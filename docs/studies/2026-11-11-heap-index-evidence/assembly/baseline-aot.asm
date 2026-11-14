
D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results/cache/barnes_hut/baseline/recompyler/rcaotr_2c76336ff39711e0671e54df.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x18000d340 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0xe3f9(%rip), %rax      # 0x18000f480
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
18000109c:     	subq	$0x1c8, %rsp            # imm = 0x1C8
1800010a3:     	movapd	%xmm8, 0x1b0(%rsp)
1800010ad:     	movaps	%xmm7, 0x1a0(%rsp)
1800010b5:     	movapd	%xmm6, 0x190(%rsp)
1800010be:     	movq	0x318(%rsp), %rax
1800010c6:     	movq	0x2e8(%rsp), %r15
1800010ce:     	movq	0x2b0(%rsp), %r14
1800010d6:     	movabsq	$-0x20000000000001, %r11 # imm = 0xFFDFFFFFFFFFFFFF
1800010e0:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
1800010ea:     	movq	$0x0, 0x170(%rsp)
1800010f6:     	movb	$0x0, 0x178(%rsp)
1800010fe:     	movq	$0x0, 0x180(%rsp)
18000110a:     	movb	$0x0, 0x188(%rsp)
180001112:     	movq	$0x0, 0x168(%rsp)
18000111e:     	movb	$0x0, 0x11f(%rsp)
180001126:     	movq	$0x0, 0x160(%rsp)
180001132:     	leaq	(%rax,%r11), %r10
180001136:     	cmpq	%rsi, %r10
180001139:     	jb	0x18000114b <.text+0x14b>
18000113b:     	movq	0x320(%rsp), %r10
180001143:     	addq	%r10, %r11
180001146:     	cmpq	%rsi, %r11
180001149:     	jae	0x18000118d <.text+0x18d>
18000114b:     	movb	$0x1, (%r15)
18000114f:     	movq	$0x4, 0x18(%r14)
180001157:     	xorl	%eax, %eax
180001159:     	movq	$0x0, (%rcx)
180001160:     	movaps	0x190(%rsp), %xmm6
180001168:     	movaps	0x1a0(%rsp), %xmm7
180001170:     	movaps	0x1b0(%rsp), %xmm8
180001179:     	addq	$0x1c8, %rsp            # imm = 0x1C8
180001180:     	popq	%rbx
180001181:     	popq	%rbp
180001182:     	popq	%rdi
180001183:     	popq	%rsi
180001184:     	popq	%r12
180001186:     	popq	%r13
180001188:     	popq	%r14
18000118a:     	popq	%r15
18000118c:     	retq
18000118d:     	movq	0x280(%rsp), %r12
180001195:     	movq	(%r14), %r11
180001198:     	leaq	0x4(%r11), %rsi
18000119c:     	cmpq	%r12, %rsi
18000119f:     	jle	0x1800011a7 <.text+0x1a7>
1800011a1:     	movb	$0x2, (%r15)
1800011a5:     	jmp	0x180001157 <.text+0x157>
1800011a7:     	movq	%rsi, (%r14)
1800011aa:     	cmpb	$0x0, (%r15)
1800011ae:     	jne	0x180001157 <.text+0x157>
1800011b0:     	movq	0x248(%rsp), %r13
1800011b8:     	movq	0x240(%rsp), %rbp
1800011c0:     	cvtsi2sd	%rax, %xmm0
1800011c5:     	movsd	0xe1e3(%rip), %xmm1     # 0x18000f3b0
1800011cd:     	mulsd	%xmm1, %xmm0
1800011d1:     	cvtsi2sd	%r10, %xmm2
1800011d6:     	mulsd	%xmm1, %xmm2
1800011da:     	xorl	%eax, %eax
1800011dc:     	cmpq	$-0x2, %r11
1800011e0:     	movl	$0x0, %r10d
1800011e6:     	cmovlq	%r13, %r10
1800011ea:     	leaq	(%rbp,%r11,8), %rsi
1800011ef:     	movsd	%xmm0, 0x10(%rsi,%r10,8)
1800011f6:     	cmpq	$-0x3, %r11
1800011fa:     	movl	$0x0, %r10d
180001200:     	cmovlq	%r13, %r10
180001204:     	movsd	%xmm2, 0x18(%rsi,%r10,8)
18000120b:     	cmpq	$-0x1, %r11
18000120f:     	movl	$0x0, %r10d
180001215:     	cmovlq	%r13, %r10
180001219:     	movsd	%xmm0, 0x8(%rsi,%r10,8)
180001220:     	movq	%r11, %r10
180001223:     	sarq	$0x3f, %r10
180001227:     	andq	%r13, %r10
18000122a:     	movsd	%xmm2, (%rsi,%r10,8)
180001230:     	cmpb	$0x0, (%r15)
180001234:     	jne	0x180001159 <.text+0x159>
18000123a:     	movq	(%r14), %rsi
18000123d:     	leaq	0xb(%rsi), %r10
180001241:     	cmpq	%r12, %r10
180001244:     	jle	0x18000124f <.text+0x24f>
180001246:     	movb	$0x2, (%r15)
18000124a:     	jmp	0x180001159 <.text+0x159>
18000124f:     	movq	%r10, (%r14)
180001252:     	cmpb	$0x0, (%r15)
180001256:     	jne	0x180001159 <.text+0x159>
18000125c:     	movq	0x278(%rsp), %rbx
180001264:     	movq	%rsi, %rax
180001267:     	sarq	$0x3f, %rax
18000126b:     	andq	%r12, %rax
18000126e:     	leaq	(%rbx,%rsi,8), %r10
180001272:     	movq	%r11, (%r10,%rax,8)
180001276:     	xorl	%eax, %eax
180001278:     	cmpq	$-0x1, %rsi
18000127c:     	cmovlq	%r12, %rax
180001280:     	movq	$0x4, 0x8(%r10,%rax,8)
180001289:     	movq	(%r14), %r11
18000128c:     	cmpq	%r12, %r11
18000128f:     	movq	%r11, %rdi
180001292:     	jle	0x18000129d <.text+0x29d>
180001294:     	movb	$0x2, (%r15)
180001298:     	movq	(%r14), %r11
18000129b:     	xorl	%edi, %edi
18000129d:     	leaq	0x3(%r11), %rax
1800012a1:     	cmpq	%r12, %rax
1800012a4:     	jg	0x1800011a1 <.text+0x1a1>
1800012aa:     	movq	%rax, (%r14)
1800012ad:     	cmpb	$0x0, (%r15)
1800012b1:     	jne	0x180001157 <.text+0x157>
1800012b7:     	movq	%r10, 0x128(%rsp)
1800012bf:     	movq	%r11, %rax
1800012c2:     	sarq	$0x3f, %rax
1800012c6:     	andq	%r12, %rax
1800012c9:     	leaq	(%rbx,%r11,8), %r10
1800012cd:     	movq	$0x0, (%r10,%rax,8)
1800012d5:     	xorl	%eax, %eax
1800012d7:     	cmpq	$-0x1, %r11
1800012db:     	movl	$0x0, %ebx
1800012e0:     	cmovlq	%r12, %rbx
1800012e4:     	movq	$0x0, 0x8(%r10,%rbx,8)
1800012ed:     	cmpq	$-0x2, %r11
1800012f1:     	movl	$0x0, %ebx
1800012f6:     	cmovlq	%r12, %rbx
1800012fa:     	movq	%rdi, 0x10(%r10,%rbx,8)
1800012ff:     	cmpb	$0x0, (%r15)
180001303:     	jne	0x180001159 <.text+0x159>
180001309:     	xorl	%eax, %eax
18000130b:     	cmpq	$-0x6, %rsi
18000130f:     	movl	$0x0, %edi
180001314:     	cmovlq	%r12, %rdi
180001318:     	movq	0x128(%rsp), %r10
180001320:     	movq	%r11, 0x30(%r10,%rdi,8)
180001325:     	cmpq	$-0x3, %rsi
180001329:     	movl	$0x0, %r11d
18000132f:     	cmovlq	%r12, %r11
180001333:     	movq	$0x0, 0x18(%r10,%r11,8)
18000133c:     	movq	(%r14), %r11
18000133f:     	leaq	0x4(%r11), %rdi
180001343:     	cmpq	%r12, %rdi
180001346:     	movq	0x278(%rsp), %rbx
18000134e:     	jg	0x1800011a1 <.text+0x1a1>
180001354:     	movq	%r8, 0x150(%rsp)
18000135c:     	movq	%r9, 0x158(%rsp)
180001364:     	movq	%rdx, 0x148(%rsp)
18000136c:     	movq	%rdi, (%r14)
18000136f:     	cmpb	$0x0, (%r15)
180001373:     	jne	0x180001159 <.text+0x159>
180001379:     	movq	%rcx, 0x120(%rsp)
180001381:     	movq	%r11, %rax
180001384:     	sarq	$0x3f, %rax
180001388:     	andq	%r13, %rax
18000138b:     	leaq	(%rbp,%r11,8), %rcx
180001390:     	movq	$0x0, (%rcx,%rax,8)
180001398:     	xorl	%eax, %eax
18000139a:     	cmpq	$-0x1, %r11
18000139e:     	movl	$0x0, %edx
1800013a3:     	cmovlq	%r12, %rdx
1800013a7:     	leaq	(%rbx,%r11,8), %r8
1800013ab:     	movq	$0x1, 0x8(%r8,%rdx,8)
1800013b4:     	cmpq	$-0x2, %r11
1800013b8:     	movl	$0x0, %edx
1800013bd:     	cmovlq	%r13, %rdx
1800013c1:     	movq	$0x0, 0x10(%rcx,%rdx,8)
1800013ca:     	cmpq	$-0x3, %r11
1800013ce:     	movl	$0x0, %ecx
1800013d3:     	cmovlq	%r12, %rcx
1800013d7:     	movq	$0x1, 0x18(%r8,%rcx,8)
1800013e0:     	cmpb	$0x0, (%r15)
1800013e4:     	jne	0x180001d08 <.text+0xd08>
1800013ea:     	xorl	%eax, %eax
1800013ec:     	cmpq	$-0x2, %rsi
1800013f0:     	movl	$0x0, %ecx
1800013f5:     	cmovlq	%r12, %rcx
1800013f9:     	movq	0x128(%rsp), %r8
180001401:     	movq	%r11, 0x10(%r8,%rcx,8)
180001406:     	cmpq	$-0x9, %rsi
18000140a:     	movl	$0x0, %ecx
18000140f:     	cmovlq	%r13, %rcx
180001413:     	leaq	(%rbp,%rsi,8), %rdx
180001418:     	movq	$0x0, 0x48(%rdx,%rcx,8)
180001421:     	cmpq	$-0xa, %rsi
180001425:     	movl	$0x0, %ecx
18000142a:     	cmovlq	%r12, %rcx
18000142e:     	movq	$0x1, 0x50(%r8,%rcx,8)
180001437:     	cmpq	$-0x4, %rsi
18000143b:     	movl	$0x0, %ecx
180001440:     	cmovlq	%r12, %rcx
180001444:     	movq	$-0x1, 0x20(%r8,%rcx,8)
18000144d:     	cmpq	$-0x5, %rsi
180001451:     	movl	$0x0, %ecx
180001456:     	cmovlq	%r12, %rcx
18000145a:     	movq	$-0x1, 0x28(%r8,%rcx,8)
180001463:     	cmpq	$-0x7, %rsi
180001467:     	movl	$0x0, %ecx
18000146c:     	cmovlq	%r12, %rcx
180001470:     	movq	$-0x1, 0x38(%r8,%rcx,8)
180001479:     	cmpq	$-0x8, %rsi
18000147d:     	movl	$0x0, %ecx
180001482:     	cmovlq	%r12, %rcx
180001486:     	movq	$-0x1, 0x40(%r8,%rcx,8)
18000148f:     	cmpb	$0x0, (%r15)
180001493:     	jne	0x180001d08 <.text+0xd08>
180001499:     	movq	0x300(%rsp), %rdx
1800014a1:     	movq	%rdx, %rcx
1800014a4:     	sarq	$0x3f, %rcx
1800014a8:     	andq	%r12, %rcx
1800014ab:     	movq	0x278(%rsp), %rax
1800014b3:     	leaq	(%rax,%rdx,8), %rax
1800014b7:     	movq	%rcx, 0x138(%rsp)
1800014bf:     	movq	%rax, 0x128(%rsp)
1800014c7:     	cmpq	$0x0, (%rax,%rcx,8)
1800014cc:     	jle	0x1800016fe <.text+0x6fe>
1800014d2:     	xorl	%edi, %edi
1800014d4:     	cmpq	$-0x2, 0x300(%rsp)
1800014dd:     	movl	$0x0, %ebx
1800014e2:     	cmovlq	%r12, %rbx
1800014e6:     	movq	0x8(%r14), %rax
1800014ea:     	movq	0x128(%rsp), %rcx
1800014f2:     	movq	0x10(%rcx,%rbx,8), %rcx
1800014f7:     	addq	%rdi, %rcx
1800014fa:     	movq	0x278(%rsp), %rdx
180001502:     	leaq	(%rdx,%rcx,8), %rdx
180001506:     	sarq	$0x3f, %rcx
18000150a:     	andq	%r12, %rcx
18000150d:     	movq	(%rdx,%rcx,8), %rcx
180001511:     	leaq	0x1(%rax), %rdx
180001515:     	movq	%rdx, 0x8(%r14)
180001519:     	cmpq	0x10(%r14), %rax
18000151d:     	jge	0x180001a74 <.text+0xa74>
180001523:     	movq	%rcx, 0x100(%rsp)
18000152b:     	movq	%rsi, 0xf8(%rsp)
180001533:     	movq	0x2f8(%rsp), %rax
18000153b:     	movq	%rax, 0xe8(%rsp)
180001543:     	movq	0x2f0(%rsp), %rax
18000154b:     	movq	%rax, 0xe0(%rsp)
180001553:     	movq	%r15, 0xd8(%rsp)
18000155b:     	movq	0x2e0(%rsp), %rax
180001563:     	movq	%rax, 0xd0(%rsp)
18000156b:     	movq	0x2d8(%rsp), %rax
180001573:     	movq	%rax, 0xc8(%rsp)
18000157b:     	movq	0x2d0(%rsp), %rax
180001583:     	movq	%rax, 0xc0(%rsp)
18000158b:     	movq	0x2c8(%rsp), %rax
180001593:     	movq	%rax, 0xb8(%rsp)
18000159b:     	movq	0x2c0(%rsp), %rax
1800015a3:     	movq	%rax, 0xb0(%rsp)
1800015ab:     	movq	0x2b8(%rsp), %rax
1800015b3:     	movq	%rax, 0xa8(%rsp)
1800015bb:     	movq	%r14, 0xa0(%rsp)
1800015c3:     	movq	0x2a8(%rsp), %rax
1800015cb:     	movq	%rax, 0x98(%rsp)
1800015d3:     	movq	0x2a0(%rsp), %rax
1800015db:     	movq	%rax, 0x90(%rsp)
1800015e3:     	movq	0x298(%rsp), %rax
1800015eb:     	movq	%rax, 0x88(%rsp)
1800015f3:     	movq	0x290(%rsp), %rax
1800015fb:     	movq	%rax, 0x80(%rsp)
180001603:     	movq	0x288(%rsp), %rax
18000160b:     	movq	%rax, 0x78(%rsp)
180001610:     	movq	%r12, 0x70(%rsp)
180001615:     	movq	0x278(%rsp), %rax
18000161d:     	movq	%rax, 0x68(%rsp)
180001622:     	movq	0x270(%rsp), %rax
18000162a:     	movq	%rax, 0x60(%rsp)
18000162f:     	movq	0x268(%rsp), %rax
180001637:     	movq	%rax, 0x58(%rsp)
18000163c:     	movq	0x260(%rsp), %rax
180001644:     	movq	%rax, 0x50(%rsp)
180001649:     	movq	0x258(%rsp), %rax
180001651:     	movq	%rax, 0x48(%rsp)
180001656:     	movq	0x250(%rsp), %rax
18000165e:     	movq	%rax, 0x40(%rsp)
180001663:     	movq	%r13, 0x38(%rsp)
180001668:     	movq	%rbp, 0x30(%rsp)
18000166d:     	movq	0x238(%rsp), %rax
180001675:     	movq	%rax, 0x28(%rsp)
18000167a:     	movq	0x230(%rsp), %rax
180001682:     	movq	%rax, 0x20(%rsp)
180001687:     	movq	$-0x1, 0x108(%rsp)
180001693:     	movq	$0x0, 0xf0(%rsp)
18000169f:     	leaq	0x11f(%rsp), %rcx
1800016a7:     	leaq	0x160(%rsp), %rdx
1800016af:     	movq	0x150(%rsp), %r8
1800016b7:     	movq	0x158(%rsp), %r9
1800016bf:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
1800016c4:     	testl	%eax, %eax
1800016c6:     	jne	0x180001a67 <.text+0xa67>
1800016cc:     	cmpb	$0x0, (%r15)
1800016d0:     	jne	0x180001d06 <.text+0xd06>
1800016d6:     	incq	%rdi
1800016d9:     	movq	0x8(%r14), %rax
1800016dd:     	decq	%rax
1800016e0:     	movq	%rax, 0x8(%r14)
1800016e4:     	movq	0x138(%rsp), %rcx
1800016ec:     	movq	0x128(%rsp), %rdx
1800016f4:     	cmpq	(%rdx,%rcx,8), %rdi
1800016f8:     	jl	0x1800014ea <.text+0x4ea>
1800016fe:     	movsd	0x310(%rsp), %xmm6
180001707:     	movsd	0x308(%rsp), %xmm7
180001710:     	movq	$0x0, 0x130(%rsp)
18000171c:     	cmpq	$-0x2, 0x300(%rsp)
180001725:     	movl	$0x0, %eax
18000172a:     	cmovlq	%r12, %rax
18000172e:     	movq	%rax, 0x140(%rsp)
180001736:     	xorpd	%xmm8, %xmm8
18000173b:     	jmp	0x18000175b <.text+0x75b>
18000173d:     	movb	$0x1, (%r15)
180001741:     	movq	$0x4c4b43, 0x18(%r14)   # imm = 0x4C4B43
180001749:     	incq	0x130(%rsp)
180001751:     	cmpb	$0x0, (%r15)
180001755:     	jne	0x180001d08 <.text+0xd08>
18000175b:     	movq	0x138(%rsp), %rax
180001763:     	movq	0x128(%rsp), %rcx
18000176b:     	movq	0x130(%rsp), %rdx
180001773:     	cmpq	(%rcx,%rax,8), %rdx
180001777:     	jge	0x180001a85 <.text+0xa85>
18000177d:     	movq	0x128(%rsp), %rax
180001785:     	movq	0x140(%rsp), %rcx
18000178d:     	movq	0x10(%rax,%rcx,8), %rax
180001792:     	addq	0x130(%rsp), %rax
18000179a:     	movq	0x278(%rsp), %rcx
1800017a2:     	leaq	(%rcx,%rax,8), %rcx
1800017a6:     	sarq	$0x3f, %rax
1800017aa:     	andq	%r12, %rax
1800017ad:     	movq	(%rcx,%rax,8), %rdi
1800017b1:     	movq	0x8(%r14), %rax
1800017b5:     	leaq	0x1(%rax), %rcx
1800017b9:     	movq	%rcx, 0x8(%r14)
1800017bd:     	cmpq	0x10(%r14), %rax
1800017c1:     	jge	0x180001cfa <.text+0xcfa>
1800017c7:     	movsd	%xmm7, 0x100(%rsp)
1800017d0:     	movq	%rdi, 0xf8(%rsp)
1800017d8:     	movq	%rsi, 0xf0(%rsp)
1800017e0:     	movq	0x2f8(%rsp), %rax
1800017e8:     	movq	%rax, 0xe8(%rsp)
1800017f0:     	movq	0x2f0(%rsp), %rax
1800017f8:     	movq	%rax, 0xe0(%rsp)
180001800:     	movq	%r15, 0xd8(%rsp)
180001808:     	movq	0x2e0(%rsp), %rax
180001810:     	movq	%rax, 0xd0(%rsp)
180001818:     	movq	0x2d8(%rsp), %rax
180001820:     	movq	%rax, 0xc8(%rsp)
180001828:     	movq	0x2d0(%rsp), %rax
180001830:     	movq	%rax, 0xc0(%rsp)
180001838:     	movq	0x2c8(%rsp), %rax
180001840:     	movq	%rax, 0xb8(%rsp)
180001848:     	movq	0x2c0(%rsp), %rax
180001850:     	movq	%rax, 0xb0(%rsp)
180001858:     	movq	0x2b8(%rsp), %rax
180001860:     	movq	%rax, 0xa8(%rsp)
180001868:     	movq	%r14, 0xa0(%rsp)
180001870:     	movq	0x2a8(%rsp), %rax
180001878:     	movq	%rax, 0x98(%rsp)
180001880:     	movq	0x2a0(%rsp), %rax
180001888:     	movq	%rax, 0x90(%rsp)
180001890:     	movq	0x298(%rsp), %rax
180001898:     	movq	%rax, 0x88(%rsp)
1800018a0:     	movq	0x290(%rsp), %rax
1800018a8:     	movq	%rax, 0x80(%rsp)
1800018b0:     	movq	0x288(%rsp), %rax
1800018b8:     	movq	%rax, 0x78(%rsp)
1800018bd:     	movq	%r12, 0x70(%rsp)
1800018c2:     	movq	0x278(%rsp), %rax
1800018ca:     	movq	%rax, 0x68(%rsp)
1800018cf:     	movq	0x270(%rsp), %rax
1800018d7:     	movq	%rax, 0x60(%rsp)
1800018dc:     	movq	0x268(%rsp), %rax
1800018e4:     	movq	%rax, 0x58(%rsp)
1800018e9:     	movq	0x260(%rsp), %rax
1800018f1:     	movq	%rax, 0x50(%rsp)
1800018f6:     	movq	0x258(%rsp), %rax
1800018fe:     	movq	%rax, 0x48(%rsp)
180001903:     	movq	0x250(%rsp), %rax
18000190b:     	movq	%rax, 0x40(%rsp)
180001910:     	movq	%r13, 0x38(%rsp)
180001915:     	movq	%rbp, 0x30(%rsp)
18000191a:     	movq	0x238(%rsp), %rax
180001922:     	movq	%rax, 0x28(%rsp)
180001927:     	movq	0x230(%rsp), %rax
18000192f:     	movq	%rax, 0x20(%rsp)
180001934:     	leaq	0x170(%rsp), %rcx
18000193c:     	leaq	0x168(%rsp), %rdx
180001944:     	movq	0x150(%rsp), %r8
18000194c:     	movq	0x158(%rsp), %r9
180001954:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
180001959:     	testl	%eax, %eax
18000195b:     	jne	0x180001a67 <.text+0xa67>
180001961:     	xorl	%eax, %eax
180001963:     	cmpb	$0x0, (%r15)
180001967:     	jne	0x180001d08 <.text+0xd08>
18000196d:     	movsd	0x170(%rsp), %xmm1
180001976:     	movsd	0x180(%rsp), %xmm0
18000197f:     	decq	0x8(%r14)
180001983:     	cmpq	$-0x1, %rdi
180001987:     	movl	$0x0, %ecx
18000198c:     	cmovlq	%r13, %rcx
180001990:     	leaq	(%rbp,%rdi,8), %rdx
180001995:     	movsd	0x8(%rdx,%rcx,8), %xmm2
18000199b:     	ucomisd	%xmm8, %xmm2
1800019a0:     	jne	0x1800019a8 <.text+0x9a8>
1800019a2:     	jnp	0x18000173d <.text+0x73d>
1800019a8:     	leaq	0x8(%rbp,%rdi,8), %r8
1800019ad:     	movq	0x278(%rsp), %r11
1800019b5:     	leaq	(%r11,%rdi,8), %rdx
1800019b9:     	sarq	$0x3f, %rdi
1800019bd:     	andq	%r12, %rdi
1800019c0:     	movq	(%rdx,%rdi,8), %r9
1800019c4:     	cmpq	$-0x1, %r9
1800019c8:     	movl	$0x0, %r10d
1800019ce:     	cmovlq	%r12, %r10
1800019d2:     	leaq	(%r11,%r9,8), %r11
1800019d6:     	leaq	(%rbp,%r9,8), %rbx
1800019db:     	sarq	$0x3f, %r9
1800019df:     	andq	%r13, %r9
1800019e2:     	divsd	%xmm2, %xmm1
1800019e6:     	addsd	(%rbx,%r9,8), %xmm1
1800019ec:     	movsd	%xmm1, (%rbx,%r9,8)
1800019f2:     	movq	$0x0, 0x8(%r11,%r10,8)
1800019fb:     	movsd	(%r8,%rcx,8), %xmm1
180001a01:     	ucomisd	%xmm8, %xmm1
180001a06:     	jne	0x180001a1b <.text+0xa1b>
180001a08:     	jp	0x180001a1b <.text+0xa1b>
180001a0a:     	movb	$0x1, (%r15)
180001a0e:     	movq	$0x4c4b44, 0x18(%r14)   # imm = 0x4C4B44
180001a16:     	jmp	0x180001749 <.text+0x749>
180001a1b:     	movq	(%rdx,%rdi,8), %rcx
180001a1f:     	cmpq	$-0x3, %rcx
180001a23:     	movl	$0x0, %edx
180001a28:     	cmovlq	%r12, %rdx
180001a2c:     	movq	0x278(%rsp), %r8
180001a34:     	leaq	(%r8,%rcx,8), %r8
180001a38:     	leaq	(%rbp,%rcx,8), %rcx
180001a3d:     	movl	$0x0, %r9d
180001a43:     	cmovleq	%r13, %r9
180001a47:     	divsd	%xmm1, %xmm0
180001a4b:     	addsd	0x10(%rcx,%r9,8), %xmm0
180001a52:     	movsd	%xmm0, 0x10(%rcx,%r9,8)
180001a59:     	movq	$0x0, 0x18(%r8,%rdx,8)
180001a62:     	jmp	0x180001749 <.text+0x749>
180001a67:     	movq	0x148(%rsp), %rcx
180001a6f:     	jmp	0x180001159 <.text+0x159>
180001a74:     	movb	$0x1, (%r15)
180001a78:     	movq	$0x9, 0x18(%r14)
180001a80:     	jmp	0x180001d06 <.text+0xd06>
180001a85:     	xorl	%eax, %eax
180001a87:     	xorl	%ecx, %ecx
180001a89:     	movq	0x138(%rsp), %rdx
180001a91:     	movq	0x128(%rsp), %r8
180001a99:     	cmpq	(%r8,%rdx,8), %rcx
180001a9d:     	jge	0x180001d08 <.text+0xd08>
180001aa3:     	movq	0x128(%rsp), %rdx
180001aab:     	movq	0x140(%rsp), %r8
180001ab3:     	movq	0x10(%rdx,%r8,8), %rdx
180001ab8:     	addq	%rcx, %rdx
180001abb:     	movq	0x278(%rsp), %r11
180001ac3:     	leaq	(%r11,%rdx,8), %r8
180001ac7:     	sarq	$0x3f, %rdx
180001acb:     	andq	%r12, %rdx
180001ace:     	movq	(%r8,%rdx,8), %r10
180001ad2:     	incq	%rcx
180001ad5:     	cmpq	$-0x3, %r10
180001ad9:     	movl	$0x0, %r9d
180001adf:     	cmovlq	%r12, %r9
180001ae3:     	leaq	(%r11,%r10,8), %rdx
180001ae7:     	movq	0x18(%rdx,%r9,8), %r11
180001aec:     	movq	%r11, %rsi
180001aef:     	sarq	$0x3f, %rsi
180001af3:     	andq	%r13, %rsi
180001af6:     	cmpq	$-0x1, %r11
180001afa:     	movl	$0x0, %edi
180001aff:     	cmovlq	%r12, %rdi
180001b03:     	movq	%r10, %r8
180001b06:     	sarq	$0x3f, %r8
180001b0a:     	andq	%r12, %r8
180001b0d:     	movq	(%rdx,%r8,8), %rbx
180001b11:     	leaq	(%rbp,%rbx,8), %r14
180001b16:     	sarq	$0x3f, %rbx
180001b1a:     	andq	%r13, %rbx
180001b1d:     	movsd	(%r14,%rbx,8), %xmm0
180001b23:     	leaq	(%rbp,%r11,8), %rbx
180001b28:     	movq	0x278(%rsp), %r14
180001b30:     	leaq	(%r14,%r11,8), %r11
180001b34:     	mulsd	%xmm6, %xmm0
180001b38:     	addsd	(%rbx,%rsi,8), %xmm0
180001b3d:     	movsd	%xmm0, (%rbx,%rsi,8)
180001b42:     	movq	$0x0, 0x8(%r11,%rdi,8)
180001b4b:     	movq	0x18(%rdx,%r9,8), %r11
180001b50:     	cmpq	$-0x2, %r11
180001b54:     	movl	$0x0, %esi
180001b59:     	cmovlq	%r13, %rsi
180001b5d:     	cmpq	$-0x3, %r11
180001b61:     	movl	$0x0, %edi
180001b66:     	cmovlq	%r12, %rdi
180001b6a:     	movq	(%rdx,%r8,8), %rbx
180001b6e:     	cmpq	$-0x2, %rbx
180001b72:     	movl	$0x0, %r14d
180001b78:     	cmovlq	%r13, %r14
180001b7c:     	leaq	(%rbp,%rbx,8), %rbx
180001b81:     	movsd	0x10(%rbx,%r14,8), %xmm0
180001b88:     	leaq	(%rbp,%r11,8), %rbx
180001b8d:     	movq	0x278(%rsp), %r14
180001b95:     	leaq	(%r14,%r11,8), %r11
180001b99:     	mulsd	%xmm6, %xmm0
180001b9d:     	addsd	0x10(%rbx,%rsi,8), %xmm0
180001ba3:     	movsd	%xmm0, 0x10(%rbx,%rsi,8)
180001ba9:     	movq	$0x0, 0x18(%r11,%rdi,8)
180001bb2:     	cmpq	$-0x2, %r10
180001bb6:     	movl	$0x0, %r10d
180001bbc:     	cmovlq	%r12, %r10
180001bc0:     	movq	0x10(%rdx,%r10,8), %r11
180001bc5:     	movq	%r11, %rsi
180001bc8:     	sarq	$0x3f, %rsi
180001bcc:     	andq	%r13, %rsi
180001bcf:     	cmpq	$-0x1, %r11
180001bd3:     	movl	$0x0, %edi
180001bd8:     	cmovlq	%r12, %rdi
180001bdc:     	movq	0x18(%rdx,%r9,8), %rbx
180001be1:     	leaq	(%rbp,%rbx,8), %r14
180001be6:     	sarq	$0x3f, %rbx
180001bea:     	andq	%r13, %rbx
180001bed:     	movsd	(%r14,%rbx,8), %xmm0
180001bf3:     	leaq	(%rbp,%r11,8), %rbx
180001bf8:     	mulsd	%xmm6, %xmm0
180001bfc:     	addsd	(%rbx,%rsi,8), %xmm0
180001c01:     	movsd	%xmm0, (%rbx,%rsi,8)
180001c06:     	movq	0x278(%rsp), %rbx
180001c0e:     	leaq	(%rbx,%r11,8), %r11
180001c12:     	movq	$0x0, 0x8(%r11,%rdi,8)
180001c1b:     	movq	0x10(%rdx,%r10,8), %r10
180001c20:     	cmpq	$-0x2, %r10
180001c24:     	movl	$0x0, %r11d
180001c2a:     	cmovlq	%r13, %r11
180001c2e:     	cmpq	$-0x3, %r10
180001c32:     	movl	$0x0, %esi
180001c37:     	cmovlq	%r12, %rsi
180001c3b:     	movq	0x18(%rdx,%r9,8), %r9
180001c40:     	cmpq	$-0x2, %r9
180001c44:     	movl	$0x0, %edi
180001c49:     	cmovlq	%r13, %rdi
180001c4d:     	leaq	(%rbp,%r9,8), %r9
180001c52:     	movsd	0x10(%r9,%rdi,8), %xmm0
180001c59:     	leaq	(%rbp,%r10,8), %r9
180001c5e:     	mulsd	%xmm6, %xmm0
180001c62:     	addsd	0x10(%r9,%r11,8), %xmm0
180001c69:     	movsd	%xmm0, 0x10(%r9,%r11,8)
180001c70:     	leaq	(%rbx,%r10,8), %r9
180001c74:     	movq	$0x0, 0x18(%r9,%rsi,8)
180001c7d:     	movq	(%rdx,%r8,8), %r9
180001c81:     	movq	%r9, %r10
180001c84:     	sarq	$0x3f, %r10
180001c88:     	andq	%r13, %r10
180001c8b:     	leaq	(%rbp,%r9,8), %r11
180001c90:     	movq	$0x0, (%r11,%r10,8)
180001c98:     	cmpq	$-0x1, %r9
180001c9c:     	movl	$0x0, %r10d
180001ca2:     	cmovlq	%r12, %r10
180001ca6:     	leaq	(%rbx,%r9,8), %r9
180001caa:     	movq	$0x1, 0x8(%r9,%r10,8)
180001cb3:     	movq	(%rdx,%r8,8), %rdx
180001cb7:     	cmpq	$-0x2, %rdx
180001cbb:     	movl	$0x0, %r8d
180001cc1:     	cmovlq	%r13, %r8
180001cc5:     	leaq	(%rbp,%rdx,8), %r9
180001cca:     	movq	$0x0, 0x10(%r9,%r8,8)
180001cd3:     	cmpq	$-0x3, %rdx
180001cd7:     	movl	$0x0, %r8d
180001cdd:     	cmovlq	%r12, %r8
180001ce1:     	leaq	(%rbx,%rdx,8), %rdx
180001ce5:     	movq	$0x1, 0x18(%rdx,%r8,8)
180001cee:     	cmpb	$0x0, (%r15)
180001cf2:     	je	0x180001a89 <.text+0xa89>
180001cf8:     	jmp	0x180001d06 <.text+0xd06>
180001cfa:     	movb	$0x1, (%r15)
180001cfe:     	movq	$0xd, 0x18(%r14)
180001d06:     	xorl	%eax, %eax
180001d08:     	movq	0x120(%rsp), %rcx
180001d10:     	jmp	0x180001159 <.text+0x159>
180001d15:     	nopw	%cs:(%rax,%rax)
180001d1f:     	nop
180001d20:     	pushq	%r15
180001d22:     	pushq	%r14
180001d24:     	pushq	%r13
180001d26:     	pushq	%r12
180001d28:     	pushq	%rsi
180001d29:     	pushq	%rdi
180001d2a:     	pushq	%rbp
180001d2b:     	pushq	%rbx
180001d2c:     	subq	$0x338, %rsp            # imm = 0x338
180001d33:     	movaps	%xmm7, 0x320(%rsp)
180001d3b:     	movaps	%xmm6, 0x310(%rsp)
180001d43:     	movq	%rdx, %rcx
180001d46:     	leaq	0x1c8(%rsp), %rax
180001d4e:     	movq	%rax, 0x60(%rsp)
180001d53:     	leaq	0x1d0(%rsp), %rax
180001d5b:     	movq	%rax, 0x58(%rsp)
180001d60:     	leaq	0x1d8(%rsp), %rax
180001d68:     	movq	%rax, 0x50(%rsp)
180001d6d:     	leaq	0x1e0(%rsp), %rax
180001d75:     	movq	%rax, 0x48(%rsp)
180001d7a:     	leaq	0x1e8(%rsp), %rax
180001d82:     	movq	%rax, 0x40(%rsp)
180001d87:     	leaq	0x1f0(%rsp), %rax
180001d8f:     	movq	%rax, 0x38(%rsp)
180001d94:     	leaq	0x1f8(%rsp), %rax
180001d9c:     	movq	%rax, 0x30(%rsp)
180001da1:     	leaq	0x200(%rsp), %rax
180001da9:     	movq	%rax, 0x28(%rsp)
180001dae:     	leaq	0x208(%rsp), %rax
180001db6:     	movq	%rax, 0x20(%rsp)
180001dbb:     	leaq	0xd6ee(%rip), %rdx      # 0x18000f4b0
180001dc2:     	movl	$0x9, %r8d
180001dc8:     	movl	$0x9, %r9d
180001dce:     	callq	0x18000d4f1 <numba_list_iter_next+0x311>
180001dd3:     	testl	%eax, %eax
180001dd5:     	movq	$0x0, 0x130(%rsp)
180001de1:     	je	0x1800024dc <.text+0x14dc>
180001de7:     	cmpq	$0x0, 0x14ee1(%rip)     # 0x180016cd0
180001def:     	je	0x180002404 <.text+0x1404>
180001df5:     	movq	0x208(%rsp), %rcx
180001dfd:     	xorps	%xmm0, %xmm0
180001e00:     	movaps	%xmm0, 0x2d0(%rsp)
180001e08:     	movaps	%xmm0, 0x2e0(%rsp)
180001e10:     	movaps	%xmm0, 0x2f0(%rsp)
180001e18:     	movq	$0x0, 0x300(%rsp)
180001e24:     	leaq	0x2d0(%rsp), %rdx
180001e2c:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
180001e31:     	testl	%eax, %eax
180001e33:     	jne	0x18000241c <.text+0x141c>
180001e39:     	cmpq	$0x8, 0x2e8(%rsp)
180001e42:     	jne	0x18000241c <.text+0x141c>
180001e48:     	movq	0x2d0(%rsp), %rbx
180001e50:     	movq	0x2d8(%rsp), %rbp
180001e58:     	movq	0x2e0(%rsp), %rsi
180001e60:     	movq	0x2f0(%rsp), %rdi
180001e68:     	movq	0x2f8(%rsp), %r15
180001e70:     	movq	0x300(%rsp), %r13
180001e78:     	movq	0x200(%rsp), %rcx
180001e80:     	xorps	%xmm0, %xmm0
180001e83:     	movaps	%xmm0, 0x290(%rsp)
180001e8b:     	movaps	%xmm0, 0x2a0(%rsp)
180001e93:     	movaps	%xmm0, 0x2b0(%rsp)
180001e9b:     	movq	$0x0, 0x2c0(%rsp)
180001ea7:     	leaq	0x290(%rsp), %rdx
180001eaf:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
180001eb4:     	testl	%eax, %eax
180001eb6:     	jne	0x180002434 <.text+0x1434>
180001ebc:     	cmpq	$0x8, 0x2a8(%rsp)
180001ec5:     	jne	0x180002434 <.text+0x1434>
180001ecb:     	movq	0x290(%rsp), %r12
180001ed3:     	movq	0x298(%rsp), %r14
180001edb:     	movq	0x2a0(%rsp), %rax
180001ee3:     	movq	%rax, 0x1c0(%rsp)
180001eeb:     	movq	0x2b0(%rsp), %rax
180001ef3:     	movq	%rax, 0x1b8(%rsp)
180001efb:     	movq	0x2b8(%rsp), %rax
180001f03:     	movq	%rax, 0x1b0(%rsp)
180001f0b:     	movq	0x2c0(%rsp), %rax
180001f13:     	movq	%rax, 0x1a8(%rsp)
180001f1b:     	movq	0x1f8(%rsp), %rcx
180001f23:     	xorps	%xmm0, %xmm0
180001f26:     	movaps	%xmm0, 0x250(%rsp)
180001f2e:     	movaps	%xmm0, 0x260(%rsp)
180001f36:     	movaps	%xmm0, 0x270(%rsp)
180001f3e:     	movq	$0x0, 0x280(%rsp)
180001f4a:     	leaq	0x250(%rsp), %rdx
180001f52:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
180001f57:     	testl	%eax, %eax
180001f59:     	jne	0x18000244c <.text+0x144c>
180001f5f:     	cmpq	$0x8, 0x268(%rsp)
180001f68:     	jne	0x18000244c <.text+0x144c>
180001f6e:     	movq	%r14, 0x1a0(%rsp)
180001f76:     	movq	0x250(%rsp), %r14
180001f7e:     	movq	0x258(%rsp), %rax
180001f86:     	movq	%rax, 0x198(%rsp)
180001f8e:     	movq	0x260(%rsp), %rax
180001f96:     	movq	%rax, 0x190(%rsp)
180001f9e:     	movq	0x270(%rsp), %rax
180001fa6:     	movq	%rax, 0x188(%rsp)
180001fae:     	movq	0x278(%rsp), %rax
180001fb6:     	movq	%rax, 0x180(%rsp)
180001fbe:     	movq	0x280(%rsp), %rax
180001fc6:     	movq	%rax, 0x178(%rsp)
180001fce:     	movq	0x1f0(%rsp), %rcx
180001fd6:     	xorps	%xmm0, %xmm0
180001fd9:     	movaps	%xmm0, 0x210(%rsp)
180001fe1:     	movaps	%xmm0, 0x220(%rsp)
180001fe9:     	movaps	%xmm0, 0x230(%rsp)
180001ff1:     	movq	$0x0, 0x240(%rsp)
180001ffd:     	leaq	0x210(%rsp), %rdx
180002005:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
18000200a:     	testl	%eax, %eax
18000200c:     	jne	0x180002461 <.text+0x1461>
180002012:     	cmpq	$0x1, 0x228(%rsp)
18000201b:     	jne	0x180002461 <.text+0x1461>
180002021:     	movq	%r13, 0x150(%rsp)
180002029:     	movq	%r15, 0x158(%rsp)
180002031:     	movq	%rdi, 0x160(%rsp)
180002039:     	movq	%rsi, 0x168(%rsp)
180002041:     	movq	0x210(%rsp), %r15
180002049:     	movq	0x218(%rsp), %rax
180002051:     	movq	%rax, 0x148(%rsp)
180002059:     	movq	0x220(%rsp), %rax
180002061:     	movq	%rax, 0x140(%rsp)
180002069:     	movq	0x230(%rsp), %rax
180002071:     	movq	%rax, 0x138(%rsp)
180002079:     	movq	0x238(%rsp), %rdi
180002081:     	movq	0x240(%rsp), %rsi
180002089:     	movq	0x1e8(%rsp), %rcx
180002091:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
180002096:     	testq	%rax, %rax
180002099:     	movq	%rbx, 0x128(%rsp)
1800020a1:     	movq	%r12, 0x120(%rsp)
1800020a9:     	movq	%rbp, 0x170(%rsp)
1800020b1:     	je	0x180002476 <.text+0x1476>
1800020b7:     	movq	%rax, %r13
1800020ba:     	movq	%rax, %rcx
1800020bd:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
1800020c2:     	movq	%rax, %r12
1800020c5:     	movq	%r13, %rcx
1800020c8:     	callq	0x18000d503 <numba_list_iter_next+0x323>
1800020cd:     	callq	0x18000d509 <numba_list_iter_next+0x329>
1800020d2:     	testq	%rax, %rax
1800020d5:     	jne	0x1800024ac <.text+0x14ac>
1800020db:     	movq	0x1e0(%rsp), %rcx
1800020e3:     	callq	0x18000d50f <numba_list_iter_next+0x32f>
1800020e8:     	movq	%rax, %rbx
1800020eb:     	movq	%rax, %rcx
1800020ee:     	callq	0x18000d515 <numba_list_iter_next+0x335>
1800020f3:     	movaps	%xmm0, %xmm6
1800020f6:     	movq	%rbx, %rcx
1800020f9:     	callq	0x18000d503 <numba_list_iter_next+0x323>
1800020fe:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180002103:     	testq	%rax, %rax
180002106:     	jne	0x1800024ac <.text+0x14ac>
18000210c:     	movq	0x1d8(%rsp), %rcx
180002114:     	callq	0x18000d50f <numba_list_iter_next+0x32f>
180002119:     	movq	%rax, %rbx
18000211c:     	movq	%rax, %rcx
18000211f:     	callq	0x18000d515 <numba_list_iter_next+0x335>
180002124:     	movaps	%xmm0, %xmm7
180002127:     	movq	%rbx, %rcx
18000212a:     	callq	0x18000d503 <numba_list_iter_next+0x323>
18000212f:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180002134:     	testq	%rax, %rax
180002137:     	jne	0x1800024ac <.text+0x14ac>
18000213d:     	movq	0x1d0(%rsp), %rcx
180002145:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
18000214a:     	testq	%rax, %rax
18000214d:     	je	0x180002489 <.text+0x1489>
180002153:     	movq	%rax, %rbp
180002156:     	movq	%rax, %rcx
180002159:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
18000215e:     	movq	%rax, %r13
180002161:     	movq	%rbp, %rcx
180002164:     	callq	0x18000d503 <numba_list_iter_next+0x323>
180002169:     	callq	0x18000d509 <numba_list_iter_next+0x329>
18000216e:     	testq	%rax, %rax
180002171:     	jne	0x1800024ac <.text+0x14ac>
180002177:     	movq	0x1c8(%rsp), %rcx
18000217f:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
180002184:     	testq	%rax, %rax
180002187:     	je	0x18000249c <.text+0x149c>
18000218d:     	movq	%rax, %rbx
180002190:     	movq	%rax, %rcx
180002193:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
180002198:     	movq	%rax, %rbp
18000219b:     	movq	%rbx, %rcx
18000219e:     	callq	0x18000d503 <numba_list_iter_next+0x323>
1800021a3:     	callq	0x18000d509 <numba_list_iter_next+0x329>
1800021a8:     	testq	%rax, %rax
1800021ab:     	jne	0x1800024ac <.text+0x14ac>
1800021b1:     	movq	%rbp, 0x110(%rsp)
1800021b9:     	movq	%r13, 0x108(%rsp)
1800021c1:     	movq	%r12, 0xf0(%rsp)
1800021c9:     	movq	%rsi, 0xe8(%rsp)
1800021d1:     	movq	%rdi, 0xe0(%rsp)
1800021d9:     	movq	0x138(%rsp), %rax
1800021e1:     	movq	%rax, 0xd8(%rsp)
1800021e9:     	movq	0x140(%rsp), %rax
1800021f1:     	movq	%rax, 0xc8(%rsp)
1800021f9:     	movq	0x148(%rsp), %rax
180002201:     	movq	%rax, 0xc0(%rsp)
180002209:     	movq	0x178(%rsp), %rax
180002211:     	movq	%rax, 0xb0(%rsp)
180002219:     	movq	0x180(%rsp), %rax
180002221:     	movq	%rax, 0xa8(%rsp)
180002229:     	movq	0x188(%rsp), %rax
180002231:     	movq	%rax, 0xa0(%rsp)
180002239:     	movq	0x190(%rsp), %rax
180002241:     	movq	%rax, 0x90(%rsp)
180002249:     	movq	0x198(%rsp), %rax
180002251:     	movq	%rax, 0x88(%rsp)
180002259:     	movq	0x1a8(%rsp), %rax
180002261:     	movq	%rax, 0x78(%rsp)
180002266:     	movq	0x1b0(%rsp), %rax
18000226e:     	movq	%rax, 0x70(%rsp)
180002273:     	movq	0x1b8(%rsp), %rax
18000227b:     	movq	%rax, 0x68(%rsp)
180002280:     	movq	0x1c0(%rsp), %rax
180002288:     	movq	%rax, 0x58(%rsp)
18000228d:     	movq	0x1a0(%rsp), %rax
180002295:     	movq	%rax, 0x50(%rsp)
18000229a:     	movq	0x150(%rsp), %rax
1800022a2:     	movq	%rax, 0x40(%rsp)
1800022a7:     	movq	0x158(%rsp), %rax
1800022af:     	movq	%rax, 0x38(%rsp)
1800022b4:     	movsd	%xmm7, 0x100(%rsp)
1800022bd:     	movsd	%xmm6, 0xf8(%rsp)
1800022c6:     	movq	%r15, 0xb8(%rsp)
1800022ce:     	movq	%r14, 0x80(%rsp)
1800022d6:     	movq	0x120(%rsp), %rdi
1800022de:     	movq	%rdi, 0x48(%rsp)
1800022e3:     	movq	0x160(%rsp), %rax
1800022eb:     	movq	%rax, 0x30(%rsp)
1800022f0:     	movq	0x168(%rsp), %rax
1800022f8:     	movq	%rax, 0x20(%rsp)
1800022fd:     	movq	$0x1, 0xd0(%rsp)
180002309:     	movq	$0x8, 0x98(%rsp)
180002315:     	movq	$0x8, 0x60(%rsp)
18000231e:     	movq	$0x8, 0x28(%rsp)
180002327:     	leaq	0x308(%rsp), %rcx
18000232f:     	leaq	0x130(%rsp), %rdx
180002337:     	movq	0x170(%rsp), %r9
18000233f:     	movq	0x128(%rsp), %rsi
180002347:     	movq	%rsi, %r8
18000234a:     	callq	0x180001090 <.text+0x90>
18000234f:     	movl	%eax, %ebp
180002351:     	movq	0x130(%rsp), %rbx
180002359:     	movq	%rsi, %rcx
18000235c:     	callq	0x180001060 <.text+0x60>
180002361:     	movq	%rdi, %rcx
180002364:     	callq	0x180001060 <.text+0x60>
180002369:     	movq	%r14, %rcx
18000236c:     	callq	0x180001060 <.text+0x60>
180002371:     	movq	%r15, %rcx
180002374:     	callq	0x180001060 <.text+0x60>
180002379:     	testl	%ebp, %ebp
18000237b:     	jne	0x1800023b3 <.text+0x13b3>
18000237d:     	movq	0xcf4c(%rip), %rsi      # 0x18000f2d0
180002384:     	movq	%rsi, %rcx
180002387:     	callq	0x18000d51b <numba_list_iter_next+0x33b>
18000238c:     	movq	%rsi, %rax
18000238f:     	movaps	0x310(%rsp), %xmm6
180002397:     	movaps	0x320(%rsp), %xmm7
18000239f:     	addq	$0x338, %rsp            # imm = 0x338
1800023a6:     	popq	%rbx
1800023a7:     	popq	%rbp
1800023a8:     	popq	%rdi
1800023a9:     	popq	%rsi
1800023aa:     	popq	%r12
1800023ac:     	popq	%r13
1800023ae:     	popq	%r14
1800023b0:     	popq	%r15
1800023b2:     	retq
1800023b3:     	jle	0x1800024e3 <.text+0x14e3>
1800023b9:     	callq	0x18000d521 <numba_list_iter_next+0x341>
1800023be:     	movl	0x8(%rbx), %edx
1800023c1:     	movq	(%rbx), %rcx
1800023c4:     	cmpl	$0x0, 0x20(%rbx)
1800023c8:     	jle	0x180002502 <.text+0x1502>
1800023ce:     	movslq	%edx, %rdx
1800023d1:     	callq	0x18000d527 <numba_list_iter_next+0x347>
1800023d6:     	movq	%rax, %rsi
1800023d9:     	movq	0x10(%rbx), %rcx
1800023dd:     	callq	*0x18(%rbx)
1800023e0:     	testq	%rax, %rax
1800023e3:     	je	0x18000252b <.text+0x152b>
1800023e9:     	movq	%rsi, %rcx
1800023ec:     	movq	%rax, %rdx
1800023ef:     	callq	0x18000b9c0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79e0>
1800023f4:     	movq	%rax, %rsi
1800023f7:     	movq	%rbx, %rcx
1800023fa:     	callq	0x18000d450 <numba_list_iter_next+0x270>
1800023ff:     	jmp	0x18000250e <.text+0x150e>
180002404:     	movq	0xcea5(%rip), %rcx      # 0x18000f2b0
18000240b:     	leaq	0xd0be(%rip), %rdx      # 0x18000f4d0
180002412:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002417:     	jmp	0x1800024dc <.text+0x14dc>
18000241c:     	movq	0xce7d(%rip), %rcx      # 0x18000f2a0
180002423:     	leaq	0xd1a6(%rip), %rdx      # 0x18000f5d0
18000242a:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
18000242f:     	jmp	0x1800024dc <.text+0x14dc>
180002434:     	movq	0xce65(%rip), %rcx      # 0x18000f2a0
18000243b:     	leaq	0xd18e(%rip), %rdx      # 0x18000f5d0
180002442:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002447:     	jmp	0x1800024d4 <.text+0x14d4>
18000244c:     	movq	0xce4d(%rip), %rcx      # 0x18000f2a0
180002453:     	leaq	0xd176(%rip), %rdx      # 0x18000f5d0
18000245a:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
18000245f:     	jmp	0x1800024cc <.text+0x14cc>
180002461:     	movq	0xce38(%rip), %rcx      # 0x18000f2a0
180002468:     	leaq	0xd161(%rip), %rdx      # 0x18000f5d0
18000246f:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002474:     	jmp	0x1800024c4 <.text+0x14c4>
180002476:     	xorl	%r12d, %r12d
180002479:     	callq	0x18000d509 <numba_list_iter_next+0x329>
18000247e:     	testq	%rax, %rax
180002481:     	je	0x1800020db <.text+0x10db>
180002487:     	jmp	0x1800024ac <.text+0x14ac>
180002489:     	xorl	%r13d, %r13d
18000248c:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180002491:     	testq	%rax, %rax
180002494:     	je	0x180002177 <.text+0x1177>
18000249a:     	jmp	0x1800024ac <.text+0x14ac>
18000249c:     	xorl	%ebp, %ebp
18000249e:     	callq	0x18000d509 <numba_list_iter_next+0x329>
1800024a3:     	testq	%rax, %rax
1800024a6:     	je	0x1800021b1 <.text+0x11b1>
1800024ac:     	movq	%r15, %rcx
1800024af:     	callq	0x180001060 <.text+0x60>
1800024b4:     	movq	0x128(%rsp), %rbx
1800024bc:     	movq	0x120(%rsp), %r12
1800024c4:     	movq	%r14, %rcx
1800024c7:     	callq	0x180001060 <.text+0x60>
1800024cc:     	movq	%r12, %rcx
1800024cf:     	callq	0x180001060 <.text+0x60>
1800024d4:     	movq	%rbx, %rcx
1800024d7:     	callq	0x180001060 <.text+0x60>
1800024dc:     	xorl	%esi, %esi
1800024de:     	jmp	0x18000238c <.text+0x138c>
1800024e3:     	cmpl	$-0x3, %ebp
1800024e6:     	je	0x18000251d <.text+0x151d>
1800024e8:     	cmpl	$-0x1, %ebp
1800024eb:     	je	0x1800024dc <.text+0x14dc>
1800024ed:     	movq	0xcda4(%rip), %rcx      # 0x18000f298
1800024f4:     	leaq	0xd175(%rip), %rdx      # 0x18000f670
1800024fb:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002500:     	jmp	0x1800024dc <.text+0x14dc>
180002502:     	movq	0x10(%rbx), %r8
180002506:     	callq	0x18000b8e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7900>
18000250b:     	movq	%rax, %rsi
18000250e:     	testq	%rsi, %rsi
180002511:     	je	0x1800024dc <.text+0x14dc>
180002513:     	movq	%rsi, %rcx
180002516:     	callq	0x18000b480 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x74a0>
18000251b:     	jmp	0x1800024dc <.text+0x14dc>
18000251d:     	movq	0xcd6c(%rip), %rcx      # 0x18000f290
180002524:     	callq	0x18000d533 <numba_list_iter_next+0x353>
180002529:     	jmp	0x1800024dc <.text+0x14dc>
18000252b:     	movq	0xcd7e(%rip), %rcx      # 0x18000f2b0
180002532:     	leaq	0xd0f7(%rip), %rdx      # 0x18000f630
180002539:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
18000253e:     	jmp	0x1800024dc <.text+0x14dc>
180002540:     	pushq	%r15
180002542:     	pushq	%r14
180002544:     	pushq	%r13
180002546:     	pushq	%r12
180002548:     	pushq	%rsi
180002549:     	pushq	%rdi
18000254a:     	pushq	%rbp
18000254b:     	pushq	%rbx
18000254c:     	subq	$0x148, %rsp            # imm = 0x148
180002553:     	movq	%r9, %r12
180002556:     	movq	%r8, %r13
180002559:     	movq	%rdx, 0x140(%rsp)
180002561:     	movq	%rcx, 0x138(%rsp)
180002569:     	movsd	0x278(%rsp), %xmm0
180002572:     	movsd	0x280(%rsp), %xmm1
18000257b:     	movq	$0x0, 0x130(%rsp)
180002587:     	movq	$0x0, 0x128(%rsp)
180002593:     	movq	0x220(%rsp), %rbp
18000259b:     	movq	0x228(%rsp), %r15
1800025a3:     	movq	0x230(%rsp), %r14
1800025ab:     	movq	0x238(%rsp), %rbx
1800025b3:     	movq	0x240(%rsp), %rdi
1800025bb:     	movq	0x248(%rsp), %rsi
1800025c3:     	movq	0x250(%rsp), %r11
1800025cb:     	movq	0x258(%rsp), %r10
1800025d3:     	movq	0x260(%rsp), %r9
1800025db:     	movq	0x268(%rsp), %r8
1800025e3:     	movq	0x270(%rsp), %rdx
1800025eb:     	movq	0x288(%rsp), %rcx
1800025f3:     	movq	0x290(%rsp), %rax
1800025fb:     	movq	%rax, 0x110(%rsp)
180002603:     	movq	%rcx, 0x108(%rsp)
18000260b:     	movq	%rdx, 0xf0(%rsp)
180002613:     	movq	%r8, 0xe8(%rsp)
18000261b:     	movq	%r9, 0xe0(%rsp)
180002623:     	movq	%r10, 0xd8(%rsp)
18000262b:     	movq	%r11, 0xd0(%rsp)
180002633:     	movq	%rsi, 0xc8(%rsp)
18000263b:     	movq	%rdi, 0xc0(%rsp)
180002643:     	movq	%rbx, 0xb8(%rsp)
18000264b:     	movq	%r14, 0xb0(%rsp)
180002653:     	movq	%r15, 0xa8(%rsp)
18000265b:     	movq	%rbp, 0xa0(%rsp)
180002663:     	movq	0x218(%rsp), %rax
18000266b:     	movq	%rax, 0x98(%rsp)
180002673:     	movq	0x210(%rsp), %rax
18000267b:     	movq	%rax, 0x90(%rsp)
180002683:     	movq	0x208(%rsp), %rax
18000268b:     	movq	%rax, 0x88(%rsp)
180002693:     	movq	0x200(%rsp), %rax
18000269b:     	movq	%rax, 0x80(%rsp)
1800026a3:     	movq	0x1f8(%rsp), %rax
1800026ab:     	movq	%rax, 0x78(%rsp)
1800026b0:     	movq	0x1f0(%rsp), %rax
1800026b8:     	movq	%rax, 0x70(%rsp)
1800026bd:     	movq	0x1e8(%rsp), %rax
1800026c5:     	movq	%rax, 0x68(%rsp)
1800026ca:     	movq	0x1e0(%rsp), %rax
1800026d2:     	movq	%rax, 0x60(%rsp)
1800026d7:     	movq	0x1d8(%rsp), %rax
1800026df:     	movq	%rax, 0x58(%rsp)
1800026e4:     	movq	0x1d0(%rsp), %rax
1800026ec:     	movq	%rax, 0x50(%rsp)
1800026f1:     	movq	0x1c8(%rsp), %rax
1800026f9:     	movq	%rax, 0x48(%rsp)
1800026fe:     	movq	0x1c0(%rsp), %rax
180002706:     	movq	%rax, 0x40(%rsp)
18000270b:     	movq	0x1b8(%rsp), %rax
180002713:     	movq	%rax, 0x38(%rsp)
180002718:     	movq	0x1b0(%rsp), %rax
180002720:     	movq	%rax, 0x30(%rsp)
180002725:     	movsd	%xmm1, 0x100(%rsp)
18000272e:     	movsd	%xmm0, 0xf8(%rsp)
180002737:     	movq	%r12, 0x28(%rsp)
18000273c:     	movq	%r13, 0x20(%rsp)
180002741:     	leaq	0x130(%rsp), %rcx
180002749:     	leaq	0x128(%rsp), %rdx
180002751:     	movq	0x138(%rsp), %r8
180002759:     	movq	0x140(%rsp), %r9
180002761:     	callq	0x180001090 <.text+0x90>
180002766:     	movl	%eax, %edx
180002768:     	movq	0x128(%rsp), %rsi
180002770:     	movq	0x130(%rsp), %rax
180002778:     	movl	$0x0, 0x124(%rsp)
180002783:     	testl	%edx, %edx
180002785:     	jne	0x18000279b <.text+0x179b>
180002787:     	addq	$0x148, %rsp            # imm = 0x148
18000278e:     	popq	%rbx
18000278f:     	popq	%rbp
180002790:     	popq	%rdi
180002791:     	popq	%rsi
180002792:     	popq	%r12
180002794:     	popq	%r13
180002796:     	popq	%r14
180002798:     	popq	%r15
18000279a:     	retq
18000279b:     	movq	%rax, %rbx
18000279e:     	leaq	0x124(%rsp), %rcx
1800027a6:     	movl	%edx, %edi
1800027a8:     	callq	0x18000b450 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7470>
1800027ad:     	testl	%edi, %edi
1800027af:     	jle	0x1800027f5 <.text+0x17f5>
1800027b1:     	callq	0x18000d521 <numba_list_iter_next+0x341>
1800027b6:     	movl	0x8(%rsi), %edx
1800027b9:     	movq	(%rsi), %rcx
1800027bc:     	cmpl	$0x0, 0x20(%rsi)
1800027c0:     	jle	0x180002816 <.text+0x1816>
1800027c2:     	movslq	%edx, %rdx
1800027c5:     	callq	0x18000d527 <numba_list_iter_next+0x347>
1800027ca:     	movq	%rax, %rdi
1800027cd:     	movq	0x10(%rsi), %rcx
1800027d1:     	callq	*0x18(%rsi)
1800027d4:     	testq	%rax, %rax
1800027d7:     	je	0x180002871 <.text+0x1871>
1800027dd:     	movq	%rdi, %rcx
1800027e0:     	movq	%rax, %rdx
1800027e3:     	callq	0x18000b9c0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79e0>
1800027e8:     	movq	%rax, %rdi
1800027eb:     	movq	%rsi, %rcx
1800027ee:     	callq	0x18000d450 <numba_list_iter_next+0x270>
1800027f3:     	jmp	0x180002822 <.text+0x1822>
1800027f5:     	movl	%edi, %eax
1800027f7:     	cmpl	$-0x3, %edi
1800027fa:     	je	0x180002863 <.text+0x1863>
1800027fc:     	cmpl	$-0x1, %eax
1800027ff:     	je	0x18000282f <.text+0x182f>
180002801:     	movq	0xca90(%rip), %rcx      # 0x18000f298
180002808:     	leaq	0xced1(%rip), %rdx      # 0x18000f6e0
18000280f:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002814:     	jmp	0x18000282f <.text+0x182f>
180002816:     	movq	0x10(%rsi), %r8
18000281a:     	callq	0x18000b8e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7900>
18000281f:     	movq	%rax, %rdi
180002822:     	testq	%rdi, %rdi
180002825:     	je	0x18000282f <.text+0x182f>
180002827:     	movq	%rdi, %rcx
18000282a:     	callq	0x18000b480 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x74a0>
18000282f:     	leaq	0xceda(%rip), %rcx      # 0x18000f710
180002836:     	callq	0x18000d539 <numba_list_iter_next+0x359>
18000283b:     	movq	%rax, %rsi
18000283e:     	movq	%rax, %rcx
180002841:     	callq	0x18000d53f <numba_list_iter_next+0x35f>
180002846:     	movq	%rsi, %rcx
180002849:     	callq	0x18000d503 <numba_list_iter_next+0x323>
18000284e:     	leaq	0x124(%rsp), %rcx
180002856:     	callq	0x18000b470 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7490>
18000285b:     	movq	%rbx, %rax
18000285e:     	jmp	0x180002787 <.text+0x1787>
180002863:     	movq	0xca26(%rip), %rcx      # 0x18000f290
18000286a:     	callq	0x18000d533 <numba_list_iter_next+0x353>
18000286f:     	jmp	0x18000282f <.text+0x182f>
180002871:     	movq	0xca38(%rip), %rcx      # 0x18000f2b0
180002878:     	leaq	0xce21(%rip), %rdx      # 0x18000f6a0
18000287f:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180002884:     	xorl	%eax, %eax
180002886:     	jmp	0x180002787 <.text+0x1787>
18000288b:     	nopl	(%rax,%rax)
180002890:     	pushq	%r15
180002892:     	pushq	%r14
180002894:     	pushq	%r13
180002896:     	pushq	%r12
180002898:     	pushq	%rsi
180002899:     	pushq	%rdi
18000289a:     	pushq	%rbp
18000289b:     	pushq	%rbx
18000289c:     	subq	$0x1a8, %rsp            # imm = 0x1A8
1800028a3:     	movapd	%xmm7, 0x190(%rsp)
1800028ac:     	movaps	%xmm6, 0x180(%rsp)
1800028b4:     	movq	0x2f8(%rsp), %rax
1800028bc:     	movq	0x2c8(%rsp), %r15
1800028c4:     	movq	0x290(%rsp), %r14
1800028cc:     	movabsq	$-0x20000000000001, %r10 # imm = 0xFFDFFFFFFFFFFFFF
1800028d6:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
1800028e0:     	movq	$0x0, 0x160(%rsp)
1800028ec:     	movb	$0x0, 0x168(%rsp)
1800028f4:     	movq	$0x0, 0x170(%rsp)
180002900:     	movb	$0x0, 0x178(%rsp)
180002908:     	movq	$0x0, 0x158(%rsp)
180002914:     	movb	$0x0, 0x11f(%rsp)
18000291c:     	movq	$0x0, 0x150(%rsp)
180002928:     	leaq	(%rax,%r10), %r11
18000292c:     	cmpq	%rsi, %r11
18000292f:     	jb	0x180002941 <.text+0x1941>
180002931:     	movq	0x300(%rsp), %r11
180002939:     	addq	%r11, %r10
18000293c:     	cmpq	%rsi, %r10
18000293f:     	jae	0x18000297a <.text+0x197a>
180002941:     	movb	$0x1, (%r15)
180002945:     	movq	$0x4, 0x18(%r14)
18000294d:     	movq	$0x0, (%rcx)
180002954:     	xorl	%eax, %eax
180002956:     	movaps	0x180(%rsp), %xmm6
18000295e:     	movaps	0x190(%rsp), %xmm7
180002966:     	addq	$0x1a8, %rsp            # imm = 0x1A8
18000296d:     	popq	%rbx
18000296e:     	popq	%rbp
18000296f:     	popq	%rdi
180002970:     	popq	%rsi
180002971:     	popq	%r12
180002973:     	popq	%r13
180002975:     	popq	%r14
180002977:     	popq	%r15
180002979:     	retq
18000297a:     	movq	0x260(%rsp), %r12
180002982:     	movq	(%r14), %r10
180002985:     	leaq	0x4(%r10), %rsi
180002989:     	cmpq	%r12, %rsi
18000298c:     	jle	0x180002994 <.text+0x1994>
18000298e:     	movb	$0x2, (%r15)
180002992:     	jmp	0x18000294d <.text+0x194d>
180002994:     	movq	%rsi, (%r14)
180002997:     	cmpb	$0x0, (%r15)
18000299b:     	jne	0x18000294d <.text+0x194d>
18000299d:     	movq	0x220(%rsp), %r13
1800029a5:     	testq	%r10, %r10
1800029a8:     	js	0x1800029ec <.text+0x19ec>
1800029aa:     	cvtsi2sd	%r11, %xmm0
1800029af:     	movsd	0xc9f9(%rip), %xmm1     # 0x18000f3b0
1800029b7:     	mulsd	%xmm1, %xmm0
1800029bb:     	cvtsi2sd	%rax, %xmm2
1800029c0:     	mulsd	%xmm1, %xmm2
1800029c4:     	movsd	%xmm2, 0x10(%r13,%r10,8)
1800029cb:     	movsd	%xmm0, 0x18(%r13,%r10,8)
1800029d2:     	movsd	%xmm2, 0x8(%r13,%r10,8)
1800029d9:     	movsd	%xmm0, (%r13,%r10,8)
1800029e0:     	cmpb	$0x0, (%r15)
1800029e4:     	jne	0x18000294d <.text+0x194d>
1800029ea:     	jmp	0x180002a02 <.text+0x1a02>
1800029ec:     	movb	$0x1, (%r15)
1800029f0:     	movq	$0xf4242, 0x18(%r14)    # imm = 0xF4242
1800029f8:     	cmpb	$0x0, (%r15)
1800029fc:     	jne	0x18000294d <.text+0x194d>
180002a02:     	movq	(%r14), %rbx
180002a05:     	leaq	0xb(%rbx), %rax
180002a09:     	cmpq	%r12, %rax
180002a0c:     	jg	0x18000298e <.text+0x198e>
180002a0e:     	movq	%rax, (%r14)
180002a11:     	cmpb	$0x0, (%r15)
180002a15:     	jne	0x18000294d <.text+0x194d>
180002a1b:     	movq	0x258(%rsp), %rax
180002a23:     	movq	%rbx, %r11
180002a26:     	sarq	$0x3f, %r11
180002a2a:     	andq	%r12, %r11
180002a2d:     	leaq	(%rax,%rbx,8), %rax
180002a31:     	movq	%r10, (%rax,%r11,8)
180002a35:     	xorl	%r10d, %r10d
180002a38:     	cmpq	$-0x1, %rbx
180002a3c:     	cmovlq	%r12, %r10
180002a40:     	movq	$0x4, 0x8(%rax,%r10,8)
180002a49:     	movq	(%r14), %r10
180002a4c:     	cmpq	%r12, %r10
180002a4f:     	movq	%r10, %r11
180002a52:     	jle	0x180002a5e <.text+0x1a5e>
180002a54:     	movb	$0x2, (%r15)
180002a58:     	movq	(%r14), %r10
180002a5b:     	xorl	%r11d, %r11d
180002a5e:     	leaq	0x3(%r10), %rsi
180002a62:     	cmpq	%r12, %rsi
180002a65:     	jg	0x18000298e <.text+0x198e>
180002a6b:     	movq	%rsi, (%r14)
180002a6e:     	cmpb	$0x0, (%r15)
180002a72:     	jne	0x18000294d <.text+0x194d>
180002a78:     	movq	%r10, %rsi
180002a7b:     	sarq	$0x3f, %rsi
180002a7f:     	andq	%r12, %rsi
180002a82:     	movq	0x258(%rsp), %rdi
180002a8a:     	leaq	(%rdi,%r10,8), %rdi
180002a8e:     	movq	$0x0, (%rdi,%rsi,8)
180002a96:     	xorl	%esi, %esi
180002a98:     	cmpq	$-0x1, %r10
180002a9c:     	movl	$0x0, %ebp
180002aa1:     	cmovlq	%r12, %rbp
180002aa5:     	movq	$0x0, 0x8(%rdi,%rbp,8)
180002aae:     	cmpq	$-0x2, %r10
180002ab2:     	cmovlq	%r12, %rsi
180002ab6:     	movq	%r11, 0x10(%rdi,%rsi,8)
180002abb:     	cmpb	$0x0, (%r15)
180002abf:     	jne	0x18000294d <.text+0x194d>
180002ac5:     	xorl	%r11d, %r11d
180002ac8:     	cmpq	$-0x6, %rbx
180002acc:     	movl	$0x0, %esi
180002ad1:     	cmovlq	%r12, %rsi
180002ad5:     	movq	%r10, 0x30(%rax,%rsi,8)
180002ada:     	cmpq	$-0x3, %rbx
180002ade:     	cmovlq	%r12, %r11
180002ae2:     	movq	$0x0, 0x18(%rax,%r11,8)
180002aeb:     	movq	(%r14), %r10
180002aee:     	leaq	0x4(%r10), %r11
180002af2:     	cmpq	%r12, %r11
180002af5:     	jg	0x18000298e <.text+0x198e>
180002afb:     	movq	%r11, (%r14)
180002afe:     	cmpb	$0x0, (%r15)
180002b02:     	jne	0x18000294d <.text+0x194d>
180002b08:     	movq	%r8, 0x148(%rsp)
180002b10:     	movq	%r9, 0x140(%rsp)
180002b18:     	movq	%rdx, 0x138(%rsp)
180002b20:     	movq	%rcx, 0x120(%rsp)
180002b28:     	testq	%r10, %r10
180002b2b:     	js	0x180002b5b <.text+0x1b5b>
180002b2d:     	movq	$0x0, (%r13,%r10,8)
180002b36:     	movq	0x258(%rsp), %rdx
180002b3e:     	leaq	(%rdx,%r10,8), %rcx
180002b42:     	movq	$0x1, 0x8(%rdx,%r10,8)
180002b4b:     	movq	$0x0, 0x10(%r13,%r10,8)
180002b54:     	movl	$0x1, %edx
180002b59:     	jmp	0x180002b67 <.text+0x1b67>
180002b5b:     	movb	$0x1, (%r15)
180002b5f:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
180002b64:     	movq	%r14, %rcx
180002b67:     	movq	%rdx, 0x18(%rcx)
180002b6b:     	cmpb	$0x0, (%r15)
180002b6f:     	movq	0x120(%rsp), %rcx
180002b77:     	movq	0x258(%rsp), %r11
180002b7f:     	jne	0x18000294d <.text+0x194d>
180002b85:     	xorl	%edx, %edx
180002b87:     	cmpq	$-0x2, %rbx
180002b8b:     	movl	$0x0, %r8d
180002b91:     	cmovlq	%r12, %r8
180002b95:     	movq	%r10, 0x10(%rax,%r8,8)
180002b9a:     	cmpq	$-0x9, %rbx
180002b9e:     	movl	$0x0, %r8d
180002ba4:     	cmovlq	0x228(%rsp), %r8
180002bad:     	leaq	(%r13,%rbx,8), %r9
180002bb2:     	movq	$0x0, 0x48(%r9,%r8,8)
180002bbb:     	cmpq	$-0xa, %rbx
180002bbf:     	movl	$0x0, %r8d
180002bc5:     	cmovlq	%r12, %r8
180002bc9:     	movq	$0x1, 0x50(%rax,%r8,8)
180002bd2:     	cmpq	$-0x4, %rbx
180002bd6:     	movl	$0x0, %r8d
180002bdc:     	cmovlq	%r12, %r8
180002be0:     	movq	$-0x1, 0x20(%rax,%r8,8)
180002be9:     	cmpq	$-0x5, %rbx
180002bed:     	movl	$0x0, %r8d
180002bf3:     	cmovlq	%r12, %r8
180002bf7:     	movq	$-0x1, 0x28(%rax,%r8,8)
180002c00:     	cmpq	$-0x7, %rbx
180002c04:     	movl	$0x0, %r8d
180002c0a:     	cmovlq	%r12, %r8
180002c0e:     	movq	$-0x1, 0x38(%rax,%r8,8)
180002c17:     	cmpq	$-0x8, %rbx
180002c1b:     	cmovlq	%r12, %rdx
180002c1f:     	movq	$-0x1, 0x40(%rax,%rdx,8)
180002c28:     	cmpb	$0x0, (%r15)
180002c2c:     	jne	0x18000294d <.text+0x194d>
180002c32:     	movq	0x2e0(%rsp), %rax
180002c3a:     	movq	%rax, %rdx
180002c3d:     	sarq	$0x3f, %rdx
180002c41:     	andq	%r12, %rdx
180002c44:     	xorl	%ecx, %ecx
180002c46:     	cmpq	$-0x2, %rax
180002c4a:     	leaq	(%r11,%rax,8), %rax
180002c4e:     	cmovlq	%r12, %rcx
180002c52:     	movq	%rcx, 0x130(%rsp)
180002c5a:     	movq	%rax, %rbp
180002c5d:     	movq	%rdx, 0x128(%rsp)
180002c65:     	cmpq	$0x0, (%rax,%rdx,8)
180002c6a:     	jle	0x180002ea5 <.text+0x1ea5>
180002c70:     	testq	%rbx, %rbx
180002c73:     	js	0x180003193 <.text+0x2193>
180002c79:     	movq	0x8(%r14), %rax
180002c7d:     	xorl	%esi, %esi
180002c7f:     	leaq	0x11f(%rsp), %rdi
180002c87:     	movq	0x130(%rsp), %rcx
180002c8f:     	movq	0x10(%rbp,%rcx,8), %rcx
180002c94:     	addq	%rsi, %rcx
180002c97:     	movq	0x258(%rsp), %rdx
180002c9f:     	leaq	(%rdx,%rcx,8), %rdx
180002ca3:     	sarq	$0x3f, %rcx
180002ca7:     	andq	%r12, %rcx
180002caa:     	movq	(%rdx,%rcx,8), %rcx
180002cae:     	leaq	0x1(%rax), %rdx
180002cb2:     	movq	%rdx, 0x8(%r14)
180002cb6:     	cmpq	0x10(%r14), %rax
180002cba:     	jge	0x180003193 <.text+0x2193>
180002cc0:     	movq	%rcx, 0x100(%rsp)
180002cc8:     	movq	%rbx, 0xf8(%rsp)
180002cd0:     	movq	0x2d8(%rsp), %rax
180002cd8:     	movq	%rax, 0xe8(%rsp)
180002ce0:     	movq	0x2d0(%rsp), %rax
180002ce8:     	movq	%rax, 0xe0(%rsp)
180002cf0:     	movq	%r15, 0xd8(%rsp)
180002cf8:     	movq	0x2c0(%rsp), %rax
180002d00:     	movq	%rax, 0xd0(%rsp)
180002d08:     	movq	0x2b8(%rsp), %rax
180002d10:     	movq	%rax, 0xc8(%rsp)
180002d18:     	movq	0x2b0(%rsp), %rax
180002d20:     	movq	%rax, 0xc0(%rsp)
180002d28:     	movq	0x2a8(%rsp), %rax
180002d30:     	movq	%rax, 0xb8(%rsp)
180002d38:     	movq	0x2a0(%rsp), %rax
180002d40:     	movq	%rax, 0xb0(%rsp)
180002d48:     	movq	0x298(%rsp), %rax
180002d50:     	movq	%rax, 0xa8(%rsp)
180002d58:     	movq	%r14, 0xa0(%rsp)
180002d60:     	movq	0x288(%rsp), %rax
180002d68:     	movq	%rax, 0x98(%rsp)
180002d70:     	movq	0x280(%rsp), %rax
180002d78:     	movq	%rax, 0x90(%rsp)
180002d80:     	movq	0x278(%rsp), %rax
180002d88:     	movq	%rax, 0x88(%rsp)
180002d90:     	movq	0x270(%rsp), %rax
180002d98:     	movq	%rax, 0x80(%rsp)
180002da0:     	movq	0x268(%rsp), %rax
180002da8:     	movq	%rax, 0x78(%rsp)
180002dad:     	movq	%r12, 0x70(%rsp)
180002db2:     	movq	0x258(%rsp), %rax
180002dba:     	movq	%rax, 0x68(%rsp)
180002dbf:     	movq	0x250(%rsp), %rax
180002dc7:     	movq	%rax, 0x60(%rsp)
180002dcc:     	movq	0x248(%rsp), %rax
180002dd4:     	movq	%rax, 0x58(%rsp)
180002dd9:     	movq	0x240(%rsp), %rax
180002de1:     	movq	%rax, 0x50(%rsp)
180002de6:     	movq	0x238(%rsp), %rax
180002dee:     	movq	%rax, 0x48(%rsp)
180002df3:     	movq	0x230(%rsp), %rax
180002dfb:     	movq	%rax, 0x40(%rsp)
180002e00:     	movq	0x228(%rsp), %rax
180002e08:     	movq	%rax, 0x38(%rsp)
180002e0d:     	movq	%r13, 0x30(%rsp)
180002e12:     	movq	0x218(%rsp), %rax
180002e1a:     	movq	%rax, 0x28(%rsp)
180002e1f:     	movq	0x210(%rsp), %rax
180002e27:     	movq	%rax, 0x20(%rsp)
180002e2c:     	movq	$-0x1, 0x108(%rsp)
180002e38:     	movq	$0x0, 0xf0(%rsp)
180002e44:     	movq	%rdi, %rcx
180002e47:     	leaq	0x150(%rsp), %rdx
180002e4f:     	movq	0x148(%rsp), %r8
180002e57:     	movq	0x140(%rsp), %r9
180002e5f:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
180002e64:     	testl	%eax, %eax
180002e66:     	jne	0x1800033f8 <.text+0x23f8>
180002e6c:     	cmpb	$0x0, (%r15)
180002e70:     	jne	0x18000319f <.text+0x219f>
180002e76:     	incq	%rsi
180002e79:     	movq	0x8(%r14), %rax
180002e7d:     	decq	%rax
180002e80:     	movq	%rax, 0x8(%r14)
180002e84:     	movq	0x128(%rsp), %rcx
180002e8c:     	cmpq	(%rbp,%rcx,8), %rsi
180002e91:     	jl	0x180002c87 <.text+0x1c87>
180002e97:     	leaq	0x18(%r14), %rax
180002e9b:     	movq	%rax, 0x110(%rsp)
180002ea3:     	jmp	0x180002eba <.text+0x1eba>
180002ea5:     	leaq	0x18(%r14), %rax
180002ea9:     	movq	%rax, 0x110(%rsp)
180002eb1:     	testq	%rbx, %rbx
180002eb4:     	js	0x1800031b3 <.text+0x21b3>
180002eba:     	movsd	0x2e8(%rsp), %xmm6
180002ec3:     	xorl	%edi, %edi
180002ec5:     	xorpd	%xmm7, %xmm7
180002ec9:     	movq	0x128(%rsp), %rax
180002ed1:     	cmpq	(%rbp,%rax,8), %rdi
180002ed6:     	jge	0x1800031b3 <.text+0x21b3>
180002edc:     	movq	0x130(%rsp), %rax
180002ee4:     	movq	0x10(%rbp,%rax,8), %rax
180002ee9:     	addq	%rdi, %rax
180002eec:     	movq	0x258(%rsp), %rcx
180002ef4:     	leaq	(%rcx,%rax,8), %rcx
180002ef8:     	sarq	$0x3f, %rax
180002efc:     	andq	%r12, %rax
180002eff:     	movq	(%rcx,%rax,8), %rsi
180002f03:     	movq	0x8(%r14), %rax
180002f07:     	leaq	0x1(%rax), %rcx
180002f0b:     	movq	%rcx, 0x8(%r14)
180002f0f:     	cmpq	0x10(%r14), %rax
180002f13:     	jge	0x180003428 <.text+0x2428>
180002f19:     	movsd	%xmm6, 0x100(%rsp)
180002f22:     	movq	%rsi, 0xf8(%rsp)
180002f2a:     	movq	%rbx, 0xf0(%rsp)
180002f32:     	movq	0x2d8(%rsp), %rax
180002f3a:     	movq	%rax, 0xe8(%rsp)
180002f42:     	movq	0x2d0(%rsp), %rax
180002f4a:     	movq	%rax, 0xe0(%rsp)
180002f52:     	movq	%r15, 0xd8(%rsp)
180002f5a:     	movq	0x2c0(%rsp), %rax
180002f62:     	movq	%rax, 0xd0(%rsp)
180002f6a:     	movq	0x2b8(%rsp), %rax
180002f72:     	movq	%rax, 0xc8(%rsp)
180002f7a:     	movq	0x2b0(%rsp), %rax
180002f82:     	movq	%rax, 0xc0(%rsp)
180002f8a:     	movq	0x2a8(%rsp), %rax
180002f92:     	movq	%rax, 0xb8(%rsp)
180002f9a:     	movq	0x2a0(%rsp), %rax
180002fa2:     	movq	%rax, 0xb0(%rsp)
180002faa:     	movq	0x298(%rsp), %rax
180002fb2:     	movq	%rax, 0xa8(%rsp)
180002fba:     	movq	%r14, 0xa0(%rsp)
180002fc2:     	movq	0x288(%rsp), %rax
180002fca:     	movq	%rax, 0x98(%rsp)
180002fd2:     	movq	0x280(%rsp), %rax
180002fda:     	movq	%rax, 0x90(%rsp)
180002fe2:     	movq	0x278(%rsp), %rax
180002fea:     	movq	%rax, 0x88(%rsp)
180002ff2:     	movq	0x270(%rsp), %rax
180002ffa:     	movq	%rax, 0x80(%rsp)
180003002:     	movq	0x268(%rsp), %rax
18000300a:     	movq	%rax, 0x78(%rsp)
18000300f:     	movq	%r12, 0x70(%rsp)
180003014:     	movq	0x258(%rsp), %rax
18000301c:     	movq	%rax, 0x68(%rsp)
180003021:     	movq	0x250(%rsp), %rax
180003029:     	movq	%rax, 0x60(%rsp)
18000302e:     	movq	0x248(%rsp), %rax
180003036:     	movq	%rax, 0x58(%rsp)
18000303b:     	movq	0x240(%rsp), %rax
180003043:     	movq	%rax, 0x50(%rsp)
180003048:     	movq	0x238(%rsp), %rax
180003050:     	movq	%rax, 0x48(%rsp)
180003055:     	movq	0x230(%rsp), %rax
18000305d:     	movq	%rax, 0x40(%rsp)
180003062:     	movq	0x228(%rsp), %rax
18000306a:     	movq	%rax, 0x38(%rsp)
18000306f:     	movq	%r13, 0x30(%rsp)
180003074:     	movq	0x218(%rsp), %rax
18000307c:     	movq	%rax, 0x28(%rsp)
180003081:     	movq	0x210(%rsp), %rax
180003089:     	movq	%rax, 0x20(%rsp)
18000308e:     	leaq	0x160(%rsp), %rcx
180003096:     	leaq	0x158(%rsp), %rdx
18000309e:     	movq	0x148(%rsp), %r8
1800030a6:     	movq	0x140(%rsp), %r9
1800030ae:     	callq	0x180007d80 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3da0>
1800030b3:     	testl	%eax, %eax
1800030b5:     	jne	0x180003458 <.text+0x2458>
1800030bb:     	cmpb	$0x0, (%r15)
1800030bf:     	jne	0x18000319f <.text+0x219f>
1800030c5:     	movsd	0x160(%rsp), %xmm1
1800030ce:     	movsd	0x170(%rsp), %xmm0
1800030d7:     	decq	0x8(%r14)
1800030db:     	testq	%rsi, %rsi
1800030de:     	js	0x180003440 <.text+0x2440>
1800030e4:     	movq	0x258(%rsp), %rax
1800030ec:     	movq	(%rax,%rsi,8), %rax
1800030f0:     	testq	%rax, %rax
1800030f3:     	js	0x180003104 <.text+0x2104>
1800030f5:     	movsd	0x8(%r13,%rsi,8), %xmm2
1800030fc:     	ucomisd	%xmm7, %xmm2
180003100:     	jne	0x180003126 <.text+0x2126>
180003102:     	jp	0x180003126 <.text+0x2126>
180003104:     	movb	$0x1, (%r15)
180003108:     	movq	0x110(%rsp), %rax
180003110:     	movq	$0x4c4b43, (%rax)       # imm = 0x4C4B43
180003117:     	incq	%rdi
18000311a:     	cmpb	$0x0, (%r15)
18000311e:     	je	0x180002ec9 <.text+0x1ec9>
180003124:     	jmp	0x18000319f <.text+0x219f>
180003126:     	divsd	%xmm2, %xmm1
18000312a:     	addsd	(%r13,%rax,8), %xmm1
180003131:     	movsd	%xmm1, (%r13,%rax,8)
180003138:     	movq	0x258(%rsp), %rcx
180003140:     	movq	$0x0, 0x8(%rcx,%rax,8)
180003149:     	movq	(%rcx,%rsi,8), %rax
18000314d:     	testq	%rax, %rax
180003150:     	js	0x180003161 <.text+0x2161>
180003152:     	movsd	0x8(%r13,%rsi,8), %xmm1
180003159:     	ucomisd	%xmm7, %xmm1
18000315d:     	jne	0x180003176 <.text+0x2176>
18000315f:     	jp	0x180003176 <.text+0x2176>
180003161:     	movb	$0x1, (%r15)
180003165:     	movq	0x110(%rsp), %rax
18000316d:     	movq	$0x4c4b44, (%rax)       # imm = 0x4C4B44
180003174:     	jmp	0x180003117 <.text+0x2117>
180003176:     	divsd	%xmm1, %xmm0
18000317a:     	addsd	0x10(%r13,%rax,8), %xmm0
180003181:     	movsd	%xmm0, 0x10(%r13,%rax,8)
180003188:     	movq	$0x0, 0x18(%rcx,%rax,8)
180003191:     	jmp	0x180003117 <.text+0x2117>
180003193:     	movb	$0x1, (%r15)
180003197:     	movq	$0x9, 0x18(%r14)
18000319f:     	movq	0x120(%rsp), %rax
1800031a7:     	movq	$0x0, (%rax)
1800031ae:     	jmp	0x180002954 <.text+0x1954>
1800031b3:     	movsd	0x2f0(%rsp), %xmm0
1800031bc:     	xorl	%eax, %eax
1800031be:     	jmp	0x1800031dc <.text+0x21dc>
1800031c0:     	movb	$0x1, (%r15)
1800031c4:     	movq	0x110(%rsp), %rcx
1800031cc:     	movq	$0x5b8d83, (%rcx)       # imm = 0x5B8D83
1800031d3:     	incq	%rax
1800031d6:     	cmpb	$0x0, (%r15)
1800031da:     	jne	0x18000319f <.text+0x219f>
1800031dc:     	movq	0x128(%rsp), %rcx
1800031e4:     	cmpq	(%rbp,%rcx,8), %rax
1800031e9:     	jge	0x18000319f <.text+0x219f>
1800031eb:     	movq	0x130(%rsp), %rcx
1800031f3:     	movq	0x10(%rbp,%rcx,8), %rcx
1800031f8:     	addq	%rax, %rcx
1800031fb:     	movq	0x258(%rsp), %rdx
180003203:     	leaq	(%rdx,%rcx,8), %rdx
180003207:     	sarq	$0x3f, %rcx
18000320b:     	andq	%r12, %rcx
18000320e:     	movq	(%rdx,%rcx,8), %rcx
180003212:     	testq	%rcx, %rcx
180003215:     	js	0x180003410 <.text+0x2410>
18000321b:     	movq	0x258(%rsp), %rdx
180003223:     	movq	0x18(%rdx,%rcx,8), %rdx
180003228:     	testq	%rdx, %rdx
18000322b:     	js	0x1800031c0 <.text+0x21c0>
18000322d:     	movq	0x258(%rsp), %r8
180003235:     	movq	(%r8,%rcx,8), %r8
180003239:     	testq	%r8, %r8
18000323c:     	js	0x1800031c0 <.text+0x21c0>
18000323e:     	movsd	(%r13,%r8,8), %xmm1
180003245:     	mulsd	%xmm0, %xmm1
180003249:     	addsd	(%r13,%rdx,8), %xmm1
180003250:     	movsd	%xmm1, (%r13,%rdx,8)
180003257:     	movq	0x258(%rsp), %r8
18000325f:     	movq	$0x0, 0x8(%r8,%rdx,8)
180003268:     	movq	0x18(%r8,%rcx,8), %rdx
18000326d:     	testq	%rdx, %rdx
180003270:     	js	0x180003380 <.text+0x2380>
180003276:     	movq	(%r8,%rcx,8), %r8
18000327a:     	testq	%r8, %r8
18000327d:     	js	0x180003380 <.text+0x2380>
180003283:     	movsd	0x10(%r13,%r8,8), %xmm1
18000328a:     	mulsd	%xmm0, %xmm1
18000328e:     	addsd	0x10(%r13,%rdx,8), %xmm1
180003295:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
18000329c:     	movq	0x258(%rsp), %r8
1800032a4:     	movq	$0x0, 0x18(%r8,%rdx,8)
1800032ad:     	movq	0x10(%r8,%rcx,8), %rdx
1800032b2:     	testq	%rdx, %rdx
1800032b5:     	js	0x180003398 <.text+0x2398>
1800032bb:     	movq	0x18(%r8,%rcx,8), %r8
1800032c0:     	testq	%r8, %r8
1800032c3:     	js	0x180003398 <.text+0x2398>
1800032c9:     	movsd	(%r13,%r8,8), %xmm1
1800032d0:     	mulsd	%xmm0, %xmm1
1800032d4:     	addsd	(%r13,%rdx,8), %xmm1
1800032db:     	movsd	%xmm1, (%r13,%rdx,8)
1800032e2:     	movq	0x258(%rsp), %r8
1800032ea:     	movq	$0x0, 0x8(%r8,%rdx,8)
1800032f3:     	movq	0x10(%r8,%rcx,8), %rdx
1800032f8:     	testq	%rdx, %rdx
1800032fb:     	js	0x1800033b0 <.text+0x23b0>
180003301:     	movq	0x18(%r8,%rcx,8), %r8
180003306:     	testq	%r8, %r8
180003309:     	js	0x1800033b0 <.text+0x23b0>
18000330f:     	movsd	0x10(%r13,%r8,8), %xmm1
180003316:     	mulsd	%xmm0, %xmm1
18000331a:     	addsd	0x10(%r13,%rdx,8), %xmm1
180003321:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
180003328:     	movq	0x258(%rsp), %r8
180003330:     	movq	$0x0, 0x18(%r8,%rdx,8)
180003339:     	movq	(%r8,%rcx,8), %rdx
18000333d:     	testq	%rdx, %rdx
180003340:     	js	0x1800033c8 <.text+0x23c8>
180003346:     	movq	$0x0, (%r13,%rdx,8)
18000334f:     	movq	$0x1, 0x8(%r8,%rdx,8)
180003358:     	movq	(%r8,%rcx,8), %rcx
18000335c:     	testq	%rcx, %rcx
18000335f:     	js	0x1800033e0 <.text+0x23e0>
180003361:     	movq	$0x0, 0x10(%r13,%rcx,8)
18000336a:     	movq	0x258(%rsp), %rdx
180003372:     	movq	$0x1, 0x18(%rdx,%rcx,8)
18000337b:     	jmp	0x1800031d3 <.text+0x21d3>
180003380:     	movb	$0x1, (%r15)
180003384:     	movq	0x110(%rsp), %rcx
18000338c:     	movq	$0x5b8d84, (%rcx)       # imm = 0x5B8D84
180003393:     	jmp	0x1800031d3 <.text+0x21d3>
180003398:     	movb	$0x1, (%r15)
18000339c:     	movq	0x110(%rsp), %rcx
1800033a4:     	movq	$0x5b8d87, (%rcx)       # imm = 0x5B8D87
1800033ab:     	jmp	0x1800031d3 <.text+0x21d3>
1800033b0:     	movb	$0x1, (%r15)
1800033b4:     	movq	0x110(%rsp), %rcx
1800033bc:     	movq	$0x5b8d88, (%rcx)       # imm = 0x5B8D88
1800033c3:     	jmp	0x1800031d3 <.text+0x21d3>
1800033c8:     	movb	$0x1, (%r15)
1800033cc:     	movq	0x110(%rsp), %rcx
1800033d4:     	movq	$0x5b8d8b, (%rcx)       # imm = 0x5B8D8B
1800033db:     	jmp	0x1800031d3 <.text+0x21d3>
1800033e0:     	movb	$0x1, (%r15)
1800033e4:     	movq	0x110(%rsp), %rcx
1800033ec:     	movq	$0x5b8d8c, (%rcx)       # imm = 0x5B8D8C
1800033f3:     	jmp	0x1800031d3 <.text+0x21d3>
1800033f8:     	movq	0x150(%rsp), %rdx
180003400:     	movq	0x138(%rsp), %rcx
180003408:     	movq	%rdx, (%rcx)
18000340b:     	jmp	0x180002956 <.text+0x1956>
180003410:     	movb	$0x1, (%r15)
180003414:     	movq	0x110(%rsp), %rax
18000341c:     	movq	$0x12, (%rax)
180003423:     	jmp	0x18000319f <.text+0x219f>
180003428:     	movb	$0x1, (%r15)
18000342c:     	movq	0x110(%rsp), %rax
180003434:     	movq	$0xd, (%rax)
18000343b:     	jmp	0x18000319f <.text+0x219f>
180003440:     	movb	$0x1, (%r15)
180003444:     	movq	0x110(%rsp), %rax
18000344c:     	movq	$0xe, (%rax)
180003453:     	jmp	0x18000319f <.text+0x219f>
180003458:     	movq	0x138(%rsp), %rcx
180003460:     	movq	$0x0, (%rcx)
180003467:     	jmp	0x180002956 <.text+0x1956>
18000346c:     	nopl	(%rax)
180003470:     	pushq	%r15
180003472:     	pushq	%r14
180003474:     	pushq	%r13
180003476:     	pushq	%r12
180003478:     	pushq	%rsi
180003479:     	pushq	%rdi
18000347a:     	pushq	%rbp
18000347b:     	pushq	%rbx
18000347c:     	subq	$0x338, %rsp            # imm = 0x338
180003483:     	movaps	%xmm7, 0x320(%rsp)
18000348b:     	movaps	%xmm6, 0x310(%rsp)
180003493:     	movq	%rdx, %rcx
180003496:     	leaq	0x1c8(%rsp), %rax
18000349e:     	movq	%rax, 0x60(%rsp)
1800034a3:     	leaq	0x1d0(%rsp), %rax
1800034ab:     	movq	%rax, 0x58(%rsp)
1800034b0:     	leaq	0x1d8(%rsp), %rax
1800034b8:     	movq	%rax, 0x50(%rsp)
1800034bd:     	leaq	0x1e0(%rsp), %rax
1800034c5:     	movq	%rax, 0x48(%rsp)
1800034ca:     	leaq	0x1e8(%rsp), %rax
1800034d2:     	movq	%rax, 0x40(%rsp)
1800034d7:     	leaq	0x1f0(%rsp), %rax
1800034df:     	movq	%rax, 0x38(%rsp)
1800034e4:     	leaq	0x1f8(%rsp), %rax
1800034ec:     	movq	%rax, 0x30(%rsp)
1800034f1:     	leaq	0x200(%rsp), %rax
1800034f9:     	movq	%rax, 0x28(%rsp)
1800034fe:     	leaq	0x208(%rsp), %rax
180003506:     	movq	%rax, 0x20(%rsp)
18000350b:     	leaq	0xc21e(%rip), %rdx      # 0x18000f730
180003512:     	movl	$0x9, %r8d
180003518:     	movl	$0x9, %r9d
18000351e:     	callq	0x18000d4f1 <numba_list_iter_next+0x311>
180003523:     	testl	%eax, %eax
180003525:     	movq	$0x0, 0x130(%rsp)
180003531:     	je	0x180003c2c <.text+0x2c2c>
180003537:     	cmpq	$0x0, 0x13789(%rip)     # 0x180016cc8
18000353f:     	je	0x180003b54 <.text+0x2b54>
180003545:     	movq	0x208(%rsp), %rcx
18000354d:     	xorps	%xmm0, %xmm0
180003550:     	movaps	%xmm0, 0x2d0(%rsp)
180003558:     	movaps	%xmm0, 0x2e0(%rsp)
180003560:     	movaps	%xmm0, 0x2f0(%rsp)
180003568:     	movq	$0x0, 0x300(%rsp)
180003574:     	leaq	0x2d0(%rsp), %rdx
18000357c:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
180003581:     	testl	%eax, %eax
180003583:     	jne	0x180003b6c <.text+0x2b6c>
180003589:     	cmpq	$0x8, 0x2e8(%rsp)
180003592:     	jne	0x180003b6c <.text+0x2b6c>
180003598:     	movq	0x2d0(%rsp), %rbx
1800035a0:     	movq	0x2d8(%rsp), %rbp
1800035a8:     	movq	0x2e0(%rsp), %rsi
1800035b0:     	movq	0x2f0(%rsp), %rdi
1800035b8:     	movq	0x2f8(%rsp), %r15
1800035c0:     	movq	0x300(%rsp), %r13
1800035c8:     	movq	0x200(%rsp), %rcx
1800035d0:     	xorps	%xmm0, %xmm0
1800035d3:     	movaps	%xmm0, 0x290(%rsp)
1800035db:     	movaps	%xmm0, 0x2a0(%rsp)
1800035e3:     	movaps	%xmm0, 0x2b0(%rsp)
1800035eb:     	movq	$0x0, 0x2c0(%rsp)
1800035f7:     	leaq	0x290(%rsp), %rdx
1800035ff:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
180003604:     	testl	%eax, %eax
180003606:     	jne	0x180003b84 <.text+0x2b84>
18000360c:     	cmpq	$0x8, 0x2a8(%rsp)
180003615:     	jne	0x180003b84 <.text+0x2b84>
18000361b:     	movq	0x290(%rsp), %r12
180003623:     	movq	0x298(%rsp), %r14
18000362b:     	movq	0x2a0(%rsp), %rax
180003633:     	movq	%rax, 0x1c0(%rsp)
18000363b:     	movq	0x2b0(%rsp), %rax
180003643:     	movq	%rax, 0x1b8(%rsp)
18000364b:     	movq	0x2b8(%rsp), %rax
180003653:     	movq	%rax, 0x1b0(%rsp)
18000365b:     	movq	0x2c0(%rsp), %rax
180003663:     	movq	%rax, 0x1a8(%rsp)
18000366b:     	movq	0x1f8(%rsp), %rcx
180003673:     	xorps	%xmm0, %xmm0
180003676:     	movaps	%xmm0, 0x250(%rsp)
18000367e:     	movaps	%xmm0, 0x260(%rsp)
180003686:     	movaps	%xmm0, 0x270(%rsp)
18000368e:     	movq	$0x0, 0x280(%rsp)
18000369a:     	leaq	0x250(%rsp), %rdx
1800036a2:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
1800036a7:     	testl	%eax, %eax
1800036a9:     	jne	0x180003b9c <.text+0x2b9c>
1800036af:     	cmpq	$0x8, 0x268(%rsp)
1800036b8:     	jne	0x180003b9c <.text+0x2b9c>
1800036be:     	movq	%r14, 0x1a0(%rsp)
1800036c6:     	movq	0x250(%rsp), %r14
1800036ce:     	movq	0x258(%rsp), %rax
1800036d6:     	movq	%rax, 0x198(%rsp)
1800036de:     	movq	0x260(%rsp), %rax
1800036e6:     	movq	%rax, 0x190(%rsp)
1800036ee:     	movq	0x270(%rsp), %rax
1800036f6:     	movq	%rax, 0x188(%rsp)
1800036fe:     	movq	0x278(%rsp), %rax
180003706:     	movq	%rax, 0x180(%rsp)
18000370e:     	movq	0x280(%rsp), %rax
180003716:     	movq	%rax, 0x178(%rsp)
18000371e:     	movq	0x1f0(%rsp), %rcx
180003726:     	xorps	%xmm0, %xmm0
180003729:     	movaps	%xmm0, 0x210(%rsp)
180003731:     	movaps	%xmm0, 0x220(%rsp)
180003739:     	movaps	%xmm0, 0x230(%rsp)
180003741:     	movq	$0x0, 0x240(%rsp)
18000374d:     	leaq	0x210(%rsp), %rdx
180003755:     	callq	0x18000c1b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x81d0>
18000375a:     	testl	%eax, %eax
18000375c:     	jne	0x180003bb1 <.text+0x2bb1>
180003762:     	cmpq	$0x1, 0x228(%rsp)
18000376b:     	jne	0x180003bb1 <.text+0x2bb1>
180003771:     	movq	%r13, 0x150(%rsp)
180003779:     	movq	%r15, 0x158(%rsp)
180003781:     	movq	%rdi, 0x160(%rsp)
180003789:     	movq	%rsi, 0x168(%rsp)
180003791:     	movq	0x210(%rsp), %r15
180003799:     	movq	0x218(%rsp), %rax
1800037a1:     	movq	%rax, 0x148(%rsp)
1800037a9:     	movq	0x220(%rsp), %rax
1800037b1:     	movq	%rax, 0x140(%rsp)
1800037b9:     	movq	0x230(%rsp), %rax
1800037c1:     	movq	%rax, 0x138(%rsp)
1800037c9:     	movq	0x238(%rsp), %rdi
1800037d1:     	movq	0x240(%rsp), %rsi
1800037d9:     	movq	0x1e8(%rsp), %rcx
1800037e1:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
1800037e6:     	testq	%rax, %rax
1800037e9:     	movq	%rbx, 0x128(%rsp)
1800037f1:     	movq	%r12, 0x120(%rsp)
1800037f9:     	movq	%rbp, 0x170(%rsp)
180003801:     	je	0x180003bc6 <.text+0x2bc6>
180003807:     	movq	%rax, %r13
18000380a:     	movq	%rax, %rcx
18000380d:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
180003812:     	movq	%rax, %r12
180003815:     	movq	%r13, %rcx
180003818:     	callq	0x18000d503 <numba_list_iter_next+0x323>
18000381d:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003822:     	testq	%rax, %rax
180003825:     	jne	0x180003bfc <.text+0x2bfc>
18000382b:     	movq	0x1e0(%rsp), %rcx
180003833:     	callq	0x18000d50f <numba_list_iter_next+0x32f>
180003838:     	movq	%rax, %rbx
18000383b:     	movq	%rax, %rcx
18000383e:     	callq	0x18000d515 <numba_list_iter_next+0x335>
180003843:     	movaps	%xmm0, %xmm6
180003846:     	movq	%rbx, %rcx
180003849:     	callq	0x18000d503 <numba_list_iter_next+0x323>
18000384e:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003853:     	testq	%rax, %rax
180003856:     	jne	0x180003bfc <.text+0x2bfc>
18000385c:     	movq	0x1d8(%rsp), %rcx
180003864:     	callq	0x18000d50f <numba_list_iter_next+0x32f>
180003869:     	movq	%rax, %rbx
18000386c:     	movq	%rax, %rcx
18000386f:     	callq	0x18000d515 <numba_list_iter_next+0x335>
180003874:     	movaps	%xmm0, %xmm7
180003877:     	movq	%rbx, %rcx
18000387a:     	callq	0x18000d503 <numba_list_iter_next+0x323>
18000387f:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003884:     	testq	%rax, %rax
180003887:     	jne	0x180003bfc <.text+0x2bfc>
18000388d:     	movq	0x1d0(%rsp), %rcx
180003895:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
18000389a:     	testq	%rax, %rax
18000389d:     	je	0x180003bd9 <.text+0x2bd9>
1800038a3:     	movq	%rax, %rbp
1800038a6:     	movq	%rax, %rcx
1800038a9:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
1800038ae:     	movq	%rax, %r13
1800038b1:     	movq	%rbp, %rcx
1800038b4:     	callq	0x18000d503 <numba_list_iter_next+0x323>
1800038b9:     	callq	0x18000d509 <numba_list_iter_next+0x329>
1800038be:     	testq	%rax, %rax
1800038c1:     	jne	0x180003bfc <.text+0x2bfc>
1800038c7:     	movq	0x1c8(%rsp), %rcx
1800038cf:     	callq	0x18000d4f7 <numba_list_iter_next+0x317>
1800038d4:     	testq	%rax, %rax
1800038d7:     	je	0x180003bec <.text+0x2bec>
1800038dd:     	movq	%rax, %rbx
1800038e0:     	movq	%rax, %rcx
1800038e3:     	callq	0x18000d4fd <numba_list_iter_next+0x31d>
1800038e8:     	movq	%rax, %rbp
1800038eb:     	movq	%rbx, %rcx
1800038ee:     	callq	0x18000d503 <numba_list_iter_next+0x323>
1800038f3:     	callq	0x18000d509 <numba_list_iter_next+0x329>
1800038f8:     	testq	%rax, %rax
1800038fb:     	jne	0x180003bfc <.text+0x2bfc>
180003901:     	movq	%rbp, 0x110(%rsp)
180003909:     	movq	%r13, 0x108(%rsp)
180003911:     	movq	%r12, 0xf0(%rsp)
180003919:     	movq	%rsi, 0xe8(%rsp)
180003921:     	movq	%rdi, 0xe0(%rsp)
180003929:     	movq	0x138(%rsp), %rax
180003931:     	movq	%rax, 0xd8(%rsp)
180003939:     	movq	0x140(%rsp), %rax
180003941:     	movq	%rax, 0xc8(%rsp)
180003949:     	movq	0x148(%rsp), %rax
180003951:     	movq	%rax, 0xc0(%rsp)
180003959:     	movq	0x178(%rsp), %rax
180003961:     	movq	%rax, 0xb0(%rsp)
180003969:     	movq	0x180(%rsp), %rax
180003971:     	movq	%rax, 0xa8(%rsp)
180003979:     	movq	0x188(%rsp), %rax
180003981:     	movq	%rax, 0xa0(%rsp)
180003989:     	movq	0x190(%rsp), %rax
180003991:     	movq	%rax, 0x90(%rsp)
180003999:     	movq	0x198(%rsp), %rax
1800039a1:     	movq	%rax, 0x88(%rsp)
1800039a9:     	movq	0x1a8(%rsp), %rax
1800039b1:     	movq	%rax, 0x78(%rsp)
1800039b6:     	movq	0x1b0(%rsp), %rax
1800039be:     	movq	%rax, 0x70(%rsp)
1800039c3:     	movq	0x1b8(%rsp), %rax
1800039cb:     	movq	%rax, 0x68(%rsp)
1800039d0:     	movq	0x1c0(%rsp), %rax
1800039d8:     	movq	%rax, 0x58(%rsp)
1800039dd:     	movq	0x1a0(%rsp), %rax
1800039e5:     	movq	%rax, 0x50(%rsp)
1800039ea:     	movq	0x150(%rsp), %rax
1800039f2:     	movq	%rax, 0x40(%rsp)
1800039f7:     	movq	0x158(%rsp), %rax
1800039ff:     	movq	%rax, 0x38(%rsp)
180003a04:     	movsd	%xmm7, 0x100(%rsp)
180003a0d:     	movsd	%xmm6, 0xf8(%rsp)
180003a16:     	movq	%r15, 0xb8(%rsp)
180003a1e:     	movq	%r14, 0x80(%rsp)
180003a26:     	movq	0x120(%rsp), %rdi
180003a2e:     	movq	%rdi, 0x48(%rsp)
180003a33:     	movq	0x160(%rsp), %rax
180003a3b:     	movq	%rax, 0x30(%rsp)
180003a40:     	movq	0x168(%rsp), %rax
180003a48:     	movq	%rax, 0x20(%rsp)
180003a4d:     	movq	$0x1, 0xd0(%rsp)
180003a59:     	movq	$0x8, 0x98(%rsp)
180003a65:     	movq	$0x8, 0x60(%rsp)
180003a6e:     	movq	$0x8, 0x28(%rsp)
180003a77:     	leaq	0x308(%rsp), %rcx
180003a7f:     	leaq	0x130(%rsp), %rdx
180003a87:     	movq	0x170(%rsp), %r9
180003a8f:     	movq	0x128(%rsp), %rsi
180003a97:     	movq	%rsi, %r8
180003a9a:     	callq	0x180002890 <.text+0x1890>
180003a9f:     	movl	%eax, %ebp
180003aa1:     	movq	0x130(%rsp), %rbx
180003aa9:     	movq	%rsi, %rcx
180003aac:     	callq	0x180001060 <.text+0x60>
180003ab1:     	movq	%rdi, %rcx
180003ab4:     	callq	0x180001060 <.text+0x60>
180003ab9:     	movq	%r14, %rcx
180003abc:     	callq	0x180001060 <.text+0x60>
180003ac1:     	movq	%r15, %rcx
180003ac4:     	callq	0x180001060 <.text+0x60>
180003ac9:     	testl	%ebp, %ebp
180003acb:     	jne	0x180003b03 <.text+0x2b03>
180003acd:     	movq	0xb7fc(%rip), %rsi      # 0x18000f2d0
180003ad4:     	movq	%rsi, %rcx
180003ad7:     	callq	0x18000d51b <numba_list_iter_next+0x33b>
180003adc:     	movq	%rsi, %rax
180003adf:     	movaps	0x310(%rsp), %xmm6
180003ae7:     	movaps	0x320(%rsp), %xmm7
180003aef:     	addq	$0x338, %rsp            # imm = 0x338
180003af6:     	popq	%rbx
180003af7:     	popq	%rbp
180003af8:     	popq	%rdi
180003af9:     	popq	%rsi
180003afa:     	popq	%r12
180003afc:     	popq	%r13
180003afe:     	popq	%r14
180003b00:     	popq	%r15
180003b02:     	retq
180003b03:     	jle	0x180003c33 <.text+0x2c33>
180003b09:     	callq	0x18000d521 <numba_list_iter_next+0x341>
180003b0e:     	movl	0x8(%rbx), %edx
180003b11:     	movq	(%rbx), %rcx
180003b14:     	cmpl	$0x0, 0x20(%rbx)
180003b18:     	jle	0x180003c52 <.text+0x2c52>
180003b1e:     	movslq	%edx, %rdx
180003b21:     	callq	0x18000d527 <numba_list_iter_next+0x347>
180003b26:     	movq	%rax, %rsi
180003b29:     	movq	0x10(%rbx), %rcx
180003b2d:     	callq	*0x18(%rbx)
180003b30:     	testq	%rax, %rax
180003b33:     	je	0x180003c7b <.text+0x2c7b>
180003b39:     	movq	%rsi, %rcx
180003b3c:     	movq	%rax, %rdx
180003b3f:     	callq	0x18000b9c0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79e0>
180003b44:     	movq	%rax, %rsi
180003b47:     	movq	%rbx, %rcx
180003b4a:     	callq	0x18000d450 <numba_list_iter_next+0x270>
180003b4f:     	jmp	0x180003c5e <.text+0x2c5e>
180003b54:     	movq	0xb755(%rip), %rcx      # 0x18000f2b0
180003b5b:     	leaq	0xbbee(%rip), %rdx      # 0x18000f750
180003b62:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003b67:     	jmp	0x180003c2c <.text+0x2c2c>
180003b6c:     	movq	0xb72d(%rip), %rcx      # 0x18000f2a0
180003b73:     	leaq	0xbcd6(%rip), %rdx      # 0x18000f850
180003b7a:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003b7f:     	jmp	0x180003c2c <.text+0x2c2c>
180003b84:     	movq	0xb715(%rip), %rcx      # 0x18000f2a0
180003b8b:     	leaq	0xbcbe(%rip), %rdx      # 0x18000f850
180003b92:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003b97:     	jmp	0x180003c24 <.text+0x2c24>
180003b9c:     	movq	0xb6fd(%rip), %rcx      # 0x18000f2a0
180003ba3:     	leaq	0xbca6(%rip), %rdx      # 0x18000f850
180003baa:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003baf:     	jmp	0x180003c1c <.text+0x2c1c>
180003bb1:     	movq	0xb6e8(%rip), %rcx      # 0x18000f2a0
180003bb8:     	leaq	0xbc91(%rip), %rdx      # 0x18000f850
180003bbf:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003bc4:     	jmp	0x180003c14 <.text+0x2c14>
180003bc6:     	xorl	%r12d, %r12d
180003bc9:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003bce:     	testq	%rax, %rax
180003bd1:     	je	0x18000382b <.text+0x282b>
180003bd7:     	jmp	0x180003bfc <.text+0x2bfc>
180003bd9:     	xorl	%r13d, %r13d
180003bdc:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003be1:     	testq	%rax, %rax
180003be4:     	je	0x1800038c7 <.text+0x28c7>
180003bea:     	jmp	0x180003bfc <.text+0x2bfc>
180003bec:     	xorl	%ebp, %ebp
180003bee:     	callq	0x18000d509 <numba_list_iter_next+0x329>
180003bf3:     	testq	%rax, %rax
180003bf6:     	je	0x180003901 <.text+0x2901>
180003bfc:     	movq	%r15, %rcx
180003bff:     	callq	0x180001060 <.text+0x60>
180003c04:     	movq	0x128(%rsp), %rbx
180003c0c:     	movq	0x120(%rsp), %r12
180003c14:     	movq	%r14, %rcx
180003c17:     	callq	0x180001060 <.text+0x60>
180003c1c:     	movq	%r12, %rcx
180003c1f:     	callq	0x180001060 <.text+0x60>
180003c24:     	movq	%rbx, %rcx
180003c27:     	callq	0x180001060 <.text+0x60>
180003c2c:     	xorl	%esi, %esi
180003c2e:     	jmp	0x180003adc <.text+0x2adc>
180003c33:     	cmpl	$-0x3, %ebp
180003c36:     	je	0x180003c6d <.text+0x2c6d>
180003c38:     	cmpl	$-0x1, %ebp
180003c3b:     	je	0x180003c2c <.text+0x2c2c>
180003c3d:     	movq	0xb654(%rip), %rcx      # 0x18000f298
180003c44:     	leaq	0xbca5(%rip), %rdx      # 0x18000f8f0
180003c4b:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003c50:     	jmp	0x180003c2c <.text+0x2c2c>
180003c52:     	movq	0x10(%rbx), %r8
180003c56:     	callq	0x18000b8e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7900>
180003c5b:     	movq	%rax, %rsi
180003c5e:     	testq	%rsi, %rsi
180003c61:     	je	0x180003c2c <.text+0x2c2c>
180003c63:     	movq	%rsi, %rcx
180003c66:     	callq	0x18000b480 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x74a0>
180003c6b:     	jmp	0x180003c2c <.text+0x2c2c>
180003c6d:     	movq	0xb61c(%rip), %rcx      # 0x18000f290
180003c74:     	callq	0x18000d533 <numba_list_iter_next+0x353>
180003c79:     	jmp	0x180003c2c <.text+0x2c2c>
180003c7b:     	movq	0xb62e(%rip), %rcx      # 0x18000f2b0
180003c82:     	leaq	0xbc27(%rip), %rdx      # 0x18000f8b0
180003c89:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003c8e:     	jmp	0x180003c2c <.text+0x2c2c>
180003c90:     	pushq	%r15
180003c92:     	pushq	%r14
180003c94:     	pushq	%r13
180003c96:     	pushq	%r12
180003c98:     	pushq	%rsi
180003c99:     	pushq	%rdi
180003c9a:     	pushq	%rbp
180003c9b:     	pushq	%rbx
180003c9c:     	subq	$0x148, %rsp            # imm = 0x148
180003ca3:     	movq	%r9, %r12
180003ca6:     	movq	%r8, %r13
180003ca9:     	movq	%rdx, 0x140(%rsp)
180003cb1:     	movq	%rcx, 0x138(%rsp)
180003cb9:     	movsd	0x278(%rsp), %xmm0
180003cc2:     	movsd	0x280(%rsp), %xmm1
180003ccb:     	movq	$0x0, 0x130(%rsp)
180003cd7:     	movq	$0x0, 0x128(%rsp)
180003ce3:     	movq	0x220(%rsp), %rbp
180003ceb:     	movq	0x228(%rsp), %r15
180003cf3:     	movq	0x230(%rsp), %r14
180003cfb:     	movq	0x238(%rsp), %rbx
180003d03:     	movq	0x240(%rsp), %rdi
180003d0b:     	movq	0x248(%rsp), %rsi
180003d13:     	movq	0x250(%rsp), %r11
180003d1b:     	movq	0x258(%rsp), %r10
180003d23:     	movq	0x260(%rsp), %r9
180003d2b:     	movq	0x268(%rsp), %r8
180003d33:     	movq	0x270(%rsp), %rdx
180003d3b:     	movq	0x288(%rsp), %rcx
180003d43:     	movq	0x290(%rsp), %rax
180003d4b:     	movq	%rax, 0x110(%rsp)
180003d53:     	movq	%rcx, 0x108(%rsp)
180003d5b:     	movq	%rdx, 0xf0(%rsp)
180003d63:     	movq	%r8, 0xe8(%rsp)
180003d6b:     	movq	%r9, 0xe0(%rsp)
180003d73:     	movq	%r10, 0xd8(%rsp)
180003d7b:     	movq	%r11, 0xd0(%rsp)
180003d83:     	movq	%rsi, 0xc8(%rsp)
180003d8b:     	movq	%rdi, 0xc0(%rsp)
180003d93:     	movq	%rbx, 0xb8(%rsp)
180003d9b:     	movq	%r14, 0xb0(%rsp)
180003da3:     	movq	%r15, 0xa8(%rsp)
180003dab:     	movq	%rbp, 0xa0(%rsp)
180003db3:     	movq	0x218(%rsp), %rax
180003dbb:     	movq	%rax, 0x98(%rsp)
180003dc3:     	movq	0x210(%rsp), %rax
180003dcb:     	movq	%rax, 0x90(%rsp)
180003dd3:     	movq	0x208(%rsp), %rax
180003ddb:     	movq	%rax, 0x88(%rsp)
180003de3:     	movq	0x200(%rsp), %rax
180003deb:     	movq	%rax, 0x80(%rsp)
180003df3:     	movq	0x1f8(%rsp), %rax
180003dfb:     	movq	%rax, 0x78(%rsp)
180003e00:     	movq	0x1f0(%rsp), %rax
180003e08:     	movq	%rax, 0x70(%rsp)
180003e0d:     	movq	0x1e8(%rsp), %rax
180003e15:     	movq	%rax, 0x68(%rsp)
180003e1a:     	movq	0x1e0(%rsp), %rax
180003e22:     	movq	%rax, 0x60(%rsp)
180003e27:     	movq	0x1d8(%rsp), %rax
180003e2f:     	movq	%rax, 0x58(%rsp)
180003e34:     	movq	0x1d0(%rsp), %rax
180003e3c:     	movq	%rax, 0x50(%rsp)
180003e41:     	movq	0x1c8(%rsp), %rax
180003e49:     	movq	%rax, 0x48(%rsp)
180003e4e:     	movq	0x1c0(%rsp), %rax
180003e56:     	movq	%rax, 0x40(%rsp)
180003e5b:     	movq	0x1b8(%rsp), %rax
180003e63:     	movq	%rax, 0x38(%rsp)
180003e68:     	movq	0x1b0(%rsp), %rax
180003e70:     	movq	%rax, 0x30(%rsp)
180003e75:     	movsd	%xmm1, 0x100(%rsp)
180003e7e:     	movsd	%xmm0, 0xf8(%rsp)
180003e87:     	movq	%r12, 0x28(%rsp)
180003e8c:     	movq	%r13, 0x20(%rsp)
180003e91:     	leaq	0x130(%rsp), %rcx
180003e99:     	leaq	0x128(%rsp), %rdx
180003ea1:     	movq	0x138(%rsp), %r8
180003ea9:     	movq	0x140(%rsp), %r9
180003eb1:     	callq	0x180002890 <.text+0x1890>
180003eb6:     	movl	%eax, %edx
180003eb8:     	movq	0x128(%rsp), %rsi
180003ec0:     	movq	0x130(%rsp), %rax
180003ec8:     	movl	$0x0, 0x124(%rsp)
180003ed3:     	testl	%edx, %edx
180003ed5:     	jne	0x180003eeb <.text+0x2eeb>
180003ed7:     	addq	$0x148, %rsp            # imm = 0x148
180003ede:     	popq	%rbx
180003edf:     	popq	%rbp
180003ee0:     	popq	%rdi
180003ee1:     	popq	%rsi
180003ee2:     	popq	%r12
180003ee4:     	popq	%r13
180003ee6:     	popq	%r14
180003ee8:     	popq	%r15
180003eea:     	retq
180003eeb:     	movq	%rax, %rbx
180003eee:     	leaq	0x124(%rsp), %rcx
180003ef6:     	movl	%edx, %edi
180003ef8:     	callq	0x18000b450 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7470>
180003efd:     	testl	%edi, %edi
180003eff:     	jle	0x180003f45 <.text+0x2f45>
180003f01:     	callq	0x18000d521 <numba_list_iter_next+0x341>
180003f06:     	movl	0x8(%rsi), %edx
180003f09:     	movq	(%rsi), %rcx
180003f0c:     	cmpl	$0x0, 0x20(%rsi)
180003f10:     	jle	0x180003f66 <.text+0x2f66>
180003f12:     	movslq	%edx, %rdx
180003f15:     	callq	0x18000d527 <numba_list_iter_next+0x347>
180003f1a:     	movq	%rax, %rdi
180003f1d:     	movq	0x10(%rsi), %rcx
180003f21:     	callq	*0x18(%rsi)
180003f24:     	testq	%rax, %rax
180003f27:     	je	0x180003fc1 <.text+0x2fc1>
180003f2d:     	movq	%rdi, %rcx
180003f30:     	movq	%rax, %rdx
180003f33:     	callq	0x18000b9c0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79e0>
180003f38:     	movq	%rax, %rdi
180003f3b:     	movq	%rsi, %rcx
180003f3e:     	callq	0x18000d450 <numba_list_iter_next+0x270>
180003f43:     	jmp	0x180003f72 <.text+0x2f72>
180003f45:     	movl	%edi, %eax
180003f47:     	cmpl	$-0x3, %edi
180003f4a:     	je	0x180003fb3 <.text+0x2fb3>
180003f4c:     	cmpl	$-0x1, %eax
180003f4f:     	je	0x180003f7f <.text+0x2f7f>
180003f51:     	movq	0xb340(%rip), %rcx      # 0x18000f298
180003f58:     	leaq	0xba01(%rip), %rdx      # 0x18000f960
180003f5f:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003f64:     	jmp	0x180003f7f <.text+0x2f7f>
180003f66:     	movq	0x10(%rsi), %r8
180003f6a:     	callq	0x18000b8e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7900>
180003f6f:     	movq	%rax, %rdi
180003f72:     	testq	%rdi, %rdi
180003f75:     	je	0x180003f7f <.text+0x2f7f>
180003f77:     	movq	%rdi, %rcx
180003f7a:     	callq	0x18000b480 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x74a0>
180003f7f:     	leaq	0xba0a(%rip), %rcx      # 0x18000f990
180003f86:     	callq	0x18000d539 <numba_list_iter_next+0x359>
180003f8b:     	movq	%rax, %rsi
180003f8e:     	movq	%rax, %rcx
180003f91:     	callq	0x18000d53f <numba_list_iter_next+0x35f>
180003f96:     	movq	%rsi, %rcx
180003f99:     	callq	0x18000d503 <numba_list_iter_next+0x323>
180003f9e:     	leaq	0x124(%rsp), %rcx
180003fa6:     	callq	0x18000b470 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7490>
180003fab:     	movq	%rbx, %rax
180003fae:     	jmp	0x180003ed7 <.text+0x2ed7>
180003fb3:     	movq	0xb2d6(%rip), %rcx      # 0x18000f290
180003fba:     	callq	0x18000d533 <numba_list_iter_next+0x353>
180003fbf:     	jmp	0x180003f7f <.text+0x2f7f>
180003fc1:     	movq	0xb2e8(%rip), %rcx      # 0x18000f2b0
180003fc8:     	leaq	0xb951(%rip), %rdx      # 0x18000f920
180003fcf:     	callq	0x18000d52d <numba_list_iter_next+0x34d>
180003fd4:     	xorl	%eax, %eax
180003fd6:     	jmp	0x180003ed7 <.text+0x2ed7>
180003fdb:     	nopl	(%rax,%rax)

0000000180003fe0 <PyInit_rcaotr_2c76336ff39711e0671e54df>:
180003fe0:     	pushq	%rsi
180003fe1:     	subq	$0x20, %rsp
180003fe5:     	leaq	0x12074(%rip), %rcx     # 0x180016060
180003fec:     	movl	$0x3f5, %edx            # imm = 0x3F5
180003ff1:     	callq	0x18000d545 <numba_list_iter_next+0x365>
180003ff6:     	testq	%rax, %rax
180003ff9:     	je	0x18000402b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4b>
180003ffb:     	leaq	0x11ffe(%rip), %rdx     # 0x180016000
180004002:     	leaq	0xb9f7(%rip), %r8       # 0x18000fa00
180004009:     	leaq	0xbae0(%rip), %r9       # 0x18000faf0
180004010:     	movq	%rax, %rcx
180004013:     	movq	%rax, %rsi
180004016:     	callq	0x18000c420 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8440>
18000401b:     	movl	%eax, %ecx
18000401d:     	xorl	%eax, %eax
18000401f:     	testl	%ecx, %ecx
180004021:     	cmoveq	%rsi, %rax
180004025:     	addq	$0x20, %rsp
180004029:     	popq	%rsi
18000402a:     	retq
18000402b:     	xorl	%eax, %eax
18000402d:     	addq	$0x20, %rsp
180004031:     	popq	%rsi
180004032:     	retq
180004033:     	nopw	%cs:(%rax,%rax)
18000403d:     	nopl	(%rax)
180004040:     	pushq	%r15
180004042:     	pushq	%r14
180004044:     	pushq	%r13
180004046:     	pushq	%r12
180004048:     	pushq	%rsi
180004049:     	pushq	%rdi
18000404a:     	pushq	%rbp
18000404b:     	pushq	%rbx
18000404c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180004053:     	movapd	%xmm8, 0x1d0(%rsp)
18000405d:     	movapd	%xmm7, 0x1c0(%rsp)
180004066:     	movapd	%xmm6, 0x1b0(%rsp)
18000406f:     	movq	0x320(%rsp), %rsi
180004077:     	movq	0x268(%rsp), %rdi
18000407f:     	movq	0x260(%rsp), %r12
180004087:     	movq	$0x0, 0x150(%rsp)
180004093:     	movb	$0x0, 0x158(%rsp)
18000409b:     	movq	$0x0, 0x160(%rsp)
1800040a7:     	movq	$0x0, 0x130(%rsp)
1800040b3:     	movb	$0x0, 0x138(%rsp)
1800040bb:     	movq	$0x0, 0x140(%rsp)
1800040c7:     	xorl	%eax, %eax
1800040c9:     	cmpq	$-0x9, %rsi
1800040cd:     	cmovlq	%rdi, %rax
1800040d1:     	leaq	(%r12,%rsi,8), %rdx
1800040d5:     	movsd	0x48(%rdx,%rax,8), %xmm0
1800040db:     	xorpd	%xmm1, %xmm1
1800040df:     	ucomisd	%xmm1, %xmm0
1800040e3:     	jne	0x1800040fc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11c>
1800040e5:     	jp	0x1800040fc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11c>
1800040e7:     	movb	$0x1, 0x18(%rcx)
1800040eb:     	movq	$0x0, 0x10(%rcx)
1800040f3:     	movb	$0x1, 0x8(%rcx)
1800040f7:     	jmp	0x180004448 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x468>
1800040fc:     	movq	0x328(%rsp), %r14
180004104:     	movq	0x2a0(%rsp), %r13
18000410c:     	movq	0x298(%rsp), %rbp
180004114:     	xorl	%eax, %eax
180004116:     	cmpq	$-0x6, %rsi
18000411a:     	cmovlq	%r13, %rax
18000411e:     	leaq	(%rbp,%rsi,8), %r11
180004123:     	movq	0x30(%r11,%rax,8), %rax
180004128:     	movq	%rax, %r10
18000412b:     	sarq	$0x3f, %r10
18000412f:     	andq	%r13, %r10
180004132:     	leaq	(%rbp,%rax,8), %rdx
180004137:     	cmpq	$0x1, (%rdx,%r10,8)
18000413c:     	jne	0x180004160 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x180>
18000413e:     	xorl	%r10d, %r10d
180004141:     	cmpq	$-0x2, %rax
180004145:     	cmovlq	%r13, %r10
180004149:     	movq	0x10(%rdx,%r10,8), %rax
18000414e:     	leaq	(%rbp,%rax,8), %rdx
180004153:     	sarq	$0x3f, %rax
180004157:     	andq	%r13, %rax
18000415a:     	cmpq	%r14, (%rdx,%rax,8)
18000415e:     	je	0x1800040e7 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x107>
180004160:     	movq	%r9, 0x128(%rsp)
180004168:     	xorl	%eax, %eax
18000416a:     	cmpq	$-0x2, %rsi
18000416e:     	movl	$0x0, %edx
180004173:     	cmovlq	%r13, %rdx
180004177:     	movq	%r11, 0x120(%rsp)
18000417f:     	movq	0x10(%r11,%rdx,8), %rdx
180004184:     	movq	%rdx, %r10
180004187:     	sarq	$0x3f, %r10
18000418b:     	andq	%rdi, %r10
18000418e:     	leaq	(%r12,%rdx,8), %r11
180004192:     	movsd	(%r11,%r10,8), %xmm1
180004198:     	cmpq	$-0x1, %rdx
18000419c:     	movl	$0x0, %esi
1800041a1:     	cmovlq	%r13, %rsi
1800041a5:     	leaq	(%rbp,%rdx,8), %r10
1800041aa:     	cmpq	$0x0, 0x8(%r10,%rsi,8)
1800041b0:     	setne	%sil
1800041b4:     	cmpq	$-0x2, %r14
1800041b8:     	movl	$0x0, %ebx
1800041bd:     	cmovlq	%r13, %rbx
1800041c1:     	leaq	(%rbp,%r14,8), %r15
1800041c6:     	movq	0x10(%r15,%rbx,8), %r14
1800041cb:     	movq	%r14, %rbx
1800041ce:     	sarq	$0x3f, %rbx
1800041d2:     	andq	%rdi, %rbx
1800041d5:     	cmpq	$-0x1, %r14
1800041d9:     	cmovlq	%r13, %rax
1800041dd:     	leaq	(%rbp,%r14,8), %r13
1800041e2:     	cmpq	$0x0, 0x8(%r13,%rax,8)
1800041e8:     	leaq	(%r12,%r14,8), %r15
1800041ec:     	subsd	(%r15,%rbx,8), %xmm1
1800041f2:     	setne	%al
1800041f5:     	andb	%sil, %al
1800041f8:     	movq	0x2d0(%rsp), %rdi
180004200:     	cmpb	$0x1, %al
180004202:     	jne	0x18000422b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24b>
180004204:     	movapd	0xb1b4(%rip), %xmm2     # 0x18000f3c0
18000420c:     	andpd	%xmm1, %xmm2
180004210:     	ucomisd	0xb1b8(%rip), %xmm2     # 0x18000f3d0
180004218:     	jae	0x180004325 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x345>
18000421e:     	movq	%r12, %r9
180004221:     	xorpd	%xmm2, %xmm2
180004225:     	addsd	%xmm2, %xmm1
180004229:     	jmp	0x18000422e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24e>
18000422b:     	movq	%r12, %r9
18000422e:     	xorl	%esi, %esi
180004230:     	cmpq	$-0x2, %rdx
180004234:     	movl	$0x0, %ebx
180004239:     	movq	0x268(%rsp), %r12
180004241:     	cmovlq	%r12, %rbx
180004245:     	movsd	0x10(%r11,%rbx,8), %xmm2
18000424c:     	cmpq	$-0x3, %rdx
180004250:     	movl	$0x0, %edx
180004255:     	movq	0x2a0(%rsp), %rbx
18000425d:     	cmovlq	%rbx, %rdx
180004261:     	cmpq	$-0x2, %r14
180004265:     	movl	$0x0, %r11d
18000426b:     	cmovlq	%r12, %r11
18000426f:     	cmpq	$-0x3, %r14
180004273:     	cmovlq	%rbx, %rsi
180004277:     	cmpq	$0x0, 0x18(%r10,%rdx,8)
18000427d:     	subsd	0x10(%r15,%r11,8), %xmm2
180004284:     	je	0x1800042f1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x311>
180004286:     	cmpq	$0x0, 0x18(%r13,%rsi,8)
18000428c:     	je	0x1800042f1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x311>
18000428e:     	movapd	0xb12a(%rip), %xmm3     # 0x18000f3c0
180004296:     	andpd	%xmm2, %xmm3
18000429a:     	ucomisd	0xb12e(%rip), %xmm3     # 0x18000f3d0
1800042a2:     	movq	%rdi, %rbx
1800042a5:     	jae	0x1800043a9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3c9>
1800042ab:     	movapd	%xmm1, %xmm3
1800042af:     	mulsd	%xmm1, %xmm3
1800042b3:     	ucomisd	0xb115(%rip), %xmm3     # 0x18000f3d0
1800042bb:     	setae	%dl
1800042be:     	testb	%dl, %al
1800042c0:     	jne	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042c2:     	xorpd	%xmm4, %xmm4
1800042c6:     	addsd	%xmm4, %xmm2
1800042ca:     	movapd	%xmm2, %xmm4
1800042ce:     	mulsd	%xmm2, %xmm4
1800042d2:     	ucomisd	0xb0f6(%rip), %xmm4     # 0x18000f3d0
1800042da:     	jae	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042dc:     	addsd	%xmm4, %xmm3
1800042e0:     	ucomisd	0xb0e8(%rip), %xmm3     # 0x18000f3d0
1800042e8:     	setae	%dl
1800042eb:     	testb	%dl, %al
1800042ed:     	jne	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042ef:     	jmp	0x180004349 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x369>
1800042f1:     	movapd	%xmm1, %xmm3
1800042f5:     	mulsd	%xmm1, %xmm3
1800042f9:     	ucomisd	0xb0cf(%rip), %xmm3     # 0x18000f3d0
180004301:     	setae	%dl
180004304:     	andb	%dl, %al
180004306:     	cmpb	$0x1, %al
180004308:     	movq	%rdi, %rbx
18000430b:     	jne	0x18000433d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x35d>
18000430d:     	movq	0x308(%rsp), %rax
180004315:     	movb	$0x1, (%rax)
180004318:     	movq	$0x3d090c, 0x18(%rbx)   # imm = 0x3D090C
180004320:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004325:     	movq	0x308(%rsp), %rax
18000432d:     	movb	$0x1, (%rax)
180004330:     	movq	$0x3d090a, 0x18(%rdi)   # imm = 0x3D090A
180004338:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000433d:     	movapd	%xmm2, %xmm4
180004341:     	mulsd	%xmm2, %xmm4
180004345:     	addsd	%xmm4, %xmm3
180004349:     	xorps	%xmm4, %xmm4
18000434c:     	sqrtsd	%xmm3, %xmm4
180004350:     	xorl	%eax, %eax
180004352:     	movq	0x320(%rsp), %rsi
18000435a:     	cmpq	$-0x3, %rsi
18000435e:     	movq	0x2a0(%rsp), %r12
180004366:     	cmovlq	%r12, %rax
18000436a:     	movq	0x120(%rsp), %r11
180004372:     	cmpq	$0x0, 0x18(%r11,%rax,8)
180004378:     	movq	0x268(%rsp), %rdi
180004380:     	movq	%r9, %r15
180004383:     	je	0x1800043fd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x41d>
180004385:     	xorpd	%xmm5, %xmm5
180004389:     	ucomisd	%xmm5, %xmm3
18000438d:     	jne	0x1800043be <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3de>
18000438f:     	jp	0x1800043be <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3de>
180004391:     	movq	0x308(%rsp), %rax
180004399:     	movb	$0x1, (%rax)
18000439c:     	movq	$0x3d090f, 0x18(%rbx)   # imm = 0x3D090F
1800043a4:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800043a9:     	movq	0x308(%rsp), %rax
1800043b1:     	movb	$0x1, (%rax)
1800043b4:     	movq	$0x3d090b, 0x18(%rbx)   # imm = 0x3D090B
1800043bc:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800043be:     	movsd	0x330(%rsp), %xmm6
1800043c7:     	movq	%rsi, %rax
1800043ca:     	sarq	$0x3f, %rax
1800043ce:     	andq	%r12, %rax
1800043d1:     	movq	(%r11,%rax,8), %rax
1800043d5:     	leaq	(%r15,%rax,8), %rdx
1800043d9:     	xorl	%r10d, %r10d
1800043dc:     	cmpq	$-0x1, %rax
1800043e0:     	cmovlq	%rdi, %r10
1800043e4:     	movsd	0x8(%rdx,%r10,8), %xmm3
1800043eb:     	addsd	%xmm3, %xmm3
1800043ef:     	divsd	%xmm4, %xmm3
1800043f3:     	ucomisd	%xmm3, %xmm6
1800043f7:     	jbe	0x1800044cd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4ed>
1800043fd:     	movsd	0xafd3(%rip), %xmm3     # 0x18000f3d8
180004405:     	maxsd	%xmm4, %xmm3
180004409:     	movapd	%xmm3, %xmm4
18000440d:     	mulsd	%xmm3, %xmm4
180004411:     	xorpd	%xmm5, %xmm5
180004415:     	ucomisd	%xmm5, %xmm4
180004419:     	jne	0x18000447e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49e>
18000441b:     	jp	0x18000447e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49e>
18000441d:     	movq	0x308(%rsp), %rax
180004425:     	movb	$0x1, (%rax)
180004428:     	movq	$0x3d0915, 0x18(%rbx)   # imm = 0x3D0915
180004430:     	movq	$0x0, 0x18(%rcx)
180004438:     	movq	$0x0, 0x10(%rcx)
180004440:     	movq	$0x0, 0x8(%rcx)
180004448:     	movq	$0x0, (%rcx)
18000444f:     	xorl	%eax, %eax
180004451:     	movaps	0x1b0(%rsp), %xmm6
180004459:     	movaps	0x1c0(%rsp), %xmm7
180004461:     	movaps	0x1d0(%rsp), %xmm8
18000446a:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180004471:     	popq	%rbx
180004472:     	popq	%rbp
180004473:     	popq	%rdi
180004474:     	popq	%rsi
180004475:     	popq	%r12
180004477:     	popq	%r13
180004479:     	popq	%r14
18000447b:     	popq	%r15
18000447d:     	retq
18000447e:     	movq	0x328(%rsp), %r8
180004486:     	leaq	(%r15,%r8,8), %rax
18000448a:     	xorl	%edx, %edx
18000448c:     	cmpq	$-0x1, %r8
180004490:     	cmovlq	%rdi, %rdx
180004494:     	movsd	0x8(%rax,%rdx,8), %xmm5
18000449a:     	mulsd	0xaf3e(%rip), %xmm5     # 0x18000f3e0
1800044a2:     	mulsd	%xmm5, %xmm0
1800044a6:     	divsd	%xmm4, %xmm0
1800044aa:     	mulsd	%xmm0, %xmm1
1800044ae:     	divsd	%xmm3, %xmm1
1800044b2:     	mulsd	%xmm0, %xmm2
1800044b6:     	divsd	%xmm3, %xmm2
1800044ba:     	movsd	%xmm2, 0x10(%rcx)
1800044bf:     	movsd	%xmm1, (%rcx)
1800044c3:     	movb	$0x0, 0x18(%rcx)
1800044c7:     	movb	$0x0, 0x8(%rcx)
1800044cb:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
1800044cd:     	movq	0x2c0(%rsp), %rdx
1800044d5:     	movq	0x2b8(%rsp), %rbp
1800044dd:     	movq	0x2b0(%rsp), %r14
1800044e5:     	movq	0x2a8(%rsp), %r9
1800044ed:     	movq	0x290(%rsp), %r13
1800044f5:     	xorl	%eax, %eax
1800044f7:     	cmpq	$-0x4, %rsi
1800044fb:     	cmovlq	%r12, %rax
1800044ff:     	movq	0x20(%r11,%rax,8), %rax
180004504:     	testq	%rax, %rax
180004507:     	movb	$0x1, %r10b
18000450a:     	movl	%r10d, 0x10c(%rsp)
180004512:     	js	0x1800046f2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x712>
180004518:     	movq	0x8(%rbx), %rdx
18000451c:     	leaq	0x1(%rdx), %r10
180004520:     	movq	%r10, 0x8(%rbx)
180004524:     	cmpq	0x10(%rbx), %rdx
180004528:     	movq	0x298(%rsp), %rdx
180004530:     	jge	0x180004943 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x963>
180004536:     	movq	%r14, %r10
180004539:     	movq	%rbx, %r14
18000453c:     	movq	%rcx, %rbx
18000453f:     	movsd	%xmm6, 0x100(%rsp)
180004548:     	movq	0x328(%rsp), %rcx
180004550:     	movq	%rcx, 0xf8(%rsp)
180004558:     	movq	%rax, 0xf0(%rsp)
180004560:     	movq	0x318(%rsp), %rax
180004568:     	movq	%rax, 0xe8(%rsp)
180004570:     	movq	0x310(%rsp), %rax
180004578:     	movq	%rax, 0xe0(%rsp)
180004580:     	movq	0x308(%rsp), %rsi
180004588:     	movq	%rsi, 0xd8(%rsp)
180004590:     	movq	0x300(%rsp), %rax
180004598:     	movq	%rax, 0xd0(%rsp)
1800045a0:     	movq	0x2f8(%rsp), %rax
1800045a8:     	movq	%rax, 0xc8(%rsp)
1800045b0:     	movq	0x2f0(%rsp), %rax
1800045b8:     	movq	%rax, 0xc0(%rsp)
1800045c0:     	movq	0x2e8(%rsp), %rax
1800045c8:     	movq	%rax, 0xb8(%rsp)
1800045d0:     	movq	0x2e0(%rsp), %rax
1800045d8:     	movq	%rax, 0xb0(%rsp)
1800045e0:     	movq	0x2d8(%rsp), %rax
1800045e8:     	movq	%rax, 0xa8(%rsp)
1800045f0:     	movq	%r14, 0xa0(%rsp)
1800045f8:     	movq	0x2c8(%rsp), %rax
180004600:     	movq	%rax, 0x98(%rsp)
180004608:     	movq	0x2c0(%rsp), %rax
180004610:     	movq	%rax, 0x90(%rsp)
180004618:     	movq	%rbp, 0x88(%rsp)
180004620:     	movq	%r10, %rbp
180004623:     	movq	%r10, 0x80(%rsp)
18000462b:     	movq	%r9, 0x78(%rsp)
180004630:     	movq	%r12, 0x70(%rsp)
180004635:     	movq	%rdx, 0x68(%rsp)
18000463a:     	movq	%r13, 0x60(%rsp)
18000463f:     	movq	0x288(%rsp), %rax
180004647:     	movq	%rax, 0x58(%rsp)
18000464c:     	movq	0x280(%rsp), %rax
180004654:     	movq	%rax, 0x50(%rsp)
180004659:     	movq	0x278(%rsp), %rax
180004661:     	movq	%rax, 0x48(%rsp)
180004666:     	movq	0x270(%rsp), %rax
18000466e:     	movq	%rax, 0x40(%rsp)
180004673:     	movq	%rdi, 0x38(%rsp)
180004678:     	movq	%r15, 0x30(%rsp)
18000467d:     	movq	0x258(%rsp), %rax
180004685:     	movq	%rax, 0x28(%rsp)
18000468a:     	movq	0x250(%rsp), %rax
180004692:     	movq	%rax, 0x20(%rsp)
180004697:     	leaq	0x190(%rsp), %rcx
18000469f:     	movq	%r8, 0x118(%rsp)
1800046a7:     	movq	0x128(%rsp), %r9
1800046af:     	movq	%rdx, %r12
1800046b2:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
1800046b7:     	movzbl	0x198(%rsp), %ecx
1800046bf:     	testb	%cl, %cl
1800046c1:     	setne	%r10b
1800046c5:     	cmpb	$0x0, (%rsi)
1800046c8:     	je	0x180004973 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x993>
1800046ce:     	movq	$0x0, 0x18(%rbx)
1800046d6:     	movq	$0x0, 0x10(%rbx)
1800046de:     	movq	$0x0, 0x8(%rbx)
1800046e6:     	movq	$0x0, (%rbx)
1800046ed:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
1800046f2:     	xorpd	%xmm7, %xmm7
1800046f6:     	movb	$0x1, %r10b
1800046f9:     	xorpd	%xmm8, %xmm8
1800046fe:     	movq	0x298(%rsp), %r9
180004706:     	xorl	%eax, %eax
180004708:     	cmpq	$-0x5, %rsi
18000470c:     	cmovlq	%r12, %rax
180004710:     	movq	0x28(%r11,%rax,8), %rax
180004715:     	testq	%rax, %rax
180004718:     	js	0x180004b50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb70>
18000471e:     	movl	%r10d, %ebp
180004721:     	movq	0x8(%rbx), %rdx
180004725:     	leaq	0x1(%rdx), %r10
180004729:     	movq	%r10, 0x8(%rbx)
18000472d:     	cmpq	0x10(%rbx), %rdx
180004731:     	jge	0x18000495b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x97b>
180004737:     	movq	%rcx, 0x110(%rsp)
18000473f:     	movsd	%xmm6, 0x100(%rsp)
180004748:     	movq	0x328(%rsp), %rcx
180004750:     	movq	%rcx, 0xf8(%rsp)
180004758:     	movq	%rax, 0xf0(%rsp)
180004760:     	movq	0x318(%rsp), %rax
180004768:     	movq	%rax, 0xe8(%rsp)
180004770:     	movq	0x310(%rsp), %rax
180004778:     	movq	%rax, 0xe0(%rsp)
180004780:     	movq	0x308(%rsp), %rsi
180004788:     	movq	%rsi, 0xd8(%rsp)
180004790:     	movq	0x300(%rsp), %rax
180004798:     	movq	%rax, 0xd0(%rsp)
1800047a0:     	movq	0x2f8(%rsp), %rax
1800047a8:     	movq	%rax, 0xc8(%rsp)
1800047b0:     	movq	0x2f0(%rsp), %rax
1800047b8:     	movq	%rax, 0xc0(%rsp)
1800047c0:     	movq	0x2e8(%rsp), %rax
1800047c8:     	movq	%rax, 0xb8(%rsp)
1800047d0:     	movq	0x2e0(%rsp), %rax
1800047d8:     	movq	%rax, 0xb0(%rsp)
1800047e0:     	movq	0x2d8(%rsp), %rax
1800047e8:     	movq	%rax, 0xa8(%rsp)
1800047f0:     	movq	%rbx, 0xa0(%rsp)
1800047f8:     	movq	0x2c8(%rsp), %rax
180004800:     	movq	%rax, 0x98(%rsp)
180004808:     	movq	0x2c0(%rsp), %rax
180004810:     	movq	%rax, 0x90(%rsp)
180004818:     	movq	0x2b8(%rsp), %rax
180004820:     	movq	%rax, 0x88(%rsp)
180004828:     	movq	%r14, 0x80(%rsp)
180004830:     	movq	0x2a8(%rsp), %rax
180004838:     	movq	%rax, 0x78(%rsp)
18000483d:     	movq	%r12, 0x70(%rsp)
180004842:     	movq	%r9, 0x68(%rsp)
180004847:     	movq	%r13, 0x60(%rsp)
18000484c:     	movq	0x288(%rsp), %rax
180004854:     	movq	%rax, 0x58(%rsp)
180004859:     	movq	0x280(%rsp), %rax
180004861:     	movq	%rax, 0x50(%rsp)
180004866:     	movq	0x278(%rsp), %rax
18000486e:     	movq	%rax, 0x48(%rsp)
180004873:     	movq	0x270(%rsp), %rax
18000487b:     	movq	%rax, 0x40(%rsp)
180004880:     	movq	%rdi, 0x38(%rsp)
180004885:     	movq	%r15, 0x30(%rsp)
18000488a:     	movq	0x258(%rsp), %rax
180004892:     	movq	%rax, 0x28(%rsp)
180004897:     	movq	0x250(%rsp), %rax
18000489f:     	movq	%rax, 0x20(%rsp)
1800048a4:     	leaq	0x170(%rsp), %rcx
1800048ac:     	movq	%r8, 0x118(%rsp)
1800048b4:     	movq	%r9, %r14
1800048b7:     	movq	0x128(%rsp), %r9
1800048bf:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
1800048c4:     	cmpb	$0x0, (%rsi)
1800048c7:     	jne	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
1800048cd:     	movq	%r14, %r9
1800048d0:     	movsd	0x180(%rsp), %xmm0
1800048d9:     	movzbl	0x188(%rsp), %eax
1800048e1:     	cmpb	$0x0, 0x178(%rsp)
1800048e9:     	setne	%cl
1800048ec:     	addsd	0x170(%rsp), %xmm7
1800048f5:     	decq	0x8(%rbx)
1800048f9:     	movl	%ebp, %r10d
1800048fc:     	andb	%cl, %r10b
1800048ff:     	cmpb	$0x1, %r10b
180004903:     	movq	0x110(%rsp), %rcx
18000490b:     	jne	0x180004a47 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xa67>
180004911:     	movapd	0xaaa7(%rip), %xmm1     # 0x18000f3c0
180004919:     	andpd	%xmm7, %xmm1
18000491d:     	ucomisd	0xaaab(%rip), %xmm1     # 0x18000f3d0
180004925:     	jb	0x180004a47 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xa67>
18000492b:     	movq	0x308(%rsp), %rax
180004933:     	movb	$0x1, (%rax)
180004936:     	movq	$0x3d0927, 0x18(%rbx)   # imm = 0x3D0927
18000493e:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004943:     	movq	0x308(%rsp), %rax
18000494b:     	movb	$0x1, (%rax)
18000494e:     	movq	$0x3d0921, 0x18(%rbx)   # imm = 0x3D0921
180004956:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000495b:     	movq	0x308(%rsp), %rax
180004963:     	movb	$0x1, (%rax)
180004966:     	movq	$0x3d0926, 0x18(%rbx)   # imm = 0x3D0926
18000496e:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004973:     	movq	%r12, %r9
180004976:     	movsd	0x1a0(%rsp), %xmm0
18000497f:     	movzbl	0x1a8(%rsp), %eax
180004987:     	movsd	0x190(%rsp), %xmm7
180004990:     	movq	%r14, %rdx
180004993:     	decq	0x8(%r14)
180004997:     	testb	%cl, %cl
180004999:     	movq	%rbx, %rcx
18000499c:     	je	0x1800049cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x9ec>
18000499e:     	movapd	0xaa1a(%rip), %xmm1     # 0x18000f3c0
1800049a6:     	andpd	%xmm7, %xmm1
1800049aa:     	ucomisd	0xaa1e(%rip), %xmm1     # 0x18000f3d0
1800049b2:     	jb	0x1800049cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x9ec>
1800049b4:     	movq	0x308(%rsp), %rax
1800049bc:     	movb	$0x1, (%rax)
1800049bf:     	movq	$0x3d0922, 0x18(%rdx)   # imm = 0x3D0922
1800049c7:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800049cc:     	xorpd	%xmm8, %xmm8
1800049d1:     	addsd	%xmm8, %xmm7
1800049d6:     	testb	%al, %al
1800049d8:     	addsd	%xmm0, %xmm8
1800049dd:     	je	0x180004acf <PyInit_rcaotr_2c76336ff39711e0671e54df+0xaef>
1800049e3:     	andpd	0xa9d5(%rip), %xmm0     # 0x18000f3c0
1800049eb:     	ucomisd	0xa9dd(%rip), %xmm0     # 0x18000f3d0
1800049f3:     	movq	0x118(%rsp), %r8
1800049fb:     	movq	%rdx, %rbx
1800049fe:     	movq	0x2a0(%rsp), %r12
180004a06:     	movq	0x120(%rsp), %r11
180004a0e:     	movq	0x320(%rsp), %rsi
180004a16:     	movq	%rbp, %r14
180004a19:     	movq	0x2b8(%rsp), %rbp
180004a21:     	movq	0x2c0(%rsp), %rdx
180004a29:     	jb	0x180004706 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x726>
180004a2f:     	movq	0x308(%rsp), %rax
180004a37:     	movb	$0x1, (%rax)
180004a3a:     	movq	$0x3d0923, 0x18(%rbx)   # imm = 0x3D0923
180004a42:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004a47:     	addsd	%xmm0, %xmm8
180004a4c:     	testb	%al, %al
180004a4e:     	setne	%al
180004a51:     	movl	0x10c(%rsp), %edx
180004a58:     	andb	%al, %dl
180004a5a:     	cmpb	$0x1, %dl
180004a5d:     	jne	0x180004b15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb35>
180004a63:     	movapd	0xa955(%rip), %xmm0     # 0x18000f3c0
180004a6b:     	andpd	%xmm8, %xmm0
180004a70:     	movb	$0x1, %al
180004a72:     	movl	%eax, 0x10c(%rsp)
180004a79:     	ucomisd	0xa94f(%rip), %xmm0     # 0x18000f3d0
180004a81:     	movq	0x118(%rsp), %r8
180004a89:     	movq	0x120(%rsp), %r11
180004a91:     	movq	0x320(%rsp), %rsi
180004a99:     	movq	0x2b0(%rsp), %r14
180004aa1:     	movq	0x2b8(%rsp), %rbp
180004aa9:     	movq	0x2c0(%rsp), %rdx
180004ab1:     	jb	0x180004b50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb70>
180004ab7:     	movq	0x308(%rsp), %rax
180004abf:     	movb	$0x1, (%rax)
180004ac2:     	movq	$0x3d0928, 0x18(%rbx)   # imm = 0x3D0928
180004aca:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004acf:     	movl	$0x0, 0x10c(%rsp)
180004ada:     	movq	0x118(%rsp), %r8
180004ae2:     	movq	%rdx, %rbx
180004ae5:     	movq	0x2a0(%rsp), %r12
180004aed:     	movq	0x120(%rsp), %r11
180004af5:     	movq	0x320(%rsp), %rsi
180004afd:     	movq	%rbp, %r14
180004b00:     	movq	0x2b8(%rsp), %rbp
180004b08:     	movq	0x2c0(%rsp), %rdx
180004b10:     	jmp	0x180004706 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x726>
180004b15:     	movl	$0x0, 0x10c(%rsp)
180004b20:     	movq	0x118(%rsp), %r8
180004b28:     	movq	0x120(%rsp), %r11
180004b30:     	movq	0x320(%rsp), %rsi
180004b38:     	movq	0x2b0(%rsp), %r14
180004b40:     	movq	0x2b8(%rsp), %rbp
180004b48:     	movq	0x2c0(%rsp), %rdx
180004b50:     	xorl	%eax, %eax
180004b52:     	cmpq	$-0x7, %rsi
180004b56:     	cmovlq	%r12, %rax
180004b5a:     	movq	0x38(%r11,%rax,8), %rax
180004b5f:     	testq	%rax, %rax
180004b62:     	js	0x180004e5b <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe7b>
180004b68:     	movl	0x10c(%rsp), %r14d
180004b70:     	movl	%r10d, %ebp
180004b73:     	movq	0x8(%rbx), %rdx
180004b77:     	leaq	0x1(%rdx), %r10
180004b7b:     	movq	%r10, 0x8(%rbx)
180004b7f:     	cmpq	0x10(%rbx), %rdx
180004b83:     	jge	0x180004d4f <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd6f>
180004b89:     	movq	%rcx, 0x110(%rsp)
180004b91:     	movsd	%xmm6, 0x100(%rsp)
180004b9a:     	movq	0x328(%rsp), %rcx
180004ba2:     	movq	%rcx, 0xf8(%rsp)
180004baa:     	movq	%rax, 0xf0(%rsp)
180004bb2:     	movq	0x318(%rsp), %rax
180004bba:     	movq	%rax, 0xe8(%rsp)
180004bc2:     	movq	0x310(%rsp), %rax
180004bca:     	movq	%rax, 0xe0(%rsp)
180004bd2:     	movq	0x308(%rsp), %rsi
180004bda:     	movq	%rsi, 0xd8(%rsp)
180004be2:     	movq	0x300(%rsp), %rax
180004bea:     	movq	%rax, 0xd0(%rsp)
180004bf2:     	movq	0x2f8(%rsp), %rax
180004bfa:     	movq	%rax, 0xc8(%rsp)
180004c02:     	movq	0x2f0(%rsp), %rax
180004c0a:     	movq	%rax, 0xc0(%rsp)
180004c12:     	movq	0x2e8(%rsp), %rax
180004c1a:     	movq	%rax, 0xb8(%rsp)
180004c22:     	movq	0x2e0(%rsp), %rax
180004c2a:     	movq	%rax, 0xb0(%rsp)
180004c32:     	movq	0x2d8(%rsp), %rax
180004c3a:     	movq	%rax, 0xa8(%rsp)
180004c42:     	movq	%rbx, 0xa0(%rsp)
180004c4a:     	movq	0x2c8(%rsp), %rax
180004c52:     	movq	%rax, 0x98(%rsp)
180004c5a:     	movq	0x2c0(%rsp), %rax
180004c62:     	movq	%rax, 0x90(%rsp)
180004c6a:     	movq	0x2b8(%rsp), %rax
180004c72:     	movq	%rax, 0x88(%rsp)
180004c7a:     	movq	0x2b0(%rsp), %rax
180004c82:     	movq	%rax, 0x80(%rsp)
180004c8a:     	movq	0x2a8(%rsp), %rax
180004c92:     	movq	%rax, 0x78(%rsp)
180004c97:     	movq	%r12, 0x70(%rsp)
180004c9c:     	movq	%r9, %r12
180004c9f:     	movq	%r9, 0x68(%rsp)
180004ca4:     	movq	%r13, 0x60(%rsp)
180004ca9:     	movq	0x288(%rsp), %rax
180004cb1:     	movq	%rax, 0x58(%rsp)
180004cb6:     	movq	0x280(%rsp), %rax
180004cbe:     	movq	%rax, 0x50(%rsp)
180004cc3:     	movq	0x278(%rsp), %rax
180004ccb:     	movq	%rax, 0x48(%rsp)
180004cd0:     	movq	0x270(%rsp), %rax
180004cd8:     	movq	%rax, 0x40(%rsp)
180004cdd:     	movq	%rdi, 0x38(%rsp)
180004ce2:     	movq	%r15, 0x30(%rsp)
180004ce7:     	movq	0x258(%rsp), %rax
180004cef:     	movq	%rax, 0x28(%rsp)
180004cf4:     	movq	0x250(%rsp), %rax
180004cfc:     	movq	%rax, 0x20(%rsp)
180004d01:     	leaq	0x150(%rsp), %rcx
180004d09:     	movq	%r8, 0x118(%rsp)
180004d11:     	movq	0x128(%rsp), %r9
180004d19:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
180004d1e:     	cmpb	$0x0, (%rsi)
180004d21:     	je	0x180004d67 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd87>
180004d23:     	movq	0x110(%rsp), %rax
180004d2b:     	movq	$0x0, 0x18(%rax)
180004d33:     	movq	$0x0, 0x10(%rax)
180004d3b:     	movq	$0x0, 0x8(%rax)
180004d43:     	movq	$0x0, (%rax)
180004d4a:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180004d4f:     	movq	0x308(%rsp), %rax
180004d57:     	movb	$0x1, (%rax)
180004d5a:     	movq	$0x3d092b, 0x18(%rbx)   # imm = 0x3D092B
180004d62:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004d67:     	movsd	0x160(%rsp), %xmm0
180004d70:     	movzbl	0x168(%rsp), %eax
180004d78:     	cmpb	$0x0, 0x158(%rsp)
180004d80:     	setne	%cl
180004d83:     	addsd	0x150(%rsp), %xmm7
180004d8c:     	decq	0x8(%rbx)
180004d90:     	andb	%cl, %bpl
180004d93:     	cmpb	$0x1, %bpl
180004d97:     	jne	0x180004dc0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xde0>
180004d99:     	movapd	0xa61f(%rip), %xmm1     # 0x18000f3c0
180004da1:     	andpd	%xmm7, %xmm1
180004da5:     	ucomisd	0xa623(%rip), %xmm1     # 0x18000f3d0
180004dad:     	jae	0x1800050f0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1110>
180004db3:     	movl	%ebp, %r10d
180004db6:     	xorpd	%xmm1, %xmm1
180004dba:     	addsd	%xmm1, %xmm7
180004dbe:     	jmp	0x180004dc3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xde3>
180004dc0:     	movl	%ebp, %r10d
180004dc3:     	addsd	%xmm0, %xmm8
180004dc8:     	testb	%al, %al
180004dca:     	setne	%al
180004dcd:     	andb	%al, %r14b
180004dd0:     	cmpb	$0x1, %r14b
180004dd4:     	jne	0x180004e05 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe25>
180004dd6:     	movapd	0xa5e2(%rip), %xmm0     # 0x18000f3c0
180004dde:     	andpd	%xmm8, %xmm0
180004de3:     	ucomisd	0xa5e5(%rip), %xmm0     # 0x18000f3d0
180004deb:     	jae	0x180005108 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1128>
180004df1:     	xorpd	%xmm0, %xmm0
180004df5:     	addsd	%xmm0, %xmm8
180004dfa:     	movb	$0x1, %al
180004dfc:     	movl	%eax, 0x10c(%rsp)
180004e03:     	jmp	0x180004e10 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe30>
180004e05:     	movl	$0x0, 0x10c(%rsp)
180004e10:     	movq	0x110(%rsp), %rcx
180004e18:     	movq	0x118(%rsp), %r8
180004e20:     	movq	0x268(%rsp), %rdi
180004e28:     	movq	%r12, %r9
180004e2b:     	movq	0x2a0(%rsp), %r12
180004e33:     	movq	0x120(%rsp), %r11
180004e3b:     	movq	0x320(%rsp), %rsi
180004e43:     	movq	0x2b0(%rsp), %r14
180004e4b:     	movq	0x2b8(%rsp), %rbp
180004e53:     	movq	0x2c0(%rsp), %rdx
180004e5b:     	xorl	%eax, %eax
180004e5d:     	cmpq	$-0x8, %rsi
180004e61:     	cmovlq	%r12, %rax
180004e65:     	movq	0x40(%r11,%rax,8), %rax
180004e6a:     	testq	%rax, %rax
180004e6d:     	js	0x180005133 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1153>
180004e73:     	movq	%rdx, %rsi
180004e76:     	movq	%r14, %r11
180004e79:     	movl	%r10d, %r14d
180004e7c:     	movq	0x8(%rbx), %rdx
180004e80:     	leaq	0x1(%rdx), %r10
180004e84:     	movq	%r10, 0x8(%rbx)
180004e88:     	cmpq	0x10(%rbx), %rdx
180004e8c:     	jge	0x180005035 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1055>
180004e92:     	movq	%rcx, 0x110(%rsp)
180004e9a:     	movq	0x328(%rsp), %rcx
180004ea2:     	movq	%rcx, 0xf8(%rsp)
180004eaa:     	movq	%rax, 0xf0(%rsp)
180004eb2:     	movq	0x318(%rsp), %rax
180004eba:     	movq	%rax, 0xe8(%rsp)
180004ec2:     	movq	0x310(%rsp), %rax
180004eca:     	movq	%rax, 0xe0(%rsp)
180004ed2:     	movq	0x300(%rsp), %rax
180004eda:     	movq	%rax, 0xd0(%rsp)
180004ee2:     	movq	0x2f8(%rsp), %rax
180004eea:     	movq	%rax, 0xc8(%rsp)
180004ef2:     	movq	0x2f0(%rsp), %rax
180004efa:     	movq	%rax, 0xc0(%rsp)
180004f02:     	movq	0x2e8(%rsp), %rax
180004f0a:     	movq	%rax, 0xb8(%rsp)
180004f12:     	movq	0x2e0(%rsp), %rax
180004f1a:     	movq	%rax, 0xb0(%rsp)
180004f22:     	movq	0x2d8(%rsp), %rax
180004f2a:     	movq	%rax, 0xa8(%rsp)
180004f32:     	movq	0x2c8(%rsp), %rax
180004f3a:     	movq	%rax, 0x98(%rsp)
180004f42:     	movq	%rsi, 0x90(%rsp)
180004f4a:     	movq	%rbp, 0x88(%rsp)
180004f52:     	movq	%r11, 0x80(%rsp)
180004f5a:     	movq	0x2a8(%rsp), %rax
180004f62:     	movq	%rax, 0x78(%rsp)
180004f67:     	movq	%r12, 0x70(%rsp)
180004f6c:     	movq	%r9, 0x68(%rsp)
180004f71:     	movq	%r13, 0x60(%rsp)
180004f76:     	movq	0x288(%rsp), %rax
180004f7e:     	movq	%rax, 0x58(%rsp)
180004f83:     	movq	0x280(%rsp), %rax
180004f8b:     	movq	%rax, 0x50(%rsp)
180004f90:     	movq	0x278(%rsp), %rax
180004f98:     	movq	%rax, 0x48(%rsp)
180004f9d:     	movq	0x270(%rsp), %rax
180004fa5:     	movq	%rax, 0x40(%rsp)
180004faa:     	movq	%rdi, 0x38(%rsp)
180004faf:     	movq	%r15, 0x30(%rsp)
180004fb4:     	movq	0x258(%rsp), %rax
180004fbc:     	movq	%rax, 0x28(%rsp)
180004fc1:     	movsd	%xmm6, 0x100(%rsp)
180004fca:     	movq	0x308(%rsp), %rdi
180004fd2:     	movq	%rdi, 0xd8(%rsp)
180004fda:     	movq	%rbx, 0xa0(%rsp)
180004fe2:     	movq	0x250(%rsp), %rax
180004fea:     	movq	%rax, 0x20(%rsp)
180004fef:     	leaq	0x130(%rsp), %rcx
180004ff7:     	movq	0x128(%rsp), %r9
180004fff:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
180005004:     	cmpb	$0x0, (%rdi)
180005007:     	je	0x18000504d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x106d>
180005009:     	movq	0x110(%rsp), %rsi
180005011:     	movq	$0x0, 0x18(%rsi)
180005019:     	movq	$0x0, 0x10(%rsi)
180005021:     	movq	$0x0, 0x8(%rsi)
180005029:     	movq	$0x0, (%rsi)
180005030:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180005035:     	movq	0x308(%rsp), %rax
18000503d:     	movb	$0x1, (%rax)
180005040:     	movq	$0x3d0930, 0x18(%rbx)   # imm = 0x3D0930
180005048:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000504d:     	movl	0x10c(%rsp), %ebp
180005054:     	movsd	0x140(%rsp), %xmm0
18000505d:     	movzbl	0x148(%rsp), %eax
180005065:     	cmpb	$0x0, 0x138(%rsp)
18000506d:     	setne	%cl
180005070:     	addsd	0x130(%rsp), %xmm7
180005079:     	movq	%rbx, %rdx
18000507c:     	decq	0x8(%rbx)
180005080:     	andb	%cl, %r14b
180005083:     	movl	%r14d, %r10d
180005086:     	cmpb	$0x1, %r14b
18000508a:     	jne	0x1800050ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x10ce>
18000508c:     	movapd	0xa32c(%rip), %xmm1     # 0x18000f3c0
180005094:     	andpd	%xmm7, %xmm1
180005098:     	ucomisd	0xa330(%rip), %xmm1     # 0x18000f3d0
1800050a0:     	jae	0x180005150 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1170>
1800050a6:     	xorpd	%xmm1, %xmm1
1800050aa:     	addsd	%xmm1, %xmm7
1800050ae:     	testb	%al, %al
1800050b0:     	setne	%al
1800050b3:     	addsd	%xmm0, %xmm8
1800050b8:     	andb	%al, %bpl
1800050bb:     	cmpb	$0x1, %bpl
1800050bf:     	jne	0x180005120 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1140>
1800050c1:     	movapd	0xa2f7(%rip), %xmm0     # 0x18000f3c0
1800050c9:     	andpd	%xmm8, %xmm0
1800050ce:     	ucomisd	0xa2fa(%rip), %xmm0     # 0x18000f3d0
1800050d6:     	jae	0x180005168 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1188>
1800050dc:     	xorpd	%xmm0, %xmm0
1800050e0:     	addsd	%xmm0, %xmm8
1800050e5:     	movb	$0x1, %al
1800050e7:     	movl	%eax, 0x10c(%rsp)
1800050ee:     	jmp	0x18000512b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x114b>
1800050f0:     	movq	0x308(%rsp), %rax
1800050f8:     	movb	$0x1, (%rax)
1800050fb:     	movq	$0x3d092c, 0x18(%rbx)   # imm = 0x3D092C
180005103:     	jmp	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
180005108:     	movq	0x308(%rsp), %rax
180005110:     	movb	$0x1, (%rax)
180005113:     	movq	$0x3d092d, 0x18(%rbx)   # imm = 0x3D092D
18000511b:     	jmp	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
180005120:     	movl	$0x0, 0x10c(%rsp)
18000512b:     	movq	0x110(%rsp), %rcx
180005133:     	movl	0x10c(%rsp), %eax
18000513a:     	movb	%al, 0x18(%rcx)
18000513d:     	movsd	%xmm8, 0x10(%rcx)
180005143:     	movb	%r10b, 0x8(%rcx)
180005147:     	movsd	%xmm7, (%rcx)
18000514b:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180005150:     	movq	0x308(%rsp), %rax
180005158:     	movb	$0x1, (%rax)
18000515b:     	movq	$0x3d0931, 0x18(%rdx)   # imm = 0x3D0931
180005163:     	jmp	0x180005009 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1029>
180005168:     	movq	0x308(%rsp), %rax
180005170:     	movb	$0x1, (%rax)
180005173:     	movq	$0x3d0932, 0x18(%rdx)   # imm = 0x3D0932
18000517b:     	jmp	0x180005009 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1029>
180005180:     	pushq	%r15
180005182:     	pushq	%r14
180005184:     	pushq	%r13
180005186:     	pushq	%r12
180005188:     	pushq	%rsi
180005189:     	pushq	%rdi
18000518a:     	pushq	%rbp
18000518b:     	pushq	%rbx
18000518c:     	subq	$0x178, %rsp            # imm = 0x178
180005193:     	movq	0x2b0(%rsp), %rax
18000519b:     	movq	0x298(%rsp), %rbp
1800051a3:     	movq	0x260(%rsp), %r11
1800051ab:     	movb	$0x0, 0x137(%rsp)
1800051b3:     	movb	$0x0, 0x11f(%rsp)
1800051bb:     	movb	$0x0, 0x11e(%rsp)
1800051c3:     	movb	$0x0, 0x11d(%rsp)
1800051cb:     	movb	$0x0, 0x11c(%rsp)
1800051d3:     	movb	$0x0, 0x136(%rsp)
1800051db:     	movb	$0x0, 0x135(%rsp)
1800051e3:     	movb	$0x0, 0x134(%rsp)
1800051eb:     	movb	$0x0, 0x133(%rsp)
1800051f3:     	cmpq	$0x1, %rax
1800051f7:     	movq	0x230(%rsp), %rbx
1800051ff:     	movq	0x228(%rsp), %r10
180005207:     	movq	0x1f8(%rsp), %r12
18000520f:     	movq	0x1f0(%rsp), %r14
180005217:     	je	0x1800055f0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1610>
18000521d:     	testq	%rax, %rax
180005220:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005226:     	movq	0x2c0(%rsp), %rsi
18000522e:     	movq	0x2b8(%rsp), %rbp
180005236:     	movq	%rbp, %rax
180005239:     	sarq	$0x3f, %rax
18000523d:     	andq	%rbx, %rax
180005240:     	leaq	(%r10,%rbp,8), %r13
180005244:     	movq	(%r13,%rax,8), %rdx
180005249:     	xorl	%edi, %edi
18000524b:     	cmpq	$-0x2, %rsi
18000524f:     	movl	$0x0, %eax
180005254:     	cmovlq	%rbx, %rax
180005258:     	leaq	(%r10,%rsi,8), %r10
18000525c:     	movq	0x10(%r10,%rax,8), %r11
180005261:     	movq	%r11, %r10
180005264:     	sarq	$0x3f, %r10
180005268:     	andq	%r12, %r10
18000526b:     	leaq	(%r14,%r11,8), %r15
18000526f:     	movsd	(%r15,%r10,8), %xmm0
180005275:     	cmpq	$-0x2, %rdx
180005279:     	movq	%r14, %r10
18000527c:     	movl	$0x0, %r14d
180005282:     	cmovlq	%r12, %r14
180005286:     	leaq	(%r10,%rdx,8), %r10
18000528a:     	movsd	0x10(%r10,%r14,8), %xmm1
180005291:     	movl	$0x0, %r14d
180005297:     	cmovleq	%r12, %r14
18000529b:     	movsd	0x8(%r10,%r14,8), %xmm2
1800052a2:     	movapd	%xmm1, %xmm3
1800052a6:     	subsd	%xmm2, %xmm3
1800052aa:     	ucomisd	%xmm3, %xmm0
1800052ae:     	jb	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800052b4:     	addsd	%xmm2, %xmm1
1800052b8:     	ucomisd	%xmm0, %xmm1
1800052bc:     	jbe	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800052c2:     	xorl	%edi, %edi
1800052c4:     	cmpq	$-0x2, %r11
1800052c8:     	movl	$0x0, %r11d
1800052ce:     	cmovlq	%r12, %r11
1800052d2:     	movsd	0x10(%r15,%r11,8), %xmm0
1800052d9:     	cmpq	$-0x3, %rdx
1800052dd:     	movl	$0x0, %r11d
1800052e3:     	cmovlq	%r12, %r11
1800052e7:     	movsd	0x18(%r10,%r11,8), %xmm1
1800052ee:     	sarq	$0x3f, %rdx
1800052f2:     	andq	%r12, %rdx
1800052f5:     	movsd	(%r10,%rdx,8), %xmm2
1800052fb:     	movapd	%xmm1, %xmm3
1800052ff:     	subsd	%xmm2, %xmm3
180005303:     	ucomisd	%xmm3, %xmm0
180005307:     	jb	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
18000530d:     	addsd	%xmm2, %xmm1
180005311:     	xorl	%edi, %edi
180005313:     	ucomisd	%xmm0, %xmm1
180005317:     	jbe	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
18000531d:     	movq	0x298(%rsp), %rdx
180005325:     	cmpb	$0x0, (%rdx)
180005328:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
18000532e:     	xorl	%r11d, %r11d
180005331:     	cmpq	$-0x6, %rbp
180005335:     	movl	$0x0, %edx
18000533a:     	cmovlq	%rbx, %rdx
18000533e:     	movq	0x30(%r13,%rdx,8), %r10
180005343:     	movq	%r10, %rdi
180005346:     	sarq	$0x3f, %rdi
18000534a:     	andq	%rbx, %rdi
18000534d:     	movq	0x228(%rsp), %r14
180005355:     	leaq	(%r14,%r10,8), %r15
180005359:     	movq	(%r15,%rdi,8), %rdx
18000535d:     	cmpq	$-0x1, %rbp
180005361:     	cmovlq	%rbx, %r11
180005365:     	cmpq	0x8(%r13,%r11,8), %rdx
18000536a:     	jge	0x180005383 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x13a3>
18000536c:     	xorl	%r11d, %r11d
18000536f:     	cmpq	$-0x3, %rbp
180005373:     	cmovlq	%rbx, %r11
180005377:     	cmpq	$0x0, 0x18(%r13,%r11,8)
18000537d:     	je	0x180005c0a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c2a>
180005383:     	xorl	%eax, %eax
180005385:     	cmpq	$-0x3, %rbp
180005389:     	cmovlq	%rbx, %rax
18000538d:     	cmpq	$0x0, 0x18(%r13,%rax,8)
180005393:     	movq	0x260(%rsp), %r14
18000539b:     	je	0x180005765 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1785>
1800053a1:     	xorl	%eax, %eax
1800053a3:     	cmpq	$-0x4, %rbp
1800053a7:     	cmovlq	%rbx, %rax
1800053ab:     	movq	0x20(%r13,%rax,8), %rax
1800053b0:     	testq	%rax, %rax
1800053b3:     	js	0x18000574d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x176d>
1800053b9:     	movq	0x8(%r14), %rdx
1800053bd:     	leaq	0x1(%rdx), %r10
1800053c1:     	movq	%r10, 0x8(%r14)
1800053c5:     	cmpq	0x10(%r14), %rdx
1800053c9:     	jge	0x18000574d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x176d>
1800053cf:     	movq	%rcx, 0x110(%rsp)
1800053d7:     	movb	$0x0, 0x11f(%rsp)
1800053df:     	movq	%rsi, 0x100(%rsp)
1800053e7:     	movq	%rax, 0xf8(%rsp)
1800053ef:     	movq	0x2a8(%rsp), %rax
1800053f7:     	movq	%rax, 0xe8(%rsp)
1800053ff:     	movq	0x2a0(%rsp), %rax
180005407:     	movq	%rax, 0xe0(%rsp)
18000540f:     	movq	0x298(%rsp), %rdi
180005417:     	movq	%rdi, 0xd8(%rsp)
18000541f:     	movq	0x290(%rsp), %rax
180005427:     	movq	%rax, 0xd0(%rsp)
18000542f:     	movq	0x288(%rsp), %rax
180005437:     	movq	%rax, 0xc8(%rsp)
18000543f:     	movq	0x280(%rsp), %rax
180005447:     	movq	%rax, 0xc0(%rsp)
18000544f:     	movq	0x278(%rsp), %rax
180005457:     	movq	%rax, 0xb8(%rsp)
18000545f:     	movq	0x270(%rsp), %rax
180005467:     	movq	%rax, 0xb0(%rsp)
18000546f:     	movq	0x268(%rsp), %rax
180005477:     	movq	%rax, 0xa8(%rsp)
18000547f:     	movq	%r14, 0xa0(%rsp)
180005487:     	movq	0x258(%rsp), %rax
18000548f:     	movq	%rax, 0x98(%rsp)
180005497:     	movq	0x250(%rsp), %rax
18000549f:     	movq	%rax, 0x90(%rsp)
1800054a7:     	movq	0x248(%rsp), %rax
1800054af:     	movq	%rax, 0x88(%rsp)
1800054b7:     	movq	0x240(%rsp), %rax
1800054bf:     	movq	%rax, 0x80(%rsp)
1800054c7:     	movq	0x238(%rsp), %rax
1800054cf:     	movq	%rax, 0x78(%rsp)
1800054d4:     	movq	%rbx, 0x70(%rsp)
1800054d9:     	movq	0x228(%rsp), %rax
1800054e1:     	movq	%rax, 0x68(%rsp)
1800054e6:     	movq	0x220(%rsp), %rax
1800054ee:     	movq	%rax, 0x60(%rsp)
1800054f3:     	movq	0x218(%rsp), %rax
1800054fb:     	movq	%rax, 0x58(%rsp)
180005500:     	movq	0x210(%rsp), %rax
180005508:     	movq	%rax, 0x50(%rsp)
18000550d:     	movq	0x208(%rsp), %rax
180005515:     	movq	%rax, 0x48(%rsp)
18000551a:     	movq	0x200(%rsp), %rax
180005522:     	movq	%rax, 0x40(%rsp)
180005527:     	movq	%r12, 0x38(%rsp)
18000552c:     	movq	0x1f0(%rsp), %rax
180005534:     	movq	%rax, 0x30(%rsp)
180005539:     	movq	0x1e8(%rsp), %rax
180005541:     	movq	%rax, 0x28(%rsp)
180005546:     	movq	0x1e0(%rsp), %rax
18000554e:     	movq	%rax, 0x20(%rsp)
180005553:     	movq	$-0x1, 0x108(%rsp)
18000555f:     	movq	$0x0, 0xf0(%rsp)
18000556b:     	leaq	0x11f(%rsp), %rcx
180005573:     	movq	%r8, 0x138(%rsp)
18000557b:     	movq	%r9, 0x128(%rsp)
180005583:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180005588:     	cmpb	$0x0, (%rdi)
18000558b:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180005591:     	movq	0x8(%r14), %rax
180005595:     	leaq	-0x1(%rax), %rcx
180005599:     	cmpb	$0x0, 0x11f(%rsp)
1800055a1:     	movq	%rcx, 0x8(%r14)
1800055a5:     	movb	$0x1, %dil
1800055a8:     	movq	0x110(%rsp), %rcx
1800055b0:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800055b6:     	xorl	%edx, %edx
1800055b8:     	cmpq	$-0x5, %rbp
1800055bc:     	cmovlq	%rbx, %rdx
1800055c0:     	movq	0x28(%r13,%rdx,8), %rdx
1800055c5:     	testq	%rdx, %rdx
1800055c8:     	js	0x1800055d8 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x15f8>
1800055ca:     	movq	%rax, 0x8(%r14)
1800055ce:     	cmpq	0x10(%r14), %rax
1800055d2:     	jle	0x180005d44 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1d64>
1800055d8:     	movq	0x298(%rsp), %rax
1800055e0:     	movb	$0x1, (%rax)
1800055e3:     	movq	$0x2dc6ce, 0x18(%r14)   # imm = 0x2DC6CE
1800055eb:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
1800055f0:     	movq	0x2c8(%rsp), %rax
1800055f8:     	movq	%rax, %rdx
1800055fb:     	sarq	$0x3f, %rdx
1800055ff:     	andq	%rbx, %rdx
180005602:     	leaq	(%r10,%rax,8), %rsi
180005606:     	movq	(%rsi,%rdx,8), %rdx
18000560a:     	xorl	%r10d, %r10d
18000560d:     	cmpq	$-0x2, %rdx
180005611:     	movl	$0x0, %edi
180005616:     	cmovlq	%r12, %rdi
18000561a:     	cmpq	$-0x3, %rdx
18000561e:     	movl	$0x0, %r15d
180005624:     	cmovlq	%r12, %r15
180005628:     	cmpq	$-0x1, %rdx
18000562c:     	cmovlq	%r12, %r10
180005630:     	movq	(%r11), %r13
180005633:     	leaq	0x4(%r13), %r11
180005637:     	cmpq	%rbx, %r11
18000563a:     	jle	0x180005642 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1662>
18000563c:     	movb	$0x2, (%rbp)
180005640:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005642:     	movq	%rsi, 0x120(%rsp)
18000564a:     	movq	%r14, %rsi
18000564d:     	leaq	(%r14,%rdx,8), %r14
180005651:     	movsd	0x10(%r14,%rdi,8), %xmm3
180005658:     	movsd	0x18(%r14,%r15,8), %xmm2
18000565f:     	movsd	0x9d49(%rip), %xmm0     # 0x18000f3b0
180005667:     	movsd	0x8(%r14,%r10,8), %xmm1
18000566e:     	mulsd	%xmm0, %xmm1
180005672:     	sarq	$0x3f, %rdx
180005676:     	andq	%r12, %rdx
180005679:     	mulsd	(%r14,%rdx,8), %xmm0
18000567f:     	movq	0x260(%rsp), %rdx
180005687:     	movq	%r11, (%rdx)
18000568a:     	cmpb	$0x0, (%rbp)
18000568e:     	je	0x1800056af <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16cf>
180005690:     	xorl	%edi, %edi
180005692:     	andb	$0x1, %dil
180005696:     	movb	%dil, (%rcx)
180005699:     	xorl	%eax, %eax
18000569b:     	addq	$0x178, %rsp            # imm = 0x178
1800056a2:     	popq	%rbx
1800056a3:     	popq	%rbp
1800056a4:     	popq	%rdi
1800056a5:     	popq	%rsi
1800056a6:     	popq	%r12
1800056a8:     	popq	%r13
1800056aa:     	popq	%r14
1800056ac:     	popq	%r15
1800056ae:     	retq
1800056af:     	movapd	%xmm3, %xmm4
1800056b3:     	addsd	%xmm1, %xmm4
1800056b7:     	movapd	%xmm2, %xmm5
1800056bb:     	subsd	%xmm0, %xmm5
1800056bf:     	xorl	%edi, %edi
1800056c1:     	cmpq	$-0x2, %r13
1800056c5:     	movl	$0x0, %edx
1800056ca:     	cmovlq	%r12, %rdx
1800056ce:     	leaq	(%rsi,%r13,8), %r10
1800056d2:     	movsd	%xmm4, 0x10(%r10,%rdx,8)
1800056d9:     	cmpq	$-0x3, %r13
1800056dd:     	movl	$0x0, %edx
1800056e2:     	cmovlq	%r12, %rdx
1800056e6:     	movsd	%xmm5, 0x18(%r10,%rdx,8)
1800056ed:     	cmpq	$-0x1, %r13
1800056f1:     	movl	$0x0, %edx
1800056f6:     	cmovlq	%r12, %rdx
1800056fa:     	movsd	%xmm1, 0x8(%r10,%rdx,8)
180005701:     	movq	%r13, %rdx
180005704:     	sarq	$0x3f, %rdx
180005708:     	andq	%r12, %rdx
18000570b:     	movsd	%xmm0, (%r10,%rdx,8)
180005711:     	cmpb	$0x0, (%rbp)
180005715:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
18000571b:     	xorl	%edx, %edx
18000571d:     	cmpq	$-0x1, %rax
180005721:     	cmovlq	%rbx, %rdx
180005725:     	movq	0x260(%rsp), %r14
18000572d:     	movq	(%r14), %r10
180005730:     	leaq	0xb(%r10), %r11
180005734:     	cmpq	%rbx, %r11
180005737:     	jle	0x180005942 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1962>
18000573d:     	movq	0x298(%rsp), %rax
180005745:     	movb	$0x2, (%rax)
180005748:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
18000574d:     	movq	0x298(%rsp), %rax
180005755:     	movb	$0x1, (%rax)
180005758:     	movq	$0x2dc6cd, 0x18(%r14)   # imm = 0x2DC6CD
180005760:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005765:     	movq	0x8(%r14), %rax
180005769:     	leaq	0x1(%rax), %rdx
18000576d:     	movq	%rdx, 0x8(%r14)
180005771:     	cmpq	0x10(%r14), %rax
180005775:     	jge	0x180005d0d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1d2d>
18000577b:     	movq	%rcx, 0x110(%rsp)
180005783:     	movq	%rbp, 0x108(%rsp)
18000578b:     	movq	0x2a8(%rsp), %rax
180005793:     	movq	%rax, 0xe8(%rsp)
18000579b:     	movq	0x2a0(%rsp), %rax
1800057a3:     	movq	%rax, 0xe0(%rsp)
1800057ab:     	movq	%r14, %rcx
1800057ae:     	movq	0x298(%rsp), %r14
1800057b6:     	movq	%r14, 0xd8(%rsp)
1800057be:     	movq	0x290(%rsp), %rax
1800057c6:     	movq	%rax, 0xd0(%rsp)
1800057ce:     	movq	0x288(%rsp), %rax
1800057d6:     	movq	%rax, 0xc8(%rsp)
1800057de:     	movq	0x280(%rsp), %rax
1800057e6:     	movq	%rax, 0xc0(%rsp)
1800057ee:     	movq	0x278(%rsp), %rax
1800057f6:     	movq	%rax, 0xb8(%rsp)
1800057fe:     	movq	0x270(%rsp), %rax
180005806:     	movq	%rax, 0xb0(%rsp)
18000580e:     	movq	0x268(%rsp), %rax
180005816:     	movq	%rax, 0xa8(%rsp)
18000581e:     	movq	%rcx, 0xa0(%rsp)
180005826:     	movq	0x258(%rsp), %rax
18000582e:     	movq	%rax, 0x98(%rsp)
180005836:     	movq	0x250(%rsp), %rax
18000583e:     	movq	%rax, 0x90(%rsp)
180005846:     	movq	0x248(%rsp), %rax
18000584e:     	movq	%rax, 0x88(%rsp)
180005856:     	movq	0x240(%rsp), %rax
18000585e:     	movq	%rax, 0x80(%rsp)
180005866:     	movq	0x238(%rsp), %rax
18000586e:     	movq	%rax, 0x78(%rsp)
180005873:     	movq	%rbx, 0x70(%rsp)
180005878:     	movq	0x228(%rsp), %rax
180005880:     	movq	%rax, 0x68(%rsp)
180005885:     	movq	0x220(%rsp), %rax
18000588d:     	movq	%rax, 0x60(%rsp)
180005892:     	movq	0x218(%rsp), %rax
18000589a:     	movq	%rax, 0x58(%rsp)
18000589f:     	movq	0x210(%rsp), %rax
1800058a7:     	movq	%rax, 0x50(%rsp)
1800058ac:     	movq	0x208(%rsp), %rax
1800058b4:     	movq	%rax, 0x48(%rsp)
1800058b9:     	movq	0x200(%rsp), %rax
1800058c1:     	movq	%rax, 0x40(%rsp)
1800058c6:     	movq	%r12, 0x38(%rsp)
1800058cb:     	movq	0x1f0(%rsp), %rax
1800058d3:     	movq	%rax, 0x30(%rsp)
1800058d8:     	movq	0x1e8(%rsp), %rax
1800058e0:     	movq	%rax, 0x28(%rsp)
1800058e5:     	movq	0x1e0(%rsp), %rax
1800058ed:     	movq	%rax, 0x20(%rsp)
1800058f2:     	movq	$-0x1, 0x100(%rsp)
1800058fe:     	movq	$-0x1, 0xf8(%rsp)
18000590a:     	movq	$0x1, 0xf0(%rsp)
180005916:     	leaq	0x137(%rsp), %rcx
18000591e:     	movq	%r8, %rdi
180005921:     	movq	%r9, %r15
180005924:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180005929:     	cmpb	$0x0, (%r14)
18000592d:     	je	0x180005d25 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1d45>
180005933:     	xorl	%edi, %edi
180005935:     	movq	0x110(%rsp), %rcx
18000593d:     	jmp	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180005942:     	movq	0x120(%rsp), %rsi
18000594a:     	movq	0x8(%rsi,%rdx,8), %rdi
18000594f:     	movq	%r11, (%r14)
180005952:     	movq	0x298(%rsp), %r11
18000595a:     	cmpb	$0x0, (%r11)
18000595e:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005964:     	movq	%r10, %r14
180005967:     	sarq	$0x3f, %r14
18000596b:     	andq	%rbx, %r14
18000596e:     	movq	0x228(%rsp), %r11
180005976:     	leaq	(%r11,%r10,8), %rsi
18000597a:     	movq	%r13, (%rsi,%r14,8)
18000597e:     	xorl	%r14d, %r14d
180005981:     	cmpq	$-0x1, %r10
180005985:     	cmovlq	%rbx, %r14
180005989:     	movq	%rdi, 0x8(%rsi,%r14,8)
18000598e:     	movq	0x260(%rsp), %r14
180005996:     	movq	(%r14), %r13
180005999:     	cmpq	%rbx, %r13
18000599c:     	movq	%r13, %rbp
18000599f:     	jle	0x1800059b2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x19d2>
1800059a1:     	movq	0x298(%rsp), %r11
1800059a9:     	movb	$0x2, (%r11)
1800059ad:     	movq	(%r14), %r13
1800059b0:     	xorl	%ebp, %ebp
1800059b2:     	leaq	0x3(%r13), %rdi
1800059b6:     	cmpq	%rbx, %rdi
1800059b9:     	jg	0x18000573d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x175d>
1800059bf:     	movq	%rdi, (%r14)
1800059c2:     	movq	0x298(%rsp), %r11
1800059ca:     	cmpb	$0x0, (%r11)
1800059ce:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
1800059d4:     	movq	%r13, %rdi
1800059d7:     	sarq	$0x3f, %rdi
1800059db:     	andq	%rbx, %rdi
1800059de:     	movq	0x228(%rsp), %r14
1800059e6:     	leaq	(%r14,%r13,8), %r14
1800059ea:     	movq	$0x0, (%r14,%rdi,8)
1800059f2:     	xorl	%edi, %edi
1800059f4:     	cmpq	$-0x1, %r13
1800059f8:     	movl	$0x0, %r15d
1800059fe:     	cmovlq	%rbx, %r15
180005a02:     	movq	$0x0, 0x8(%r14,%r15,8)
180005a0b:     	cmpq	$-0x2, %r13
180005a0f:     	movl	$0x0, %r15d
180005a15:     	cmovlq	%rbx, %r15
180005a19:     	movq	%rbp, 0x10(%r14,%r15,8)
180005a1e:     	cmpb	$0x0, (%r11)
180005a22:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180005a28:     	xorl	%edi, %edi
180005a2a:     	cmpq	$-0x6, %r10
180005a2e:     	movl	$0x0, %r14d
180005a34:     	cmovlq	%rbx, %r14
180005a38:     	movq	%r13, 0x30(%rsi,%r14,8)
180005a3d:     	cmpq	$-0x3, %r10
180005a41:     	cmovlq	%rbx, %rdi
180005a45:     	movq	$0x0, 0x18(%rsi,%rdi,8)
180005a4e:     	movq	0x260(%rsp), %r11
180005a56:     	movq	(%r11), %r13
180005a59:     	leaq	0x4(%r13), %rdi
180005a5d:     	cmpq	%rbx, %rdi
180005a60:     	jg	0x18000573d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x175d>
180005a66:     	movq	%rdi, (%r11)
180005a69:     	movq	0x298(%rsp), %rbp
180005a71:     	cmpb	$0x0, (%rbp)
180005a75:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005a7b:     	movq	%r13, %rdi
180005a7e:     	sarq	$0x3f, %rdi
180005a82:     	andq	%r12, %rdi
180005a85:     	movq	0x1f0(%rsp), %r11
180005a8d:     	leaq	(%r11,%r13,8), %r14
180005a91:     	movq	$0x0, (%r14,%rdi,8)
180005a99:     	xorl	%edi, %edi
180005a9b:     	cmpq	$-0x1, %r13
180005a9f:     	movl	$0x0, %r15d
180005aa5:     	cmovlq	%rbx, %r15
180005aa9:     	movq	0x228(%rsp), %r11
180005ab1:     	leaq	(%r11,%r13,8), %r11
180005ab5:     	movq	$0x1, 0x8(%r11,%r15,8)
180005abe:     	cmpq	$-0x2, %r13
180005ac2:     	movl	$0x0, %r15d
180005ac8:     	cmovlq	%r12, %r15
180005acc:     	movq	$0x0, 0x10(%r14,%r15,8)
180005ad5:     	cmpq	$-0x3, %r13
180005ad9:     	movl	$0x0, %r14d
180005adf:     	cmovlq	%rbx, %r14
180005ae3:     	movq	$0x1, 0x18(%r11,%r14,8)
180005aec:     	cmpb	$0x0, (%rbp)
180005af0:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180005af6:     	xorl	%edi, %edi
180005af8:     	cmpq	$-0x2, %r10
180005afc:     	movl	$0x0, %r14d
180005b02:     	cmovlq	%rbx, %r14
180005b06:     	movq	%r13, 0x10(%rsi,%r14,8)
180005b0b:     	cmpq	$-0x9, %r10
180005b0f:     	movl	$0x0, %r14d
180005b15:     	cmovlq	%r12, %r14
180005b19:     	movq	0x1f0(%rsp), %r11
180005b21:     	leaq	(%r11,%r10,8), %r15
180005b25:     	movq	$0x0, 0x48(%r15,%r14,8)
180005b2e:     	cmpq	$-0xa, %r10
180005b32:     	movl	$0x0, %r14d
180005b38:     	cmovlq	%rbx, %r14
180005b3c:     	movq	$0x1, 0x50(%rsi,%r14,8)
180005b45:     	cmpq	$-0x4, %r10
180005b49:     	movl	$0x0, %r14d
180005b4f:     	cmovlq	%rbx, %r14
180005b53:     	movq	$-0x1, 0x20(%rsi,%r14,8)
180005b5c:     	cmpq	$-0x5, %r10
180005b60:     	movl	$0x0, %r14d
180005b66:     	cmovlq	%rbx, %r14
180005b6a:     	movq	$-0x1, 0x28(%rsi,%r14,8)
180005b73:     	cmpq	$-0x7, %r10
180005b77:     	movl	$0x0, %r14d
180005b7d:     	cmovlq	%rbx, %r14
180005b81:     	movq	$-0x1, 0x38(%rsi,%r14,8)
180005b8a:     	cmpq	$-0x8, %r10
180005b8e:     	movl	$0x0, %r14d
180005b94:     	cmovlq	%rbx, %r14
180005b98:     	movq	$-0x1, 0x40(%rsi,%r14,8)
180005ba1:     	movq	0x298(%rsp), %r11
180005ba9:     	cmpb	$0x0, (%r11)
180005bad:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180005bb3:     	movq	%r8, 0x138(%rsp)
180005bbb:     	movq	%r9, 0x128(%rsp)
180005bc3:     	movq	%rcx, 0x110(%rsp)
180005bcb:     	xorl	%esi, %esi
180005bcd:     	cmpq	$-0x4, %rax
180005bd1:     	cmovlq	%rbx, %rsi
180005bd5:     	movq	0x120(%rsp), %rcx
180005bdd:     	movq	%r10, 0x20(%rcx,%rsi,8)
180005be2:     	movq	0x260(%rsp), %rcx
180005bea:     	movq	(%rcx), %r10
180005bed:     	leaq	0x4(%r10), %rcx
180005bf1:     	cmpq	%rbx, %rcx
180005bf4:     	jle	0x18000671a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x273a>
180005bfa:     	movq	0x298(%rsp), %rax
180005c02:     	movb	$0x2, (%rax)
180005c05:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180005c0a:     	xorl	%r11d, %r11d
180005c0d:     	cmpq	$-0x1, %r10
180005c11:     	cmovlq	%rbx, %r11
180005c15:     	cmpq	0x8(%r15,%r11,8), %rdx
180005c1a:     	movq	0x260(%rsp), %r8
180005c22:     	jne	0x1800061a2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x21c2>
180005c28:     	leaq	(%rdx,%rdx), %r9
180005c2c:     	movq	%r9, 0x120(%rsp)
180005c34:     	movq	%rdx, 0x140(%rsp)
180005c3c:     	testq	%rdx, %rdx
180005c3f:     	movl	$0x4, %r9d
180005c45:     	cmovneq	0x120(%rsp), %r9
180005c4e:     	movq	(%r8), %rdx
180005c51:     	movq	%r9, 0x160(%rsp)
180005c59:     	movq	%rdx, 0x110(%rsp)
180005c61:     	addq	%rdx, %r9
180005c64:     	cmpq	%rbx, %r9
180005c67:     	jg	0x18000573d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x175d>
180005c6d:     	movq	0x260(%rsp), %rdx
180005c75:     	movq	%r9, (%rdx)
180005c78:     	movq	0x298(%rsp), %r8
180005c80:     	cmpb	$0x0, (%r8)
180005c84:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005c8a:     	movq	%r11, 0x170(%rsp)
180005c92:     	movq	%r15, 0x158(%rsp)
180005c9a:     	xorl	%edx, %edx
180005c9c:     	cmpq	$-0x2, %r10
180005ca0:     	cmovlq	%rbx, %rdx
180005ca4:     	movq	%rdx, 0x150(%rsp)
180005cac:     	cmpq	$0x0, 0x140(%rsp)
180005cb5:     	movq	%r14, %r15
180005cb8:     	jle	0x180006165 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2185>
180005cbe:     	movq	0x158(%rsp), %r8
180005cc6:     	movq	0x150(%rsp), %r9
180005cce:     	movq	0x10(%r8,%r9,8), %r8
180005cd3:     	movq	0x140(%rsp), %rdx
180005cdb:     	movl	%edx, %r14d
180005cde:     	andl	$0x7, %r14d
180005ce2:     	cmpq	$0x7, %rdx
180005ce6:     	ja	0x180005f29 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1f49>
180005cec:     	leaq	(,%rbx,8), %r9
180005cf4:     	movq	$0x0, 0x128(%rsp)
180005d00:     	movq	0x228(%rsp), %r15
180005d08:     	jmp	0x18000610c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x212c>
180005d0d:     	movq	0x298(%rsp), %rax
180005d15:     	movb	$0x1, (%rax)
180005d18:     	movq	$0x2dc6cb, 0x18(%r14)   # imm = 0x2DC6CB
180005d20:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180005d25:     	movq	0x260(%rsp), %r14
180005d2d:     	decq	0x8(%r14)
180005d31:     	movq	0x110(%rsp), %rcx
180005d39:     	movq	%r15, %r9
180005d3c:     	movq	%rdi, %r8
180005d3f:     	jmp	0x1800053a1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x13c1>
180005d44:     	movb	$0x0, 0x11e(%rsp)
180005d4c:     	movq	%rsi, 0x100(%rsp)
180005d54:     	movq	%rdx, 0xf8(%rsp)
180005d5c:     	movq	0x2a8(%rsp), %rax
180005d64:     	movq	%rax, 0xe8(%rsp)
180005d6c:     	movq	0x2a0(%rsp), %rax
180005d74:     	movq	%rax, 0xe0(%rsp)
180005d7c:     	movq	%r14, %r15
180005d7f:     	movq	0x298(%rsp), %r14
180005d87:     	movq	%r14, 0xd8(%rsp)
180005d8f:     	movq	0x290(%rsp), %rax
180005d97:     	movq	%rax, 0xd0(%rsp)
180005d9f:     	movq	0x288(%rsp), %rax
180005da7:     	movq	%rax, 0xc8(%rsp)
180005daf:     	movq	0x280(%rsp), %rax
180005db7:     	movq	%rax, 0xc0(%rsp)
180005dbf:     	movq	0x278(%rsp), %rax
180005dc7:     	movq	%rax, 0xb8(%rsp)
180005dcf:     	movq	0x270(%rsp), %rax
180005dd7:     	movq	%rax, 0xb0(%rsp)
180005ddf:     	movq	0x268(%rsp), %rax
180005de7:     	movq	%rax, 0xa8(%rsp)
180005def:     	movq	%r15, 0xa0(%rsp)
180005df7:     	movq	0x258(%rsp), %rax
180005dff:     	movq	%rax, 0x98(%rsp)
180005e07:     	movq	0x250(%rsp), %rax
180005e0f:     	movq	%rax, 0x90(%rsp)
180005e17:     	movq	0x248(%rsp), %rax
180005e1f:     	movq	%rax, 0x88(%rsp)
180005e27:     	movq	0x240(%rsp), %rax
180005e2f:     	movq	%rax, 0x80(%rsp)
180005e37:     	movq	0x238(%rsp), %rax
180005e3f:     	movq	%rax, 0x78(%rsp)
180005e44:     	movq	%rbx, 0x70(%rsp)
180005e49:     	movq	0x228(%rsp), %rax
180005e51:     	movq	%rax, 0x68(%rsp)
180005e56:     	movq	0x220(%rsp), %rax
180005e5e:     	movq	%rax, 0x60(%rsp)
180005e63:     	movq	0x218(%rsp), %rax
180005e6b:     	movq	%rax, 0x58(%rsp)
180005e70:     	movq	0x210(%rsp), %rax
180005e78:     	movq	%rax, 0x50(%rsp)
180005e7d:     	movq	0x208(%rsp), %rax
180005e85:     	movq	%rax, 0x48(%rsp)
180005e8a:     	movq	0x200(%rsp), %rax
180005e92:     	movq	%rax, 0x40(%rsp)
180005e97:     	movq	%r12, 0x38(%rsp)
180005e9c:     	movq	0x1f0(%rsp), %rax
180005ea4:     	movq	%rax, 0x30(%rsp)
180005ea9:     	movq	0x1e8(%rsp), %rax
180005eb1:     	movq	%rax, 0x28(%rsp)
180005eb6:     	movq	0x1e0(%rsp), %rax
180005ebe:     	movq	%rax, 0x20(%rsp)
180005ec3:     	movq	$-0x1, 0x108(%rsp)
180005ecf:     	movq	$0x0, 0xf0(%rsp)
180005edb:     	leaq	0x11e(%rsp), %rcx
180005ee3:     	movq	0x138(%rsp), %r8
180005eeb:     	movq	0x128(%rsp), %r9
180005ef3:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180005ef8:     	cmpb	$0x0, (%r14)
180005efc:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180005f02:     	movq	0x8(%r15), %rax
180005f06:     	leaq	-0x1(%rax), %rcx
180005f0a:     	cmpb	$0x0, 0x11e(%rsp)
180005f12:     	movq	%rcx, 0x8(%r15)
180005f16:     	je	0x180006495 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24b5>
180005f1c:     	movq	0x110(%rsp), %rcx
180005f24:     	jmp	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180005f29:     	movq	%r10, 0x168(%rsp)
180005f31:     	movq	%r14, 0x120(%rsp)
180005f39:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180005f43:     	andq	%rdx, %r9
180005f46:     	movq	%r9, 0x128(%rsp)
180005f4e:     	movq	0x228(%rsp), %r9
180005f56:     	leaq	(%r9,%r8,8), %rdx
180005f5a:     	movq	%rdx, 0x138(%rsp)
180005f62:     	movq	0x110(%rsp), %rdx
180005f6a:     	leaq	(%r9,%rdx,8), %rdx
180005f6e:     	movq	%rdx, 0x148(%rsp)
180005f76:     	leaq	(,%rbx,8), %r9
180005f7e:     	xorl	%r11d, %r11d
180005f81:     	movq	0x138(%rsp), %rsi
180005f89:     	movq	0x110(%rsp), %r10
180005f91:     	movq	0x148(%rsp), %rdx
180005f99:     	leaq	(%r8,%r11), %r14
180005f9d:     	sarq	$0x3f, %r14
180005fa1:     	andq	%r9, %r14
180005fa4:     	addq	%rsi, %r14
180005fa7:     	movq	(%r14,%r11,8), %r14
180005fab:     	leaq	(%r10,%r11), %r15
180005faf:     	sarq	$0x3f, %r15
180005fb3:     	andq	%r9, %r15
180005fb6:     	addq	%rdx, %r15
180005fb9:     	movq	%r14, (%r15,%r11,8)
180005fbd:     	leaq	0x1(%r8,%r11), %r14
180005fc2:     	sarq	$0x3f, %r14
180005fc6:     	andq	%r9, %r14
180005fc9:     	addq	%rsi, %r14
180005fcc:     	movq	0x8(%r14,%r11,8), %r14
180005fd1:     	leaq	0x1(%r10,%r11), %r15
180005fd6:     	sarq	$0x3f, %r15
180005fda:     	andq	%r9, %r15
180005fdd:     	addq	%rdx, %r15
180005fe0:     	movq	%r14, 0x8(%r15,%r11,8)
180005fe5:     	leaq	0x2(%r8,%r11), %r14
180005fea:     	sarq	$0x3f, %r14
180005fee:     	andq	%r9, %r14
180005ff1:     	addq	%rsi, %r14
180005ff4:     	movq	0x10(%r14,%r11,8), %r14
180005ff9:     	leaq	0x2(%r10,%r11), %r15
180005ffe:     	sarq	$0x3f, %r15
180006002:     	andq	%r9, %r15
180006005:     	addq	%rdx, %r15
180006008:     	movq	%r14, 0x10(%r15,%r11,8)
18000600d:     	leaq	0x3(%r8,%r11), %r14
180006012:     	sarq	$0x3f, %r14
180006016:     	andq	%r9, %r14
180006019:     	addq	%rsi, %r14
18000601c:     	movq	0x18(%r14,%r11,8), %r14
180006021:     	leaq	0x3(%r10,%r11), %r15
180006026:     	sarq	$0x3f, %r15
18000602a:     	andq	%r9, %r15
18000602d:     	addq	%rdx, %r15
180006030:     	movq	%r14, 0x18(%r15,%r11,8)
180006035:     	leaq	0x4(%r8,%r11), %r14
18000603a:     	sarq	$0x3f, %r14
18000603e:     	andq	%r9, %r14
180006041:     	addq	%rsi, %r14
180006044:     	movq	0x20(%r14,%r11,8), %r14
180006049:     	leaq	0x4(%r10,%r11), %r15
18000604e:     	sarq	$0x3f, %r15
180006052:     	andq	%r9, %r15
180006055:     	addq	%rdx, %r15
180006058:     	movq	%r14, 0x20(%r15,%r11,8)
18000605d:     	leaq	0x5(%r8,%r11), %r14
180006062:     	sarq	$0x3f, %r14
180006066:     	andq	%r9, %r14
180006069:     	addq	%rsi, %r14
18000606c:     	movq	0x28(%r14,%r11,8), %r14
180006071:     	leaq	0x5(%r10,%r11), %r15
180006076:     	sarq	$0x3f, %r15
18000607a:     	andq	%r9, %r15
18000607d:     	addq	%rdx, %r15
180006080:     	movq	%r14, 0x28(%r15,%r11,8)
180006085:     	leaq	0x6(%r8,%r11), %r14
18000608a:     	sarq	$0x3f, %r14
18000608e:     	andq	%r9, %r14
180006091:     	addq	%rsi, %r14
180006094:     	movq	0x30(%r14,%r11,8), %r14
180006099:     	leaq	0x6(%r10,%r11), %r15
18000609e:     	sarq	$0x3f, %r15
1800060a2:     	andq	%r9, %r15
1800060a5:     	addq	%rdx, %r15
1800060a8:     	movq	%r14, 0x30(%r15,%r11,8)
1800060ad:     	leaq	0x7(%r8,%r11), %r14
1800060b2:     	sarq	$0x3f, %r14
1800060b6:     	andq	%r9, %r14
1800060b9:     	addq	%rsi, %r14
1800060bc:     	movq	0x38(%r14,%r11,8), %r14
1800060c1:     	leaq	0x7(%r10,%r11), %r15
1800060c6:     	sarq	$0x3f, %r15
1800060ca:     	andq	%r9, %r15
1800060cd:     	addq	%rdx, %r15
1800060d0:     	movq	%r14, 0x38(%r15,%r11,8)
1800060d5:     	addq	$0x8, %r11
1800060d9:     	cmpq	%r11, 0x128(%rsp)
1800060e1:     	jne	0x180005f99 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1fb9>
1800060e7:     	movq	0x120(%rsp), %r14
1800060ef:     	testq	%r14, %r14
1800060f2:     	movq	0x228(%rsp), %r15
1800060fa:     	movq	0x168(%rsp), %r10
180006102:     	movq	0x2c0(%rsp), %rsi
18000610a:     	je	0x180006165 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2185>
18000610c:     	movq	0x110(%rsp), %r11
180006114:     	movq	0x128(%rsp), %rdx
18000611c:     	addq	%rdx, %r11
18000611f:     	addq	%rdx, %r8
180006122:     	movq	%r14, 0x120(%rsp)
18000612a:     	movq	%r8, %r14
18000612d:     	sarq	$0x3f, %r14
180006131:     	andq	%r9, %r14
180006134:     	addq	%r15, %r14
180006137:     	movq	(%r14,%r8,8), %r14
18000613b:     	movq	%r15, %rdx
18000613e:     	movq	%r11, %r15
180006141:     	sarq	$0x3f, %r15
180006145:     	andq	%r9, %r15
180006148:     	addq	%rdx, %r15
18000614b:     	movq	%r14, (%r15,%r11,8)
18000614f:     	movq	%rdx, %r15
180006152:     	movq	0x120(%rsp), %r14
18000615a:     	incq	%r11
18000615d:     	incq	%r8
180006160:     	decq	%r14
180006163:     	jne	0x180006122 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2142>
180006165:     	movq	%r15, %r14
180006168:     	movq	0x158(%rsp), %r15
180006170:     	movq	0x170(%rsp), %r8
180006178:     	movq	0x160(%rsp), %r9
180006180:     	movq	%r9, 0x8(%r15,%r8,8)
180006185:     	movq	0x110(%rsp), %r8
18000618d:     	movq	0x150(%rsp), %r9
180006195:     	movq	%r8, 0x10(%r15,%r9,8)
18000619a:     	movq	0x140(%rsp), %rdx
1800061a2:     	leaq	0x1(%rdx), %r8
1800061a6:     	movq	%r8, (%r15,%rdi,8)
1800061aa:     	movq	0x298(%rsp), %r8
1800061b2:     	cmpb	$0x0, (%r8)
1800061b6:     	jne	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
1800061bc:     	xorl	%edi, %edi
1800061be:     	cmpq	$-0x2, %r10
1800061c2:     	movl	$0x0, %r8d
1800061c8:     	cmovlq	%rbx, %r8
1800061cc:     	addq	0x10(%r15,%r8,8), %rdx
1800061d1:     	movq	%rdx, %r8
1800061d4:     	sarq	$0x3f, %r8
1800061d8:     	andq	%rbx, %r8
1800061db:     	leaq	(%r14,%rdx,8), %rdx
1800061df:     	movq	%rsi, (%rdx,%r8,8)
1800061e3:     	cmpq	$-0x9, %rbp
1800061e7:     	movl	$0x0, %edx
1800061ec:     	cmovlq	%r12, %rdx
1800061f0:     	movq	0x1f0(%rsp), %r15
1800061f8:     	leaq	(%r15,%rbp,8), %r10
1800061fc:     	movsd	0x48(%r10,%rdx,8), %xmm1
180006203:     	cmpq	$-0xa, %rbp
180006207:     	movl	$0x0, %r9d
18000620d:     	cmovlq	%rbx, %r9
180006211:     	leaq	0x50(%r13), %r11
180006215:     	cmpq	$-0x1, %rsi
180006219:     	cmovlq	%r12, %rdi
18000621d:     	leaq	(%r15,%rsi,8), %r8
180006221:     	movsd	0x8(%r8,%rdi,8), %xmm2
180006228:     	movapd	%xmm1, %xmm0
18000622c:     	addsd	%xmm2, %xmm0
180006230:     	xorpd	%xmm3, %xmm3
180006234:     	ucomisd	%xmm3, %xmm0
180006238:     	jbe	0x1800062ca <PyInit_rcaotr_2c76336ff39711e0671e54df+0x22ea>
18000623e:     	movq	%r11, 0x110(%rsp)
180006246:     	movq	%r10, 0x120(%rsp)
18000624e:     	xorl	%r11d, %r11d
180006251:     	cmpq	$-0x2, %rbp
180006255:     	movl	$0x0, %ebp
18000625a:     	cmovlq	%rbx, %rbp
18000625e:     	movq	0x10(%r13,%rbp,8), %r8
180006263:     	movq	%r8, %r10
180006266:     	sarq	$0x3f, %r10
18000626a:     	andq	%r12, %r10
18000626d:     	leaq	(%r15,%r8,8), %r15
180006271:     	cmpq	$-0x1, %r8
180006275:     	cmovlq	%rbx, %r11
180006279:     	leaq	(%r14,%r8,8), %r14
18000627d:     	cmpq	$0x0, 0x8(%r14,%r11,8)
180006283:     	mulsd	(%r15,%r10,8), %xmm1
180006289:     	je	0x1800062df <PyInit_rcaotr_2c76336ff39711e0671e54df+0x22ff>
18000628b:     	leaq	0x50(%r13), %r14
18000628f:     	cmpq	$0x0, (%r14,%r9,8)
180006294:     	je	0x1800062df <PyInit_rcaotr_2c76336ff39711e0671e54df+0x22ff>
180006296:     	movapd	0x9122(%rip), %xmm3     # 0x18000f3c0
18000629e:     	andpd	%xmm1, %xmm3
1800062a2:     	ucomisd	0x9126(%rip), %xmm3     # 0x18000f3d0
1800062aa:     	movq	0x228(%rsp), %r14
1800062b2:     	jae	0x1800063d8 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x23f8>
1800062b8:     	movq	%r15, 0x128(%rsp)
1800062c0:     	xorpd	%xmm3, %xmm3
1800062c4:     	addsd	%xmm3, %xmm1
1800062c8:     	jmp	0x1800062ef <PyInit_rcaotr_2c76336ff39711e0671e54df+0x230f>
1800062ca:     	shlq	$0x3, %rdx
1800062ce:     	shlq	$0x3, %r9
1800062d2:     	movq	0x298(%rsp), %r15
1800062da:     	jmp	0x18000646b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x248b>
1800062df:     	movq	%r15, 0x128(%rsp)
1800062e7:     	movq	0x228(%rsp), %r14
1800062ef:     	leaq	0x10(%r14,%rsi,8), %r14
1800062f4:     	movq	%r14, 0x138(%rsp)
1800062fc:     	movq	(%r14,%rax,8), %r14
180006300:     	movq	0x1f0(%rsp), %r15
180006308:     	leaq	(%r15,%r14,8), %r15
18000630c:     	sarq	$0x3f, %r14
180006310:     	andq	%r12, %r14
180006313:     	mulsd	(%r15,%r14,8), %xmm2
180006319:     	addsd	%xmm1, %xmm2
18000631d:     	divsd	%xmm0, %xmm2
180006321:     	movq	0x128(%rsp), %r14
180006329:     	movsd	%xmm2, (%r14,%r10,8)
18000632f:     	shlq	$0x3, %r9
180006333:     	movq	0x228(%rsp), %r10
18000633b:     	leaq	0x8(%r10,%r8,8), %r8
180006340:     	movq	$0x0, (%r8,%r11,8)
180006348:     	movq	0x10(%r13,%rbp,8), %r8
18000634d:     	xorl	%r11d, %r11d
180006350:     	cmpq	$-0x2, %r8
180006354:     	movl	$0x0, %r10d
18000635a:     	cmovlq	%r12, %r10
18000635e:     	movq	0x1f0(%rsp), %r14
180006366:     	leaq	(%r14,%r8,8), %r14
18000636a:     	movsd	0x10(%r14,%r10,8), %xmm1
180006371:     	movq	0x228(%rsp), %r14
180006379:     	cmpq	$-0x3, %r8
18000637d:     	cmovgeq	%r11, %rbx
180006381:     	leaq	(%r14,%r8,8), %r11
180006385:     	cmpq	$0x0, 0x18(%r11,%rbx,8)
18000638b:     	movq	0x120(%rsp), %r11
180006393:     	mulsd	0x48(%r11,%rdx,8), %xmm1
18000639a:     	je	0x1800063f9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2419>
18000639c:     	cmpq	$0x0, 0x50(%r13,%r9)
1800063a2:     	movq	0x298(%rsp), %r15
1800063aa:     	movq	0x260(%rsp), %r11
1800063b2:     	je	0x180006401 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2421>
1800063b4:     	movapd	0x9004(%rip), %xmm2     # 0x18000f3c0
1800063bc:     	andpd	%xmm1, %xmm2
1800063c0:     	ucomisd	0x9008(%rip), %xmm2     # 0x18000f3d0
1800063c8:     	jae	0x180006487 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24a7>
1800063ce:     	xorpd	%xmm2, %xmm2
1800063d2:     	addsd	%xmm2, %xmm1
1800063d6:     	jmp	0x180006401 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2421>
1800063d8:     	movq	0x298(%rsp), %r15
1800063e0:     	movb	$0x1, (%r15)
1800063e4:     	movq	0x260(%rsp), %rax
1800063ec:     	movq	$0x895447, 0x18(%rax)   # imm = 0x895447
1800063f4:     	jmp	0x18000647a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x249a>
1800063f9:     	movq	0x298(%rsp), %r15
180006401:     	movq	0x1f0(%rsp), %r13
180006409:     	leaq	0x8(%r13,%rsi,8), %r11
18000640e:     	leaq	0x10(%r13,%r8,8), %rsi
180006413:     	leaq	0x18(%r14,%r8,8), %r8
180006418:     	shlq	$0x3, %rdx
18000641c:     	movq	0x138(%rsp), %r14
180006424:     	movq	(%r14,%rax,8), %rax
180006428:     	xorl	%r14d, %r14d
18000642b:     	cmpq	$-0x2, %rax
18000642f:     	cmovlq	%r12, %r14
180006433:     	leaq	(%r13,%rax,8), %rax
180006438:     	movsd	0x10(%rax,%r14,8), %xmm2
18000643f:     	mulsd	(%r11,%rdi,8), %xmm2
180006445:     	addsd	%xmm1, %xmm2
180006449:     	divsd	%xmm0, %xmm2
18000644d:     	movsd	%xmm2, (%rsi,%r10,8)
180006453:     	movq	$0x0, (%r8,%rbx,8)
18000645b:     	movq	0x120(%rsp), %r10
180006463:     	movq	0x110(%rsp), %r11
18000646b:     	movsd	%xmm0, 0x48(%r10,%rdx)
180006472:     	movq	$0x0, (%r11,%r9)
18000647a:     	cmpb	$0x0, (%r15)
18000647e:     	sete	%dil
180006482:     	jmp	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006487:     	movb	$0x1, (%r15)
18000648b:     	movq	$0x895449, 0x18(%r11)   # imm = 0x895449
180006493:     	jmp	0x18000647a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x249a>
180006495:     	xorl	%ecx, %ecx
180006497:     	cmpq	$-0x7, %rbp
18000649b:     	cmovlq	%rbx, %rcx
18000649f:     	movq	0x38(%r13,%rcx,8), %rcx
1800064a4:     	testq	%rcx, %rcx
1800064a7:     	js	0x1800064d3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24f3>
1800064a9:     	movq	%rax, 0x8(%r15)
1800064ad:     	cmpq	0x10(%r15), %rax
1800064b1:     	jle	0x1800064eb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x250b>
1800064b3:     	movq	0x298(%rsp), %rax
1800064bb:     	movb	$0x1, (%rax)
1800064be:     	movq	0x260(%rsp), %rax
1800064c6:     	movq	$0x2dc6cf, 0x18(%rax)   # imm = 0x2DC6CF
1800064ce:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
1800064d3:     	movq	0x298(%rsp), %rax
1800064db:     	movb	$0x1, (%rax)
1800064de:     	movq	$0x2dc6cf, 0x18(%r15)   # imm = 0x2DC6CF
1800064e6:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
1800064eb:     	movb	$0x0, 0x11d(%rsp)
1800064f3:     	movq	%rsi, 0x100(%rsp)
1800064fb:     	movq	%rcx, 0xf8(%rsp)
180006503:     	movq	0x2a8(%rsp), %rax
18000650b:     	movq	%rax, 0xe8(%rsp)
180006513:     	movq	0x2a0(%rsp), %rax
18000651b:     	movq	%rax, 0xe0(%rsp)
180006523:     	movq	0x298(%rsp), %r14
18000652b:     	movq	%r14, 0xd8(%rsp)
180006533:     	movq	0x290(%rsp), %rax
18000653b:     	movq	%rax, 0xd0(%rsp)
180006543:     	movq	0x288(%rsp), %rax
18000654b:     	movq	%rax, 0xc8(%rsp)
180006553:     	movq	0x280(%rsp), %rax
18000655b:     	movq	%rax, 0xc0(%rsp)
180006563:     	movq	0x278(%rsp), %rax
18000656b:     	movq	%rax, 0xb8(%rsp)
180006573:     	movq	0x270(%rsp), %rax
18000657b:     	movq	%rax, 0xb0(%rsp)
180006583:     	movq	0x268(%rsp), %rax
18000658b:     	movq	%rax, 0xa8(%rsp)
180006593:     	movq	0x260(%rsp), %rax
18000659b:     	movq	%rax, 0xa0(%rsp)
1800065a3:     	movq	0x258(%rsp), %rax
1800065ab:     	movq	%rax, 0x98(%rsp)
1800065b3:     	movq	0x250(%rsp), %rax
1800065bb:     	movq	%rax, 0x90(%rsp)
1800065c3:     	movq	0x248(%rsp), %rax
1800065cb:     	movq	%rax, 0x88(%rsp)
1800065d3:     	movq	0x240(%rsp), %rax
1800065db:     	movq	%rax, 0x80(%rsp)
1800065e3:     	movq	0x238(%rsp), %rax
1800065eb:     	movq	%rax, 0x78(%rsp)
1800065f0:     	movq	%rbx, 0x70(%rsp)
1800065f5:     	movq	0x228(%rsp), %rax
1800065fd:     	movq	%rax, 0x68(%rsp)
180006602:     	movq	0x220(%rsp), %rax
18000660a:     	movq	%rax, 0x60(%rsp)
18000660f:     	movq	0x218(%rsp), %rax
180006617:     	movq	%rax, 0x58(%rsp)
18000661c:     	movq	0x210(%rsp), %rax
180006624:     	movq	%rax, 0x50(%rsp)
180006629:     	movq	0x208(%rsp), %rax
180006631:     	movq	%rax, 0x48(%rsp)
180006636:     	movq	0x200(%rsp), %rax
18000663e:     	movq	%rax, 0x40(%rsp)
180006643:     	movq	%r12, 0x38(%rsp)
180006648:     	movq	0x1f0(%rsp), %rax
180006650:     	movq	%rax, 0x30(%rsp)
180006655:     	movq	0x1e8(%rsp), %rax
18000665d:     	movq	%rax, 0x28(%rsp)
180006662:     	movq	0x1e0(%rsp), %rax
18000666a:     	movq	%rax, 0x20(%rsp)
18000666f:     	movq	$-0x1, 0x108(%rsp)
18000667b:     	movq	$0x0, 0xf0(%rsp)
180006687:     	leaq	0x11d(%rsp), %rcx
18000668f:     	movq	0x138(%rsp), %r8
180006697:     	movq	0x128(%rsp), %r9
18000669f:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
1800066a4:     	cmpb	$0x0, (%r14)
1800066a8:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
1800066ae:     	movq	0x260(%rsp), %rdx
1800066b6:     	movq	0x8(%rdx), %rax
1800066ba:     	leaq	-0x1(%rax), %rcx
1800066be:     	cmpb	$0x0, 0x11d(%rsp)
1800066c6:     	movq	%rcx, 0x8(%rdx)
1800066ca:     	movq	0x110(%rsp), %rcx
1800066d2:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800066d8:     	xorl	%ecx, %ecx
1800066da:     	cmpq	$-0x8, %rbp
1800066de:     	cmovlq	%rbx, %rcx
1800066e2:     	movq	0x40(%r13,%rcx,8), %rcx
1800066e7:     	testq	%rcx, %rcx
1800066ea:     	js	0x1800066fa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x271a>
1800066ec:     	movq	%rax, 0x8(%rdx)
1800066f0:     	cmpq	0x10(%rdx), %rax
1800066f4:     	jle	0x180007b1f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3b3f>
1800066fa:     	movq	0x298(%rsp), %rax
180006702:     	movb	$0x1, (%rax)
180006705:     	movq	0x260(%rsp), %rax
18000670d:     	movq	$0x2dc6d0, 0x18(%rax)   # imm = 0x2DC6D0
180006715:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
18000671a:     	movq	0x260(%rsp), %r8
180006722:     	movq	%rcx, (%r8)
180006725:     	movq	0x298(%rsp), %rcx
18000672d:     	cmpb	$0x0, (%rcx)
180006730:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006736:     	subsd	%xmm1, %xmm3
18000673a:     	xorl	%edi, %edi
18000673c:     	cmpq	$-0x2, %r10
180006740:     	movl	$0x0, %ecx
180006745:     	cmovlq	%r12, %rcx
180006749:     	movq	0x1f0(%rsp), %r8
180006751:     	leaq	(%r8,%r10,8), %r8
180006755:     	movsd	%xmm3, 0x10(%r8,%rcx,8)
18000675c:     	cmpq	$-0x3, %r10
180006760:     	movl	$0x0, %ecx
180006765:     	cmovlq	%r12, %rcx
180006769:     	movsd	%xmm5, 0x18(%r8,%rcx,8)
180006770:     	cmpq	$-0x1, %r10
180006774:     	movl	$0x0, %ecx
180006779:     	cmovlq	%r12, %rcx
18000677d:     	movsd	%xmm1, 0x8(%r8,%rcx,8)
180006784:     	movq	%r10, %rcx
180006787:     	sarq	$0x3f, %rcx
18000678b:     	andq	%r12, %rcx
18000678e:     	movsd	%xmm0, (%r8,%rcx,8)
180006794:     	movq	0x298(%rsp), %rcx
18000679c:     	cmpb	$0x0, (%rcx)
18000679f:     	movq	0x110(%rsp), %rcx
1800067a7:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800067ad:     	movq	0x260(%rsp), %rcx
1800067b5:     	movq	(%rcx), %r8
1800067b8:     	leaq	0xb(%r8), %r9
1800067bc:     	cmpq	%rbx, %r9
1800067bf:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
1800067c5:     	movq	0x120(%rsp), %rcx
1800067cd:     	movq	0x8(%rcx,%rdx,8), %rcx
1800067d2:     	movq	0x260(%rsp), %r11
1800067da:     	movq	%r9, (%r11)
1800067dd:     	movq	0x298(%rsp), %r9
1800067e5:     	cmpb	$0x0, (%r9)
1800067e9:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
1800067ef:     	movq	%r8, %r11
1800067f2:     	sarq	$0x3f, %r11
1800067f6:     	andq	%rbx, %r11
1800067f9:     	movq	0x228(%rsp), %r9
180006801:     	leaq	(%r9,%r8,8), %r9
180006805:     	movq	%r10, (%r9,%r11,8)
180006809:     	xorl	%r10d, %r10d
18000680c:     	cmpq	$-0x1, %r8
180006810:     	cmovlq	%rbx, %r10
180006814:     	movq	%rcx, 0x8(%r9,%r10,8)
180006819:     	movq	0x260(%rsp), %rcx
180006821:     	movq	(%rcx), %r10
180006824:     	cmpq	%rbx, %r10
180006827:     	movq	%r10, %rcx
18000682a:     	jle	0x180006844 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2864>
18000682c:     	movq	0x298(%rsp), %rcx
180006834:     	movb	$0x2, (%rcx)
180006837:     	movq	0x260(%rsp), %rcx
18000683f:     	movq	(%rcx), %r10
180006842:     	xorl	%ecx, %ecx
180006844:     	leaq	0x3(%r10), %r11
180006848:     	cmpq	%rbx, %r11
18000684b:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006851:     	movq	0x260(%rsp), %rdi
180006859:     	movq	%r11, (%rdi)
18000685c:     	movq	0x298(%rsp), %r11
180006864:     	cmpb	$0x0, (%r11)
180006868:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
18000686e:     	movq	%r10, %r11
180006871:     	sarq	$0x3f, %r11
180006875:     	andq	%rbx, %r11
180006878:     	movq	0x228(%rsp), %rdi
180006880:     	leaq	(%rdi,%r10,8), %r14
180006884:     	movq	$0x0, (%r14,%r11,8)
18000688c:     	xorl	%edi, %edi
18000688e:     	cmpq	$-0x1, %r10
180006892:     	movl	$0x0, %r11d
180006898:     	cmovlq	%rbx, %r11
18000689c:     	movq	$0x0, 0x8(%r14,%r11,8)
1800068a5:     	cmpq	$-0x2, %r10
1800068a9:     	movl	$0x0, %r11d
1800068af:     	cmovlq	%rbx, %r11
1800068b3:     	movq	%rcx, 0x10(%r14,%r11,8)
1800068b8:     	movq	0x298(%rsp), %rcx
1800068c0:     	cmpb	$0x0, (%rcx)
1800068c3:     	movq	0x110(%rsp), %rcx
1800068cb:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800068d1:     	xorl	%ecx, %ecx
1800068d3:     	cmpq	$-0x6, %r8
1800068d7:     	movl	$0x0, %r11d
1800068dd:     	cmovlq	%rbx, %r11
1800068e1:     	movq	%r10, 0x30(%r9,%r11,8)
1800068e6:     	cmpq	$-0x3, %r8
1800068ea:     	cmovlq	%rbx, %rcx
1800068ee:     	movq	$0x0, 0x18(%r9,%rcx,8)
1800068f7:     	movq	0x260(%rsp), %rcx
1800068ff:     	movq	(%rcx), %r10
180006902:     	leaq	0x4(%r10), %rcx
180006906:     	cmpq	%rbx, %rcx
180006909:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
18000690f:     	movq	0x260(%rsp), %r11
180006917:     	movq	%rcx, (%r11)
18000691a:     	movq	0x298(%rsp), %rcx
180006922:     	cmpb	$0x0, (%rcx)
180006925:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
18000692b:     	movq	%r10, %rcx
18000692e:     	sarq	$0x3f, %rcx
180006932:     	andq	%r12, %rcx
180006935:     	movq	0x1f0(%rsp), %r11
18000693d:     	leaq	(%r11,%r10,8), %r11
180006941:     	movq	$0x0, (%r11,%rcx,8)
180006949:     	xorl	%edi, %edi
18000694b:     	cmpq	$-0x1, %r10
18000694f:     	movl	$0x0, %ecx
180006954:     	cmovlq	%rbx, %rcx
180006958:     	movq	0x228(%rsp), %r14
180006960:     	leaq	(%r14,%r10,8), %r14
180006964:     	movq	$0x1, 0x8(%r14,%rcx,8)
18000696d:     	cmpq	$-0x2, %r10
180006971:     	movl	$0x0, %ecx
180006976:     	cmovlq	%r12, %rcx
18000697a:     	movq	$0x0, 0x10(%r11,%rcx,8)
180006983:     	cmpq	$-0x3, %r10
180006987:     	movl	$0x0, %ecx
18000698c:     	cmovlq	%rbx, %rcx
180006990:     	movq	$0x1, 0x18(%r14,%rcx,8)
180006999:     	movq	0x298(%rsp), %rcx
1800069a1:     	cmpb	$0x0, (%rcx)
1800069a4:     	movq	0x110(%rsp), %rcx
1800069ac:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800069b2:     	xorl	%edi, %edi
1800069b4:     	cmpq	$-0x2, %r8
1800069b8:     	movl	$0x0, %r11d
1800069be:     	cmovlq	%rbx, %r11
1800069c2:     	movq	%r10, 0x10(%r9,%r11,8)
1800069c7:     	cmpq	$-0x9, %r8
1800069cb:     	movl	$0x0, %r10d
1800069d1:     	cmovlq	%r12, %r10
1800069d5:     	movq	0x1f0(%rsp), %r11
1800069dd:     	leaq	(%r11,%r8,8), %r11
1800069e1:     	movq	$0x0, 0x48(%r11,%r10,8)
1800069ea:     	cmpq	$-0xa, %r8
1800069ee:     	movl	$0x0, %r10d
1800069f4:     	cmovlq	%rbx, %r10
1800069f8:     	movq	$0x1, 0x50(%r9,%r10,8)
180006a01:     	cmpq	$-0x4, %r8
180006a05:     	movl	$0x0, %r10d
180006a0b:     	cmovlq	%rbx, %r10
180006a0f:     	movq	$-0x1, 0x20(%r9,%r10,8)
180006a18:     	cmpq	$-0x5, %r8
180006a1c:     	movl	$0x0, %r10d
180006a22:     	cmovlq	%rbx, %r10
180006a26:     	movq	$-0x1, 0x28(%r9,%r10,8)
180006a2f:     	cmpq	$-0x7, %r8
180006a33:     	movl	$0x0, %r10d
180006a39:     	cmovlq	%rbx, %r10
180006a3d:     	movq	$-0x1, 0x38(%r9,%r10,8)
180006a46:     	cmpq	$-0x8, %r8
180006a4a:     	movl	$0x0, %r10d
180006a50:     	cmovlq	%rbx, %r10
180006a54:     	movq	$-0x1, 0x40(%r9,%r10,8)
180006a5d:     	movq	0x298(%rsp), %r9
180006a65:     	cmpb	$0x0, (%r9)
180006a69:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006a6f:     	xorl	%r13d, %r13d
180006a72:     	cmpq	$-0x5, %rax
180006a76:     	cmovlq	%rbx, %r13
180006a7a:     	movq	0x120(%rsp), %rcx
180006a82:     	movq	%r8, 0x28(%rcx,%r13,8)
180006a87:     	movq	0x260(%rsp), %rcx
180006a8f:     	movq	(%rcx), %r10
180006a92:     	leaq	0x4(%r10), %rcx
180006a96:     	cmpq	%rbx, %rcx
180006a99:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006a9f:     	movq	0x260(%rsp), %r8
180006aa7:     	movq	%rcx, (%r8)
180006aaa:     	movq	0x298(%rsp), %rcx
180006ab2:     	cmpb	$0x0, (%rcx)
180006ab5:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006abb:     	addsd	%xmm0, %xmm2
180006abf:     	xorl	%edi, %edi
180006ac1:     	cmpq	$-0x2, %r10
180006ac5:     	movl	$0x0, %ecx
180006aca:     	cmovlq	%r12, %rcx
180006ace:     	movq	0x1f0(%rsp), %r8
180006ad6:     	leaq	(%r8,%r10,8), %r8
180006ada:     	movsd	%xmm4, 0x10(%r8,%rcx,8)
180006ae1:     	cmpq	$-0x3, %r10
180006ae5:     	movl	$0x0, %ecx
180006aea:     	cmovlq	%r12, %rcx
180006aee:     	movsd	%xmm2, 0x18(%r8,%rcx,8)
180006af5:     	cmpq	$-0x1, %r10
180006af9:     	movl	$0x0, %ecx
180006afe:     	cmovlq	%r12, %rcx
180006b02:     	movsd	%xmm1, 0x8(%r8,%rcx,8)
180006b09:     	movq	%r10, %rcx
180006b0c:     	sarq	$0x3f, %rcx
180006b10:     	andq	%r12, %rcx
180006b13:     	movsd	%xmm0, (%r8,%rcx,8)
180006b19:     	movq	0x298(%rsp), %rcx
180006b21:     	cmpb	$0x0, (%rcx)
180006b24:     	movq	0x110(%rsp), %rcx
180006b2c:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006b32:     	movq	0x260(%rsp), %rcx
180006b3a:     	movq	(%rcx), %r8
180006b3d:     	leaq	0xb(%r8), %r9
180006b41:     	cmpq	%rbx, %r9
180006b44:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006b4a:     	movq	0x120(%rsp), %rcx
180006b52:     	movq	0x8(%rcx,%rdx,8), %rcx
180006b57:     	movq	0x260(%rsp), %r11
180006b5f:     	movq	%r9, (%r11)
180006b62:     	movq	0x298(%rsp), %r9
180006b6a:     	cmpb	$0x0, (%r9)
180006b6e:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006b74:     	movq	%r8, %r11
180006b77:     	sarq	$0x3f, %r11
180006b7b:     	andq	%rbx, %r11
180006b7e:     	movq	0x228(%rsp), %r9
180006b86:     	leaq	(%r9,%r8,8), %r9
180006b8a:     	movq	%r10, (%r9,%r11,8)
180006b8e:     	xorl	%r10d, %r10d
180006b91:     	cmpq	$-0x1, %r8
180006b95:     	cmovlq	%rbx, %r10
180006b99:     	movq	%rcx, 0x8(%r9,%r10,8)
180006b9e:     	movq	0x260(%rsp), %rcx
180006ba6:     	movq	(%rcx), %r10
180006ba9:     	cmpq	%rbx, %r10
180006bac:     	movq	%r10, %rcx
180006baf:     	jle	0x180006bc9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2be9>
180006bb1:     	movq	0x298(%rsp), %rcx
180006bb9:     	movb	$0x2, (%rcx)
180006bbc:     	movq	0x260(%rsp), %rcx
180006bc4:     	movq	(%rcx), %r10
180006bc7:     	xorl	%ecx, %ecx
180006bc9:     	leaq	0x3(%r10), %r11
180006bcd:     	cmpq	%rbx, %r11
180006bd0:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006bd6:     	movq	0x260(%rsp), %rdi
180006bde:     	movq	%r11, (%rdi)
180006be1:     	movq	0x298(%rsp), %r11
180006be9:     	cmpb	$0x0, (%r11)
180006bed:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006bf3:     	movq	%r10, %r11
180006bf6:     	sarq	$0x3f, %r11
180006bfa:     	andq	%rbx, %r11
180006bfd:     	movq	0x228(%rsp), %rdi
180006c05:     	leaq	(%rdi,%r10,8), %r14
180006c09:     	movq	$0x0, (%r14,%r11,8)
180006c11:     	xorl	%edi, %edi
180006c13:     	cmpq	$-0x1, %r10
180006c17:     	movl	$0x0, %r11d
180006c1d:     	cmovlq	%rbx, %r11
180006c21:     	movq	$0x0, 0x8(%r14,%r11,8)
180006c2a:     	cmpq	$-0x2, %r10
180006c2e:     	movl	$0x0, %r11d
180006c34:     	cmovlq	%rbx, %r11
180006c38:     	movq	%rcx, 0x10(%r14,%r11,8)
180006c3d:     	movq	0x298(%rsp), %rcx
180006c45:     	cmpb	$0x0, (%rcx)
180006c48:     	movq	0x110(%rsp), %rcx
180006c50:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006c56:     	xorl	%ecx, %ecx
180006c58:     	cmpq	$-0x6, %r8
180006c5c:     	movl	$0x0, %r11d
180006c62:     	cmovlq	%rbx, %r11
180006c66:     	movq	%r10, 0x30(%r9,%r11,8)
180006c6b:     	cmpq	$-0x3, %r8
180006c6f:     	cmovlq	%rbx, %rcx
180006c73:     	movq	$0x0, 0x18(%r9,%rcx,8)
180006c7c:     	movq	0x260(%rsp), %rcx
180006c84:     	movq	(%rcx), %r10
180006c87:     	leaq	0x4(%r10), %rcx
180006c8b:     	cmpq	%rbx, %rcx
180006c8e:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006c94:     	movq	0x260(%rsp), %r11
180006c9c:     	movq	%rcx, (%r11)
180006c9f:     	movq	0x298(%rsp), %rcx
180006ca7:     	cmpb	$0x0, (%rcx)
180006caa:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006cb0:     	movq	%r10, %rcx
180006cb3:     	sarq	$0x3f, %rcx
180006cb7:     	andq	%r12, %rcx
180006cba:     	movq	0x1f0(%rsp), %r11
180006cc2:     	leaq	(%r11,%r10,8), %r11
180006cc6:     	movq	$0x0, (%r11,%rcx,8)
180006cce:     	xorl	%edi, %edi
180006cd0:     	cmpq	$-0x1, %r10
180006cd4:     	movl	$0x0, %ecx
180006cd9:     	cmovlq	%rbx, %rcx
180006cdd:     	movq	0x228(%rsp), %r14
180006ce5:     	leaq	(%r14,%r10,8), %r14
180006ce9:     	movq	$0x1, 0x8(%r14,%rcx,8)
180006cf2:     	cmpq	$-0x2, %r10
180006cf6:     	movl	$0x0, %ecx
180006cfb:     	cmovlq	%r12, %rcx
180006cff:     	movq	$0x0, 0x10(%r11,%rcx,8)
180006d08:     	cmpq	$-0x3, %r10
180006d0c:     	movl	$0x0, %ecx
180006d11:     	cmovlq	%rbx, %rcx
180006d15:     	movq	$0x1, 0x18(%r14,%rcx,8)
180006d1e:     	movq	0x298(%rsp), %rcx
180006d26:     	cmpb	$0x0, (%rcx)
180006d29:     	movq	0x110(%rsp), %rcx
180006d31:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006d37:     	xorl	%edi, %edi
180006d39:     	cmpq	$-0x2, %r8
180006d3d:     	movl	$0x0, %r11d
180006d43:     	cmovlq	%rbx, %r11
180006d47:     	movq	%r10, 0x10(%r9,%r11,8)
180006d4c:     	cmpq	$-0x9, %r8
180006d50:     	movl	$0x0, %r10d
180006d56:     	cmovlq	%r12, %r10
180006d5a:     	movq	0x1f0(%rsp), %r11
180006d62:     	leaq	(%r11,%r8,8), %r11
180006d66:     	movq	$0x0, 0x48(%r11,%r10,8)
180006d6f:     	cmpq	$-0xa, %r8
180006d73:     	movl	$0x0, %r10d
180006d79:     	cmovlq	%rbx, %r10
180006d7d:     	movq	$0x1, 0x50(%r9,%r10,8)
180006d86:     	cmpq	$-0x4, %r8
180006d8a:     	movl	$0x0, %r10d
180006d90:     	cmovlq	%rbx, %r10
180006d94:     	movq	$-0x1, 0x20(%r9,%r10,8)
180006d9d:     	cmpq	$-0x5, %r8
180006da1:     	movl	$0x0, %r10d
180006da7:     	cmovlq	%rbx, %r10
180006dab:     	movq	$-0x1, 0x28(%r9,%r10,8)
180006db4:     	cmpq	$-0x7, %r8
180006db8:     	movl	$0x0, %r10d
180006dbe:     	cmovlq	%rbx, %r10
180006dc2:     	movq	$-0x1, 0x38(%r9,%r10,8)
180006dcb:     	cmpq	$-0x8, %r8
180006dcf:     	movl	$0x0, %r10d
180006dd5:     	cmovlq	%rbx, %r10
180006dd9:     	movq	$-0x1, 0x40(%r9,%r10,8)
180006de2:     	movq	0x298(%rsp), %r9
180006dea:     	cmpb	$0x0, (%r9)
180006dee:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006df4:     	xorl	%ebp, %ebp
180006df6:     	cmpq	$-0x7, %rax
180006dfa:     	cmovlq	%rbx, %rbp
180006dfe:     	movq	0x120(%rsp), %rcx
180006e06:     	movq	%r8, 0x38(%rcx,%rbp,8)
180006e0b:     	movq	0x260(%rsp), %rcx
180006e13:     	movq	(%rcx), %r9
180006e16:     	leaq	0x4(%r9), %rcx
180006e1a:     	cmpq	%rbx, %rcx
180006e1d:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006e23:     	movq	0x260(%rsp), %r8
180006e2b:     	movq	%rcx, (%r8)
180006e2e:     	movq	0x298(%rsp), %rcx
180006e36:     	cmpb	$0x0, (%rcx)
180006e39:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006e3f:     	xorl	%edi, %edi
180006e41:     	cmpq	$-0x2, %r9
180006e45:     	movl	$0x0, %ecx
180006e4a:     	cmovlq	%r12, %rcx
180006e4e:     	movq	0x1f0(%rsp), %r8
180006e56:     	leaq	(%r8,%r9,8), %r8
180006e5a:     	movsd	%xmm3, 0x10(%r8,%rcx,8)
180006e61:     	cmpq	$-0x3, %r9
180006e65:     	movl	$0x0, %ecx
180006e6a:     	cmovlq	%r12, %rcx
180006e6e:     	movsd	%xmm2, 0x18(%r8,%rcx,8)
180006e75:     	cmpq	$-0x1, %r9
180006e79:     	movl	$0x0, %ecx
180006e7e:     	cmovlq	%r12, %rcx
180006e82:     	movsd	%xmm1, 0x8(%r8,%rcx,8)
180006e89:     	movq	%r9, %rcx
180006e8c:     	sarq	$0x3f, %rcx
180006e90:     	andq	%r12, %rcx
180006e93:     	movsd	%xmm0, (%r8,%rcx,8)
180006e99:     	movq	0x298(%rsp), %rcx
180006ea1:     	cmpb	$0x0, (%rcx)
180006ea4:     	movq	0x110(%rsp), %rcx
180006eac:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006eb2:     	movq	0x260(%rsp), %rcx
180006eba:     	movq	(%rcx), %r8
180006ebd:     	leaq	0xb(%r8), %r10
180006ec1:     	cmpq	%rbx, %r10
180006ec4:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006eca:     	movq	0x120(%rsp), %rcx
180006ed2:     	movq	0x8(%rcx,%rdx,8), %rcx
180006ed7:     	movq	0x260(%rsp), %rdx
180006edf:     	movq	%r10, (%rdx)
180006ee2:     	movq	0x298(%rsp), %rdx
180006eea:     	cmpb	$0x0, (%rdx)
180006eed:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006ef3:     	movq	%r8, %r10
180006ef6:     	sarq	$0x3f, %r10
180006efa:     	andq	%rbx, %r10
180006efd:     	movq	0x228(%rsp), %rdx
180006f05:     	leaq	(%rdx,%r8,8), %rdx
180006f09:     	movq	%r9, (%rdx,%r10,8)
180006f0d:     	xorl	%r9d, %r9d
180006f10:     	cmpq	$-0x1, %r8
180006f14:     	cmovlq	%rbx, %r9
180006f18:     	movq	%rcx, 0x8(%rdx,%r9,8)
180006f1d:     	movq	0x260(%rsp), %rcx
180006f25:     	movq	(%rcx), %r9
180006f28:     	cmpq	%rbx, %r9
180006f2b:     	movq	%r9, %rcx
180006f2e:     	jle	0x180006f48 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x2f68>
180006f30:     	movq	0x298(%rsp), %rcx
180006f38:     	movb	$0x2, (%rcx)
180006f3b:     	movq	0x260(%rsp), %rcx
180006f43:     	movq	(%rcx), %r9
180006f46:     	xorl	%ecx, %ecx
180006f48:     	leaq	0x3(%r9), %r10
180006f4c:     	cmpq	%rbx, %r10
180006f4f:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180006f55:     	movq	0x260(%rsp), %r11
180006f5d:     	movq	%r10, (%r11)
180006f60:     	movq	0x298(%rsp), %r10
180006f68:     	cmpb	$0x0, (%r10)
180006f6c:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180006f72:     	movq	%r9, %r10
180006f75:     	sarq	$0x3f, %r10
180006f79:     	andq	%rbx, %r10
180006f7c:     	movq	0x228(%rsp), %r11
180006f84:     	leaq	(%r11,%r9,8), %r11
180006f88:     	movq	$0x0, (%r11,%r10,8)
180006f90:     	xorl	%edi, %edi
180006f92:     	cmpq	$-0x1, %r9
180006f96:     	movl	$0x0, %r10d
180006f9c:     	cmovlq	%rbx, %r10
180006fa0:     	movq	$0x0, 0x8(%r11,%r10,8)
180006fa9:     	cmpq	$-0x2, %r9
180006fad:     	movl	$0x0, %r10d
180006fb3:     	cmovlq	%rbx, %r10
180006fb7:     	movq	%rcx, 0x10(%r11,%r10,8)
180006fbc:     	movq	0x298(%rsp), %rcx
180006fc4:     	cmpb	$0x0, (%rcx)
180006fc7:     	movq	0x110(%rsp), %rcx
180006fcf:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180006fd5:     	xorl	%ecx, %ecx
180006fd7:     	cmpq	$-0x6, %r8
180006fdb:     	movl	$0x0, %r10d
180006fe1:     	cmovlq	%rbx, %r10
180006fe5:     	movq	%r9, 0x30(%rdx,%r10,8)
180006fea:     	cmpq	$-0x3, %r8
180006fee:     	cmovlq	%rbx, %rcx
180006ff2:     	movq	$0x0, 0x18(%rdx,%rcx,8)
180006ffb:     	movq	0x260(%rsp), %rcx
180007003:     	movq	(%rcx), %r9
180007006:     	leaq	0x4(%r9), %rcx
18000700a:     	cmpq	%rbx, %rcx
18000700d:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180007013:     	movq	0x260(%rsp), %r10
18000701b:     	movq	%rcx, (%r10)
18000701e:     	movq	0x298(%rsp), %rcx
180007026:     	cmpb	$0x0, (%rcx)
180007029:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
18000702f:     	movq	%r9, %rcx
180007032:     	sarq	$0x3f, %rcx
180007036:     	andq	%r12, %rcx
180007039:     	movq	0x1f0(%rsp), %r10
180007041:     	leaq	(%r10,%r9,8), %r10
180007045:     	movq	$0x0, (%r10,%rcx,8)
18000704d:     	xorl	%edi, %edi
18000704f:     	cmpq	$-0x1, %r9
180007053:     	movl	$0x0, %ecx
180007058:     	cmovlq	%rbx, %rcx
18000705c:     	movq	0x228(%rsp), %r11
180007064:     	leaq	(%r11,%r9,8), %r11
180007068:     	movq	$0x1, 0x8(%r11,%rcx,8)
180007071:     	cmpq	$-0x2, %r9
180007075:     	movl	$0x0, %ecx
18000707a:     	cmovlq	%r12, %rcx
18000707e:     	movq	$0x0, 0x10(%r10,%rcx,8)
180007087:     	cmpq	$-0x3, %r9
18000708b:     	movl	$0x0, %ecx
180007090:     	cmovlq	%rbx, %rcx
180007094:     	movq	$0x1, 0x18(%r11,%rcx,8)
18000709d:     	movq	0x298(%rsp), %rcx
1800070a5:     	cmpb	$0x0, (%rcx)
1800070a8:     	movq	0x110(%rsp), %rcx
1800070b0:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
1800070b6:     	xorl	%edi, %edi
1800070b8:     	cmpq	$-0x2, %r8
1800070bc:     	movl	$0x0, %r10d
1800070c2:     	cmovlq	%rbx, %r10
1800070c6:     	movq	%r9, 0x10(%rdx,%r10,8)
1800070cb:     	cmpq	$-0x9, %r8
1800070cf:     	movl	$0x0, %r9d
1800070d5:     	cmovlq	%r12, %r9
1800070d9:     	movq	0x1f0(%rsp), %r10
1800070e1:     	leaq	(%r10,%r8,8), %r10
1800070e5:     	movq	$0x0, 0x48(%r10,%r9,8)
1800070ee:     	cmpq	$-0xa, %r8
1800070f2:     	movl	$0x0, %r9d
1800070f8:     	cmovlq	%rbx, %r9
1800070fc:     	movq	$0x1, 0x50(%rdx,%r9,8)
180007105:     	cmpq	$-0x4, %r8
180007109:     	movl	$0x0, %r9d
18000710f:     	cmovlq	%rbx, %r9
180007113:     	movq	$-0x1, 0x20(%rdx,%r9,8)
18000711c:     	cmpq	$-0x5, %r8
180007120:     	movl	$0x0, %r9d
180007126:     	cmovlq	%rbx, %r9
18000712a:     	movq	$-0x1, 0x28(%rdx,%r9,8)
180007133:     	cmpq	$-0x7, %r8
180007137:     	movl	$0x0, %r9d
18000713d:     	cmovlq	%rbx, %r9
180007141:     	movq	$-0x1, 0x38(%rdx,%r9,8)
18000714a:     	cmpq	$-0x8, %r8
18000714e:     	movl	$0x0, %r9d
180007154:     	cmovlq	%rbx, %r9
180007158:     	movq	$-0x1, 0x40(%rdx,%r9,8)
180007161:     	movq	0x298(%rsp), %rdx
180007169:     	cmpb	$0x0, (%rdx)
18000716c:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180007172:     	xorl	%r15d, %r15d
180007175:     	cmpq	$-0x8, %rax
180007179:     	movl	$0x0, %ecx
18000717e:     	cmovlq	%rbx, %rcx
180007182:     	movq	0x120(%rsp), %rdx
18000718a:     	movq	%rcx, 0x160(%rsp)
180007192:     	movq	%r8, 0x40(%rdx,%rcx,8)
180007197:     	cmpq	$-0x3, %rax
18000719b:     	movl	$0x0, %ecx
1800071a0:     	cmovlq	%rbx, %rcx
1800071a4:     	movq	$0x1, 0x18(%rdx,%rcx,8)
1800071ad:     	cmpq	$-0x6, %rax
1800071b1:     	cmovlq	%rbx, %r15
1800071b5:     	movq	0x30(%rdx,%r15,8), %rax
1800071ba:     	movq	%rax, %rdx
1800071bd:     	sarq	$0x3f, %rdx
1800071c1:     	andq	%rbx, %rdx
1800071c4:     	movq	0x228(%rsp), %rcx
1800071cc:     	leaq	(%rcx,%rax,8), %rcx
1800071d0:     	movq	%rdx, 0x158(%rsp)
1800071d8:     	movq	%rcx, 0x140(%rsp)
1800071e0:     	cmpq	$0x0, (%rcx,%rdx,8)
1800071e5:     	jle	0x180007a5d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3a7d>
1800071eb:     	leaq	(,%rbx,8), %rcx
1800071f3:     	xorl	%edi, %edi
1800071f5:     	cmpq	$-0x2, %rax
1800071f9:     	cmovgeq	%rdi, %rcx
1800071fd:     	movq	%rcx, 0x150(%rsp)
180007205:     	movq	0x120(%rsp), %rax
18000720d:     	movq	0x20(%rax,%rsi,8), %rax
180007212:     	testq	%rax, %rax
180007215:     	js	0x180007cfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d1a>
18000721b:     	movq	0x140(%rsp), %rcx
180007223:     	movq	0x150(%rsp), %rdx
18000722b:     	movq	0x10(%rcx,%rdx), %rcx
180007230:     	addq	%rdi, %rcx
180007233:     	movq	0x228(%rsp), %rdx
18000723b:     	leaq	(%rdx,%rcx,8), %rdx
18000723f:     	sarq	$0x3f, %rcx
180007243:     	andq	%rbx, %rcx
180007246:     	movq	(%rdx,%rcx,8), %rcx
18000724a:     	movq	%rcx, 0x148(%rsp)
180007252:     	movq	0x260(%rsp), %r8
18000725a:     	movq	0x8(%r8), %rcx
18000725e:     	leaq	0x1(%rcx), %rdx
180007262:     	movq	%rdx, 0x8(%r8)
180007266:     	cmpq	0x10(%r8), %rcx
18000726a:     	jge	0x180007cfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d1a>
180007270:     	movq	0x148(%rsp), %rcx
180007278:     	movq	%rcx, 0x100(%rsp)
180007280:     	movq	%rax, 0xf8(%rsp)
180007288:     	movq	0x2a8(%rsp), %rax
180007290:     	movq	%rax, 0xe8(%rsp)
180007298:     	movq	0x2a0(%rsp), %rax
1800072a0:     	movq	%rax, 0xe0(%rsp)
1800072a8:     	movq	0x298(%rsp), %r14
1800072b0:     	movq	%r14, 0xd8(%rsp)
1800072b8:     	movq	0x290(%rsp), %rax
1800072c0:     	movq	%rax, 0xd0(%rsp)
1800072c8:     	movq	0x288(%rsp), %rax
1800072d0:     	movq	%rax, 0xc8(%rsp)
1800072d8:     	movq	0x280(%rsp), %rax
1800072e0:     	movq	%rax, 0xc0(%rsp)
1800072e8:     	movq	0x278(%rsp), %rax
1800072f0:     	movq	%rax, 0xb8(%rsp)
1800072f8:     	movq	0x270(%rsp), %rax
180007300:     	movq	%rax, 0xb0(%rsp)
180007308:     	movq	0x268(%rsp), %rax
180007310:     	movq	%rax, 0xa8(%rsp)
180007318:     	movq	0x260(%rsp), %rax
180007320:     	movq	%rax, 0xa0(%rsp)
180007328:     	movq	0x258(%rsp), %rax
180007330:     	movq	%rax, 0x98(%rsp)
180007338:     	movq	0x250(%rsp), %rax
180007340:     	movq	%rax, 0x90(%rsp)
180007348:     	movq	0x248(%rsp), %rax
180007350:     	movq	%rax, 0x88(%rsp)
180007358:     	movq	0x240(%rsp), %rax
180007360:     	movq	%rax, 0x80(%rsp)
180007368:     	movq	0x238(%rsp), %rax
180007370:     	movq	%rax, 0x78(%rsp)
180007375:     	movq	%rbx, 0x70(%rsp)
18000737a:     	movq	0x228(%rsp), %rax
180007382:     	movq	%rax, 0x68(%rsp)
180007387:     	movq	0x220(%rsp), %rax
18000738f:     	movq	%rax, 0x60(%rsp)
180007394:     	movq	0x218(%rsp), %rax
18000739c:     	movq	%rax, 0x58(%rsp)
1800073a1:     	movq	0x210(%rsp), %rax
1800073a9:     	movq	%rax, 0x50(%rsp)
1800073ae:     	movq	0x208(%rsp), %rax
1800073b6:     	movq	%rax, 0x48(%rsp)
1800073bb:     	movq	0x200(%rsp), %rax
1800073c3:     	movq	%rax, 0x40(%rsp)
1800073c8:     	movq	%r12, 0x38(%rsp)
1800073cd:     	movq	0x1f0(%rsp), %rax
1800073d5:     	movq	%rax, 0x30(%rsp)
1800073da:     	movq	0x1e8(%rsp), %rax
1800073e2:     	movq	%rax, 0x28(%rsp)
1800073e7:     	movq	0x1e0(%rsp), %rax
1800073ef:     	movq	%rax, 0x20(%rsp)
1800073f4:     	movq	$-0x1, 0x108(%rsp)
180007400:     	movq	$0x0, 0xf0(%rsp)
18000740c:     	leaq	0x136(%rsp), %rcx
180007414:     	movq	0x138(%rsp), %r8
18000741c:     	movq	0x128(%rsp), %r9
180007424:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180007429:     	cmpb	$0x0, (%r14)
18000742d:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007433:     	movq	0x260(%rsp), %rdx
18000743b:     	movq	0x8(%rdx), %rcx
18000743f:     	leaq	-0x1(%rcx), %rax
180007443:     	movq	%rax, 0x8(%rdx)
180007447:     	movq	0x120(%rsp), %rax
18000744f:     	movq	0x28(%rax,%r13,8), %rax
180007454:     	testq	%rax, %rax
180007457:     	js	0x180007d1a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d3a>
18000745d:     	movq	%rcx, 0x8(%rdx)
180007461:     	cmpq	0x10(%rdx), %rcx
180007465:     	jg	0x180007d1a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d3a>
18000746b:     	movq	0x148(%rsp), %rcx
180007473:     	movq	%rcx, 0x100(%rsp)
18000747b:     	movq	%rax, 0xf8(%rsp)
180007483:     	movq	0x2a8(%rsp), %rax
18000748b:     	movq	%rax, 0xe8(%rsp)
180007493:     	movq	0x2a0(%rsp), %rax
18000749b:     	movq	%rax, 0xe0(%rsp)
1800074a3:     	movq	0x298(%rsp), %r14
1800074ab:     	movq	%r14, 0xd8(%rsp)
1800074b3:     	movq	0x290(%rsp), %rax
1800074bb:     	movq	%rax, 0xd0(%rsp)
1800074c3:     	movq	0x288(%rsp), %rax
1800074cb:     	movq	%rax, 0xc8(%rsp)
1800074d3:     	movq	0x280(%rsp), %rax
1800074db:     	movq	%rax, 0xc0(%rsp)
1800074e3:     	movq	0x278(%rsp), %rax
1800074eb:     	movq	%rax, 0xb8(%rsp)
1800074f3:     	movq	0x270(%rsp), %rax
1800074fb:     	movq	%rax, 0xb0(%rsp)
180007503:     	movq	0x268(%rsp), %rax
18000750b:     	movq	%rax, 0xa8(%rsp)
180007513:     	movq	0x260(%rsp), %rax
18000751b:     	movq	%rax, 0xa0(%rsp)
180007523:     	movq	0x258(%rsp), %rax
18000752b:     	movq	%rax, 0x98(%rsp)
180007533:     	movq	0x250(%rsp), %rax
18000753b:     	movq	%rax, 0x90(%rsp)
180007543:     	movq	0x248(%rsp), %rax
18000754b:     	movq	%rax, 0x88(%rsp)
180007553:     	movq	0x240(%rsp), %rax
18000755b:     	movq	%rax, 0x80(%rsp)
180007563:     	movq	0x238(%rsp), %rax
18000756b:     	movq	%rax, 0x78(%rsp)
180007570:     	movq	%rbx, 0x70(%rsp)
180007575:     	movq	0x228(%rsp), %rax
18000757d:     	movq	%rax, 0x68(%rsp)
180007582:     	movq	0x220(%rsp), %rax
18000758a:     	movq	%rax, 0x60(%rsp)
18000758f:     	movq	0x218(%rsp), %rax
180007597:     	movq	%rax, 0x58(%rsp)
18000759c:     	movq	0x210(%rsp), %rax
1800075a4:     	movq	%rax, 0x50(%rsp)
1800075a9:     	movq	0x208(%rsp), %rax
1800075b1:     	movq	%rax, 0x48(%rsp)
1800075b6:     	movq	0x200(%rsp), %rax
1800075be:     	movq	%rax, 0x40(%rsp)
1800075c3:     	movq	%r12, 0x38(%rsp)
1800075c8:     	movq	0x1f0(%rsp), %rax
1800075d0:     	movq	%rax, 0x30(%rsp)
1800075d5:     	movq	0x1e8(%rsp), %rax
1800075dd:     	movq	%rax, 0x28(%rsp)
1800075e2:     	movq	0x1e0(%rsp), %rax
1800075ea:     	movq	%rax, 0x20(%rsp)
1800075ef:     	movq	$-0x1, 0x108(%rsp)
1800075fb:     	movq	$0x0, 0xf0(%rsp)
180007607:     	leaq	0x135(%rsp), %rcx
18000760f:     	movq	0x138(%rsp), %r8
180007617:     	movq	0x128(%rsp), %r9
18000761f:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180007624:     	cmpb	$0x0, (%r14)
180007628:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
18000762e:     	movq	0x260(%rsp), %rdx
180007636:     	movq	0x8(%rdx), %rcx
18000763a:     	leaq	-0x1(%rcx), %rax
18000763e:     	movq	%rax, 0x8(%rdx)
180007642:     	movq	0x120(%rsp), %rax
18000764a:     	movq	0x38(%rax,%rbp,8), %rax
18000764f:     	testq	%rax, %rax
180007652:     	js	0x180007d3a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d5a>
180007658:     	movq	%rcx, 0x8(%rdx)
18000765c:     	cmpq	0x10(%rdx), %rcx
180007660:     	jg	0x180007d3a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d5a>
180007666:     	movq	0x148(%rsp), %rcx
18000766e:     	movq	%rcx, 0x100(%rsp)
180007676:     	movq	%rax, 0xf8(%rsp)
18000767e:     	movq	0x2a8(%rsp), %rax
180007686:     	movq	%rax, 0xe8(%rsp)
18000768e:     	movq	0x2a0(%rsp), %rax
180007696:     	movq	%rax, 0xe0(%rsp)
18000769e:     	movq	0x298(%rsp), %r14
1800076a6:     	movq	%r14, 0xd8(%rsp)
1800076ae:     	movq	0x290(%rsp), %rax
1800076b6:     	movq	%rax, 0xd0(%rsp)
1800076be:     	movq	0x288(%rsp), %rax
1800076c6:     	movq	%rax, 0xc8(%rsp)
1800076ce:     	movq	0x280(%rsp), %rax
1800076d6:     	movq	%rax, 0xc0(%rsp)
1800076de:     	movq	0x278(%rsp), %rax
1800076e6:     	movq	%rax, 0xb8(%rsp)
1800076ee:     	movq	0x270(%rsp), %rax
1800076f6:     	movq	%rax, 0xb0(%rsp)
1800076fe:     	movq	0x268(%rsp), %rax
180007706:     	movq	%rax, 0xa8(%rsp)
18000770e:     	movq	0x260(%rsp), %rax
180007716:     	movq	%rax, 0xa0(%rsp)
18000771e:     	movq	0x258(%rsp), %rax
180007726:     	movq	%rax, 0x98(%rsp)
18000772e:     	movq	0x250(%rsp), %rax
180007736:     	movq	%rax, 0x90(%rsp)
18000773e:     	movq	0x248(%rsp), %rax
180007746:     	movq	%rax, 0x88(%rsp)
18000774e:     	movq	0x240(%rsp), %rax
180007756:     	movq	%rax, 0x80(%rsp)
18000775e:     	movq	0x238(%rsp), %rax
180007766:     	movq	%rax, 0x78(%rsp)
18000776b:     	movq	%rbx, 0x70(%rsp)
180007770:     	movq	0x228(%rsp), %rax
180007778:     	movq	%rax, 0x68(%rsp)
18000777d:     	movq	0x220(%rsp), %rax
180007785:     	movq	%rax, 0x60(%rsp)
18000778a:     	movq	0x218(%rsp), %rax
180007792:     	movq	%rax, 0x58(%rsp)
180007797:     	movq	0x210(%rsp), %rax
18000779f:     	movq	%rax, 0x50(%rsp)
1800077a4:     	movq	0x208(%rsp), %rax
1800077ac:     	movq	%rax, 0x48(%rsp)
1800077b1:     	movq	0x200(%rsp), %rax
1800077b9:     	movq	%rax, 0x40(%rsp)
1800077be:     	movq	%r12, 0x38(%rsp)
1800077c3:     	movq	0x1f0(%rsp), %rax
1800077cb:     	movq	%rax, 0x30(%rsp)
1800077d0:     	movq	0x1e8(%rsp), %rax
1800077d8:     	movq	%rax, 0x28(%rsp)
1800077dd:     	movq	0x1e0(%rsp), %rax
1800077e5:     	movq	%rax, 0x20(%rsp)
1800077ea:     	movq	$-0x1, 0x108(%rsp)
1800077f6:     	movq	$0x0, 0xf0(%rsp)
180007802:     	leaq	0x134(%rsp), %rcx
18000780a:     	movq	0x138(%rsp), %r8
180007812:     	movq	0x128(%rsp), %r9
18000781a:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
18000781f:     	cmpb	$0x0, (%r14)
180007823:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007829:     	movq	0x260(%rsp), %rdx
180007831:     	movq	0x8(%rdx), %rcx
180007835:     	leaq	-0x1(%rcx), %rax
180007839:     	movq	%rax, 0x8(%rdx)
18000783d:     	movq	0x120(%rsp), %rax
180007845:     	movq	0x160(%rsp), %rdx
18000784d:     	movq	0x40(%rax,%rdx,8), %rax
180007852:     	testq	%rax, %rax
180007855:     	js	0x180007d5a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d7a>
18000785b:     	movq	0x260(%rsp), %rdx
180007863:     	movq	%rcx, 0x8(%rdx)
180007867:     	cmpq	0x10(%rdx), %rcx
18000786b:     	jg	0x180007d5a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3d7a>
180007871:     	movq	0x148(%rsp), %rcx
180007879:     	movq	%rcx, 0x100(%rsp)
180007881:     	movq	%rax, 0xf8(%rsp)
180007889:     	movq	0x2a8(%rsp), %rax
180007891:     	movq	%rax, 0xe8(%rsp)
180007899:     	movq	0x2a0(%rsp), %rax
1800078a1:     	movq	%rax, 0xe0(%rsp)
1800078a9:     	movq	0x298(%rsp), %r14
1800078b1:     	movq	%r14, 0xd8(%rsp)
1800078b9:     	movq	0x290(%rsp), %rax
1800078c1:     	movq	%rax, 0xd0(%rsp)
1800078c9:     	movq	0x288(%rsp), %rax
1800078d1:     	movq	%rax, 0xc8(%rsp)
1800078d9:     	movq	0x280(%rsp), %rax
1800078e1:     	movq	%rax, 0xc0(%rsp)
1800078e9:     	movq	0x278(%rsp), %rax
1800078f1:     	movq	%rax, 0xb8(%rsp)
1800078f9:     	movq	0x270(%rsp), %rax
180007901:     	movq	%rax, 0xb0(%rsp)
180007909:     	movq	0x268(%rsp), %rax
180007911:     	movq	%rax, 0xa8(%rsp)
180007919:     	movq	0x260(%rsp), %rax
180007921:     	movq	%rax, 0xa0(%rsp)
180007929:     	movq	0x258(%rsp), %rax
180007931:     	movq	%rax, 0x98(%rsp)
180007939:     	movq	0x250(%rsp), %rax
180007941:     	movq	%rax, 0x90(%rsp)
180007949:     	movq	0x248(%rsp), %rax
180007951:     	movq	%rax, 0x88(%rsp)
180007959:     	movq	0x240(%rsp), %rax
180007961:     	movq	%rax, 0x80(%rsp)
180007969:     	movq	0x238(%rsp), %rax
180007971:     	movq	%rax, 0x78(%rsp)
180007976:     	movq	%rbx, 0x70(%rsp)
18000797b:     	movq	0x228(%rsp), %rax
180007983:     	movq	%rax, 0x68(%rsp)
180007988:     	movq	0x220(%rsp), %rax
180007990:     	movq	%rax, 0x60(%rsp)
180007995:     	movq	0x218(%rsp), %rax
18000799d:     	movq	%rax, 0x58(%rsp)
1800079a2:     	movq	0x210(%rsp), %rax
1800079aa:     	movq	%rax, 0x50(%rsp)
1800079af:     	movq	0x208(%rsp), %rax
1800079b7:     	movq	%rax, 0x48(%rsp)
1800079bc:     	movq	0x200(%rsp), %rax
1800079c4:     	movq	%rax, 0x40(%rsp)
1800079c9:     	movq	%r12, 0x38(%rsp)
1800079ce:     	movq	0x1f0(%rsp), %rax
1800079d6:     	movq	%rax, 0x30(%rsp)
1800079db:     	movq	0x1e8(%rsp), %rax
1800079e3:     	movq	%rax, 0x28(%rsp)
1800079e8:     	movq	0x1e0(%rsp), %rax
1800079f0:     	movq	%rax, 0x20(%rsp)
1800079f5:     	movq	$-0x1, 0x108(%rsp)
180007a01:     	movq	$0x0, 0xf0(%rsp)
180007a0d:     	leaq	0x133(%rsp), %rcx
180007a15:     	movq	0x138(%rsp), %r8
180007a1d:     	movq	0x128(%rsp), %r9
180007a25:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180007a2a:     	cmpb	$0x0, (%r14)
180007a2e:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007a34:     	incq	%rdi
180007a37:     	movq	0x260(%rsp), %rax
180007a3f:     	decq	0x8(%rax)
180007a43:     	movq	0x158(%rsp), %rax
180007a4b:     	movq	0x140(%rsp), %rcx
180007a53:     	cmpq	(%rcx,%rax,8), %rdi
180007a57:     	jl	0x180007205 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3225>
180007a5d:     	movq	0x260(%rsp), %rax
180007a65:     	movq	(%rax), %rax
180007a68:     	cmpq	%rbx, %rax
180007a6b:     	movq	%rax, %rcx
180007a6e:     	jle	0x180007a88 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3aa8>
180007a70:     	movq	0x298(%rsp), %rax
180007a78:     	movb	$0x2, (%rax)
180007a7b:     	movq	0x260(%rsp), %rax
180007a83:     	movq	(%rax), %rax
180007a86:     	xorl	%ecx, %ecx
180007a88:     	leaq	0x3(%rax), %rdx
180007a8c:     	cmpq	%rbx, %rdx
180007a8f:     	jg	0x180005bfa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1c1a>
180007a95:     	movq	0x260(%rsp), %r8
180007a9d:     	movq	%rdx, (%r8)
180007aa0:     	movq	0x298(%rsp), %rdx
180007aa8:     	cmpb	$0x0, (%rdx)
180007aab:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007ab1:     	movq	%rax, %rdx
180007ab4:     	sarq	$0x3f, %rdx
180007ab8:     	andq	%rbx, %rdx
180007abb:     	movq	0x228(%rsp), %r8
180007ac3:     	leaq	(%r8,%rax,8), %r8
180007ac7:     	movq	$0x0, (%r8,%rdx,8)
180007acf:     	xorl	%edi, %edi
180007ad1:     	cmpq	$-0x1, %rax
180007ad5:     	movl	$0x0, %edx
180007ada:     	cmovlq	%rbx, %rdx
180007ade:     	movq	$0x0, 0x8(%r8,%rdx,8)
180007ae7:     	cmpq	$-0x2, %rax
180007aeb:     	cmovgeq	%rdi, %rbx
180007aef:     	movq	%rcx, 0x10(%r8,%rbx,8)
180007af4:     	movq	0x298(%rsp), %rcx
180007afc:     	cmpb	$0x0, (%rcx)
180007aff:     	movq	0x110(%rsp), %rcx
180007b07:     	jne	0x180005692 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b2>
180007b0d:     	movq	0x120(%rsp), %rdx
180007b15:     	movq	%rax, 0x30(%rdx,%r15,8)
180007b1a:     	jmp	0x180005690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x16b0>
180007b1f:     	movb	$0x0, 0x11c(%rsp)
180007b27:     	movq	%rsi, 0x100(%rsp)
180007b2f:     	movq	%rcx, 0xf8(%rsp)
180007b37:     	movq	0x2a8(%rsp), %rax
180007b3f:     	movq	%rax, 0xe8(%rsp)
180007b47:     	movq	0x2a0(%rsp), %rax
180007b4f:     	movq	%rax, 0xe0(%rsp)
180007b57:     	movq	0x290(%rsp), %rax
180007b5f:     	movq	%rax, 0xd0(%rsp)
180007b67:     	movq	0x288(%rsp), %rax
180007b6f:     	movq	%rax, 0xc8(%rsp)
180007b77:     	movq	0x280(%rsp), %rax
180007b7f:     	movq	%rax, 0xc0(%rsp)
180007b87:     	movq	0x278(%rsp), %rax
180007b8f:     	movq	%rax, 0xb8(%rsp)
180007b97:     	movq	0x270(%rsp), %rax
180007b9f:     	movq	%rax, 0xb0(%rsp)
180007ba7:     	movq	0x268(%rsp), %rax
180007baf:     	movq	%rax, 0xa8(%rsp)
180007bb7:     	movq	0x258(%rsp), %rax
180007bbf:     	movq	%rax, 0x98(%rsp)
180007bc7:     	movq	0x250(%rsp), %rax
180007bcf:     	movq	%rax, 0x90(%rsp)
180007bd7:     	movq	0x248(%rsp), %rax
180007bdf:     	movq	%rax, 0x88(%rsp)
180007be7:     	movq	0x240(%rsp), %rax
180007bef:     	movq	%rax, 0x80(%rsp)
180007bf7:     	movq	0x238(%rsp), %rax
180007bff:     	movq	%rax, 0x78(%rsp)
180007c04:     	movq	%rbx, 0x70(%rsp)
180007c09:     	movq	0x228(%rsp), %rax
180007c11:     	movq	%rax, 0x68(%rsp)
180007c16:     	movq	0x220(%rsp), %rax
180007c1e:     	movq	%rax, 0x60(%rsp)
180007c23:     	movq	0x218(%rsp), %rax
180007c2b:     	movq	%rax, 0x58(%rsp)
180007c30:     	movq	0x210(%rsp), %rax
180007c38:     	movq	%rax, 0x50(%rsp)
180007c3d:     	movq	0x208(%rsp), %rax
180007c45:     	movq	%rax, 0x48(%rsp)
180007c4a:     	movq	0x200(%rsp), %rax
180007c52:     	movq	%rax, 0x40(%rsp)
180007c57:     	movq	%r12, 0x38(%rsp)
180007c5c:     	movq	0x1f0(%rsp), %rax
180007c64:     	movq	%rax, 0x30(%rsp)
180007c69:     	movq	0x1e8(%rsp), %rax
180007c71:     	movq	%rax, 0x28(%rsp)
180007c76:     	movq	0x298(%rsp), %rsi
180007c7e:     	movq	%rsi, 0xd8(%rsp)
180007c86:     	movq	0x260(%rsp), %rax
180007c8e:     	movq	%rax, 0xa0(%rsp)
180007c96:     	movq	0x1e0(%rsp), %rax
180007c9e:     	movq	%rax, 0x20(%rsp)
180007ca3:     	movq	$-0x1, 0x108(%rsp)
180007caf:     	movq	$0x0, 0xf0(%rsp)
180007cbb:     	leaq	0x11c(%rsp), %rcx
180007cc3:     	movq	0x138(%rsp), %r8
180007ccb:     	movq	0x128(%rsp), %r9
180007cd3:     	callq	0x180005180 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11a0>
180007cd8:     	cmpb	$0x0, (%rsi)
180007cdb:     	jne	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007ce1:     	movzbl	0x11c(%rsp), %edi
180007ce9:     	movq	0x260(%rsp), %rax
180007cf1:     	decq	0x8(%rax)
180007cf5:     	jmp	0x180005f1c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1f3c>
180007cfa:     	movq	0x298(%rsp), %rax
180007d02:     	movb	$0x1, (%rax)
180007d05:     	movq	0x260(%rsp), %rax
180007d0d:     	movq	$0x989697, 0x18(%rax)   # imm = 0x989697
180007d15:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007d1a:     	movq	0x298(%rsp), %rax
180007d22:     	movb	$0x1, (%rax)
180007d25:     	movq	0x260(%rsp), %rax
180007d2d:     	movq	$0x989698, 0x18(%rax)   # imm = 0x989698
180007d35:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007d3a:     	movq	0x298(%rsp), %rax
180007d42:     	movb	$0x1, (%rax)
180007d45:     	movq	0x260(%rsp), %rax
180007d4d:     	movq	$0x989699, 0x18(%rax)   # imm = 0x989699
180007d55:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007d5a:     	movq	0x298(%rsp), %rax
180007d62:     	movb	$0x1, (%rax)
180007d65:     	movq	0x260(%rsp), %rax
180007d6d:     	movq	$0x98969a, 0x18(%rax)   # imm = 0x98969A
180007d75:     	jmp	0x180005933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1953>
180007d7a:     	nopw	(%rax,%rax)
180007d80:     	pushq	%r15
180007d82:     	pushq	%r14
180007d84:     	pushq	%r13
180007d86:     	pushq	%r12
180007d88:     	pushq	%rsi
180007d89:     	pushq	%rdi
180007d8a:     	pushq	%rbp
180007d8b:     	pushq	%rbx
180007d8c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180007d93:     	movapd	%xmm8, 0x1d0(%rsp)
180007d9d:     	movapd	%xmm7, 0x1c0(%rsp)
180007da6:     	movapd	%xmm6, 0x1b0(%rsp)
180007daf:     	movq	0x320(%rsp), %rdi
180007db7:     	movq	0x268(%rsp), %r12
180007dbf:     	movq	0x260(%rsp), %r15
180007dc7:     	movq	$0x0, 0x190(%rsp)
180007dd3:     	movb	$0x0, 0x198(%rsp)
180007ddb:     	movq	$0x0, 0x1a0(%rsp)
180007de7:     	movq	$0x0, 0x170(%rsp)
180007df3:     	movb	$0x0, 0x178(%rsp)
180007dfb:     	movq	$0x0, 0x180(%rsp)
180007e07:     	movq	$0x0, 0x150(%rsp)
180007e13:     	movb	$0x0, 0x158(%rsp)
180007e1b:     	movq	$0x0, 0x160(%rsp)
180007e27:     	movq	$0x0, 0x130(%rsp)
180007e33:     	movb	$0x0, 0x138(%rsp)
180007e3b:     	movq	$0x0, 0x140(%rsp)
180007e47:     	xorl	%eax, %eax
180007e49:     	cmpq	$-0x9, %rdi
180007e4d:     	cmovlq	%r12, %rax
180007e51:     	leaq	(%r15,%rdi,8), %rdx
180007e55:     	movsd	0x48(%rdx,%rax,8), %xmm0
180007e5b:     	xorpd	%xmm1, %xmm1
180007e5f:     	ucomisd	%xmm1, %xmm0
180007e63:     	jne	0x180007e7c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3e9c>
180007e65:     	jp	0x180007e7c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3e9c>
180007e67:     	movb	$0x1, 0x18(%rcx)
180007e6b:     	movq	$0x0, 0x10(%rcx)
180007e73:     	movb	$0x1, 0x8(%rcx)
180007e77:     	jmp	0x180008024 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4044>
180007e7c:     	movq	0x328(%rsp), %rsi
180007e84:     	movq	0x2a0(%rsp), %rbp
180007e8c:     	movq	0x298(%rsp), %r13
180007e94:     	xorl	%eax, %eax
180007e96:     	cmpq	$-0x6, %rdi
180007e9a:     	cmovlq	%rbp, %rax
180007e9e:     	leaq	(%r13,%rdi,8), %rbx
180007ea3:     	movq	0x30(%rbx,%rax,8), %rax
180007ea8:     	movq	%rax, %r10
180007eab:     	sarq	$0x3f, %r10
180007eaf:     	andq	%rbp, %r10
180007eb2:     	leaq	(%r13,%rax,8), %rdx
180007eb7:     	cmpq	$0x1, (%rdx,%r10,8)
180007ebc:     	jne	0x180007ee0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3f00>
180007ebe:     	xorl	%r10d, %r10d
180007ec1:     	cmpq	$-0x2, %rax
180007ec5:     	cmovlq	%rbp, %r10
180007ec9:     	movq	0x10(%rdx,%r10,8), %rax
180007ece:     	leaq	(%r13,%rax,8), %rdx
180007ed3:     	sarq	$0x3f, %rax
180007ed7:     	andq	%rbp, %rax
180007eda:     	cmpq	%rsi, (%rdx,%rax,8)
180007ede:     	je	0x180007e67 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3e87>
180007ee0:     	movq	0x308(%rsp), %r14
180007ee8:     	movq	0x2d0(%rsp), %r11
180007ef0:     	xorl	%eax, %eax
180007ef2:     	cmpq	$-0x2, %rdi
180007ef6:     	cmovlq	%rbp, %rax
180007efa:     	movq	0x10(%rbx,%rax,8), %rdx
180007eff:     	testq	%rdx, %rdx
180007f02:     	js	0x180008000 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4020>
180007f08:     	testq	%rsi, %rsi
180007f0b:     	js	0x180008000 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4020>
180007f11:     	movq	0x10(%r13,%rsi,8), %r10
180007f16:     	testq	%r10, %r10
180007f19:     	js	0x180008000 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4020>
180007f1f:     	movsd	(%r15,%rdx,8), %xmm1
180007f25:     	cmpq	$0x0, 0x8(%r13,%rdx,8)
180007f2b:     	setne	%r11b
180007f2f:     	cmpq	$0x0, 0x8(%r13,%r10,8)
180007f35:     	setne	%al
180007f38:     	subsd	(%r15,%r10,8), %xmm1
180007f3e:     	andb	%r11b, %al
180007f41:     	cmpb	$0x1, %al
180007f43:     	jne	0x180007f67 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3f87>
180007f45:     	movapd	0x7473(%rip), %xmm2     # 0x18000f3c0
180007f4d:     	andpd	%xmm1, %xmm2
180007f51:     	ucomisd	0x7477(%rip), %xmm2     # 0x18000f3d0
180007f59:     	jae	0x180008081 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x40a1>
180007f5f:     	xorpd	%xmm2, %xmm2
180007f63:     	addsd	%xmm2, %xmm1
180007f67:     	movq	0x2d0(%rsp), %r11
180007f6f:     	movsd	0x10(%r15,%rdx,8), %xmm2
180007f76:     	cmpq	$0x0, 0x18(%r13,%rdx,8)
180007f7c:     	subsd	0x10(%r15,%r10,8), %xmm2
180007f83:     	je	0x18000805a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x407a>
180007f89:     	cmpq	$0x0, 0x18(%r13,%r10,8)
180007f8f:     	je	0x18000805a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x407a>
180007f95:     	movapd	0x7423(%rip), %xmm3     # 0x18000f3c0
180007f9d:     	andpd	%xmm2, %xmm3
180007fa1:     	ucomisd	0x7427(%rip), %xmm3     # 0x18000f3d0
180007fa9:     	jae	0x1800080ef <PyInit_rcaotr_2c76336ff39711e0671e54df+0x410f>
180007faf:     	movapd	%xmm1, %xmm3
180007fb3:     	mulsd	%xmm1, %xmm3
180007fb7:     	ucomisd	0x7411(%rip), %xmm3     # 0x18000f3d0
180007fbf:     	setae	%dl
180007fc2:     	testb	%dl, %al
180007fc4:     	jne	0x180008073 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4093>
180007fca:     	xorpd	%xmm4, %xmm4
180007fce:     	addsd	%xmm4, %xmm2
180007fd2:     	movapd	%xmm2, %xmm4
180007fd6:     	mulsd	%xmm2, %xmm4
180007fda:     	ucomisd	0x73ee(%rip), %xmm4     # 0x18000f3d0
180007fe2:     	jae	0x180008073 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4093>
180007fe8:     	addsd	%xmm4, %xmm3
180007fec:     	ucomisd	0x73dc(%rip), %xmm3     # 0x18000f3d0
180007ff4:     	setae	%dl
180007ff7:     	testb	%dl, %al
180007ff9:     	jne	0x180008073 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4093>
180007ffb:     	jmp	0x1800080a6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x40c6>
180008000:     	movb	$0x1, (%r14)
180008004:     	movq	$0x3d090a, 0x18(%r11)   # imm = 0x3D090A
18000800c:     	movq	$0x0, 0x18(%rcx)
180008014:     	movq	$0x0, 0x10(%rcx)
18000801c:     	movq	$0x0, 0x8(%rcx)
180008024:     	movq	$0x0, (%rcx)
18000802b:     	xorl	%eax, %eax
18000802d:     	movaps	0x1b0(%rsp), %xmm6
180008035:     	movaps	0x1c0(%rsp), %xmm7
18000803d:     	movaps	0x1d0(%rsp), %xmm8
180008046:     	addq	$0x1e8, %rsp            # imm = 0x1E8
18000804d:     	popq	%rbx
18000804e:     	popq	%rbp
18000804f:     	popq	%rdi
180008050:     	popq	%rsi
180008051:     	popq	%r12
180008053:     	popq	%r13
180008055:     	popq	%r14
180008057:     	popq	%r15
180008059:     	retq
18000805a:     	movapd	%xmm1, %xmm3
18000805e:     	mulsd	%xmm1, %xmm3
180008062:     	ucomisd	0x7366(%rip), %xmm3     # 0x18000f3d0
18000806a:     	setae	%dl
18000806d:     	andb	%dl, %al
18000806f:     	cmpb	$0x1, %al
180008071:     	jne	0x18000809a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x40ba>
180008073:     	movb	$0x1, (%r14)
180008077:     	movq	$0x3d090c, 0x18(%r11)   # imm = 0x3D090C
18000807f:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
180008081:     	movb	$0x1, (%r14)
180008085:     	movq	0x2d0(%rsp), %rax
18000808d:     	movq	$0x3d090a, 0x18(%rax)   # imm = 0x3D090A
180008095:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
18000809a:     	movapd	%xmm2, %xmm4
18000809e:     	mulsd	%xmm2, %xmm4
1800080a2:     	addsd	%xmm4, %xmm3
1800080a6:     	xorps	%xmm4, %xmm4
1800080a9:     	sqrtsd	%xmm3, %xmm4
1800080ad:     	xorl	%eax, %eax
1800080af:     	cmpq	$-0x3, %rdi
1800080b3:     	cmovlq	%rbp, %rax
1800080b7:     	cmpq	$0x0, 0x18(%rbx,%rax,8)
1800080bd:     	je	0x18000811e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x413e>
1800080bf:     	movq	%rdi, %rax
1800080c2:     	sarq	$0x3f, %rax
1800080c6:     	andq	%rbp, %rax
1800080c9:     	movq	(%rbx,%rax,8), %rax
1800080cd:     	testq	%rax, %rax
1800080d0:     	js	0x1800080de <PyInit_rcaotr_2c76336ff39711e0671e54df+0x40fe>
1800080d2:     	xorpd	%xmm5, %xmm5
1800080d6:     	ucomisd	%xmm5, %xmm3
1800080da:     	jne	0x180008100 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4120>
1800080dc:     	jp	0x180008100 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4120>
1800080de:     	movb	$0x1, (%r14)
1800080e2:     	movq	$0x3d090f, 0x18(%r11)   # imm = 0x3D090F
1800080ea:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
1800080ef:     	movb	$0x1, (%r14)
1800080f3:     	movq	$0x3d090b, 0x18(%r11)   # imm = 0x3D090B
1800080fb:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
180008100:     	movsd	0x330(%rsp), %xmm6
180008109:     	movsd	0x8(%r15,%rax,8), %xmm3
180008110:     	addsd	%xmm3, %xmm3
180008114:     	divsd	%xmm4, %xmm3
180008118:     	ucomisd	%xmm3, %xmm6
18000811c:     	jbe	0x18000818c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x41ac>
18000811e:     	movsd	0x72b2(%rip), %xmm3     # 0x18000f3d8
180008126:     	maxsd	%xmm4, %xmm3
18000812a:     	movapd	%xmm3, %xmm4
18000812e:     	mulsd	%xmm3, %xmm4
180008132:     	xorpd	%xmm5, %xmm5
180008136:     	ucomisd	%xmm5, %xmm4
18000813a:     	jne	0x18000814f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x416f>
18000813c:     	jp	0x18000814f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x416f>
18000813e:     	movb	$0x1, (%r14)
180008142:     	movq	$0x3d0915, 0x18(%r11)   # imm = 0x3D0915
18000814a:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
18000814f:     	movsd	0x8(%r15,%rsi,8), %xmm5
180008156:     	mulsd	0x7282(%rip), %xmm5     # 0x18000f3e0
18000815e:     	mulsd	%xmm5, %xmm0
180008162:     	divsd	%xmm4, %xmm0
180008166:     	mulsd	%xmm0, %xmm1
18000816a:     	divsd	%xmm3, %xmm1
18000816e:     	mulsd	%xmm0, %xmm2
180008172:     	divsd	%xmm3, %xmm2
180008176:     	movsd	%xmm2, 0x10(%rcx)
18000817b:     	movsd	%xmm1, (%rcx)
18000817f:     	movb	$0x0, 0x18(%rcx)
180008183:     	movb	$0x0, 0x8(%rcx)
180008187:     	jmp	0x18000802b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x404b>
18000818c:     	xorl	%eax, %eax
18000818e:     	cmpq	$-0x4, %rdi
180008192:     	cmovlq	%rbp, %rax
180008196:     	movq	0x20(%rbx,%rax,8), %rax
18000819b:     	testq	%rax, %rax
18000819e:     	movb	$0x1, %dl
1800081a0:     	movl	%edx, 0x114(%rsp)
1800081a7:     	js	0x1800083bd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x43dd>
1800081ad:     	movq	0x8(%r11), %rdx
1800081b1:     	leaq	0x1(%rdx), %r10
1800081b5:     	movq	%r10, 0x8(%r11)
1800081b9:     	cmpq	0x10(%r11), %rdx
1800081bd:     	jge	0x18000860e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x462e>
1800081c3:     	movq	%rcx, 0x118(%rsp)
1800081cb:     	movsd	%xmm6, 0x100(%rsp)
1800081d4:     	movq	%rsi, 0xf8(%rsp)
1800081dc:     	movq	%rax, 0xf0(%rsp)
1800081e4:     	movq	0x318(%rsp), %rax
1800081ec:     	movq	%rax, 0xe8(%rsp)
1800081f4:     	movq	0x310(%rsp), %rax
1800081fc:     	movq	%rax, 0xe0(%rsp)
180008204:     	movq	%r14, 0xd8(%rsp)
18000820c:     	movq	0x300(%rsp), %rax
180008214:     	movq	%rax, 0xd0(%rsp)
18000821c:     	movq	0x2f8(%rsp), %rax
180008224:     	movq	%rax, 0xc8(%rsp)
18000822c:     	movq	0x2f0(%rsp), %rax
180008234:     	movq	%rax, 0xc0(%rsp)
18000823c:     	movq	0x2e8(%rsp), %rax
180008244:     	movq	%rax, 0xb8(%rsp)
18000824c:     	movq	0x2e0(%rsp), %rax
180008254:     	movq	%rax, 0xb0(%rsp)
18000825c:     	movq	0x2d8(%rsp), %rax
180008264:     	movq	%rax, 0xa8(%rsp)
18000826c:     	movq	%r11, 0xa0(%rsp)
180008274:     	movq	0x2c8(%rsp), %rax
18000827c:     	movq	%rax, 0x98(%rsp)
180008284:     	movq	0x2c0(%rsp), %rax
18000828c:     	movq	%rax, 0x90(%rsp)
180008294:     	movq	0x2b8(%rsp), %rax
18000829c:     	movq	%rax, 0x88(%rsp)
1800082a4:     	movq	0x2b0(%rsp), %rax
1800082ac:     	movq	%rax, 0x80(%rsp)
1800082b4:     	movq	0x2a8(%rsp), %rax
1800082bc:     	movq	%rax, 0x78(%rsp)
1800082c1:     	movq	%rbp, 0x70(%rsp)
1800082c6:     	movq	%r13, 0x68(%rsp)
1800082cb:     	movq	0x290(%rsp), %rax
1800082d3:     	movq	%rax, 0x60(%rsp)
1800082d8:     	movq	0x288(%rsp), %rax
1800082e0:     	movq	%rax, 0x58(%rsp)
1800082e5:     	movq	0x280(%rsp), %rax
1800082ed:     	movq	%rax, 0x50(%rsp)
1800082f2:     	movq	0x278(%rsp), %rax
1800082fa:     	movq	%rax, 0x48(%rsp)
1800082ff:     	movq	0x270(%rsp), %rax
180008307:     	movq	%rax, 0x40(%rsp)
18000830c:     	movq	%r12, 0x38(%rsp)
180008311:     	movq	%r15, 0x30(%rsp)
180008316:     	movq	0x258(%rsp), %rax
18000831e:     	movq	%rax, 0x28(%rsp)
180008323:     	movq	0x250(%rsp), %rax
18000832b:     	movq	%rax, 0x20(%rsp)
180008330:     	leaq	0x190(%rsp), %rcx
180008338:     	movq	%r8, 0x120(%rsp)
180008340:     	movq	%r9, 0x128(%rsp)
180008348:     	callq	0x180007d80 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3da0>
18000834d:     	movzbl	0x198(%rsp), %ecx
180008355:     	testb	%cl, %cl
180008357:     	setne	%dl
18000835a:     	cmpb	$0x0, (%r14)
18000835e:     	jne	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008364:     	movsd	0x1a0(%rsp), %xmm0
18000836d:     	movzbl	0x1a8(%rsp), %eax
180008375:     	movsd	0x190(%rsp), %xmm7
18000837e:     	movq	0x2d0(%rsp), %r11
180008386:     	decq	0x8(%r11)
18000838a:     	testb	%cl, %cl
18000838c:     	je	0x180008630 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4650>
180008392:     	movapd	0x7026(%rip), %xmm1     # 0x18000f3c0
18000839a:     	andpd	%xmm7, %xmm1
18000839e:     	ucomisd	0x702a(%rip), %xmm1     # 0x18000f3d0
1800083a6:     	jb	0x180008630 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4650>
1800083ac:     	movb	$0x1, (%r14)
1800083b0:     	movq	$0x3d0922, 0x18(%r11)   # imm = 0x3D0922
1800083b8:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
1800083bd:     	xorpd	%xmm7, %xmm7
1800083c1:     	movb	$0x1, 0x113(%rsp)
1800083c9:     	xorpd	%xmm8, %xmm8
1800083ce:     	xorl	%eax, %eax
1800083d0:     	cmpq	$-0x5, %rdi
1800083d4:     	cmovlq	%rbp, %rax
1800083d8:     	movq	0x28(%rbx,%rax,8), %rax
1800083dd:     	testq	%rax, %rax
1800083e0:     	js	0x180008749 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4769>
1800083e6:     	movq	0x8(%r11), %rdx
1800083ea:     	leaq	0x1(%rdx), %r10
1800083ee:     	movq	%r10, 0x8(%r11)
1800083f2:     	cmpq	0x10(%r11), %rdx
1800083f6:     	jge	0x18000861f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x463f>
1800083fc:     	movq	%rcx, 0x118(%rsp)
180008404:     	movsd	%xmm6, 0x100(%rsp)
18000840d:     	movq	%rsi, 0xf8(%rsp)
180008415:     	movq	%rax, 0xf0(%rsp)
18000841d:     	movq	0x318(%rsp), %rax
180008425:     	movq	%rax, 0xe8(%rsp)
18000842d:     	movq	0x310(%rsp), %rax
180008435:     	movq	%rax, 0xe0(%rsp)
18000843d:     	movq	%r14, 0xd8(%rsp)
180008445:     	movq	0x300(%rsp), %rax
18000844d:     	movq	%rax, 0xd0(%rsp)
180008455:     	movq	0x2f8(%rsp), %rax
18000845d:     	movq	%rax, 0xc8(%rsp)
180008465:     	movq	0x2f0(%rsp), %rax
18000846d:     	movq	%rax, 0xc0(%rsp)
180008475:     	movq	0x2e8(%rsp), %rax
18000847d:     	movq	%rax, 0xb8(%rsp)
180008485:     	movq	0x2e0(%rsp), %rax
18000848d:     	movq	%rax, 0xb0(%rsp)
180008495:     	movq	0x2d8(%rsp), %rax
18000849d:     	movq	%rax, 0xa8(%rsp)
1800084a5:     	movq	%r11, 0xa0(%rsp)
1800084ad:     	movq	0x2c8(%rsp), %rax
1800084b5:     	movq	%rax, 0x98(%rsp)
1800084bd:     	movq	0x2c0(%rsp), %rax
1800084c5:     	movq	%rax, 0x90(%rsp)
1800084cd:     	movq	0x2b8(%rsp), %rax
1800084d5:     	movq	%rax, 0x88(%rsp)
1800084dd:     	movq	0x2b0(%rsp), %rax
1800084e5:     	movq	%rax, 0x80(%rsp)
1800084ed:     	movq	0x2a8(%rsp), %rax
1800084f5:     	movq	%rax, 0x78(%rsp)
1800084fa:     	movq	%rbp, 0x70(%rsp)
1800084ff:     	movq	%r13, 0x68(%rsp)
180008504:     	movq	0x290(%rsp), %rax
18000850c:     	movq	%rax, 0x60(%rsp)
180008511:     	movq	0x288(%rsp), %rax
180008519:     	movq	%rax, 0x58(%rsp)
18000851e:     	movq	0x280(%rsp), %rax
180008526:     	movq	%rax, 0x50(%rsp)
18000852b:     	movq	0x278(%rsp), %rax
180008533:     	movq	%rax, 0x48(%rsp)
180008538:     	movq	0x270(%rsp), %rax
180008540:     	movq	%rax, 0x40(%rsp)
180008545:     	movq	%r12, 0x38(%rsp)
18000854a:     	movq	%r15, 0x30(%rsp)
18000854f:     	movq	0x258(%rsp), %rax
180008557:     	movq	%rax, 0x28(%rsp)
18000855c:     	movq	0x250(%rsp), %rax
180008564:     	movq	%rax, 0x20(%rsp)
180008569:     	leaq	0x170(%rsp), %rcx
180008571:     	movq	%r8, 0x120(%rsp)
180008579:     	movq	%r9, 0x128(%rsp)
180008581:     	callq	0x180007d80 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3da0>
180008586:     	cmpb	$0x0, (%r14)
18000858a:     	jne	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008590:     	movsd	0x180(%rsp), %xmm0
180008599:     	movzbl	0x188(%rsp), %eax
1800085a1:     	cmpb	$0x0, 0x178(%rsp)
1800085a9:     	setne	%cl
1800085ac:     	addsd	0x170(%rsp), %xmm7
1800085b5:     	movq	0x2d0(%rsp), %rdx
1800085bd:     	decq	0x8(%rdx)
1800085c1:     	movzbl	0x113(%rsp), %edx
1800085c9:     	andb	%cl, %dl
1800085cb:     	movb	%dl, 0x113(%rsp)
1800085d2:     	cmpb	$0x1, %dl
1800085d5:     	jne	0x18000868d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46ad>
1800085db:     	movapd	0x6ddd(%rip), %xmm1     # 0x18000f3c0
1800085e3:     	andpd	%xmm7, %xmm1
1800085e7:     	ucomisd	0x6de1(%rip), %xmm1     # 0x18000f3d0
1800085ef:     	jb	0x18000868d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46ad>
1800085f5:     	movb	$0x1, (%r14)
1800085f9:     	movq	0x2d0(%rsp), %rax
180008601:     	movq	$0x3d0927, 0x18(%rax)   # imm = 0x3D0927
180008609:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
18000860e:     	movb	$0x1, (%r14)
180008612:     	movq	$0x3d0921, 0x18(%r11)   # imm = 0x3D0921
18000861a:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
18000861f:     	movb	$0x1, (%r14)
180008623:     	movq	$0x3d0926, 0x18(%r11)   # imm = 0x3D0926
18000862b:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
180008630:     	movb	%dl, 0x113(%rsp)
180008637:     	xorpd	%xmm8, %xmm8
18000863c:     	addsd	%xmm8, %xmm7
180008641:     	testb	%al, %al
180008643:     	addsd	%xmm0, %xmm8
180008648:     	je	0x1800086f6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4716>
18000864e:     	andpd	0x6d6a(%rip), %xmm0     # 0x18000f3c0
180008656:     	ucomisd	0x6d72(%rip), %xmm0     # 0x18000f3d0
18000865e:     	movq	0x118(%rsp), %rcx
180008666:     	movq	0x128(%rsp), %r9
18000866e:     	movq	0x120(%rsp), %r8
180008676:     	jb	0x1800083ce <PyInit_rcaotr_2c76336ff39711e0671e54df+0x43ee>
18000867c:     	movb	$0x1, (%r14)
180008680:     	movq	$0x3d0923, 0x18(%r11)   # imm = 0x3D0923
180008688:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
18000868d:     	addsd	%xmm0, %xmm8
180008692:     	testb	%al, %al
180008694:     	setne	%al
180008697:     	movl	0x114(%rsp), %ecx
18000869e:     	andb	%al, %cl
1800086a0:     	cmpb	$0x1, %cl
1800086a3:     	jne	0x18000871e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x473e>
1800086a5:     	movapd	0x6d13(%rip), %xmm0     # 0x18000f3c0
1800086ad:     	andpd	%xmm8, %xmm0
1800086b2:     	movb	$0x1, %al
1800086b4:     	movl	%eax, 0x114(%rsp)
1800086bb:     	ucomisd	0x6d0d(%rip), %xmm0     # 0x18000f3d0
1800086c3:     	movq	0x118(%rsp), %rcx
1800086cb:     	movq	0x128(%rsp), %r9
1800086d3:     	movq	0x120(%rsp), %r8
1800086db:     	movq	0x2d0(%rsp), %r11
1800086e3:     	jb	0x180008749 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4769>
1800086e5:     	movb	$0x1, (%r14)
1800086e9:     	movq	$0x3d0928, 0x18(%r11)   # imm = 0x3D0928
1800086f1:     	jmp	0x18000800c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x402c>
1800086f6:     	movl	$0x0, 0x114(%rsp)
180008701:     	movq	0x118(%rsp), %rcx
180008709:     	movq	0x128(%rsp), %r9
180008711:     	movq	0x120(%rsp), %r8
180008719:     	jmp	0x1800083ce <PyInit_rcaotr_2c76336ff39711e0671e54df+0x43ee>
18000871e:     	movl	$0x0, 0x114(%rsp)
180008729:     	movq	0x118(%rsp), %rcx
180008731:     	movq	0x128(%rsp), %r9
180008739:     	movq	0x120(%rsp), %r8
180008741:     	movq	0x2d0(%rsp), %r11
180008749:     	xorl	%eax, %eax
18000874b:     	cmpq	$-0x7, %rdi
18000874f:     	cmovlq	%rbp, %rax
180008753:     	movq	0x38(%rbx,%rax,8), %rax
180008758:     	testq	%rax, %rax
18000875b:     	movq	%rcx, 0x118(%rsp)
180008763:     	js	0x1800089bf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49df>
180008769:     	movq	0x8(%r11), %rcx
18000876d:     	leaq	0x1(%rcx), %rdx
180008771:     	movq	%rdx, 0x8(%r11)
180008775:     	cmpq	0x10(%r11), %rcx
180008779:     	jge	0x180008c50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c70>
18000877f:     	movsd	%xmm6, 0x100(%rsp)
180008788:     	movq	%rsi, 0xf8(%rsp)
180008790:     	movq	%rax, 0xf0(%rsp)
180008798:     	movq	0x318(%rsp), %rax
1800087a0:     	movq	%rax, 0xe8(%rsp)
1800087a8:     	movq	0x310(%rsp), %rax
1800087b0:     	movq	%rax, 0xe0(%rsp)
1800087b8:     	movq	%r14, 0xd8(%rsp)
1800087c0:     	movq	0x300(%rsp), %rax
1800087c8:     	movq	%rax, 0xd0(%rsp)
1800087d0:     	movq	0x2f8(%rsp), %rax
1800087d8:     	movq	%rax, 0xc8(%rsp)
1800087e0:     	movq	0x2f0(%rsp), %rax
1800087e8:     	movq	%rax, 0xc0(%rsp)
1800087f0:     	movq	0x2e8(%rsp), %rax
1800087f8:     	movq	%rax, 0xb8(%rsp)
180008800:     	movq	0x2e0(%rsp), %rax
180008808:     	movq	%rax, 0xb0(%rsp)
180008810:     	movq	0x2d8(%rsp), %rax
180008818:     	movq	%rax, 0xa8(%rsp)
180008820:     	movq	%r11, 0xa0(%rsp)
180008828:     	movq	0x2c8(%rsp), %rax
180008830:     	movq	%rax, 0x98(%rsp)
180008838:     	movq	0x2c0(%rsp), %rax
180008840:     	movq	%rax, 0x90(%rsp)
180008848:     	movq	0x2b8(%rsp), %rax
180008850:     	movq	%rax, 0x88(%rsp)
180008858:     	movq	0x2b0(%rsp), %rax
180008860:     	movq	%rax, 0x80(%rsp)
180008868:     	movq	0x2a8(%rsp), %rax
180008870:     	movq	%rax, 0x78(%rsp)
180008875:     	movq	%rbp, 0x70(%rsp)
18000887a:     	movq	%r13, 0x68(%rsp)
18000887f:     	movq	0x290(%rsp), %rax
180008887:     	movq	%rax, 0x60(%rsp)
18000888c:     	movq	0x288(%rsp), %rax
180008894:     	movq	%rax, 0x58(%rsp)
180008899:     	movq	0x280(%rsp), %rax
1800088a1:     	movq	%rax, 0x50(%rsp)
1800088a6:     	movq	0x278(%rsp), %rax
1800088ae:     	movq	%rax, 0x48(%rsp)
1800088b3:     	movq	0x270(%rsp), %rax
1800088bb:     	movq	%rax, 0x40(%rsp)
1800088c0:     	movq	%r12, 0x38(%rsp)
1800088c5:     	movq	%r15, 0x30(%rsp)
1800088ca:     	movq	0x258(%rsp), %rax
1800088d2:     	movq	%rax, 0x28(%rsp)
1800088d7:     	movq	0x250(%rsp), %rax
1800088df:     	movq	%rax, 0x20(%rsp)
1800088e4:     	leaq	0x150(%rsp), %rcx
1800088ec:     	movq	%r8, 0x120(%rsp)
1800088f4:     	movq	%r9, 0x128(%rsp)
1800088fc:     	callq	0x180007d80 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3da0>
180008901:     	cmpb	$0x0, (%r14)
180008905:     	jne	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
18000890b:     	movsd	0x160(%rsp), %xmm0
180008914:     	movzbl	0x168(%rsp), %eax
18000891c:     	cmpb	$0x0, 0x158(%rsp)
180008924:     	setne	%cl
180008927:     	addsd	0x150(%rsp), %xmm7
180008930:     	movq	0x2d0(%rsp), %rdx
180008938:     	decq	0x8(%rdx)
18000893c:     	movzbl	0x113(%rsp), %edx
180008944:     	andb	%cl, %dl
180008946:     	movb	%dl, 0x113(%rsp)
18000894d:     	cmpb	$0x1, %dl
180008950:     	jne	0x180008974 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4994>
180008952:     	movapd	0x6a66(%rip), %xmm1     # 0x18000f3c0
18000895a:     	andpd	%xmm7, %xmm1
18000895e:     	ucomisd	0x6a6a(%rip), %xmm1     # 0x18000f3d0
180008966:     	jae	0x180008cae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4cce>
18000896c:     	xorpd	%xmm1, %xmm1
180008970:     	addsd	%xmm1, %xmm7
180008974:     	addsd	%xmm0, %xmm8
180008979:     	testb	%al, %al
18000897b:     	setne	%al
18000897e:     	movl	0x114(%rsp), %ecx
180008985:     	andb	%al, %cl
180008987:     	cmpb	$0x1, %cl
18000898a:     	jne	0x180008c9e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4cbe>
180008990:     	movapd	0x6a28(%rip), %xmm0     # 0x18000f3c0
180008998:     	andpd	%xmm8, %xmm0
18000899d:     	ucomisd	0x6a2b(%rip), %xmm0     # 0x18000f3d0
1800089a5:     	jae	0x180008cc4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4ce4>
1800089ab:     	xorpd	%xmm0, %xmm0
1800089af:     	addsd	%xmm0, %xmm8
1800089b4:     	movb	$0x1, %al
1800089b6:     	movl	%eax, 0x114(%rsp)
1800089bd:     	jmp	0x1800089cf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49ef>
1800089bf:     	movq	%r8, 0x120(%rsp)
1800089c7:     	movq	%r9, 0x128(%rsp)
1800089cf:     	xorl	%eax, %eax
1800089d1:     	cmpq	$-0x8, %rdi
1800089d5:     	cmovlq	%rbp, %rax
1800089d9:     	movq	0x40(%rbx,%rax,8), %rax
1800089de:     	testq	%rax, %rax
1800089e1:     	js	0x180008ce5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d05>
1800089e7:     	movq	0x2d0(%rsp), %r8
1800089ef:     	movq	0x8(%r8), %rcx
1800089f3:     	leaq	0x1(%rcx), %rdx
1800089f7:     	movq	%rdx, 0x8(%r8)
1800089fb:     	cmpq	0x10(%r8), %rcx
1800089ff:     	jge	0x180008c5e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c7e>
180008a05:     	movq	%rsi, 0xf8(%rsp)
180008a0d:     	movq	%rax, 0xf0(%rsp)
180008a15:     	movq	0x318(%rsp), %rax
180008a1d:     	movq	%rax, 0xe8(%rsp)
180008a25:     	movq	0x310(%rsp), %rax
180008a2d:     	movq	%rax, 0xe0(%rsp)
180008a35:     	movq	0x300(%rsp), %rax
180008a3d:     	movq	%rax, 0xd0(%rsp)
180008a45:     	movq	0x2f8(%rsp), %rax
180008a4d:     	movq	%rax, 0xc8(%rsp)
180008a55:     	movq	0x2f0(%rsp), %rax
180008a5d:     	movq	%rax, 0xc0(%rsp)
180008a65:     	movq	0x2e8(%rsp), %rax
180008a6d:     	movq	%rax, 0xb8(%rsp)
180008a75:     	movq	0x2e0(%rsp), %rax
180008a7d:     	movq	%rax, 0xb0(%rsp)
180008a85:     	movq	0x2d8(%rsp), %rax
180008a8d:     	movq	%rax, 0xa8(%rsp)
180008a95:     	movq	0x2c8(%rsp), %rax
180008a9d:     	movq	%rax, 0x98(%rsp)
180008aa5:     	movq	0x2c0(%rsp), %rax
180008aad:     	movq	%rax, 0x90(%rsp)
180008ab5:     	movq	0x2b8(%rsp), %rax
180008abd:     	movq	%rax, 0x88(%rsp)
180008ac5:     	movq	0x2b0(%rsp), %rax
180008acd:     	movq	%rax, 0x80(%rsp)
180008ad5:     	movq	0x2a8(%rsp), %rax
180008add:     	movq	%rax, 0x78(%rsp)
180008ae2:     	movq	%rbp, 0x70(%rsp)
180008ae7:     	movq	%r13, 0x68(%rsp)
180008aec:     	movq	0x290(%rsp), %rax
180008af4:     	movq	%rax, 0x60(%rsp)
180008af9:     	movq	0x288(%rsp), %rax
180008b01:     	movq	%rax, 0x58(%rsp)
180008b06:     	movq	0x280(%rsp), %rax
180008b0e:     	movq	%rax, 0x50(%rsp)
180008b13:     	movq	0x278(%rsp), %rax
180008b1b:     	movq	%rax, 0x48(%rsp)
180008b20:     	movq	0x270(%rsp), %rax
180008b28:     	movq	%rax, 0x40(%rsp)
180008b2d:     	movq	%r12, 0x38(%rsp)
180008b32:     	movq	%r15, 0x30(%rsp)
180008b37:     	movq	0x258(%rsp), %rax
180008b3f:     	movq	%rax, 0x28(%rsp)
180008b44:     	movsd	%xmm6, 0x100(%rsp)
180008b4d:     	movq	%r14, 0xd8(%rsp)
180008b55:     	movq	0x2d0(%rsp), %rax
180008b5d:     	movq	%rax, 0xa0(%rsp)
180008b65:     	movq	0x250(%rsp), %rax
180008b6d:     	movq	%rax, 0x20(%rsp)
180008b72:     	leaq	0x130(%rsp), %rcx
180008b7a:     	movq	0x120(%rsp), %r8
180008b82:     	movq	0x128(%rsp), %r9
180008b8a:     	callq	0x180007d80 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3da0>
180008b8f:     	cmpb	$0x0, (%r14)
180008b93:     	jne	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008b99:     	movsd	0x140(%rsp), %xmm0
180008ba2:     	movzbl	0x148(%rsp), %eax
180008baa:     	cmpb	$0x0, 0x138(%rsp)
180008bb2:     	setne	%cl
180008bb5:     	addsd	0x130(%rsp), %xmm7
180008bbe:     	movq	0x2d0(%rsp), %rdx
180008bc6:     	decq	0x8(%rdx)
180008bca:     	movzbl	0x113(%rsp), %edx
180008bd2:     	andb	%cl, %dl
180008bd4:     	movb	%dl, 0x113(%rsp)
180008bdb:     	cmpb	$0x1, %dl
180008bde:     	jne	0x180008c02 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c22>
180008be0:     	movapd	0x67d8(%rip), %xmm1     # 0x18000f3c0
180008be8:     	andpd	%xmm7, %xmm1
180008bec:     	ucomisd	0x67dc(%rip), %xmm1     # 0x18000f3d0
180008bf4:     	jae	0x180008d11 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d31>
180008bfa:     	xorpd	%xmm1, %xmm1
180008bfe:     	addsd	%xmm1, %xmm7
180008c02:     	testb	%al, %al
180008c04:     	setne	%al
180008c07:     	addsd	%xmm0, %xmm8
180008c0c:     	movl	0x114(%rsp), %ecx
180008c13:     	andb	%al, %cl
180008c15:     	cmpb	$0x1, %cl
180008c18:     	jne	0x180008cda <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4cfa>
180008c1e:     	movapd	0x679a(%rip), %xmm0     # 0x18000f3c0
180008c26:     	andpd	%xmm8, %xmm0
180008c2b:     	ucomisd	0x679d(%rip), %xmm0     # 0x18000f3d0
180008c33:     	jae	0x180008d2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d4a>
180008c39:     	xorpd	%xmm0, %xmm0
180008c3d:     	addsd	%xmm0, %xmm8
180008c42:     	movb	$0x1, %al
180008c44:     	movl	%eax, 0x114(%rsp)
180008c4b:     	jmp	0x180008ce5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d05>
180008c50:     	movb	$0x1, (%r14)
180008c54:     	movq	$0x3d092b, 0x18(%r11)   # imm = 0x3D092B
180008c5c:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008c5e:     	movb	$0x1, (%r14)
180008c62:     	movq	0x2d0(%rsp), %rax
180008c6a:     	movq	$0x3d0930, 0x18(%rax)   # imm = 0x3D0930
180008c72:     	movq	0x118(%rsp), %rax
180008c7a:     	movq	$0x0, 0x18(%rax)
180008c82:     	movq	$0x0, 0x10(%rax)
180008c8a:     	movq	$0x0, 0x8(%rax)
180008c92:     	movq	$0x0, (%rax)
180008c99:     	jmp	0x18000802b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x404b>
180008c9e:     	movl	$0x0, 0x114(%rsp)
180008ca9:     	jmp	0x1800089cf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49ef>
180008cae:     	movb	$0x1, (%r14)
180008cb2:     	movq	0x2d0(%rsp), %rax
180008cba:     	movq	$0x3d092c, 0x18(%rax)   # imm = 0x3D092C
180008cc2:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008cc4:     	movb	$0x1, (%r14)
180008cc8:     	movq	0x2d0(%rsp), %rax
180008cd0:     	movq	$0x3d092d, 0x18(%rax)   # imm = 0x3D092D
180008cd8:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008cda:     	movl	$0x0, 0x114(%rsp)
180008ce5:     	movq	0x118(%rsp), %rax
180008ced:     	movl	0x114(%rsp), %ecx
180008cf4:     	movb	%cl, 0x18(%rax)
180008cf7:     	movsd	%xmm8, 0x10(%rax)
180008cfd:     	movzbl	0x113(%rsp), %ecx
180008d05:     	movb	%cl, 0x8(%rax)
180008d08:     	movsd	%xmm7, (%rax)
180008d0c:     	jmp	0x18000802b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x404b>
180008d11:     	movb	$0x1, (%r14)
180008d15:     	movq	0x2d0(%rsp), %rax
180008d1d:     	movq	$0x3d0931, 0x18(%rax)   # imm = 0x3D0931
180008d25:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008d2a:     	movb	$0x1, (%r14)
180008d2e:     	movq	0x2d0(%rsp), %rax
180008d36:     	movq	$0x3d0932, 0x18(%rax)   # imm = 0x3D0932
180008d3e:     	jmp	0x180008c72 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4c92>
180008d43:     	nopw	%cs:(%rax,%rax)
180008d4d:     	nopl	(%rax)
180008d50:     	pushq	%r15
180008d52:     	pushq	%r14
180008d54:     	pushq	%r13
180008d56:     	pushq	%r12
180008d58:     	pushq	%rsi
180008d59:     	pushq	%rdi
180008d5a:     	pushq	%rbp
180008d5b:     	pushq	%rbx
180008d5c:     	subq	$0x1d8, %rsp            # imm = 0x1D8
180008d63:     	movq	0x310(%rsp), %rax
180008d6b:     	movq	0x2f8(%rsp), %r15
180008d73:     	movq	0x2c0(%rsp), %r12
180008d7b:     	movb	$0x0, 0x137(%rsp)
180008d83:     	movq	$0x0, 0x1b8(%rsp)
180008d8f:     	movb	$0x0, 0x11f(%rsp)
180008d97:     	movq	$0x0, 0x1b0(%rsp)
180008da3:     	movb	$0x0, 0x11e(%rsp)
180008dab:     	movq	$0x0, 0x1a8(%rsp)
180008db7:     	movb	$0x0, 0x11d(%rsp)
180008dbf:     	movq	$0x0, 0x1a0(%rsp)
180008dcb:     	movb	$0x0, 0x11c(%rsp)
180008dd3:     	movq	$0x0, 0x198(%rsp)
180008ddf:     	movb	$0x0, 0x136(%rsp)
180008de7:     	movq	$0x0, 0x190(%rsp)
180008df3:     	movb	$0x0, 0x135(%rsp)
180008dfb:     	movq	$0x0, 0x188(%rsp)
180008e07:     	movb	$0x0, 0x134(%rsp)
180008e0f:     	movq	$0x0, 0x180(%rsp)
180008e1b:     	movb	$0x0, 0x133(%rsp)
180008e23:     	movq	$0x0, 0x178(%rsp)
180008e2f:     	cmpq	$0x1, %rax
180008e33:     	movq	0x290(%rsp), %r14
180008e3b:     	movq	0x288(%rsp), %r13
180008e43:     	movq	0x258(%rsp), %rbp
180008e4b:     	movq	0x250(%rsp), %rbx
180008e53:     	je	0x180008f06 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f26>
180008e59:     	testq	%rax, %rax
180008e5c:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008e62:     	movq	0x318(%rsp), %rdi
180008e6a:     	movq	%rdi, %rax
180008e6d:     	sarq	$0x3f, %rax
180008e71:     	andq	%r14, %rax
180008e74:     	leaq	(%r13,%rdi,8), %rsi
180008e79:     	movq	(%rsi,%rax,8), %rax
180008e7d:     	testq	%rax, %rax
180008e80:     	js	0x180008f33 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f53>
180008e86:     	movq	0x320(%rsp), %r10
180008e8e:     	testq	%r10, %r10
180008e91:     	js	0x180008f33 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f53>
180008e97:     	movq	0x10(%r13,%r10,8), %r11
180008e9c:     	testq	%r11, %r11
180008e9f:     	js	0x180008fc1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4fe1>
180008ea5:     	movsd	(%rbx,%r11,8), %xmm0
180008eab:     	movsd	0x8(%rbx,%rax,8), %xmm2
180008eb1:     	movsd	0x10(%rbx,%rax,8), %xmm1
180008eb7:     	movapd	%xmm1, %xmm3
180008ebb:     	subsd	%xmm2, %xmm3
180008ebf:     	xorl	%r10d, %r10d
180008ec2:     	ucomisd	%xmm3, %xmm0
180008ec6:     	jb	0x180008fe3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5003>
180008ecc:     	addsd	%xmm2, %xmm1
180008ed0:     	ucomisd	%xmm0, %xmm1
180008ed4:     	jbe	0x180008fe3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5003>
180008eda:     	movsd	0x10(%rbx,%r11,8), %xmm0
180008ee1:     	movsd	(%rbx,%rax,8), %xmm1
180008ee6:     	movsd	0x18(%rbx,%rax,8), %xmm2
180008eec:     	movapd	%xmm2, %xmm3
180008ef0:     	subsd	%xmm1, %xmm3
180008ef4:     	ucomisd	%xmm3, %xmm0
180008ef8:     	jae	0x180008fd7 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4ff7>
180008efe:     	xorl	%r10d, %r10d
180008f01:     	jmp	0x180008fe3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5003>
180008f06:     	movq	0x328(%rsp), %rsi
180008f0e:     	testq	%rsi, %rsi
180008f11:     	js	0x180008f45 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f65>
180008f13:     	movq	(%r13,%rsi,8), %rax
180008f18:     	testq	%rax, %rax
180008f1b:     	js	0x180008f45 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f65>
180008f1d:     	movq	(%r12), %r11
180008f21:     	leaq	0x4(%r11), %r10
180008f25:     	cmpq	%r14, %r10
180008f28:     	jle	0x180008f57 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f77>
180008f2a:     	movb	$0x2, (%r15)
180008f2e:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008f33:     	movb	$0x1, (%r15)
180008f37:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
180008f40:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008f45:     	movb	$0x1, (%r15)
180008f49:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
180008f52:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008f57:     	movsd	0x10(%rbx,%rax,8), %xmm1
180008f5d:     	movsd	0x18(%rbx,%rax,8), %xmm2
180008f63:     	movsd	0x6445(%rip), %xmm0     # 0x18000f3b0
180008f6b:     	movsd	0x8(%rbx,%rax,8), %xmm3
180008f71:     	mulsd	%xmm0, %xmm3
180008f75:     	mulsd	(%rbx,%rax,8), %xmm0
180008f7a:     	movq	%r10, (%r12)
180008f7e:     	cmpb	$0x0, (%r15)
180008f82:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008f88:     	movapd	%xmm1, %xmm4
180008f8c:     	addsd	%xmm3, %xmm4
180008f90:     	movapd	%xmm2, %xmm5
180008f94:     	subsd	%xmm0, %xmm5
180008f98:     	testq	%r11, %r11
180008f9b:     	js	0x1800092ca <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52ea>
180008fa1:     	movsd	%xmm4, 0x10(%rbx,%r11,8)
180008fa8:     	movsd	%xmm5, 0x18(%rbx,%r11,8)
180008faf:     	movsd	%xmm3, 0x8(%rbx,%r11,8)
180008fb6:     	movsd	%xmm0, (%rbx,%r11,8)
180008fbc:     	jmp	0x1800092d7 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52f7>
180008fc1:     	movb	$0x1, (%r15)
180008fc5:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
180008fce:     	cmpb	$0x0, (%r15)
180008fd2:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008fd7:     	addsd	%xmm1, %xmm2
180008fdb:     	ucomisd	%xmm0, %xmm2
180008fdf:     	seta	%r10b
180008fe3:     	cmpb	$0x0, (%r15)
180008fe7:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008fed:     	testb	%r10b, %r10b
180008ff0:     	je	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180008ff6:     	xorl	%eax, %eax
180008ff8:     	cmpq	$-0x6, %rdi
180008ffc:     	movl	$0x0, %r10d
180009002:     	cmovlq	%r14, %r10
180009006:     	movq	0x30(%rsi,%r10,8), %r11
18000900b:     	movq	%r11, %r10
18000900e:     	sarq	$0x3f, %r10
180009012:     	andq	%r14, %r10
180009015:     	movq	%r11, 0x148(%rsp)
18000901d:     	leaq	(%r13,%r11,8), %r11
180009022:     	movq	%r11, 0x128(%rsp)
18000902a:     	movq	(%r11,%r10,8), %r11
18000902e:     	cmpq	$-0x1, %rdi
180009032:     	cmovlq	%r14, %rax
180009036:     	cmpq	0x8(%rsi,%rax,8), %r11
18000903b:     	jge	0x180009053 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5073>
18000903d:     	xorl	%eax, %eax
18000903f:     	cmpq	$-0x3, %rdi
180009043:     	cmovlq	%r14, %rax
180009047:     	cmpq	$0x0, 0x18(%rsi,%rax,8)
18000904d:     	je	0x1800096d0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x56f0>
180009053:     	xorl	%eax, %eax
180009055:     	cmpq	$-0x3, %rdi
180009059:     	cmovlq	%r14, %rax
18000905d:     	cmpq	$0x0, 0x18(%rsi,%rax,8)
180009063:     	je	0x1800094b9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x54d9>
180009069:     	xorl	%eax, %eax
18000906b:     	cmpq	$-0x4, %rdi
18000906f:     	movl	$0x0, %r10d
180009075:     	cmovlq	%r14, %r10
180009079:     	movq	0x20(%rsi,%r10,8), %r10
18000907e:     	testq	%r10, %r10
180009081:     	js	0x1800096bb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x56db>
180009087:     	movq	0x8(%r12), %rax
18000908c:     	leaq	0x1(%rax), %r11
180009090:     	movq	%r11, 0x8(%r12)
180009095:     	cmpq	0x10(%r12), %rax
18000909a:     	jge	0x1800097ba <PyInit_rcaotr_2c76336ff39711e0671e54df+0x57da>
1800090a0:     	movq	%rdx, 0x120(%rsp)
1800090a8:     	movq	%rcx, 0x110(%rsp)
1800090b0:     	movb	$0x0, 0x11f(%rsp)
1800090b8:     	movq	0x320(%rsp), %rax
1800090c0:     	movq	%rax, 0x100(%rsp)
1800090c8:     	movq	%r10, 0xf8(%rsp)
1800090d0:     	movq	0x308(%rsp), %rax
1800090d8:     	movq	%rax, 0xe8(%rsp)
1800090e0:     	movq	0x300(%rsp), %rax
1800090e8:     	movq	%rax, 0xe0(%rsp)
1800090f0:     	movq	%r15, 0xd8(%rsp)
1800090f8:     	movq	0x2f0(%rsp), %rax
180009100:     	movq	%rax, 0xd0(%rsp)
180009108:     	movq	0x2e8(%rsp), %rax
180009110:     	movq	%rax, 0xc8(%rsp)
180009118:     	movq	0x2e0(%rsp), %rax
180009120:     	movq	%rax, 0xc0(%rsp)
180009128:     	movq	0x2d8(%rsp), %rax
180009130:     	movq	%rax, 0xb8(%rsp)
180009138:     	movq	0x2d0(%rsp), %rax
180009140:     	movq	%rax, 0xb0(%rsp)
180009148:     	movq	0x2c8(%rsp), %rax
180009150:     	movq	%rax, 0xa8(%rsp)
180009158:     	movq	%r12, 0xa0(%rsp)
180009160:     	movq	0x2b8(%rsp), %rax
180009168:     	movq	%rax, 0x98(%rsp)
180009170:     	movq	0x2b0(%rsp), %rax
180009178:     	movq	%rax, 0x90(%rsp)
180009180:     	movq	0x2a8(%rsp), %rax
180009188:     	movq	%rax, 0x88(%rsp)
180009190:     	movq	0x2a0(%rsp), %rax
180009198:     	movq	%rax, 0x80(%rsp)
1800091a0:     	movq	0x298(%rsp), %rax
1800091a8:     	movq	%rax, 0x78(%rsp)
1800091ad:     	movq	%r14, 0x70(%rsp)
1800091b2:     	movq	%r13, 0x68(%rsp)
1800091b7:     	movq	0x280(%rsp), %rax
1800091bf:     	movq	%rax, 0x60(%rsp)
1800091c4:     	movq	0x278(%rsp), %rax
1800091cc:     	movq	%rax, 0x58(%rsp)
1800091d1:     	movq	0x270(%rsp), %rax
1800091d9:     	movq	%rax, 0x50(%rsp)
1800091de:     	movq	0x268(%rsp), %rax
1800091e6:     	movq	%rax, 0x48(%rsp)
1800091eb:     	movq	0x260(%rsp), %rax
1800091f3:     	movq	%rax, 0x40(%rsp)
1800091f8:     	movq	%rbp, 0x38(%rsp)
1800091fd:     	movq	%rbx, 0x30(%rsp)
180009202:     	movq	0x248(%rsp), %rax
18000920a:     	movq	%rax, 0x28(%rsp)
18000920f:     	movq	0x240(%rsp), %rax
180009217:     	movq	%rax, 0x20(%rsp)
18000921c:     	movq	$-0x1, 0x108(%rsp)
180009228:     	movq	$0x0, 0xf0(%rsp)
180009234:     	leaq	0x11f(%rsp), %rcx
18000923c:     	leaq	0x1b0(%rsp), %rdx
180009244:     	movq	%r8, 0x128(%rsp)
18000924c:     	movq	%r9, 0x148(%rsp)
180009254:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
180009259:     	testl	%eax, %eax
18000925b:     	jne	0x180009f03 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f23>
180009261:     	cmpb	$0x0, (%r15)
180009265:     	movq	0x110(%rsp), %rcx
18000926d:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
18000926f:     	movzbl	0x11f(%rsp), %eax
180009277:     	movq	0x8(%r12), %rdx
18000927c:     	leaq	-0x1(%rdx), %r8
180009280:     	movq	%r8, 0x8(%r12)
180009285:     	testb	$0x1, %al
180009287:     	jne	0x180009e9a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5eba>
18000928d:     	xorl	%eax, %eax
18000928f:     	cmpq	$-0x5, %rdi
180009293:     	movl	$0x0, %r8d
180009299:     	cmovlq	%r14, %r8
18000929d:     	movq	0x28(%rsi,%r8,8), %r8
1800092a2:     	testq	%r8, %r8
1800092a5:     	js	0x1800097de <PyInit_rcaotr_2c76336ff39711e0671e54df+0x57fe>
1800092ab:     	movq	%rdx, 0x8(%r12)
1800092b0:     	cmpq	0x10(%r12), %rdx
1800092b5:     	jle	0x1800097f3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5813>
1800092bb:     	movb	$0x1, (%r15)
1800092bf:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
1800092c8:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
1800092ca:     	movb	$0x1, (%r15)
1800092ce:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800092d7:     	cmpb	$0x0, (%r15)
1800092db:     	je	0x1800092f6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5316>
1800092dd:     	movb	$0x0, (%rcx)
1800092e0:     	xorl	%eax, %eax
1800092e2:     	addq	$0x1d8, %rsp            # imm = 0x1D8
1800092e9:     	popq	%rbx
1800092ea:     	popq	%rbp
1800092eb:     	popq	%rdi
1800092ec:     	popq	%rsi
1800092ed:     	popq	%r12
1800092ef:     	popq	%r13
1800092f1:     	popq	%r14
1800092f3:     	popq	%r15
1800092f5:     	retq
1800092f6:     	movq	(%r12), %rax
1800092fa:     	leaq	0xb(%rax), %r10
1800092fe:     	cmpq	%r14, %r10
180009301:     	jg	0x180008f2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f4a>
180009307:     	movq	0x8(%r13,%rsi,8), %rdi
18000930c:     	movq	%r10, (%r12)
180009310:     	cmpb	$0x0, (%r15)
180009314:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009316:     	movq	%rax, %r10
180009319:     	sarq	$0x3f, %r10
18000931d:     	andq	%r14, %r10
180009320:     	movq	%rax, 0x138(%rsp)
180009328:     	movq	0x138(%rsp), %rax
180009330:     	leaq	(%r13,%rax,8), %rax
180009335:     	movq	%r11, (%rax,%r10,8)
180009339:     	movq	0x138(%rsp), %rax
180009341:     	xorl	%r10d, %r10d
180009344:     	cmpq	$-0x1, %rax
180009348:     	cmovlq	%r14, %r10
18000934c:     	leaq	(%r13,%rax,8), %r11
180009351:     	movq	%rdi, 0x8(%r11,%r10,8)
180009356:     	movq	(%r12), %r11
18000935a:     	cmpq	%r14, %r11
18000935d:     	movq	%r11, %rdi
180009360:     	jle	0x18000936c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x538c>
180009362:     	movb	$0x2, (%r15)
180009366:     	movq	(%r12), %r11
18000936a:     	xorl	%edi, %edi
18000936c:     	leaq	0x3(%r11), %r10
180009370:     	cmpq	%r14, %r10
180009373:     	jg	0x180008f2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f4a>
180009379:     	movq	%r10, (%r12)
18000937d:     	cmpb	$0x0, (%r15)
180009381:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009387:     	movq	%r11, %r10
18000938a:     	sarq	$0x3f, %r10
18000938e:     	andq	%r14, %r10
180009391:     	movq	%rdi, 0x120(%rsp)
180009399:     	leaq	(%r13,%r11,8), %rdi
18000939e:     	movq	$0x0, (%rdi,%r10,8)
1800093a6:     	movq	$0x0, 0x110(%rsp)
1800093b2:     	cmpq	$-0x1, %r11
1800093b6:     	movl	$0x0, %r10d
1800093bc:     	cmovlq	%r14, %r10
1800093c0:     	leaq	(%r13,%r11,8), %rdi
1800093c5:     	movq	$0x0, 0x8(%rdi,%r10,8)
1800093ce:     	cmpq	$-0x2, %r11
1800093d2:     	movq	0x110(%rsp), %r10
1800093da:     	cmovlq	%r14, %r10
1800093de:     	movq	%r10, 0x110(%rsp)
1800093e6:     	leaq	(%r13,%r11,8), %r10
1800093eb:     	movq	0x120(%rsp), %rdi
1800093f3:     	movq	%r11, 0x128(%rsp)
1800093fb:     	movq	0x110(%rsp), %r11
180009403:     	movq	%rdi, 0x10(%r10,%r11,8)
180009408:     	movq	0x128(%rsp), %r11
180009410:     	cmpb	$0x0, (%r15)
180009414:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
18000941a:     	cmpq	$-0x6, %rax
18000941e:     	movl	$0x0, %edi
180009423:     	cmovlq	%r14, %rdi
180009427:     	leaq	(%r13,%rax,8), %r10
18000942c:     	movq	%r11, 0x30(%r10,%rdi,8)
180009431:     	cmpq	$-0x3, %rax
180009435:     	movl	$0x0, %r11d
18000943b:     	cmovlq	%r14, %r11
18000943f:     	movq	$0x0, 0x18(%r10,%r11,8)
180009448:     	movq	(%r12), %r11
18000944c:     	leaq	0x4(%r11), %r10
180009450:     	cmpq	%r14, %r10
180009453:     	jg	0x180008f2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f4a>
180009459:     	movq	%r10, (%r12)
18000945d:     	cmpb	$0x0, (%r15)
180009461:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009467:     	movq	%r8, 0x128(%rsp)
18000946f:     	movq	%r9, 0x148(%rsp)
180009477:     	movq	%rdx, 0x120(%rsp)
18000947f:     	movq	%rcx, 0x110(%rsp)
180009487:     	testq	%r11, %r11
18000948a:     	js	0x18000a15a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x617a>
180009490:     	movq	$0x0, (%rbx,%r11,8)
180009498:     	leaq	(%r13,%r11,8), %rcx
18000949d:     	movq	$0x1, 0x8(%r13,%r11,8)
1800094a6:     	movq	$0x0, 0x10(%rbx,%r11,8)
1800094af:     	movl	$0x1, %edx
1800094b4:     	jmp	0x18000a166 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6186>
1800094b9:     	movq	0x8(%r12), %rax
1800094be:     	leaq	0x1(%rax), %r10
1800094c2:     	movq	%r10, 0x8(%r12)
1800094c7:     	cmpq	0x10(%r12), %rax
1800094cc:     	jge	0x1800097cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x57ec>
1800094d2:     	movq	%rdx, 0x120(%rsp)
1800094da:     	movq	%rcx, 0x110(%rsp)
1800094e2:     	movq	%rdi, 0x108(%rsp)
1800094ea:     	movq	0x308(%rsp), %rax
1800094f2:     	movq	%rax, 0xe8(%rsp)
1800094fa:     	movq	0x300(%rsp), %rax
180009502:     	movq	%rax, 0xe0(%rsp)
18000950a:     	movq	%r15, 0xd8(%rsp)
180009512:     	movq	0x2f0(%rsp), %rax
18000951a:     	movq	%rax, 0xd0(%rsp)
180009522:     	movq	0x2e8(%rsp), %rax
18000952a:     	movq	%rax, 0xc8(%rsp)
180009532:     	movq	0x2e0(%rsp), %rax
18000953a:     	movq	%rax, 0xc0(%rsp)
180009542:     	movq	0x2d8(%rsp), %rax
18000954a:     	movq	%rax, 0xb8(%rsp)
180009552:     	movq	0x2d0(%rsp), %rax
18000955a:     	movq	%rax, 0xb0(%rsp)
180009562:     	movq	0x2c8(%rsp), %rax
18000956a:     	movq	%rax, 0xa8(%rsp)
180009572:     	movq	%r12, 0xa0(%rsp)
18000957a:     	movq	0x2b8(%rsp), %rax
180009582:     	movq	%rax, 0x98(%rsp)
18000958a:     	movq	0x2b0(%rsp), %rax
180009592:     	movq	%rax, 0x90(%rsp)
18000959a:     	movq	0x2a8(%rsp), %rax
1800095a2:     	movq	%rax, 0x88(%rsp)
1800095aa:     	movq	0x2a0(%rsp), %rax
1800095b2:     	movq	%rax, 0x80(%rsp)
1800095ba:     	movq	0x298(%rsp), %rax
1800095c2:     	movq	%rax, 0x78(%rsp)
1800095c7:     	movq	%r14, 0x70(%rsp)
1800095cc:     	movq	%r13, 0x68(%rsp)
1800095d1:     	movq	0x280(%rsp), %rax
1800095d9:     	movq	%rax, 0x60(%rsp)
1800095de:     	movq	0x278(%rsp), %rax
1800095e6:     	movq	%rax, 0x58(%rsp)
1800095eb:     	movq	0x270(%rsp), %rax
1800095f3:     	movq	%rax, 0x50(%rsp)
1800095f8:     	movq	0x268(%rsp), %rax
180009600:     	movq	%rax, 0x48(%rsp)
180009605:     	movq	0x260(%rsp), %rax
18000960d:     	movq	%rax, 0x40(%rsp)
180009612:     	movq	%rbp, 0x38(%rsp)
180009617:     	movq	%rbx, 0x30(%rsp)
18000961c:     	movq	0x248(%rsp), %rax
180009624:     	movq	%rax, 0x28(%rsp)
180009629:     	movq	0x240(%rsp), %rax
180009631:     	movq	%rax, 0x20(%rsp)
180009636:     	movq	$-0x1, 0x100(%rsp)
180009642:     	movq	$-0x1, 0xf8(%rsp)
18000964e:     	movq	$0x1, 0xf0(%rsp)
18000965a:     	leaq	0x137(%rsp), %rcx
180009662:     	leaq	0x1b8(%rsp), %rdx
18000966a:     	movq	%r8, 0x128(%rsp)
180009672:     	movq	%r9, 0x148(%rsp)
18000967a:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000967f:     	testl	%eax, %eax
180009681:     	jne	0x180009f0d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f2d>
180009687:     	cmpb	$0x0, (%r15)
18000968b:     	movq	0x110(%rsp), %rcx
180009693:     	movq	0x120(%rsp), %rdx
18000969b:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
1800096a1:     	decq	0x8(%r12)
1800096a6:     	movq	0x148(%rsp), %r9
1800096ae:     	movq	0x128(%rsp), %r8
1800096b6:     	jmp	0x180009069 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5089>
1800096bb:     	movb	$0x1, (%r15)
1800096bf:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
1800096c8:     	movb	$0x0, (%rcx)
1800096cb:     	jmp	0x1800092e2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5302>
1800096d0:     	xorl	%eax, %eax
1800096d2:     	movq	0x148(%rsp), %r8
1800096da:     	cmpq	$-0x1, %r8
1800096de:     	cmovlq	%r14, %rax
1800096e2:     	movq	0x128(%rsp), %r9
1800096ea:     	cmpq	0x8(%r9,%rax,8), %r11
1800096ef:     	jne	0x180009cd4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5cf4>
1800096f5:     	movq	%rax, 0x1d0(%rsp)
1800096fd:     	leaq	(%r11,%r11), %rax
180009701:     	testq	%r11, %r11
180009704:     	movl	$0x4, %r9d
18000970a:     	cmovneq	%rax, %r9
18000970e:     	movq	(%r12), %rdx
180009712:     	movq	%rdx, 0x138(%rsp)
18000971a:     	addq	%r9, %rdx
18000971d:     	cmpq	%r14, %rdx
180009720:     	jg	0x180008f2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4f4a>
180009726:     	movq	%rdx, (%r12)
18000972a:     	cmpb	$0x0, (%r15)
18000972e:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009734:     	movq	%r10, 0x1c0(%rsp)
18000973c:     	movq	%r9, 0x1c8(%rsp)
180009744:     	xorl	%eax, %eax
180009746:     	cmpq	$-0x2, %r8
18000974a:     	cmovlq	%r14, %rax
18000974e:     	movq	%rax, 0x168(%rsp)
180009756:     	movq	%r11, 0x170(%rsp)
18000975e:     	testq	%r11, %r11
180009761:     	jle	0x180009c8a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5caa>
180009767:     	movq	0x128(%rsp), %rax
18000976f:     	movq	0x168(%rsp), %rdx
180009777:     	movq	0x10(%rax,%rdx,8), %r8
18000977c:     	movq	0x170(%rsp), %rax
180009784:     	movl	%eax, %edx
180009786:     	andl	$0x7, %edx
180009789:     	movq	%rdx, 0x160(%rsp)
180009791:     	cmpq	$0x7, %rax
180009795:     	ja	0x1800099be <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59de>
18000979b:     	leaq	(,%r14,8), %rax
1800097a3:     	movq	%rax, 0x110(%rsp)
1800097ab:     	xorl	%edx, %edx
1800097ad:     	movq	0x160(%rsp), %r9
1800097b5:     	jmp	0x180009c40 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5c60>
1800097ba:     	movb	$0x1, (%r15)
1800097be:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
1800097c7:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
1800097cc:     	movb	$0x1, (%r15)
1800097d0:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
1800097d9:     	jmp	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
1800097de:     	movb	$0x1, (%r15)
1800097e2:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
1800097eb:     	movb	$0x0, (%rcx)
1800097ee:     	jmp	0x1800092e2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5302>
1800097f3:     	movb	$0x0, 0x11e(%rsp)
1800097fb:     	movq	0x320(%rsp), %rax
180009803:     	movq	%rax, 0x100(%rsp)
18000980b:     	movq	%r8, 0xf8(%rsp)
180009813:     	movq	0x308(%rsp), %rax
18000981b:     	movq	%rax, 0xe8(%rsp)
180009823:     	movq	0x300(%rsp), %rax
18000982b:     	movq	%rax, 0xe0(%rsp)
180009833:     	movq	%r15, 0xd8(%rsp)
18000983b:     	movq	0x2f0(%rsp), %rax
180009843:     	movq	%rax, 0xd0(%rsp)
18000984b:     	movq	0x2e8(%rsp), %rax
180009853:     	movq	%rax, 0xc8(%rsp)
18000985b:     	movq	0x2e0(%rsp), %rax
180009863:     	movq	%rax, 0xc0(%rsp)
18000986b:     	movq	0x2d8(%rsp), %rax
180009873:     	movq	%rax, 0xb8(%rsp)
18000987b:     	movq	0x2d0(%rsp), %rax
180009883:     	movq	%rax, 0xb0(%rsp)
18000988b:     	movq	0x2c8(%rsp), %rax
180009893:     	movq	%rax, 0xa8(%rsp)
18000989b:     	movq	%r12, 0xa0(%rsp)
1800098a3:     	movq	0x2b8(%rsp), %rax
1800098ab:     	movq	%rax, 0x98(%rsp)
1800098b3:     	movq	0x2b0(%rsp), %rax
1800098bb:     	movq	%rax, 0x90(%rsp)
1800098c3:     	movq	0x2a8(%rsp), %rax
1800098cb:     	movq	%rax, 0x88(%rsp)
1800098d3:     	movq	0x2a0(%rsp), %rax
1800098db:     	movq	%rax, 0x80(%rsp)
1800098e3:     	movq	0x298(%rsp), %rax
1800098eb:     	movq	%rax, 0x78(%rsp)
1800098f0:     	movq	%r14, 0x70(%rsp)
1800098f5:     	movq	%r13, 0x68(%rsp)
1800098fa:     	movq	0x280(%rsp), %rax
180009902:     	movq	%rax, 0x60(%rsp)
180009907:     	movq	0x278(%rsp), %rax
18000990f:     	movq	%rax, 0x58(%rsp)
180009914:     	movq	0x270(%rsp), %rax
18000991c:     	movq	%rax, 0x50(%rsp)
180009921:     	movq	0x268(%rsp), %rax
180009929:     	movq	%rax, 0x48(%rsp)
18000992e:     	movq	0x260(%rsp), %rax
180009936:     	movq	%rax, 0x40(%rsp)
18000993b:     	movq	%rbp, 0x38(%rsp)
180009940:     	movq	%rbx, 0x30(%rsp)
180009945:     	movq	0x248(%rsp), %rax
18000994d:     	movq	%rax, 0x28(%rsp)
180009952:     	movq	0x240(%rsp), %rax
18000995a:     	movq	%rax, 0x20(%rsp)
18000995f:     	movq	$-0x1, 0x108(%rsp)
18000996b:     	movq	$0x0, 0xf0(%rsp)
180009977:     	leaq	0x11e(%rsp), %rcx
18000997f:     	leaq	0x1a8(%rsp), %rdx
180009987:     	movq	0x128(%rsp), %r8
18000998f:     	movq	0x148(%rsp), %r9
180009997:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000999c:     	testl	%eax, %eax
18000999e:     	jne	0x18000a282 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x62a2>
1800099a4:     	cmpb	$0x0, (%r15)
1800099a8:     	je	0x180009ea2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5ec2>
1800099ae:     	movq	0x110(%rsp), %rax
1800099b6:     	movb	$0x0, (%rax)
1800099b9:     	jmp	0x1800092e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5300>
1800099be:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
1800099c8:     	andq	%rax, %rdx
1800099cb:     	movq	%rdx, 0x158(%rsp)
1800099d3:     	movq	0x138(%rsp), %rax
1800099db:     	leaq	(%r13,%rax,8), %rax
1800099e0:     	movq	%rax, 0x150(%rsp)
1800099e8:     	xorl	%edx, %edx
1800099ea:     	leaq	(%r8,%rdx), %rax
1800099ee:     	sarq	$0x3f, %rax
1800099f2:     	leaq	(,%r14,8), %r11
1800099fa:     	movq	%r11, 0x110(%rsp)
180009a02:     	andq	%r11, %rax
180009a05:     	leaq	(%r13,%r8,8), %r9
180009a0a:     	movq	%r9, 0x120(%rsp)
180009a12:     	addq	%r9, %rax
180009a15:     	movq	(%rax,%rdx,8), %rax
180009a19:     	movq	%rax, 0x140(%rsp)
180009a21:     	movq	0x138(%rsp), %r9
180009a29:     	leaq	(%r9,%rdx), %rax
180009a2d:     	sarq	$0x3f, %rax
180009a31:     	andq	%r11, %rax
180009a34:     	movq	0x150(%rsp), %r11
180009a3c:     	addq	%r11, %rax
180009a3f:     	movq	0x140(%rsp), %r10
180009a47:     	movq	%r10, (%rax,%rdx,8)
180009a4b:     	leaq	0x1(%r8,%rdx), %rax
180009a50:     	sarq	$0x3f, %rax
180009a54:     	movq	0x110(%rsp), %r10
180009a5c:     	andq	%r10, %rax
180009a5f:     	addq	0x120(%rsp), %rax
180009a67:     	movq	0x8(%rax,%rdx,8), %rax
180009a6c:     	movq	%rax, 0x140(%rsp)
180009a74:     	leaq	0x1(%r9,%rdx), %rax
180009a79:     	sarq	$0x3f, %rax
180009a7d:     	andq	%r10, %rax
180009a80:     	addq	%r11, %rax
180009a83:     	movq	0x140(%rsp), %r10
180009a8b:     	movq	%r10, 0x8(%rax,%rdx,8)
180009a90:     	leaq	0x2(%r8,%rdx), %rax
180009a95:     	sarq	$0x3f, %rax
180009a99:     	movq	0x110(%rsp), %r10
180009aa1:     	andq	%r10, %rax
180009aa4:     	addq	0x120(%rsp), %rax
180009aac:     	movq	0x10(%rax,%rdx,8), %rax
180009ab1:     	movq	%rax, 0x140(%rsp)
180009ab9:     	leaq	0x2(%r9,%rdx), %rax
180009abe:     	sarq	$0x3f, %rax
180009ac2:     	andq	%r10, %rax
180009ac5:     	addq	%r11, %rax
180009ac8:     	movq	0x140(%rsp), %r10
180009ad0:     	movq	%r10, 0x10(%rax,%rdx,8)
180009ad5:     	leaq	0x3(%r8,%rdx), %rax
180009ada:     	sarq	$0x3f, %rax
180009ade:     	andq	0x110(%rsp), %rax
180009ae6:     	addq	0x120(%rsp), %rax
180009aee:     	movq	0x18(%rax,%rdx,8), %r10
180009af3:     	leaq	0x3(%r9,%rdx), %rax
180009af8:     	sarq	$0x3f, %rax
180009afc:     	andq	0x110(%rsp), %rax
180009b04:     	addq	%r11, %rax
180009b07:     	movq	%r10, 0x18(%rax,%rdx,8)
180009b0c:     	leaq	0x4(%r8,%rdx), %rax
180009b11:     	sarq	$0x3f, %rax
180009b15:     	movq	0x110(%rsp), %r10
180009b1d:     	andq	%r10, %rax
180009b20:     	addq	0x120(%rsp), %rax
180009b28:     	movq	0x20(%rax,%rdx,8), %rax
180009b2d:     	movq	%rax, 0x140(%rsp)
180009b35:     	leaq	0x4(%r9,%rdx), %rax
180009b3a:     	sarq	$0x3f, %rax
180009b3e:     	andq	%r10, %rax
180009b41:     	addq	%r11, %rax
180009b44:     	movq	0x140(%rsp), %r11
180009b4c:     	movq	%r11, 0x20(%rax,%rdx,8)
180009b51:     	leaq	0x5(%r8,%rdx), %rax
180009b56:     	sarq	$0x3f, %rax
180009b5a:     	andq	%r10, %rax
180009b5d:     	movq	0x120(%rsp), %r11
180009b65:     	addq	%r11, %rax
180009b68:     	movq	0x28(%rax,%rdx,8), %rax
180009b6d:     	movq	%rax, 0x140(%rsp)
180009b75:     	leaq	0x5(%r9,%rdx), %rax
180009b7a:     	sarq	$0x3f, %rax
180009b7e:     	andq	%r10, %rax
180009b81:     	movq	0x150(%rsp), %r11
180009b89:     	addq	%r11, %rax
180009b8c:     	movq	0x140(%rsp), %r10
180009b94:     	movq	%r10, 0x28(%rax,%rdx,8)
180009b99:     	leaq	0x6(%r8,%rdx), %rax
180009b9e:     	sarq	$0x3f, %rax
180009ba2:     	movq	0x110(%rsp), %r10
180009baa:     	andq	%r10, %rax
180009bad:     	addq	0x120(%rsp), %rax
180009bb5:     	movq	0x30(%rax,%rdx,8), %rax
180009bba:     	movq	%rax, 0x140(%rsp)
180009bc2:     	leaq	0x6(%r9,%rdx), %rax
180009bc7:     	sarq	$0x3f, %rax
180009bcb:     	andq	%r10, %rax
180009bce:     	movq	%r10, %r9
180009bd1:     	addq	%r11, %rax
180009bd4:     	movq	0x140(%rsp), %r10
180009bdc:     	movq	%r10, 0x30(%rax,%rdx,8)
180009be1:     	leaq	0x7(%r8,%rdx), %rax
180009be6:     	sarq	$0x3f, %rax
180009bea:     	andq	%r9, %rax
180009bed:     	movq	%r9, %r10
180009bf0:     	addq	0x120(%rsp), %rax
180009bf8:     	movq	0x38(%rax,%rdx,8), %r9
180009bfd:     	movq	0x138(%rsp), %rax
180009c05:     	leaq	0x7(%rax,%rdx), %rax
180009c0a:     	sarq	$0x3f, %rax
180009c0e:     	andq	%r10, %rax
180009c11:     	addq	%r11, %rax
180009c14:     	movq	%r9, 0x38(%rax,%rdx,8)
180009c19:     	addq	$0x8, %rdx
180009c1d:     	cmpq	%rdx, 0x158(%rsp)
180009c25:     	jne	0x1800099ea <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5a0a>
180009c2b:     	movq	0x160(%rsp), %r9
180009c33:     	testq	%r9, %r9
180009c36:     	movq	0x158(%rsp), %rdx
180009c3e:     	je	0x180009c8a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5caa>
180009c40:     	movq	0x138(%rsp), %rax
180009c48:     	leaq	(%rdx,%rax), %r11
180009c4c:     	addq	%rdx, %r8
180009c4f:     	movq	%r8, %rax
180009c52:     	sarq	$0x3f, %rax
180009c56:     	movq	%r8, %r10
180009c59:     	movq	0x110(%rsp), %r8
180009c61:     	andq	%r8, %rax
180009c64:     	addq	%r13, %rax
180009c67:     	movq	(%rax,%r10,8), %rax
180009c6b:     	movq	%r11, %rdx
180009c6e:     	sarq	$0x3f, %rdx
180009c72:     	andq	%r8, %rdx
180009c75:     	movq	%r10, %r8
180009c78:     	addq	%r13, %rdx
180009c7b:     	movq	%rax, (%rdx,%r11,8)
180009c7f:     	incq	%r11
180009c82:     	incq	%r8
180009c85:     	decq	%r9
180009c88:     	jne	0x180009c4f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5c6f>
180009c8a:     	movq	0x128(%rsp), %r9
180009c92:     	movq	0x1d0(%rsp), %rax
180009c9a:     	movq	0x1c8(%rsp), %rdx
180009ca2:     	movq	%rdx, 0x8(%r9,%rax,8)
180009ca7:     	movq	0x138(%rsp), %rax
180009caf:     	movq	0x168(%rsp), %rdx
180009cb7:     	movq	%rax, 0x10(%r9,%rdx,8)
180009cbc:     	movq	0x170(%rsp), %r11
180009cc4:     	movq	0x148(%rsp), %r8
180009ccc:     	movq	0x1c0(%rsp), %r10
180009cd4:     	leaq	0x1(%r11), %rax
180009cd8:     	movq	%rax, (%r9,%r10,8)
180009cdc:     	cmpb	$0x0, (%r15)
180009ce0:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009ce6:     	xorl	%edx, %edx
180009ce8:     	cmpq	$-0x2, %r8
180009cec:     	movl	$0x0, %eax
180009cf1:     	cmovlq	%r14, %rax
180009cf5:     	addq	0x10(%r9,%rax,8), %r11
180009cfa:     	movq	%r11, %rax
180009cfd:     	sarq	$0x3f, %rax
180009d01:     	andq	%r14, %rax
180009d04:     	leaq	(%r13,%r11,8), %r8
180009d09:     	movq	0x320(%rsp), %r10
180009d11:     	movq	%r10, (%r8,%rax,8)
180009d15:     	cmpq	$-0x9, %rdi
180009d19:     	cmovgeq	%rdx, %rbp
180009d1d:     	leaq	(%rbx,%rdi,8), %rax
180009d21:     	movsd	0x48(%rax,%rbp,8), %xmm1
180009d27:     	cmpq	$-0xa, %rdi
180009d2b:     	cmovlq	%r14, %rdx
180009d2f:     	movsd	0x8(%rbx,%r10,8), %xmm2
180009d36:     	movapd	%xmm1, %xmm0
180009d3a:     	addsd	%xmm2, %xmm0
180009d3e:     	xorpd	%xmm3, %xmm3
180009d42:     	ucomisd	%xmm3, %xmm0
180009d46:     	jbe	0x180009e5b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e7b>
180009d4c:     	xorl	%r8d, %r8d
180009d4f:     	cmpq	$-0x2, %rdi
180009d53:     	cmovlq	%r14, %r8
180009d57:     	movq	0x10(%rsi,%r8,8), %r9
180009d5c:     	testq	%r9, %r9
180009d5f:     	js	0x180009e74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e94>
180009d65:     	cmpq	$0x0, 0x8(%r13,%r9,8)
180009d6b:     	mulsd	(%rbx,%r9,8), %xmm1
180009d71:     	je	0x180009d9d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5dbd>
180009d73:     	cmpq	$0x0, 0x50(%rsi,%rdx,8)
180009d79:     	je	0x180009d9d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5dbd>
180009d7b:     	movapd	0x563d(%rip), %xmm3     # 0x18000f3c0
180009d83:     	andpd	%xmm1, %xmm3
180009d87:     	ucomisd	0x5641(%rip), %xmm3     # 0x18000f3d0
180009d8f:     	jae	0x180009e74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e94>
180009d95:     	xorpd	%xmm3, %xmm3
180009d99:     	addsd	%xmm3, %xmm1
180009d9d:     	movq	0x10(%r13,%r10,8), %r10
180009da2:     	testq	%r10, %r10
180009da5:     	js	0x180009e74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e94>
180009dab:     	mulsd	(%rbx,%r10,8), %xmm2
180009db1:     	addsd	%xmm2, %xmm1
180009db5:     	divsd	%xmm0, %xmm1
180009db9:     	movsd	%xmm1, (%rbx,%r9,8)
180009dbf:     	movq	$0x0, 0x8(%r13,%r9,8)
180009dc8:     	movq	0x10(%rsi,%r8,8), %r8
180009dcd:     	testq	%r8, %r8
180009dd0:     	js	0x180009e83 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5ea3>
180009dd6:     	movsd	0x10(%rbx,%r8,8), %xmm1
180009ddd:     	cmpq	$0x0, 0x18(%r13,%r8,8)
180009de3:     	mulsd	0x48(%rax,%rbp,8), %xmm1
180009de9:     	je	0x180009e11 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e31>
180009deb:     	cmpq	$0x0, 0x50(%rsi,%rdx,8)
180009df1:     	je	0x180009e11 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e31>
180009df3:     	movapd	0x55c5(%rip), %xmm2     # 0x18000f3c0
180009dfb:     	andpd	%xmm1, %xmm2
180009dff:     	ucomisd	0x55c9(%rip), %xmm2     # 0x18000f3d0
180009e07:     	jae	0x180009e83 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5ea3>
180009e09:     	xorpd	%xmm2, %xmm2
180009e0d:     	addsd	%xmm2, %xmm1
180009e11:     	movq	0x320(%rsp), %r9
180009e19:     	movq	0x10(%r13,%r9,8), %r9
180009e1e:     	testq	%r9, %r9
180009e21:     	js	0x180009e83 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5ea3>
180009e23:     	shlq	$0x3, %rbp
180009e27:     	shlq	$0x3, %rdx
180009e2b:     	movsd	0x10(%rbx,%r9,8), %xmm2
180009e32:     	movq	0x320(%rsp), %r9
180009e3a:     	mulsd	0x8(%rbx,%r9,8), %xmm2
180009e41:     	addsd	%xmm2, %xmm1
180009e45:     	divsd	%xmm0, %xmm1
180009e49:     	movsd	%xmm1, 0x10(%rbx,%r8,8)
180009e50:     	movq	$0x0, 0x18(%r13,%r8,8)
180009e59:     	jmp	0x180009e63 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5e83>
180009e5b:     	shlq	$0x3, %rbp
180009e5f:     	shlq	$0x3, %rdx
180009e63:     	movsd	%xmm0, 0x48(%rax,%rbp)
180009e69:     	movq	$0x0, 0x50(%rsi,%rdx)
180009e72:     	jmp	0x180009e90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5eb0>
180009e74:     	movb	$0x1, (%r15)
180009e78:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
180009e81:     	jmp	0x180009e90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5eb0>
180009e83:     	movb	$0x1, (%r15)
180009e87:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180009e90:     	cmpb	$0x0, (%r15)
180009e94:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
180009e9a:     	movb	$0x1, (%rcx)
180009e9d:     	jmp	0x1800092e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5300>
180009ea2:     	movzbl	0x11e(%rsp), %eax
180009eaa:     	movq	0x8(%r12), %rcx
180009eaf:     	leaq	-0x1(%rcx), %rdx
180009eb3:     	movq	%rdx, 0x8(%r12)
180009eb8:     	testb	$0x1, %al
180009eba:     	je	0x180009ecc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5eec>
180009ebc:     	movq	0x110(%rsp), %rax
180009ec4:     	movb	$0x1, (%rax)
180009ec7:     	jmp	0x1800092e0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5300>
180009ecc:     	xorl	%eax, %eax
180009ece:     	cmpq	$-0x7, %rdi
180009ed2:     	movl	$0x0, %edx
180009ed7:     	cmovlq	%r14, %rdx
180009edb:     	movq	0x38(%rsi,%rdx,8), %rdx
180009ee0:     	testq	%rdx, %rdx
180009ee3:     	js	0x180009f25 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f45>
180009ee5:     	movq	%rcx, 0x8(%r12)
180009eea:     	cmpq	0x10(%r12), %rcx
180009eef:     	jle	0x180009f42 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f62>
180009ef1:     	movb	$0x1, (%r15)
180009ef5:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
180009efe:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
180009f03:     	movq	0x1b0(%rsp), %rdx
180009f0b:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
180009f0d:     	movq	0x1b8(%rsp), %rdx
180009f15:     	movq	0x120(%rsp), %rcx
180009f1d:     	movq	%rdx, (%rcx)
180009f20:     	jmp	0x1800092e2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5302>
180009f25:     	movb	$0x1, (%r15)
180009f29:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
180009f32:     	movq	0x110(%rsp), %rcx
180009f3a:     	movb	$0x0, (%rcx)
180009f3d:     	jmp	0x1800092e2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5302>
180009f42:     	movb	$0x0, 0x11d(%rsp)
180009f4a:     	movq	0x320(%rsp), %rax
180009f52:     	movq	%rax, 0x100(%rsp)
180009f5a:     	movq	%rdx, 0xf8(%rsp)
180009f62:     	movq	0x308(%rsp), %rax
180009f6a:     	movq	%rax, 0xe8(%rsp)
180009f72:     	movq	0x300(%rsp), %rax
180009f7a:     	movq	%rax, 0xe0(%rsp)
180009f82:     	movq	%r15, 0xd8(%rsp)
180009f8a:     	movq	0x2f0(%rsp), %rax
180009f92:     	movq	%rax, 0xd0(%rsp)
180009f9a:     	movq	0x2e8(%rsp), %rax
180009fa2:     	movq	%rax, 0xc8(%rsp)
180009faa:     	movq	0x2e0(%rsp), %rax
180009fb2:     	movq	%rax, 0xc0(%rsp)
180009fba:     	movq	0x2d8(%rsp), %rax
180009fc2:     	movq	%rax, 0xb8(%rsp)
180009fca:     	movq	0x2d0(%rsp), %rax
180009fd2:     	movq	%rax, 0xb0(%rsp)
180009fda:     	movq	0x2c8(%rsp), %rax
180009fe2:     	movq	%rax, 0xa8(%rsp)
180009fea:     	movq	%r12, 0xa0(%rsp)
180009ff2:     	movq	0x2b8(%rsp), %rax
180009ffa:     	movq	%rax, 0x98(%rsp)
18000a002:     	movq	0x2b0(%rsp), %rax
18000a00a:     	movq	%rax, 0x90(%rsp)
18000a012:     	movq	0x2a8(%rsp), %rax
18000a01a:     	movq	%rax, 0x88(%rsp)
18000a022:     	movq	0x2a0(%rsp), %rax
18000a02a:     	movq	%rax, 0x80(%rsp)
18000a032:     	movq	0x298(%rsp), %rax
18000a03a:     	movq	%rax, 0x78(%rsp)
18000a03f:     	movq	%r14, 0x70(%rsp)
18000a044:     	movq	%r13, 0x68(%rsp)
18000a049:     	movq	0x280(%rsp), %rax
18000a051:     	movq	%rax, 0x60(%rsp)
18000a056:     	movq	0x278(%rsp), %rax
18000a05e:     	movq	%rax, 0x58(%rsp)
18000a063:     	movq	0x270(%rsp), %rax
18000a06b:     	movq	%rax, 0x50(%rsp)
18000a070:     	movq	0x268(%rsp), %rax
18000a078:     	movq	%rax, 0x48(%rsp)
18000a07d:     	movq	0x260(%rsp), %rax
18000a085:     	movq	%rax, 0x40(%rsp)
18000a08a:     	movq	%rbp, 0x38(%rsp)
18000a08f:     	movq	%rbx, 0x30(%rsp)
18000a094:     	movq	0x248(%rsp), %rax
18000a09c:     	movq	%rax, 0x28(%rsp)
18000a0a1:     	movq	0x240(%rsp), %rax
18000a0a9:     	movq	%rax, 0x20(%rsp)
18000a0ae:     	movq	$-0x1, 0x108(%rsp)
18000a0ba:     	movq	$0x0, 0xf0(%rsp)
18000a0c6:     	leaq	0x11d(%rsp), %rcx
18000a0ce:     	leaq	0x1a0(%rsp), %rdx
18000a0d6:     	movq	0x128(%rsp), %r8
18000a0de:     	movq	0x148(%rsp), %r9
18000a0e6:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000a0eb:     	testl	%eax, %eax
18000a0ed:     	jne	0x18000a5bf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x65df>
18000a0f3:     	cmpb	$0x0, (%r15)
18000a0f7:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a0fd:     	movzbl	0x11d(%rsp), %eax
18000a105:     	movq	0x8(%r12), %rcx
18000a10a:     	leaq	-0x1(%rcx), %rdx
18000a10e:     	movq	%rdx, 0x8(%r12)
18000a113:     	testb	$0x1, %al
18000a115:     	jne	0x180009ebc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5edc>
18000a11b:     	xorl	%eax, %eax
18000a11d:     	cmpq	$-0x8, %rdi
18000a121:     	movl	$0x0, %edx
18000a126:     	cmovlq	%r14, %rdx
18000a12a:     	movq	0x40(%rsi,%rdx,8), %rdx
18000a12f:     	testq	%rdx, %rdx
18000a132:     	js	0x18000a28f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x62af>
18000a138:     	movq	%rcx, 0x8(%r12)
18000a13d:     	cmpq	0x10(%r12), %rcx
18000a142:     	jle	0x18000a2a1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x62c1>
18000a148:     	movb	$0x1, (%r15)
18000a14c:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
18000a155:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a15a:     	movb	$0x1, (%r15)
18000a15e:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
18000a163:     	movq	%r12, %rcx
18000a166:     	movq	%rdx, 0x18(%rcx)
18000a16a:     	cmpb	$0x0, (%r15)
18000a16e:     	movq	0x110(%rsp), %rcx
18000a176:     	movq	0x138(%rsp), %rax
18000a17e:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
18000a184:     	xorl	%edx, %edx
18000a186:     	cmpq	$-0x2, %rax
18000a18a:     	movl	$0x0, %r8d
18000a190:     	cmovlq	%r14, %r8
18000a194:     	leaq	(%r13,%rax,8), %r10
18000a199:     	movq	%r11, 0x10(%r10,%r8,8)
18000a19e:     	cmpq	$-0x9, %rax
18000a1a2:     	movl	$0x0, %r8d
18000a1a8:     	cmovlq	%rbp, %r8
18000a1ac:     	leaq	(%rbx,%rax,8), %r9
18000a1b0:     	movq	$0x0, 0x48(%r9,%r8,8)
18000a1b9:     	cmpq	$-0xa, %rax
18000a1bd:     	movl	$0x0, %r8d
18000a1c3:     	cmovlq	%r14, %r8
18000a1c7:     	movq	$0x1, 0x50(%r10,%r8,8)
18000a1d0:     	cmpq	$-0x4, %rax
18000a1d4:     	movl	$0x0, %r8d
18000a1da:     	cmovlq	%r14, %r8
18000a1de:     	movq	$-0x1, 0x20(%r10,%r8,8)
18000a1e7:     	cmpq	$-0x5, %rax
18000a1eb:     	movl	$0x0, %r8d
18000a1f1:     	cmovlq	%r14, %r8
18000a1f5:     	movq	$-0x1, 0x28(%r10,%r8,8)
18000a1fe:     	cmpq	$-0x7, %rax
18000a202:     	movl	$0x0, %r8d
18000a208:     	cmovlq	%r14, %r8
18000a20c:     	movq	$-0x1, 0x38(%r10,%r8,8)
18000a215:     	cmpq	$-0x8, %rax
18000a219:     	cmovlq	%r14, %rdx
18000a21d:     	movq	$-0x1, 0x40(%r10,%rdx,8)
18000a226:     	cmpb	$0x0, (%r15)
18000a22a:     	jne	0x1800092dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x52fd>
18000a230:     	movq	%rax, 0x20(%r13,%rsi,8)
18000a235:     	movq	(%r12), %rdx
18000a239:     	leaq	0x4(%rdx), %rax
18000a23d:     	cmpq	%r14, %rax
18000a240:     	jle	0x18000a24b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x626b>
18000a242:     	movb	$0x2, (%r15)
18000a246:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a24b:     	movq	%rax, (%r12)
18000a24f:     	cmpb	$0x0, (%r15)
18000a253:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a259:     	subsd	%xmm3, %xmm1
18000a25d:     	testq	%rdx, %rdx
18000a260:     	js	0x18000a476 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6496>
18000a266:     	movsd	%xmm1, 0x10(%rbx,%rdx,8)
18000a26c:     	movsd	%xmm5, 0x18(%rbx,%rdx,8)
18000a272:     	movsd	%xmm3, 0x8(%rbx,%rdx,8)
18000a278:     	movsd	%xmm0, (%rbx,%rdx,8)
18000a27d:     	jmp	0x18000a483 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x64a3>
18000a282:     	movq	0x1a8(%rsp), %rdx
18000a28a:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000a28f:     	movb	$0x1, (%r15)
18000a293:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
18000a29c:     	jmp	0x180009f32 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f52>
18000a2a1:     	movb	$0x0, 0x11c(%rsp)
18000a2a9:     	movq	0x320(%rsp), %rax
18000a2b1:     	movq	%rax, 0x100(%rsp)
18000a2b9:     	movq	%rdx, 0xf8(%rsp)
18000a2c1:     	movq	0x308(%rsp), %rax
18000a2c9:     	movq	%rax, 0xe8(%rsp)
18000a2d1:     	movq	0x300(%rsp), %rax
18000a2d9:     	movq	%rax, 0xe0(%rsp)
18000a2e1:     	movq	0x2f0(%rsp), %rax
18000a2e9:     	movq	%rax, 0xd0(%rsp)
18000a2f1:     	movq	0x2e8(%rsp), %rax
18000a2f9:     	movq	%rax, 0xc8(%rsp)
18000a301:     	movq	0x2e0(%rsp), %rax
18000a309:     	movq	%rax, 0xc0(%rsp)
18000a311:     	movq	0x2d8(%rsp), %rax
18000a319:     	movq	%rax, 0xb8(%rsp)
18000a321:     	movq	0x2d0(%rsp), %rax
18000a329:     	movq	%rax, 0xb0(%rsp)
18000a331:     	movq	0x2c8(%rsp), %rax
18000a339:     	movq	%rax, 0xa8(%rsp)
18000a341:     	movq	0x2b8(%rsp), %rax
18000a349:     	movq	%rax, 0x98(%rsp)
18000a351:     	movq	0x2b0(%rsp), %rax
18000a359:     	movq	%rax, 0x90(%rsp)
18000a361:     	movq	0x2a8(%rsp), %rax
18000a369:     	movq	%rax, 0x88(%rsp)
18000a371:     	movq	0x2a0(%rsp), %rax
18000a379:     	movq	%rax, 0x80(%rsp)
18000a381:     	movq	0x298(%rsp), %rax
18000a389:     	movq	%rax, 0x78(%rsp)
18000a38e:     	movq	%r14, 0x70(%rsp)
18000a393:     	movq	%r13, 0x68(%rsp)
18000a398:     	movq	0x280(%rsp), %rax
18000a3a0:     	movq	%rax, 0x60(%rsp)
18000a3a5:     	movq	0x278(%rsp), %rax
18000a3ad:     	movq	%rax, 0x58(%rsp)
18000a3b2:     	movq	0x270(%rsp), %rax
18000a3ba:     	movq	%rax, 0x50(%rsp)
18000a3bf:     	movq	0x268(%rsp), %rax
18000a3c7:     	movq	%rax, 0x48(%rsp)
18000a3cc:     	movq	0x260(%rsp), %rax
18000a3d4:     	movq	%rax, 0x40(%rsp)
18000a3d9:     	movq	%rbp, 0x38(%rsp)
18000a3de:     	movq	%rbx, 0x30(%rsp)
18000a3e3:     	movq	%r15, 0xd8(%rsp)
18000a3eb:     	movq	%r12, 0xa0(%rsp)
18000a3f3:     	movq	0x248(%rsp), %rax
18000a3fb:     	movq	%rax, 0x28(%rsp)
18000a400:     	movq	0x240(%rsp), %rax
18000a408:     	movq	%rax, 0x20(%rsp)
18000a40d:     	movq	$-0x1, 0x108(%rsp)
18000a419:     	movq	$0x0, 0xf0(%rsp)
18000a425:     	leaq	0x11c(%rsp), %rcx
18000a42d:     	leaq	0x198(%rsp), %rdx
18000a435:     	movq	0x128(%rsp), %r8
18000a43d:     	movq	0x148(%rsp), %r9
18000a445:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000a44a:     	testl	%eax, %eax
18000a44c:     	jne	0x18000a5cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x65ec>
18000a452:     	cmpb	$0x0, (%r15)
18000a456:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a45c:     	movzbl	0x11c(%rsp), %eax
18000a464:     	decq	0x8(%r12)
18000a469:     	testb	$0x1, %al
18000a46b:     	je	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a471:     	jmp	0x180009ebc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5edc>
18000a476:     	movb	$0x1, (%r15)
18000a47a:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
18000a483:     	cmpb	$0x0, (%r15)
18000a487:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a48d:     	movq	(%r12), %rax
18000a491:     	leaq	0xb(%rax), %rcx
18000a495:     	cmpq	%r14, %rcx
18000a498:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a49e:     	movq	0x8(%r13,%rsi,8), %r8
18000a4a3:     	movq	%rcx, (%r12)
18000a4a7:     	cmpb	$0x0, (%r15)
18000a4ab:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a4b1:     	movq	%rax, %r9
18000a4b4:     	sarq	$0x3f, %r9
18000a4b8:     	andq	%r14, %r9
18000a4bb:     	leaq	(%r13,%rax,8), %rcx
18000a4c0:     	movq	%rdx, (%rcx,%r9,8)
18000a4c4:     	xorl	%edx, %edx
18000a4c6:     	cmpq	$-0x1, %rax
18000a4ca:     	cmovlq	%r14, %rdx
18000a4ce:     	movq	%r8, 0x8(%rcx,%rdx,8)
18000a4d3:     	movq	(%r12), %rdx
18000a4d7:     	cmpq	%r14, %rdx
18000a4da:     	movq	%rdx, %r8
18000a4dd:     	jle	0x18000a4ea <PyInit_rcaotr_2c76336ff39711e0671e54df+0x650a>
18000a4df:     	movb	$0x2, (%r15)
18000a4e3:     	movq	(%r12), %rdx
18000a4e7:     	xorl	%r8d, %r8d
18000a4ea:     	leaq	0x3(%rdx), %r9
18000a4ee:     	cmpq	%r14, %r9
18000a4f1:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a4f7:     	movq	%r9, (%r12)
18000a4fb:     	cmpb	$0x0, (%r15)
18000a4ff:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a505:     	movq	%rdx, %r9
18000a508:     	sarq	$0x3f, %r9
18000a50c:     	andq	%r14, %r9
18000a50f:     	leaq	(%r13,%rdx,8), %r10
18000a514:     	movq	$0x0, (%r10,%r9,8)
18000a51c:     	xorl	%r9d, %r9d
18000a51f:     	cmpq	$-0x1, %rdx
18000a523:     	movl	$0x0, %r11d
18000a529:     	cmovlq	%r14, %r11
18000a52d:     	movq	$0x0, 0x8(%r10,%r11,8)
18000a536:     	cmpq	$-0x2, %rdx
18000a53a:     	cmovlq	%r14, %r9
18000a53e:     	movq	%r8, 0x10(%r10,%r9,8)
18000a543:     	cmpb	$0x0, (%r15)
18000a547:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a54d:     	xorl	%r8d, %r8d
18000a550:     	cmpq	$-0x6, %rax
18000a554:     	movl	$0x0, %r9d
18000a55a:     	cmovlq	%r14, %r9
18000a55e:     	movq	%rdx, 0x30(%rcx,%r9,8)
18000a563:     	cmpq	$-0x3, %rax
18000a567:     	cmovlq	%r14, %r8
18000a56b:     	movq	$0x0, 0x18(%rcx,%r8,8)
18000a574:     	movq	(%r12), %rdx
18000a578:     	leaq	0x4(%rdx), %r8
18000a57c:     	cmpq	%r14, %r8
18000a57f:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a585:     	movq	%r8, (%r12)
18000a589:     	cmpb	$0x0, (%r15)
18000a58d:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a593:     	testq	%rdx, %rdx
18000a596:     	js	0x18000a5d9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x65f9>
18000a598:     	movq	$0x0, (%rbx,%rdx,8)
18000a5a0:     	leaq	(%r13,%rdx,8), %r8
18000a5a5:     	movq	$0x1, 0x8(%r13,%rdx,8)
18000a5ae:     	movq	$0x0, 0x10(%rbx,%rdx,8)
18000a5b7:     	movl	$0x1, %r9d
18000a5bd:     	jmp	0x18000a5e6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6606>
18000a5bf:     	movq	0x1a0(%rsp), %rdx
18000a5c7:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000a5cc:     	movq	0x198(%rsp), %rdx
18000a5d4:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000a5d9:     	movb	$0x1, (%r15)
18000a5dd:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
18000a5e3:     	movq	%r12, %r8
18000a5e6:     	movq	%r9, 0x18(%r8)
18000a5ea:     	cmpb	$0x0, (%r15)
18000a5ee:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a5f4:     	xorl	%r8d, %r8d
18000a5f7:     	cmpq	$-0x2, %rax
18000a5fb:     	movl	$0x0, %r9d
18000a601:     	cmovlq	%r14, %r9
18000a605:     	movq	%rdx, 0x10(%rcx,%r9,8)
18000a60a:     	cmpq	$-0x9, %rax
18000a60e:     	movl	$0x0, %edx
18000a613:     	cmovlq	%rbp, %rdx
18000a617:     	leaq	(%rbx,%rax,8), %r9
18000a61b:     	movq	$0x0, 0x48(%r9,%rdx,8)
18000a624:     	cmpq	$-0xa, %rax
18000a628:     	movl	$0x0, %edx
18000a62d:     	cmovlq	%r14, %rdx
18000a631:     	movq	$0x1, 0x50(%rcx,%rdx,8)
18000a63a:     	cmpq	$-0x4, %rax
18000a63e:     	movl	$0x0, %edx
18000a643:     	cmovlq	%r14, %rdx
18000a647:     	movq	$-0x1, 0x20(%rcx,%rdx,8)
18000a650:     	cmpq	$-0x5, %rax
18000a654:     	movl	$0x0, %edx
18000a659:     	cmovlq	%r14, %rdx
18000a65d:     	movq	$-0x1, 0x28(%rcx,%rdx,8)
18000a666:     	cmpq	$-0x7, %rax
18000a66a:     	movl	$0x0, %edx
18000a66f:     	cmovlq	%r14, %rdx
18000a673:     	movq	$-0x1, 0x38(%rcx,%rdx,8)
18000a67c:     	cmpq	$-0x8, %rax
18000a680:     	cmovlq	%r14, %r8
18000a684:     	movq	$-0x1, 0x40(%rcx,%r8,8)
18000a68d:     	cmpb	$0x0, (%r15)
18000a691:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a697:     	movq	%rax, 0x28(%r13,%rsi,8)
18000a69c:     	movq	(%r12), %rdx
18000a6a0:     	leaq	0x4(%rdx), %rax
18000a6a4:     	cmpq	%r14, %rax
18000a6a7:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a6ad:     	movq	%rax, (%r12)
18000a6b1:     	cmpb	$0x0, (%r15)
18000a6b5:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a6bb:     	addsd	%xmm0, %xmm2
18000a6bf:     	testq	%rdx, %rdx
18000a6c2:     	js	0x18000a6dd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x66fd>
18000a6c4:     	movsd	%xmm4, 0x10(%rbx,%rdx,8)
18000a6ca:     	movsd	%xmm2, 0x18(%rbx,%rdx,8)
18000a6d0:     	movsd	%xmm3, 0x8(%rbx,%rdx,8)
18000a6d6:     	movsd	%xmm0, (%rbx,%rdx,8)
18000a6db:     	jmp	0x18000a6ea <PyInit_rcaotr_2c76336ff39711e0671e54df+0x670a>
18000a6dd:     	movb	$0x1, (%r15)
18000a6e1:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
18000a6ea:     	cmpb	$0x0, (%r15)
18000a6ee:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a6f4:     	movq	(%r12), %rax
18000a6f8:     	leaq	0xb(%rax), %rcx
18000a6fc:     	cmpq	%r14, %rcx
18000a6ff:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a705:     	movq	0x8(%r13,%rsi,8), %r8
18000a70a:     	movq	%rcx, (%r12)
18000a70e:     	cmpb	$0x0, (%r15)
18000a712:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a718:     	movq	%rax, %r9
18000a71b:     	sarq	$0x3f, %r9
18000a71f:     	andq	%r14, %r9
18000a722:     	leaq	(%r13,%rax,8), %rcx
18000a727:     	movq	%rdx, (%rcx,%r9,8)
18000a72b:     	xorl	%edx, %edx
18000a72d:     	cmpq	$-0x1, %rax
18000a731:     	cmovlq	%r14, %rdx
18000a735:     	movq	%r8, 0x8(%rcx,%rdx,8)
18000a73a:     	movq	(%r12), %rdx
18000a73e:     	cmpq	%r14, %rdx
18000a741:     	movq	%rdx, %r8
18000a744:     	jle	0x18000a751 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6771>
18000a746:     	movb	$0x2, (%r15)
18000a74a:     	movq	(%r12), %rdx
18000a74e:     	xorl	%r8d, %r8d
18000a751:     	leaq	0x3(%rdx), %r9
18000a755:     	cmpq	%r14, %r9
18000a758:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a75e:     	movq	%r9, (%r12)
18000a762:     	cmpb	$0x0, (%r15)
18000a766:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a76c:     	movq	%rdx, %r9
18000a76f:     	sarq	$0x3f, %r9
18000a773:     	andq	%r14, %r9
18000a776:     	leaq	(%r13,%rdx,8), %r10
18000a77b:     	movq	$0x0, (%r10,%r9,8)
18000a783:     	xorl	%r9d, %r9d
18000a786:     	cmpq	$-0x1, %rdx
18000a78a:     	movl	$0x0, %r11d
18000a790:     	cmovlq	%r14, %r11
18000a794:     	movq	$0x0, 0x8(%r10,%r11,8)
18000a79d:     	cmpq	$-0x2, %rdx
18000a7a1:     	cmovlq	%r14, %r9
18000a7a5:     	movq	%r8, 0x10(%r10,%r9,8)
18000a7aa:     	cmpb	$0x0, (%r15)
18000a7ae:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a7b4:     	xorl	%r8d, %r8d
18000a7b7:     	cmpq	$-0x6, %rax
18000a7bb:     	movl	$0x0, %r9d
18000a7c1:     	cmovlq	%r14, %r9
18000a7c5:     	movq	%rdx, 0x30(%rcx,%r9,8)
18000a7ca:     	cmpq	$-0x3, %rax
18000a7ce:     	cmovlq	%r14, %r8
18000a7d2:     	movq	$0x0, 0x18(%rcx,%r8,8)
18000a7db:     	movq	(%r12), %rdx
18000a7df:     	leaq	0x4(%rdx), %r8
18000a7e3:     	cmpq	%r14, %r8
18000a7e6:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a7ec:     	movq	%r8, (%r12)
18000a7f0:     	cmpb	$0x0, (%r15)
18000a7f4:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a7fa:     	testq	%rdx, %rdx
18000a7fd:     	js	0x18000a826 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6846>
18000a7ff:     	movq	$0x0, (%rbx,%rdx,8)
18000a807:     	leaq	(%r13,%rdx,8), %r8
18000a80c:     	movq	$0x1, 0x8(%r13,%rdx,8)
18000a815:     	movq	$0x0, 0x10(%rbx,%rdx,8)
18000a81e:     	movl	$0x1, %r9d
18000a824:     	jmp	0x18000a833 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6853>
18000a826:     	movb	$0x1, (%r15)
18000a82a:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
18000a830:     	movq	%r12, %r8
18000a833:     	movq	%r9, 0x18(%r8)
18000a837:     	cmpb	$0x0, (%r15)
18000a83b:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a841:     	xorl	%r8d, %r8d
18000a844:     	cmpq	$-0x2, %rax
18000a848:     	movl	$0x0, %r9d
18000a84e:     	cmovlq	%r14, %r9
18000a852:     	movq	%rdx, 0x10(%rcx,%r9,8)
18000a857:     	cmpq	$-0x9, %rax
18000a85b:     	movl	$0x0, %edx
18000a860:     	cmovlq	%rbp, %rdx
18000a864:     	leaq	(%rbx,%rax,8), %r9
18000a868:     	movq	$0x0, 0x48(%r9,%rdx,8)
18000a871:     	cmpq	$-0xa, %rax
18000a875:     	movl	$0x0, %edx
18000a87a:     	cmovlq	%r14, %rdx
18000a87e:     	movq	$0x1, 0x50(%rcx,%rdx,8)
18000a887:     	cmpq	$-0x4, %rax
18000a88b:     	movl	$0x0, %edx
18000a890:     	cmovlq	%r14, %rdx
18000a894:     	movq	$-0x1, 0x20(%rcx,%rdx,8)
18000a89d:     	cmpq	$-0x5, %rax
18000a8a1:     	movl	$0x0, %edx
18000a8a6:     	cmovlq	%r14, %rdx
18000a8aa:     	movq	$-0x1, 0x28(%rcx,%rdx,8)
18000a8b3:     	cmpq	$-0x7, %rax
18000a8b7:     	movl	$0x0, %edx
18000a8bc:     	cmovlq	%r14, %rdx
18000a8c0:     	movq	$-0x1, 0x38(%rcx,%rdx,8)
18000a8c9:     	cmpq	$-0x8, %rax
18000a8cd:     	cmovlq	%r14, %r8
18000a8d1:     	movq	$-0x1, 0x40(%rcx,%r8,8)
18000a8da:     	cmpb	$0x0, (%r15)
18000a8de:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a8e4:     	movq	%rax, 0x38(%r13,%rsi,8)
18000a8e9:     	movq	(%r12), %rdx
18000a8ed:     	leaq	0x4(%rdx), %rax
18000a8f1:     	cmpq	%r14, %rax
18000a8f4:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a8fa:     	movq	%rax, (%r12)
18000a8fe:     	cmpb	$0x0, (%r15)
18000a902:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a908:     	testq	%rdx, %rdx
18000a90b:     	js	0x18000a926 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6946>
18000a90d:     	movsd	%xmm1, 0x10(%rbx,%rdx,8)
18000a913:     	movsd	%xmm2, 0x18(%rbx,%rdx,8)
18000a919:     	movsd	%xmm3, 0x8(%rbx,%rdx,8)
18000a91f:     	movsd	%xmm0, (%rbx,%rdx,8)
18000a924:     	jmp	0x18000a933 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6953>
18000a926:     	movb	$0x1, (%r15)
18000a92a:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
18000a933:     	cmpb	$0x0, (%r15)
18000a937:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a93d:     	movq	(%r12), %rax
18000a941:     	leaq	0xb(%rax), %rcx
18000a945:     	cmpq	%r14, %rcx
18000a948:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a94e:     	movq	0x8(%r13,%rsi,8), %r8
18000a953:     	movq	%rcx, (%r12)
18000a957:     	cmpb	$0x0, (%r15)
18000a95b:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a961:     	movq	%rax, %r9
18000a964:     	sarq	$0x3f, %r9
18000a968:     	andq	%r14, %r9
18000a96b:     	leaq	(%r13,%rax,8), %rcx
18000a970:     	movq	%rdx, (%rcx,%r9,8)
18000a974:     	xorl	%edx, %edx
18000a976:     	cmpq	$-0x1, %rax
18000a97a:     	cmovlq	%r14, %rdx
18000a97e:     	movq	%r8, 0x8(%rcx,%rdx,8)
18000a983:     	movq	(%r12), %rdx
18000a987:     	cmpq	%r14, %rdx
18000a98a:     	movq	%rdx, %r8
18000a98d:     	jle	0x18000a99a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x69ba>
18000a98f:     	movb	$0x2, (%r15)
18000a993:     	movq	(%r12), %rdx
18000a997:     	xorl	%r8d, %r8d
18000a99a:     	leaq	0x3(%rdx), %r9
18000a99e:     	cmpq	%r14, %r9
18000a9a1:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000a9a7:     	movq	%r9, (%r12)
18000a9ab:     	cmpb	$0x0, (%r15)
18000a9af:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a9b5:     	movq	%rdx, %r9
18000a9b8:     	sarq	$0x3f, %r9
18000a9bc:     	andq	%r14, %r9
18000a9bf:     	leaq	(%r13,%rdx,8), %r10
18000a9c4:     	movq	$0x0, (%r10,%r9,8)
18000a9cc:     	xorl	%r9d, %r9d
18000a9cf:     	cmpq	$-0x1, %rdx
18000a9d3:     	movl	$0x0, %r11d
18000a9d9:     	cmovlq	%r14, %r11
18000a9dd:     	movq	$0x0, 0x8(%r10,%r11,8)
18000a9e6:     	cmpq	$-0x2, %rdx
18000a9ea:     	cmovlq	%r14, %r9
18000a9ee:     	movq	%r8, 0x10(%r10,%r9,8)
18000a9f3:     	cmpb	$0x0, (%r15)
18000a9f7:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000a9fd:     	xorl	%r8d, %r8d
18000aa00:     	cmpq	$-0x6, %rax
18000aa04:     	movl	$0x0, %r9d
18000aa0a:     	cmovlq	%r14, %r9
18000aa0e:     	movq	%rdx, 0x30(%rcx,%r9,8)
18000aa13:     	cmpq	$-0x3, %rax
18000aa17:     	cmovlq	%r14, %r8
18000aa1b:     	movq	$0x0, 0x18(%rcx,%r8,8)
18000aa24:     	movq	(%r12), %rdx
18000aa28:     	leaq	0x4(%rdx), %r8
18000aa2c:     	cmpq	%r14, %r8
18000aa2f:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000aa35:     	movq	%r8, (%r12)
18000aa39:     	cmpb	$0x0, (%r15)
18000aa3d:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000aa43:     	testq	%rdx, %rdx
18000aa46:     	js	0x18000aa6f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6a8f>
18000aa48:     	movq	$0x0, (%rbx,%rdx,8)
18000aa50:     	leaq	(%r13,%rdx,8), %r8
18000aa55:     	movq	$0x1, 0x8(%r13,%rdx,8)
18000aa5e:     	movq	$0x0, 0x10(%rbx,%rdx,8)
18000aa67:     	movl	$0x1, %r9d
18000aa6d:     	jmp	0x18000aa7c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6a9c>
18000aa6f:     	movb	$0x1, (%r15)
18000aa73:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
18000aa79:     	movq	%r12, %r8
18000aa7c:     	movq	%r9, 0x18(%r8)
18000aa80:     	cmpb	$0x0, (%r15)
18000aa84:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000aa8a:     	xorl	%r8d, %r8d
18000aa8d:     	cmpq	$-0x2, %rax
18000aa91:     	movl	$0x0, %r9d
18000aa97:     	cmovlq	%r14, %r9
18000aa9b:     	movq	%rdx, 0x10(%rcx,%r9,8)
18000aaa0:     	cmpq	$-0x9, %rax
18000aaa4:     	movl	$0x0, %edx
18000aaa9:     	cmovlq	%rbp, %rdx
18000aaad:     	leaq	(%rbx,%rax,8), %r9
18000aab1:     	movq	$0x0, 0x48(%r9,%rdx,8)
18000aaba:     	cmpq	$-0xa, %rax
18000aabe:     	movl	$0x0, %edx
18000aac3:     	cmovlq	%r14, %rdx
18000aac7:     	movq	$0x1, 0x50(%rcx,%rdx,8)
18000aad0:     	cmpq	$-0x4, %rax
18000aad4:     	movl	$0x0, %edx
18000aad9:     	cmovlq	%r14, %rdx
18000aadd:     	movq	$-0x1, 0x20(%rcx,%rdx,8)
18000aae6:     	cmpq	$-0x5, %rax
18000aaea:     	movl	$0x0, %edx
18000aaef:     	cmovlq	%r14, %rdx
18000aaf3:     	movq	$-0x1, 0x28(%rcx,%rdx,8)
18000aafc:     	cmpq	$-0x7, %rax
18000ab00:     	movl	$0x0, %edx
18000ab05:     	cmovlq	%r14, %rdx
18000ab09:     	movq	$-0x1, 0x38(%rcx,%rdx,8)
18000ab12:     	cmpq	$-0x8, %rax
18000ab16:     	cmovlq	%r14, %r8
18000ab1a:     	movq	$-0x1, 0x40(%rcx,%r8,8)
18000ab23:     	cmpb	$0x0, (%r15)
18000ab27:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000ab2d:     	movq	%rax, 0x40(%r13,%rsi,8)
18000ab32:     	movq	$0x1, 0x18(%r13,%rsi,8)
18000ab3b:     	movq	0x30(%r13,%rsi,8), %rax
18000ab40:     	movq	%rax, %rcx
18000ab43:     	sarq	$0x3f, %rcx
18000ab47:     	andq	%r14, %rcx
18000ab4a:     	leaq	(%r13,%rax,8), %rdx
18000ab4f:     	movq	%rcx, 0x140(%rsp)
18000ab57:     	movq	%rdx, 0x150(%rsp)
18000ab5f:     	cmpq	$0x0, (%rdx,%rcx,8)
18000ab64:     	jle	0x18000b34d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x736d>
18000ab6a:     	leaq	(,%r14,8), %rcx
18000ab72:     	xorl	%edi, %edi
18000ab74:     	cmpq	$-0x2, %rax
18000ab78:     	cmovgeq	%rdi, %rcx
18000ab7c:     	movq	%rcx, 0x158(%rsp)
18000ab84:     	movq	0x20(%r13,%rsi,8), %rax
18000ab89:     	testq	%rax, %rax
18000ab8c:     	js	0x18000b3cf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x73ef>
18000ab92:     	movq	0x150(%rsp), %rcx
18000ab9a:     	movq	0x158(%rsp), %rdx
18000aba2:     	movq	0x10(%rcx,%rdx), %rcx
18000aba7:     	addq	%rdi, %rcx
18000abaa:     	leaq	(%r13,%rcx,8), %rdx
18000abaf:     	sarq	$0x3f, %rcx
18000abb3:     	andq	%r14, %rcx
18000abb6:     	movq	(%rdx,%rcx,8), %rcx
18000abba:     	movq	%rcx, 0x138(%rsp)
18000abc2:     	movq	0x8(%r12), %rcx
18000abc7:     	leaq	0x1(%rcx), %rdx
18000abcb:     	movq	%rdx, 0x8(%r12)
18000abd0:     	cmpq	0x10(%r12), %rcx
18000abd5:     	jge	0x18000b3cf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x73ef>
18000abdb:     	movq	0x138(%rsp), %rcx
18000abe3:     	movq	%rcx, 0x100(%rsp)
18000abeb:     	movq	%rax, 0xf8(%rsp)
18000abf3:     	movq	0x308(%rsp), %rax
18000abfb:     	movq	%rax, 0xe8(%rsp)
18000ac03:     	movq	0x300(%rsp), %rax
18000ac0b:     	movq	%rax, 0xe0(%rsp)
18000ac13:     	movq	%r15, 0xd8(%rsp)
18000ac1b:     	movq	0x2f0(%rsp), %rax
18000ac23:     	movq	%rax, 0xd0(%rsp)
18000ac2b:     	movq	0x2e8(%rsp), %rax
18000ac33:     	movq	%rax, 0xc8(%rsp)
18000ac3b:     	movq	0x2e0(%rsp), %rax
18000ac43:     	movq	%rax, 0xc0(%rsp)
18000ac4b:     	movq	0x2d8(%rsp), %rax
18000ac53:     	movq	%rax, 0xb8(%rsp)
18000ac5b:     	movq	0x2d0(%rsp), %rax
18000ac63:     	movq	%rax, 0xb0(%rsp)
18000ac6b:     	movq	0x2c8(%rsp), %rax
18000ac73:     	movq	%rax, 0xa8(%rsp)
18000ac7b:     	movq	%r12, 0xa0(%rsp)
18000ac83:     	movq	0x2b8(%rsp), %rax
18000ac8b:     	movq	%rax, 0x98(%rsp)
18000ac93:     	movq	0x2b0(%rsp), %rax
18000ac9b:     	movq	%rax, 0x90(%rsp)
18000aca3:     	movq	0x2a8(%rsp), %rax
18000acab:     	movq	%rax, 0x88(%rsp)
18000acb3:     	movq	0x2a0(%rsp), %rax
18000acbb:     	movq	%rax, 0x80(%rsp)
18000acc3:     	movq	0x298(%rsp), %rax
18000accb:     	movq	%rax, 0x78(%rsp)
18000acd0:     	movq	%r14, 0x70(%rsp)
18000acd5:     	movq	%r13, 0x68(%rsp)
18000acda:     	movq	0x280(%rsp), %rax
18000ace2:     	movq	%rax, 0x60(%rsp)
18000ace7:     	movq	0x278(%rsp), %rax
18000acef:     	movq	%rax, 0x58(%rsp)
18000acf4:     	movq	0x270(%rsp), %rax
18000acfc:     	movq	%rax, 0x50(%rsp)
18000ad01:     	movq	0x268(%rsp), %rax
18000ad09:     	movq	%rax, 0x48(%rsp)
18000ad0e:     	movq	0x260(%rsp), %rax
18000ad16:     	movq	%rax, 0x40(%rsp)
18000ad1b:     	movq	%rbp, 0x38(%rsp)
18000ad20:     	movq	%rbx, 0x30(%rsp)
18000ad25:     	movq	0x248(%rsp), %rax
18000ad2d:     	movq	%rax, 0x28(%rsp)
18000ad32:     	movq	0x240(%rsp), %rax
18000ad3a:     	movq	%rax, 0x20(%rsp)
18000ad3f:     	movq	$-0x1, 0x108(%rsp)
18000ad4b:     	movq	$0x0, 0xf0(%rsp)
18000ad57:     	leaq	0x136(%rsp), %rcx
18000ad5f:     	leaq	0x190(%rsp), %rdx
18000ad67:     	movq	0x128(%rsp), %r8
18000ad6f:     	movq	0x148(%rsp), %r9
18000ad77:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000ad7c:     	testl	%eax, %eax
18000ad7e:     	jne	0x18000b3e1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7401>
18000ad84:     	cmpb	$0x0, (%r15)
18000ad88:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000ad8e:     	movq	0x8(%r12), %rcx
18000ad93:     	leaq	-0x1(%rcx), %rax
18000ad97:     	movq	%rax, 0x8(%r12)
18000ad9c:     	movq	0x28(%r13,%rsi,8), %rax
18000ada1:     	testq	%rax, %rax
18000ada4:     	js	0x18000b3ee <PyInit_rcaotr_2c76336ff39711e0671e54df+0x740e>
18000adaa:     	movq	%rcx, 0x8(%r12)
18000adaf:     	cmpq	0x10(%r12), %rcx
18000adb4:     	jg	0x18000b3ee <PyInit_rcaotr_2c76336ff39711e0671e54df+0x740e>
18000adba:     	movq	0x138(%rsp), %rcx
18000adc2:     	movq	%rcx, 0x100(%rsp)
18000adca:     	movq	%rax, 0xf8(%rsp)
18000add2:     	movq	0x308(%rsp), %rax
18000adda:     	movq	%rax, 0xe8(%rsp)
18000ade2:     	movq	0x300(%rsp), %rax
18000adea:     	movq	%rax, 0xe0(%rsp)
18000adf2:     	movq	%r15, 0xd8(%rsp)
18000adfa:     	movq	0x2f0(%rsp), %rax
18000ae02:     	movq	%rax, 0xd0(%rsp)
18000ae0a:     	movq	0x2e8(%rsp), %rax
18000ae12:     	movq	%rax, 0xc8(%rsp)
18000ae1a:     	movq	0x2e0(%rsp), %rax
18000ae22:     	movq	%rax, 0xc0(%rsp)
18000ae2a:     	movq	0x2d8(%rsp), %rax
18000ae32:     	movq	%rax, 0xb8(%rsp)
18000ae3a:     	movq	0x2d0(%rsp), %rax
18000ae42:     	movq	%rax, 0xb0(%rsp)
18000ae4a:     	movq	0x2c8(%rsp), %rax
18000ae52:     	movq	%rax, 0xa8(%rsp)
18000ae5a:     	movq	%r12, 0xa0(%rsp)
18000ae62:     	movq	0x2b8(%rsp), %rax
18000ae6a:     	movq	%rax, 0x98(%rsp)
18000ae72:     	movq	0x2b0(%rsp), %rax
18000ae7a:     	movq	%rax, 0x90(%rsp)
18000ae82:     	movq	0x2a8(%rsp), %rax
18000ae8a:     	movq	%rax, 0x88(%rsp)
18000ae92:     	movq	0x2a0(%rsp), %rax
18000ae9a:     	movq	%rax, 0x80(%rsp)
18000aea2:     	movq	0x298(%rsp), %rax
18000aeaa:     	movq	%rax, 0x78(%rsp)
18000aeaf:     	movq	%r14, 0x70(%rsp)
18000aeb4:     	movq	%r13, 0x68(%rsp)
18000aeb9:     	movq	0x280(%rsp), %rax
18000aec1:     	movq	%rax, 0x60(%rsp)
18000aec6:     	movq	0x278(%rsp), %rax
18000aece:     	movq	%rax, 0x58(%rsp)
18000aed3:     	movq	0x270(%rsp), %rax
18000aedb:     	movq	%rax, 0x50(%rsp)
18000aee0:     	movq	0x268(%rsp), %rax
18000aee8:     	movq	%rax, 0x48(%rsp)
18000aeed:     	movq	0x260(%rsp), %rax
18000aef5:     	movq	%rax, 0x40(%rsp)
18000aefa:     	movq	%rbp, 0x38(%rsp)
18000aeff:     	movq	%rbx, 0x30(%rsp)
18000af04:     	movq	0x248(%rsp), %rax
18000af0c:     	movq	%rax, 0x28(%rsp)
18000af11:     	movq	0x240(%rsp), %rax
18000af19:     	movq	%rax, 0x20(%rsp)
18000af1e:     	movq	$-0x1, 0x108(%rsp)
18000af2a:     	movq	$0x0, 0xf0(%rsp)
18000af36:     	leaq	0x135(%rsp), %rcx
18000af3e:     	leaq	0x188(%rsp), %rdx
18000af46:     	movq	0x128(%rsp), %r8
18000af4e:     	movq	0x148(%rsp), %r9
18000af56:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000af5b:     	testl	%eax, %eax
18000af5d:     	jne	0x18000b400 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7420>
18000af63:     	cmpb	$0x0, (%r15)
18000af67:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000af6d:     	movq	0x8(%r12), %rcx
18000af72:     	leaq	-0x1(%rcx), %rax
18000af76:     	movq	%rax, 0x8(%r12)
18000af7b:     	movq	0x38(%r13,%rsi,8), %rax
18000af80:     	testq	%rax, %rax
18000af83:     	js	0x18000b40d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x742d>
18000af89:     	movq	%rcx, 0x8(%r12)
18000af8e:     	cmpq	0x10(%r12), %rcx
18000af93:     	jg	0x18000b40d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x742d>
18000af99:     	movq	0x138(%rsp), %rcx
18000afa1:     	movq	%rcx, 0x100(%rsp)
18000afa9:     	movq	%rax, 0xf8(%rsp)
18000afb1:     	movq	0x308(%rsp), %rax
18000afb9:     	movq	%rax, 0xe8(%rsp)
18000afc1:     	movq	0x300(%rsp), %rax
18000afc9:     	movq	%rax, 0xe0(%rsp)
18000afd1:     	movq	%r15, 0xd8(%rsp)
18000afd9:     	movq	0x2f0(%rsp), %rax
18000afe1:     	movq	%rax, 0xd0(%rsp)
18000afe9:     	movq	0x2e8(%rsp), %rax
18000aff1:     	movq	%rax, 0xc8(%rsp)
18000aff9:     	movq	0x2e0(%rsp), %rax
18000b001:     	movq	%rax, 0xc0(%rsp)
18000b009:     	movq	0x2d8(%rsp), %rax
18000b011:     	movq	%rax, 0xb8(%rsp)
18000b019:     	movq	0x2d0(%rsp), %rax
18000b021:     	movq	%rax, 0xb0(%rsp)
18000b029:     	movq	0x2c8(%rsp), %rax
18000b031:     	movq	%rax, 0xa8(%rsp)
18000b039:     	movq	%r12, 0xa0(%rsp)
18000b041:     	movq	0x2b8(%rsp), %rax
18000b049:     	movq	%rax, 0x98(%rsp)
18000b051:     	movq	0x2b0(%rsp), %rax
18000b059:     	movq	%rax, 0x90(%rsp)
18000b061:     	movq	0x2a8(%rsp), %rax
18000b069:     	movq	%rax, 0x88(%rsp)
18000b071:     	movq	0x2a0(%rsp), %rax
18000b079:     	movq	%rax, 0x80(%rsp)
18000b081:     	movq	0x298(%rsp), %rax
18000b089:     	movq	%rax, 0x78(%rsp)
18000b08e:     	movq	%r14, 0x70(%rsp)
18000b093:     	movq	%r13, 0x68(%rsp)
18000b098:     	movq	0x280(%rsp), %rax
18000b0a0:     	movq	%rax, 0x60(%rsp)
18000b0a5:     	movq	0x278(%rsp), %rax
18000b0ad:     	movq	%rax, 0x58(%rsp)
18000b0b2:     	movq	0x270(%rsp), %rax
18000b0ba:     	movq	%rax, 0x50(%rsp)
18000b0bf:     	movq	0x268(%rsp), %rax
18000b0c7:     	movq	%rax, 0x48(%rsp)
18000b0cc:     	movq	0x260(%rsp), %rax
18000b0d4:     	movq	%rax, 0x40(%rsp)
18000b0d9:     	movq	%rbp, 0x38(%rsp)
18000b0de:     	movq	%rbx, 0x30(%rsp)
18000b0e3:     	movq	0x248(%rsp), %rax
18000b0eb:     	movq	%rax, 0x28(%rsp)
18000b0f0:     	movq	0x240(%rsp), %rax
18000b0f8:     	movq	%rax, 0x20(%rsp)
18000b0fd:     	movq	$-0x1, 0x108(%rsp)
18000b109:     	movq	$0x0, 0xf0(%rsp)
18000b115:     	leaq	0x134(%rsp), %rcx
18000b11d:     	leaq	0x180(%rsp), %rdx
18000b125:     	movq	0x128(%rsp), %r8
18000b12d:     	movq	0x148(%rsp), %r9
18000b135:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000b13a:     	testl	%eax, %eax
18000b13c:     	jne	0x18000b41f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x743f>
18000b142:     	cmpb	$0x0, (%r15)
18000b146:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b14c:     	movq	0x8(%r12), %rcx
18000b151:     	leaq	-0x1(%rcx), %rax
18000b155:     	movq	%rax, 0x8(%r12)
18000b15a:     	movq	0x40(%r13,%rsi,8), %rax
18000b15f:     	testq	%rax, %rax
18000b162:     	js	0x18000b42c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x744c>
18000b168:     	movq	%rcx, 0x8(%r12)
18000b16d:     	cmpq	0x10(%r12), %rcx
18000b172:     	jg	0x18000b42c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x744c>
18000b178:     	movq	0x138(%rsp), %rcx
18000b180:     	movq	%rcx, 0x100(%rsp)
18000b188:     	movq	%rax, 0xf8(%rsp)
18000b190:     	movq	0x308(%rsp), %rax
18000b198:     	movq	%rax, 0xe8(%rsp)
18000b1a0:     	movq	0x300(%rsp), %rax
18000b1a8:     	movq	%rax, 0xe0(%rsp)
18000b1b0:     	movq	%r15, 0xd8(%rsp)
18000b1b8:     	movq	0x2f0(%rsp), %rax
18000b1c0:     	movq	%rax, 0xd0(%rsp)
18000b1c8:     	movq	0x2e8(%rsp), %rax
18000b1d0:     	movq	%rax, 0xc8(%rsp)
18000b1d8:     	movq	0x2e0(%rsp), %rax
18000b1e0:     	movq	%rax, 0xc0(%rsp)
18000b1e8:     	movq	0x2d8(%rsp), %rax
18000b1f0:     	movq	%rax, 0xb8(%rsp)
18000b1f8:     	movq	0x2d0(%rsp), %rax
18000b200:     	movq	%rax, 0xb0(%rsp)
18000b208:     	movq	0x2c8(%rsp), %rax
18000b210:     	movq	%rax, 0xa8(%rsp)
18000b218:     	movq	%r12, 0xa0(%rsp)
18000b220:     	movq	0x2b8(%rsp), %rax
18000b228:     	movq	%rax, 0x98(%rsp)
18000b230:     	movq	0x2b0(%rsp), %rax
18000b238:     	movq	%rax, 0x90(%rsp)
18000b240:     	movq	0x2a8(%rsp), %rax
18000b248:     	movq	%rax, 0x88(%rsp)
18000b250:     	movq	0x2a0(%rsp), %rax
18000b258:     	movq	%rax, 0x80(%rsp)
18000b260:     	movq	0x298(%rsp), %rax
18000b268:     	movq	%rax, 0x78(%rsp)
18000b26d:     	movq	%r14, 0x70(%rsp)
18000b272:     	movq	%r13, 0x68(%rsp)
18000b277:     	movq	0x280(%rsp), %rax
18000b27f:     	movq	%rax, 0x60(%rsp)
18000b284:     	movq	0x278(%rsp), %rax
18000b28c:     	movq	%rax, 0x58(%rsp)
18000b291:     	movq	0x270(%rsp), %rax
18000b299:     	movq	%rax, 0x50(%rsp)
18000b29e:     	movq	0x268(%rsp), %rax
18000b2a6:     	movq	%rax, 0x48(%rsp)
18000b2ab:     	movq	0x260(%rsp), %rax
18000b2b3:     	movq	%rax, 0x40(%rsp)
18000b2b8:     	movq	%rbp, 0x38(%rsp)
18000b2bd:     	movq	%rbx, 0x30(%rsp)
18000b2c2:     	movq	0x248(%rsp), %rax
18000b2ca:     	movq	%rax, 0x28(%rsp)
18000b2cf:     	movq	0x240(%rsp), %rax
18000b2d7:     	movq	%rax, 0x20(%rsp)
18000b2dc:     	movq	$-0x1, 0x108(%rsp)
18000b2e8:     	movq	$0x0, 0xf0(%rsp)
18000b2f4:     	leaq	0x133(%rsp), %rcx
18000b2fc:     	leaq	0x178(%rsp), %rdx
18000b304:     	movq	0x128(%rsp), %r8
18000b30c:     	movq	0x148(%rsp), %r9
18000b314:     	callq	0x180008d50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4d70>
18000b319:     	testl	%eax, %eax
18000b31b:     	jne	0x18000b43e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x745e>
18000b321:     	cmpb	$0x0, (%r15)
18000b325:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b32b:     	incq	%rdi
18000b32e:     	decq	0x8(%r12)
18000b333:     	movq	0x140(%rsp), %rax
18000b33b:     	movq	0x150(%rsp), %rcx
18000b343:     	cmpq	(%rcx,%rax,8), %rdi
18000b347:     	jl	0x18000ab84 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6ba4>
18000b34d:     	movq	(%r12), %rcx
18000b351:     	cmpq	%r14, %rcx
18000b354:     	movq	%rcx, %rdx
18000b357:     	jle	0x18000b363 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7383>
18000b359:     	movb	$0x2, (%r15)
18000b35d:     	movq	(%r12), %rcx
18000b361:     	xorl	%edx, %edx
18000b363:     	leaq	0x3(%rcx), %rax
18000b367:     	cmpq	%r14, %rax
18000b36a:     	jg	0x18000a242 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x6262>
18000b370:     	movq	%rax, (%r12)
18000b374:     	cmpb	$0x0, (%r15)
18000b378:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b37e:     	movq	%rcx, %rax
18000b381:     	sarq	$0x3f, %rax
18000b385:     	andq	%r14, %rax
18000b388:     	leaq	(%r13,%rcx,8), %r8
18000b38d:     	movq	$0x0, (%r8,%rax,8)
18000b395:     	xorl	%eax, %eax
18000b397:     	cmpq	$-0x1, %rcx
18000b39b:     	movl	$0x0, %r9d
18000b3a1:     	cmovlq	%r14, %r9
18000b3a5:     	movq	$0x0, 0x8(%r8,%r9,8)
18000b3ae:     	cmpq	$-0x2, %rcx
18000b3b2:     	cmovgeq	%rax, %r14
18000b3b6:     	movq	%rdx, 0x10(%r8,%r14,8)
18000b3bb:     	cmpb	$0x0, (%r15)
18000b3bf:     	jne	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b3c5:     	movq	%rcx, 0x30(%r13,%rsi,8)
18000b3ca:     	jmp	0x180009f32 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f52>
18000b3cf:     	movb	$0x1, (%r15)
18000b3d3:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
18000b3dc:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b3e1:     	movq	0x190(%rsp), %rdx
18000b3e9:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000b3ee:     	movb	$0x1, (%r15)
18000b3f2:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
18000b3fb:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b400:     	movq	0x188(%rsp), %rdx
18000b408:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000b40d:     	movb	$0x1, (%r15)
18000b411:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
18000b41a:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b41f:     	movq	0x180(%rsp), %rdx
18000b427:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000b42c:     	movb	$0x1, (%r15)
18000b430:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
18000b439:     	jmp	0x1800099ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x59ce>
18000b43e:     	movq	0x178(%rsp), %rdx
18000b446:     	jmp	0x180009f15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x5f35>
18000b44b:     	int3
18000b44c:     	int3
18000b44d:     	int3
18000b44e:     	int3
18000b44f:     	int3
18000b450:     	pushq	%rbx
18000b452:     	subq	$0x20, %rsp
18000b456:     	movq	%rcx, %rbx
18000b459:     	callq	*0x3c91(%rip)           # 0x18000f0f0
18000b45f:     	movl	%eax, (%rbx)
18000b461:     	addq	$0x20, %rsp
18000b465:     	popq	%rbx
18000b466:     	retq
18000b467:     	int3
18000b468:     	int3
18000b469:     	int3
18000b46a:     	int3
18000b46b:     	int3
18000b46c:     	int3
18000b46d:     	int3
18000b46e:     	int3
18000b46f:     	int3
18000b470:     	movl	(%rcx), %ecx
18000b472:     	jmpq	*0x3d97(%rip)           # 0x18000f210
18000b479:     	int3
18000b47a:     	int3
18000b47b:     	int3
18000b47c:     	int3
18000b47d:     	int3
18000b47e:     	int3
18000b47f:     	int3
18000b480:     	pushq	%rbp
18000b482:     	pushq	%rbx
18000b483:     	pushq	%rsi
18000b484:     	pushq	%rdi
18000b485:     	pushq	%r14
18000b487:     	pushq	%r15
18000b489:     	movq	%rsp, %rbp
18000b48c:     	subq	$0x48, %rsp
18000b490:     	movq	0x3d49(%rip), %rax      # 0x18000f1e0
18000b497:     	xorl	%r15d, %r15d
18000b49a:     	movq	%rcx, %rsi
18000b49d:     	movq	%r15, 0x38(%rbp)
18000b4a1:     	movl	%r15d, %r14d
18000b4a4:     	movq	%r15, 0x50(%rbp)
18000b4a8:     	movq	%r15, 0x48(%rbp)
18000b4ac:     	cmpq	%rax, 0x8(%rcx)
18000b4b0:     	jne	0x18000b61e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x763e>
18000b4b6:     	leaq	0x48(%rbp), %rax
18000b4ba:     	leaq	0x50(%rbp), %r9
18000b4be:     	movq	%rax, 0x20(%rsp)
18000b4c3:     	leaq	0x38(%rbp), %r8
18000b4c7:     	leaq	0x49b6(%rip), %rdx      # 0x18000fe84
18000b4ce:     	callq	*0x3c5c(%rip)           # 0x18000f130
18000b4d4:     	testl	%eax, %eax
18000b4d6:     	jne	0x18000b614 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7634>
18000b4dc:     	movq	0x48(%rbp), %rbx
18000b4e0:     	testq	%rbx, %rbx
18000b4e3:     	je	0x18000b605 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7625>
18000b4e9:     	cmpq	0x3de0(%rip), %rbx      # 0x18000f2d0
18000b4f0:     	je	0x18000b605 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7625>
18000b4f6:     	movq	0x8(%rbx), %rax
18000b4fa:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
18000b504:     	je	0x18000b605 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7625>
18000b50a:     	movq	0x20(%rbx), %rcx
18000b50e:     	callq	*0x3c6c(%rip)           # 0x18000f180
18000b514:     	movq	0x28(%rbx), %rcx
18000b518:     	movq	%rax, %rdi
18000b51b:     	callq	*0x3c5f(%rip)           # 0x18000f180
18000b521:     	movq	0x30(%rbx), %rcx
18000b525:     	movq	%rax, %r14
18000b528:     	callq	*0x3c62(%rip)           # 0x18000f190
18000b52e:     	leaq	-0x10(%rbp), %r8
18000b532:     	movl	%eax, %ebx
18000b534:     	leaq	-0x18(%rbp), %rdx
18000b538:     	leaq	0x40(%rbp), %rcx
18000b53c:     	callq	*0x3c5e(%rip)           # 0x18000f1a0
18000b542:     	callq	*0x3c18(%rip)           # 0x18000f160
18000b548:     	movq	%rax, %rsi
18000b54b:     	testq	%rax, %rax
18000b54e:     	je	0x18000b5fb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x761b>
18000b554:     	movl	%ebx, %r8d
18000b557:     	movq	%rdi, %rdx
18000b55a:     	movq	%r14, %rcx
18000b55d:     	callq	*0x3cf5(%rip)           # 0x18000f258
18000b563:     	movq	%rax, %rdi
18000b566:     	testq	%rax, %rax
18000b569:     	je	0x18000b5fb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x761b>
18000b56f:     	callq	*0x3cf3(%rip)           # 0x18000f268
18000b575:     	xorl	%r9d, %r9d
18000b578:     	movq	%rsi, %r8
18000b57b:     	movq	%rax, %rcx
18000b57e:     	movq	%rdi, %rdx
18000b581:     	callq	*0x3cb9(%rip)           # 0x18000f240
18000b587:     	movl	(%rsi), %ecx
18000b589:     	movq	%rax, %rbx
18000b58c:     	testl	%ecx, %ecx
18000b58e:     	js	0x18000b5a0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x75c0>
18000b590:     	subl	$0x1, %ecx
18000b593:     	movl	%ecx, (%rsi)
18000b595:     	jne	0x18000b5a0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x75c0>
18000b597:     	movq	%rsi, %rcx
18000b59a:     	callq	*0x3c28(%rip)           # 0x18000f1c8
18000b5a0:     	movl	(%rdi), %eax
18000b5a2:     	testl	%eax, %eax
18000b5a4:     	js	0x18000b5b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x75d6>
18000b5a6:     	subl	$0x1, %eax
18000b5a9:     	movl	%eax, (%rdi)
18000b5ab:     	jne	0x18000b5b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x75d6>
18000b5ad:     	movq	%rdi, %rcx
18000b5b0:     	callq	*0x3c12(%rip)           # 0x18000f1c8
18000b5b6:     	testq	%rbx, %rbx
18000b5b9:     	je	0x18000b5fb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x761b>
18000b5bb:     	movq	-0x10(%rbp), %r8
18000b5bf:     	movq	-0x18(%rbp), %rdx
18000b5c3:     	movq	0x40(%rbp), %rcx
18000b5c7:     	callq	*0x3c03(%rip)           # 0x18000f1d0
18000b5cd:     	movq	%rbx, %rcx
18000b5d0:     	callq	*0x3c52(%rip)           # 0x18000f228
18000b5d6:     	movl	(%rbx), %eax
18000b5d8:     	testl	%eax, %eax
18000b5da:     	js	0x18000b605 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7625>
18000b5dc:     	subl	$0x1, %eax
18000b5df:     	movl	%eax, (%rbx)
18000b5e1:     	jne	0x18000b605 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7625>
18000b5e3:     	movq	%rbx, %rcx
18000b5e6:     	callq	*0x3bdc(%rip)           # 0x18000f1c8
18000b5ec:     	xorl	%eax, %eax
18000b5ee:     	addq	$0x48, %rsp
18000b5f2:     	popq	%r15
18000b5f4:     	popq	%r14
18000b5f6:     	popq	%rdi
18000b5f7:     	popq	%rsi
18000b5f8:     	popq	%rbx
18000b5f9:     	popq	%rbp
18000b5fa:     	retq
18000b5fb:     	movq	0x40(%rbp), %rcx
18000b5ff:     	callq	*0x3bfb(%rip)           # 0x18000f200
18000b605:     	xorl	%eax, %eax
18000b607:     	addq	$0x48, %rsp
18000b60b:     	popq	%r15
18000b60d:     	popq	%r14
18000b60f:     	popq	%rdi
18000b610:     	popq	%rsi
18000b611:     	popq	%rbx
18000b612:     	popq	%rbp
18000b613:     	retq
18000b614:     	movq	0x38(%rbp), %rbx
18000b618:     	movq	0x50(%rbp), %r14
18000b61c:     	jmp	0x18000b625 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7645>
18000b61e:     	movq	%rsi, %rbx
18000b621:     	movq	%rbx, 0x38(%rbp)
18000b625:     	cmpq	0x3ca4(%rip), %rbx      # 0x18000f2d0
18000b62c:     	jne	0x18000b6c4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x76e4>
18000b632:     	leaq	-0x18(%rbp), %r8
18000b636:     	leaq	-0x10(%rbp), %rdx
18000b63a:     	leaq	0x40(%rbp), %rcx
18000b63e:     	callq	*0x3adc(%rip)           # 0x18000f120
18000b644:     	movq	0x3c85(%rip), %rax      # 0x18000f2d0
18000b64b:     	cmpq	%rax, 0x40(%rbp)
18000b64f:     	jne	0x18000b664 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7684>
18000b651:     	movq	0x3c58(%rip), %rcx      # 0x18000f2b0
18000b658:     	leaq	0x47d9(%rip), %rdx      # 0x18000fe38
18000b65f:     	jmp	0x18000b785 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77a5>
18000b664:     	movq	0x40(%rbp), %rcx
18000b668:     	testq	%rcx, %rcx
18000b66b:     	je	0x18000b67a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x769a>
18000b66d:     	movl	(%rcx), %eax
18000b66f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000b674:     	jae	0x18000b67a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x769a>
18000b676:     	incl	%eax
18000b678:     	movl	%eax, (%rcx)
18000b67a:     	movq	-0x10(%rbp), %rcx
18000b67e:     	testq	%rcx, %rcx
18000b681:     	je	0x18000b690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x76b0>
18000b683:     	movl	(%rcx), %eax
18000b685:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000b68a:     	jae	0x18000b690 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x76b0>
18000b68c:     	incl	%eax
18000b68e:     	movl	%eax, (%rcx)
18000b690:     	movq	-0x18(%rbp), %r8
18000b694:     	testq	%r8, %r8
18000b697:     	je	0x18000b6ac <PyInit_rcaotr_2c76336ff39711e0671e54df+0x76cc>
18000b699:     	movl	(%r8), %eax
18000b69c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000b6a1:     	jae	0x18000b6ac <PyInit_rcaotr_2c76336ff39711e0671e54df+0x76cc>
18000b6a3:     	incl	%eax
18000b6a5:     	movl	%eax, (%r8)
18000b6a8:     	movq	-0x18(%rbp), %r8
18000b6ac:     	movq	-0x10(%rbp), %rdx
18000b6b0:     	movq	0x40(%rbp), %rcx
18000b6b4:     	callq	*0x3b16(%rip)           # 0x18000f1d0
18000b6ba:     	movl	$0x1, %ebx
18000b6bf:     	jmp	0x18000b791 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77b1>
18000b6c4:     	movq	0x8(%rbx), %rcx
18000b6c8:     	movl	0xa8(%rcx), %eax
18000b6ce:     	testl	%eax, %eax
18000b6d0:     	jns	0x18000b766 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7786>
18000b6d6:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
18000b6e0:     	je	0x18000b766 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7786>
18000b6e6:     	movq	%r14, %rdx
18000b6e9:     	movq	%rbx, %rcx
18000b6ec:     	callq	*0x39f6(%rip)           # 0x18000f0e8
18000b6f2:     	movq	%rax, %rdi
18000b6f5:     	testq	%rax, %rax
18000b6f8:     	je	0x18000b78e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77ae>
18000b6fe:     	movq	0x8(%rax), %rax
18000b702:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
18000b70c:     	jne	0x18000b73d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x775d>
18000b70e:     	movq	0x3b8b(%rip), %rcx      # 0x18000f2a0
18000b715:     	leaq	0x473c(%rip), %rdx      # 0x18000fe58
18000b71c:     	movq	(%rcx), %rcx
18000b71f:     	callq	*0x3b83(%rip)           # 0x18000f2a8
18000b725:     	movl	(%rdi), %eax
18000b727:     	testl	%eax, %eax
18000b729:     	js	0x18000b78e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77ae>
18000b72b:     	subl	$0x1, %eax
18000b72e:     	movl	%eax, (%rdi)
18000b730:     	jne	0x18000b78e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77ae>
18000b732:     	movq	%rdi, %rcx
18000b735:     	callq	*0x3a8d(%rip)           # 0x18000f1c8
18000b73b:     	jmp	0x18000b78e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77ae>
18000b73d:     	movl	(%rdi), %eax
18000b73f:     	testl	%eax, %eax
18000b741:     	js	0x18000b753 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7773>
18000b743:     	subl	$0x1, %eax
18000b746:     	movl	%eax, (%rdi)
18000b748:     	jne	0x18000b753 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7773>
18000b74a:     	movq	%rdi, %rcx
18000b74d:     	callq	*0x3a75(%rip)           # 0x18000f1c8
18000b753:     	movq	%r14, %rdx
18000b756:     	movq	%rbx, %rcx
18000b759:     	callq	*0x3b01(%rip)           # 0x18000f260
18000b75f:     	movl	$0x1, %ebx
18000b764:     	jmp	0x18000b791 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77b1>
18000b766:     	btl	$0x1e, %eax
18000b76a:     	jae	0x18000b777 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7797>
18000b76c:     	movq	%rbx, %rdx
18000b76f:     	callq	*0x3aeb(%rip)           # 0x18000f260
18000b775:     	jmp	0x18000b78e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x77ae>
18000b777:     	movq	0x3b22(%rip), %rcx      # 0x18000f2a0
18000b77e:     	leaq	0x46d3(%rip), %rdx      # 0x18000fe58
18000b785:     	movq	(%rcx), %rcx
18000b788:     	callq	*0x3b1a(%rip)           # 0x18000f2a8
18000b78e:     	movl	%r15d, %ebx
18000b791:     	movq	0x48(%rbp), %rdi
18000b795:     	testq	%rdi, %rdi
18000b798:     	je	0x18000b8bb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78db>
18000b79e:     	cmpq	0x3b2b(%rip), %rdi      # 0x18000f2d0
18000b7a5:     	je	0x18000b8bb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78db>
18000b7ab:     	movq	0x8(%rdi), %rax
18000b7af:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
18000b7b9:     	je	0x18000b8bb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78db>
18000b7bf:     	movq	0x20(%rdi), %rcx
18000b7c3:     	movq	%r12, 0x40(%rsp)
18000b7c8:     	callq	*0x39b2(%rip)           # 0x18000f180
18000b7ce:     	movq	0x28(%rdi), %rcx
18000b7d2:     	movq	%rax, %r14
18000b7d5:     	callq	*0x39a5(%rip)           # 0x18000f180
18000b7db:     	movq	0x30(%rdi), %rcx
18000b7df:     	movq	%rax, %r12
18000b7e2:     	callq	*0x39a8(%rip)           # 0x18000f190
18000b7e8:     	leaq	-0x10(%rbp), %r8
18000b7ec:     	movl	%eax, %edi
18000b7ee:     	leaq	-0x18(%rbp), %rdx
18000b7f2:     	leaq	0x40(%rbp), %rcx
18000b7f6:     	callq	*0x39a4(%rip)           # 0x18000f1a0
18000b7fc:     	callq	*0x395e(%rip)           # 0x18000f160
18000b802:     	movq	%rax, %r15
18000b805:     	testq	%rax, %rax
18000b808:     	je	0x18000b8ac <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78cc>
18000b80e:     	movl	%edi, %r8d
18000b811:     	movq	%r14, %rdx
18000b814:     	movq	%r12, %rcx
18000b817:     	callq	*0x3a3b(%rip)           # 0x18000f258
18000b81d:     	movq	%rax, %r14
18000b820:     	testq	%rax, %rax
18000b823:     	je	0x18000b8ac <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78cc>
18000b829:     	callq	*0x3a39(%rip)           # 0x18000f268
18000b82f:     	xorl	%r9d, %r9d
18000b832:     	movq	%r15, %r8
18000b835:     	movq	%rax, %rcx
18000b838:     	movq	%r14, %rdx
18000b83b:     	callq	*0x39ff(%rip)           # 0x18000f240
18000b841:     	movl	(%r15), %ecx
18000b844:     	movq	%rax, %rdi
18000b847:     	testl	%ecx, %ecx
18000b849:     	js	0x18000b85c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x787c>
18000b84b:     	subl	$0x1, %ecx
18000b84e:     	movl	%ecx, (%r15)
18000b851:     	jne	0x18000b85c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x787c>
18000b853:     	movq	%r15, %rcx
18000b856:     	callq	*0x396c(%rip)           # 0x18000f1c8
18000b85c:     	movl	(%r14), %eax
18000b85f:     	testl	%eax, %eax
18000b861:     	js	0x18000b874 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7894>
18000b863:     	subl	$0x1, %eax
18000b866:     	movl	%eax, (%r14)
18000b869:     	jne	0x18000b874 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7894>
18000b86b:     	movq	%r14, %rcx
18000b86e:     	callq	*0x3954(%rip)           # 0x18000f1c8
18000b874:     	testq	%rdi, %rdi
18000b877:     	je	0x18000b8ac <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78cc>
18000b879:     	movq	-0x10(%rbp), %r8
18000b87d:     	movq	-0x18(%rbp), %rdx
18000b881:     	movq	0x40(%rbp), %rcx
18000b885:     	callq	*0x3945(%rip)           # 0x18000f1d0
18000b88b:     	movq	%rdi, %rcx
18000b88e:     	callq	*0x3994(%rip)           # 0x18000f228
18000b894:     	movl	(%rdi), %eax
18000b896:     	testl	%eax, %eax
18000b898:     	js	0x18000b8b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78d6>
18000b89a:     	subl	$0x1, %eax
18000b89d:     	movl	%eax, (%rdi)
18000b89f:     	jne	0x18000b8b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78d6>
18000b8a1:     	movq	%rdi, %rcx
18000b8a4:     	callq	*0x391e(%rip)           # 0x18000f1c8
18000b8aa:     	jmp	0x18000b8b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78d6>
18000b8ac:     	movq	0x40(%rbp), %rcx
18000b8b0:     	callq	*0x394a(%rip)           # 0x18000f200
18000b8b6:     	movq	0x40(%rsp), %r12
18000b8bb:     	movl	(%rsi), %ecx
18000b8bd:     	testl	%ecx, %ecx
18000b8bf:     	js	0x18000b8d1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78f1>
18000b8c1:     	subl	$0x1, %ecx
18000b8c4:     	movl	%ecx, (%rsi)
18000b8c6:     	jne	0x18000b8d1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x78f1>
18000b8c8:     	movq	%rsi, %rcx
18000b8cb:     	callq	*0x38f7(%rip)           # 0x18000f1c8
18000b8d1:     	movl	%ebx, %eax
18000b8d3:     	addq	$0x48, %rsp
18000b8d7:     	popq	%r15
18000b8d9:     	popq	%r14
18000b8db:     	popq	%rdi
18000b8dc:     	popq	%rsi
18000b8dd:     	popq	%rbx
18000b8de:     	popq	%rbp
18000b8df:     	retq
18000b8e0:     	movq	%rbx, 0x8(%rsp)
18000b8e5:     	movq	%rsi, 0x10(%rsp)
18000b8ea:     	pushq	%rdi
18000b8eb:     	subq	$0x20, %rsp
18000b8ef:     	cmpq	$0x0, 0xb3a1(%rip)      # 0x180016c98
18000b8f7:     	movq	%rcx, %rsi
18000b8fa:     	movslq	%edx, %rdi
18000b8fd:     	jne	0x18000b94d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x796d>
18000b8ff:     	leaq	0x4582(%rip), %rcx      # 0x18000fe88
18000b906:     	callq	*0x392c(%rip)           # 0x18000f238
18000b90c:     	movq	%rax, %rbx
18000b90f:     	testq	%rax, %rax
18000b912:     	je	0x18000b961 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7981>
18000b914:     	leaq	0x4575(%rip), %rdx      # 0x18000fe90
18000b91b:     	movq	%rax, %rcx
18000b91e:     	callq	*0x3844(%rip)           # 0x18000f168
18000b924:     	movl	(%rbx), %ecx
18000b926:     	movq	%rax, 0xb36b(%rip)      # 0x180016c98
18000b92d:     	testl	%ecx, %ecx
18000b92f:     	js	0x18000b948 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7968>
18000b931:     	subl	$0x1, %ecx
18000b934:     	movl	%ecx, (%rbx)
18000b936:     	jne	0x18000b948 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7968>
18000b938:     	movq	%rbx, %rcx
18000b93b:     	callq	*0x3887(%rip)           # 0x18000f1c8
18000b941:     	movq	0xb350(%rip), %rax      # 0x180016c98
18000b948:     	testq	%rax, %rax
18000b94b:     	je	0x18000b961 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7981>
18000b94d:     	movq	%rdi, %rdx
18000b950:     	movq	%rsi, %rcx
18000b953:     	callq	*0x395f(%rip)           # 0x18000f2b8
18000b959:     	movq	%rax, %rbx
18000b95c:     	testq	%rax, %rax
18000b95f:     	jne	0x18000b973 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7993>
18000b961:     	xorl	%eax, %eax
18000b963:     	movq	0x30(%rsp), %rbx
18000b968:     	movq	0x38(%rsp), %rsi
18000b96d:     	addq	$0x20, %rsp
18000b971:     	popq	%rdi
18000b972:     	retq
18000b973:     	movq	0xb31e(%rip), %rcx      # 0x180016c98
18000b97a:     	xorl	%r8d, %r8d
18000b97d:     	movq	%rbx, %rdx
18000b980:     	callq	*0x3812(%rip)           # 0x18000f198
18000b986:     	movl	(%rbx), %ecx
18000b988:     	movq	%rax, %rdi
18000b98b:     	testl	%ecx, %ecx
18000b98d:     	js	0x18000b99f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79bf>
18000b98f:     	subl	$0x1, %ecx
18000b992:     	movl	%ecx, (%rbx)
18000b994:     	jne	0x18000b99f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x79bf>
18000b996:     	movq	%rbx, %rcx
18000b999:     	callq	*0x3829(%rip)           # 0x18000f1c8
18000b99f:     	movq	0x30(%rsp), %rbx
18000b9a4:     	movq	%rdi, %rax
18000b9a7:     	movq	0x38(%rsp), %rsi
18000b9ac:     	addq	$0x20, %rsp
18000b9b0:     	popq	%rdi
18000b9b1:     	retq
18000b9b2:     	int3
18000b9b3:     	int3
18000b9b4:     	int3
18000b9b5:     	int3
18000b9b6:     	int3
18000b9b7:     	int3
18000b9b8:     	int3
18000b9b9:     	int3
18000b9ba:     	int3
18000b9bb:     	int3
18000b9bc:     	int3
18000b9bd:     	int3
18000b9be:     	int3
18000b9bf:     	int3
18000b9c0:     	movq	%rbx, 0x8(%rsp)
18000b9c5:     	movq	%rsi, 0x10(%rsp)
18000b9ca:     	pushq	%rdi
18000b9cb:     	subq	$0x20, %rsp
18000b9cf:     	movq	0xb2ba(%rip), %rax      # 0x180016c90
18000b9d6:     	movq	%rdx, %rdi
18000b9d9:     	movq	%rcx, %rsi
18000b9dc:     	testq	%rax, %rax
18000b9df:     	jne	0x18000ba41 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7a61>
18000b9e1:     	leaq	0x44b0(%rip), %rcx      # 0x18000fe98
18000b9e8:     	callq	*0x384a(%rip)           # 0x18000f238
18000b9ee:     	movq	%rax, %rbx
18000b9f1:     	testq	%rax, %rax
18000b9f4:     	je	0x18000ba2f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7a4f>
18000b9f6:     	leaq	0x44b3(%rip), %rdx      # 0x18000feb0
18000b9fd:     	movq	%rax, %rcx
18000ba00:     	callq	*0x3762(%rip)           # 0x18000f168
18000ba06:     	movl	(%rbx), %ecx
18000ba08:     	movq	%rax, 0xb281(%rip)      # 0x180016c90
18000ba0f:     	testl	%ecx, %ecx
18000ba11:     	js	0x18000ba2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7a4a>
18000ba13:     	subl	$0x1, %ecx
18000ba16:     	movl	%ecx, (%rbx)
18000ba18:     	jne	0x18000ba2a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7a4a>
18000ba1a:     	movq	%rbx, %rcx
18000ba1d:     	callq	*0x37a5(%rip)           # 0x18000f1c8
18000ba23:     	movq	0xb266(%rip), %rax      # 0x180016c90
18000ba2a:     	testq	%rax, %rax
18000ba2d:     	jne	0x18000ba41 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7a61>
18000ba2f:     	xorl	%eax, %eax
18000ba31:     	movq	0x30(%rsp), %rbx
18000ba36:     	movq	0x38(%rsp), %rsi
18000ba3b:     	addq	$0x20, %rsp
18000ba3f:     	popq	%rdi
18000ba40:     	retq
18000ba41:     	xorl	%r9d, %r9d
18000ba44:     	movq	%rdi, %r8
18000ba47:     	movq	%rsi, %rdx
18000ba4a:     	movq	%rax, %rcx
18000ba4d:     	movq	0x30(%rsp), %rbx
18000ba52:     	movq	0x38(%rsp), %rsi
18000ba57:     	addq	$0x20, %rsp
18000ba5b:     	popq	%rdi
18000ba5c:     	jmpq	*0x3735(%rip)           # 0x18000f198
18000ba63:     	int3
18000ba64:     	int3
18000ba65:     	int3
18000ba66:     	int3
18000ba67:     	int3
18000ba68:     	int3
18000ba69:     	int3
18000ba6a:     	int3
18000ba6b:     	int3
18000ba6c:     	int3
18000ba6d:     	int3
18000ba6e:     	int3
18000ba6f:     	int3
18000ba70:     	movq	%rbx, 0x8(%rsp)
18000ba75:     	movq	%rsi, 0x10(%rsp)
18000ba7a:     	pushq	%rdi
18000ba7b:     	subq	$0x20, %rsp
18000ba7f:     	movq	%rcx, %rbx
18000ba82:     	movq	%r8, %rdi
18000ba85:     	movq	0x10(%rcx), %rcx
18000ba89:     	movq	%rdx, %rsi
18000ba8c:     	testq	%rcx, %rcx
18000ba8f:     	je	0x18000ba9a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7aba>
18000ba91:     	movq	%r8, %rdx
18000ba94:     	callq	*%rsi
18000ba96:     	testl	%eax, %eax
18000ba98:     	jne	0x18000babd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7add>
18000ba9a:     	movq	0x18(%rbx), %rcx
18000ba9e:     	testq	%rcx, %rcx
18000baa1:     	je	0x18000babb <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7adb>
18000baa3:     	movq	%rdi, %rdx
18000baa6:     	movq	%rsi, %rax
18000baa9:     	movq	0x30(%rsp), %rbx
18000baae:     	movq	0x38(%rsp), %rsi
18000bab3:     	addq	$0x20, %rsp
18000bab7:     	popq	%rdi
18000bab8:     	jmpq	*%rax
18000babb:     	xorl	%eax, %eax
18000babd:     	movq	0x30(%rsp), %rbx
18000bac2:     	movq	0x38(%rsp), %rsi
18000bac7:     	addq	$0x20, %rsp
18000bacb:     	popq	%rdi
18000bacc:     	retq
18000bacd:     	int3
18000bace:     	int3
18000bacf:     	int3
18000bad0:     	pushq	%rbx
18000bad2:     	subq	$0x20, %rsp
18000bad6:     	movq	%rcx, %rbx
18000bad9:     	movq	0x10(%rcx), %rcx
18000badd:     	testq	%rcx, %rcx
18000bae0:     	je	0x18000bafd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b1d>
18000bae2:     	movq	$0x0, 0x10(%rbx)
18000baea:     	movl	(%rcx), %eax
18000baec:     	testl	%eax, %eax
18000baee:     	js	0x18000bafd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b1d>
18000baf0:     	subl	$0x1, %eax
18000baf3:     	movl	%eax, (%rcx)
18000baf5:     	jne	0x18000bafd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b1d>
18000baf7:     	callq	*0x36cb(%rip)           # 0x18000f1c8
18000bafd:     	movq	0x18(%rbx), %rcx
18000bb01:     	testq	%rcx, %rcx
18000bb04:     	je	0x18000bb21 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b41>
18000bb06:     	movq	$0x0, 0x18(%rbx)
18000bb0e:     	movl	(%rcx), %eax
18000bb10:     	testl	%eax, %eax
18000bb12:     	js	0x18000bb21 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b41>
18000bb14:     	subl	$0x1, %eax
18000bb17:     	movl	%eax, (%rcx)
18000bb19:     	jne	0x18000bb21 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b41>
18000bb1b:     	callq	*0x36a7(%rip)           # 0x18000f1c8
18000bb21:     	xorl	%eax, %eax
18000bb23:     	addq	$0x20, %rsp
18000bb27:     	popq	%rbx
18000bb28:     	retq
18000bb29:     	int3
18000bb2a:     	int3
18000bb2b:     	int3
18000bb2c:     	int3
18000bb2d:     	int3
18000bb2e:     	int3
18000bb2f:     	int3
18000bb30:     	pushq	%rbx
18000bb32:     	subq	$0x20, %rsp
18000bb36:     	movq	%rcx, %rbx
18000bb39:     	callq	*0x36d9(%rip)           # 0x18000f218
18000bb3f:     	movq	0x10(%rbx), %rcx
18000bb43:     	testq	%rcx, %rcx
18000bb46:     	je	0x18000bb63 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b83>
18000bb48:     	movq	$0x0, 0x10(%rbx)
18000bb50:     	movl	(%rcx), %eax
18000bb52:     	testl	%eax, %eax
18000bb54:     	js	0x18000bb63 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b83>
18000bb56:     	subl	$0x1, %eax
18000bb59:     	movl	%eax, (%rcx)
18000bb5b:     	jne	0x18000bb63 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7b83>
18000bb5d:     	callq	*0x3665(%rip)           # 0x18000f1c8
18000bb63:     	movq	0x18(%rbx), %rcx
18000bb67:     	testq	%rcx, %rcx
18000bb6a:     	je	0x18000bb87 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7ba7>
18000bb6c:     	movq	$0x0, 0x18(%rbx)
18000bb74:     	movl	(%rcx), %eax
18000bb76:     	testl	%eax, %eax
18000bb78:     	js	0x18000bb87 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7ba7>
18000bb7a:     	subl	$0x1, %eax
18000bb7d:     	movl	%eax, (%rcx)
18000bb7f:     	jne	0x18000bb87 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7ba7>
18000bb81:     	callq	*0x3641(%rip)           # 0x18000f1c8
18000bb87:     	movq	0x8(%rbx), %rax
18000bb8b:     	movq	%rbx, %rcx
18000bb8e:     	addq	$0x20, %rsp
18000bb92:     	popq	%rbx
18000bb93:     	jmpq	*0x140(%rax)
18000bb9a:     	int3
18000bb9b:     	int3
18000bb9c:     	int3
18000bb9d:     	int3
18000bb9e:     	int3
18000bb9f:     	int3
18000bba0:     	pushq	%rbx
18000bba2:     	subq	$0x30, %rsp
18000bba6:     	movq	%r8, %r10
18000bba9:     	leaq	0x58(%rsp), %rax
18000bbae:     	movq	%rax, 0x28(%rsp)
18000bbb3:     	leaq	0xae16(%rip), %r9       # 0x1800169d0
18000bbba:     	movq	0x3627(%rip), %rax      # 0x18000f1e8
18000bbc1:     	leaq	0x4318(%rip), %r8       # 0x18000fee0
18000bbc8:     	movq	%rdx, %r11
18000bbcb:     	movq	%rax, 0x20(%rsp)
18000bbd0:     	movq	%rcx, %rbx
18000bbd3:     	movq	%r10, %rdx
18000bbd6:     	movq	%r11, %rcx
18000bbd9:     	callq	*0x3519(%rip)           # 0x18000f0f8
18000bbdf:     	testl	%eax, %eax
18000bbe1:     	je	0x18000bc3c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c5c>
18000bbe3:     	xorl	%r8d, %r8d
18000bbe6:     	xorl	%edx, %edx
18000bbe8:     	movq	%rbx, %rcx
18000bbeb:     	callq	*0x3657(%rip)           # 0x18000f248
18000bbf1:     	movq	%rax, %rbx
18000bbf4:     	testq	%rax, %rax
18000bbf7:     	je	0x18000bc3c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c5c>
18000bbf9:     	movq	0x58(%rsp), %rax
18000bbfe:     	movl	(%rax), %ecx
18000bc00:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000bc06:     	jae	0x18000bc11 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c31>
18000bc08:     	incl	%ecx
18000bc0a:     	movl	%ecx, (%rax)
18000bc0c:     	movq	0x58(%rsp), %rax
18000bc11:     	xorl	%ecx, %ecx
18000bc13:     	movq	%rax, 0x10(%rbx)
18000bc17:     	callq	*0x355b(%rip)           # 0x18000f178
18000bc1d:     	movq	%rax, 0x18(%rbx)
18000bc21:     	testq	%rax, %rax
18000bc24:     	jne	0x18000bc44 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c64>
18000bc26:     	movl	(%rbx), %eax
18000bc28:     	testl	%eax, %eax
18000bc2a:     	js	0x18000bc3c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c5c>
18000bc2c:     	subl	$0x1, %eax
18000bc2f:     	movl	%eax, (%rbx)
18000bc31:     	jne	0x18000bc3c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c5c>
18000bc33:     	movq	%rbx, %rcx
18000bc36:     	callq	*0x358c(%rip)           # 0x18000f1c8
18000bc3c:     	xorl	%eax, %eax
18000bc3e:     	addq	$0x30, %rsp
18000bc42:     	popq	%rbx
18000bc43:     	retq
18000bc44:     	movq	%rbx, %rax
18000bc47:     	addq	$0x30, %rsp
18000bc4b:     	popq	%rbx
18000bc4c:     	retq
18000bc4d:     	int3
18000bc4e:     	int3
18000bc4f:     	int3
18000bc50:     	movq	%rbx, 0x8(%rsp)
18000bc55:     	movq	%rsi, 0x10(%rsp)
18000bc5a:     	pushq	%rdi
18000bc5b:     	subq	$0x20, %rsp
18000bc5f:     	movq	%rcx, %rbx
18000bc62:     	movq	%r8, %rdi
18000bc65:     	movq	0x18(%rcx), %rcx
18000bc69:     	movq	%rdx, %rsi
18000bc6c:     	testq	%rcx, %rcx
18000bc6f:     	je	0x18000bc7a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7c9a>
18000bc71:     	movq	%r8, %rdx
18000bc74:     	callq	*%rsi
18000bc76:     	testl	%eax, %eax
18000bc78:     	jne	0x18000bc9d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7cbd>
18000bc7a:     	movq	0x40(%rbx), %rcx
18000bc7e:     	testq	%rcx, %rcx
18000bc81:     	je	0x18000bc9b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7cbb>
18000bc83:     	movq	%rdi, %rdx
18000bc86:     	movq	%rsi, %rax
18000bc89:     	movq	0x30(%rsp), %rbx
18000bc8e:     	movq	0x38(%rsp), %rsi
18000bc93:     	addq	$0x20, %rsp
18000bc97:     	popq	%rdi
18000bc98:     	jmpq	*%rax
18000bc9b:     	xorl	%eax, %eax
18000bc9d:     	movq	0x30(%rsp), %rbx
18000bca2:     	movq	0x38(%rsp), %rsi
18000bca7:     	addq	$0x20, %rsp
18000bcab:     	popq	%rdi
18000bcac:     	retq
18000bcad:     	int3
18000bcae:     	int3
18000bcaf:     	int3
18000bcb0:     	pushq	%rbx
18000bcb2:     	subq	$0x20, %rsp
18000bcb6:     	movq	%rcx, %rbx
18000bcb9:     	callq	*0x3559(%rip)           # 0x18000f218
18000bcbf:     	cmpq	$0x0, 0x48(%rbx)
18000bcc4:     	je	0x18000bccf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7cef>
18000bcc6:     	movq	%rbx, %rcx
18000bcc9:     	callq	*0x34b9(%rip)           # 0x18000f188
18000bccf:     	movq	0x20(%rbx), %rcx
18000bcd3:     	callq	*0x34df(%rip)           # 0x18000f1b8
18000bcd9:     	movq	0x38(%rbx), %rcx
18000bcdd:     	callq	*0x34d5(%rip)           # 0x18000f1b8
18000bce3:     	movq	0x18(%rbx), %rcx
18000bce7:     	testq	%rcx, %rcx
18000bcea:     	je	0x18000bcff <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d1f>
18000bcec:     	movl	(%rcx), %eax
18000bcee:     	testl	%eax, %eax
18000bcf0:     	js	0x18000bcff <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d1f>
18000bcf2:     	subl	$0x1, %eax
18000bcf5:     	movl	%eax, (%rcx)
18000bcf7:     	jne	0x18000bcff <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d1f>
18000bcf9:     	callq	*0x34c9(%rip)           # 0x18000f1c8
18000bcff:     	movq	0x40(%rbx), %rcx
18000bd03:     	testq	%rcx, %rcx
18000bd06:     	je	0x18000bd1b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d3b>
18000bd08:     	movl	(%rcx), %eax
18000bd0a:     	testl	%eax, %eax
18000bd0c:     	js	0x18000bd1b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d3b>
18000bd0e:     	subl	$0x1, %eax
18000bd11:     	movl	%eax, (%rcx)
18000bd13:     	jne	0x18000bd1b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d3b>
18000bd15:     	callq	*0x34ad(%rip)           # 0x18000f1c8
18000bd1b:     	movq	0x8(%rbx), %rax
18000bd1f:     	movq	%rbx, %rcx
18000bd22:     	addq	$0x20, %rsp
18000bd26:     	popq	%rbx
18000bd27:     	jmpq	*0x140(%rax)
18000bd2e:     	int3
18000bd2f:     	int3
18000bd30:     	pushq	%rbx
18000bd32:     	subq	$0x20, %rsp
18000bd36:     	callq	*0x3444(%rip)           # 0x18000f180
18000bd3c:     	movq	%rax, %rbx
18000bd3f:     	testq	%rax, %rax
18000bd42:     	jne	0x18000bd4a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d6a>
18000bd44:     	addq	$0x20, %rsp
18000bd48:     	popq	%rbx
18000bd49:     	retq
18000bd4a:     	movq	%rbx, %rcx
18000bd4d:     	movq	%rdi, 0x30(%rsp)
18000bd52:     	callq	0x18000e0b5 <numba_list_iter_next+0xed5>
18000bd57:     	leaq	0x1(%rax), %rcx
18000bd5b:     	callq	*0x34ef(%rip)           # 0x18000f250
18000bd61:     	movq	%rax, %rdi
18000bd64:     	testq	%rax, %rax
18000bd67:     	jne	0x18000bd7c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d9c>
18000bd69:     	callq	*0x33d1(%rip)           # 0x18000f140
18000bd6f:     	movq	0x30(%rsp), %rdi
18000bd74:     	xorl	%eax, %eax
18000bd76:     	addq	$0x20, %rsp
18000bd7a:     	popq	%rbx
18000bd7b:     	retq
18000bd7c:     	movq	%rbx, %rdx
18000bd7f:     	movq	%rdi, %rcx
18000bd82:     	callq	0x18000e0af <numba_list_iter_next+0xecf>
18000bd87:     	movq	%rdi, %rax
18000bd8a:     	movq	0x30(%rsp), %rdi
18000bd8f:     	addq	$0x20, %rsp
18000bd93:     	popq	%rbx
18000bd94:     	retq
18000bd95:     	int3
18000bd96:     	int3
18000bd97:     	int3
18000bd98:     	int3
18000bd99:     	int3
18000bd9a:     	int3
18000bd9b:     	int3
18000bd9c:     	int3
18000bd9d:     	int3
18000bd9e:     	int3
18000bd9f:     	int3
18000bda0:     	movq	0x18(%rcx), %rcx
18000bda4:     	movq	%rdx, %rax
18000bda7:     	testq	%rcx, %rcx
18000bdaa:     	je	0x18000bdb2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7dd2>
18000bdac:     	movq	%r8, %rdx
18000bdaf:     	jmpq	*%rax
18000bdb2:     	xorl	%eax, %eax
18000bdb4:     	retq
18000bdb5:     	int3
18000bdb6:     	int3
18000bdb7:     	int3
18000bdb8:     	int3
18000bdb9:     	int3
18000bdba:     	int3
18000bdbb:     	int3
18000bdbc:     	int3
18000bdbd:     	int3
18000bdbe:     	int3
18000bdbf:     	int3
18000bdc0:     	movq	%rbx, 0x8(%rsp)
18000bdc5:     	pushq	%rdi
18000bdc6:     	subq	$0x20, %rsp
18000bdca:     	movq	0x28(%rcx), %rax
18000bdce:     	xorl	%edi, %edi
18000bdd0:     	movq	%rcx, %rbx
18000bdd3:     	testq	%rax, %rax
18000bdd6:     	je	0x18000bde2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e02>
18000bdd8:     	addq	$0x38, %rcx
18000bddc:     	callq	*%rax
18000bdde:     	movq	%rdi, 0x28(%rbx)
18000bde2:     	movq	0x18(%rbx), %rcx
18000bde6:     	testq	%rcx, %rcx
18000bde9:     	je	0x18000be02 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e22>
18000bdeb:     	movq	%rdi, 0x18(%rbx)
18000bdef:     	movl	(%rcx), %eax
18000bdf1:     	testl	%eax, %eax
18000bdf3:     	js	0x18000be02 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e22>
18000bdf5:     	subl	$0x1, %eax
18000bdf8:     	movl	%eax, (%rcx)
18000bdfa:     	jne	0x18000be02 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e22>
18000bdfc:     	callq	*0x33c6(%rip)           # 0x18000f1c8
18000be02:     	movq	%rdi, 0x20(%rbx)
18000be06:     	xorl	%eax, %eax
18000be08:     	movq	0x30(%rsp), %rbx
18000be0d:     	addq	$0x20, %rsp
18000be11:     	popq	%rdi
18000be12:     	retq
18000be13:     	int3
18000be14:     	int3
18000be15:     	int3
18000be16:     	int3
18000be17:     	int3
18000be18:     	int3
18000be19:     	int3
18000be1a:     	int3
18000be1b:     	int3
18000be1c:     	int3
18000be1d:     	int3
18000be1e:     	int3
18000be1f:     	int3
18000be20:     	pushq	%rbx
18000be22:     	subq	$0x20, %rsp
18000be26:     	movq	%rcx, %rbx
18000be29:     	callq	*0x33e9(%rip)           # 0x18000f218
18000be2f:     	cmpq	$0x0, 0x30(%rbx)
18000be34:     	je	0x18000be3f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e5f>
18000be36:     	movq	%rbx, %rcx
18000be39:     	callq	*0x3349(%rip)           # 0x18000f188
18000be3f:     	callq	*0x32c3(%rip)           # 0x18000f108
18000be45:     	testl	%eax, %eax
18000be47:     	jne	0x18000be58 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e78>
18000be49:     	movq	0x28(%rbx), %rax
18000be4d:     	testq	%rax, %rax
18000be50:     	je	0x18000be58 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e78>
18000be52:     	leaq	0x38(%rbx), %rcx
18000be56:     	callq	*%rax
18000be58:     	movq	0x18(%rbx), %rcx
18000be5c:     	testq	%rcx, %rcx
18000be5f:     	je	0x18000be74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e94>
18000be61:     	movl	(%rcx), %eax
18000be63:     	testl	%eax, %eax
18000be65:     	js	0x18000be74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e94>
18000be67:     	subl	$0x1, %eax
18000be6a:     	movl	%eax, (%rcx)
18000be6c:     	jne	0x18000be74 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7e94>
18000be6e:     	callq	*0x3354(%rip)           # 0x18000f1c8
18000be74:     	movq	0x8(%rbx), %rax
18000be78:     	movq	%rbx, %rcx
18000be7b:     	addq	$0x20, %rsp
18000be7f:     	popq	%rbx
18000be80:     	jmpq	*0x140(%rax)
18000be87:     	int3
18000be88:     	int3
18000be89:     	int3
18000be8a:     	int3
18000be8b:     	int3
18000be8c:     	int3
18000be8d:     	int3
18000be8e:     	int3
18000be8f:     	int3
18000be90:     	pushq	%rdi
18000be92:     	subq	$0x20, %rsp
18000be96:     	cmpq	$0x0, 0x20(%rcx)
18000be9b:     	movq	%rcx, %rdi
18000be9e:     	jne	0x18000bebf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7edf>
18000bea0:     	movq	0x3409(%rip), %rcx      # 0x18000f2b0
18000bea7:     	leaq	0x4082(%rip), %rdx      # 0x18000ff30
18000beae:     	movq	(%rcx), %rcx
18000beb1:     	callq	*0x33f1(%rip)           # 0x18000f2a8
18000beb7:     	xorl	%eax, %eax
18000beb9:     	addq	$0x20, %rsp
18000bebd:     	popq	%rdi
18000bebe:     	retq
18000bebf:     	movq	%rdi, %rdx
18000bec2:     	movq	%rbx, 0x30(%rsp)
18000bec7:     	movl	$0x1, %ecx
18000becc:     	callq	*0x3436(%rip)           # 0x18000f308
18000bed2:     	movq	%rax, %rbx
18000bed5:     	testq	%rax, %rax
18000bed8:     	jne	0x18000bee5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f05>
18000beda:     	movq	0x30(%rsp), %rbx
18000bedf:     	addq	$0x20, %rsp
18000bee3:     	popq	%rdi
18000bee4:     	retq
18000bee5:     	xorl	%r8d, %r8d
18000bee8:     	movq	%rbx, %rdx
18000beeb:     	movq	%rdi, %rcx
18000beee:     	callq	*0x20(%rdi)
18000bef1:     	movl	(%rbx), %ecx
18000bef3:     	movq	%rax, %rdi
18000bef6:     	testl	%ecx, %ecx
18000bef8:     	js	0x18000bf0a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f2a>
18000befa:     	subl	$0x1, %ecx
18000befd:     	movl	%ecx, (%rbx)
18000beff:     	jne	0x18000bf0a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f2a>
18000bf01:     	movq	%rbx, %rcx
18000bf04:     	callq	*0x32be(%rip)           # 0x18000f1c8
18000bf0a:     	movq	0x30(%rsp), %rbx
18000bf0f:     	movq	%rdi, %rax
18000bf12:     	addq	$0x20, %rsp
18000bf16:     	popq	%rdi
18000bf17:     	retq
18000bf18:     	int3
18000bf19:     	int3
18000bf1a:     	int3
18000bf1b:     	int3
18000bf1c:     	int3
18000bf1d:     	int3
18000bf1e:     	int3
18000bf1f:     	int3
18000bf20:     	movq	%rbx, 0x8(%rsp)
18000bf25:     	pushq	%rdi
18000bf26:     	subq	$0x20, %rsp
18000bf2a:     	movq	%r8, %rbx
18000bf2d:     	callq	*0x31bd(%rip)           # 0x18000f0f0
18000bf33:     	movl	(%rbx), %ecx
18000bf35:     	movl	%eax, %edi
18000bf37:     	testl	%ecx, %ecx
18000bf39:     	js	0x18000bf4b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f6b>
18000bf3b:     	subl	$0x1, %ecx
18000bf3e:     	movl	%ecx, (%rbx)
18000bf40:     	jne	0x18000bf4b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f6b>
18000bf42:     	movq	%rbx, %rcx
18000bf45:     	callq	*0x327d(%rip)           # 0x18000f1c8
18000bf4b:     	movl	%edi, %ecx
18000bf4d:     	movq	0x30(%rsp), %rbx
18000bf52:     	addq	$0x20, %rsp
18000bf56:     	popq	%rdi
18000bf57:     	jmpq	*0x32b2(%rip)           # 0x18000f210
18000bf5e:     	int3
18000bf5f:     	int3
18000bf60:     	movq	%rbx, 0x8(%rsp)
18000bf65:     	pushq	%rdi
18000bf66:     	subq	$0x20, %rsp
18000bf6a:     	movl	(%rdx), %eax
18000bf6c:     	movq	%rdx, %rbx
18000bf6f:     	movq	%rcx, %rdi
18000bf72:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000bf77:     	jae	0x18000bf7d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f9d>
18000bf79:     	incl	%eax
18000bf7b:     	movl	%eax, (%rdx)
18000bf7d:     	movl	$0x30, %ecx
18000bf82:     	callq	*0xace0(%rip)           # 0x180016c68
18000bf88:     	cmpb	$0x0, 0xacb1(%rip)      # 0x180016c40
18000bf8f:     	je	0x18000bf99 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7fb9>
18000bf91:     	lock
18000bf92:     	incq	0xacaf(%rip)            # 0x180016c48
18000bf99:     	testq	%rax, %rax
18000bf9c:     	je	0x18000bfd3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7ff3>
18000bf9e:     	movl	$0x1, %ecx
18000bfa3:     	leaq	-0x8a(%rip), %rdx       # 0x18000bf20 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f40>
18000bfaa:     	xchgq	%rcx, (%rax)
18000bfad:     	xorl	%ecx, %ecx
18000bfaf:     	movq	%rdx, 0x8(%rax)
18000bfb3:     	movq	%rcx, 0x20(%rax)
18000bfb7:     	movq	%rcx, 0x28(%rax)
18000bfbb:     	movq	%rbx, 0x10(%rax)
18000bfbf:     	movq	%rdi, 0x18(%rax)
18000bfc3:     	cmpb	%cl, 0xac77(%rip)       # 0x180016c40
18000bfc9:     	je	0x18000bfd3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7ff3>
18000bfcb:     	lock
18000bfcc:     	incq	0xac85(%rip)            # 0x180016c58
18000bfd3:     	movq	0x30(%rsp), %rbx
18000bfd8:     	addq	$0x20, %rsp
18000bfdc:     	popq	%rdi
18000bfdd:     	retq
18000bfde:     	int3
18000bfdf:     	int3
18000bfe0:     	movq	%rbx, 0x8(%rsp)
18000bfe5:     	pushq	%rdi
18000bfe6:     	subq	$0x30, %rsp
18000bfea:     	movq	%rcx, %rdi
18000bfed:     	leaq	0xa9cc(%rip), %r9       # 0x1800169c0
18000bff4:     	movq	%r8, %rax
18000bff7:     	leaq	0x58(%rsp), %rcx
18000bffc:     	movq	%rdx, %r10
18000bfff:     	movq	%rcx, 0x20(%rsp)
18000c004:     	movq	%r10, %rcx
18000c007:     	leaq	0x3f6a(%rip), %r8       # 0x18000ff78
18000c00e:     	movq	%rax, %rdx
18000c011:     	callq	*0x30e1(%rip)           # 0x18000f0f8
18000c017:     	testl	%eax, %eax
18000c019:     	je	0x18000c043 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8063>
18000c01b:     	movq	0x58(%rsp), %rcx
18000c020:     	callq	*0x30ba(%rip)           # 0x18000f0e0
18000c026:     	movq	%rax, %rbx
18000c029:     	callq	*0x32b9(%rip)           # 0x18000f2e8
18000c02f:     	testq	%rax, %rax
18000c032:     	jne	0x18000c043 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8063>
18000c034:     	movq	%rbx, 0x10(%rdi)
18000c038:     	movq	0x40(%rsp), %rbx
18000c03d:     	addq	$0x30, %rsp
18000c041:     	popq	%rdi
18000c042:     	retq
18000c043:     	movq	0x40(%rsp), %rbx
18000c048:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000c04d:     	addq	$0x30, %rsp
18000c051:     	popq	%rdi
18000c052:     	retq
18000c053:     	int3
18000c054:     	int3
18000c055:     	int3
18000c056:     	int3
18000c057:     	int3
18000c058:     	int3
18000c059:     	int3
18000c05a:     	int3
18000c05b:     	int3
18000c05c:     	int3
18000c05d:     	int3
18000c05e:     	int3
18000c05f:     	int3
18000c060:     	subq	$0x38, %rsp
18000c064:     	movl	%r8d, %eax
18000c067:     	movq	%rdx, %r10
18000c06a:     	movq	0x10(%rcx), %r8
18000c06e:     	movq	%rcx, %rdx
18000c071:     	movl	%eax, 0x28(%rsp)
18000c075:     	movq	%r10, %rcx
18000c078:     	movl	$0x0, 0x20(%rsp)
18000c080:     	movq	0x20(%r8), %r9
18000c084:     	movq	0x18(%r8), %r8
18000c088:     	callq	*0x317a(%rip)           # 0x18000f208
18000c08e:     	addq	$0x38, %rsp
18000c092:     	retq
18000c093:     	int3
18000c094:     	int3
18000c095:     	int3
18000c096:     	int3
18000c097:     	int3
18000c098:     	int3
18000c099:     	int3
18000c09a:     	int3
18000c09b:     	int3
18000c09c:     	int3
18000c09d:     	int3
18000c09e:     	int3
18000c09f:     	int3
18000c0a0:     	movq	0x10(%rcx), %rax
18000c0a4:     	lock
18000c0a5:     	incq	(%rax)
18000c0a8:     	movq	0x3221(%rip), %rax      # 0x18000f2d0
18000c0af:     	retq
18000c0b0:     	subq	$0x28, %rsp
18000c0b4:     	movq	0x10(%rcx), %rcx
18000c0b8:     	callq	0x18000d3b0 <numba_list_iter_next+0x1d0>
18000c0bd:     	movq	0x320c(%rip), %rax      # 0x18000f2d0
18000c0c4:     	addq	$0x28, %rsp
18000c0c8:     	retq
18000c0c9:     	int3
18000c0ca:     	int3
18000c0cb:     	int3
18000c0cc:     	int3
18000c0cd:     	int3
18000c0ce:     	int3
18000c0cf:     	int3
18000c0d0:     	movq	0x10(%rcx), %rcx
18000c0d4:     	movq	0x18(%rcx), %rcx
18000c0d8:     	jmpq	*0x3079(%rip)           # 0x18000f158
18000c0df:     	int3
18000c0e0:     	subq	$0x28, %rsp
18000c0e4:     	movq	0x10(%rcx), %rax
18000c0e8:     	testq	%rax, %rax
18000c0eb:     	je	0x18000c109 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8129>
18000c0ed:     	cmpq	$0x0, 0x18(%rax)
18000c0f2:     	je	0x18000c109 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8129>
18000c0f4:     	movq	(%rax), %rcx
18000c0f7:     	nop
18000c0f8:     	cmpq	$-0x1, %rcx
18000c0fc:     	je	0x18000c109 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8129>
18000c0fe:     	addq	$0x28, %rsp
18000c102:     	jmpq	*0x301f(%rip)           # 0x18000f128
18000c109:     	movq	0x30e8(%rip), %rcx      # 0x18000f1f8
18000c110:     	leaq	0x3e69(%rip), %rdx      # 0x18000ff80
18000c117:     	movq	(%rcx), %rcx
18000c11a:     	callq	*0x3188(%rip)           # 0x18000f2a8
18000c120:     	xorl	%eax, %eax
18000c122:     	addq	$0x28, %rsp
18000c126:     	retq
18000c127:     	int3
18000c128:     	int3
18000c129:     	int3
18000c12a:     	int3
18000c12b:     	int3
18000c12c:     	int3
18000c12d:     	int3
18000c12e:     	int3
18000c12f:     	int3
18000c130:     	movq	0x10(%rcx), %rcx
18000c134:     	movq	0x28(%rcx), %rcx
18000c138:     	jmpq	*0x3019(%rip)           # 0x18000f158
18000c13f:     	int3
18000c140:     	movq	0x10(%rcx), %rax
18000c144:     	movq	0x10(%rax), %rax
18000c148:     	testq	%rax, %rax
18000c14b:     	je	0x18000c15c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x817c>
18000c14d:     	movl	(%rax), %ecx
18000c14f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000c155:     	jae	0x18000c17a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x819a>
18000c157:     	incl	%ecx
18000c159:     	movl	%ecx, (%rax)
18000c15b:     	retq
18000c15c:     	movq	0x316d(%rip), %rcx      # 0x18000f2d0
18000c163:     	movl	(%rcx), %eax
18000c165:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000c16a:     	jae	0x18000c177 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8197>
18000c16c:     	incl	%eax
18000c16e:     	movl	%eax, (%rcx)
18000c170:     	movq	0x3159(%rip), %rcx      # 0x18000f2d0
18000c177:     	movq	%rcx, %rax
18000c17a:     	retq
18000c17b:     	int3
18000c17c:     	int3
18000c17d:     	int3
18000c17e:     	int3
18000c17f:     	int3
18000c180:     	pushq	%rbx
18000c182:     	subq	$0x20, %rsp
18000c186:     	movq	%rcx, %rbx
18000c189:     	movq	0x10(%rcx), %rcx
18000c18d:     	callq	0x18000d3b0 <numba_list_iter_next+0x1d0>
18000c192:     	movq	0x8(%rbx), %rax
18000c196:     	movq	%rbx, %rcx
18000c199:     	addq	$0x20, %rsp
18000c19d:     	popq	%rbx
18000c19e:     	jmpq	*0x140(%rax)
18000c1a5:     	int3
18000c1a6:     	int3
18000c1a7:     	int3
18000c1a8:     	int3
18000c1a9:     	int3
18000c1aa:     	int3
18000c1ab:     	int3
18000c1ac:     	int3
18000c1ad:     	int3
18000c1ae:     	int3
18000c1af:     	int3
18000c1b0:     	movq	%rdi, 0x18(%rsp)
18000c1b5:     	pushq	%r14
18000c1b7:     	subq	$0x20, %rsp
18000c1bb:     	movq	0xaabe(%rip), %rax      # 0x180016c80
18000c1c2:     	movq	%rdx, %r14
18000c1c5:     	movq	%rcx, %rdi
18000c1c8:     	movq	0x8(%rcx), %rcx
18000c1cc:     	movq	0x10(%rax), %rdx
18000c1d0:     	cmpq	%rdx, %rcx
18000c1d3:     	je	0x18000c1f0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8210>
18000c1d5:     	callq	*0x2ffd(%rip)           # 0x18000f1d8
18000c1db:     	testl	%eax, %eax
18000c1dd:     	jne	0x18000c1f0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8210>
18000c1df:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000c1e4:     	movq	0x40(%rsp), %rdi
18000c1e9:     	addq	$0x20, %rsp
18000c1ed:     	popq	%r14
18000c1ef:     	retq
18000c1f0:     	movq	%rbx, 0x30(%rsp)
18000c1f5:     	movq	%rdi, %rdx
18000c1f8:     	movq	0x10(%rdi), %rbx
18000c1fc:     	movq	%rbx, %rcx
18000c1ff:     	movq	%rsi, 0x38(%rsp)
18000c204:     	movl	0x18(%rdi), %esi
18000c207:     	callq	0x18000bf60 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7f80>
18000c20c:     	movq	%rax, (%r14)
18000c20f:     	movq	0xaa6a(%rip), %rax      # 0x180016c80
18000c216:     	movq	%rbx, 0x20(%r14)
18000c21a:     	movl	0x18(%rdi), %edx
18000c21d:     	movq	0x20(%rdi), %rcx
18000c221:     	callq	*0x4f0(%rax)
18000c227:     	cmpl	$0x12, 0xaa5e(%rip)     # 0x180016c8c
18000c22e:     	movq	0x30(%rsp), %rbx
18000c233:     	movq	%rax, 0x10(%r14)
18000c237:     	movq	0x38(%rdi), %rax
18000c23b:     	jl	0x18000c243 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8263>
18000c23d:     	movq	0x28(%rax), %rax
18000c241:     	jmp	0x18000c247 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8267>
18000c243:     	movslq	0x20(%rax), %rax
18000c247:     	xorl	%r8d, %r8d
18000c24a:     	movq	%rax, 0x18(%r14)
18000c24e:     	movq	%rdi, 0x8(%r14)
18000c252:     	leaq	0x28(%r14), %rax
18000c256:     	testl	%esi, %esi
18000c258:     	jle	0x18000c29b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x82bb>
18000c25a:     	nopw	(%rax,%rax)
18000c260:     	movq	0x20(%rdi), %rcx
18000c264:     	movq	(%rcx,%r8,8), %rdx
18000c268:     	incl	%r8d
18000c26b:     	movq	%rdx, (%rax)
18000c26e:     	addq	$0x8, %rax
18000c272:     	cmpl	%esi, %r8d
18000c275:     	jl	0x18000c260 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8280>
18000c277:     	xorl	%r8d, %r8d
18000c27a:     	nopw	(%rax,%rax)
18000c280:     	movq	0x28(%rdi), %rcx
18000c284:     	leaq	0x8(%rax), %rax
18000c288:     	movslq	%r8d, %rdx
18000c28b:     	incl	%r8d
18000c28e:     	movq	(%rcx,%rdx,8), %rdx
18000c292:     	movq	%rdx, -0x8(%rax)
18000c296:     	cmpl	%esi, %r8d
18000c299:     	jl	0x18000c280 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x82a0>
18000c29b:     	movq	0x38(%rsp), %rsi
18000c2a0:     	xorl	%eax, %eax
18000c2a2:     	movq	0x40(%rsp), %rdi
18000c2a7:     	addq	$0x20, %rsp
18000c2ab:     	popq	%r14
18000c2ad:     	retq
18000c2ae:     	int3
18000c2af:     	int3
18000c2b0:     	pushq	%rbx
18000c2b2:     	pushq	%rbp
18000c2b3:     	pushq	%rsi
18000c2b4:     	pushq	%rdi
18000c2b5:     	subq	$0x28, %rsp
18000c2b9:     	cmpq	$0x0, 0xa9d7(%rip)      # 0x180016c98
18000c2c1:     	movq	%rcx, %rbp
18000c2c4:     	movslq	0x8(%rdx), %rdi
18000c2c8:     	movq	(%rdx), %rsi
18000c2cb:     	jne	0x18000c323 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8343>
18000c2cd:     	leaq	0x3bb4(%rip), %rcx      # 0x18000fe88
18000c2d4:     	callq	*0x2f5e(%rip)           # 0x18000f238
18000c2da:     	movq	%rax, %rbx
18000c2dd:     	testq	%rax, %rax
18000c2e0:     	je	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c2e6:     	leaq	0x3ba3(%rip), %rdx      # 0x18000fe90
18000c2ed:     	movq	%rax, %rcx
18000c2f0:     	callq	*0x2e72(%rip)           # 0x18000f168
18000c2f6:     	movl	(%rbx), %edx
18000c2f8:     	movq	%rax, 0xa999(%rip)      # 0x180016c98
18000c2ff:     	testl	%edx, %edx
18000c301:     	js	0x18000c31a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x833a>
18000c303:     	subl	$0x1, %edx
18000c306:     	movl	%edx, (%rbx)
18000c308:     	jne	0x18000c31a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x833a>
18000c30a:     	movq	%rbx, %rcx
18000c30d:     	callq	*0x2eb5(%rip)           # 0x18000f1c8
18000c313:     	movq	0xa97e(%rip), %rax      # 0x180016c98
18000c31a:     	testq	%rax, %rax
18000c31d:     	je	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c323:     	movq	%rdi, %rdx
18000c326:     	movq	%rsi, %rcx
18000c329:     	callq	*0x2f89(%rip)           # 0x18000f2b8
18000c32f:     	movq	%rax, %rdi
18000c332:     	testq	%rax, %rax
18000c335:     	je	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c337:     	movq	0xa95a(%rip), %rcx      # 0x180016c98
18000c33e:     	xorl	%r8d, %r8d
18000c341:     	movq	%rax, %rdx
18000c344:     	callq	*0x2e4e(%rip)           # 0x18000f198
18000c34a:     	movl	(%rdi), %ecx
18000c34c:     	movq	%rax, %rbx
18000c34f:     	testl	%ecx, %ecx
18000c351:     	js	0x18000c363 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8383>
18000c353:     	subl	$0x1, %ecx
18000c356:     	movl	%ecx, (%rdi)
18000c358:     	jne	0x18000c363 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8383>
18000c35a:     	movq	%rdi, %rcx
18000c35d:     	callq	*0x2e65(%rip)           # 0x18000f1c8
18000c363:     	testq	%rbx, %rbx
18000c366:     	je	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c368:     	movq	0x8(%rbx), %r8
18000c36c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
18000c377:     	jne	0x18000c3b5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83d5>
18000c379:     	movq	0x2f20(%rip), %rcx      # 0x18000f2a0
18000c380:     	leaq	0x3d01(%rip), %rdx      # 0x180010088
18000c387:     	movq	0x18(%r8), %r8
18000c38b:     	movq	(%rcx), %rcx
18000c38e:     	callq	*0x2e5c(%rip)           # 0x18000f1f0
18000c394:     	movl	(%rbx), %eax
18000c396:     	testl	%eax, %eax
18000c398:     	js	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c39a:     	subl	$0x1, %eax
18000c39d:     	movl	%eax, (%rbx)
18000c39f:     	jne	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c3a1:     	movq	%rbx, %rcx
18000c3a4:     	callq	*0x2e1e(%rip)           # 0x18000f1c8
18000c3aa:     	xorl	%eax, %eax
18000c3ac:     	addq	$0x28, %rsp
18000c3b0:     	popq	%rdi
18000c3b1:     	popq	%rsi
18000c3b2:     	popq	%rbp
18000c3b3:     	popq	%rbx
18000c3b4:     	retq
18000c3b5:     	xorl	%r8d, %r8d
18000c3b8:     	leaq	0x9f81(%rip), %rcx      # 0x180016340
18000c3bf:     	xorl	%edx, %edx
18000c3c1:     	callq	*0x2e81(%rip)           # 0x18000f248
18000c3c7:     	movq	%rax, %rdi
18000c3ca:     	testq	%rax, %rax
18000c3cd:     	je	0x18000c394 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83b4>
18000c3cf:     	movq	%rbp, %rcx
18000c3d2:     	movq	%rbx, 0x18(%rax)
18000c3d6:     	callq	*0x2de4(%rip)           # 0x18000f1c0
18000c3dc:     	movq	%rax, 0x10(%rdi)
18000c3e0:     	movq	%rax, %rcx
18000c3e3:     	testq	%rax, %rax
18000c3e6:     	jne	0x18000c3fa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x841a>
18000c3e8:     	movl	(%rdi), %eax
18000c3ea:     	testl	%eax, %eax
18000c3ec:     	js	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c3ee:     	subl	$0x1, %eax
18000c3f1:     	movl	%eax, (%rdi)
18000c3f3:     	jne	0x18000c3aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83ca>
18000c3f5:     	movq	%rdi, %rcx
18000c3f8:     	jmp	0x18000c3a4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x83c4>
18000c3fa:     	movl	(%rax), %eax
18000c3fc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000c401:     	jae	0x18000c407 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8427>
18000c403:     	incl	%eax
18000c405:     	movl	%eax, (%rcx)
18000c407:     	movq	%rdi, %rax
18000c40a:     	addq	$0x28, %rsp
18000c40e:     	popq	%rdi
18000c40f:     	popq	%rsi
18000c410:     	popq	%rbp
18000c411:     	popq	%rbx
18000c412:     	retq
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
18000c420:     	movq	%r9, 0x20(%rsp)
18000c425:     	movq	%r8, 0x18(%rsp)
18000c42a:     	movq	%rdx, 0x10(%rsp)
18000c42f:     	movq	%rcx, 0x8(%rsp)
18000c434:     	pushq	%rbx
18000c435:     	pushq	%rbp
18000c436:     	pushq	%rsi
18000c437:     	pushq	%rdi
18000c438:     	pushq	%r12
18000c43a:     	pushq	%r13
18000c43c:     	pushq	%r14
18000c43e:     	pushq	%r15
18000c440:     	subq	$0x68, %rsp
18000c444:     	movq	%rcx, %r14
18000c447:     	movq	%r9, %r15
18000c44a:     	leaq	0x36ef(%rip), %rcx      # 0x18000fb40
18000c451:     	movq	%r8, %r13
18000c454:     	movq	%rdx, %rsi
18000c457:     	callq	*0x2ddb(%rip)           # 0x18000f238
18000c45d:     	movq	%rax, %rdi
18000c460:     	testq	%rax, %rax
18000c463:     	jne	0x18000c49c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x84bc>
18000c465:     	movq	0x2ccc(%rip), %rcx      # 0x18000f138
18000c46c:     	movq	(%rcx), %rcx
18000c46f:     	callq	*0x2d3b(%rip)           # 0x18000f1b0
18000c475:     	testl	%eax, %eax
18000c477:     	je	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c47d:     	callq	*0x2e3d(%rip)           # 0x18000f2c0
18000c483:     	leaq	0x36d6(%rip), %rcx      # 0x18000fb60
18000c48a:     	callq	*0x2da8(%rip)           # 0x18000f238
18000c490:     	movq	%rax, %rdi
18000c493:     	testq	%rax, %rax
18000c496:     	je	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c49c:     	leaq	0x36dd(%rip), %rdx      # 0x18000fb80
18000c4a3:     	movq	%rdi, %rcx
18000c4a6:     	callq	*0x2cbc(%rip)           # 0x18000f168
18000c4ac:     	movl	(%rdi), %ecx
18000c4ae:     	movq	%rax, %rbx
18000c4b1:     	testl	%ecx, %ecx
18000c4b3:     	js	0x18000c4c5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x84e5>
18000c4b5:     	subl	$0x1, %ecx
18000c4b8:     	movl	%ecx, (%rdi)
18000c4ba:     	jne	0x18000c4c5 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x84e5>
18000c4bc:     	movq	%rdi, %rcx
18000c4bf:     	callq	*0x2d03(%rip)           # 0x18000f1c8
18000c4c5:     	testq	%rbx, %rbx
18000c4c8:     	je	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c4ce:     	movq	0x2c2b(%rip), %rax      # 0x18000f100
18000c4d5:     	cmpq	%rax, 0x8(%rbx)
18000c4d9:     	je	0x18000c515 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8535>
18000c4db:     	movq	0x2dce(%rip), %rcx      # 0x18000f2b0
18000c4e2:     	leaq	0x36a7(%rip), %rdx      # 0x18000fb90
18000c4e9:     	movq	(%rcx), %rcx
18000c4ec:     	callq	*0x2db6(%rip)           # 0x18000f2a8
18000c4f2:     	movl	(%rbx), %eax
18000c4f4:     	testl	%eax, %eax
18000c4f6:     	js	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c4fc:     	subl	$0x1, %eax
18000c4ff:     	movl	%eax, (%rbx)
18000c501:     	jne	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c507:     	movq	%rbx, %rcx
18000c50a:     	callq	*0x2cb8(%rip)           # 0x18000f1c8
18000c510:     	jmp	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c515:     	xorl	%edx, %edx
18000c517:     	movq	%rbx, %rcx
18000c51a:     	callq	*0x2c88(%rip)           # 0x18000f1a8
18000c520:     	movl	(%rbx), %ecx
18000c522:     	movq	%rax, 0xa757(%rip)      # 0x180016c80
18000c529:     	testl	%ecx, %ecx
18000c52b:     	js	0x18000c544 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8564>
18000c52d:     	subl	$0x1, %ecx
18000c530:     	movl	%ecx, (%rbx)
18000c532:     	jne	0x18000c544 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8564>
18000c534:     	movq	%rbx, %rcx
18000c537:     	callq	*0x2c8b(%rip)           # 0x18000f1c8
18000c53d:     	movq	0xa73c(%rip), %rax      # 0x180016c80
18000c544:     	testq	%rax, %rax
18000c547:     	jne	0x18000c562 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8582>
18000c549:     	leaq	0x3668(%rip), %rdx      # 0x18000fbb8
18000c550:     	movq	0x2d59(%rip), %rcx      # 0x18000f2b0
18000c557:     	movq	(%rcx), %rcx
18000c55a:     	callq	*0x2d48(%rip)           # 0x18000f2a8
18000c560:     	jmp	0x18000c597 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b7>
18000c562:     	callq	*(%rax)
18000c564:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
18000c569:     	jbe	0x18000c5ca <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85ea>
18000c56b:     	movq	0x2d3e(%rip), %rax      # 0x18000f2b0
18000c572:     	movq	(%rax), %rbx
18000c575:     	movq	0xa704(%rip), %rax      # 0x180016c80
18000c57c:     	callq	*(%rax)
18000c57e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
18000c584:     	leaq	0x3655(%rip), %rdx      # 0x18000fbe0
18000c58b:     	movl	%eax, %r9d
18000c58e:     	movq	%rbx, %rcx
18000c591:     	callq	*0x2c59(%rip)           # 0x18000f1f0
18000c597:     	callq	*0x2b7b(%rip)           # 0x18000f118
18000c59d:     	movq	0x2b6c(%rip), %rcx      # 0x18000f110
18000c5a4:     	leaq	0x385d(%rip), %rdx      # 0x18000fe08
18000c5ab:     	movq	(%rcx), %rcx
18000c5ae:     	callq	*0x2cf4(%rip)           # 0x18000f2a8
18000c5b4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000c5b9:     	addq	$0x68, %rsp
18000c5bd:     	popq	%r15
18000c5bf:     	popq	%r14
18000c5c1:     	popq	%r13
18000c5c3:     	popq	%r12
18000c5c5:     	popq	%rdi
18000c5c6:     	popq	%rsi
18000c5c7:     	popq	%rbp
18000c5c8:     	popq	%rbx
18000c5c9:     	retq
18000c5ca:     	movq	0xa6af(%rip), %rax      # 0x180016c80
18000c5d1:     	callq	*0x698(%rax)
18000c5d7:     	movl	%eax, 0xa6af(%rip)      # 0x180016c8c
18000c5dd:     	cmpl	$0x10, %eax
18000c5e0:     	jge	0x18000c5fe <PyInit_rcaotr_2c76336ff39711e0671e54df+0x861e>
18000c5e2:     	movq	0x2cc7(%rip), %rcx      # 0x18000f2b0
18000c5e9:     	leaq	0x3640(%rip), %rdx      # 0x18000fc30
18000c5f0:     	movl	%eax, %r9d
18000c5f3:     	movl	$0x10, %r8d
18000c5f9:     	movq	(%rcx), %rcx
18000c5fc:     	jmp	0x18000c591 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85b1>
18000c5fe:     	movq	0xa67b(%rip), %rax      # 0x180016c80
18000c605:     	callq	*0x690(%rax)
18000c60b:     	testl	%eax, %eax
18000c60d:     	jne	0x18000c61b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x863b>
18000c60f:     	leaq	0x376a(%rip), %rdx      # 0x18000fd80
18000c616:     	jmp	0x18000c550 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8570>
18000c61b:     	cmpl	$0x1, %eax
18000c61e:     	je	0x18000c62c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x864c>
18000c620:     	leaq	0x3789(%rip), %rdx      # 0x18000fdb0
18000c627:     	jmp	0x18000c550 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8570>
18000c62c:     	leaq	0xa1ed(%rip), %rcx      # 0x180016820
18000c633:     	callq	*0x2b37(%rip)           # 0x18000f170
18000c639:     	testl	%eax, %eax
18000c63b:     	jne	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000c641:     	leaq	0x9cf8(%rip), %rcx      # 0x180016340
18000c648:     	callq	*0x2b22(%rip)           # 0x18000f170
18000c64e:     	testl	%eax, %eax
18000c650:     	jne	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000c656:     	leaq	0xa023(%rip), %rcx      # 0x180016680
18000c65d:     	callq	*0x2b0d(%rip)           # 0x18000f170
18000c663:     	testl	%eax, %eax
18000c665:     	jne	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000c66b:     	xorl	%ebx, %ebx
18000c66d:     	cmpl	%ebx, 0xa615(%rip)      # 0x180016c88
18000c673:     	jne	0x18000c6b6 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x86d6>
18000c675:     	movq	%gs:0x58, %rax
18000c67e:     	movl	0xa61c(%rip), %ecx      # 0x180016ca0
18000c684:     	movl	$0x1, 0xa5fa(%rip)      # 0x180016c88
18000c68e:     	movq	(%rax,%rcx,8), %rdx
18000c692:     	movl	$0x10, %eax
18000c697:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000c69e:     	movl	$0x9f0, %eax            # imm = 0x9F0
18000c6a3:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000c6aa:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000c6af:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000c6b6:     	movl	%ebx, 0xa57c(%rip)      # 0x180016c38
18000c6bc:     	movq	%rbx, %rax
18000c6bf:     	movb	%bl, 0xa57b(%rip)       # 0x180016c40
18000c6c5:     	movq	%rbx, %rcx
18000c6c8:     	xchgq	%rax, 0xa579(%rip)      # 0x180016c48
18000c6cf:     	xchgq	%rcx, 0xa57a(%rip)      # 0x180016c50
18000c6d6:     	movq	%rbx, %rax
18000c6d9:     	movq	%rbx, %rcx
18000c6dc:     	xchgq	%rax, 0xa575(%rip)      # 0x180016c58
18000c6e3:     	xchgq	%rcx, 0xa576(%rip)      # 0x180016c60
18000c6ea:     	movq	0x296f(%rip), %rax      # 0x18000f060
18000c6f1:     	leaq	0x9de8(%rip), %rcx      # 0x1800164e0
18000c6f8:     	movq	%rax, 0xa569(%rip)      # 0x180016c68
18000c6ff:     	movq	0x296a(%rip), %rax      # 0x18000f070
18000c706:     	movq	%rax, 0xa563(%rip)      # 0x180016c70
18000c70d:     	movq	0x2954(%rip), %rax      # 0x18000f068
18000c714:     	movq	%rax, 0xa55d(%rip)      # 0x180016c78
18000c71b:     	movq	0x2b26(%rip), %rax      # 0x18000f248
18000c722:     	movq	%rax, 0x9eef(%rip)      # 0x180016618
18000c729:     	callq	*0x2a41(%rip)           # 0x18000f170
18000c72f:     	testl	%eax, %eax
18000c731:     	jne	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000c737:     	leaq	0x37e2(%rip), %rdx      # 0x18000ff20
18000c73e:     	movq	%r14, %rcx
18000c741:     	callq	*0x2a21(%rip)           # 0x18000f168
18000c747:     	movq	%rax, 0x28(%rsp)
18000c74c:     	movq	%rax, %rdi
18000c74f:     	testq	%rax, %rax
18000c752:     	je	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000c758:     	leaq	0x395a(%rip), %rcx      # 0x1800100b9
18000c75f:     	callq	*0x2b1b(%rip)           # 0x18000f280
18000c765:     	movq	%rax, 0x20(%rsp)
18000c76a:     	movq	%rax, %r12
18000c76d:     	testq	%rax, %rax
18000c770:     	je	0x18000cab4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ad4>
18000c776:     	movl	%ebx, %ebp
18000c778:     	cmpq	%rbx, (%rsi)
18000c77b:     	je	0x18000c924 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8944>
18000c781:     	movslq	%ebp, %rbx
18000c784:     	leaq	0x30(%rsp), %rdx
18000c789:     	movq	%r14, %rcx
18000c78c:     	leaq	(%rbx,%rbx,4), %rax
18000c790:     	movups	(%r13,%rax,8), %xmm0
18000c796:     	movups	0x10(%r13,%rax,8), %xmm1
18000c79c:     	movaps	%xmm0, 0x30(%rsp)
18000c7a1:     	movsd	0x20(%r13,%rax,8), %xmm0
18000c7a8:     	movsd	%xmm0, 0x50(%rsp)
18000c7ae:     	movaps	%xmm1, 0x40(%rsp)
18000c7b3:     	callq	0x18000c2b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x82d0>
18000c7b8:     	movq	%rax, %r14
18000c7bb:     	testq	%rax, %rax
18000c7be:     	je	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000c7c4:     	movq	(%rsi), %rcx
18000c7c7:     	callq	*0x2ab3(%rip)           # 0x18000f280
18000c7cd:     	movq	%rax, %r13
18000c7d0:     	testq	%rax, %rax
18000c7d3:     	je	0x18000cad7 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8af7>
18000c7d9:     	movq	(%r15,%rbx,8), %rcx
18000c7dd:     	xorl	%edx, %edx
18000c7df:     	movq	%r14, (%rcx)
18000c7e2:     	leaq	0xa037(%rip), %rcx      # 0x180016820
18000c7e9:     	movq	0x8(%rsi), %r12
18000c7ed:     	callq	*0x295d(%rip)           # 0x18000f150
18000c7f3:     	movq	%rax, %rbx
18000c7f6:     	testq	%rax, %rax
18000c7f9:     	je	0x18000c876 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8896>
18000c7fb:     	movq	%r13, %rcx
18000c7fe:     	callq	*0x297c(%rip)           # 0x18000f180
18000c804:     	movq	%rax, %rdi
18000c807:     	testq	%rax, %rax
18000c80a:     	je	0x18000c82c <PyInit_rcaotr_2c76336ff39711e0671e54df+0x884c>
18000c80c:     	movq	%rax, %rcx
18000c80f:     	callq	0x18000e0b5 <numba_list_iter_next+0xed5>
18000c814:     	leaq	0x1(%rax), %rcx
18000c818:     	callq	*0x2a32(%rip)           # 0x18000f250
18000c81e:     	movq	%rax, %rsi
18000c821:     	testq	%rax, %rax
18000c824:     	jne	0x18000c834 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8854>
18000c826:     	callq	*0x2914(%rip)           # 0x18000f140
18000c82c:     	xorl	%eax, %eax
18000c82e:     	movq	%rax, 0x20(%rbx)
18000c832:     	jmp	0x18000c865 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8885>
18000c834:     	movq	%rdi, %rdx
18000c837:     	movq	%rsi, %rcx
18000c83a:     	callq	0x18000e0af <numba_list_iter_next+0xecf>
18000c83f:     	movq	0x20(%rsp), %rcx
18000c844:     	movq	%rsi, 0x20(%rbx)
18000c848:     	movq	%r12, 0x28(%rbx)
18000c84c:     	movl	$0x3, 0x30(%rbx)
18000c853:     	callq	0x18000bd30 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x7d50>
18000c858:     	movq	%rax, 0x38(%rbx)
18000c85c:     	testq	%rax, %rax
18000c85f:     	jne	0x18000c9d0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89f0>
18000c865:     	movl	(%rbx), %eax
18000c867:     	testl	%eax, %eax
18000c869:     	js	0x18000c876 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8896>
18000c86b:     	subl	$0x1, %eax
18000c86e:     	movl	%eax, (%rbx)
18000c870:     	je	0x18000ca1d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8a3d>
18000c876:     	xorl	%edi, %edi
18000c878:     	movl	(%r14), %eax
18000c87b:     	testl	%eax, %eax
18000c87d:     	js	0x18000c890 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x88b0>
18000c87f:     	subl	$0x1, %eax
18000c882:     	movl	%eax, (%r14)
18000c885:     	jne	0x18000c890 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x88b0>
18000c887:     	movq	%r14, %rcx
18000c88a:     	callq	*0x2938(%rip)           # 0x18000f1c8
18000c890:     	movl	(%r13), %eax
18000c894:     	testl	%eax, %eax
18000c896:     	js	0x18000c8aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x88ca>
18000c898:     	subl	$0x1, %eax
18000c89b:     	movl	%eax, (%r13)
18000c89f:     	jne	0x18000c8aa <PyInit_rcaotr_2c76336ff39711e0671e54df+0x88ca>
18000c8a1:     	movq	%r13, %rcx
18000c8a4:     	callq	*0x291e(%rip)           # 0x18000f1c8
18000c8aa:     	testq	%rdi, %rdi
18000c8ad:     	je	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000c8b3:     	movq	0xb8(%rsp), %rsi
18000c8bb:     	movq	%rdi, %r8
18000c8be:     	movq	0xb0(%rsp), %r14
18000c8c6:     	movq	%r14, %rcx
18000c8c9:     	movq	(%rsi), %rdx
18000c8cc:     	callq	*0x294e(%rip)           # 0x18000f220
18000c8d2:     	movl	(%rdi), %ecx
18000c8d4:     	testl	%eax, %eax
18000c8d6:     	jne	0x18000ca7a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8a9a>
18000c8dc:     	testl	%ecx, %ecx
18000c8de:     	js	0x18000c8f2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8912>
18000c8e0:     	leal	-0x1(%rcx), %eax
18000c8e3:     	movl	%eax, (%rdi)
18000c8e5:     	testl	%eax, %eax
18000c8e7:     	jne	0x18000c8f2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8912>
18000c8e9:     	movq	%rdi, %rcx
18000c8ec:     	callq	*0x28d6(%rip)           # 0x18000f1c8
18000c8f2:     	movq	0xc8(%rsp), %r15
18000c8fa:     	addq	$0x20, %rsi
18000c8fe:     	movq	0xc0(%rsp), %r13
18000c906:     	incl	%ebp
18000c908:     	movq	%rsi, 0xb8(%rsp)
18000c910:     	cmpq	$0x0, (%rsi)
18000c914:     	jne	0x18000c781 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x87a1>
18000c91a:     	movq	0x20(%rsp), %r12
18000c91f:     	movq	0x28(%rsp), %rdi
18000c924:     	movslq	%ebp, %rax
18000c927:     	cmpq	$0x0, (%r15,%rax,8)
18000c92c:     	je	0x18000c999 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89b9>
18000c92e:     	nop
18000c930:     	movslq	%ebp, %rbx
18000c933:     	leaq	0x30(%rsp), %rdx
18000c938:     	movq	%r14, %rcx
18000c93b:     	leaq	(%rbx,%rbx,4), %rax
18000c93f:     	movups	(%r13,%rax,8), %xmm0
18000c945:     	movups	0x10(%r13,%rax,8), %xmm1
18000c94b:     	movaps	%xmm0, 0x30(%rsp)
18000c950:     	movsd	0x20(%r13,%rax,8), %xmm0
18000c957:     	movsd	%xmm0, 0x50(%rsp)
18000c95d:     	movaps	%xmm1, 0x40(%rsp)
18000c962:     	callq	0x18000c2b0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x82d0>
18000c967:     	testq	%rax, %rax
18000c96a:     	je	0x18000ca95 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab5>
18000c970:     	movq	(%r15,%rbx,8), %rcx
18000c974:     	movq	%rax, (%rcx)
18000c977:     	movl	(%rax), %ecx
18000c979:     	testl	%ecx, %ecx
18000c97b:     	js	0x18000c98d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89ad>
18000c97d:     	subl	$0x1, %ecx
18000c980:     	movl	%ecx, (%rax)
18000c982:     	jne	0x18000c98d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89ad>
18000c984:     	movq	%rax, %rcx
18000c987:     	callq	*0x283b(%rip)           # 0x18000f1c8
18000c98d:     	incl	%ebp
18000c98f:     	movslq	%ebp, %rax
18000c992:     	cmpq	$0x0, (%r15,%rax,8)
18000c997:     	jne	0x18000c930 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8950>
18000c999:     	movl	(%r12), %eax
18000c99d:     	testl	%eax, %eax
18000c99f:     	js	0x18000c9b3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89d3>
18000c9a1:     	subl	$0x1, %eax
18000c9a4:     	movl	%eax, (%r12)
18000c9a8:     	jne	0x18000c9b3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89d3>
18000c9aa:     	movq	%r12, %rcx
18000c9ad:     	callq	*0x2815(%rip)           # 0x18000f1c8
18000c9b3:     	movl	(%rdi), %eax
18000c9b5:     	testl	%eax, %eax
18000c9b7:     	js	0x18000c9c9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89e9>
18000c9b9:     	subl	$0x1, %eax
18000c9bc:     	movl	%eax, (%rdi)
18000c9be:     	jne	0x18000c9c9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89e9>
18000c9c0:     	movq	%rdi, %rcx
18000c9c3:     	callq	*0x27ff(%rip)           # 0x18000f1c8
18000c9c9:     	xorl	%eax, %eax
18000c9cb:     	jmp	0x18000c5b9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d9>
18000c9d0:     	movl	(%r14), %eax
18000c9d3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000c9d8:     	jae	0x18000c9df <PyInit_rcaotr_2c76336ff39711e0671e54df+0x89ff>
18000c9da:     	incl	%eax
18000c9dc:     	movl	%eax, (%r14)
18000c9df:     	movq	0xb0(%rsp), %rcx
18000c9e7:     	leaq	0x3532(%rip), %rdx      # 0x18000ff20
18000c9ee:     	movq	%r14, 0x18(%rbx)
18000c9f2:     	movq	$0x0, 0x40(%rbx)
18000c9fa:     	callq	*0x2768(%rip)           # 0x18000f168
18000ca00:     	movq	%rax, %rsi
18000ca03:     	testq	%rax, %rax
18000ca06:     	jne	0x18000ca2b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8a4b>
18000ca08:     	movl	(%rbx), %eax
18000ca0a:     	testl	%eax, %eax
18000ca0c:     	js	0x18000c876 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8896>
18000ca12:     	subl	$0x1, %eax
18000ca15:     	movl	%eax, (%rbx)
18000ca17:     	jne	0x18000c876 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8896>
18000ca1d:     	movq	%rbx, %rcx
18000ca20:     	callq	*0x27a2(%rip)           # 0x18000f1c8
18000ca26:     	jmp	0x18000c876 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8896>
18000ca2b:     	xorl	%r9d, %r9d
18000ca2e:     	leaq	0x20(%rbx), %rcx
18000ca32:     	movq	%rsi, %r8
18000ca35:     	movq	%rbx, %rdx
18000ca38:     	callq	*0x270a(%rip)           # 0x18000f148
18000ca3e:     	movq	%rax, %rdi
18000ca41:     	movl	(%rbx), %eax
18000ca43:     	testl	%eax, %eax
18000ca45:     	js	0x18000ca57 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8a77>
18000ca47:     	subl	$0x1, %eax
18000ca4a:     	movl	%eax, (%rbx)
18000ca4c:     	jne	0x18000ca57 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8a77>
18000ca4e:     	movq	%rbx, %rcx
18000ca51:     	callq	*0x2771(%rip)           # 0x18000f1c8
18000ca57:     	movl	(%rsi), %eax
18000ca59:     	testl	%eax, %eax
18000ca5b:     	js	0x18000c878 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8898>
18000ca61:     	subl	$0x1, %eax
18000ca64:     	movl	%eax, (%rsi)
18000ca66:     	jne	0x18000c878 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8898>
18000ca6c:     	movq	%rsi, %rcx
18000ca6f:     	callq	*0x2753(%rip)           # 0x18000f1c8
18000ca75:     	jmp	0x18000c878 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8898>
18000ca7a:     	testl	%ecx, %ecx
18000ca7c:     	js	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000ca7e:     	leal	-0x1(%rcx), %eax
18000ca81:     	movl	%eax, (%rdi)
18000ca83:     	testl	%eax, %eax
18000ca85:     	jne	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000ca87:     	movq	%rdi, %rcx
18000ca8a:     	callq	*0x2738(%rip)           # 0x18000f1c8
18000ca90:     	movq	0x20(%rsp), %r12
18000ca95:     	movl	(%r12), %eax
18000ca99:     	testl	%eax, %eax
18000ca9b:     	js	0x18000caaf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8acf>
18000ca9d:     	subl	$0x1, %eax
18000caa0:     	movl	%eax, (%r12)
18000caa4:     	jne	0x18000caaf <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8acf>
18000caa6:     	movq	%r12, %rcx
18000caa9:     	callq	*0x2719(%rip)           # 0x18000f1c8
18000caaf:     	movq	0x28(%rsp), %rdi
18000cab4:     	movl	(%rdi), %eax
18000cab6:     	testl	%eax, %eax
18000cab8:     	js	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000cabe:     	subl	$0x1, %eax
18000cac1:     	movl	%eax, (%rdi)
18000cac3:     	jne	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000cac9:     	movq	%rdi, %rcx
18000cacc:     	callq	*0x26f6(%rip)           # 0x18000f1c8
18000cad2:     	jmp	0x18000c5b4 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x85d4>
18000cad7:     	movl	(%r14), %eax
18000cada:     	testl	%eax, %eax
18000cadc:     	js	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000cade:     	subl	$0x1, %eax
18000cae1:     	movl	%eax, (%r14)
18000cae4:     	jne	0x18000ca90 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8ab0>
18000cae6:     	movq	%r14, %rcx
18000cae9:     	jmp	0x18000ca8a <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8aaa>
18000caeb:     	int3
18000caec:     	int3
18000caed:     	int3
18000caee:     	int3
18000caef:     	int3
18000caf0:     	leaq	0xa1e9(%rip), %rax      # 0x180016ce0
18000caf7:     	retq
18000caf8:     	int3
18000caf9:     	int3
18000cafa:     	int3
18000cafb:     	int3
18000cafc:     	int3
18000cafd:     	int3
18000cafe:     	int3
18000caff:     	int3

000000018000cb00 <numba_list_set_method_table>:
18000cb00:     	movups	(%rdx), %xmm0
18000cb03:     	movups	%xmm0, 0x20(%rcx)
18000cb07:     	retq
18000cb08:     	int3
18000cb09:     	int3
18000cb0a:     	int3
18000cb0b:     	int3
18000cb0c:     	int3
18000cb0d:     	int3
18000cb0e:     	int3
18000cb0f:     	int3

000000018000cb10 <numba_list_new>:
18000cb10:     	pushq	%rbx
18000cb12:     	pushq	%rbp
18000cb13:     	pushq	%rsi
18000cb14:     	pushq	%rdi
18000cb15:     	subq	$0x28, %rsp
18000cb19:     	movq	%rcx, %rsi
18000cb1c:     	movq	%r8, %rdi
18000cb1f:     	movl	$0x38, %ecx
18000cb24:     	movq	%rdx, %rbp
18000cb27:     	callq	*0x2533(%rip)           # 0x18000f060
18000cb2d:     	movq	%rax, %rbx
18000cb30:     	testq	%rax, %rax
18000cb33:     	je	0x18000cb9d <numba_list_new+0x8d>
18000cb35:     	movq	$0x0, (%rax)
18000cb3c:     	xorps	%xmm0, %xmm0
18000cb3f:     	movq	%rbp, 0x8(%rax)
18000cb43:     	movq	%rdi, 0x10(%rax)
18000cb47:     	movl	$0x1, 0x18(%rax)
18000cb4e:     	movups	%xmm0, 0x20(%rax)
18000cb52:     	testq	%rdi, %rdi
18000cb55:     	je	0x18000cbab <numba_list_new+0x9b>
18000cb57:     	imulq	%rbp, %rdi
18000cb5b:     	movl	$0x8, %ecx
18000cb60:     	movq	%rdi, %rax
18000cb63:     	cqto
18000cb65:     	andl	$0x7, %edx
18000cb68:     	addq	%rdx, %rax
18000cb6b:     	andl	$0x7, %eax
18000cb6e:     	subq	%rdx, %rax
18000cb71:     	subq	%rax, %rcx
18000cb74:     	movq	%rcx, %rax
18000cb77:     	cqto
18000cb79:     	andl	$0x7, %edx
18000cb7c:     	leaq	(%rdx,%rax), %rcx
18000cb80:     	andl	$0x7, %ecx
18000cb83:     	subq	%rdx, %rcx
18000cb86:     	addq	%rdi, %rcx
18000cb89:     	callq	*0x24d1(%rip)           # 0x18000f060
18000cb8f:     	testq	%rax, %rax
18000cb92:     	jne	0x18000cbad <numba_list_new+0x9d>
18000cb94:     	movq	%rbx, %rcx
18000cb97:     	callq	*0x24cb(%rip)           # 0x18000f068
18000cb9d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000cba2:     	addq	$0x28, %rsp
18000cba6:     	popq	%rdi
18000cba7:     	popq	%rsi
18000cba8:     	popq	%rbp
18000cba9:     	popq	%rbx
18000cbaa:     	retq
18000cbab:     	xorl	%eax, %eax
18000cbad:     	movq	%rax, 0x30(%rbx)
18000cbb1:     	xorl	%eax, %eax
18000cbb3:     	movq	%rbx, (%rsi)
18000cbb6:     	addq	$0x28, %rsp
18000cbba:     	popq	%rdi
18000cbbb:     	popq	%rsi
18000cbbc:     	popq	%rbp
18000cbbd:     	popq	%rbx
18000cbbe:     	retq
18000cbbf:     	int3

000000018000cbc0 <numba_list_free>:
18000cbc0:     	pushq	%rbx
18000cbc2:     	subq	$0x20, %rsp
18000cbc6:     	cmpq	$0x0, 0x28(%rcx)
18000cbcb:     	movq	%rcx, %rbx
18000cbce:     	je	0x18000cc04 <numba_list_free+0x44>
18000cbd0:     	movq	%rdi, 0x30(%rsp)
18000cbd5:     	xorl	%edi, %edi
18000cbd7:     	cmpq	%rdi, (%rcx)
18000cbda:     	jle	0x18000cbff <numba_list_free+0x3f>
18000cbdc:     	nopl	(%rax)
18000cbe0:     	movq	0x28(%rbx), %rax
18000cbe4:     	testq	%rax, %rax
18000cbe7:     	je	0x18000cbf7 <numba_list_free+0x37>
18000cbe9:     	movq	%rdi, %rcx
18000cbec:     	imulq	0x8(%rbx), %rcx
18000cbf1:     	addq	0x30(%rbx), %rcx
18000cbf5:     	callq	*%rax
18000cbf7:     	incq	%rdi
18000cbfa:     	cmpq	(%rbx), %rdi
18000cbfd:     	jl	0x18000cbe0 <numba_list_free+0x20>
18000cbff:     	movq	0x30(%rsp), %rdi
18000cc04:     	movq	0x30(%rbx), %rcx
18000cc08:     	testq	%rcx, %rcx
18000cc0b:     	je	0x18000cc13 <numba_list_free+0x53>
18000cc0d:     	callq	*0x2455(%rip)           # 0x18000f068
18000cc13:     	movq	%rbx, %rcx
18000cc16:     	addq	$0x20, %rsp
18000cc1a:     	popq	%rbx
18000cc1b:     	jmpq	*0x2446(%rip)           # 0x18000f068
18000cc22:     	int3
18000cc23:     	int3
18000cc24:     	int3
18000cc25:     	int3
18000cc26:     	int3
18000cc27:     	int3
18000cc28:     	int3
18000cc29:     	int3
18000cc2a:     	int3
18000cc2b:     	int3
18000cc2c:     	int3
18000cc2d:     	int3
18000cc2e:     	int3
18000cc2f:     	int3

000000018000cc30 <numba_list_base_ptr>:
18000cc30:     	movq	0x30(%rcx), %rax
18000cc34:     	retq
18000cc35:     	int3
18000cc36:     	int3
18000cc37:     	int3
18000cc38:     	int3
18000cc39:     	int3
18000cc3a:     	int3
18000cc3b:     	int3
18000cc3c:     	int3
18000cc3d:     	int3
18000cc3e:     	int3
18000cc3f:     	int3

000000018000cc40 <numba_list_size_address>:
18000cc40:     	movq	%rcx, %rax
18000cc43:     	retq
18000cc44:     	int3
18000cc45:     	int3
18000cc46:     	int3
18000cc47:     	int3
18000cc48:     	int3
18000cc49:     	int3
18000cc4a:     	int3
18000cc4b:     	int3
18000cc4c:     	int3
18000cc4d:     	int3
18000cc4e:     	int3
18000cc4f:     	int3

000000018000cc50 <numba_list_length>:
18000cc50:     	movq	(%rcx), %rax
18000cc53:     	retq
18000cc54:     	int3
18000cc55:     	int3
18000cc56:     	int3
18000cc57:     	int3
18000cc58:     	int3
18000cc59:     	int3
18000cc5a:     	int3
18000cc5b:     	int3
18000cc5c:     	int3
18000cc5d:     	int3
18000cc5e:     	int3
18000cc5f:     	int3

000000018000cc60 <numba_list_allocated>:
18000cc60:     	movq	0x10(%rcx), %rax
18000cc64:     	retq
18000cc65:     	int3
18000cc66:     	int3
18000cc67:     	int3
18000cc68:     	int3
18000cc69:     	int3
18000cc6a:     	int3
18000cc6b:     	int3
18000cc6c:     	int3
18000cc6d:     	int3
18000cc6e:     	int3
18000cc6f:     	int3

000000018000cc70 <numba_list_is_mutable>:
18000cc70:     	movl	0x18(%rcx), %eax
18000cc73:     	retq
18000cc74:     	int3
18000cc75:     	int3
18000cc76:     	int3
18000cc77:     	int3
18000cc78:     	int3
18000cc79:     	int3
18000cc7a:     	int3
18000cc7b:     	int3
18000cc7c:     	int3
18000cc7d:     	int3
18000cc7e:     	int3
18000cc7f:     	int3

000000018000cc80 <numba_list_set_is_mutable>:
18000cc80:     	movl	%edx, 0x18(%rcx)
18000cc83:     	retq
18000cc84:     	int3
18000cc85:     	int3
18000cc86:     	int3
18000cc87:     	int3
18000cc88:     	int3
18000cc89:     	int3
18000cc8a:     	int3
18000cc8b:     	int3
18000cc8c:     	int3
18000cc8d:     	int3
18000cc8e:     	int3
18000cc8f:     	int3

000000018000cc90 <numba_list_setitem>:
18000cc90:     	movq	%rbx, 0x10(%rsp)
18000cc95:     	pushq	%rsi
18000cc96:     	subq	$0x20, %rsp
18000cc9a:     	cmpl	$0x0, 0x18(%rcx)
18000cc9e:     	movq	%r8, %rsi
18000cca1:     	movq	%rcx, %rbx
18000cca4:     	jne	0x18000ccb6 <numba_list_setitem+0x26>
18000cca6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000ccab:     	movq	0x38(%rsp), %rbx
18000ccb0:     	addq	$0x20, %rsp
18000ccb4:     	popq	%rsi
18000ccb5:     	retq
18000ccb6:     	cmpq	(%rcx), %rdx
18000ccb9:     	jb	0x18000cccb <numba_list_setitem+0x3b>
18000ccbb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000ccc0:     	movq	0x38(%rsp), %rbx
18000ccc5:     	addq	$0x20, %rsp
18000ccc9:     	popq	%rsi
18000ccca:     	retq
18000cccb:     	imulq	0x8(%rcx), %rdx
18000ccd0:     	movq	0x28(%rcx), %rax
18000ccd4:     	movq	%rdi, 0x30(%rsp)
18000ccd9:     	movq	0x30(%rcx), %rdi
18000ccdd:     	addq	%rdx, %rdi
18000cce0:     	testq	%rax, %rax
18000cce3:     	je	0x18000ccea <numba_list_setitem+0x5a>
18000cce5:     	movq	%rdi, %rcx
18000cce8:     	callq	*%rax
18000ccea:     	movq	0x8(%rbx), %r8
18000ccee:     	movq	%rsi, %rdx
18000ccf1:     	movq	%rdi, %rcx
18000ccf4:     	callq	0x18000e0a3 <numba_list_iter_next+0xec3>
18000ccf9:     	movq	0x20(%rbx), %rax
18000ccfd:     	testq	%rax, %rax
18000cd00:     	je	0x18000cd07 <numba_list_setitem+0x77>
18000cd02:     	movq	%rdi, %rcx
18000cd05:     	callq	*%rax
18000cd07:     	movq	0x30(%rsp), %rdi
18000cd0c:     	xorl	%eax, %eax
18000cd0e:     	movq	0x38(%rsp), %rbx
18000cd13:     	addq	$0x20, %rsp
18000cd17:     	popq	%rsi
18000cd18:     	retq
18000cd19:     	int3
18000cd1a:     	int3
18000cd1b:     	int3
18000cd1c:     	int3
18000cd1d:     	int3
18000cd1e:     	int3
18000cd1f:     	int3

000000018000cd20 <numba_list_getitem>:
18000cd20:     	subq	$0x28, %rsp
18000cd24:     	movq	%r8, %r9
18000cd27:     	movq	%rdx, %rax
18000cd2a:     	cmpq	(%rcx), %rdx
18000cd2d:     	jb	0x18000cd39 <numba_list_getitem+0x19>
18000cd2f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000cd34:     	addq	$0x28, %rsp
18000cd38:     	retq
18000cd39:     	movq	0x8(%rcx), %r8
18000cd3d:     	movq	%r8, %rdx
18000cd40:     	imulq	%rax, %rdx
18000cd44:     	addq	0x30(%rcx), %rdx
18000cd48:     	movq	%r9, %rcx
18000cd4b:     	callq	0x18000e0a3 <numba_list_iter_next+0xec3>
18000cd50:     	xorl	%eax, %eax
18000cd52:     	addq	$0x28, %rsp
18000cd56:     	retq
18000cd57:     	int3
18000cd58:     	int3
18000cd59:     	int3
18000cd5a:     	int3
18000cd5b:     	int3
18000cd5c:     	int3
18000cd5d:     	int3
18000cd5e:     	int3
18000cd5f:     	int3

000000018000cd60 <numba_list_append>:
18000cd60:     	movq	%rbx, 0x10(%rsp)
18000cd65:     	pushq	%rsi
18000cd66:     	subq	$0x20, %rsp
18000cd6a:     	cmpl	$0x0, 0x18(%rcx)
18000cd6e:     	movq	%rdx, %rsi
18000cd71:     	movq	%rcx, %rbx
18000cd74:     	jne	0x18000cd86 <numba_list_append+0x26>
18000cd76:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000cd7b:     	movq	0x38(%rsp), %rbx
18000cd80:     	addq	$0x20, %rsp
18000cd84:     	popq	%rsi
18000cd85:     	retq
18000cd86:     	movq	(%rcx), %rdx
18000cd89:     	incq	%rdx
18000cd8c:     	callq	0x18000cde0 <numba_list_resize>
18000cd91:     	testl	%eax, %eax
18000cd93:     	js	0x18000cdcc <numba_list_append+0x6c>
18000cd95:     	movq	0x8(%rbx), %r8
18000cd99:     	movq	%rsi, %rdx
18000cd9c:     	movq	%rdi, 0x30(%rsp)
18000cda1:     	movq	(%rbx), %rdi
18000cda4:     	decq	%rdi
18000cda7:     	imulq	%r8, %rdi
18000cdab:     	addq	0x30(%rbx), %rdi
18000cdaf:     	movq	%rdi, %rcx
18000cdb2:     	callq	0x18000e0a3 <numba_list_iter_next+0xec3>
18000cdb7:     	movq	0x20(%rbx), %rax
18000cdbb:     	testq	%rax, %rax
18000cdbe:     	je	0x18000cdc5 <numba_list_append+0x65>
18000cdc0:     	movq	%rdi, %rcx
18000cdc3:     	callq	*%rax
18000cdc5:     	movq	0x30(%rsp), %rdi
18000cdca:     	xorl	%eax, %eax
18000cdcc:     	movq	0x38(%rsp), %rbx
18000cdd1:     	addq	$0x20, %rsp
18000cdd5:     	popq	%rsi
18000cdd6:     	retq
18000cdd7:     	int3
18000cdd8:     	int3
18000cdd9:     	int3
18000cdda:     	int3
18000cddb:     	int3
18000cddc:     	int3
18000cddd:     	int3
18000cdde:     	int3
18000cddf:     	int3

000000018000cde0 <numba_list_resize>:
18000cde0:     	movq	%rsi, 0x18(%rsp)
18000cde5:     	pushq	%rdi
18000cde6:     	subq	$0x20, %rsp
18000cdea:     	cmpl	$0x0, 0x18(%rcx)
18000cdee:     	movq	%rdx, %rsi
18000cdf1:     	movq	%rcx, %rdi
18000cdf4:     	jne	0x18000ce06 <numba_list_resize+0x26>
18000cdf6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000cdfb:     	movq	0x40(%rsp), %rsi
18000ce00:     	addq	$0x20, %rsp
18000ce04:     	popq	%rdi
18000ce05:     	retq
18000ce06:     	movq	0x10(%rcx), %rax
18000ce0a:     	cmpq	%rsi, %rax
18000ce0d:     	jl	0x18000ce27 <numba_list_resize+0x47>
18000ce0f:     	sarq	%rax
18000ce12:     	cmpq	%rax, %rsi
18000ce15:     	jl	0x18000ce27 <numba_list_resize+0x47>
18000ce17:     	movq	%rsi, (%rcx)
18000ce1a:     	xorl	%eax, %eax
18000ce1c:     	movq	0x40(%rsp), %rsi
18000ce21:     	addq	$0x20, %rsp
18000ce25:     	popq	%rdi
18000ce26:     	retq
18000ce27:     	cmpq	$0x9, %rsi
18000ce2b:     	movq	%rbp, 0x38(%rsp)
18000ce30:     	movl	$0x3, %ecx
18000ce35:     	movl	$0x6, %eax
18000ce3a:     	cmovll	%ecx, %eax
18000ce3d:     	movq	%rsi, %r8
18000ce40:     	movq	0x8(%rdi), %rcx
18000ce44:     	addq	%rsi, %rax
18000ce47:     	sarq	$0x3, %r8
18000ce4b:     	xorl	%edx, %edx
18000ce4d:     	addq	%rax, %r8
18000ce50:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000ce5a:     	divq	%rcx
18000ce5d:     	cmpq	%rax, %r8
18000ce60:     	ja	0x18000cedb <numba_list_resize+0xfb>
18000ce62:     	xorl	%ebp, %ebp
18000ce64:     	movq	%rbx, 0x30(%rsp)
18000ce69:     	testq	%rsi, %rsi
18000ce6c:     	cmovneq	%r8, %rbp
18000ce70:     	movq	%rbp, %rbx
18000ce73:     	imulq	%rcx, %rbx
18000ce77:     	movl	$0x8, %ecx
18000ce7c:     	movq	%rbx, %rax
18000ce7f:     	cqto
18000ce81:     	andl	$0x7, %edx
18000ce84:     	addq	%rdx, %rax
18000ce87:     	andl	$0x7, %eax
18000ce8a:     	subq	%rdx, %rax
18000ce8d:     	subq	%rax, %rcx
18000ce90:     	movq	%rcx, %rax
18000ce93:     	movq	0x30(%rdi), %rcx
18000ce97:     	cqto
18000ce99:     	andl	$0x7, %edx
18000ce9c:     	addq	%rdx, %rax
18000ce9f:     	andl	$0x7, %eax
18000cea2:     	subq	%rdx, %rax
18000cea5:     	leaq	(%rbx,%rax), %rdx
18000cea9:     	callq	*0x21c1(%rip)           # 0x18000f070
18000ceaf:     	testq	%rbx, %rbx
18000ceb2:     	movq	0x30(%rsp), %rbx
18000ceb7:     	je	0x18000cebe <numba_list_resize+0xde>
18000ceb9:     	testq	%rax, %rax
18000cebc:     	je	0x18000cedb <numba_list_resize+0xfb>
18000cebe:     	movq	%rax, 0x30(%rdi)
18000cec2:     	xorl	%eax, %eax
18000cec4:     	movq	%rbp, 0x10(%rdi)
18000cec8:     	movq	0x38(%rsp), %rbp
18000cecd:     	movq	%rsi, (%rdi)
18000ced0:     	movq	0x40(%rsp), %rsi
18000ced5:     	addq	$0x20, %rsp
18000ced9:     	popq	%rdi
18000ceda:     	retq
18000cedb:     	movq	0x38(%rsp), %rbp
18000cee0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000cee5:     	movq	0x40(%rsp), %rsi
18000ceea:     	addq	$0x20, %rsp
18000ceee:     	popq	%rdi
18000ceef:     	retq

000000018000cef0 <numba_list_delitem>:
18000cef0:     	movq	%rbx, 0x10(%rsp)
18000cef5:     	pushq	%rdi
18000cef6:     	subq	$0x20, %rsp
18000cefa:     	cmpl	$0x0, 0x18(%rcx)
18000cefe:     	movq	%rdx, %rdi
18000cf01:     	movq	%rcx, %rbx
18000cf04:     	jne	0x18000cf16 <numba_list_delitem+0x26>
18000cf06:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000cf0b:     	movq	0x38(%rsp), %rbx
18000cf10:     	addq	$0x20, %rsp
18000cf14:     	popq	%rdi
18000cf15:     	retq
18000cf16:     	cmpq	(%rcx), %rdi
18000cf19:     	jb	0x18000cf2b <numba_list_delitem+0x3b>
18000cf1b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000cf20:     	movq	0x38(%rsp), %rbx
18000cf25:     	addq	$0x20, %rsp
18000cf29:     	popq	%rdi
18000cf2a:     	retq
18000cf2b:     	movq	0x28(%rcx), %rax
18000cf2f:     	movq	%rsi, 0x30(%rsp)
18000cf34:     	movq	%rdi, %rsi
18000cf37:     	imulq	0x8(%rcx), %rsi
18000cf3c:     	addq	0x30(%rcx), %rsi
18000cf40:     	testq	%rax, %rax
18000cf43:     	je	0x18000cf4a <numba_list_delitem+0x5a>
18000cf45:     	movq	%rsi, %rcx
18000cf48:     	callq	*%rax
18000cf4a:     	movq	(%rbx), %r8
18000cf4d:     	leaq	-0x1(%r8), %rax
18000cf51:     	cmpq	%rax, %rdi
18000cf54:     	je	0x18000cf76 <numba_list_delitem+0x86>
18000cf56:     	subq	%rdi, %r8
18000cf59:     	leaq	0x1(%rdi), %rdx
18000cf5d:     	imulq	0x8(%rbx), %rdx
18000cf62:     	decq	%r8
18000cf65:     	movq	%rsi, %rcx
18000cf68:     	imulq	0x8(%rbx), %r8
18000cf6d:     	addq	0x30(%rbx), %rdx
18000cf71:     	callq	0x18000e0a9 <numba_list_iter_next+0xec9>
18000cf76:     	movq	(%rbx), %rdx
18000cf79:     	movq	%rbx, %rcx
18000cf7c:     	decq	%rdx
18000cf7f:     	callq	0x18000cde0 <numba_list_resize>
18000cf84:     	movq	0x30(%rsp), %rsi
18000cf89:     	xorl	%ecx, %ecx
18000cf8b:     	movq	0x38(%rsp), %rbx
18000cf90:     	testl	%eax, %eax
18000cf92:     	cmovsl	%eax, %ecx
18000cf95:     	movl	%ecx, %eax
18000cf97:     	addq	$0x20, %rsp
18000cf9b:     	popq	%rdi
18000cf9c:     	retq
18000cf9d:     	int3
18000cf9e:     	int3
18000cf9f:     	int3

000000018000cfa0 <numba_list_delete_slice>:
18000cfa0:     	pushq	%rbx
18000cfa2:     	pushq	%rbp
18000cfa3:     	pushq	%rdi
18000cfa4:     	pushq	%r15
18000cfa6:     	subq	$0x38, %rsp
18000cfaa:     	cmpl	$0x0, 0x18(%rcx)
18000cfae:     	movq	%r9, %rdi
18000cfb1:     	movq	%r8, %rbp
18000cfb4:     	movq	%rdx, %r15
18000cfb7:     	movq	%rcx, %rbx
18000cfba:     	jne	0x18000cfcb <numba_list_delete_slice+0x2b>
18000cfbc:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000cfc1:     	addq	$0x38, %rsp
18000cfc5:     	popq	%r15
18000cfc7:     	popq	%rdi
18000cfc8:     	popq	%rbp
18000cfc9:     	popq	%rbx
18000cfca:     	retq
18000cfcb:     	movq	%r13, 0x78(%rsp)
18000cfd0:     	testq	%rdi, %rdi
18000cfd3:     	jle	0x18000cff2 <numba_list_delete_slice+0x52>
18000cfd5:     	cmpq	%r8, %r15
18000cfd8:     	jge	0x18000d191 <numba_list_delete_slice+0x1f1>
18000cfde:     	movq	%r8, %rax
18000cfe1:     	subq	%r15, %rax
18000cfe4:     	decq	%rax
18000cfe7:     	cqto
18000cfe9:     	idivq	%rdi
18000cfec:     	leal	0x1(%rax), %r13d
18000cff0:     	jmp	0x18000d012 <numba_list_delete_slice+0x72>
18000cff2:     	cmpq	%r15, %r8
18000cff5:     	jge	0x18000d191 <numba_list_delete_slice+0x1f1>
18000cffb:     	movq	%r15, %rax
18000cffe:     	movl	$0x1, %r13d
18000d004:     	subq	%r8, %rax
18000d007:     	decq	%rax
18000d00a:     	cqto
18000d00c:     	idivq	%rdi
18000d00f:     	subl	%eax, %r13d
18000d012:     	testl	%r13d, %r13d
18000d015:     	jle	0x18000d191 <numba_list_delete_slice+0x1f1>
18000d01b:     	movq	%rsi, 0x68(%rsp)
18000d020:     	movl	(%rcx), %esi
18000d022:     	subl	%r13d, %esi
18000d025:     	movl	%esi, 0x20(%rsp)
18000d029:     	testq	%rdi, %rdi
18000d02c:     	jns	0x18000d047 <numba_list_delete_slice+0xa7>
18000d02e:     	leaq	0x1(%r15), %rbp
18000d032:     	leal	-0x1(%r13), %eax
18000d036:     	movslq	%eax, %rcx
18000d039:     	leaq	-0x1(%rbp), %r15
18000d03d:     	imulq	%rdi, %rcx
18000d041:     	addq	%rcx, %r15
18000d044:     	negq	%rdi
18000d047:     	cmpq	$0x1, %rdi
18000d04b:     	jne	0x18000d097 <numba_list_delete_slice+0xf7>
18000d04d:     	cmpq	$0x0, 0x28(%rbx)
18000d052:     	je	0x18000d079 <numba_list_delete_slice+0xd9>
18000d054:     	movslq	%r15d, %rdi
18000d057:     	cmpq	%rbp, %rdi
18000d05a:     	jge	0x18000d079 <numba_list_delete_slice+0xd9>
18000d05c:     	nopl	(%rax)
18000d060:     	movslq	%edi, %rcx
18000d063:     	imulq	0x8(%rbx), %rcx
18000d068:     	addq	0x30(%rbx), %rcx
18000d06c:     	callq	*0x28(%rbx)
18000d06f:     	incl	%edi
18000d071:     	movslq	%edi, %rax
18000d074:     	cmpq	%rbp, %rax
18000d077:     	jl	0x18000d060 <numba_list_delete_slice+0xc0>
18000d079:     	movq	0x8(%rbx), %rcx
18000d07d:     	movq	(%rbx), %r8
18000d080:     	movq	%rcx, %rdx
18000d083:     	subq	%rbp, %r8
18000d086:     	imulq	%rcx, %r8
18000d08a:     	imulq	%rbp, %rdx
18000d08e:     	imulq	%r15, %rcx
18000d092:     	jmp	0x18000d15c <numba_list_delete_slice+0x1bc>
18000d097:     	movq	%r14, 0x30(%rsp)
18000d09c:     	movq	%r15, %r14
18000d09f:     	movl	$0x0, 0x60(%rsp)
18000d0a7:     	cmpq	%rbp, %r15
18000d0aa:     	jge	0x18000d129 <numba_list_delete_slice+0x189>
18000d0ac:     	movq	%r12, 0x70(%rsp)
18000d0b1:     	movq	(%rbx), %rax
18000d0b4:     	leaq	(%r14,%rdi), %r12
18000d0b8:     	cmpq	%rax, %r12
18000d0bb:     	jl	0x18000d0c8 <numba_list_delete_slice+0x128>
18000d0bd:     	movq	%r14, %rsi
18000d0c0:     	notq	%rsi
18000d0c3:     	addq	%rax, %rsi
18000d0c6:     	jmp	0x18000d0cc <numba_list_delete_slice+0x12c>
18000d0c8:     	leaq	-0x1(%rdi), %rsi
18000d0cc:     	movq	0x28(%rbx), %rax
18000d0d0:     	testq	%rax, %rax
18000d0d3:     	je	0x18000d0e3 <numba_list_delete_slice+0x143>
18000d0d5:     	movq	%r14, %rcx
18000d0d8:     	imulq	0x8(%rbx), %rcx
18000d0dd:     	addq	0x30(%rbx), %rcx
18000d0e1:     	callq	*%rax
18000d0e3:     	movq	0x8(%rbx), %r9
18000d0e7:     	leaq	0x1(%r14), %rdx
18000d0eb:     	movq	0x30(%rbx), %r10
18000d0ef:     	movq	%r9, %r8
18000d0f2:     	imulq	%rsi, %r8
18000d0f6:     	imulq	%r9, %rdx
18000d0fa:     	movslq	0x60(%rsp), %rsi
18000d0ff:     	subq	%rsi, %r14
18000d102:     	imulq	%r9, %r14
18000d106:     	addq	%r10, %rdx
18000d109:     	leaq	(%r10,%r14), %rcx
18000d10d:     	callq	0x18000e0a9 <numba_list_iter_next+0xec9>
18000d112:     	incl	%esi
18000d114:     	movq	%r12, %r14
18000d117:     	movl	%esi, 0x60(%rsp)
18000d11b:     	cmpq	%rbp, %r12
18000d11e:     	jl	0x18000d0b1 <numba_list_delete_slice+0x111>
18000d120:     	movq	0x70(%rsp), %r12
18000d125:     	movl	0x20(%rsp), %esi
18000d129:     	movq	(%rbx), %r8
18000d12c:     	movq	0x30(%rsp), %r14
18000d131:     	movslq	%r13d, %r10
18000d134:     	movq	%r10, %rcx
18000d137:     	imulq	%rdi, %rcx
18000d13b:     	addq	%r15, %rcx
18000d13e:     	cmpq	%r8, %rcx
18000d141:     	jge	0x18000d169 <numba_list_delete_slice+0x1c9>
18000d143:     	movq	0x8(%rbx), %rax
18000d147:     	subq	%rcx, %r8
18000d14a:     	movq	%rax, %rdx
18000d14d:     	imulq	%rcx, %rdx
18000d151:     	imulq	%rax, %r8
18000d155:     	subq	%r10, %rcx
18000d158:     	imulq	%rax, %rcx
18000d15c:     	addq	0x30(%rbx), %rdx
18000d160:     	addq	0x30(%rbx), %rcx
18000d164:     	callq	0x18000e0a9 <numba_list_iter_next+0xec9>
18000d169:     	movslq	%esi, %rdx
18000d16c:     	movq	%rbx, %rcx
18000d16f:     	callq	0x18000cde0 <numba_list_resize>
18000d174:     	movq	0x68(%rsp), %rsi
18000d179:     	xorl	%ecx, %ecx
18000d17b:     	movq	0x78(%rsp), %r13
18000d180:     	testl	%eax, %eax
18000d182:     	cmovsl	%eax, %ecx
18000d185:     	movl	%ecx, %eax
18000d187:     	addq	$0x38, %rsp
18000d18b:     	popq	%r15
18000d18d:     	popq	%rdi
18000d18e:     	popq	%rbp
18000d18f:     	popq	%rbx
18000d190:     	retq
18000d191:     	movq	0x78(%rsp), %r13
18000d196:     	xorl	%eax, %eax
18000d198:     	addq	$0x38, %rsp
18000d19c:     	popq	%r15
18000d19e:     	popq	%rdi
18000d19f:     	popq	%rbp
18000d1a0:     	popq	%rbx
18000d1a1:     	retq
18000d1a2:     	int3
18000d1a3:     	int3
18000d1a4:     	int3
18000d1a5:     	int3
18000d1a6:     	int3
18000d1a7:     	int3
18000d1a8:     	int3
18000d1a9:     	int3
18000d1aa:     	int3
18000d1ab:     	int3
18000d1ac:     	int3
18000d1ad:     	int3
18000d1ae:     	int3
18000d1af:     	int3

000000018000d1b0 <numba_list_iter_sizeof>:
18000d1b0:     	movl	$0x18, %eax
18000d1b5:     	retq
18000d1b6:     	int3
18000d1b7:     	int3
18000d1b8:     	int3
18000d1b9:     	int3
18000d1ba:     	int3
18000d1bb:     	int3
18000d1bc:     	int3
18000d1bd:     	int3
18000d1be:     	int3
18000d1bf:     	int3

000000018000d1c0 <numba_list_iter>:
18000d1c0:     	movq	%rdx, (%rcx)
18000d1c3:     	movq	(%rdx), %rax
18000d1c6:     	movq	%rax, 0x8(%rcx)
18000d1ca:     	movq	$0x0, 0x10(%rcx)
18000d1d2:     	retq
18000d1d3:     	int3
18000d1d4:     	int3
18000d1d5:     	int3
18000d1d6:     	int3
18000d1d7:     	int3
18000d1d8:     	int3
18000d1d9:     	int3
18000d1da:     	int3
18000d1db:     	int3
18000d1dc:     	int3
18000d1dd:     	int3
18000d1de:     	int3
18000d1df:     	int3

000000018000d1e0 <numba_list_iter_next>:
18000d1e0:     	movq	(%rcx), %r8
18000d1e3:     	movq	(%r8), %r9
18000d1e6:     	cmpq	0x8(%rcx), %r9
18000d1ea:     	je	0x18000d1f2 <numba_list_iter_next+0x12>
18000d1ec:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
18000d1f1:     	retq
18000d1f2:     	movq	0x10(%rcx), %rax
18000d1f6:     	cmpq	%r9, %rax
18000d1f9:     	jge	0x18000d20e <numba_list_iter_next+0x2e>
18000d1fb:     	imulq	0x8(%r8), %rax
18000d200:     	addq	0x30(%r8), %rax
18000d204:     	movq	%rax, (%rdx)
18000d207:     	incq	0x10(%rcx)
18000d20b:     	xorl	%eax, %eax
18000d20d:     	retq
18000d20e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
18000d213:     	retq
18000d214:     	int3
18000d215:     	int3
18000d216:     	int3
18000d217:     	int3
18000d218:     	int3
18000d219:     	int3
18000d21a:     	int3
18000d21b:     	int3
18000d21c:     	int3
18000d21d:     	int3
18000d21e:     	int3
18000d21f:     	int3
18000d220:     	pushq	%rbx
18000d222:     	subq	$0x20, %rsp
18000d226:     	movq	%rcx, %rbx
18000d229:     	addq	$0x30, %rcx
18000d22d:     	callq	*0x9a35(%rip)           # 0x180016c68
18000d233:     	cmpb	$0x0, 0x9a06(%rip)      # 0x180016c40
18000d23a:     	je	0x18000d244 <numba_list_iter_next+0x64>
18000d23c:     	lock
18000d23d:     	incq	0x9a04(%rip)            # 0x180016c48
18000d244:     	testq	%rax, %rax
18000d247:     	je	0x18000d288 <numba_list_iter_next+0xa8>
18000d249:     	leaq	0x30(%rax), %rdx
18000d24d:     	testq	%rdx, %rdx
18000d250:     	je	0x18000d288 <numba_list_iter_next+0xa8>
18000d252:     	xorl	%r8d, %r8d
18000d255:     	movl	$0x1, %ecx
18000d25a:     	xchgq	%rcx, (%rax)
18000d25d:     	movq	%r8, 0x8(%rax)
18000d261:     	movq	%r8, 0x10(%rax)
18000d265:     	movq	%rdx, 0x18(%rax)
18000d269:     	movq	%rbx, 0x20(%rax)
18000d26d:     	movq	%r8, 0x28(%rax)
18000d271:     	cmpb	%r8b, 0x99c8(%rip)      # 0x180016c40
18000d278:     	je	0x18000d28a <numba_list_iter_next+0xaa>
18000d27a:     	lock
18000d27b:     	incq	0x99d6(%rip)            # 0x180016c58
18000d282:     	addq	$0x20, %rsp
18000d286:     	popq	%rbx
18000d287:     	retq
18000d288:     	xorl	%eax, %eax
18000d28a:     	addq	$0x20, %rsp
18000d28e:     	popq	%rbx
18000d28f:     	retq
18000d290:     	movq	%rbx, 0x8(%rsp)
18000d295:     	pushq	%rdi
18000d296:     	subq	$0x20, %rsp
18000d29a:     	movq	%rcx, %rdi
18000d29d:     	movq	%rdx, %rbx
18000d2a0:     	addq	$0x30, %rcx
18000d2a4:     	testq	%rdx, %rdx
18000d2a7:     	je	0x18000d2b1 <numba_list_iter_next+0xd1>
18000d2a9:     	movq	0x18(%rdx), %rdx
18000d2ad:     	callq	*(%rbx)
18000d2af:     	jmp	0x18000d2b7 <numba_list_iter_next+0xd7>
18000d2b1:     	callq	*0x99b1(%rip)           # 0x180016c68
18000d2b7:     	cmpb	$0x0, 0x9982(%rip)      # 0x180016c40
18000d2be:     	movq	%rax, %r8
18000d2c1:     	je	0x18000d2cb <numba_list_iter_next+0xeb>
18000d2c3:     	lock
18000d2c4:     	incq	0x997d(%rip)            # 0x180016c48
18000d2cb:     	xorl	%edx, %edx
18000d2cd:     	leaq	0x30(%r8), %rax
18000d2d1:     	testq	%r8, %r8
18000d2d4:     	movl	%edx, %ecx
18000d2d6:     	cmovneq	%rax, %rcx
18000d2da:     	testq	%rcx, %rcx
18000d2dd:     	jne	0x18000d2ec <numba_list_iter_next+0x10c>
18000d2df:     	xorl	%eax, %eax
18000d2e1:     	movq	0x30(%rsp), %rbx
18000d2e6:     	addq	$0x20, %rsp
18000d2ea:     	popq	%rdi
18000d2eb:     	retq
18000d2ec:     	movl	$0x1, %eax
18000d2f1:     	xchgq	%rax, (%r8)
18000d2f4:     	movq	%rdx, 0x8(%r8)
18000d2f8:     	movq	%rdx, 0x10(%r8)
18000d2fc:     	movq	%rcx, 0x18(%r8)
18000d300:     	movq	%rdi, 0x20(%r8)
18000d304:     	movq	%rbx, 0x28(%r8)
18000d308:     	cmpb	%dl, 0x9932(%rip)       # 0x180016c40
18000d30e:     	je	0x18000d318 <numba_list_iter_next+0x138>
18000d310:     	lock
18000d311:     	incq	0x9940(%rip)            # 0x180016c58
18000d318:     	movq	0x30(%rsp), %rbx
18000d31d:     	movq	%r8, %rax
18000d320:     	addq	$0x20, %rsp
18000d324:     	popq	%rdi
18000d325:     	retq
18000d326:     	int3
18000d327:     	int3
18000d328:     	int3
18000d329:     	int3
18000d32a:     	int3
18000d32b:     	int3
18000d32c:     	int3
18000d32d:     	int3
18000d32e:     	int3
18000d32f:     	int3
18000d330:     	lock
18000d331:     	incq	(%rcx)
18000d334:     	retq
18000d335:     	int3
18000d336:     	int3
18000d337:     	int3
18000d338:     	int3
18000d339:     	int3
18000d33a:     	int3
18000d33b:     	int3
18000d33c:     	int3
18000d33d:     	int3
18000d33e:     	int3
18000d33f:     	int3
18000d340:     	pushq	%rbx
18000d342:     	subq	$0x20, %rsp
18000d346:     	movq	0x8(%rcx), %rax
18000d34a:     	movq	%rcx, %rbx
18000d34d:     	testq	%rax, %rax
18000d350:     	je	0x18000d369 <numba_list_iter_next+0x189>
18000d352:     	cmpl	$0x0, 0x98df(%rip)      # 0x180016c38
18000d359:     	jne	0x18000d369 <numba_list_iter_next+0x189>
18000d35b:     	movq	0x10(%rcx), %r8
18000d35f:     	movq	0x20(%rcx), %rdx
18000d363:     	movq	0x18(%rcx), %rcx
18000d367:     	callq	*%rax
18000d369:     	movq	0x28(%rbx), %rax
18000d36d:     	movq	%rbx, %rcx
18000d370:     	testq	%rax, %rax
18000d373:     	je	0x18000d37e <numba_list_iter_next+0x19e>
18000d375:     	movq	0x18(%rax), %rdx
18000d379:     	callq	*0x10(%rax)
18000d37c:     	jmp	0x18000d384 <numba_list_iter_next+0x1a4>
18000d37e:     	callq	*0x98f4(%rip)           # 0x180016c78
18000d384:     	cmpb	$0x0, 0x98b5(%rip)      # 0x180016c40
18000d38b:     	je	0x18000d3a9 <numba_list_iter_next+0x1c9>
18000d38d:     	leaq	0x98bc(%rip), %rax      # 0x180016c50
18000d394:     	lock
18000d395:     	incq	(%rax)
18000d398:     	cmpb	$0x0, 0x98a1(%rip)      # 0x180016c40
18000d39f:     	je	0x18000d3a9 <numba_list_iter_next+0x1c9>
18000d3a1:     	lock
18000d3a2:     	incq	0x98b7(%rip)            # 0x180016c60
18000d3a9:     	addq	$0x20, %rsp
18000d3ad:     	popq	%rbx
18000d3ae:     	retq
18000d3af:     	int3
18000d3b0:     	pushq	%rbx
18000d3b2:     	subq	$0x20, %rsp
18000d3b6:     	movq	%rcx, %rbx
18000d3b9:     	movq	$-0x1, %rax
18000d3c0:     	lock
18000d3c1:     	xaddq	%rax, (%rcx)
18000d3c5:     	cmpq	$0x1, %rax
18000d3c9:     	jne	0x18000d42b <numba_list_iter_next+0x24b>
18000d3cb:     	movq	0x8(%rcx), %rax
18000d3cf:     	testq	%rax, %rax
18000d3d2:     	je	0x18000d3eb <numba_list_iter_next+0x20b>
18000d3d4:     	cmpl	$0x0, 0x985d(%rip)      # 0x180016c38
18000d3db:     	jne	0x18000d3eb <numba_list_iter_next+0x20b>
18000d3dd:     	movq	0x10(%rcx), %r8
18000d3e1:     	movq	0x20(%rcx), %rdx
18000d3e5:     	movq	0x18(%rcx), %rcx
18000d3e9:     	callq	*%rax
18000d3eb:     	movq	0x28(%rbx), %rax
18000d3ef:     	movq	%rbx, %rcx
18000d3f2:     	testq	%rax, %rax
18000d3f5:     	je	0x18000d400 <numba_list_iter_next+0x220>
18000d3f7:     	movq	0x18(%rax), %rdx
18000d3fb:     	callq	*0x10(%rax)
18000d3fe:     	jmp	0x18000d406 <numba_list_iter_next+0x226>
18000d400:     	callq	*0x9872(%rip)           # 0x180016c78
18000d406:     	cmpb	$0x0, 0x9833(%rip)      # 0x180016c40
18000d40d:     	je	0x18000d42b <numba_list_iter_next+0x24b>
18000d40f:     	leaq	0x983a(%rip), %rax      # 0x180016c50
18000d416:     	lock
18000d417:     	incq	(%rax)
18000d41a:     	cmpb	$0x0, 0x981f(%rip)      # 0x180016c40
18000d421:     	je	0x18000d42b <numba_list_iter_next+0x24b>
18000d423:     	lock
18000d424:     	incq	0x9835(%rip)            # 0x180016c60
18000d42b:     	addq	$0x20, %rsp
18000d42f:     	popq	%rbx
18000d430:     	retq
18000d431:     	int3
18000d432:     	int3
18000d433:     	int3
18000d434:     	int3
18000d435:     	int3
18000d436:     	int3
18000d437:     	int3
18000d438:     	int3
18000d439:     	int3
18000d43a:     	int3
18000d43b:     	int3
18000d43c:     	int3
18000d43d:     	int3
18000d43e:     	int3
18000d43f:     	int3
18000d440:     	movq	0x18(%rcx), %rax
18000d444:     	retq
18000d445:     	int3
18000d446:     	int3
18000d447:     	int3
18000d448:     	int3
18000d449:     	int3
18000d44a:     	int3
18000d44b:     	int3
18000d44c:     	int3
18000d44d:     	int3
18000d44e:     	int3
18000d44f:     	int3
18000d450:     	subq	$0x28, %rsp
18000d454:     	callq	*0x981e(%rip)           # 0x180016c78
18000d45a:     	cmpb	$0x0, 0x97df(%rip)      # 0x180016c40
18000d461:     	je	0x18000d46b <numba_list_iter_next+0x28b>
18000d463:     	lock
18000d464:     	incq	0x97e5(%rip)            # 0x180016c50
18000d46b:     	addq	$0x28, %rsp
18000d46f:     	retq
18000d470:     	jmpq	*%r8
18000d473:     	int3
18000d474:     	int3
18000d475:     	int3
18000d476:     	int3
18000d477:     	int3
18000d478:     	int3
18000d479:     	int3
18000d47a:     	int3
18000d47b:     	int3
18000d47c:     	int3
18000d47d:     	int3
18000d47e:     	int3
18000d47f:     	int3
18000d480:     	movq	%rbx, 0x8(%rsp)
18000d485:     	pushq	%rdi
18000d486:     	subq	$0x20, %rsp
18000d48a:     	movq	%rcx, %rdi
18000d48d:     	movq	%rdx, %rbx
18000d490:     	movl	$0x30, %ecx
18000d495:     	callq	*0x97cd(%rip)           # 0x180016c68
18000d49b:     	cmpb	$0x0, 0x979e(%rip)      # 0x180016c40
18000d4a2:     	je	0x18000d4ac <numba_list_iter_next+0x2cc>
18000d4a4:     	lock
18000d4a5:     	incq	0x979c(%rip)            # 0x180016c48
18000d4ac:     	testq	%rax, %rax
18000d4af:     	je	0x18000d4e6 <numba_list_iter_next+0x306>
18000d4b1:     	leaq	-0x48(%rip), %rcx       # 0x18000d470 <numba_list_iter_next+0x290>
18000d4b8:     	movl	$0x1, %edx
18000d4bd:     	xchgq	%rdx, (%rax)
18000d4c0:     	movq	%rcx, 0x8(%rax)
18000d4c4:     	xorl	%ecx, %ecx
18000d4c6:     	movq	%rcx, 0x20(%rax)
18000d4ca:     	movq	%rcx, 0x28(%rax)
18000d4ce:     	movq	%rbx, 0x10(%rax)
18000d4d2:     	movq	%rdi, 0x18(%rax)
18000d4d6:     	cmpb	%cl, 0x9764(%rip)       # 0x180016c40
18000d4dc:     	je	0x18000d4e6 <numba_list_iter_next+0x306>
18000d4de:     	lock
18000d4df:     	incq	0x9772(%rip)            # 0x180016c58
18000d4e6:     	movq	0x30(%rsp), %rbx
18000d4eb:     	addq	$0x20, %rsp
18000d4ef:     	popq	%rdi
18000d4f0:     	retq
18000d4f1:     	jmpq	*0x1e19(%rip)           # 0x18000f310
18000d4f7:     	jmpq	*0x1e03(%rip)           # 0x18000f300
18000d4fd:     	jmpq	*0x1df5(%rip)           # 0x18000f2f8
18000d503:     	jmpq	*0x1de7(%rip)           # 0x18000f2f0
18000d509:     	jmpq	*0x1dd9(%rip)           # 0x18000f2e8
18000d50f:     	jmpq	*0x1dcb(%rip)           # 0x18000f2e0
18000d515:     	jmpq	*0x1dbd(%rip)           # 0x18000f2d8
18000d51b:     	jmpq	*0x1da7(%rip)           # 0x18000f2c8
18000d521:     	jmpq	*0x1d99(%rip)           # 0x18000f2c0
18000d527:     	jmpq	*0x1d8b(%rip)           # 0x18000f2b8
18000d52d:     	jmpq	*0x1d75(%rip)           # 0x18000f2a8
18000d533:     	jmpq	*0x1d4f(%rip)           # 0x18000f288
18000d539:     	jmpq	*0x1d41(%rip)           # 0x18000f280
18000d53f:     	jmpq	*0x1d33(%rip)           # 0x18000f278
18000d545:     	jmpq	*0x1d25(%rip)           # 0x18000f270
18000d54b:     	jmpq	*0x1cdf(%rip)           # 0x18000f230
18000d551:     	int3
18000d552:     	int3
18000d553:     	int3
18000d554:     	int3
18000d555:     	int3
18000d556:     	int3
18000d557:     	int3
18000d558:     	int3
18000d559:     	int3
18000d55a:     	int3
18000d55b:     	int3
18000d55c:     	int3
18000d55d:     	int3
18000d55e:     	int3
18000d55f:     	int3
18000d560:     	int3
18000d561:     	int3
18000d562:     	int3
18000d563:     	int3
18000d564:     	int3
18000d565:     	int3
18000d566:     	nopw	(%rax,%rax)
18000d570:     	cmpq	0x8b89(%rip), %rcx      # 0x180016100
18000d577:     	jne	0x18000d589 <numba_list_iter_next+0x3a9>
18000d579:     	rolq	$0x10, %rcx
18000d57d:     	testw	$0xffff, %cx            # imm = 0xFFFF
18000d582:     	jne	0x18000d585 <numba_list_iter_next+0x3a5>
18000d584:     	retq
18000d585:     	rorq	$0x10, %rcx
18000d589:     	jmp	0x18000d8e4 <numba_list_iter_next+0x704>
18000d58e:     	int3
18000d58f:     	int3
18000d590:     	subq	$0x28, %rsp
18000d594:     	testl	%edx, %edx
18000d596:     	je	0x18000d5d1 <numba_list_iter_next+0x3f1>
18000d598:     	subl	$0x1, %edx
18000d59b:     	je	0x18000d5c5 <numba_list_iter_next+0x3e5>
18000d59d:     	subl	$0x1, %edx
18000d5a0:     	je	0x18000d5b8 <numba_list_iter_next+0x3d8>
18000d5a2:     	cmpl	$0x1, %edx
18000d5a5:     	je	0x18000d5b1 <numba_list_iter_next+0x3d1>
18000d5a7:     	movl	$0x1, %eax
18000d5ac:     	addq	$0x28, %rsp
18000d5b0:     	retq
18000d5b1:     	callq	0x18000dab0 <numba_list_iter_next+0x8d0>
18000d5b6:     	jmp	0x18000d5bd <numba_list_iter_next+0x3dd>
18000d5b8:     	callq	0x18000da88 <numba_list_iter_next+0x8a8>
18000d5bd:     	movzbl	%al, %eax
18000d5c0:     	addq	$0x28, %rsp
18000d5c4:     	retq
18000d5c5:     	movq	%r8, %rdx
18000d5c8:     	addq	$0x28, %rsp
18000d5cc:     	jmp	0x18000d5e0 <numba_list_iter_next+0x400>
18000d5d1:     	testq	%r8, %r8
18000d5d4:     	setne	%cl
18000d5d7:     	addq	$0x28, %rsp
18000d5db:     	jmp	0x18000d6f8 <numba_list_iter_next+0x518>
18000d5e0:     	movq	%rbx, 0x8(%rsp)
18000d5e5:     	movq	%rsi, 0x10(%rsp)
18000d5ea:     	movq	%rdi, 0x20(%rsp)
18000d5ef:     	pushq	%r14
18000d5f1:     	subq	$0x20, %rsp
18000d5f5:     	movq	%rdx, %rsi
18000d5f8:     	movq	%rcx, %r14
18000d5fb:     	xorl	%ecx, %ecx
18000d5fd:     	callq	0x18000db6c <numba_list_iter_next+0x98c>
18000d602:     	testb	%al, %al
18000d604:     	je	0x18000d6d2 <numba_list_iter_next+0x4f2>
18000d60a:     	callq	0x18000da00 <numba_list_iter_next+0x820>
18000d60f:     	movb	%al, %bl
18000d611:     	movb	%al, 0x40(%rsp)
18000d615:     	movb	$0x1, %dil
18000d618:     	cmpl	$0x0, 0x93e9(%rip)      # 0x180016a08
18000d61f:     	jne	0x18000d6ea <numba_list_iter_next+0x50a>
18000d625:     	movl	$0x1, 0x93d9(%rip)      # 0x180016a08
18000d62f:     	callq	0x18000da70 <numba_list_iter_next+0x890>
18000d634:     	testb	%al, %al
18000d636:     	je	0x18000d687 <numba_list_iter_next+0x4a7>
18000d638:     	callq	0x18000dd2c <numba_list_iter_next+0xb4c>
18000d63d:     	callq	0x18000d9c0 <numba_list_iter_next+0x7e0>
18000d642:     	callq	0x18000d9e4 <numba_list_iter_next+0x804>
18000d647:     	leaq	0x1d22(%rip), %rdx      # 0x18000f370
18000d64e:     	leaq	0x1d13(%rip), %rcx      # 0x18000f368
18000d655:     	callq	0x18000e072 <numba_list_iter_next+0xe92>
18000d65a:     	testl	%eax, %eax
18000d65c:     	jne	0x18000d687 <numba_list_iter_next+0x4a7>
18000d65e:     	callq	0x18000da3c <numba_list_iter_next+0x85c>
18000d663:     	testb	%al, %al
18000d665:     	je	0x18000d687 <numba_list_iter_next+0x4a7>
18000d667:     	leaq	0x1cf2(%rip), %rdx      # 0x18000f360
18000d66e:     	leaq	0x1ce3(%rip), %rcx      # 0x18000f358
18000d675:     	callq	0x18000e06c <numba_list_iter_next+0xe8c>
18000d67a:     	movl	$0x2, 0x9384(%rip)      # 0x180016a08
18000d684:     	xorb	%dil, %dil
18000d687:     	movb	%bl, %cl
18000d689:     	callq	0x18000dccc <numba_list_iter_next+0xaec>
18000d68e:     	testb	%dil, %dil
18000d691:     	jne	0x18000d6d2 <numba_list_iter_next+0x4f2>
18000d693:     	callq	0x18000dd1c <numba_list_iter_next+0xb3c>
18000d698:     	movq	%rax, %rbx
18000d69b:     	cmpq	$0x0, (%rax)
18000d69f:     	je	0x18000d6c5 <numba_list_iter_next+0x4e5>
18000d6a1:     	movq	%rax, %rcx
18000d6a4:     	callq	0x18000dc34 <numba_list_iter_next+0xa54>
18000d6a9:     	testb	%al, %al
18000d6ab:     	je	0x18000d6c5 <numba_list_iter_next+0x4e5>
18000d6ad:     	movq	%rsi, %r8
18000d6b0:     	movl	$0x2, %edx
18000d6b5:     	movq	%r14, %rcx
18000d6b8:     	movq	(%rbx), %rax
18000d6bb:     	movq	0x1c6e(%rip), %r9       # 0x18000f330
18000d6c2:     	callq	*%r9
18000d6c5:     	incl	0x9315(%rip)            # 0x1800169e0
18000d6cb:     	movl	$0x1, %eax
18000d6d0:     	jmp	0x18000d6d4 <numba_list_iter_next+0x4f4>
18000d6d2:     	xorl	%eax, %eax
18000d6d4:     	movq	0x30(%rsp), %rbx
18000d6d9:     	movq	0x38(%rsp), %rsi
18000d6de:     	movq	0x48(%rsp), %rdi
18000d6e3:     	addq	$0x20, %rsp
18000d6e7:     	popq	%r14
18000d6e9:     	retq
18000d6ea:     	movl	$0x7, %ecx
18000d6ef:     	callq	0x18000dd24 <numba_list_iter_next+0xb44>
18000d6f4:     	nop
18000d6f5:     	int3
18000d6f6:     	int3
18000d6f7:     	int3
18000d6f8:     	movq	%rbx, 0x8(%rsp)
18000d6fd:     	pushq	%rdi
18000d6fe:     	subq	$0x30, %rsp
18000d702:     	movb	%cl, %dil
18000d705:     	movl	0x92d5(%rip), %eax      # 0x1800169e0
18000d70b:     	testl	%eax, %eax
18000d70d:     	jg	0x18000d71c <numba_list_iter_next+0x53c>
18000d70f:     	xorl	%eax, %eax
18000d711:     	movq	0x40(%rsp), %rbx
18000d716:     	addq	$0x30, %rsp
18000d71a:     	popq	%rdi
18000d71b:     	retq
18000d71c:     	decl	%eax
18000d71e:     	movl	%eax, 0x92bc(%rip)      # 0x1800169e0
18000d724:     	callq	0x18000da00 <numba_list_iter_next+0x820>
18000d729:     	movb	%al, %bl
18000d72b:     	movb	%al, 0x20(%rsp)
18000d72f:     	cmpl	$0x2, 0x92d2(%rip)      # 0x180016a08
18000d736:     	jne	0x18000d76e <numba_list_iter_next+0x58e>
18000d738:     	callq	0x18000db28 <numba_list_iter_next+0x948>
18000d73d:     	callq	0x18000d9d0 <numba_list_iter_next+0x7f0>
18000d742:     	callq	0x18000dd68 <numba_list_iter_next+0xb88>
18000d747:     	movl	$0x0, 0x92b7(%rip)      # 0x180016a08
18000d751:     	movb	%bl, %cl
18000d753:     	callq	0x18000dccc <numba_list_iter_next+0xaec>
18000d758:     	xorl	%edx, %edx
18000d75a:     	movb	%dil, %cl
18000d75d:     	callq	0x18000dcf0 <numba_list_iter_next+0xb10>
18000d762:     	movzbl	%al, %ebx
18000d765:     	callq	0x18000db58 <numba_list_iter_next+0x978>
18000d76a:     	movl	%ebx, %eax
18000d76c:     	jmp	0x18000d711 <numba_list_iter_next+0x531>
18000d76e:     	movl	$0x7, %ecx
18000d773:     	callq	0x18000dd24 <numba_list_iter_next+0xb44>
18000d778:     	nop
18000d779:     	nop
18000d77a:     	int3
18000d77b:     	int3
18000d77c:     	movq	%rsp, %rax
18000d77f:     	movq	%rbx, 0x20(%rax)
18000d783:     	movq	%r8, 0x18(%rax)
18000d787:     	movl	%edx, 0x10(%rax)
18000d78a:     	movq	%rcx, 0x8(%rax)
18000d78e:     	pushq	%rsi
18000d78f:     	pushq	%rdi
18000d790:     	pushq	%r14
18000d792:     	subq	$0x40, %rsp
18000d796:     	movq	%r8, %rsi
18000d799:     	movl	%edx, %edi
18000d79b:     	movq	%rcx, %r14
18000d79e:     	testl	%edx, %edx
18000d7a0:     	jne	0x18000d7b1 <numba_list_iter_next+0x5d1>
18000d7a2:     	cmpl	%edx, 0x9238(%rip)      # 0x1800169e0
18000d7a8:     	jg	0x18000d7b1 <numba_list_iter_next+0x5d1>
18000d7aa:     	xorl	%eax, %eax
18000d7ac:     	jmp	0x18000d896 <numba_list_iter_next+0x6b6>
18000d7b1:     	leal	-0x1(%rdx), %eax
18000d7b4:     	cmpl	$0x1, %eax
18000d7b7:     	ja	0x18000d7f9 <numba_list_iter_next+0x619>
18000d7b9:     	movq	0x2368(%rip), %rax      # 0x18000fb28
18000d7c0:     	testq	%rax, %rax
18000d7c3:     	jne	0x18000d7ca <numba_list_iter_next+0x5ea>
18000d7c5:     	leal	0x1(%rax), %ebx
18000d7c8:     	jmp	0x18000d7d2 <numba_list_iter_next+0x5f2>
18000d7ca:     	callq	*0x1b60(%rip)           # 0x18000f330
18000d7d0:     	movl	%eax, %ebx
18000d7d2:     	movl	%ebx, 0x30(%rsp)
18000d7d6:     	testl	%ebx, %ebx
18000d7d8:     	je	0x18000d88c <numba_list_iter_next+0x6ac>
18000d7de:     	movq	%rsi, %r8
18000d7e1:     	movl	%edi, %edx
18000d7e3:     	movq	%r14, %rcx
18000d7e6:     	callq	0x18000d590 <numba_list_iter_next+0x3b0>
18000d7eb:     	movl	%eax, %ebx
18000d7ed:     	movl	%eax, 0x30(%rsp)
18000d7f1:     	testl	%eax, %eax
18000d7f3:     	je	0x18000d88c <numba_list_iter_next+0x6ac>
18000d7f9:     	movq	%rsi, %r8
18000d7fc:     	movl	%edi, %edx
18000d7fe:     	movq	%r14, %rcx
18000d801:     	callq	0x18000d99c <numba_list_iter_next+0x7bc>
18000d806:     	movl	%eax, %ebx
18000d808:     	movl	%eax, 0x30(%rsp)
18000d80c:     	cmpl	$0x1, %edi
18000d80f:     	jne	0x18000d847 <numba_list_iter_next+0x667>
18000d811:     	testl	%eax, %eax
18000d813:     	jne	0x18000d847 <numba_list_iter_next+0x667>
18000d815:     	movq	%rsi, %r8
18000d818:     	xorl	%edx, %edx
18000d81a:     	movq	%r14, %rcx
18000d81d:     	callq	0x18000d99c <numba_list_iter_next+0x7bc>
18000d822:     	testq	%rsi, %rsi
18000d825:     	setne	%cl
18000d828:     	callq	0x18000d6f8 <numba_list_iter_next+0x518>
18000d82d:     	movq	0x22f4(%rip), %rax      # 0x18000fb28
18000d834:     	testq	%rax, %rax
18000d837:     	je	0x18000d847 <numba_list_iter_next+0x667>
18000d839:     	movq	%rsi, %r8
18000d83c:     	xorl	%edx, %edx
18000d83e:     	movq	%r14, %rcx
18000d841:     	callq	*0x1ae9(%rip)           # 0x18000f330
18000d847:     	testl	%edi, %edi
18000d849:     	je	0x18000d850 <numba_list_iter_next+0x670>
18000d84b:     	cmpl	$0x3, %edi
18000d84e:     	jne	0x18000d88c <numba_list_iter_next+0x6ac>
18000d850:     	movq	%rsi, %r8
18000d853:     	movl	%edi, %edx
18000d855:     	movq	%r14, %rcx
18000d858:     	callq	0x18000d590 <numba_list_iter_next+0x3b0>
18000d85d:     	movl	%eax, %ebx
18000d85f:     	movl	%eax, 0x30(%rsp)
18000d863:     	testl	%eax, %eax
18000d865:     	je	0x18000d88c <numba_list_iter_next+0x6ac>
18000d867:     	movq	0x22ba(%rip), %rax      # 0x18000fb28
18000d86e:     	testq	%rax, %rax
18000d871:     	jne	0x18000d878 <numba_list_iter_next+0x698>
18000d873:     	leal	0x1(%rax), %ebx
18000d876:     	jmp	0x18000d888 <numba_list_iter_next+0x6a8>
18000d878:     	movq	%rsi, %r8
18000d87b:     	movl	%edi, %edx
18000d87d:     	movq	%r14, %rcx
18000d880:     	callq	*0x1aaa(%rip)           # 0x18000f330
18000d886:     	movl	%eax, %ebx
18000d888:     	movl	%ebx, 0x30(%rsp)
18000d88c:     	jmp	0x18000d894 <numba_list_iter_next+0x6b4>
18000d88e:     	xorl	%ebx, %ebx
18000d890:     	movl	%ebx, 0x30(%rsp)
18000d894:     	movl	%ebx, %eax
18000d896:     	movq	0x78(%rsp), %rbx
18000d89b:     	addq	$0x40, %rsp
18000d89f:     	popq	%r14
18000d8a1:     	popq	%rdi
18000d8a2:     	popq	%rsi
18000d8a3:     	retq
18000d8a4:     	movq	%rbx, 0x8(%rsp)
18000d8a9:     	movq	%rsi, 0x10(%rsp)
18000d8ae:     	pushq	%rdi
18000d8af:     	subq	$0x20, %rsp
18000d8b3:     	movq	%r8, %rdi
18000d8b6:     	movl	%edx, %ebx
18000d8b8:     	movq	%rcx, %rsi
18000d8bb:     	cmpl	$0x1, %edx
18000d8be:     	jne	0x18000d8c5 <numba_list_iter_next+0x6e5>
18000d8c0:     	callq	0x18000d8ec <numba_list_iter_next+0x70c>
18000d8c5:     	movq	%rdi, %r8
18000d8c8:     	movl	%ebx, %edx
18000d8ca:     	movq	%rsi, %rcx
18000d8cd:     	movq	0x30(%rsp), %rbx
18000d8d2:     	movq	0x38(%rsp), %rsi
18000d8d7:     	addq	$0x20, %rsp
18000d8db:     	popq	%rdi
18000d8dc:     	jmp	0x18000d77c <numba_list_iter_next+0x59c>
18000d8e1:     	int3
18000d8e2:     	int3
18000d8e3:     	int3
18000d8e4:     	movl	$0x2, %ecx
18000d8e9:     	int	$0x29
18000d8eb:     	retq
18000d8ec:     	movq	%rbx, 0x18(%rsp)
18000d8f1:     	pushq	%rbp
18000d8f2:     	movq	%rsp, %rbp
18000d8f5:     	subq	$0x30, %rsp
18000d8f9:     	movq	0x8800(%rip), %rax      # 0x180016100
18000d900:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000d90a:     	cmpq	%rbx, %rax
18000d90d:     	jne	0x18000d986 <numba_list_iter_next+0x7a6>
18000d90f:     	leaq	0x10(%rbp), %rcx
18000d913:     	movq	$0x0, 0x10(%rbp)
18000d91b:     	callq	*0x16ff(%rip)           # 0x18000f020
18000d921:     	movq	0x10(%rbp), %rax
18000d925:     	movq	%rax, -0x10(%rbp)
18000d929:     	callq	*0x16e9(%rip)           # 0x18000f018
18000d92f:     	movl	%eax, %eax
18000d931:     	xorq	%rax, -0x10(%rbp)
18000d935:     	callq	*0x16d5(%rip)           # 0x18000f010
18000d93b:     	movl	%eax, %eax
18000d93d:     	leaq	0x18(%rbp), %rcx
18000d941:     	xorq	%rax, -0x10(%rbp)
18000d945:     	callq	*0x16b5(%rip)           # 0x18000f000
18000d94b:     	movl	0x18(%rbp), %eax
18000d94e:     	leaq	-0x10(%rbp), %rcx
18000d952:     	shlq	$0x20, %rax
18000d956:     	xorq	0x18(%rbp), %rax
18000d95a:     	xorq	-0x10(%rbp), %rax
18000d95e:     	xorq	%rcx, %rax
18000d961:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000d96b:     	andq	%rcx, %rax
18000d96e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
18000d978:     	cmpq	%rbx, %rax
18000d97b:     	cmoveq	%rcx, %rax
18000d97f:     	movq	%rax, 0x877a(%rip)      # 0x180016100
18000d986:     	movq	0x50(%rsp), %rbx
18000d98b:     	notq	%rax
18000d98e:     	movq	%rax, 0x87ab(%rip)      # 0x180016140
18000d995:     	addq	$0x30, %rsp
18000d999:     	popq	%rbp
18000d99a:     	retq
18000d99b:     	int3
18000d99c:     	subq	$0x28, %rsp
18000d9a0:     	cmpl	$0x1, %edx
18000d9a3:     	jne	0x18000d9b5 <numba_list_iter_next+0x7d5>
18000d9a5:     	cmpq	$0x0, 0x217b(%rip)      # 0x18000fb28
18000d9ad:     	jne	0x18000d9b5 <numba_list_iter_next+0x7d5>
18000d9af:     	callq	*0x1673(%rip)           # 0x18000f028
18000d9b5:     	movl	$0x1, %eax
18000d9ba:     	addq	$0x28, %rsp
18000d9be:     	retq
18000d9bf:     	int3
18000d9c0:     	leaq	0x9029(%rip), %rcx      # 0x1800169f0
18000d9c7:     	jmpq	*0x163a(%rip)           # 0x18000f008
18000d9ce:     	int3
18000d9cf:     	int3
18000d9d0:     	leaq	0x9019(%rip), %rcx      # 0x1800169f0
18000d9d7:     	jmp	0x18000e066 <numba_list_iter_next+0xe86>
18000d9dc:     	leaq	0x901d(%rip), %rax      # 0x180016a00
18000d9e3:     	retq
18000d9e4:     	subq	$0x28, %rsp
18000d9e8:     	callq	0x18000caf0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x8b10>
18000d9ed:     	orq	$0x24, (%rax)
18000d9f1:     	callq	0x18000d9dc <numba_list_iter_next+0x7fc>
18000d9f6:     	orq	$0x2, (%rax)
18000d9fa:     	addq	$0x28, %rsp
18000d9fe:     	retq
18000d9ff:     	int3
18000da00:     	subq	$0x28, %rsp
18000da04:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000da09:     	testl	%eax, %eax
18000da0b:     	je	0x18000da2e <numba_list_iter_next+0x84e>
18000da0d:     	movq	%gs:0x30, %rax
18000da16:     	movq	0x8(%rax), %rcx
18000da1a:     	jmp	0x18000da21 <numba_list_iter_next+0x841>
18000da1c:     	cmpq	%rax, %rcx
18000da1f:     	je	0x18000da35 <numba_list_iter_next+0x855>
18000da21:     	xorl	%eax, %eax
18000da23:     	lock
18000da24:     	cmpxchgq	%rcx, 0x8fe4(%rip)      # 0x180016a10
18000da2c:     	jne	0x18000da1c <numba_list_iter_next+0x83c>
18000da2e:     	xorb	%al, %al
18000da30:     	addq	$0x28, %rsp
18000da34:     	retq
18000da35:     	movb	$0x1, %al
18000da37:     	jmp	0x18000da30 <numba_list_iter_next+0x850>
18000da39:     	int3
18000da3a:     	int3
18000da3b:     	int3
18000da3c:     	subq	$0x28, %rsp
18000da40:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000da45:     	testl	%eax, %eax
18000da47:     	je	0x18000da50 <numba_list_iter_next+0x870>
18000da49:     	callq	0x18000dda8 <numba_list_iter_next+0xbc8>
18000da4e:     	jmp	0x18000da69 <numba_list_iter_next+0x889>
18000da50:     	callq	0x18000e044 <numba_list_iter_next+0xe64>
18000da55:     	movl	%eax, %ecx
18000da57:     	callq	0x18000e07e <numba_list_iter_next+0xe9e>
18000da5c:     	testl	%eax, %eax
18000da5e:     	je	0x18000da64 <numba_list_iter_next+0x884>
18000da60:     	xorb	%al, %al
18000da62:     	jmp	0x18000da6b <numba_list_iter_next+0x88b>
18000da64:     	callq	0x18000e084 <numba_list_iter_next+0xea4>
18000da69:     	movb	$0x1, %al
18000da6b:     	addq	$0x28, %rsp
18000da6f:     	retq
18000da70:     	subq	$0x28, %rsp
18000da74:     	xorl	%ecx, %ecx
18000da76:     	callq	0x18000dba8 <numba_list_iter_next+0x9c8>
18000da7b:     	testb	%al, %al
18000da7d:     	setne	%al
18000da80:     	addq	$0x28, %rsp
18000da84:     	retq
18000da85:     	int3
18000da86:     	int3
18000da87:     	int3
18000da88:     	subq	$0x28, %rsp
18000da8c:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000da91:     	testb	%al, %al
18000da93:     	jne	0x18000da99 <numba_list_iter_next+0x8b9>
18000da95:     	xorb	%al, %al
18000da97:     	jmp	0x18000daab <numba_list_iter_next+0x8cb>
18000da99:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000da9e:     	testb	%al, %al
18000daa0:     	jne	0x18000daa9 <numba_list_iter_next+0x8c9>
18000daa2:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000daa7:     	jmp	0x18000da95 <numba_list_iter_next+0x8b5>
18000daa9:     	movb	$0x1, %al
18000daab:     	addq	$0x28, %rsp
18000daaf:     	retq
18000dab0:     	subq	$0x28, %rsp
18000dab4:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000dab9:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000dabe:     	movb	$0x1, %al
18000dac0:     	addq	$0x28, %rsp
18000dac4:     	retq
18000dac5:     	int3
18000dac6:     	int3
18000dac7:     	int3
18000dac8:     	movq	%rbx, 0x8(%rsp)
18000dacd:     	movq	%rbp, 0x10(%rsp)
18000dad2:     	movq	%rsi, 0x18(%rsp)
18000dad7:     	pushq	%rdi
18000dad8:     	subq	$0x20, %rsp
18000dadc:     	movq	%r9, %rdi
18000dadf:     	movq	%r8, %rsi
18000dae2:     	movl	%edx, %ebx
18000dae4:     	movq	%rcx, %rbp
18000dae7:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000daec:     	testl	%eax, %eax
18000daee:     	jne	0x18000db06 <numba_list_iter_next+0x926>
18000daf0:     	cmpl	$0x1, %ebx
18000daf3:     	jne	0x18000db06 <numba_list_iter_next+0x926>
18000daf5:     	movq	%rsi, %r8
18000daf8:     	xorl	%edx, %edx
18000dafa:     	movq	%rbp, %rcx
18000dafd:     	movq	%rdi, %rax
18000db00:     	callq	*0x182a(%rip)           # 0x18000f330
18000db06:     	movq	0x58(%rsp), %rdx
18000db0b:     	movl	0x50(%rsp), %ecx
18000db0f:     	movq	0x30(%rsp), %rbx
18000db14:     	movq	0x38(%rsp), %rbp
18000db19:     	movq	0x40(%rsp), %rsi
18000db1e:     	addq	$0x20, %rsp
18000db22:     	popq	%rdi
18000db23:     	jmp	0x18000e078 <numba_list_iter_next+0xe98>
18000db28:     	subq	$0x28, %rsp
18000db2c:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000db31:     	testl	%eax, %eax
18000db33:     	je	0x18000db45 <numba_list_iter_next+0x965>
18000db35:     	leaq	0x8ee4(%rip), %rcx      # 0x180016a20
18000db3c:     	addq	$0x28, %rsp
18000db40:     	jmp	0x18000e090 <numba_list_iter_next+0xeb0>
18000db45:     	callq	0x18000e0a0 <numba_list_iter_next+0xec0>
18000db4a:     	testl	%eax, %eax
18000db4c:     	jne	0x18000db53 <numba_list_iter_next+0x973>
18000db4e:     	callq	0x18000e096 <numba_list_iter_next+0xeb6>
18000db53:     	addq	$0x28, %rsp
18000db57:     	retq
18000db58:     	subq	$0x28, %rsp
18000db5c:     	xorl	%ecx, %ecx
18000db5e:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000db63:     	addq	$0x28, %rsp
18000db67:     	jmp	0x18000e09c <numba_list_iter_next+0xebc>
18000db6c:     	subq	$0x28, %rsp
18000db70:     	testl	%ecx, %ecx
18000db72:     	jne	0x18000db7b <numba_list_iter_next+0x99b>
18000db74:     	movb	$0x1, 0x8e9d(%rip)      # 0x180016a18
18000db7b:     	callq	0x18000dda8 <numba_list_iter_next+0xbc8>
18000db80:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000db85:     	testb	%al, %al
18000db87:     	jne	0x18000db8d <numba_list_iter_next+0x9ad>
18000db89:     	xorb	%al, %al
18000db8b:     	jmp	0x18000dba1 <numba_list_iter_next+0x9c1>
18000db8d:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000db92:     	testb	%al, %al
18000db94:     	jne	0x18000db9f <numba_list_iter_next+0x9bf>
18000db96:     	xorl	%ecx, %ecx
18000db98:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000db9d:     	jmp	0x18000db89 <numba_list_iter_next+0x9a9>
18000db9f:     	movb	$0x1, %al
18000dba1:     	addq	$0x28, %rsp
18000dba5:     	retq
18000dba6:     	int3
18000dba7:     	int3
18000dba8:     	pushq	%rbx
18000dbaa:     	subq	$0x20, %rsp
18000dbae:     	cmpb	$0x0, 0x8e64(%rip)      # 0x180016a19
18000dbb5:     	movl	%ecx, %ebx
18000dbb7:     	jne	0x18000dc20 <numba_list_iter_next+0xa40>
18000dbb9:     	cmpl	$0x1, %ecx
18000dbbc:     	ja	0x18000dc28 <numba_list_iter_next+0xa48>
18000dbbe:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000dbc3:     	testl	%eax, %eax
18000dbc5:     	je	0x18000dbef <numba_list_iter_next+0xa0f>
18000dbc7:     	testl	%ebx, %ebx
18000dbc9:     	jne	0x18000dbef <numba_list_iter_next+0xa0f>
18000dbcb:     	leaq	0x8e4e(%rip), %rcx      # 0x180016a20
18000dbd2:     	callq	0x18000e08a <numba_list_iter_next+0xeaa>
18000dbd7:     	testl	%eax, %eax
18000dbd9:     	jne	0x18000dbeb <numba_list_iter_next+0xa0b>
18000dbdb:     	leaq	0x8e56(%rip), %rcx      # 0x180016a38
18000dbe2:     	callq	0x18000e08a <numba_list_iter_next+0xeaa>
18000dbe7:     	testl	%eax, %eax
18000dbe9:     	je	0x18000dc19 <numba_list_iter_next+0xa39>
18000dbeb:     	xorb	%al, %al
18000dbed:     	jmp	0x18000dc22 <numba_list_iter_next+0xa42>
18000dbef:     	movdqa	0x1f39(%rip), %xmm0     # 0x18000fb30
18000dbf7:     	orq	$-0x1, %rax
18000dbfb:     	movdqu	%xmm0, 0x8e1d(%rip)     # 0x180016a20
18000dc03:     	movq	%rax, 0x8e26(%rip)      # 0x180016a30
18000dc0a:     	movdqu	%xmm0, 0x8e26(%rip)     # 0x180016a38
18000dc12:     	movq	%rax, 0x8e2f(%rip)      # 0x180016a48
18000dc19:     	movb	$0x1, 0x8df9(%rip)      # 0x180016a19
18000dc20:     	movb	$0x1, %al
18000dc22:     	addq	$0x20, %rsp
18000dc26:     	popq	%rbx
18000dc27:     	retq
18000dc28:     	movl	$0x5, %ecx
18000dc2d:     	callq	0x18000dd24 <numba_list_iter_next+0xb44>
18000dc32:     	int3
18000dc33:     	int3
18000dc34:     	subq	$0x18, %rsp
18000dc38:     	movq	%rcx, %r8
18000dc3b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
18000dc40:     	cmpw	%ax, -0xdc47(%rip)      # 0x180000000
18000dc47:     	jne	0x18000dcc1 <numba_list_iter_next+0xae1>
18000dc49:     	movslq	-0xdc14(%rip), %rcx     # 0x18000003c
18000dc50:     	leaq	-0xdc57(%rip), %rdx     # 0x180000000
18000dc57:     	addq	%rdx, %rcx
18000dc5a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
18000dc60:     	jne	0x18000dcc1 <numba_list_iter_next+0xae1>
18000dc62:     	movl	$0x20b, %eax            # imm = 0x20B
18000dc67:     	cmpw	%ax, 0x18(%rcx)
18000dc6b:     	jne	0x18000dcc1 <numba_list_iter_next+0xae1>
18000dc6d:     	subq	%rdx, %r8
18000dc70:     	movzwl	0x14(%rcx), %edx
18000dc74:     	addq	$0x18, %rdx
18000dc78:     	addq	%rcx, %rdx
18000dc7b:     	movzwl	0x6(%rcx), %eax
18000dc7f:     	leaq	(%rax,%rax,4), %rcx
18000dc83:     	leaq	(%rdx,%rcx,8), %r9
18000dc87:     	movq	%rdx, (%rsp)
18000dc8b:     	cmpq	%r9, %rdx
18000dc8e:     	je	0x18000dca8 <numba_list_iter_next+0xac8>
18000dc90:     	movl	0xc(%rdx), %ecx
18000dc93:     	cmpq	%rcx, %r8
18000dc96:     	jb	0x18000dca2 <numba_list_iter_next+0xac2>
18000dc98:     	movl	0x8(%rdx), %eax
18000dc9b:     	addl	%ecx, %eax
18000dc9d:     	cmpq	%rax, %r8
18000dca0:     	jb	0x18000dcaa <numba_list_iter_next+0xaca>
18000dca2:     	addq	$0x28, %rdx
18000dca6:     	jmp	0x18000dc87 <numba_list_iter_next+0xaa7>
18000dca8:     	xorl	%edx, %edx
18000dcaa:     	testq	%rdx, %rdx
18000dcad:     	jne	0x18000dcb3 <numba_list_iter_next+0xad3>
18000dcaf:     	xorb	%al, %al
18000dcb1:     	jmp	0x18000dcc7 <numba_list_iter_next+0xae7>
18000dcb3:     	cmpl	$0x0, 0x24(%rdx)
18000dcb7:     	jge	0x18000dcbd <numba_list_iter_next+0xadd>
18000dcb9:     	xorb	%al, %al
18000dcbb:     	jmp	0x18000dcc7 <numba_list_iter_next+0xae7>
18000dcbd:     	movb	$0x1, %al
18000dcbf:     	jmp	0x18000dcc7 <numba_list_iter_next+0xae7>
18000dcc1:     	xorb	%al, %al
18000dcc3:     	jmp	0x18000dcc7 <numba_list_iter_next+0xae7>
18000dcc5:     	xorb	%al, %al
18000dcc7:     	addq	$0x18, %rsp
18000dccb:     	retq
18000dccc:     	pushq	%rbx
18000dcce:     	subq	$0x20, %rsp
18000dcd2:     	movb	%cl, %bl
18000dcd4:     	callq	0x18000e04c <numba_list_iter_next+0xe6c>
18000dcd9:     	xorl	%edx, %edx
18000dcdb:     	testl	%eax, %eax
18000dcdd:     	je	0x18000dcea <numba_list_iter_next+0xb0a>
18000dcdf:     	testb	%bl, %bl
18000dce1:     	jne	0x18000dcea <numba_list_iter_next+0xb0a>
18000dce3:     	xchgq	%rdx, 0x8d26(%rip)      # 0x180016a10
18000dcea:     	addq	$0x20, %rsp
18000dcee:     	popq	%rbx
18000dcef:     	retq
18000dcf0:     	pushq	%rbx
18000dcf2:     	subq	$0x20, %rsp
18000dcf6:     	cmpb	$0x0, 0x8d1b(%rip)      # 0x180016a18
18000dcfd:     	movb	%cl, %bl
18000dcff:     	je	0x18000dd05 <numba_list_iter_next+0xb25>
18000dd01:     	testb	%dl, %dl
18000dd03:     	jne	0x18000dd11 <numba_list_iter_next+0xb31>
18000dd05:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000dd0a:     	movb	%bl, %cl
18000dd0c:     	callq	0x18000e09c <numba_list_iter_next+0xebc>
18000dd11:     	movb	$0x1, %al
18000dd13:     	addq	$0x20, %rsp
18000dd17:     	popq	%rbx
18000dd18:     	retq
18000dd19:     	int3
18000dd1a:     	int3
18000dd1b:     	int3
18000dd1c:     	leaq	0x8fb5(%rip), %rax      # 0x180016cd8
18000dd23:     	retq
18000dd24:     	movl	%ecx, %ecx
18000dd26:     	int	$0x29
18000dd28:     	retq
18000dd29:     	int3
18000dd2a:     	int3
18000dd2b:     	int3
18000dd2c:     	movq	%rbx, 0x8(%rsp)
18000dd31:     	pushq	%rdi
18000dd32:     	subq	$0x20, %rsp
18000dd36:     	leaq	0x480b(%rip), %rbx      # 0x180012548
18000dd3d:     	leaq	0x4804(%rip), %rdi      # 0x180012548
18000dd44:     	jmp	0x18000dd58 <numba_list_iter_next+0xb78>
18000dd46:     	movq	(%rbx), %rax
18000dd49:     	testq	%rax, %rax
18000dd4c:     	je	0x18000dd54 <numba_list_iter_next+0xb74>
18000dd4e:     	callq	*0x15dc(%rip)           # 0x18000f330
18000dd54:     	addq	$0x8, %rbx
18000dd58:     	cmpq	%rdi, %rbx
18000dd5b:     	jb	0x18000dd46 <numba_list_iter_next+0xb66>
18000dd5d:     	movq	0x30(%rsp), %rbx
18000dd62:     	addq	$0x20, %rsp
18000dd66:     	popq	%rdi
18000dd67:     	retq
18000dd68:     	movq	%rbx, 0x8(%rsp)
18000dd6d:     	pushq	%rdi
18000dd6e:     	subq	$0x20, %rsp
18000dd72:     	leaq	0x47df(%rip), %rbx      # 0x180012558
18000dd79:     	leaq	0x47d8(%rip), %rdi      # 0x180012558
18000dd80:     	jmp	0x18000dd94 <numba_list_iter_next+0xbb4>
18000dd82:     	movq	(%rbx), %rax
18000dd85:     	testq	%rax, %rax
18000dd88:     	je	0x18000dd90 <numba_list_iter_next+0xbb0>
18000dd8a:     	callq	*0x15a0(%rip)           # 0x18000f330
18000dd90:     	addq	$0x8, %rbx
18000dd94:     	cmpq	%rdi, %rbx
18000dd97:     	jb	0x18000dd82 <numba_list_iter_next+0xba2>
18000dd99:     	movq	0x30(%rsp), %rbx
18000dd9e:     	addq	$0x20, %rsp
18000dda2:     	popq	%rdi
18000dda3:     	retq
18000dda4:     	retq	$0x0
18000dda7:     	int3
18000dda8:     	movq	%rbx, 0x10(%rsp)
18000ddad:     	movq	%rbp, 0x18(%rsp)
18000ddb2:     	movq	%rsi, 0x20(%rsp)
18000ddb7:     	pushq	%rdi
18000ddb8:     	subq	$0x10, %rsp
18000ddbc:     	xorl	%eax, %eax
18000ddbe:     	xorl	%ecx, %ecx
18000ddc0:     	cpuid
18000ddc2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
18000ddc8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000ddce:     	orl	%ecx, %edx
18000ddd0:     	movl	%eax, %ebp
18000ddd2:     	movl	$0x1, %eax
18000ddd7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000dddd:     	orl	%ebx, %edx
18000dddf:     	leal	-0x1(%rax), %ecx
18000dde2:     	cpuid
18000dde4:     	movl	%ecx, %edi
18000dde6:     	jne	0x18000de46 <numba_list_iter_next+0xc66>
18000dde8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000dded:     	movq	$0x8000, 0x8360(%rip)   # imm = 0x8000
                                                # 0x180016158
18000ddf8:     	movq	$-0x1, 0x835d(%rip)     # 0x180016160
18000de03:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
18000de08:     	je	0x18000de32 <numba_list_iter_next+0xc52>
18000de0a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000de0f:     	je	0x18000de32 <numba_list_iter_next+0xc52>
18000de11:     	cmpl	$0x20670, %eax          # imm = 0x20670
18000de16:     	je	0x18000de32 <numba_list_iter_next+0xc52>
18000de18:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000de1d:     	cmpl	$0x20, %eax
18000de20:     	ja	0x18000de46 <numba_list_iter_next+0xc66>
18000de22:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000de2c:     	btq	%rax, %rcx
18000de30:     	jae	0x18000de46 <numba_list_iter_next+0xc66>
18000de32:     	movl	0x8c1b(%rip), %r8d      # 0x180016a54
18000de39:     	orl	$0x1, %r8d
18000de3d:     	movl	%r8d, 0x8c10(%rip)      # 0x180016a54
18000de44:     	jmp	0x18000de4d <numba_list_iter_next+0xc6d>
18000de46:     	movl	0x8c07(%rip), %r8d      # 0x180016a54
18000de4d:     	xorl	%r9d, %r9d
18000de50:     	movl	%r9d, %r11d
18000de53:     	cmpl	$0x7, %ebp
18000de56:     	jl	0x18000de9a <numba_list_iter_next+0xcba>
18000de58:     	xorl	%ecx, %ecx
18000de5a:     	leal	0x7(%r9), %eax
18000de5e:     	cpuid
18000de60:     	movl	%edx, %esi
18000de62:     	movl	%ebx, %r10d
18000de65:     	btl	$0x9, %ebx
18000de69:     	jae	0x18000de76 <numba_list_iter_next+0xc96>
18000de6b:     	orl	$0x2, %r8d
18000de6f:     	movl	%r8d, 0x8bde(%rip)      # 0x180016a54
18000de76:     	cmpl	$0x1, %eax
18000de79:     	jl	0x18000de88 <numba_list_iter_next+0xca8>
18000de7b:     	movl	$0x7, %eax
18000de80:     	leal	-0x6(%rax), %ecx
18000de83:     	cpuid
18000de85:     	movl	%edx, %r9d
18000de88:     	movl	$0x24, %eax
18000de8d:     	cmpl	%eax, %ebp
18000de8f:     	jl	0x18000dea0 <numba_list_iter_next+0xcc0>
18000de91:     	xorl	%ecx, %ecx
18000de93:     	cpuid
18000de95:     	movl	%ebx, %r11d
18000de98:     	jmp	0x18000dea0 <numba_list_iter_next+0xcc0>
18000de9a:     	movl	%r9d, %r10d
18000de9d:     	movl	%r9d, %esi
18000dea0:     	movq	0x82c1(%rip), %rax      # 0x180016168
18000dea7:     	andq	$-0x2, %rax
18000deab:     	movl	$0x1, 0x829b(%rip)      # 0x180016150
18000deb5:     	movl	$0x2, 0x8295(%rip)      # 0x180016154
18000debf:     	movq	%rax, 0x82a2(%rip)      # 0x180016168
18000dec6:     	btl	$0x14, %edi
18000deca:     	jae	0x18000deeb <numba_list_iter_next+0xd0b>
18000decc:     	andq	$-0x11, %rax
18000ded0:     	movl	$0x2, 0x8276(%rip)      # 0x180016150
18000deda:     	movq	%rax, 0x8287(%rip)      # 0x180016168
18000dee1:     	movl	$0x6, 0x8269(%rip)      # 0x180016154
18000deeb:     	btl	$0x1b, %edi
18000deef:     	jae	0x18000e02c <numba_list_iter_next+0xe4c>
18000def5:     	xorl	%ecx, %ecx
18000def7:     	xgetbv
18000defa:     	shlq	$0x20, %rdx
18000defe:     	orq	%rax, %rdx
18000df01:     	movq	%rdx, 0x20(%rsp)
18000df06:     	btl	$0x1c, %edi
18000df0a:     	jae	0x18000e010 <numba_list_iter_next+0xe30>
18000df10:     	movq	0x20(%rsp), %rax
18000df15:     	andb	$0x6, %al
18000df17:     	cmpb	$0x6, %al
18000df19:     	jne	0x18000e010 <numba_list_iter_next+0xe30>
18000df1f:     	movl	0x822f(%rip), %eax      # 0x180016154
18000df25:     	movb	$-0x20, %dl
18000df27:     	orl	$0x8, %eax
18000df2a:     	movl	$0x3, 0x821c(%rip)      # 0x180016150
18000df34:     	movl	%eax, 0x821a(%rip)      # 0x180016154
18000df3a:     	testb	$0x20, %r10b
18000df3e:     	je	0x18000dfa2 <numba_list_iter_next+0xdc2>
18000df40:     	orl	$0x20, %eax
18000df43:     	movl	$0x5, 0x8203(%rip)      # 0x180016150
18000df4d:     	movl	%eax, 0x8201(%rip)      # 0x180016154
18000df53:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
18000df58:     	movq	0x8209(%rip), %rax      # 0x180016168
18000df5f:     	andl	%ecx, %r10d
18000df62:     	andq	$-0x3, %rax
18000df66:     	movq	%rax, 0x81fb(%rip)      # 0x180016168
18000df6d:     	cmpl	%ecx, %r10d
18000df70:     	jne	0x18000dfa9 <numba_list_iter_next+0xdc9>
18000df72:     	movq	0x20(%rsp), %rax
18000df77:     	andb	%dl, %al
18000df79:     	cmpb	%dl, %al
18000df7b:     	jne	0x18000dfa2 <numba_list_iter_next+0xdc2>
18000df7d:     	movq	0x81e4(%rip), %rax      # 0x180016168
18000df84:     	orl	$0x40, 0x81c9(%rip)     # 0x180016154
18000df8b:     	andq	$-0x25, %rax
18000df8f:     	movl	$0x6, 0x81b7(%rip)      # 0x180016150
18000df99:     	movq	%rax, 0x81c8(%rip)      # 0x180016168
18000dfa0:     	jmp	0x18000dfa9 <numba_list_iter_next+0xdc9>
18000dfa2:     	movq	0x81bf(%rip), %rax      # 0x180016168
18000dfa9:     	btl	$0x17, %esi
18000dfad:     	jae	0x18000dfbb <numba_list_iter_next+0xddb>
18000dfaf:     	btrq	$0x18, %rax
18000dfb4:     	movq	%rax, 0x81ad(%rip)      # 0x180016168
18000dfbb:     	btl	$0x13, %r9d
18000dfc0:     	jae	0x18000e010 <numba_list_iter_next+0xe30>
18000dfc2:     	movq	0x20(%rsp), %rax
18000dfc7:     	andb	%dl, %al
18000dfc9:     	cmpb	%dl, %al
18000dfcb:     	jne	0x18000e010 <numba_list_iter_next+0xe30>
18000dfcd:     	movq	0x8194(%rip), %rdx      # 0x180016168
18000dfd4:     	movl	%r11d, %eax
18000dfd7:     	shrq	$0x10, %rax
18000dfdb:     	movl	%r11d, %ecx
18000dfde:     	andl	$0x6, %eax
18000dfe1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
18000dfe7:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000dfed:     	movl	%ecx, 0x8a65(%rip)      # 0x180016a58
18000dff3:     	notq	%rax
18000dff6:     	andq	%rax, %rdx
18000dff9:     	movq	%rdx, 0x8168(%rip)      # 0x180016168
18000e000:     	cmpb	$0x1, %cl
18000e003:     	jbe	0x18000e010 <numba_list_iter_next+0xe30>
18000e005:     	andq	$-0x41, %rdx
18000e009:     	movq	%rdx, 0x8158(%rip)      # 0x180016168
18000e010:     	btl	$0x15, %r9d
18000e015:     	jae	0x18000e02c <numba_list_iter_next+0xe4c>
18000e017:     	movq	0x20(%rsp), %rax
18000e01c:     	btq	$0x13, %rax
18000e021:     	jae	0x18000e02c <numba_list_iter_next+0xe4c>
18000e023:     	btrq	$0x7, 0x813c(%rip)      # 0x180016168
18000e02c:     	movq	0x28(%rsp), %rbx
18000e031:     	xorl	%eax, %eax
18000e033:     	movq	0x30(%rsp), %rbp
18000e038:     	movq	0x38(%rsp), %rsi
18000e03d:     	addq	$0x10, %rsp
18000e041:     	popq	%rdi
18000e042:     	retq
18000e043:     	int3
18000e044:     	movl	$0x1, %eax
18000e049:     	retq
18000e04a:     	int3
18000e04b:     	int3
18000e04c:     	xorl	%eax, %eax
18000e04e:     	cmpl	%eax, 0x811c(%rip)      # 0x180016170
18000e054:     	setne	%al
18000e057:     	retq
18000e058:     	int3
18000e059:     	int3
18000e05a:     	int3
18000e05b:     	int3
18000e05c:     	int3
18000e05d:     	int3
18000e05e:     	int3
18000e05f:     	int3
18000e060:     	jmpq	*0xfe2(%rip)            # 0x18000f048
18000e066:     	jmpq	*0xfe4(%rip)            # 0x18000f050
18000e06c:     	jmpq	*0x101e(%rip)           # 0x18000f090
18000e072:     	jmpq	*0x1020(%rip)           # 0x18000f098
18000e078:     	jmpq	*0x1022(%rip)           # 0x18000f0a0
18000e07e:     	jmpq	*0x1024(%rip)           # 0x18000f0a8
18000e084:     	jmpq	*0x1026(%rip)           # 0x18000f0b0
18000e08a:     	jmpq	*0xff0(%rip)            # 0x18000f080
18000e090:     	jmpq	*0x1022(%rip)           # 0x18000f0b8
18000e096:     	jmpq	*0xfec(%rip)            # 0x18000f088
18000e09c:     	movb	$0x1, %al
18000e09e:     	retq
18000e09f:     	int3
18000e0a0:     	xorl	%eax, %eax
18000e0a2:     	retq
18000e0a3:     	jmpq	*0xf8f(%rip)            # 0x18000f038
18000e0a9:     	jmpq	*0xf91(%rip)            # 0x18000f040
18000e0af:     	jmpq	*0x1013(%rip)           # 0x18000f0c8
18000e0b5:     	jmpq	*0x1015(%rip)           # 0x18000f0d0
18000e0bb:     	int3
18000e0bc:     	int3
18000e0bd:     	int3
18000e0be:     	int3
18000e0bf:     	int3
18000e0c0:     	int3
18000e0c1:     	int3
18000e0c2:     	int3
18000e0c3:     	int3
18000e0c4:     	int3
18000e0c5:     	int3
18000e0c6:     	nopw	(%rax,%rax)
18000e0d0:     	jmpq	*%rax
18000e0d2:     	int3
18000e0d3:     	int3
18000e0d4:     	int3
18000e0d5:     	int3
18000e0d6:     	int3
18000e0d7:     	int3
18000e0d8:     	int3
18000e0d9:     	int3
18000e0da:     	int3
18000e0db:     	int3
18000e0dc:     	int3
18000e0dd:     	int3
18000e0de:     	int3
18000e0df:     	int3
18000e0e0:     	int3
18000e0e1:     	int3
18000e0e2:     	int3
18000e0e3:     	int3
18000e0e4:     	int3
18000e0e5:     	int3
18000e0e6:     	nopw	(%rax,%rax)
18000e0f0:     	jmpq	*0x123a(%rip)           # 0x18000f330
18000e0f6:     	pushq	%rbp
18000e0f8:     	subq	$0x20, %rsp
18000e0fc:     	movq	%rdx, %rbp
18000e0ff:     	movb	0x40(%rbp), %cl
18000e102:     	addq	$0x20, %rsp
18000e106:     	popq	%rbp
18000e107:     	jmp	0x18000dccc <numba_list_iter_next+0xaec>
18000e10c:     	int3
18000e10d:     	pushq	%rbp
18000e10f:     	subq	$0x20, %rsp
18000e113:     	movq	%rdx, %rbp
18000e116:     	movb	0x20(%rbp), %cl
18000e119:     	callq	0x18000dccc <numba_list_iter_next+0xaec>
18000e11e:     	nop
18000e11f:     	addq	$0x20, %rsp
18000e123:     	popq	%rbp
18000e124:     	retq
18000e125:     	int3
18000e126:     	pushq	%rbp
18000e128:     	subq	$0x20, %rsp
18000e12c:     	movq	%rdx, %rbp
18000e12f:     	addq	$0x20, %rsp
18000e133:     	popq	%rbp
18000e134:     	jmp	0x18000db58 <numba_list_iter_next+0x978>
18000e139:     	int3
18000e13a:     	pushq	%rbp
18000e13c:     	subq	$0x30, %rsp
18000e140:     	movq	%rdx, %rbp
18000e143:     	movq	(%rcx), %rax
18000e146:     	movl	(%rax), %edx
18000e148:     	movq	%rcx, 0x28(%rsp)
18000e14d:     	movl	%edx, 0x20(%rsp)
18000e151:     	leaq	-0xbc8(%rip), %r9       # 0x18000d590 <numba_list_iter_next+0x3b0>
18000e158:     	movq	0x70(%rbp), %r8
18000e15c:     	movl	0x68(%rbp), %edx
18000e15f:     	movq	0x60(%rbp), %rcx
18000e163:     	callq	0x18000dac8 <numba_list_iter_next+0x8e8>
18000e168:     	nop
18000e169:     	addq	$0x30, %rsp
18000e16d:     	popq	%rbp
18000e16e:     	retq
18000e16f:     	int3
18000e170:     	pushq	%rbp
18000e172:     	movq	%rdx, %rbp
18000e175:     	movq	(%rcx), %rax
18000e178:     	xorl	%ecx, %ecx
18000e17a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
18000e180:     	sete	%cl
18000e183:     	movl	%ecx, %eax
18000e185:     	popq	%rbp
18000e186:     	retq
18000e187:     	int3
