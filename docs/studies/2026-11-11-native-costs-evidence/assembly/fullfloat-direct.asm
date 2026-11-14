
D:\Code\Datathon\recompyler-codex-20261111\wave6-study\results-v2\cache\fullfloat-direct\recompyler\rcaotr_9593466dcbd0d86cb0e5e730.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x18000af20 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0xb3d9(%rip), %rax      # 0x18000c460
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
18000109c:     	subq	$0x1a8, %rsp            # imm = 0x1A8
1800010a3:     	movapd	%xmm8, 0x190(%rsp)
1800010ad:     	movaps	%xmm7, 0x180(%rsp)
1800010b5:     	movapd	%xmm6, 0x170(%rsp)
1800010be:     	movq	0x2f8(%rsp), %r11
1800010c6:     	movq	0x2c8(%rsp), %r15
1800010ce:     	movq	0x290(%rsp), %rbp
1800010d6:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
1800010e0:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
1800010ea:     	xorpd	%xmm0, %xmm0
1800010ee:     	movapd	%xmm0, 0x150(%rsp)
1800010f7:     	leaq	(%r11,%rax), %rsi
1800010fb:     	cmpq	%r10, %rsi
1800010fe:     	jb	0x180001110 <.text+0x110>
180001100:     	movq	0x300(%rsp), %rsi
180001108:     	addq	%rsi, %rax
18000110b:     	cmpq	%r10, %rax
18000110e:     	jae	0x180001152 <.text+0x152>
180001110:     	movb	$0x1, (%r15)
180001114:     	movq	$0x4, 0x18(%rbp)
18000111c:     	xorl	%eax, %eax
18000111e:     	movq	$0x0, (%rcx)
180001125:     	movaps	0x170(%rsp), %xmm6
18000112d:     	movaps	0x180(%rsp), %xmm7
180001135:     	movaps	0x190(%rsp), %xmm8
18000113e:     	addq	$0x1a8, %rsp            # imm = 0x1A8
180001145:     	popq	%rbx
180001146:     	popq	%rbp
180001147:     	popq	%rdi
180001148:     	popq	%rsi
180001149:     	popq	%r12
18000114b:     	popq	%r13
18000114d:     	popq	%r14
18000114f:     	popq	%r15
180001151:     	retq
180001152:     	movq	0x260(%rsp), %r12
18000115a:     	movq	(%rbp), %r10
18000115e:     	leaq	0x4(%r10), %rax
180001162:     	cmpq	%r12, %rax
180001165:     	jle	0x18000116d <.text+0x16d>
180001167:     	movb	$0x2, (%r15)
18000116b:     	jmp	0x18000111c <.text+0x11c>
18000116d:     	movq	%rax, (%rbp)
180001171:     	xorl	%eax, %eax
180001173:     	cmpb	$0x0, (%r15)
180001177:     	jne	0x18000111e <.text+0x11e>
180001179:     	movq	0x220(%rsp), %r13
180001181:     	xorps	%xmm0, %xmm0
180001184:     	cvtsi2sd	%r11, %xmm0
180001189:     	movsd	0xb21f(%rip), %xmm1     # 0x18000c3b0
180001191:     	mulsd	%xmm1, %xmm0
180001195:     	cvtsi2sd	%rsi, %xmm2
18000119a:     	mulsd	%xmm1, %xmm2
18000119e:     	movsd	%xmm0, 0x10(%r13,%r10,8)
1800011a5:     	movsd	%xmm2, 0x18(%r13,%r10,8)
1800011ac:     	movsd	%xmm0, 0x8(%r13,%r10,8)
1800011b3:     	movsd	%xmm2, (%r13,%r10,8)
1800011ba:     	cmpb	$0x0, (%r15)
1800011be:     	jne	0x18000111e <.text+0x11e>
1800011c4:     	movq	(%rbp), %r14
1800011c8:     	leaq	0xa(%r14), %r11
1800011cc:     	cmpq	%r12, %r11
1800011cf:     	jle	0x1800011da <.text+0x1da>
1800011d1:     	movb	$0x2, (%r15)
1800011d5:     	jmp	0x18000111e <.text+0x11e>
1800011da:     	movq	%r11, (%rbp)
1800011de:     	cmpb	$0x0, (%r15)
1800011e2:     	jne	0x18000111e <.text+0x11e>
1800011e8:     	movq	0x258(%rsp), %rdi
1800011f0:     	movq	%r10, (%rdi,%r14,8)
1800011f4:     	movq	$0x4, 0x8(%rdi,%r14,8)
1800011fd:     	movq	(%rbp), %r10
180001201:     	cmpq	%r12, %r10
180001204:     	movq	%r10, %r11
180001207:     	jle	0x180001214 <.text+0x214>
180001209:     	movb	$0x2, (%r15)
18000120d:     	movq	(%rbp), %r10
180001211:     	xorl	%r11d, %r11d
180001214:     	leaq	0x3(%r10), %rsi
180001218:     	cmpq	%r12, %rsi
18000121b:     	jg	0x1800011d1 <.text+0x1d1>
18000121d:     	movq	%rsi, (%rbp)
180001221:     	cmpb	$0x0, (%r15)
180001225:     	jne	0x18000111e <.text+0x11e>
18000122b:     	movq	%r10, %rsi
18000122e:     	sarq	$0x3f, %rsi
180001232:     	andq	%r12, %rsi
180001235:     	leaq	(%rdi,%r10,8), %rdi
180001239:     	movq	$0x0, (%rdi,%rsi,8)
180001241:     	xorl	%esi, %esi
180001243:     	cmpq	$-0x1, %r10
180001247:     	movl	$0x0, %ebx
18000124c:     	cmovlq	%r12, %rbx
180001250:     	movq	$0x0, 0x8(%rdi,%rbx,8)
180001259:     	cmpq	$-0x2, %r10
18000125d:     	cmovlq	%r12, %rsi
180001261:     	movq	%r11, 0x10(%rdi,%rsi,8)
180001266:     	cmpb	$0x0, (%r15)
18000126a:     	jne	0x18000111c <.text+0x11c>
180001270:     	movq	0x258(%rsp), %r11
180001278:     	leaq	(%r11,%r14,8), %r11
18000127c:     	movq	%r10, 0x30(%r11)
180001280:     	movq	$0x0, 0x18(%r11)
180001288:     	movq	(%rbp), %r10
18000128c:     	leaq	0x2(%r10), %rsi
180001290:     	cmpq	%r12, %rsi
180001293:     	jg	0x1800011d1 <.text+0x1d1>
180001299:     	movq	%r8, 0x140(%rsp)
1800012a1:     	movq	%r9, 0x148(%rsp)
1800012a9:     	movq	%rdx, 0x138(%rsp)
1800012b1:     	movq	%rsi, (%rbp)
1800012b5:     	cmpb	$0x0, (%r15)
1800012b9:     	jne	0x18000111c <.text+0x11c>
1800012bf:     	movq	%rcx, 0x118(%rsp)
1800012c7:     	movq	$0x0, 0x8(%r13,%r10,8)
1800012d0:     	movq	$0x0, (%r13,%r10,8)
1800012d9:     	cmpb	$0x0, (%r15)
1800012dd:     	jne	0x180001312 <.text+0x312>
1800012df:     	movq	%r10, 0x10(%r11)
1800012e3:     	movq	$0x0, 0x48(%r13,%r14,8)
1800012ec:     	movq	$-0x1, 0x28(%r11)
1800012f4:     	movq	$-0x1, 0x20(%r11)
1800012fc:     	movq	$-0x1, 0x38(%r11)
180001304:     	movq	$-0x1, 0x40(%r11)
18000130c:     	cmpb	$0x0, (%r15)
180001310:     	je	0x180001321 <.text+0x321>
180001312:     	xorl	%eax, %eax
180001314:     	movq	0x118(%rsp), %rcx
18000131c:     	jmp	0x18000111e <.text+0x11e>
180001321:     	movq	0x2e0(%rsp), %rdx
180001329:     	movq	%rdx, %rax
18000132c:     	sarq	$0x3f, %rax
180001330:     	andq	%r12, %rax
180001333:     	movq	0x258(%rsp), %rcx
18000133b:     	leaq	(%rcx,%rdx,8), %rcx
18000133f:     	movq	%rax, 0x128(%rsp)
180001347:     	movq	%rcx, %rbx
18000134a:     	cmpq	$0x0, (%rcx,%rax,8)
18000134f:     	jle	0x180001579 <.text+0x579>
180001355:     	xorl	%esi, %esi
180001357:     	cmpq	$-0x2, 0x2e0(%rsp)
180001360:     	movl	$0x0, %edi
180001365:     	cmovlq	%r12, %rdi
180001369:     	movq	0x8(%rbp), %rax
18000136d:     	movq	0x10(%rbx,%rdi,8), %rcx
180001372:     	addq	%rsi, %rcx
180001375:     	movq	0x258(%rsp), %rdx
18000137d:     	leaq	(%rdx,%rcx,8), %rdx
180001381:     	sarq	$0x3f, %rcx
180001385:     	andq	%r12, %rcx
180001388:     	movq	(%rdx,%rcx,8), %rcx
18000138c:     	leaq	0x1(%rax), %rdx
180001390:     	movq	%rdx, 0x8(%rbp)
180001394:     	cmpq	0x10(%rbp), %rax
180001398:     	jge	0x18000185d <.text+0x85d>
18000139e:     	movq	%rcx, 0x100(%rsp)
1800013a6:     	movq	%r14, 0xf8(%rsp)
1800013ae:     	movq	0x2d8(%rsp), %rax
1800013b6:     	movq	%rax, 0xe8(%rsp)
1800013be:     	movq	0x2d0(%rsp), %rax
1800013c6:     	movq	%rax, 0xe0(%rsp)
1800013ce:     	movq	%r15, 0xd8(%rsp)
1800013d6:     	movq	0x2c0(%rsp), %rax
1800013de:     	movq	%rax, 0xd0(%rsp)
1800013e6:     	movq	0x2b8(%rsp), %rax
1800013ee:     	movq	%rax, 0xc8(%rsp)
1800013f6:     	movq	0x2b0(%rsp), %rax
1800013fe:     	movq	%rax, 0xc0(%rsp)
180001406:     	movq	0x2a8(%rsp), %rax
18000140e:     	movq	%rax, 0xb8(%rsp)
180001416:     	movq	0x2a0(%rsp), %rax
18000141e:     	movq	%rax, 0xb0(%rsp)
180001426:     	movq	0x298(%rsp), %rax
18000142e:     	movq	%rax, 0xa8(%rsp)
180001436:     	movq	%rbp, 0xa0(%rsp)
18000143e:     	movq	0x288(%rsp), %rax
180001446:     	movq	%rax, 0x98(%rsp)
18000144e:     	movq	0x280(%rsp), %rax
180001456:     	movq	%rax, 0x90(%rsp)
18000145e:     	movq	0x278(%rsp), %rax
180001466:     	movq	%rax, 0x88(%rsp)
18000146e:     	movq	0x270(%rsp), %rax
180001476:     	movq	%rax, 0x80(%rsp)
18000147e:     	movq	0x268(%rsp), %rax
180001486:     	movq	%rax, 0x78(%rsp)
18000148b:     	movq	%r12, 0x70(%rsp)
180001490:     	movq	0x258(%rsp), %rax
180001498:     	movq	%rax, 0x68(%rsp)
18000149d:     	movq	0x250(%rsp), %rax
1800014a5:     	movq	%rax, 0x60(%rsp)
1800014aa:     	movq	0x248(%rsp), %rax
1800014b2:     	movq	%rax, 0x58(%rsp)
1800014b7:     	movq	0x240(%rsp), %rax
1800014bf:     	movq	%rax, 0x50(%rsp)
1800014c4:     	movq	0x238(%rsp), %rax
1800014cc:     	movq	%rax, 0x48(%rsp)
1800014d1:     	movq	0x230(%rsp), %rax
1800014d9:     	movq	%rax, 0x40(%rsp)
1800014de:     	movq	0x228(%rsp), %rax
1800014e6:     	movq	%rax, 0x38(%rsp)
1800014eb:     	movq	%r13, 0x30(%rsp)
1800014f0:     	movq	0x218(%rsp), %rax
1800014f8:     	movq	%rax, 0x28(%rsp)
1800014fd:     	movq	0x210(%rsp), %rax
180001505:     	movq	%rax, 0x20(%rsp)
18000150a:     	movq	$-0x1, 0x108(%rsp)
180001516:     	movq	$0x0, 0xf0(%rsp)
180001522:     	leaq	0x127(%rsp), %rcx
18000152a:     	leaq	0x160(%rsp), %rdx
180001532:     	movq	0x140(%rsp), %r8
18000153a:     	movq	0x148(%rsp), %r9
180001542:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180001547:     	testl	%eax, %eax
180001549:     	jne	0x180001850 <.text+0x850>
18000154f:     	cmpb	$0x0, (%r15)
180001553:     	jne	0x180001312 <.text+0x312>
180001559:     	incq	%rsi
18000155c:     	movq	0x8(%rbp), %rax
180001560:     	decq	%rax
180001563:     	movq	%rax, 0x8(%rbp)
180001567:     	movq	0x128(%rsp), %rcx
18000156f:     	cmpq	(%rbx,%rcx,8), %rsi
180001573:     	jl	0x18000136d <.text+0x36d>
180001579:     	movsd	0x2f0(%rsp), %xmm6
180001582:     	movsd	0x2e8(%rsp), %xmm7
18000158b:     	xorl	%esi, %esi
18000158d:     	cmpq	$-0x2, 0x2e0(%rsp)
180001596:     	movl	$0x0, %eax
18000159b:     	cmovlq	%r12, %rax
18000159f:     	movq	%rax, 0x130(%rsp)
1800015a7:     	xorpd	%xmm8, %xmm8
1800015ac:     	jmp	0x1800015c7 <.text+0x5c7>
1800015ae:     	movb	$0x1, (%r15)
1800015b2:     	movq	$0x4c4b43, 0x18(%rbp)   # imm = 0x4C4B43
1800015ba:     	incq	%rsi
1800015bd:     	cmpb	$0x0, (%r15)
1800015c1:     	jne	0x18000195c <.text+0x95c>
1800015c7:     	movq	0x128(%rsp), %rax
1800015cf:     	cmpq	(%rbx,%rax,8), %rsi
1800015d3:     	jge	0x18000186e <.text+0x86e>
1800015d9:     	movq	0x130(%rsp), %rax
1800015e1:     	movq	0x10(%rbx,%rax,8), %rax
1800015e6:     	addq	%rsi, %rax
1800015e9:     	movq	0x258(%rsp), %rcx
1800015f1:     	leaq	(%rcx,%rax,8), %rcx
1800015f5:     	sarq	$0x3f, %rax
1800015f9:     	andq	%r12, %rax
1800015fc:     	movq	(%rcx,%rax,8), %rdi
180001600:     	movq	0x8(%rbp), %rax
180001604:     	leaq	0x1(%rax), %rcx
180001608:     	movq	%rcx, 0x8(%rbp)
18000160c:     	cmpq	0x10(%rbp), %rax
180001610:     	jge	0x180001969 <.text+0x969>
180001616:     	movsd	%xmm7, 0x100(%rsp)
18000161f:     	movq	%rdi, 0xf8(%rsp)
180001627:     	movq	%r14, 0xf0(%rsp)
18000162f:     	movq	0x2d8(%rsp), %rax
180001637:     	movq	%rax, 0xe8(%rsp)
18000163f:     	movq	0x2d0(%rsp), %rax
180001647:     	movq	%rax, 0xe0(%rsp)
18000164f:     	movq	%r15, 0xd8(%rsp)
180001657:     	movq	0x2c0(%rsp), %rax
18000165f:     	movq	%rax, 0xd0(%rsp)
180001667:     	movq	0x2b8(%rsp), %rax
18000166f:     	movq	%rax, 0xc8(%rsp)
180001677:     	movq	0x2b0(%rsp), %rax
18000167f:     	movq	%rax, 0xc0(%rsp)
180001687:     	movq	0x2a8(%rsp), %rax
18000168f:     	movq	%rax, 0xb8(%rsp)
180001697:     	movq	0x2a0(%rsp), %rax
18000169f:     	movq	%rax, 0xb0(%rsp)
1800016a7:     	movq	0x298(%rsp), %rax
1800016af:     	movq	%rax, 0xa8(%rsp)
1800016b7:     	movq	%rbp, 0xa0(%rsp)
1800016bf:     	movq	0x288(%rsp), %rax
1800016c7:     	movq	%rax, 0x98(%rsp)
1800016cf:     	movq	0x280(%rsp), %rax
1800016d7:     	movq	%rax, 0x90(%rsp)
1800016df:     	movq	0x278(%rsp), %rax
1800016e7:     	movq	%rax, 0x88(%rsp)
1800016ef:     	movq	0x270(%rsp), %rax
1800016f7:     	movq	%rax, 0x80(%rsp)
1800016ff:     	movq	0x268(%rsp), %rax
180001707:     	movq	%rax, 0x78(%rsp)
18000170c:     	movq	%r12, 0x70(%rsp)
180001711:     	movq	0x258(%rsp), %rax
180001719:     	movq	%rax, 0x68(%rsp)
18000171e:     	movq	0x250(%rsp), %rax
180001726:     	movq	%rax, 0x60(%rsp)
18000172b:     	movq	0x248(%rsp), %rax
180001733:     	movq	%rax, 0x58(%rsp)
180001738:     	movq	0x240(%rsp), %rax
180001740:     	movq	%rax, 0x50(%rsp)
180001745:     	movq	0x238(%rsp), %rax
18000174d:     	movq	%rax, 0x48(%rsp)
180001752:     	movq	0x230(%rsp), %rax
18000175a:     	movq	%rax, 0x40(%rsp)
18000175f:     	movq	0x228(%rsp), %rax
180001767:     	movq	%rax, 0x38(%rsp)
18000176c:     	movq	%r13, 0x30(%rsp)
180001771:     	movq	0x218(%rsp), %rax
180001779:     	movq	%rax, 0x28(%rsp)
18000177e:     	movq	0x210(%rsp), %rax
180001786:     	movq	%rax, 0x20(%rsp)
18000178b:     	leaq	0x150(%rsp), %rcx
180001793:     	leaq	0x168(%rsp), %rdx
18000179b:     	movq	0x140(%rsp), %r8
1800017a3:     	movq	0x148(%rsp), %r9
1800017ab:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
1800017b0:     	testl	%eax, %eax
1800017b2:     	jne	0x180001850 <.text+0x850>
1800017b8:     	xorl	%eax, %eax
1800017ba:     	cmpb	$0x0, (%r15)
1800017be:     	jne	0x18000195c <.text+0x95c>
1800017c4:     	movsd	0x150(%rsp), %xmm1
1800017cd:     	movsd	0x158(%rsp), %xmm0
1800017d6:     	decq	0x8(%rbp)
1800017da:     	movsd	0x8(%r13,%rdi,8), %xmm2
1800017e1:     	ucomisd	%xmm8, %xmm2
1800017e6:     	jne	0x1800017ee <.text+0x7ee>
1800017e8:     	jnp	0x1800015ae <.text+0x5ae>
1800017ee:     	movq	0x258(%rsp), %rcx
1800017f6:     	movq	(%rcx,%rdi,8), %rcx
1800017fa:     	divsd	%xmm2, %xmm1
1800017fe:     	addsd	(%r13,%rcx,8), %xmm1
180001805:     	movsd	%xmm1, (%r13,%rcx,8)
18000180c:     	movsd	0x8(%r13,%rdi,8), %xmm1
180001813:     	ucomisd	%xmm8, %xmm1
180001818:     	jne	0x18000182d <.text+0x82d>
18000181a:     	jp	0x18000182d <.text+0x82d>
18000181c:     	movb	$0x1, (%r15)
180001820:     	movq	$0x4c4b44, 0x18(%rbp)   # imm = 0x4C4B44
180001828:     	jmp	0x1800015ba <.text+0x5ba>
18000182d:     	movq	0x258(%rsp), %rcx
180001835:     	movq	(%rcx,%rdi,8), %rcx
180001839:     	divsd	%xmm1, %xmm0
18000183d:     	addsd	0x8(%r13,%rcx,8), %xmm0
180001844:     	movsd	%xmm0, 0x8(%r13,%rcx,8)
18000184b:     	jmp	0x1800015ba <.text+0x5ba>
180001850:     	movq	0x138(%rsp), %rcx
180001858:     	jmp	0x18000111e <.text+0x11e>
18000185d:     	movb	$0x1, (%r15)
180001861:     	movq	$0x9, 0x18(%rbp)
180001869:     	jmp	0x180001312 <.text+0x312>
18000186e:     	xorl	%eax, %eax
180001870:     	xorl	%ecx, %ecx
180001872:     	movq	0x128(%rsp), %rdx
18000187a:     	cmpq	(%rbx,%rdx,8), %rcx
18000187e:     	jge	0x18000195c <.text+0x95c>
180001884:     	movq	0x130(%rsp), %rdx
18000188c:     	movq	0x10(%rbx,%rdx,8), %rdx
180001891:     	addq	%rcx, %rdx
180001894:     	movq	0x258(%rsp), %r10
18000189c:     	leaq	(%r10,%rdx,8), %r8
1800018a0:     	sarq	$0x3f, %rdx
1800018a4:     	andq	%r12, %rdx
1800018a7:     	movq	(%r8,%rdx,8), %rdx
1800018ab:     	incq	%rcx
1800018ae:     	movq	(%r10,%rdx,8), %r8
1800018b2:     	movq	0x18(%r10,%rdx,8), %r9
1800018b7:     	movsd	(%r13,%r8,8), %xmm0
1800018be:     	mulsd	%xmm6, %xmm0
1800018c2:     	addsd	(%r13,%r9,8), %xmm0
1800018c9:     	movsd	%xmm0, (%r13,%r9,8)
1800018d0:     	movq	(%r10,%rdx,8), %r8
1800018d4:     	movq	0x18(%r10,%rdx,8), %r9
1800018d9:     	movsd	0x8(%r13,%r8,8), %xmm0
1800018e0:     	mulsd	%xmm6, %xmm0
1800018e4:     	addsd	0x8(%r13,%r9,8), %xmm0
1800018eb:     	movsd	%xmm0, 0x8(%r13,%r9,8)
1800018f2:     	movq	0x10(%r10,%rdx,8), %r8
1800018f7:     	movq	0x18(%r10,%rdx,8), %r9
1800018fc:     	movsd	(%r13,%r9,8), %xmm0
180001903:     	mulsd	%xmm6, %xmm0
180001907:     	addsd	(%r13,%r8,8), %xmm0
18000190e:     	movsd	%xmm0, (%r13,%r8,8)
180001915:     	movq	0x10(%r10,%rdx,8), %r8
18000191a:     	movq	0x18(%r10,%rdx,8), %r9
18000191f:     	movsd	0x8(%r13,%r9,8), %xmm0
180001926:     	mulsd	%xmm6, %xmm0
18000192a:     	addsd	0x8(%r13,%r8,8), %xmm0
180001931:     	movsd	%xmm0, 0x8(%r13,%r8,8)
180001938:     	movq	(%r10,%rdx,8), %r8
18000193c:     	movq	$0x0, (%r13,%r8,8)
180001945:     	movq	(%r10,%rdx,8), %rdx
180001949:     	movq	$0x0, 0x8(%r13,%rdx,8)
180001952:     	cmpb	$0x0, (%r15)
180001956:     	je	0x180001872 <.text+0x872>
18000195c:     	movq	0x118(%rsp), %rcx
180001964:     	jmp	0x18000111e <.text+0x11e>
180001969:     	movb	$0x1, (%r15)
18000196d:     	movq	$0xd, 0x18(%rbp)
180001975:     	jmp	0x180001312 <.text+0x312>
18000197a:     	nopw	(%rax,%rax)
180001980:     	pushq	%r15
180001982:     	pushq	%r14
180001984:     	pushq	%r13
180001986:     	pushq	%r12
180001988:     	pushq	%rsi
180001989:     	pushq	%rdi
18000198a:     	pushq	%rbp
18000198b:     	pushq	%rbx
18000198c:     	subq	$0x338, %rsp            # imm = 0x338
180001993:     	movaps	%xmm7, 0x320(%rsp)
18000199b:     	movaps	%xmm6, 0x310(%rsp)
1800019a3:     	movq	%rdx, %rcx
1800019a6:     	leaq	0x1c8(%rsp), %rax
1800019ae:     	movq	%rax, 0x60(%rsp)
1800019b3:     	leaq	0x1d0(%rsp), %rax
1800019bb:     	movq	%rax, 0x58(%rsp)
1800019c0:     	leaq	0x1d8(%rsp), %rax
1800019c8:     	movq	%rax, 0x50(%rsp)
1800019cd:     	leaq	0x1e0(%rsp), %rax
1800019d5:     	movq	%rax, 0x48(%rsp)
1800019da:     	leaq	0x1e8(%rsp), %rax
1800019e2:     	movq	%rax, 0x40(%rsp)
1800019e7:     	leaq	0x1f0(%rsp), %rax
1800019ef:     	movq	%rax, 0x38(%rsp)
1800019f4:     	leaq	0x1f8(%rsp), %rax
1800019fc:     	movq	%rax, 0x30(%rsp)
180001a01:     	leaq	0x200(%rsp), %rax
180001a09:     	movq	%rax, 0x28(%rsp)
180001a0e:     	leaq	0x208(%rsp), %rax
180001a16:     	movq	%rax, 0x20(%rsp)
180001a1b:     	leaq	0xaa6e(%rip), %rdx      # 0x18000c490
180001a22:     	movl	$0x9, %r8d
180001a28:     	movl	$0x9, %r9d
180001a2e:     	callq	0x18000b0d1 <numba_list_iter_next+0x311>
180001a33:     	testl	%eax, %eax
180001a35:     	movq	$0x0, 0x130(%rsp)
180001a41:     	je	0x18000213c <.text+0x113c>
180001a47:     	cmpq	$0x0, 0x12281(%rip)     # 0x180013cd0
180001a4f:     	je	0x180002064 <.text+0x1064>
180001a55:     	movq	0x208(%rsp), %rcx
180001a5d:     	xorps	%xmm0, %xmm0
180001a60:     	movaps	%xmm0, 0x2d0(%rsp)
180001a68:     	movaps	%xmm0, 0x2e0(%rsp)
180001a70:     	movaps	%xmm0, 0x2f0(%rsp)
180001a78:     	movq	$0x0, 0x300(%rsp)
180001a84:     	leaq	0x2d0(%rsp), %rdx
180001a8c:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180001a91:     	testl	%eax, %eax
180001a93:     	jne	0x18000207c <.text+0x107c>
180001a99:     	cmpq	$0x8, 0x2e8(%rsp)
180001aa2:     	jne	0x18000207c <.text+0x107c>
180001aa8:     	movq	0x2d0(%rsp), %rbx
180001ab0:     	movq	0x2d8(%rsp), %rbp
180001ab8:     	movq	0x2e0(%rsp), %rsi
180001ac0:     	movq	0x2f0(%rsp), %rdi
180001ac8:     	movq	0x2f8(%rsp), %r15
180001ad0:     	movq	0x300(%rsp), %r13
180001ad8:     	movq	0x200(%rsp), %rcx
180001ae0:     	xorps	%xmm0, %xmm0
180001ae3:     	movaps	%xmm0, 0x290(%rsp)
180001aeb:     	movaps	%xmm0, 0x2a0(%rsp)
180001af3:     	movaps	%xmm0, 0x2b0(%rsp)
180001afb:     	movq	$0x0, 0x2c0(%rsp)
180001b07:     	leaq	0x290(%rsp), %rdx
180001b0f:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180001b14:     	testl	%eax, %eax
180001b16:     	jne	0x180002094 <.text+0x1094>
180001b1c:     	cmpq	$0x8, 0x2a8(%rsp)
180001b25:     	jne	0x180002094 <.text+0x1094>
180001b2b:     	movq	0x290(%rsp), %r12
180001b33:     	movq	0x298(%rsp), %r14
180001b3b:     	movq	0x2a0(%rsp), %rax
180001b43:     	movq	%rax, 0x1c0(%rsp)
180001b4b:     	movq	0x2b0(%rsp), %rax
180001b53:     	movq	%rax, 0x1b8(%rsp)
180001b5b:     	movq	0x2b8(%rsp), %rax
180001b63:     	movq	%rax, 0x1b0(%rsp)
180001b6b:     	movq	0x2c0(%rsp), %rax
180001b73:     	movq	%rax, 0x1a8(%rsp)
180001b7b:     	movq	0x1f8(%rsp), %rcx
180001b83:     	xorps	%xmm0, %xmm0
180001b86:     	movaps	%xmm0, 0x250(%rsp)
180001b8e:     	movaps	%xmm0, 0x260(%rsp)
180001b96:     	movaps	%xmm0, 0x270(%rsp)
180001b9e:     	movq	$0x0, 0x280(%rsp)
180001baa:     	leaq	0x250(%rsp), %rdx
180001bb2:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180001bb7:     	testl	%eax, %eax
180001bb9:     	jne	0x1800020ac <.text+0x10ac>
180001bbf:     	cmpq	$0x8, 0x268(%rsp)
180001bc8:     	jne	0x1800020ac <.text+0x10ac>
180001bce:     	movq	%r14, 0x1a0(%rsp)
180001bd6:     	movq	0x250(%rsp), %r14
180001bde:     	movq	0x258(%rsp), %rax
180001be6:     	movq	%rax, 0x198(%rsp)
180001bee:     	movq	0x260(%rsp), %rax
180001bf6:     	movq	%rax, 0x190(%rsp)
180001bfe:     	movq	0x270(%rsp), %rax
180001c06:     	movq	%rax, 0x188(%rsp)
180001c0e:     	movq	0x278(%rsp), %rax
180001c16:     	movq	%rax, 0x180(%rsp)
180001c1e:     	movq	0x280(%rsp), %rax
180001c26:     	movq	%rax, 0x178(%rsp)
180001c2e:     	movq	0x1f0(%rsp), %rcx
180001c36:     	xorps	%xmm0, %xmm0
180001c39:     	movaps	%xmm0, 0x210(%rsp)
180001c41:     	movaps	%xmm0, 0x220(%rsp)
180001c49:     	movaps	%xmm0, 0x230(%rsp)
180001c51:     	movq	$0x0, 0x240(%rsp)
180001c5d:     	leaq	0x210(%rsp), %rdx
180001c65:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180001c6a:     	testl	%eax, %eax
180001c6c:     	jne	0x1800020c1 <.text+0x10c1>
180001c72:     	cmpq	$0x1, 0x228(%rsp)
180001c7b:     	jne	0x1800020c1 <.text+0x10c1>
180001c81:     	movq	%r13, 0x150(%rsp)
180001c89:     	movq	%r15, 0x158(%rsp)
180001c91:     	movq	%rdi, 0x160(%rsp)
180001c99:     	movq	%rsi, 0x168(%rsp)
180001ca1:     	movq	0x210(%rsp), %r15
180001ca9:     	movq	0x218(%rsp), %rax
180001cb1:     	movq	%rax, 0x148(%rsp)
180001cb9:     	movq	0x220(%rsp), %rax
180001cc1:     	movq	%rax, 0x140(%rsp)
180001cc9:     	movq	0x230(%rsp), %rax
180001cd1:     	movq	%rax, 0x138(%rsp)
180001cd9:     	movq	0x238(%rsp), %rdi
180001ce1:     	movq	0x240(%rsp), %rsi
180001ce9:     	movq	0x1e8(%rsp), %rcx
180001cf1:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
180001cf6:     	testq	%rax, %rax
180001cf9:     	movq	%rbx, 0x128(%rsp)
180001d01:     	movq	%r12, 0x120(%rsp)
180001d09:     	movq	%rbp, 0x170(%rsp)
180001d11:     	je	0x1800020d6 <.text+0x10d6>
180001d17:     	movq	%rax, %r13
180001d1a:     	movq	%rax, %rcx
180001d1d:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
180001d22:     	movq	%rax, %r12
180001d25:     	movq	%r13, %rcx
180001d28:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180001d2d:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180001d32:     	testq	%rax, %rax
180001d35:     	jne	0x18000210c <.text+0x110c>
180001d3b:     	movq	0x1e0(%rsp), %rcx
180001d43:     	callq	0x18000b0ef <numba_list_iter_next+0x32f>
180001d48:     	movq	%rax, %rbx
180001d4b:     	movq	%rax, %rcx
180001d4e:     	callq	0x18000b0f5 <numba_list_iter_next+0x335>
180001d53:     	movaps	%xmm0, %xmm6
180001d56:     	movq	%rbx, %rcx
180001d59:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180001d5e:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180001d63:     	testq	%rax, %rax
180001d66:     	jne	0x18000210c <.text+0x110c>
180001d6c:     	movq	0x1d8(%rsp), %rcx
180001d74:     	callq	0x18000b0ef <numba_list_iter_next+0x32f>
180001d79:     	movq	%rax, %rbx
180001d7c:     	movq	%rax, %rcx
180001d7f:     	callq	0x18000b0f5 <numba_list_iter_next+0x335>
180001d84:     	movaps	%xmm0, %xmm7
180001d87:     	movq	%rbx, %rcx
180001d8a:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180001d8f:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180001d94:     	testq	%rax, %rax
180001d97:     	jne	0x18000210c <.text+0x110c>
180001d9d:     	movq	0x1d0(%rsp), %rcx
180001da5:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
180001daa:     	testq	%rax, %rax
180001dad:     	je	0x1800020e9 <.text+0x10e9>
180001db3:     	movq	%rax, %rbp
180001db6:     	movq	%rax, %rcx
180001db9:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
180001dbe:     	movq	%rax, %r13
180001dc1:     	movq	%rbp, %rcx
180001dc4:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180001dc9:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180001dce:     	testq	%rax, %rax
180001dd1:     	jne	0x18000210c <.text+0x110c>
180001dd7:     	movq	0x1c8(%rsp), %rcx
180001ddf:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
180001de4:     	testq	%rax, %rax
180001de7:     	je	0x1800020fc <.text+0x10fc>
180001ded:     	movq	%rax, %rbx
180001df0:     	movq	%rax, %rcx
180001df3:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
180001df8:     	movq	%rax, %rbp
180001dfb:     	movq	%rbx, %rcx
180001dfe:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180001e03:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180001e08:     	testq	%rax, %rax
180001e0b:     	jne	0x18000210c <.text+0x110c>
180001e11:     	movq	%rbp, 0x110(%rsp)
180001e19:     	movq	%r13, 0x108(%rsp)
180001e21:     	movq	%r12, 0xf0(%rsp)
180001e29:     	movq	%rsi, 0xe8(%rsp)
180001e31:     	movq	%rdi, 0xe0(%rsp)
180001e39:     	movq	0x138(%rsp), %rax
180001e41:     	movq	%rax, 0xd8(%rsp)
180001e49:     	movq	0x140(%rsp), %rax
180001e51:     	movq	%rax, 0xc8(%rsp)
180001e59:     	movq	0x148(%rsp), %rax
180001e61:     	movq	%rax, 0xc0(%rsp)
180001e69:     	movq	0x178(%rsp), %rax
180001e71:     	movq	%rax, 0xb0(%rsp)
180001e79:     	movq	0x180(%rsp), %rax
180001e81:     	movq	%rax, 0xa8(%rsp)
180001e89:     	movq	0x188(%rsp), %rax
180001e91:     	movq	%rax, 0xa0(%rsp)
180001e99:     	movq	0x190(%rsp), %rax
180001ea1:     	movq	%rax, 0x90(%rsp)
180001ea9:     	movq	0x198(%rsp), %rax
180001eb1:     	movq	%rax, 0x88(%rsp)
180001eb9:     	movq	0x1a8(%rsp), %rax
180001ec1:     	movq	%rax, 0x78(%rsp)
180001ec6:     	movq	0x1b0(%rsp), %rax
180001ece:     	movq	%rax, 0x70(%rsp)
180001ed3:     	movq	0x1b8(%rsp), %rax
180001edb:     	movq	%rax, 0x68(%rsp)
180001ee0:     	movq	0x1c0(%rsp), %rax
180001ee8:     	movq	%rax, 0x58(%rsp)
180001eed:     	movq	0x1a0(%rsp), %rax
180001ef5:     	movq	%rax, 0x50(%rsp)
180001efa:     	movq	0x150(%rsp), %rax
180001f02:     	movq	%rax, 0x40(%rsp)
180001f07:     	movq	0x158(%rsp), %rax
180001f0f:     	movq	%rax, 0x38(%rsp)
180001f14:     	movsd	%xmm7, 0x100(%rsp)
180001f1d:     	movsd	%xmm6, 0xf8(%rsp)
180001f26:     	movq	%r15, 0xb8(%rsp)
180001f2e:     	movq	%r14, 0x80(%rsp)
180001f36:     	movq	0x120(%rsp), %rdi
180001f3e:     	movq	%rdi, 0x48(%rsp)
180001f43:     	movq	0x160(%rsp), %rax
180001f4b:     	movq	%rax, 0x30(%rsp)
180001f50:     	movq	0x168(%rsp), %rax
180001f58:     	movq	%rax, 0x20(%rsp)
180001f5d:     	movq	$0x1, 0xd0(%rsp)
180001f69:     	movq	$0x8, 0x98(%rsp)
180001f75:     	movq	$0x8, 0x60(%rsp)
180001f7e:     	movq	$0x8, 0x28(%rsp)
180001f87:     	leaq	0x308(%rsp), %rcx
180001f8f:     	leaq	0x130(%rsp), %rdx
180001f97:     	movq	0x170(%rsp), %r9
180001f9f:     	movq	0x128(%rsp), %rsi
180001fa7:     	movq	%rsi, %r8
180001faa:     	callq	0x180001090 <.text+0x90>
180001faf:     	movl	%eax, %ebp
180001fb1:     	movq	0x130(%rsp), %rbx
180001fb9:     	movq	%rsi, %rcx
180001fbc:     	callq	0x180001060 <.text+0x60>
180001fc1:     	movq	%rdi, %rcx
180001fc4:     	callq	0x180001060 <.text+0x60>
180001fc9:     	movq	%r14, %rcx
180001fcc:     	callq	0x180001060 <.text+0x60>
180001fd1:     	movq	%r15, %rcx
180001fd4:     	callq	0x180001060 <.text+0x60>
180001fd9:     	testl	%ebp, %ebp
180001fdb:     	jne	0x180002013 <.text+0x1013>
180001fdd:     	movq	0xa2ec(%rip), %rsi      # 0x18000c2d0
180001fe4:     	movq	%rsi, %rcx
180001fe7:     	callq	0x18000b0fb <numba_list_iter_next+0x33b>
180001fec:     	movq	%rsi, %rax
180001fef:     	movaps	0x310(%rsp), %xmm6
180001ff7:     	movaps	0x320(%rsp), %xmm7
180001fff:     	addq	$0x338, %rsp            # imm = 0x338
180002006:     	popq	%rbx
180002007:     	popq	%rbp
180002008:     	popq	%rdi
180002009:     	popq	%rsi
18000200a:     	popq	%r12
18000200c:     	popq	%r13
18000200e:     	popq	%r14
180002010:     	popq	%r15
180002012:     	retq
180002013:     	jle	0x180002143 <.text+0x1143>
180002019:     	callq	0x18000b101 <numba_list_iter_next+0x341>
18000201e:     	movl	0x8(%rbx), %edx
180002021:     	movq	(%rbx), %rcx
180002024:     	cmpl	$0x0, 0x20(%rbx)
180002028:     	jle	0x180002162 <.text+0x1162>
18000202e:     	movslq	%edx, %rdx
180002031:     	callq	0x18000b107 <numba_list_iter_next+0x347>
180002036:     	movq	%rax, %rsi
180002039:     	movq	0x10(%rbx), %rcx
18000203d:     	callq	*0x18(%rbx)
180002040:     	testq	%rax, %rax
180002043:     	je	0x18000218b <.text+0x118b>
180002049:     	movq	%rsi, %rcx
18000204c:     	movq	%rax, %rdx
18000204f:     	callq	0x1800095a0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5ac0>
180002054:     	movq	%rax, %rsi
180002057:     	movq	%rbx, %rcx
18000205a:     	callq	0x18000b030 <numba_list_iter_next+0x270>
18000205f:     	jmp	0x18000216e <.text+0x116e>
180002064:     	movq	0xa245(%rip), %rcx      # 0x18000c2b0
18000206b:     	leaq	0xa43e(%rip), %rdx      # 0x18000c4b0
180002072:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180002077:     	jmp	0x18000213c <.text+0x113c>
18000207c:     	movq	0xa21d(%rip), %rcx      # 0x18000c2a0
180002083:     	leaq	0xa526(%rip), %rdx      # 0x18000c5b0
18000208a:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
18000208f:     	jmp	0x18000213c <.text+0x113c>
180002094:     	movq	0xa205(%rip), %rcx      # 0x18000c2a0
18000209b:     	leaq	0xa50e(%rip), %rdx      # 0x18000c5b0
1800020a2:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800020a7:     	jmp	0x180002134 <.text+0x1134>
1800020ac:     	movq	0xa1ed(%rip), %rcx      # 0x18000c2a0
1800020b3:     	leaq	0xa4f6(%rip), %rdx      # 0x18000c5b0
1800020ba:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800020bf:     	jmp	0x18000212c <.text+0x112c>
1800020c1:     	movq	0xa1d8(%rip), %rcx      # 0x18000c2a0
1800020c8:     	leaq	0xa4e1(%rip), %rdx      # 0x18000c5b0
1800020cf:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800020d4:     	jmp	0x180002124 <.text+0x1124>
1800020d6:     	xorl	%r12d, %r12d
1800020d9:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800020de:     	testq	%rax, %rax
1800020e1:     	je	0x180001d3b <.text+0xd3b>
1800020e7:     	jmp	0x18000210c <.text+0x110c>
1800020e9:     	xorl	%r13d, %r13d
1800020ec:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800020f1:     	testq	%rax, %rax
1800020f4:     	je	0x180001dd7 <.text+0xdd7>
1800020fa:     	jmp	0x18000210c <.text+0x110c>
1800020fc:     	xorl	%ebp, %ebp
1800020fe:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180002103:     	testq	%rax, %rax
180002106:     	je	0x180001e11 <.text+0xe11>
18000210c:     	movq	%r15, %rcx
18000210f:     	callq	0x180001060 <.text+0x60>
180002114:     	movq	0x128(%rsp), %rbx
18000211c:     	movq	0x120(%rsp), %r12
180002124:     	movq	%r14, %rcx
180002127:     	callq	0x180001060 <.text+0x60>
18000212c:     	movq	%r12, %rcx
18000212f:     	callq	0x180001060 <.text+0x60>
180002134:     	movq	%rbx, %rcx
180002137:     	callq	0x180001060 <.text+0x60>
18000213c:     	xorl	%esi, %esi
18000213e:     	jmp	0x180001fec <.text+0xfec>
180002143:     	cmpl	$-0x3, %ebp
180002146:     	je	0x18000217d <.text+0x117d>
180002148:     	cmpl	$-0x1, %ebp
18000214b:     	je	0x18000213c <.text+0x113c>
18000214d:     	movq	0xa144(%rip), %rcx      # 0x18000c298
180002154:     	leaq	0xa4f5(%rip), %rdx      # 0x18000c650
18000215b:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180002160:     	jmp	0x18000213c <.text+0x113c>
180002162:     	movq	0x10(%rbx), %r8
180002166:     	callq	0x1800094c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59e0>
18000216b:     	movq	%rax, %rsi
18000216e:     	testq	%rsi, %rsi
180002171:     	je	0x18000213c <.text+0x113c>
180002173:     	movq	%rsi, %rcx
180002176:     	callq	0x180009060 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5580>
18000217b:     	jmp	0x18000213c <.text+0x113c>
18000217d:     	movq	0xa10c(%rip), %rcx      # 0x18000c290
180002184:     	callq	0x18000b113 <numba_list_iter_next+0x353>
180002189:     	jmp	0x18000213c <.text+0x113c>
18000218b:     	movq	0xa11e(%rip), %rcx      # 0x18000c2b0
180002192:     	leaq	0xa477(%rip), %rdx      # 0x18000c610
180002199:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
18000219e:     	jmp	0x18000213c <.text+0x113c>
1800021a0:     	pushq	%r15
1800021a2:     	pushq	%r14
1800021a4:     	pushq	%r13
1800021a6:     	pushq	%r12
1800021a8:     	pushq	%rsi
1800021a9:     	pushq	%rdi
1800021aa:     	pushq	%rbp
1800021ab:     	pushq	%rbx
1800021ac:     	subq	$0x148, %rsp            # imm = 0x148
1800021b3:     	movq	%r9, %r12
1800021b6:     	movq	%r8, %r13
1800021b9:     	movq	%rdx, 0x140(%rsp)
1800021c1:     	movq	%rcx, 0x138(%rsp)
1800021c9:     	movsd	0x278(%rsp), %xmm0
1800021d2:     	movsd	0x280(%rsp), %xmm1
1800021db:     	movq	$0x0, 0x130(%rsp)
1800021e7:     	movq	$0x0, 0x128(%rsp)
1800021f3:     	movq	0x220(%rsp), %rbp
1800021fb:     	movq	0x228(%rsp), %r15
180002203:     	movq	0x230(%rsp), %r14
18000220b:     	movq	0x238(%rsp), %rbx
180002213:     	movq	0x240(%rsp), %rdi
18000221b:     	movq	0x248(%rsp), %rsi
180002223:     	movq	0x250(%rsp), %r11
18000222b:     	movq	0x258(%rsp), %r10
180002233:     	movq	0x260(%rsp), %r9
18000223b:     	movq	0x268(%rsp), %r8
180002243:     	movq	0x270(%rsp), %rdx
18000224b:     	movq	0x288(%rsp), %rcx
180002253:     	movq	0x290(%rsp), %rax
18000225b:     	movq	%rax, 0x110(%rsp)
180002263:     	movq	%rcx, 0x108(%rsp)
18000226b:     	movq	%rdx, 0xf0(%rsp)
180002273:     	movq	%r8, 0xe8(%rsp)
18000227b:     	movq	%r9, 0xe0(%rsp)
180002283:     	movq	%r10, 0xd8(%rsp)
18000228b:     	movq	%r11, 0xd0(%rsp)
180002293:     	movq	%rsi, 0xc8(%rsp)
18000229b:     	movq	%rdi, 0xc0(%rsp)
1800022a3:     	movq	%rbx, 0xb8(%rsp)
1800022ab:     	movq	%r14, 0xb0(%rsp)
1800022b3:     	movq	%r15, 0xa8(%rsp)
1800022bb:     	movq	%rbp, 0xa0(%rsp)
1800022c3:     	movq	0x218(%rsp), %rax
1800022cb:     	movq	%rax, 0x98(%rsp)
1800022d3:     	movq	0x210(%rsp), %rax
1800022db:     	movq	%rax, 0x90(%rsp)
1800022e3:     	movq	0x208(%rsp), %rax
1800022eb:     	movq	%rax, 0x88(%rsp)
1800022f3:     	movq	0x200(%rsp), %rax
1800022fb:     	movq	%rax, 0x80(%rsp)
180002303:     	movq	0x1f8(%rsp), %rax
18000230b:     	movq	%rax, 0x78(%rsp)
180002310:     	movq	0x1f0(%rsp), %rax
180002318:     	movq	%rax, 0x70(%rsp)
18000231d:     	movq	0x1e8(%rsp), %rax
180002325:     	movq	%rax, 0x68(%rsp)
18000232a:     	movq	0x1e0(%rsp), %rax
180002332:     	movq	%rax, 0x60(%rsp)
180002337:     	movq	0x1d8(%rsp), %rax
18000233f:     	movq	%rax, 0x58(%rsp)
180002344:     	movq	0x1d0(%rsp), %rax
18000234c:     	movq	%rax, 0x50(%rsp)
180002351:     	movq	0x1c8(%rsp), %rax
180002359:     	movq	%rax, 0x48(%rsp)
18000235e:     	movq	0x1c0(%rsp), %rax
180002366:     	movq	%rax, 0x40(%rsp)
18000236b:     	movq	0x1b8(%rsp), %rax
180002373:     	movq	%rax, 0x38(%rsp)
180002378:     	movq	0x1b0(%rsp), %rax
180002380:     	movq	%rax, 0x30(%rsp)
180002385:     	movsd	%xmm1, 0x100(%rsp)
18000238e:     	movsd	%xmm0, 0xf8(%rsp)
180002397:     	movq	%r12, 0x28(%rsp)
18000239c:     	movq	%r13, 0x20(%rsp)
1800023a1:     	leaq	0x130(%rsp), %rcx
1800023a9:     	leaq	0x128(%rsp), %rdx
1800023b1:     	movq	0x138(%rsp), %r8
1800023b9:     	movq	0x140(%rsp), %r9
1800023c1:     	callq	0x180001090 <.text+0x90>
1800023c6:     	movl	%eax, %edx
1800023c8:     	movq	0x128(%rsp), %rsi
1800023d0:     	movq	0x130(%rsp), %rax
1800023d8:     	movl	$0x0, 0x124(%rsp)
1800023e3:     	testl	%edx, %edx
1800023e5:     	jne	0x1800023fb <.text+0x13fb>
1800023e7:     	addq	$0x148, %rsp            # imm = 0x148
1800023ee:     	popq	%rbx
1800023ef:     	popq	%rbp
1800023f0:     	popq	%rdi
1800023f1:     	popq	%rsi
1800023f2:     	popq	%r12
1800023f4:     	popq	%r13
1800023f6:     	popq	%r14
1800023f8:     	popq	%r15
1800023fa:     	retq
1800023fb:     	movq	%rax, %rbx
1800023fe:     	leaq	0x124(%rsp), %rcx
180002406:     	movl	%edx, %edi
180002408:     	callq	0x180009030 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5550>
18000240d:     	testl	%edi, %edi
18000240f:     	jle	0x180002455 <.text+0x1455>
180002411:     	callq	0x18000b101 <numba_list_iter_next+0x341>
180002416:     	movl	0x8(%rsi), %edx
180002419:     	movq	(%rsi), %rcx
18000241c:     	cmpl	$0x0, 0x20(%rsi)
180002420:     	jle	0x180002476 <.text+0x1476>
180002422:     	movslq	%edx, %rdx
180002425:     	callq	0x18000b107 <numba_list_iter_next+0x347>
18000242a:     	movq	%rax, %rdi
18000242d:     	movq	0x10(%rsi), %rcx
180002431:     	callq	*0x18(%rsi)
180002434:     	testq	%rax, %rax
180002437:     	je	0x1800024d1 <.text+0x14d1>
18000243d:     	movq	%rdi, %rcx
180002440:     	movq	%rax, %rdx
180002443:     	callq	0x1800095a0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5ac0>
180002448:     	movq	%rax, %rdi
18000244b:     	movq	%rsi, %rcx
18000244e:     	callq	0x18000b030 <numba_list_iter_next+0x270>
180002453:     	jmp	0x180002482 <.text+0x1482>
180002455:     	movl	%edi, %eax
180002457:     	cmpl	$-0x3, %edi
18000245a:     	je	0x1800024c3 <.text+0x14c3>
18000245c:     	cmpl	$-0x1, %eax
18000245f:     	je	0x18000248f <.text+0x148f>
180002461:     	movq	0x9e30(%rip), %rcx      # 0x18000c298
180002468:     	leaq	0xa251(%rip), %rdx      # 0x18000c6c0
18000246f:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180002474:     	jmp	0x18000248f <.text+0x148f>
180002476:     	movq	0x10(%rsi), %r8
18000247a:     	callq	0x1800094c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59e0>
18000247f:     	movq	%rax, %rdi
180002482:     	testq	%rdi, %rdi
180002485:     	je	0x18000248f <.text+0x148f>
180002487:     	movq	%rdi, %rcx
18000248a:     	callq	0x180009060 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5580>
18000248f:     	leaq	0xa25a(%rip), %rcx      # 0x18000c6f0
180002496:     	callq	0x18000b119 <numba_list_iter_next+0x359>
18000249b:     	movq	%rax, %rsi
18000249e:     	movq	%rax, %rcx
1800024a1:     	callq	0x18000b11f <numba_list_iter_next+0x35f>
1800024a6:     	movq	%rsi, %rcx
1800024a9:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
1800024ae:     	leaq	0x124(%rsp), %rcx
1800024b6:     	callq	0x180009050 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5570>
1800024bb:     	movq	%rbx, %rax
1800024be:     	jmp	0x1800023e7 <.text+0x13e7>
1800024c3:     	movq	0x9dc6(%rip), %rcx      # 0x18000c290
1800024ca:     	callq	0x18000b113 <numba_list_iter_next+0x353>
1800024cf:     	jmp	0x18000248f <.text+0x148f>
1800024d1:     	movq	0x9dd8(%rip), %rcx      # 0x18000c2b0
1800024d8:     	leaq	0xa1a1(%rip), %rdx      # 0x18000c680
1800024df:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800024e4:     	xorl	%eax, %eax
1800024e6:     	jmp	0x1800023e7 <.text+0x13e7>
1800024eb:     	nopl	(%rax,%rax)
1800024f0:     	pushq	%r15
1800024f2:     	pushq	%r14
1800024f4:     	pushq	%r13
1800024f6:     	pushq	%r12
1800024f8:     	pushq	%rsi
1800024f9:     	pushq	%rdi
1800024fa:     	pushq	%rbp
1800024fb:     	pushq	%rbx
1800024fc:     	subq	$0x1a8, %rsp            # imm = 0x1A8
180002503:     	movapd	%xmm7, 0x190(%rsp)
18000250c:     	movaps	%xmm6, 0x180(%rsp)
180002514:     	movq	0x2f8(%rsp), %r10
18000251c:     	movq	0x2c8(%rsp), %r15
180002524:     	movq	0x290(%rsp), %r14
18000252c:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180002536:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
180002540:     	xorpd	%xmm0, %xmm0
180002544:     	movapd	%xmm0, 0x160(%rsp)
18000254d:     	movq	$0x0, 0x178(%rsp)
180002559:     	movb	$0x0, 0x11f(%rsp)
180002561:     	movq	$0x0, 0x158(%rsp)
18000256d:     	leaq	(%r10,%rax), %r11
180002571:     	cmpq	%rsi, %r11
180002574:     	jb	0x180002586 <.text+0x1586>
180002576:     	movq	0x300(%rsp), %r11
18000257e:     	addq	%r11, %rax
180002581:     	cmpq	%rsi, %rax
180002584:     	jae	0x1800025bf <.text+0x15bf>
180002586:     	movb	$0x1, (%r15)
18000258a:     	movq	$0x4, 0x18(%r14)
180002592:     	movq	$0x0, (%rcx)
180002599:     	xorl	%eax, %eax
18000259b:     	movaps	0x180(%rsp), %xmm6
1800025a3:     	movaps	0x190(%rsp), %xmm7
1800025ab:     	addq	$0x1a8, %rsp            # imm = 0x1A8
1800025b2:     	popq	%rbx
1800025b3:     	popq	%rbp
1800025b4:     	popq	%rdi
1800025b5:     	popq	%rsi
1800025b6:     	popq	%r12
1800025b8:     	popq	%r13
1800025ba:     	popq	%r14
1800025bc:     	popq	%r15
1800025be:     	retq
1800025bf:     	movq	0x260(%rsp), %r12
1800025c7:     	movq	(%r14), %rax
1800025ca:     	leaq	0x4(%rax), %rsi
1800025ce:     	cmpq	%r12, %rsi
1800025d1:     	jle	0x1800025d9 <.text+0x15d9>
1800025d3:     	movb	$0x2, (%r15)
1800025d7:     	jmp	0x180002592 <.text+0x1592>
1800025d9:     	movq	%rsi, (%r14)
1800025dc:     	cmpb	$0x0, (%r15)
1800025e0:     	jne	0x180002592 <.text+0x1592>
1800025e2:     	movq	0x220(%rsp), %r13
1800025ea:     	testq	%rax, %rax
1800025ed:     	js	0x180002634 <.text+0x1634>
1800025ef:     	xorps	%xmm0, %xmm0
1800025f2:     	cvtsi2sd	%r11, %xmm0
1800025f7:     	movsd	0x9db1(%rip), %xmm1     # 0x18000c3b0
1800025ff:     	mulsd	%xmm1, %xmm0
180002603:     	cvtsi2sd	%r10, %xmm2
180002608:     	mulsd	%xmm1, %xmm2
18000260c:     	movsd	%xmm2, 0x10(%r13,%rax,8)
180002613:     	movsd	%xmm0, 0x18(%r13,%rax,8)
18000261a:     	movsd	%xmm2, 0x8(%r13,%rax,8)
180002621:     	movsd	%xmm0, (%r13,%rax,8)
180002628:     	cmpb	$0x0, (%r15)
18000262c:     	jne	0x180002592 <.text+0x1592>
180002632:     	jmp	0x18000264a <.text+0x164a>
180002634:     	movb	$0x1, (%r15)
180002638:     	movq	$0xf4242, 0x18(%r14)    # imm = 0xF4242
180002640:     	cmpb	$0x0, (%r15)
180002644:     	jne	0x180002592 <.text+0x1592>
18000264a:     	movq	(%r14), %rsi
18000264d:     	leaq	0xa(%rsi), %r10
180002651:     	cmpq	%r12, %r10
180002654:     	jg	0x1800025d3 <.text+0x15d3>
18000265a:     	movq	%r10, (%r14)
18000265d:     	cmpb	$0x0, (%r15)
180002661:     	jne	0x180002592 <.text+0x1592>
180002667:     	movq	0x258(%rsp), %rbp
18000266f:     	movq	%rax, (%rbp,%rsi,8)
180002674:     	movq	$0x4, 0x8(%rbp,%rsi,8)
18000267d:     	movq	(%r14), %rax
180002680:     	cmpq	%r12, %rax
180002683:     	movq	%rax, %r10
180002686:     	jle	0x180002692 <.text+0x1692>
180002688:     	movb	$0x2, (%r15)
18000268c:     	movq	(%r14), %rax
18000268f:     	xorl	%r10d, %r10d
180002692:     	leaq	0x3(%rax), %r11
180002696:     	cmpq	%r12, %r11
180002699:     	jg	0x1800025d3 <.text+0x15d3>
18000269f:     	movq	%r11, (%r14)
1800026a2:     	cmpb	$0x0, (%r15)
1800026a6:     	jne	0x180002592 <.text+0x1592>
1800026ac:     	movq	%rax, %r11
1800026af:     	sarq	$0x3f, %r11
1800026b3:     	andq	%r12, %r11
1800026b6:     	leaq	(%rbp,%rax,8), %rdi
1800026bb:     	movq	$0x0, (%rdi,%r11,8)
1800026c3:     	xorl	%r11d, %r11d
1800026c6:     	cmpq	$-0x1, %rax
1800026ca:     	movl	$0x0, %ebx
1800026cf:     	cmovlq	%r12, %rbx
1800026d3:     	movq	$0x0, 0x8(%rdi,%rbx,8)
1800026dc:     	cmpq	$-0x2, %rax
1800026e0:     	cmovlq	%r12, %r11
1800026e4:     	movq	%r10, 0x10(%rdi,%r11,8)
1800026e9:     	cmpb	$0x0, (%r15)
1800026ed:     	jne	0x180002592 <.text+0x1592>
1800026f3:     	leaq	(%rbp,%rsi,8), %r10
1800026f8:     	movq	%rax, 0x30(%r10)
1800026fc:     	movq	$0x0, 0x18(%r10)
180002704:     	movq	(%r14), %rax
180002707:     	leaq	0x2(%rax), %r11
18000270b:     	cmpq	%r12, %r11
18000270e:     	jg	0x1800025d3 <.text+0x15d3>
180002714:     	movq	%r11, (%r14)
180002717:     	cmpb	$0x0, (%r15)
18000271b:     	jne	0x180002592 <.text+0x1592>
180002721:     	movq	%r8, 0x150(%rsp)
180002729:     	movq	%r9, 0x148(%rsp)
180002731:     	movq	%rdx, 0x140(%rsp)
180002739:     	movq	%rcx, 0x120(%rsp)
180002741:     	testq	%rax, %rax
180002744:     	js	0x18000275a <.text+0x175a>
180002746:     	movq	$0x0, 0x8(%r13,%rax,8)
18000274f:     	movq	$0x0, (%r13,%rax,8)
180002758:     	jmp	0x180002766 <.text+0x1766>
18000275a:     	movb	$0x1, (%r15)
18000275e:     	movq	$0x6acfc2, 0x18(%r14)   # imm = 0x6ACFC2
180002766:     	cmpb	$0x0, (%r15)
18000276a:     	movq	0x120(%rsp), %rcx
180002772:     	jne	0x180002592 <.text+0x1592>
180002778:     	movq	%rax, 0x10(%r10)
18000277c:     	movq	$0x0, 0x48(%r13,%rsi,8)
180002785:     	movq	$-0x1, 0x28(%r10)
18000278d:     	movq	$-0x1, 0x20(%r10)
180002795:     	movq	$-0x1, 0x38(%r10)
18000279d:     	movq	$-0x1, 0x40(%r10)
1800027a5:     	cmpb	$0x0, (%r15)
1800027a9:     	jne	0x180002592 <.text+0x1592>
1800027af:     	movq	0x2e0(%rsp), %rax
1800027b7:     	movq	%rax, %rcx
1800027ba:     	sarq	$0x3f, %rcx
1800027be:     	andq	%r12, %rcx
1800027c1:     	xorl	%edx, %edx
1800027c3:     	cmpq	$-0x2, %rax
1800027c7:     	leaq	(%rbp,%rax,8), %rax
1800027cc:     	cmovlq	%r12, %rdx
1800027d0:     	movq	%rdx, 0x138(%rsp)
1800027d8:     	movq	%rcx, 0x130(%rsp)
1800027e0:     	movq	%rax, 0x128(%rsp)
1800027e8:     	cmpq	$0x0, (%rax,%rcx,8)
1800027ed:     	jle	0x180002a28 <.text+0x1a28>
1800027f3:     	testq	%rsi, %rsi
1800027f6:     	js	0x180002cf6 <.text+0x1cf6>
1800027fc:     	movq	0x8(%r14), %rax
180002800:     	xorl	%edi, %edi
180002802:     	leaq	0x11f(%rsp), %rbx
18000280a:     	movq	0x138(%rsp), %rcx
180002812:     	movq	0x128(%rsp), %rdx
18000281a:     	movq	0x10(%rdx,%rcx,8), %rcx
18000281f:     	addq	%rdi, %rcx
180002822:     	leaq	(%rbp,%rcx,8), %rdx
180002827:     	sarq	$0x3f, %rcx
18000282b:     	andq	%r12, %rcx
18000282e:     	movq	(%rdx,%rcx,8), %rcx
180002832:     	leaq	0x1(%rax), %rdx
180002836:     	movq	%rdx, 0x8(%r14)
18000283a:     	cmpq	0x10(%r14), %rax
18000283e:     	jge	0x180002cf6 <.text+0x1cf6>
180002844:     	movq	%rcx, 0x100(%rsp)
18000284c:     	movq	%rsi, 0xf8(%rsp)
180002854:     	movq	0x2d8(%rsp), %rax
18000285c:     	movq	%rax, 0xe8(%rsp)
180002864:     	movq	0x2d0(%rsp), %rax
18000286c:     	movq	%rax, 0xe0(%rsp)
180002874:     	movq	%r15, 0xd8(%rsp)
18000287c:     	movq	0x2c0(%rsp), %rax
180002884:     	movq	%rax, 0xd0(%rsp)
18000288c:     	movq	0x2b8(%rsp), %rax
180002894:     	movq	%rax, 0xc8(%rsp)
18000289c:     	movq	0x2b0(%rsp), %rax
1800028a4:     	movq	%rax, 0xc0(%rsp)
1800028ac:     	movq	0x2a8(%rsp), %rax
1800028b4:     	movq	%rax, 0xb8(%rsp)
1800028bc:     	movq	0x2a0(%rsp), %rax
1800028c4:     	movq	%rax, 0xb0(%rsp)
1800028cc:     	movq	0x298(%rsp), %rax
1800028d4:     	movq	%rax, 0xa8(%rsp)
1800028dc:     	movq	%r14, 0xa0(%rsp)
1800028e4:     	movq	0x288(%rsp), %rax
1800028ec:     	movq	%rax, 0x98(%rsp)
1800028f4:     	movq	0x280(%rsp), %rax
1800028fc:     	movq	%rax, 0x90(%rsp)
180002904:     	movq	0x278(%rsp), %rax
18000290c:     	movq	%rax, 0x88(%rsp)
180002914:     	movq	0x270(%rsp), %rax
18000291c:     	movq	%rax, 0x80(%rsp)
180002924:     	movq	0x268(%rsp), %rax
18000292c:     	movq	%rax, 0x78(%rsp)
180002931:     	movq	%r12, 0x70(%rsp)
180002936:     	movq	%rbp, 0x68(%rsp)
18000293b:     	movq	0x250(%rsp), %rax
180002943:     	movq	%rax, 0x60(%rsp)
180002948:     	movq	0x248(%rsp), %rax
180002950:     	movq	%rax, 0x58(%rsp)
180002955:     	movq	0x240(%rsp), %rax
18000295d:     	movq	%rax, 0x50(%rsp)
180002962:     	movq	0x238(%rsp), %rax
18000296a:     	movq	%rax, 0x48(%rsp)
18000296f:     	movq	0x230(%rsp), %rax
180002977:     	movq	%rax, 0x40(%rsp)
18000297c:     	movq	0x228(%rsp), %rax
180002984:     	movq	%rax, 0x38(%rsp)
180002989:     	movq	%r13, 0x30(%rsp)
18000298e:     	movq	0x218(%rsp), %rax
180002996:     	movq	%rax, 0x28(%rsp)
18000299b:     	movq	0x210(%rsp), %rax
1800029a3:     	movq	%rax, 0x20(%rsp)
1800029a8:     	movq	$-0x1, 0x108(%rsp)
1800029b4:     	movq	$0x0, 0xf0(%rsp)
1800029c0:     	movq	%rbx, %rcx
1800029c3:     	leaq	0x158(%rsp), %rdx
1800029cb:     	movq	0x150(%rsp), %r8
1800029d3:     	movq	0x148(%rsp), %r9
1800029db:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
1800029e0:     	testl	%eax, %eax
1800029e2:     	jne	0x180002eed <.text+0x1eed>
1800029e8:     	cmpb	$0x0, (%r15)
1800029ec:     	jne	0x180002d02 <.text+0x1d02>
1800029f2:     	incq	%rdi
1800029f5:     	movq	0x8(%r14), %rax
1800029f9:     	decq	%rax
1800029fc:     	movq	%rax, 0x8(%r14)
180002a00:     	movq	0x130(%rsp), %rcx
180002a08:     	movq	0x128(%rsp), %rdx
180002a10:     	cmpq	(%rdx,%rcx,8), %rdi
180002a14:     	jl	0x18000280a <.text+0x180a>
180002a1a:     	leaq	0x18(%r14), %rax
180002a1e:     	movq	%rax, 0x110(%rsp)
180002a26:     	jmp	0x180002a3d <.text+0x1a3d>
180002a28:     	leaq	0x18(%r14), %rax
180002a2c:     	movq	%rax, 0x110(%rsp)
180002a34:     	testq	%rsi, %rsi
180002a37:     	js	0x180002d16 <.text+0x1d16>
180002a3d:     	movsd	0x2e8(%rsp), %xmm6
180002a46:     	xorl	%edi, %edi
180002a48:     	xorpd	%xmm7, %xmm7
180002a4c:     	movq	0x130(%rsp), %rax
180002a54:     	movq	0x128(%rsp), %rcx
180002a5c:     	cmpq	(%rcx,%rax,8), %rdi
180002a60:     	jge	0x180002d16 <.text+0x1d16>
180002a66:     	movq	0x138(%rsp), %rax
180002a6e:     	movq	0x128(%rsp), %rcx
180002a76:     	movq	0x10(%rcx,%rax,8), %rax
180002a7b:     	addq	%rdi, %rax
180002a7e:     	leaq	(%rbp,%rax,8), %rcx
180002a83:     	sarq	$0x3f, %rax
180002a87:     	andq	%r12, %rax
180002a8a:     	movq	(%rcx,%rax,8), %rbx
180002a8e:     	movq	0x8(%r14), %rax
180002a92:     	leaq	0x1(%rax), %rcx
180002a96:     	movq	%rcx, 0x8(%r14)
180002a9a:     	cmpq	0x10(%r14), %rax
180002a9e:     	jge	0x180002f1d <.text+0x1f1d>
180002aa4:     	movsd	%xmm6, 0x100(%rsp)
180002aad:     	movq	%rbx, 0xf8(%rsp)
180002ab5:     	movq	%rsi, 0xf0(%rsp)
180002abd:     	movq	0x2d8(%rsp), %rax
180002ac5:     	movq	%rax, 0xe8(%rsp)
180002acd:     	movq	0x2d0(%rsp), %rax
180002ad5:     	movq	%rax, 0xe0(%rsp)
180002add:     	movq	%r15, 0xd8(%rsp)
180002ae5:     	movq	0x2c0(%rsp), %rax
180002aed:     	movq	%rax, 0xd0(%rsp)
180002af5:     	movq	0x2b8(%rsp), %rax
180002afd:     	movq	%rax, 0xc8(%rsp)
180002b05:     	movq	0x2b0(%rsp), %rax
180002b0d:     	movq	%rax, 0xc0(%rsp)
180002b15:     	movq	0x2a8(%rsp), %rax
180002b1d:     	movq	%rax, 0xb8(%rsp)
180002b25:     	movq	0x2a0(%rsp), %rax
180002b2d:     	movq	%rax, 0xb0(%rsp)
180002b35:     	movq	0x298(%rsp), %rax
180002b3d:     	movq	%rax, 0xa8(%rsp)
180002b45:     	movq	%r14, 0xa0(%rsp)
180002b4d:     	movq	0x288(%rsp), %rax
180002b55:     	movq	%rax, 0x98(%rsp)
180002b5d:     	movq	0x280(%rsp), %rax
180002b65:     	movq	%rax, 0x90(%rsp)
180002b6d:     	movq	0x278(%rsp), %rax
180002b75:     	movq	%rax, 0x88(%rsp)
180002b7d:     	movq	0x270(%rsp), %rax
180002b85:     	movq	%rax, 0x80(%rsp)
180002b8d:     	movq	0x268(%rsp), %rax
180002b95:     	movq	%rax, 0x78(%rsp)
180002b9a:     	movq	%r12, 0x70(%rsp)
180002b9f:     	movq	%rbp, 0x68(%rsp)
180002ba4:     	movq	0x250(%rsp), %rax
180002bac:     	movq	%rax, 0x60(%rsp)
180002bb1:     	movq	0x248(%rsp), %rax
180002bb9:     	movq	%rax, 0x58(%rsp)
180002bbe:     	movq	0x240(%rsp), %rax
180002bc6:     	movq	%rax, 0x50(%rsp)
180002bcb:     	movq	0x238(%rsp), %rax
180002bd3:     	movq	%rax, 0x48(%rsp)
180002bd8:     	movq	0x230(%rsp), %rax
180002be0:     	movq	%rax, 0x40(%rsp)
180002be5:     	movq	0x228(%rsp), %rax
180002bed:     	movq	%rax, 0x38(%rsp)
180002bf2:     	movq	%r13, 0x30(%rsp)
180002bf7:     	movq	0x218(%rsp), %rax
180002bff:     	movq	%rax, 0x28(%rsp)
180002c04:     	movq	0x210(%rsp), %rax
180002c0c:     	movq	%rax, 0x20(%rsp)
180002c11:     	leaq	0x160(%rsp), %rcx
180002c19:     	leaq	0x178(%rsp), %rdx
180002c21:     	movq	0x150(%rsp), %r8
180002c29:     	movq	0x148(%rsp), %r9
180002c31:     	callq	0x180006400 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2920>
180002c36:     	testl	%eax, %eax
180002c38:     	jne	0x180002f4d <.text+0x1f4d>
180002c3e:     	cmpb	$0x0, (%r15)
180002c42:     	jne	0x180002d02 <.text+0x1d02>
180002c48:     	movsd	0x160(%rsp), %xmm1
180002c51:     	movsd	0x168(%rsp), %xmm0
180002c5a:     	decq	0x8(%r14)
180002c5e:     	testq	%rbx, %rbx
180002c61:     	js	0x180002f35 <.text+0x1f35>
180002c67:     	movq	(%rbp,%rbx,8), %rax
180002c6c:     	testq	%rax, %rax
180002c6f:     	js	0x180002c80 <.text+0x1c80>
180002c71:     	movsd	0x8(%r13,%rbx,8), %xmm2
180002c78:     	ucomisd	%xmm7, %xmm2
180002c7c:     	jne	0x180002ca2 <.text+0x1ca2>
180002c7e:     	jp	0x180002ca2 <.text+0x1ca2>
180002c80:     	movb	$0x1, (%r15)
180002c84:     	movq	0x110(%rsp), %rax
180002c8c:     	movq	$0x4c4b43, (%rax)       # imm = 0x4C4B43
180002c93:     	incq	%rdi
180002c96:     	cmpb	$0x0, (%r15)
180002c9a:     	je	0x180002a4c <.text+0x1a4c>
180002ca0:     	jmp	0x180002d02 <.text+0x1d02>
180002ca2:     	divsd	%xmm2, %xmm1
180002ca6:     	addsd	(%r13,%rax,8), %xmm1
180002cad:     	movsd	%xmm1, (%r13,%rax,8)
180002cb4:     	movq	(%rbp,%rbx,8), %rax
180002cb9:     	testq	%rax, %rax
180002cbc:     	js	0x180002ccd <.text+0x1ccd>
180002cbe:     	movsd	0x8(%r13,%rbx,8), %xmm1
180002cc5:     	ucomisd	%xmm7, %xmm1
180002cc9:     	jne	0x180002ce2 <.text+0x1ce2>
180002ccb:     	jp	0x180002ce2 <.text+0x1ce2>
180002ccd:     	movb	$0x1, (%r15)
180002cd1:     	movq	0x110(%rsp), %rax
180002cd9:     	movq	$0x4c4b44, (%rax)       # imm = 0x4C4B44
180002ce0:     	jmp	0x180002c93 <.text+0x1c93>
180002ce2:     	divsd	%xmm1, %xmm0
180002ce6:     	addsd	0x8(%r13,%rax,8), %xmm0
180002ced:     	movsd	%xmm0, 0x8(%r13,%rax,8)
180002cf4:     	jmp	0x180002c93 <.text+0x1c93>
180002cf6:     	movb	$0x1, (%r15)
180002cfa:     	movq	$0x9, 0x18(%r14)
180002d02:     	movq	0x120(%rsp), %rax
180002d0a:     	movq	$0x0, (%rax)
180002d11:     	jmp	0x180002599 <.text+0x1599>
180002d16:     	movsd	0x2f0(%rsp), %xmm0
180002d1f:     	xorl	%eax, %eax
180002d21:     	jmp	0x180002d3f <.text+0x1d3f>
180002d23:     	movb	$0x1, (%r15)
180002d27:     	movq	0x110(%rsp), %rcx
180002d2f:     	movq	$0x5b8d83, (%rcx)       # imm = 0x5B8D83
180002d36:     	incq	%rax
180002d39:     	cmpb	$0x0, (%r15)
180002d3d:     	jne	0x180002d02 <.text+0x1d02>
180002d3f:     	movq	0x130(%rsp), %rcx
180002d47:     	movq	0x128(%rsp), %rdx
180002d4f:     	cmpq	(%rdx,%rcx,8), %rax
180002d53:     	jge	0x180002d02 <.text+0x1d02>
180002d55:     	movq	0x138(%rsp), %rcx
180002d5d:     	movq	0x128(%rsp), %rdx
180002d65:     	movq	0x10(%rdx,%rcx,8), %rcx
180002d6a:     	addq	%rax, %rcx
180002d6d:     	leaq	(%rbp,%rcx,8), %rdx
180002d72:     	sarq	$0x3f, %rcx
180002d76:     	andq	%r12, %rcx
180002d79:     	movq	(%rdx,%rcx,8), %rcx
180002d7d:     	testq	%rcx, %rcx
180002d80:     	js	0x180002f05 <.text+0x1f05>
180002d86:     	movq	0x18(%rbp,%rcx,8), %rdx
180002d8b:     	testq	%rdx, %rdx
180002d8e:     	js	0x180002d23 <.text+0x1d23>
180002d90:     	movq	(%rbp,%rcx,8), %r8
180002d95:     	testq	%r8, %r8
180002d98:     	js	0x180002d23 <.text+0x1d23>
180002d9a:     	movsd	(%r13,%r8,8), %xmm1
180002da1:     	mulsd	%xmm0, %xmm1
180002da5:     	addsd	(%r13,%rdx,8), %xmm1
180002dac:     	movsd	%xmm1, (%r13,%rdx,8)
180002db3:     	movq	0x18(%rbp,%rcx,8), %rdx
180002db8:     	testq	%rdx, %rdx
180002dbb:     	js	0x180002e75 <.text+0x1e75>
180002dc1:     	movq	(%rbp,%rcx,8), %r8
180002dc6:     	testq	%r8, %r8
180002dc9:     	js	0x180002e75 <.text+0x1e75>
180002dcf:     	movsd	0x8(%r13,%r8,8), %xmm1
180002dd6:     	mulsd	%xmm0, %xmm1
180002dda:     	addsd	0x8(%r13,%rdx,8), %xmm1
180002de1:     	movsd	%xmm1, 0x8(%r13,%rdx,8)
180002de8:     	movq	0x10(%rbp,%rcx,8), %rdx
180002ded:     	testq	%rdx, %rdx
180002df0:     	js	0x180002e8d <.text+0x1e8d>
180002df6:     	movq	0x18(%rbp,%rcx,8), %r8
180002dfb:     	testq	%r8, %r8
180002dfe:     	js	0x180002e8d <.text+0x1e8d>
180002e04:     	movsd	(%r13,%r8,8), %xmm1
180002e0b:     	mulsd	%xmm0, %xmm1
180002e0f:     	addsd	(%r13,%rdx,8), %xmm1
180002e16:     	movsd	%xmm1, (%r13,%rdx,8)
180002e1d:     	movq	0x10(%rbp,%rcx,8), %rdx
180002e22:     	testq	%rdx, %rdx
180002e25:     	js	0x180002ea5 <.text+0x1ea5>
180002e27:     	movq	0x18(%rbp,%rcx,8), %r8
180002e2c:     	testq	%r8, %r8
180002e2f:     	js	0x180002ea5 <.text+0x1ea5>
180002e31:     	movsd	0x8(%r13,%r8,8), %xmm1
180002e38:     	mulsd	%xmm0, %xmm1
180002e3c:     	addsd	0x8(%r13,%rdx,8), %xmm1
180002e43:     	movsd	%xmm1, 0x8(%r13,%rdx,8)
180002e4a:     	movq	(%rbp,%rcx,8), %rdx
180002e4f:     	testq	%rdx, %rdx
180002e52:     	js	0x180002ebd <.text+0x1ebd>
180002e54:     	movq	$0x0, (%r13,%rdx,8)
180002e5d:     	movq	(%rbp,%rcx,8), %rcx
180002e62:     	testq	%rcx, %rcx
180002e65:     	js	0x180002ed5 <.text+0x1ed5>
180002e67:     	movq	$0x0, 0x8(%r13,%rcx,8)
180002e70:     	jmp	0x180002d36 <.text+0x1d36>
180002e75:     	movb	$0x1, (%r15)
180002e79:     	movq	0x110(%rsp), %rcx
180002e81:     	movq	$0x5b8d84, (%rcx)       # imm = 0x5B8D84
180002e88:     	jmp	0x180002d36 <.text+0x1d36>
180002e8d:     	movb	$0x1, (%r15)
180002e91:     	movq	0x110(%rsp), %rcx
180002e99:     	movq	$0x5b8d87, (%rcx)       # imm = 0x5B8D87
180002ea0:     	jmp	0x180002d36 <.text+0x1d36>
180002ea5:     	movb	$0x1, (%r15)
180002ea9:     	movq	0x110(%rsp), %rcx
180002eb1:     	movq	$0x5b8d88, (%rcx)       # imm = 0x5B8D88
180002eb8:     	jmp	0x180002d36 <.text+0x1d36>
180002ebd:     	movb	$0x1, (%r15)
180002ec1:     	movq	0x110(%rsp), %rcx
180002ec9:     	movq	$0x5b8d8b, (%rcx)       # imm = 0x5B8D8B
180002ed0:     	jmp	0x180002d36 <.text+0x1d36>
180002ed5:     	movb	$0x1, (%r15)
180002ed9:     	movq	0x110(%rsp), %rcx
180002ee1:     	movq	$0x5b8d8c, (%rcx)       # imm = 0x5B8D8C
180002ee8:     	jmp	0x180002d36 <.text+0x1d36>
180002eed:     	movq	0x158(%rsp), %rdx
180002ef5:     	movq	0x140(%rsp), %rcx
180002efd:     	movq	%rdx, (%rcx)
180002f00:     	jmp	0x18000259b <.text+0x159b>
180002f05:     	movb	$0x1, (%r15)
180002f09:     	movq	0x110(%rsp), %rax
180002f11:     	movq	$0x12, (%rax)
180002f18:     	jmp	0x180002d02 <.text+0x1d02>
180002f1d:     	movb	$0x1, (%r15)
180002f21:     	movq	0x110(%rsp), %rax
180002f29:     	movq	$0xd, (%rax)
180002f30:     	jmp	0x180002d02 <.text+0x1d02>
180002f35:     	movb	$0x1, (%r15)
180002f39:     	movq	0x110(%rsp), %rax
180002f41:     	movq	$0xe, (%rax)
180002f48:     	jmp	0x180002d02 <.text+0x1d02>
180002f4d:     	movq	0x140(%rsp), %rcx
180002f55:     	movq	$0x0, (%rcx)
180002f5c:     	jmp	0x18000259b <.text+0x159b>
180002f61:     	nopw	%cs:(%rax,%rax)
180002f6b:     	nopl	(%rax,%rax)
180002f70:     	pushq	%r15
180002f72:     	pushq	%r14
180002f74:     	pushq	%r13
180002f76:     	pushq	%r12
180002f78:     	pushq	%rsi
180002f79:     	pushq	%rdi
180002f7a:     	pushq	%rbp
180002f7b:     	pushq	%rbx
180002f7c:     	subq	$0x338, %rsp            # imm = 0x338
180002f83:     	movaps	%xmm7, 0x320(%rsp)
180002f8b:     	movaps	%xmm6, 0x310(%rsp)
180002f93:     	movq	%rdx, %rcx
180002f96:     	leaq	0x1c8(%rsp), %rax
180002f9e:     	movq	%rax, 0x60(%rsp)
180002fa3:     	leaq	0x1d0(%rsp), %rax
180002fab:     	movq	%rax, 0x58(%rsp)
180002fb0:     	leaq	0x1d8(%rsp), %rax
180002fb8:     	movq	%rax, 0x50(%rsp)
180002fbd:     	leaq	0x1e0(%rsp), %rax
180002fc5:     	movq	%rax, 0x48(%rsp)
180002fca:     	leaq	0x1e8(%rsp), %rax
180002fd2:     	movq	%rax, 0x40(%rsp)
180002fd7:     	leaq	0x1f0(%rsp), %rax
180002fdf:     	movq	%rax, 0x38(%rsp)
180002fe4:     	leaq	0x1f8(%rsp), %rax
180002fec:     	movq	%rax, 0x30(%rsp)
180002ff1:     	leaq	0x200(%rsp), %rax
180002ff9:     	movq	%rax, 0x28(%rsp)
180002ffe:     	leaq	0x208(%rsp), %rax
180003006:     	movq	%rax, 0x20(%rsp)
18000300b:     	leaq	0x96fe(%rip), %rdx      # 0x18000c710
180003012:     	movl	$0x9, %r8d
180003018:     	movl	$0x9, %r9d
18000301e:     	callq	0x18000b0d1 <numba_list_iter_next+0x311>
180003023:     	testl	%eax, %eax
180003025:     	movq	$0x0, 0x130(%rsp)
180003031:     	je	0x18000372c <.text+0x272c>
180003037:     	cmpq	$0x0, 0x10c89(%rip)     # 0x180013cc8
18000303f:     	je	0x180003654 <.text+0x2654>
180003045:     	movq	0x208(%rsp), %rcx
18000304d:     	xorps	%xmm0, %xmm0
180003050:     	movaps	%xmm0, 0x2d0(%rsp)
180003058:     	movaps	%xmm0, 0x2e0(%rsp)
180003060:     	movaps	%xmm0, 0x2f0(%rsp)
180003068:     	movq	$0x0, 0x300(%rsp)
180003074:     	leaq	0x2d0(%rsp), %rdx
18000307c:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180003081:     	testl	%eax, %eax
180003083:     	jne	0x18000366c <.text+0x266c>
180003089:     	cmpq	$0x8, 0x2e8(%rsp)
180003092:     	jne	0x18000366c <.text+0x266c>
180003098:     	movq	0x2d0(%rsp), %rbx
1800030a0:     	movq	0x2d8(%rsp), %rbp
1800030a8:     	movq	0x2e0(%rsp), %rsi
1800030b0:     	movq	0x2f0(%rsp), %rdi
1800030b8:     	movq	0x2f8(%rsp), %r15
1800030c0:     	movq	0x300(%rsp), %r13
1800030c8:     	movq	0x200(%rsp), %rcx
1800030d0:     	xorps	%xmm0, %xmm0
1800030d3:     	movaps	%xmm0, 0x290(%rsp)
1800030db:     	movaps	%xmm0, 0x2a0(%rsp)
1800030e3:     	movaps	%xmm0, 0x2b0(%rsp)
1800030eb:     	movq	$0x0, 0x2c0(%rsp)
1800030f7:     	leaq	0x290(%rsp), %rdx
1800030ff:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
180003104:     	testl	%eax, %eax
180003106:     	jne	0x180003684 <.text+0x2684>
18000310c:     	cmpq	$0x8, 0x2a8(%rsp)
180003115:     	jne	0x180003684 <.text+0x2684>
18000311b:     	movq	0x290(%rsp), %r12
180003123:     	movq	0x298(%rsp), %r14
18000312b:     	movq	0x2a0(%rsp), %rax
180003133:     	movq	%rax, 0x1c0(%rsp)
18000313b:     	movq	0x2b0(%rsp), %rax
180003143:     	movq	%rax, 0x1b8(%rsp)
18000314b:     	movq	0x2b8(%rsp), %rax
180003153:     	movq	%rax, 0x1b0(%rsp)
18000315b:     	movq	0x2c0(%rsp), %rax
180003163:     	movq	%rax, 0x1a8(%rsp)
18000316b:     	movq	0x1f8(%rsp), %rcx
180003173:     	xorps	%xmm0, %xmm0
180003176:     	movaps	%xmm0, 0x250(%rsp)
18000317e:     	movaps	%xmm0, 0x260(%rsp)
180003186:     	movaps	%xmm0, 0x270(%rsp)
18000318e:     	movq	$0x0, 0x280(%rsp)
18000319a:     	leaq	0x250(%rsp), %rdx
1800031a2:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
1800031a7:     	testl	%eax, %eax
1800031a9:     	jne	0x18000369c <.text+0x269c>
1800031af:     	cmpq	$0x8, 0x268(%rsp)
1800031b8:     	jne	0x18000369c <.text+0x269c>
1800031be:     	movq	%r14, 0x1a0(%rsp)
1800031c6:     	movq	0x250(%rsp), %r14
1800031ce:     	movq	0x258(%rsp), %rax
1800031d6:     	movq	%rax, 0x198(%rsp)
1800031de:     	movq	0x260(%rsp), %rax
1800031e6:     	movq	%rax, 0x190(%rsp)
1800031ee:     	movq	0x270(%rsp), %rax
1800031f6:     	movq	%rax, 0x188(%rsp)
1800031fe:     	movq	0x278(%rsp), %rax
180003206:     	movq	%rax, 0x180(%rsp)
18000320e:     	movq	0x280(%rsp), %rax
180003216:     	movq	%rax, 0x178(%rsp)
18000321e:     	movq	0x1f0(%rsp), %rcx
180003226:     	xorps	%xmm0, %xmm0
180003229:     	movaps	%xmm0, 0x210(%rsp)
180003231:     	movaps	%xmm0, 0x220(%rsp)
180003239:     	movaps	%xmm0, 0x230(%rsp)
180003241:     	movq	$0x0, 0x240(%rsp)
18000324d:     	leaq	0x210(%rsp), %rdx
180003255:     	callq	0x180009d90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62b0>
18000325a:     	testl	%eax, %eax
18000325c:     	jne	0x1800036b1 <.text+0x26b1>
180003262:     	cmpq	$0x1, 0x228(%rsp)
18000326b:     	jne	0x1800036b1 <.text+0x26b1>
180003271:     	movq	%r13, 0x150(%rsp)
180003279:     	movq	%r15, 0x158(%rsp)
180003281:     	movq	%rdi, 0x160(%rsp)
180003289:     	movq	%rsi, 0x168(%rsp)
180003291:     	movq	0x210(%rsp), %r15
180003299:     	movq	0x218(%rsp), %rax
1800032a1:     	movq	%rax, 0x148(%rsp)
1800032a9:     	movq	0x220(%rsp), %rax
1800032b1:     	movq	%rax, 0x140(%rsp)
1800032b9:     	movq	0x230(%rsp), %rax
1800032c1:     	movq	%rax, 0x138(%rsp)
1800032c9:     	movq	0x238(%rsp), %rdi
1800032d1:     	movq	0x240(%rsp), %rsi
1800032d9:     	movq	0x1e8(%rsp), %rcx
1800032e1:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
1800032e6:     	testq	%rax, %rax
1800032e9:     	movq	%rbx, 0x128(%rsp)
1800032f1:     	movq	%r12, 0x120(%rsp)
1800032f9:     	movq	%rbp, 0x170(%rsp)
180003301:     	je	0x1800036c6 <.text+0x26c6>
180003307:     	movq	%rax, %r13
18000330a:     	movq	%rax, %rcx
18000330d:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
180003312:     	movq	%rax, %r12
180003315:     	movq	%r13, %rcx
180003318:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
18000331d:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180003322:     	testq	%rax, %rax
180003325:     	jne	0x1800036fc <.text+0x26fc>
18000332b:     	movq	0x1e0(%rsp), %rcx
180003333:     	callq	0x18000b0ef <numba_list_iter_next+0x32f>
180003338:     	movq	%rax, %rbx
18000333b:     	movq	%rax, %rcx
18000333e:     	callq	0x18000b0f5 <numba_list_iter_next+0x335>
180003343:     	movaps	%xmm0, %xmm6
180003346:     	movq	%rbx, %rcx
180003349:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
18000334e:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180003353:     	testq	%rax, %rax
180003356:     	jne	0x1800036fc <.text+0x26fc>
18000335c:     	movq	0x1d8(%rsp), %rcx
180003364:     	callq	0x18000b0ef <numba_list_iter_next+0x32f>
180003369:     	movq	%rax, %rbx
18000336c:     	movq	%rax, %rcx
18000336f:     	callq	0x18000b0f5 <numba_list_iter_next+0x335>
180003374:     	movaps	%xmm0, %xmm7
180003377:     	movq	%rbx, %rcx
18000337a:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
18000337f:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
180003384:     	testq	%rax, %rax
180003387:     	jne	0x1800036fc <.text+0x26fc>
18000338d:     	movq	0x1d0(%rsp), %rcx
180003395:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
18000339a:     	testq	%rax, %rax
18000339d:     	je	0x1800036d9 <.text+0x26d9>
1800033a3:     	movq	%rax, %rbp
1800033a6:     	movq	%rax, %rcx
1800033a9:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
1800033ae:     	movq	%rax, %r13
1800033b1:     	movq	%rbp, %rcx
1800033b4:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
1800033b9:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800033be:     	testq	%rax, %rax
1800033c1:     	jne	0x1800036fc <.text+0x26fc>
1800033c7:     	movq	0x1c8(%rsp), %rcx
1800033cf:     	callq	0x18000b0d7 <numba_list_iter_next+0x317>
1800033d4:     	testq	%rax, %rax
1800033d7:     	je	0x1800036ec <.text+0x26ec>
1800033dd:     	movq	%rax, %rbx
1800033e0:     	movq	%rax, %rcx
1800033e3:     	callq	0x18000b0dd <numba_list_iter_next+0x31d>
1800033e8:     	movq	%rax, %rbp
1800033eb:     	movq	%rbx, %rcx
1800033ee:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
1800033f3:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800033f8:     	testq	%rax, %rax
1800033fb:     	jne	0x1800036fc <.text+0x26fc>
180003401:     	movq	%rbp, 0x110(%rsp)
180003409:     	movq	%r13, 0x108(%rsp)
180003411:     	movq	%r12, 0xf0(%rsp)
180003419:     	movq	%rsi, 0xe8(%rsp)
180003421:     	movq	%rdi, 0xe0(%rsp)
180003429:     	movq	0x138(%rsp), %rax
180003431:     	movq	%rax, 0xd8(%rsp)
180003439:     	movq	0x140(%rsp), %rax
180003441:     	movq	%rax, 0xc8(%rsp)
180003449:     	movq	0x148(%rsp), %rax
180003451:     	movq	%rax, 0xc0(%rsp)
180003459:     	movq	0x178(%rsp), %rax
180003461:     	movq	%rax, 0xb0(%rsp)
180003469:     	movq	0x180(%rsp), %rax
180003471:     	movq	%rax, 0xa8(%rsp)
180003479:     	movq	0x188(%rsp), %rax
180003481:     	movq	%rax, 0xa0(%rsp)
180003489:     	movq	0x190(%rsp), %rax
180003491:     	movq	%rax, 0x90(%rsp)
180003499:     	movq	0x198(%rsp), %rax
1800034a1:     	movq	%rax, 0x88(%rsp)
1800034a9:     	movq	0x1a8(%rsp), %rax
1800034b1:     	movq	%rax, 0x78(%rsp)
1800034b6:     	movq	0x1b0(%rsp), %rax
1800034be:     	movq	%rax, 0x70(%rsp)
1800034c3:     	movq	0x1b8(%rsp), %rax
1800034cb:     	movq	%rax, 0x68(%rsp)
1800034d0:     	movq	0x1c0(%rsp), %rax
1800034d8:     	movq	%rax, 0x58(%rsp)
1800034dd:     	movq	0x1a0(%rsp), %rax
1800034e5:     	movq	%rax, 0x50(%rsp)
1800034ea:     	movq	0x150(%rsp), %rax
1800034f2:     	movq	%rax, 0x40(%rsp)
1800034f7:     	movq	0x158(%rsp), %rax
1800034ff:     	movq	%rax, 0x38(%rsp)
180003504:     	movsd	%xmm7, 0x100(%rsp)
18000350d:     	movsd	%xmm6, 0xf8(%rsp)
180003516:     	movq	%r15, 0xb8(%rsp)
18000351e:     	movq	%r14, 0x80(%rsp)
180003526:     	movq	0x120(%rsp), %rdi
18000352e:     	movq	%rdi, 0x48(%rsp)
180003533:     	movq	0x160(%rsp), %rax
18000353b:     	movq	%rax, 0x30(%rsp)
180003540:     	movq	0x168(%rsp), %rax
180003548:     	movq	%rax, 0x20(%rsp)
18000354d:     	movq	$0x1, 0xd0(%rsp)
180003559:     	movq	$0x8, 0x98(%rsp)
180003565:     	movq	$0x8, 0x60(%rsp)
18000356e:     	movq	$0x8, 0x28(%rsp)
180003577:     	leaq	0x308(%rsp), %rcx
18000357f:     	leaq	0x130(%rsp), %rdx
180003587:     	movq	0x170(%rsp), %r9
18000358f:     	movq	0x128(%rsp), %rsi
180003597:     	movq	%rsi, %r8
18000359a:     	callq	0x1800024f0 <.text+0x14f0>
18000359f:     	movl	%eax, %ebp
1800035a1:     	movq	0x130(%rsp), %rbx
1800035a9:     	movq	%rsi, %rcx
1800035ac:     	callq	0x180001060 <.text+0x60>
1800035b1:     	movq	%rdi, %rcx
1800035b4:     	callq	0x180001060 <.text+0x60>
1800035b9:     	movq	%r14, %rcx
1800035bc:     	callq	0x180001060 <.text+0x60>
1800035c1:     	movq	%r15, %rcx
1800035c4:     	callq	0x180001060 <.text+0x60>
1800035c9:     	testl	%ebp, %ebp
1800035cb:     	jne	0x180003603 <.text+0x2603>
1800035cd:     	movq	0x8cfc(%rip), %rsi      # 0x18000c2d0
1800035d4:     	movq	%rsi, %rcx
1800035d7:     	callq	0x18000b0fb <numba_list_iter_next+0x33b>
1800035dc:     	movq	%rsi, %rax
1800035df:     	movaps	0x310(%rsp), %xmm6
1800035e7:     	movaps	0x320(%rsp), %xmm7
1800035ef:     	addq	$0x338, %rsp            # imm = 0x338
1800035f6:     	popq	%rbx
1800035f7:     	popq	%rbp
1800035f8:     	popq	%rdi
1800035f9:     	popq	%rsi
1800035fa:     	popq	%r12
1800035fc:     	popq	%r13
1800035fe:     	popq	%r14
180003600:     	popq	%r15
180003602:     	retq
180003603:     	jle	0x180003733 <.text+0x2733>
180003609:     	callq	0x18000b101 <numba_list_iter_next+0x341>
18000360e:     	movl	0x8(%rbx), %edx
180003611:     	movq	(%rbx), %rcx
180003614:     	cmpl	$0x0, 0x20(%rbx)
180003618:     	jle	0x180003752 <.text+0x2752>
18000361e:     	movslq	%edx, %rdx
180003621:     	callq	0x18000b107 <numba_list_iter_next+0x347>
180003626:     	movq	%rax, %rsi
180003629:     	movq	0x10(%rbx), %rcx
18000362d:     	callq	*0x18(%rbx)
180003630:     	testq	%rax, %rax
180003633:     	je	0x18000377b <.text+0x277b>
180003639:     	movq	%rsi, %rcx
18000363c:     	movq	%rax, %rdx
18000363f:     	callq	0x1800095a0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5ac0>
180003644:     	movq	%rax, %rsi
180003647:     	movq	%rbx, %rcx
18000364a:     	callq	0x18000b030 <numba_list_iter_next+0x270>
18000364f:     	jmp	0x18000375e <.text+0x275e>
180003654:     	movq	0x8c55(%rip), %rcx      # 0x18000c2b0
18000365b:     	leaq	0x90ce(%rip), %rdx      # 0x18000c730
180003662:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180003667:     	jmp	0x18000372c <.text+0x272c>
18000366c:     	movq	0x8c2d(%rip), %rcx      # 0x18000c2a0
180003673:     	leaq	0x91b6(%rip), %rdx      # 0x18000c830
18000367a:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
18000367f:     	jmp	0x18000372c <.text+0x272c>
180003684:     	movq	0x8c15(%rip), %rcx      # 0x18000c2a0
18000368b:     	leaq	0x919e(%rip), %rdx      # 0x18000c830
180003692:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180003697:     	jmp	0x180003724 <.text+0x2724>
18000369c:     	movq	0x8bfd(%rip), %rcx      # 0x18000c2a0
1800036a3:     	leaq	0x9186(%rip), %rdx      # 0x18000c830
1800036aa:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800036af:     	jmp	0x18000371c <.text+0x271c>
1800036b1:     	movq	0x8be8(%rip), %rcx      # 0x18000c2a0
1800036b8:     	leaq	0x9171(%rip), %rdx      # 0x18000c830
1800036bf:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
1800036c4:     	jmp	0x180003714 <.text+0x2714>
1800036c6:     	xorl	%r12d, %r12d
1800036c9:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800036ce:     	testq	%rax, %rax
1800036d1:     	je	0x18000332b <.text+0x232b>
1800036d7:     	jmp	0x1800036fc <.text+0x26fc>
1800036d9:     	xorl	%r13d, %r13d
1800036dc:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800036e1:     	testq	%rax, %rax
1800036e4:     	je	0x1800033c7 <.text+0x23c7>
1800036ea:     	jmp	0x1800036fc <.text+0x26fc>
1800036ec:     	xorl	%ebp, %ebp
1800036ee:     	callq	0x18000b0e9 <numba_list_iter_next+0x329>
1800036f3:     	testq	%rax, %rax
1800036f6:     	je	0x180003401 <.text+0x2401>
1800036fc:     	movq	%r15, %rcx
1800036ff:     	callq	0x180001060 <.text+0x60>
180003704:     	movq	0x128(%rsp), %rbx
18000370c:     	movq	0x120(%rsp), %r12
180003714:     	movq	%r14, %rcx
180003717:     	callq	0x180001060 <.text+0x60>
18000371c:     	movq	%r12, %rcx
18000371f:     	callq	0x180001060 <.text+0x60>
180003724:     	movq	%rbx, %rcx
180003727:     	callq	0x180001060 <.text+0x60>
18000372c:     	xorl	%esi, %esi
18000372e:     	jmp	0x1800035dc <.text+0x25dc>
180003733:     	cmpl	$-0x3, %ebp
180003736:     	je	0x18000376d <.text+0x276d>
180003738:     	cmpl	$-0x1, %ebp
18000373b:     	je	0x18000372c <.text+0x272c>
18000373d:     	movq	0x8b54(%rip), %rcx      # 0x18000c298
180003744:     	leaq	0x9185(%rip), %rdx      # 0x18000c8d0
18000374b:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180003750:     	jmp	0x18000372c <.text+0x272c>
180003752:     	movq	0x10(%rbx), %r8
180003756:     	callq	0x1800094c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59e0>
18000375b:     	movq	%rax, %rsi
18000375e:     	testq	%rsi, %rsi
180003761:     	je	0x18000372c <.text+0x272c>
180003763:     	movq	%rsi, %rcx
180003766:     	callq	0x180009060 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5580>
18000376b:     	jmp	0x18000372c <.text+0x272c>
18000376d:     	movq	0x8b1c(%rip), %rcx      # 0x18000c290
180003774:     	callq	0x18000b113 <numba_list_iter_next+0x353>
180003779:     	jmp	0x18000372c <.text+0x272c>
18000377b:     	movq	0x8b2e(%rip), %rcx      # 0x18000c2b0
180003782:     	leaq	0x9107(%rip), %rdx      # 0x18000c890
180003789:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
18000378e:     	jmp	0x18000372c <.text+0x272c>
180003790:     	pushq	%r15
180003792:     	pushq	%r14
180003794:     	pushq	%r13
180003796:     	pushq	%r12
180003798:     	pushq	%rsi
180003799:     	pushq	%rdi
18000379a:     	pushq	%rbp
18000379b:     	pushq	%rbx
18000379c:     	subq	$0x148, %rsp            # imm = 0x148
1800037a3:     	movq	%r9, %r12
1800037a6:     	movq	%r8, %r13
1800037a9:     	movq	%rdx, 0x140(%rsp)
1800037b1:     	movq	%rcx, 0x138(%rsp)
1800037b9:     	movsd	0x278(%rsp), %xmm0
1800037c2:     	movsd	0x280(%rsp), %xmm1
1800037cb:     	movq	$0x0, 0x130(%rsp)
1800037d7:     	movq	$0x0, 0x128(%rsp)
1800037e3:     	movq	0x220(%rsp), %rbp
1800037eb:     	movq	0x228(%rsp), %r15
1800037f3:     	movq	0x230(%rsp), %r14
1800037fb:     	movq	0x238(%rsp), %rbx
180003803:     	movq	0x240(%rsp), %rdi
18000380b:     	movq	0x248(%rsp), %rsi
180003813:     	movq	0x250(%rsp), %r11
18000381b:     	movq	0x258(%rsp), %r10
180003823:     	movq	0x260(%rsp), %r9
18000382b:     	movq	0x268(%rsp), %r8
180003833:     	movq	0x270(%rsp), %rdx
18000383b:     	movq	0x288(%rsp), %rcx
180003843:     	movq	0x290(%rsp), %rax
18000384b:     	movq	%rax, 0x110(%rsp)
180003853:     	movq	%rcx, 0x108(%rsp)
18000385b:     	movq	%rdx, 0xf0(%rsp)
180003863:     	movq	%r8, 0xe8(%rsp)
18000386b:     	movq	%r9, 0xe0(%rsp)
180003873:     	movq	%r10, 0xd8(%rsp)
18000387b:     	movq	%r11, 0xd0(%rsp)
180003883:     	movq	%rsi, 0xc8(%rsp)
18000388b:     	movq	%rdi, 0xc0(%rsp)
180003893:     	movq	%rbx, 0xb8(%rsp)
18000389b:     	movq	%r14, 0xb0(%rsp)
1800038a3:     	movq	%r15, 0xa8(%rsp)
1800038ab:     	movq	%rbp, 0xa0(%rsp)
1800038b3:     	movq	0x218(%rsp), %rax
1800038bb:     	movq	%rax, 0x98(%rsp)
1800038c3:     	movq	0x210(%rsp), %rax
1800038cb:     	movq	%rax, 0x90(%rsp)
1800038d3:     	movq	0x208(%rsp), %rax
1800038db:     	movq	%rax, 0x88(%rsp)
1800038e3:     	movq	0x200(%rsp), %rax
1800038eb:     	movq	%rax, 0x80(%rsp)
1800038f3:     	movq	0x1f8(%rsp), %rax
1800038fb:     	movq	%rax, 0x78(%rsp)
180003900:     	movq	0x1f0(%rsp), %rax
180003908:     	movq	%rax, 0x70(%rsp)
18000390d:     	movq	0x1e8(%rsp), %rax
180003915:     	movq	%rax, 0x68(%rsp)
18000391a:     	movq	0x1e0(%rsp), %rax
180003922:     	movq	%rax, 0x60(%rsp)
180003927:     	movq	0x1d8(%rsp), %rax
18000392f:     	movq	%rax, 0x58(%rsp)
180003934:     	movq	0x1d0(%rsp), %rax
18000393c:     	movq	%rax, 0x50(%rsp)
180003941:     	movq	0x1c8(%rsp), %rax
180003949:     	movq	%rax, 0x48(%rsp)
18000394e:     	movq	0x1c0(%rsp), %rax
180003956:     	movq	%rax, 0x40(%rsp)
18000395b:     	movq	0x1b8(%rsp), %rax
180003963:     	movq	%rax, 0x38(%rsp)
180003968:     	movq	0x1b0(%rsp), %rax
180003970:     	movq	%rax, 0x30(%rsp)
180003975:     	movsd	%xmm1, 0x100(%rsp)
18000397e:     	movsd	%xmm0, 0xf8(%rsp)
180003987:     	movq	%r12, 0x28(%rsp)
18000398c:     	movq	%r13, 0x20(%rsp)
180003991:     	leaq	0x130(%rsp), %rcx
180003999:     	leaq	0x128(%rsp), %rdx
1800039a1:     	movq	0x138(%rsp), %r8
1800039a9:     	movq	0x140(%rsp), %r9
1800039b1:     	callq	0x1800024f0 <.text+0x14f0>
1800039b6:     	movl	%eax, %edx
1800039b8:     	movq	0x128(%rsp), %rsi
1800039c0:     	movq	0x130(%rsp), %rax
1800039c8:     	movl	$0x0, 0x124(%rsp)
1800039d3:     	testl	%edx, %edx
1800039d5:     	jne	0x1800039eb <.text+0x29eb>
1800039d7:     	addq	$0x148, %rsp            # imm = 0x148
1800039de:     	popq	%rbx
1800039df:     	popq	%rbp
1800039e0:     	popq	%rdi
1800039e1:     	popq	%rsi
1800039e2:     	popq	%r12
1800039e4:     	popq	%r13
1800039e6:     	popq	%r14
1800039e8:     	popq	%r15
1800039ea:     	retq
1800039eb:     	movq	%rax, %rbx
1800039ee:     	leaq	0x124(%rsp), %rcx
1800039f6:     	movl	%edx, %edi
1800039f8:     	callq	0x180009030 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5550>
1800039fd:     	testl	%edi, %edi
1800039ff:     	jle	0x180003a45 <.text+0x2a45>
180003a01:     	callq	0x18000b101 <numba_list_iter_next+0x341>
180003a06:     	movl	0x8(%rsi), %edx
180003a09:     	movq	(%rsi), %rcx
180003a0c:     	cmpl	$0x0, 0x20(%rsi)
180003a10:     	jle	0x180003a66 <.text+0x2a66>
180003a12:     	movslq	%edx, %rdx
180003a15:     	callq	0x18000b107 <numba_list_iter_next+0x347>
180003a1a:     	movq	%rax, %rdi
180003a1d:     	movq	0x10(%rsi), %rcx
180003a21:     	callq	*0x18(%rsi)
180003a24:     	testq	%rax, %rax
180003a27:     	je	0x180003ac1 <.text+0x2ac1>
180003a2d:     	movq	%rdi, %rcx
180003a30:     	movq	%rax, %rdx
180003a33:     	callq	0x1800095a0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5ac0>
180003a38:     	movq	%rax, %rdi
180003a3b:     	movq	%rsi, %rcx
180003a3e:     	callq	0x18000b030 <numba_list_iter_next+0x270>
180003a43:     	jmp	0x180003a72 <.text+0x2a72>
180003a45:     	movl	%edi, %eax
180003a47:     	cmpl	$-0x3, %edi
180003a4a:     	je	0x180003ab3 <.text+0x2ab3>
180003a4c:     	cmpl	$-0x1, %eax
180003a4f:     	je	0x180003a7f <.text+0x2a7f>
180003a51:     	movq	0x8840(%rip), %rcx      # 0x18000c298
180003a58:     	leaq	0x8ee1(%rip), %rdx      # 0x18000c940
180003a5f:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180003a64:     	jmp	0x180003a7f <.text+0x2a7f>
180003a66:     	movq	0x10(%rsi), %r8
180003a6a:     	callq	0x1800094c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59e0>
180003a6f:     	movq	%rax, %rdi
180003a72:     	testq	%rdi, %rdi
180003a75:     	je	0x180003a7f <.text+0x2a7f>
180003a77:     	movq	%rdi, %rcx
180003a7a:     	callq	0x180009060 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5580>
180003a7f:     	leaq	0x8eea(%rip), %rcx      # 0x18000c970
180003a86:     	callq	0x18000b119 <numba_list_iter_next+0x359>
180003a8b:     	movq	%rax, %rsi
180003a8e:     	movq	%rax, %rcx
180003a91:     	callq	0x18000b11f <numba_list_iter_next+0x35f>
180003a96:     	movq	%rsi, %rcx
180003a99:     	callq	0x18000b0e3 <numba_list_iter_next+0x323>
180003a9e:     	leaq	0x124(%rsp), %rcx
180003aa6:     	callq	0x180009050 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5570>
180003aab:     	movq	%rbx, %rax
180003aae:     	jmp	0x1800039d7 <.text+0x29d7>
180003ab3:     	movq	0x87d6(%rip), %rcx      # 0x18000c290
180003aba:     	callq	0x18000b113 <numba_list_iter_next+0x353>
180003abf:     	jmp	0x180003a7f <.text+0x2a7f>
180003ac1:     	movq	0x87e8(%rip), %rcx      # 0x18000c2b0
180003ac8:     	leaq	0x8e31(%rip), %rdx      # 0x18000c900
180003acf:     	callq	0x18000b10d <numba_list_iter_next+0x34d>
180003ad4:     	xorl	%eax, %eax
180003ad6:     	jmp	0x1800039d7 <.text+0x29d7>
180003adb:     	nopl	(%rax,%rax)

0000000180003ae0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730>:
180003ae0:     	pushq	%rsi
180003ae1:     	subq	$0x20, %rsp
180003ae5:     	leaq	0xf574(%rip), %rcx      # 0x180013060
180003aec:     	movl	$0x3f5, %edx            # imm = 0x3F5
180003af1:     	callq	0x18000b125 <numba_list_iter_next+0x365>
180003af6:     	testq	%rax, %rax
180003af9:     	je	0x180003b2b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4b>
180003afb:     	leaq	0xf4fe(%rip), %rdx      # 0x180013000
180003b02:     	leaq	0x8ed7(%rip), %r8       # 0x18000c9e0
180003b09:     	leaq	0x8fc0(%rip), %r9       # 0x18000cad0
180003b10:     	movq	%rax, %rcx
180003b13:     	movq	%rax, %rsi
180003b16:     	callq	0x18000a000 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6520>
180003b1b:     	movl	%eax, %ecx
180003b1d:     	xorl	%eax, %eax
180003b1f:     	testl	%ecx, %ecx
180003b21:     	cmoveq	%rsi, %rax
180003b25:     	addq	$0x20, %rsp
180003b29:     	popq	%rsi
180003b2a:     	retq
180003b2b:     	xorl	%eax, %eax
180003b2d:     	addq	$0x20, %rsp
180003b31:     	popq	%rsi
180003b32:     	retq
180003b33:     	nopw	%cs:(%rax,%rax)
180003b3d:     	nopl	(%rax)
180003b40:     	pushq	%r15
180003b42:     	pushq	%r14
180003b44:     	pushq	%r13
180003b46:     	pushq	%r12
180003b48:     	pushq	%rsi
180003b49:     	pushq	%rdi
180003b4a:     	pushq	%rbp
180003b4b:     	pushq	%rbx
180003b4c:     	subq	$0x198, %rsp            # imm = 0x198
180003b53:     	movapd	%xmm8, 0x180(%rsp)
180003b5d:     	movapd	%xmm7, 0x170(%rsp)
180003b66:     	movapd	%xmm6, 0x160(%rsp)
180003b6f:     	movq	0x2d0(%rsp), %r13
180003b77:     	movq	0x210(%rsp), %rsi
180003b7f:     	movsd	0x48(%rsi,%r13,8), %xmm0
180003b86:     	xorpd	%xmm1, %xmm1
180003b8a:     	ucomisd	%xmm1, %xmm0
180003b8e:     	jne	0x180003bd0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xf0>
180003b90:     	jp	0x180003bd0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xf0>
180003b92:     	movq	$0x0, 0x8(%rcx)
180003b9a:     	movq	$0x0, (%rcx)
180003ba1:     	xorl	%eax, %eax
180003ba3:     	movaps	0x160(%rsp), %xmm6
180003bab:     	movaps	0x170(%rsp), %xmm7
180003bb3:     	movaps	0x180(%rsp), %xmm8
180003bbc:     	addq	$0x198, %rsp            # imm = 0x198
180003bc3:     	popq	%rbx
180003bc4:     	popq	%rbp
180003bc5:     	popq	%rdi
180003bc6:     	popq	%rsi
180003bc7:     	popq	%r12
180003bc9:     	popq	%r13
180003bcb:     	popq	%r14
180003bcd:     	popq	%r15
180003bcf:     	retq
180003bd0:     	movq	0x2d8(%rsp), %r12
180003bd8:     	movq	0x250(%rsp), %r15
180003be0:     	movq	0x248(%rsp), %r14
180003be8:     	movq	0x30(%r14,%r13,8), %rax
180003bed:     	movq	%rax, %r10
180003bf0:     	sarq	$0x3f, %r10
180003bf4:     	andq	%r15, %r10
180003bf7:     	leaq	(%r14,%rax,8), %rdx
180003bfb:     	cmpq	$0x1, (%rdx,%r10,8)
180003c00:     	jne	0x180003c27 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x147>
180003c02:     	xorl	%r10d, %r10d
180003c05:     	cmpq	$-0x2, %rax
180003c09:     	cmovlq	%r15, %r10
180003c0d:     	movq	0x10(%rdx,%r10,8), %rax
180003c12:     	leaq	(%r14,%rax,8), %rdx
180003c16:     	sarq	$0x3f, %rax
180003c1a:     	andq	%r15, %rax
180003c1d:     	cmpq	%r12, (%rdx,%rax,8)
180003c21:     	je	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
180003c27:     	movq	0x2b8(%rsp), %rbx
180003c2f:     	movq	0x280(%rsp), %rdi
180003c37:     	movq	0x10(%r14,%r13,8), %rax
180003c3c:     	movq	0x10(%r14,%r12,8), %rdx
180003c41:     	movsd	(%rsi,%rax,8), %xmm1
180003c46:     	movsd	0x8(%rsi,%rax,8), %xmm2
180003c4c:     	subsd	(%rsi,%rdx,8), %xmm1
180003c51:     	subsd	0x8(%rsi,%rdx,8), %xmm2
180003c57:     	movapd	%xmm1, %xmm4
180003c5b:     	mulsd	%xmm1, %xmm4
180003c5f:     	movapd	%xmm2, %xmm3
180003c63:     	mulsd	%xmm2, %xmm3
180003c67:     	addsd	%xmm4, %xmm3
180003c6b:     	xorps	%xmm4, %xmm4
180003c6e:     	sqrtsd	%xmm3, %xmm4
180003c72:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003c78:     	je	0x180003cb7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1d7>
180003c7a:     	xorpd	%xmm5, %xmm5
180003c7e:     	ucomisd	%xmm5, %xmm3
180003c82:     	jne	0x180003c96 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1b6>
180003c84:     	jp	0x180003c96 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1b6>
180003c86:     	movb	$0x1, (%rbx)
180003c89:     	movq	$0x3d090f, 0x18(%rdi)   # imm = 0x3D090F
180003c91:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
180003c96:     	movsd	0x2e0(%rsp), %xmm6
180003c9f:     	movq	(%r14,%r13,8), %rax
180003ca3:     	movsd	0x8(%rsi,%rax,8), %xmm3
180003ca9:     	addsd	%xmm3, %xmm3
180003cad:     	divsd	%xmm4, %xmm3
180003cb1:     	ucomisd	%xmm3, %xmm6
180003cb5:     	jbe	0x180003d1c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x23c>
180003cb7:     	movsd	0x86f9(%rip), %xmm3     # 0x18000c3b8
180003cbf:     	maxsd	%xmm4, %xmm3
180003cc3:     	movapd	%xmm3, %xmm4
180003cc7:     	mulsd	%xmm3, %xmm4
180003ccb:     	xorpd	%xmm5, %xmm5
180003ccf:     	ucomisd	%xmm5, %xmm4
180003cd3:     	jne	0x180003ce7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x207>
180003cd5:     	jp	0x180003ce7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x207>
180003cd7:     	movb	$0x1, (%rbx)
180003cda:     	movq	$0x3d0915, 0x18(%rdi)   # imm = 0x3D0915
180003ce2:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
180003ce7:     	movsd	0x8(%rsi,%r12,8), %xmm5
180003cee:     	mulsd	0x86ca(%rip), %xmm5     # 0x18000c3c0
180003cf6:     	mulsd	%xmm5, %xmm0
180003cfa:     	divsd	%xmm4, %xmm0
180003cfe:     	mulsd	%xmm0, %xmm1
180003d02:     	divsd	%xmm3, %xmm1
180003d06:     	mulsd	%xmm0, %xmm2
180003d0a:     	divsd	%xmm3, %xmm2
180003d0e:     	movsd	%xmm1, (%rcx)
180003d12:     	movsd	%xmm2, 0x8(%rcx)
180003d17:     	jmp	0x180003ba1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xc1>
180003d1c:     	movq	0x2c8(%rsp), %rdx
180003d24:     	movq	0x298(%rsp), %rbp
180003d2c:     	movq	0x290(%rsp), %r11
180003d34:     	movq	0x20(%r14,%r13,8), %rax
180003d39:     	testq	%rax, %rax
180003d3c:     	js	0x180003f2c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x44c>
180003d42:     	movq	0x8(%rdi), %rdx
180003d46:     	leaq	0x1(%rdx), %r10
180003d4a:     	movq	%r10, 0x8(%rdi)
180003d4e:     	cmpq	0x10(%rdi), %rdx
180003d52:     	jge	0x1800042ea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x80a>
180003d58:     	movq	%rcx, 0x108(%rsp)
180003d60:     	movsd	%xmm6, 0x100(%rsp)
180003d69:     	movq	%r12, 0xf8(%rsp)
180003d71:     	movq	%rax, 0xf0(%rsp)
180003d79:     	movq	0x2c8(%rsp), %rax
180003d81:     	movq	%rax, 0xe8(%rsp)
180003d89:     	movq	0x2c0(%rsp), %rax
180003d91:     	movq	%rax, 0xe0(%rsp)
180003d99:     	movq	%rbx, 0xd8(%rsp)
180003da1:     	movq	0x2b0(%rsp), %rax
180003da9:     	movq	%rax, 0xd0(%rsp)
180003db1:     	movq	0x2a8(%rsp), %rax
180003db9:     	movq	%rax, 0xc8(%rsp)
180003dc1:     	movq	0x2a0(%rsp), %rax
180003dc9:     	movq	%rax, 0xc0(%rsp)
180003dd1:     	movq	%rbp, 0xb8(%rsp)
180003dd9:     	movq	%r11, 0xb0(%rsp)
180003de1:     	movq	0x288(%rsp), %rax
180003de9:     	movq	%rax, 0xa8(%rsp)
180003df1:     	movq	%rdi, 0xa0(%rsp)
180003df9:     	movq	0x278(%rsp), %rax
180003e01:     	movq	%rax, 0x98(%rsp)
180003e09:     	movq	0x270(%rsp), %rax
180003e11:     	movq	%rax, 0x90(%rsp)
180003e19:     	movq	0x268(%rsp), %rax
180003e21:     	movq	%rax, 0x88(%rsp)
180003e29:     	movq	0x260(%rsp), %rax
180003e31:     	movq	%rax, 0x80(%rsp)
180003e39:     	movq	0x258(%rsp), %rax
180003e41:     	movq	%rax, 0x78(%rsp)
180003e46:     	movq	%r15, 0x70(%rsp)
180003e4b:     	movq	%r14, 0x68(%rsp)
180003e50:     	movq	0x240(%rsp), %rax
180003e58:     	movq	%rax, 0x60(%rsp)
180003e5d:     	movq	0x238(%rsp), %rax
180003e65:     	movq	%rax, 0x58(%rsp)
180003e6a:     	movq	0x230(%rsp), %rax
180003e72:     	movq	%rax, 0x50(%rsp)
180003e77:     	movq	0x228(%rsp), %rax
180003e7f:     	movq	%rax, 0x48(%rsp)
180003e84:     	movq	0x220(%rsp), %rax
180003e8c:     	movq	%rax, 0x40(%rsp)
180003e91:     	movq	0x218(%rsp), %rax
180003e99:     	movq	%rax, 0x38(%rsp)
180003e9e:     	movq	%rsi, 0x30(%rsp)
180003ea3:     	movq	0x208(%rsp), %rax
180003eab:     	movq	%rax, 0x28(%rsp)
180003eb0:     	movq	0x200(%rsp), %rax
180003eb8:     	movq	%rax, 0x20(%rsp)
180003ebd:     	leaq	0x150(%rsp), %rcx
180003ec5:     	movq	%r8, 0x110(%rsp)
180003ecd:     	movq	%r9, %rbp
180003ed0:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
180003ed5:     	cmpb	$0x0, (%rbx)
180003ed8:     	jne	0x1800042ce <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x7ee>
180003ede:     	xorpd	%xmm8, %xmm8
180003ee3:     	movsd	0x150(%rsp), %xmm7
180003eec:     	addsd	%xmm8, %xmm7
180003ef1:     	addsd	0x158(%rsp), %xmm8
180003efb:     	decq	0x8(%rdi)
180003eff:     	movq	0x108(%rsp), %rcx
180003f07:     	movq	%rbp, %r9
180003f0a:     	movq	0x110(%rsp), %r8
180003f12:     	movq	0x290(%rsp), %r11
180003f1a:     	movq	0x298(%rsp), %rbp
180003f22:     	movq	0x2c8(%rsp), %rdx
180003f2a:     	jmp	0x180003f35 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x455>
180003f2c:     	xorpd	%xmm7, %xmm7
180003f30:     	xorpd	%xmm8, %xmm8
180003f35:     	movq	0x28(%r14,%r13,8), %rax
180003f3a:     	testq	%rax, %rax
180003f3d:     	js	0x180004123 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x643>
180003f43:     	movq	0x8(%rdi), %rdx
180003f47:     	leaq	0x1(%rdx), %r10
180003f4b:     	movq	%r10, 0x8(%rdi)
180003f4f:     	cmpq	0x10(%rdi), %rdx
180003f53:     	jge	0x1800042fa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x81a>
180003f59:     	movq	%rcx, 0x108(%rsp)
180003f61:     	movsd	%xmm6, 0x100(%rsp)
180003f6a:     	movq	%r12, 0xf8(%rsp)
180003f72:     	movq	%rax, 0xf0(%rsp)
180003f7a:     	movq	0x2c8(%rsp), %rax
180003f82:     	movq	%rax, 0xe8(%rsp)
180003f8a:     	movq	0x2c0(%rsp), %rax
180003f92:     	movq	%rax, 0xe0(%rsp)
180003f9a:     	movq	%rbx, 0xd8(%rsp)
180003fa2:     	movq	0x2b0(%rsp), %rax
180003faa:     	movq	%rax, 0xd0(%rsp)
180003fb2:     	movq	0x2a8(%rsp), %rax
180003fba:     	movq	%rax, 0xc8(%rsp)
180003fc2:     	movq	0x2a0(%rsp), %rax
180003fca:     	movq	%rax, 0xc0(%rsp)
180003fd2:     	movq	%rbp, 0xb8(%rsp)
180003fda:     	movq	%r11, 0xb0(%rsp)
180003fe2:     	movq	0x288(%rsp), %rax
180003fea:     	movq	%rax, 0xa8(%rsp)
180003ff2:     	movq	%rdi, 0xa0(%rsp)
180003ffa:     	movq	0x278(%rsp), %rax
180004002:     	movq	%rax, 0x98(%rsp)
18000400a:     	movq	0x270(%rsp), %rax
180004012:     	movq	%rax, 0x90(%rsp)
18000401a:     	movq	0x268(%rsp), %rax
180004022:     	movq	%rax, 0x88(%rsp)
18000402a:     	movq	0x260(%rsp), %rax
180004032:     	movq	%rax, 0x80(%rsp)
18000403a:     	movq	0x258(%rsp), %rax
180004042:     	movq	%rax, 0x78(%rsp)
180004047:     	movq	%r15, 0x70(%rsp)
18000404c:     	movq	%r14, 0x68(%rsp)
180004051:     	movq	0x240(%rsp), %rax
180004059:     	movq	%rax, 0x60(%rsp)
18000405e:     	movq	0x238(%rsp), %rax
180004066:     	movq	%rax, 0x58(%rsp)
18000406b:     	movq	0x230(%rsp), %rax
180004073:     	movq	%rax, 0x50(%rsp)
180004078:     	movq	0x228(%rsp), %rax
180004080:     	movq	%rax, 0x48(%rsp)
180004085:     	movq	0x220(%rsp), %rax
18000408d:     	movq	%rax, 0x40(%rsp)
180004092:     	movq	0x218(%rsp), %rax
18000409a:     	movq	%rax, 0x38(%rsp)
18000409f:     	movq	%rsi, 0x30(%rsp)
1800040a4:     	movq	0x208(%rsp), %rax
1800040ac:     	movq	%rax, 0x28(%rsp)
1800040b1:     	movq	0x200(%rsp), %rax
1800040b9:     	movq	%rax, 0x20(%rsp)
1800040be:     	leaq	0x140(%rsp), %rcx
1800040c6:     	movq	%r8, 0x110(%rsp)
1800040ce:     	movq	%r9, 0x118(%rsp)
1800040d6:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
1800040db:     	cmpb	$0x0, (%rbx)
1800040de:     	jne	0x1800042ce <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x7ee>
1800040e4:     	addsd	0x140(%rsp), %xmm7
1800040ed:     	addsd	0x148(%rsp), %xmm8
1800040f7:     	decq	0x8(%rdi)
1800040fb:     	movq	0x108(%rsp), %rcx
180004103:     	movq	0x118(%rsp), %r9
18000410b:     	movq	0x110(%rsp), %r8
180004113:     	movq	0x290(%rsp), %r11
18000411b:     	movq	0x2c8(%rsp), %rdx
180004123:     	movq	0x38(%r14,%r13,8), %rax
180004128:     	testq	%rax, %rax
18000412b:     	js	0x180004359 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x879>
180004131:     	movq	0x8(%rdi), %rdx
180004135:     	leaq	0x1(%rdx), %r10
180004139:     	movq	%r10, 0x8(%rdi)
18000413d:     	cmpq	0x10(%rdi), %rdx
180004141:     	jge	0x18000430a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x82a>
180004147:     	movq	%rcx, 0x108(%rsp)
18000414f:     	movsd	%xmm6, 0x100(%rsp)
180004158:     	movq	%r12, 0xf8(%rsp)
180004160:     	movq	%rax, 0xf0(%rsp)
180004168:     	movq	0x2c8(%rsp), %rax
180004170:     	movq	%rax, 0xe8(%rsp)
180004178:     	movq	0x2c0(%rsp), %rax
180004180:     	movq	%rax, 0xe0(%rsp)
180004188:     	movq	%rbx, 0xd8(%rsp)
180004190:     	movq	0x2b0(%rsp), %rax
180004198:     	movq	%rax, 0xd0(%rsp)
1800041a0:     	movq	0x2a8(%rsp), %rax
1800041a8:     	movq	%rax, 0xc8(%rsp)
1800041b0:     	movq	0x2a0(%rsp), %rax
1800041b8:     	movq	%rax, 0xc0(%rsp)
1800041c0:     	movq	%rbp, 0xb8(%rsp)
1800041c8:     	movq	%r11, 0xb0(%rsp)
1800041d0:     	movq	0x288(%rsp), %rax
1800041d8:     	movq	%rax, 0xa8(%rsp)
1800041e0:     	movq	%rdi, 0xa0(%rsp)
1800041e8:     	movq	0x278(%rsp), %rax
1800041f0:     	movq	%rax, 0x98(%rsp)
1800041f8:     	movq	0x270(%rsp), %rax
180004200:     	movq	%rax, 0x90(%rsp)
180004208:     	movq	0x268(%rsp), %rax
180004210:     	movq	%rax, 0x88(%rsp)
180004218:     	movq	0x260(%rsp), %rax
180004220:     	movq	%rax, 0x80(%rsp)
180004228:     	movq	0x258(%rsp), %rax
180004230:     	movq	%rax, 0x78(%rsp)
180004235:     	movq	%r15, 0x70(%rsp)
18000423a:     	movq	%r14, 0x68(%rsp)
18000423f:     	movq	0x240(%rsp), %rax
180004247:     	movq	%rax, 0x60(%rsp)
18000424c:     	movq	0x238(%rsp), %rax
180004254:     	movq	%rax, 0x58(%rsp)
180004259:     	movq	0x230(%rsp), %rax
180004261:     	movq	%rax, 0x50(%rsp)
180004266:     	movq	0x228(%rsp), %rax
18000426e:     	movq	%rax, 0x48(%rsp)
180004273:     	movq	0x220(%rsp), %rax
18000427b:     	movq	%rax, 0x40(%rsp)
180004280:     	movq	0x218(%rsp), %rax
180004288:     	movq	%rax, 0x38(%rsp)
18000428d:     	movq	%rsi, 0x30(%rsp)
180004292:     	movq	0x208(%rsp), %rax
18000429a:     	movq	%rax, 0x28(%rsp)
18000429f:     	movq	0x200(%rsp), %rax
1800042a7:     	movq	%rax, 0x20(%rsp)
1800042ac:     	leaq	0x130(%rsp), %rcx
1800042b4:     	movq	%r8, 0x110(%rsp)
1800042bc:     	movq	%r9, 0x118(%rsp)
1800042c4:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
1800042c9:     	cmpb	$0x0, (%rbx)
1800042cc:     	je	0x18000431a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x83a>
1800042ce:     	movq	0x108(%rsp), %rax
1800042d6:     	movq	$0x0, 0x8(%rax)
1800042de:     	movq	$0x0, (%rax)
1800042e5:     	jmp	0x180003ba1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xc1>
1800042ea:     	movb	$0x1, (%rbx)
1800042ed:     	movq	$0x3d0921, 0x18(%rdi)   # imm = 0x3D0921
1800042f5:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
1800042fa:     	movb	$0x1, (%rbx)
1800042fd:     	movq	$0x3d0926, 0x18(%rdi)   # imm = 0x3D0926
180004305:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
18000430a:     	movb	$0x1, (%rbx)
18000430d:     	movq	$0x3d092b, 0x18(%rdi)   # imm = 0x3D092B
180004315:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
18000431a:     	addsd	0x130(%rsp), %xmm7
180004323:     	addsd	0x138(%rsp), %xmm8
18000432d:     	decq	0x8(%rdi)
180004331:     	movq	0x108(%rsp), %rcx
180004339:     	movq	0x118(%rsp), %r9
180004341:     	movq	0x110(%rsp), %r8
180004349:     	movq	0x290(%rsp), %r11
180004351:     	movq	0x2c8(%rsp), %rdx
180004359:     	movq	0x40(%r14,%r13,8), %rax
18000435e:     	testq	%rax, %rax
180004361:     	js	0x18000453b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa5b>
180004367:     	movq	%rdx, %r13
18000436a:     	movq	0x8(%rdi), %rdx
18000436e:     	leaq	0x1(%rdx), %r10
180004372:     	movq	%r10, 0x8(%rdi)
180004376:     	cmpq	0x10(%rdi), %rdx
18000437a:     	jge	0x18000450c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa2c>
180004380:     	movq	%rcx, 0x108(%rsp)
180004388:     	movq	%r12, 0xf8(%rsp)
180004390:     	movq	%rax, 0xf0(%rsp)
180004398:     	movq	%r13, 0xe8(%rsp)
1800043a0:     	movq	0x2c0(%rsp), %rax
1800043a8:     	movq	%rax, 0xe0(%rsp)
1800043b0:     	movq	0x2b0(%rsp), %rax
1800043b8:     	movq	%rax, 0xd0(%rsp)
1800043c0:     	movq	0x2a8(%rsp), %rax
1800043c8:     	movq	%rax, 0xc8(%rsp)
1800043d0:     	movq	0x2a0(%rsp), %rax
1800043d8:     	movq	%rax, 0xc0(%rsp)
1800043e0:     	movq	%rbp, 0xb8(%rsp)
1800043e8:     	movq	%r11, 0xb0(%rsp)
1800043f0:     	movq	0x288(%rsp), %rax
1800043f8:     	movq	%rax, 0xa8(%rsp)
180004400:     	movq	0x278(%rsp), %rax
180004408:     	movq	%rax, 0x98(%rsp)
180004410:     	movq	0x270(%rsp), %rax
180004418:     	movq	%rax, 0x90(%rsp)
180004420:     	movq	0x268(%rsp), %rax
180004428:     	movq	%rax, 0x88(%rsp)
180004430:     	movq	0x260(%rsp), %rax
180004438:     	movq	%rax, 0x80(%rsp)
180004440:     	movq	0x258(%rsp), %rax
180004448:     	movq	%rax, 0x78(%rsp)
18000444d:     	movq	%r15, 0x70(%rsp)
180004452:     	movq	%r14, 0x68(%rsp)
180004457:     	movq	0x240(%rsp), %rax
18000445f:     	movq	%rax, 0x60(%rsp)
180004464:     	movq	0x238(%rsp), %rax
18000446c:     	movq	%rax, 0x58(%rsp)
180004471:     	movq	0x230(%rsp), %rax
180004479:     	movq	%rax, 0x50(%rsp)
18000447e:     	movq	0x228(%rsp), %rax
180004486:     	movq	%rax, 0x48(%rsp)
18000448b:     	movq	0x220(%rsp), %rax
180004493:     	movq	%rax, 0x40(%rsp)
180004498:     	movq	0x218(%rsp), %rax
1800044a0:     	movq	%rax, 0x38(%rsp)
1800044a5:     	movq	%rsi, 0x30(%rsp)
1800044aa:     	movq	0x208(%rsp), %rax
1800044b2:     	movq	%rax, 0x28(%rsp)
1800044b7:     	movsd	%xmm6, 0x100(%rsp)
1800044c0:     	movq	%rbx, 0xd8(%rsp)
1800044c8:     	movq	%rdi, 0xa0(%rsp)
1800044d0:     	movq	0x200(%rsp), %rax
1800044d8:     	movq	%rax, 0x20(%rsp)
1800044dd:     	leaq	0x120(%rsp), %rcx
1800044e5:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
1800044ea:     	cmpb	$0x0, (%rbx)
1800044ed:     	je	0x18000451c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa3c>
1800044ef:     	movq	0x108(%rsp), %r13
1800044f7:     	movq	$0x0, 0x8(%r13)
1800044ff:     	movq	$0x0, (%r13)
180004507:     	jmp	0x180003ba1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xc1>
18000450c:     	movb	$0x1, (%rbx)
18000450f:     	movq	$0x3d0930, 0x18(%rdi)   # imm = 0x3D0930
180004517:     	jmp	0x180003b92 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xb2>
18000451c:     	addsd	0x120(%rsp), %xmm7
180004525:     	addsd	0x128(%rsp), %xmm8
18000452f:     	decq	0x8(%rdi)
180004533:     	movq	0x108(%rsp), %rcx
18000453b:     	movsd	%xmm7, (%rcx)
18000453f:     	movsd	%xmm8, 0x8(%rcx)
180004545:     	jmp	0x180003ba1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xc1>
18000454a:     	nopw	(%rax,%rax)
180004550:     	pushq	%r15
180004552:     	pushq	%r14
180004554:     	pushq	%r13
180004556:     	pushq	%r12
180004558:     	pushq	%rsi
180004559:     	pushq	%rdi
18000455a:     	pushq	%rbp
18000455b:     	pushq	%rbx
18000455c:     	subq	$0x178, %rsp            # imm = 0x178
180004563:     	movq	0x2b0(%rsp), %rax
18000456b:     	movq	0x298(%rsp), %r13
180004573:     	movq	0x260(%rsp), %r15
18000457b:     	movq	0x258(%rsp), %rdi
180004583:     	movb	$0x0, 0x137(%rsp)
18000458b:     	movb	$0x0, 0x127(%rsp)
180004593:     	movb	$0x0, 0x126(%rsp)
18000459b:     	movb	$0x0, 0x125(%rsp)
1800045a3:     	movb	$0x0, 0x124(%rsp)
1800045ab:     	movb	$0x0, 0x136(%rsp)
1800045b3:     	movb	$0x0, 0x135(%rsp)
1800045bb:     	movb	$0x0, 0x134(%rsp)
1800045c3:     	movb	$0x0, 0x133(%rsp)
1800045cb:     	cmpq	$0x1, %rax
1800045cf:     	movq	0x230(%rsp), %rbx
1800045d7:     	movq	0x228(%rsp), %rbp
1800045df:     	movq	0x1f0(%rsp), %r14
1800045e7:     	je	0x18000477f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xc9f>
1800045ed:     	testq	%rax, %rax
1800045f0:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
1800045f6:     	movq	0x2c0(%rsp), %rsi
1800045fe:     	movq	0x2b8(%rsp), %rdi
180004606:     	movq	(%rbp,%rdi,8), %rax
18000460b:     	movq	0x10(%rbp,%rsi,8), %rdx
180004610:     	movsd	(%r14,%rdx,8), %xmm0
180004616:     	movsd	0x8(%r14,%rax,8), %xmm2
18000461d:     	movsd	0x10(%r14,%rax,8), %xmm1
180004624:     	movapd	%xmm1, %xmm3
180004628:     	subsd	%xmm2, %xmm3
18000462c:     	xorl	%r12d, %r12d
18000462f:     	ucomisd	%xmm3, %xmm0
180004633:     	jb	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004639:     	addsd	%xmm2, %xmm1
18000463d:     	ucomisd	%xmm0, %xmm1
180004641:     	jbe	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004647:     	movsd	0x8(%r14,%rdx,8), %xmm0
18000464e:     	movsd	(%r14,%rax,8), %xmm2
180004654:     	movsd	0x18(%r14,%rax,8), %xmm1
18000465b:     	movapd	%xmm1, %xmm3
18000465f:     	subsd	%xmm2, %xmm3
180004663:     	ucomisd	%xmm3, %xmm0
180004667:     	jb	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
18000466d:     	addsd	%xmm2, %xmm1
180004671:     	xorl	%r12d, %r12d
180004674:     	ucomisd	%xmm0, %xmm1
180004678:     	jbe	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
18000467e:     	cmpb	$0x0, (%r13)
180004683:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004689:     	movq	0x18(%rbp,%rdi,8), %r12
18000468e:     	movq	0x30(%rbp,%rdi,8), %rdx
180004693:     	movq	%rdx, %r11
180004696:     	sarq	$0x3f, %r11
18000469a:     	andq	%rbx, %r11
18000469d:     	leaq	(%rbp,%rdx,8), %r10
1800046a2:     	movq	(%r10,%r11,8), %rax
1800046a6:     	cmpq	0x8(%rbp,%rdi,8), %rax
1800046ab:     	jge	0x18000497c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe9c>
1800046b1:     	testq	%r12, %r12
1800046b4:     	jne	0x180004985 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xea5>
1800046ba:     	xorl	%r9d, %r9d
1800046bd:     	cmpq	$-0x1, %rdx
1800046c1:     	cmovlq	%rbx, %r9
1800046c5:     	cmpq	0x8(%r10,%r9,8), %rax
1800046ca:     	jne	0x180005213 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1733>
1800046d0:     	leaq	(%rax,%rax), %r8
1800046d4:     	testq	%rax, %rax
1800046d7:     	movl	$0x4, %r10d
1800046dd:     	cmovneq	%r8, %r10
1800046e1:     	movq	(%r15), %r12
1800046e4:     	leaq	(%r12,%r10), %r8
1800046e8:     	cmpq	%rbx, %r8
1800046eb:     	jg	0x18000478b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xcab>
1800046f1:     	movq	%r8, (%r15)
1800046f4:     	cmpb	$0x0, (%r13)
1800046f9:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
1800046ff:     	movq	%r12, 0x128(%rsp)
180004707:     	movq	%r10, 0x168(%rsp)
18000470f:     	movq	%r9, 0x170(%rsp)
180004717:     	xorl	%r8d, %r8d
18000471a:     	cmpq	$-0x2, %rdx
18000471e:     	cmovlq	%rbx, %r8
180004722:     	movq	%r8, 0x148(%rsp)
18000472a:     	movq	%rax, 0x140(%rsp)
180004732:     	testq	%rax, %rax
180004735:     	jle	0x1800051dc <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x16fc>
18000473b:     	leaq	(%rbp,%rdx,8), %r8
180004740:     	movq	0x148(%rsp), %r9
180004748:     	movq	0x10(%r8,%r9,8), %r15
18000474d:     	movq	0x140(%rsp), %rax
180004755:     	movl	%eax, %r10d
180004758:     	andl	$0x7, %r10d
18000475c:     	cmpq	$0x7, %rax
180004760:     	ja	0x180004faa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x14ca>
180004766:     	leaq	(,%rbx,8), %r8
18000476e:     	movq	$0x0, 0x138(%rsp)
18000477a:     	jmp	0x180005192 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x16b2>
18000477f:     	movq	(%r15), %rdx
180004782:     	leaq	0x4(%rdx), %rax
180004786:     	cmpq	%rbx, %rax
180004789:     	jle	0x180004795 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xcb5>
18000478b:     	movb	$0x2, (%r13)
180004790:     	jmp	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
180004795:     	movq	0x2c8(%rsp), %rsi
18000479d:     	movq	(%rbp,%rsi,8), %r10
1800047a2:     	movsd	0x10(%r14,%r10,8), %xmm1
1800047a9:     	movsd	0x18(%r14,%r10,8), %xmm2
1800047b0:     	movsd	0x7bf8(%rip), %xmm0     # 0x18000c3b0
1800047b8:     	movsd	0x8(%r14,%r10,8), %xmm3
1800047bf:     	mulsd	%xmm0, %xmm3
1800047c3:     	mulsd	(%r14,%r10,8), %xmm0
1800047c9:     	movq	%rax, (%r15)
1800047cc:     	cmpb	$0x0, (%r13)
1800047d1:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
1800047d7:     	movapd	%xmm1, %xmm4
1800047db:     	addsd	%xmm3, %xmm4
1800047df:     	movapd	%xmm2, %xmm5
1800047e3:     	subsd	%xmm0, %xmm5
1800047e7:     	movsd	%xmm4, 0x10(%r14,%rdx,8)
1800047ee:     	movsd	%xmm5, 0x18(%r14,%rdx,8)
1800047f5:     	movsd	%xmm3, 0x8(%r14,%rdx,8)
1800047fc:     	movsd	%xmm0, (%r14,%rdx,8)
180004802:     	cmpb	$0x0, (%r13)
180004807:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
18000480d:     	movq	(%r15), %rax
180004810:     	leaq	0xa(%rax), %r11
180004814:     	cmpq	%rbx, %r11
180004817:     	jg	0x18000478b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xcab>
18000481d:     	movq	0x8(%rbp,%rsi,8), %r10
180004822:     	movq	%r11, (%r15)
180004825:     	cmpb	$0x0, (%r13)
18000482a:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
180004830:     	movq	%rdx, (%rbp,%rax,8)
180004835:     	movq	%r10, 0x8(%rbp,%rax,8)
18000483a:     	movq	(%r15), %rdx
18000483d:     	cmpq	%rbx, %rdx
180004840:     	movq	%rdx, %r10
180004843:     	jle	0x180004850 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xd70>
180004845:     	movb	$0x2, (%r13)
18000484a:     	movq	(%r15), %rdx
18000484d:     	xorl	%r10d, %r10d
180004850:     	leaq	0x3(%rdx), %r11
180004854:     	cmpq	%rbx, %r11
180004857:     	jg	0x18000478b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xcab>
18000485d:     	movq	%r11, (%r15)
180004860:     	cmpb	$0x0, (%r13)
180004865:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
18000486b:     	movq	%rdx, %r11
18000486e:     	sarq	$0x3f, %r11
180004872:     	andq	%rbx, %r11
180004875:     	leaq	(%rbp,%rdx,8), %rsi
18000487a:     	movq	$0x0, (%rsi,%r11,8)
180004882:     	xorl	%r12d, %r12d
180004885:     	cmpq	$-0x1, %rdx
180004889:     	movl	$0x0, %r11d
18000488f:     	cmovlq	%rbx, %r11
180004893:     	movq	$0x0, 0x8(%rsi,%r11,8)
18000489c:     	cmpq	$-0x2, %rdx
1800048a0:     	movl	$0x0, %r11d
1800048a6:     	cmovlq	%rbx, %r11
1800048aa:     	movq	%r10, 0x10(%rsi,%r11,8)
1800048af:     	cmpb	$0x0, (%r13)
1800048b4:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
1800048ba:     	leaq	(%rbp,%rax,8), %r10
1800048bf:     	movq	%rdx, 0x30(%r10)
1800048c3:     	movq	$0x0, 0x18(%r10)
1800048cb:     	movq	(%r15), %rdx
1800048ce:     	leaq	0x2(%rdx), %r11
1800048d2:     	cmpq	%rbx, %r11
1800048d5:     	jg	0x18000478b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xcab>
1800048db:     	movq	%r11, (%r15)
1800048de:     	cmpb	$0x0, (%r13)
1800048e3:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
1800048e9:     	movq	%r8, 0x128(%rsp)
1800048f1:     	movq	%r9, 0x138(%rsp)
1800048f9:     	movq	%rcx, 0x118(%rsp)
180004901:     	movq	$0x0, 0x8(%r14,%rdx,8)
18000490a:     	movq	$0x0, (%r14,%rdx,8)
180004912:     	cmpb	$0x0, (%r13)
180004917:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000491d:     	movq	%rdx, 0x10(%r10)
180004921:     	movq	$0x0, 0x48(%r14,%rax,8)
18000492a:     	movq	$-0x1, 0x28(%r10)
180004932:     	movq	$-0x1, 0x20(%r10)
18000493a:     	movq	$-0x1, 0x38(%r10)
180004942:     	movq	$-0x1, 0x40(%r10)
18000494a:     	cmpb	$0x0, (%r13)
18000494f:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180004955:     	movq	0x2c8(%rsp), %rcx
18000495d:     	movq	%rax, 0x20(%rbp,%rcx,8)
180004962:     	movq	(%r15), %rcx
180004965:     	leaq	0x4(%rcx), %rax
180004969:     	cmpq	%rbx, %rax
18000496c:     	jle	0x1800054f5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1a15>
180004972:     	movb	$0x2, (%r13)
180004977:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000497c:     	testq	%r12, %r12
18000497f:     	je	0x180004bac <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x10cc>
180004985:     	movq	0x20(%rbp,%rdi,8), %rax
18000498a:     	testq	%rax, %rax
18000498d:     	js	0x180004daa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12ca>
180004993:     	movq	0x8(%r15), %rdx
180004997:     	leaq	0x1(%rdx), %r10
18000499b:     	movq	%r10, 0x8(%r15)
18000499f:     	cmpq	0x10(%r15), %rdx
1800049a3:     	jge	0x180004daa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12ca>
1800049a9:     	movq	%rcx, 0x118(%rsp)
1800049b1:     	movb	$0x0, 0x127(%rsp)
1800049b9:     	movq	%rsi, 0x100(%rsp)
1800049c1:     	movq	%rax, 0xf8(%rsp)
1800049c9:     	movq	0x2a8(%rsp), %rax
1800049d1:     	movq	%rax, 0xe8(%rsp)
1800049d9:     	movq	0x2a0(%rsp), %rax
1800049e1:     	movq	%rax, 0xe0(%rsp)
1800049e9:     	movq	%r13, 0xd8(%rsp)
1800049f1:     	movq	0x290(%rsp), %rax
1800049f9:     	movq	%rax, 0xd0(%rsp)
180004a01:     	movq	0x288(%rsp), %rax
180004a09:     	movq	%rax, 0xc8(%rsp)
180004a11:     	movq	0x280(%rsp), %rax
180004a19:     	movq	%rax, 0xc0(%rsp)
180004a21:     	movq	0x278(%rsp), %rax
180004a29:     	movq	%rax, 0xb8(%rsp)
180004a31:     	movq	0x270(%rsp), %rax
180004a39:     	movq	%rax, 0xb0(%rsp)
180004a41:     	movq	0x268(%rsp), %rax
180004a49:     	movq	%rax, 0xa8(%rsp)
180004a51:     	movq	%r15, 0xa0(%rsp)
180004a59:     	movq	0x258(%rsp), %rax
180004a61:     	movq	%rax, 0x98(%rsp)
180004a69:     	movq	0x250(%rsp), %rax
180004a71:     	movq	%rax, 0x90(%rsp)
180004a79:     	movq	0x248(%rsp), %rax
180004a81:     	movq	%rax, 0x88(%rsp)
180004a89:     	movq	0x240(%rsp), %rax
180004a91:     	movq	%rax, 0x80(%rsp)
180004a99:     	movq	0x238(%rsp), %rax
180004aa1:     	movq	%rax, 0x78(%rsp)
180004aa6:     	movq	%rbx, 0x70(%rsp)
180004aab:     	movq	%rbp, 0x68(%rsp)
180004ab0:     	movq	0x220(%rsp), %rax
180004ab8:     	movq	%rax, 0x60(%rsp)
180004abd:     	movq	0x218(%rsp), %rax
180004ac5:     	movq	%rax, 0x58(%rsp)
180004aca:     	movq	0x210(%rsp), %rax
180004ad2:     	movq	%rax, 0x50(%rsp)
180004ad7:     	movq	0x208(%rsp), %rax
180004adf:     	movq	%rax, 0x48(%rsp)
180004ae4:     	movq	0x200(%rsp), %rax
180004aec:     	movq	%rax, 0x40(%rsp)
180004af1:     	movq	0x1f8(%rsp), %rax
180004af9:     	movq	%rax, 0x38(%rsp)
180004afe:     	movq	%r14, 0x30(%rsp)
180004b03:     	movq	0x1e8(%rsp), %rax
180004b0b:     	movq	%rax, 0x28(%rsp)
180004b10:     	movq	0x1e0(%rsp), %rax
180004b18:     	movq	%rax, 0x20(%rsp)
180004b1d:     	movq	$-0x1, 0x108(%rsp)
180004b29:     	movq	$0x0, 0xf0(%rsp)
180004b35:     	leaq	0x127(%rsp), %rcx
180004b3d:     	movq	%r8, 0x128(%rsp)
180004b45:     	movq	%r9, 0x138(%rsp)
180004b4d:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180004b52:     	cmpb	$0x0, (%r13)
180004b57:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180004b5d:     	movq	0x8(%r15), %rdx
180004b61:     	leaq	-0x1(%rdx), %rax
180004b65:     	cmpb	$0x0, 0x127(%rsp)
180004b6d:     	movq	%rax, 0x8(%r15)
180004b71:     	movb	$0x1, %r12b
180004b74:     	movq	0x118(%rsp), %rcx
180004b7c:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004b82:     	movq	0x28(%rbp,%rdi,8), %rax
180004b87:     	testq	%rax, %rax
180004b8a:     	js	0x180004b9a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x10ba>
180004b8c:     	movq	%rdx, 0x8(%r15)
180004b90:     	cmpq	0x10(%r15), %rdx
180004b94:     	jle	0x180004dd7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12f7>
180004b9a:     	movb	$0x1, (%r13)
180004b9f:     	movq	$0x2dc6ce, 0x18(%r15)   # imm = 0x2DC6CE
180004ba7:     	jmp	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
180004bac:     	movq	0x8(%r15), %rax
180004bb0:     	leaq	0x1(%rax), %rdx
180004bb4:     	movq	%rdx, 0x8(%r15)
180004bb8:     	cmpq	0x10(%r15), %rax
180004bbc:     	jge	0x180004d76 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1296>
180004bc2:     	movq	%rcx, 0x118(%rsp)
180004bca:     	movq	%rdi, 0x108(%rsp)
180004bd2:     	movq	0x2a8(%rsp), %rax
180004bda:     	movq	%rax, 0xe8(%rsp)
180004be2:     	movq	0x2a0(%rsp), %rax
180004bea:     	movq	%rax, 0xe0(%rsp)
180004bf2:     	movq	%r13, 0xd8(%rsp)
180004bfa:     	movq	0x290(%rsp), %rax
180004c02:     	movq	%rax, 0xd0(%rsp)
180004c0a:     	movq	0x288(%rsp), %rax
180004c12:     	movq	%rax, 0xc8(%rsp)
180004c1a:     	movq	0x280(%rsp), %rax
180004c22:     	movq	%rax, 0xc0(%rsp)
180004c2a:     	movq	0x278(%rsp), %rax
180004c32:     	movq	%rax, 0xb8(%rsp)
180004c3a:     	movq	0x270(%rsp), %rax
180004c42:     	movq	%rax, 0xb0(%rsp)
180004c4a:     	movq	0x268(%rsp), %rax
180004c52:     	movq	%rax, 0xa8(%rsp)
180004c5a:     	movq	%r15, 0xa0(%rsp)
180004c62:     	movq	0x258(%rsp), %rax
180004c6a:     	movq	%rax, 0x98(%rsp)
180004c72:     	movq	0x250(%rsp), %rax
180004c7a:     	movq	%rax, 0x90(%rsp)
180004c82:     	movq	0x248(%rsp), %rax
180004c8a:     	movq	%rax, 0x88(%rsp)
180004c92:     	movq	0x240(%rsp), %rax
180004c9a:     	movq	%rax, 0x80(%rsp)
180004ca2:     	movq	0x238(%rsp), %rax
180004caa:     	movq	%rax, 0x78(%rsp)
180004caf:     	movq	%rbx, 0x70(%rsp)
180004cb4:     	movq	%rbp, 0x68(%rsp)
180004cb9:     	movq	0x220(%rsp), %rax
180004cc1:     	movq	%rax, 0x60(%rsp)
180004cc6:     	movq	0x218(%rsp), %rax
180004cce:     	movq	%rax, 0x58(%rsp)
180004cd3:     	movq	0x210(%rsp), %rax
180004cdb:     	movq	%rax, 0x50(%rsp)
180004ce0:     	movq	0x208(%rsp), %rax
180004ce8:     	movq	%rax, 0x48(%rsp)
180004ced:     	movq	0x200(%rsp), %rax
180004cf5:     	movq	%rax, 0x40(%rsp)
180004cfa:     	movq	0x1f8(%rsp), %rax
180004d02:     	movq	%rax, 0x38(%rsp)
180004d07:     	movq	%r14, 0x30(%rsp)
180004d0c:     	movq	0x1e8(%rsp), %rax
180004d14:     	movq	%rax, 0x28(%rsp)
180004d19:     	movq	0x1e0(%rsp), %rax
180004d21:     	movq	%rax, 0x20(%rsp)
180004d26:     	movq	$-0x1, 0x100(%rsp)
180004d32:     	movq	$-0x1, 0xf8(%rsp)
180004d3e:     	movq	$0x1, 0xf0(%rsp)
180004d4a:     	leaq	0x137(%rsp), %rcx
180004d52:     	movq	%r8, 0x128(%rsp)
180004d5a:     	movq	%r9, %r12
180004d5d:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180004d62:     	cmpb	$0x0, (%r13)
180004d67:     	je	0x180004d85 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12a5>
180004d69:     	xorl	%r12d, %r12d
180004d6c:     	movq	0x118(%rsp), %rcx
180004d74:     	jmp	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004d76:     	movb	$0x1, (%r13)
180004d7b:     	movq	$0x2dc6cb, 0x18(%r15)   # imm = 0x2DC6CB
180004d83:     	jmp	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
180004d85:     	decq	0x8(%r15)
180004d89:     	movq	0x118(%rsp), %rcx
180004d91:     	movq	%r12, %r9
180004d94:     	movq	0x128(%rsp), %r8
180004d9c:     	movq	0x20(%rbp,%rdi,8), %rax
180004da1:     	testq	%rax, %rax
180004da4:     	jns	0x180004993 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xeb3>
180004daa:     	movb	$0x1, (%r13)
180004daf:     	movq	$0x2dc6cd, 0x18(%r15)   # imm = 0x2DC6CD
180004db7:     	xorl	%r12d, %r12d
180004dba:     	andb	$0x1, %r12b
180004dbe:     	movb	%r12b, (%rcx)
180004dc1:     	xorl	%eax, %eax
180004dc3:     	addq	$0x178, %rsp            # imm = 0x178
180004dca:     	popq	%rbx
180004dcb:     	popq	%rbp
180004dcc:     	popq	%rdi
180004dcd:     	popq	%rsi
180004dce:     	popq	%r12
180004dd0:     	popq	%r13
180004dd2:     	popq	%r14
180004dd4:     	popq	%r15
180004dd6:     	retq
180004dd7:     	movb	$0x0, 0x126(%rsp)
180004ddf:     	movq	%rsi, 0x100(%rsp)
180004de7:     	movq	%rax, 0xf8(%rsp)
180004def:     	movq	0x2a8(%rsp), %rax
180004df7:     	movq	%rax, 0xe8(%rsp)
180004dff:     	movq	0x2a0(%rsp), %rax
180004e07:     	movq	%rax, 0xe0(%rsp)
180004e0f:     	movq	%r13, 0xd8(%rsp)
180004e17:     	movq	0x290(%rsp), %rax
180004e1f:     	movq	%rax, 0xd0(%rsp)
180004e27:     	movq	0x288(%rsp), %rax
180004e2f:     	movq	%rax, 0xc8(%rsp)
180004e37:     	movq	0x280(%rsp), %rax
180004e3f:     	movq	%rax, 0xc0(%rsp)
180004e47:     	movq	0x278(%rsp), %rax
180004e4f:     	movq	%rax, 0xb8(%rsp)
180004e57:     	movq	0x270(%rsp), %rax
180004e5f:     	movq	%rax, 0xb0(%rsp)
180004e67:     	movq	0x268(%rsp), %rax
180004e6f:     	movq	%rax, 0xa8(%rsp)
180004e77:     	movq	%r15, 0xa0(%rsp)
180004e7f:     	movq	0x258(%rsp), %rax
180004e87:     	movq	%rax, 0x98(%rsp)
180004e8f:     	movq	0x250(%rsp), %rax
180004e97:     	movq	%rax, 0x90(%rsp)
180004e9f:     	movq	0x248(%rsp), %rax
180004ea7:     	movq	%rax, 0x88(%rsp)
180004eaf:     	movq	0x240(%rsp), %rax
180004eb7:     	movq	%rax, 0x80(%rsp)
180004ebf:     	movq	0x238(%rsp), %rax
180004ec7:     	movq	%rax, 0x78(%rsp)
180004ecc:     	movq	%rbx, 0x70(%rsp)
180004ed1:     	movq	%rbp, 0x68(%rsp)
180004ed6:     	movq	0x220(%rsp), %rax
180004ede:     	movq	%rax, 0x60(%rsp)
180004ee3:     	movq	0x218(%rsp), %rax
180004eeb:     	movq	%rax, 0x58(%rsp)
180004ef0:     	movq	0x210(%rsp), %rax
180004ef8:     	movq	%rax, 0x50(%rsp)
180004efd:     	movq	0x208(%rsp), %rax
180004f05:     	movq	%rax, 0x48(%rsp)
180004f0a:     	movq	0x200(%rsp), %rax
180004f12:     	movq	%rax, 0x40(%rsp)
180004f17:     	movq	0x1f8(%rsp), %rax
180004f1f:     	movq	%rax, 0x38(%rsp)
180004f24:     	movq	%r14, 0x30(%rsp)
180004f29:     	movq	0x1e8(%rsp), %rax
180004f31:     	movq	%rax, 0x28(%rsp)
180004f36:     	movq	0x1e0(%rsp), %rax
180004f3e:     	movq	%rax, 0x20(%rsp)
180004f43:     	movq	$-0x1, 0x108(%rsp)
180004f4f:     	movq	$0x0, 0xf0(%rsp)
180004f5b:     	leaq	0x126(%rsp), %rcx
180004f63:     	movq	0x128(%rsp), %r8
180004f6b:     	movq	0x138(%rsp), %r9
180004f73:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180004f78:     	cmpb	$0x0, (%r13)
180004f7d:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180004f83:     	movq	0x8(%r15), %rcx
180004f87:     	leaq	-0x1(%rcx), %rax
180004f8b:     	cmpb	$0x0, 0x126(%rsp)
180004f93:     	movq	%rax, 0x8(%r15)
180004f97:     	je	0x1800052d7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x17f7>
180004f9d:     	movq	0x118(%rsp), %rcx
180004fa5:     	jmp	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
180004faa:     	movq	%rdx, 0x158(%rsp)
180004fb2:     	movq	%r10, 0x160(%rsp)
180004fba:     	movabsq	$0x7ffffffffffffff8, %r8 # imm = 0x7FFFFFFFFFFFFFF8
180004fc4:     	andq	%rax, %r8
180004fc7:     	movq	%r8, 0x138(%rsp)
180004fcf:     	movq	0x128(%rsp), %rax
180004fd7:     	leaq	(%rbp,%rax,8), %rax
180004fdc:     	movq	%rax, 0x150(%rsp)
180004fe4:     	leaq	(,%rbx,8), %r8
180004fec:     	xorl	%r12d, %r12d
180004fef:     	movq	0x150(%rsp), %rdx
180004ff7:     	leaq	(%r15,%r12), %r9
180004ffb:     	sarq	$0x3f, %r9
180004fff:     	andq	%r8, %r9
180005002:     	leaq	(%rbp,%r15,8), %rax
180005007:     	movq	%rax, 0x118(%rsp)
18000500f:     	addq	%rax, %r9
180005012:     	movq	(%r9,%r12,8), %r9
180005016:     	movq	0x128(%rsp), %rax
18000501e:     	leaq	(%rax,%r12), %r10
180005022:     	sarq	$0x3f, %r10
180005026:     	andq	%r8, %r10
180005029:     	addq	%rdx, %r10
18000502c:     	movq	%r9, (%r10,%r12,8)
180005030:     	leaq	0x1(%r15,%r12), %r9
180005035:     	sarq	$0x3f, %r9
180005039:     	andq	%r8, %r9
18000503c:     	addq	0x118(%rsp), %r9
180005044:     	movq	0x8(%r9,%r12,8), %r9
180005049:     	leaq	0x1(%rax,%r12), %r10
18000504e:     	sarq	$0x3f, %r10
180005052:     	andq	%r8, %r10
180005055:     	addq	%rdx, %r10
180005058:     	movq	%r9, 0x8(%r10,%r12,8)
18000505d:     	leaq	0x2(%r15,%r12), %r9
180005062:     	sarq	$0x3f, %r9
180005066:     	andq	%r8, %r9
180005069:     	addq	0x118(%rsp), %r9
180005071:     	movq	0x10(%r9,%r12,8), %r9
180005076:     	leaq	0x2(%rax,%r12), %r10
18000507b:     	sarq	$0x3f, %r10
18000507f:     	andq	%r8, %r10
180005082:     	addq	%rdx, %r10
180005085:     	movq	%r9, 0x10(%r10,%r12,8)
18000508a:     	leaq	0x3(%r15,%r12), %r9
18000508f:     	sarq	$0x3f, %r9
180005093:     	andq	%r8, %r9
180005096:     	addq	0x118(%rsp), %r9
18000509e:     	movq	0x18(%r9,%r12,8), %r9
1800050a3:     	leaq	0x3(%rax,%r12), %r10
1800050a8:     	sarq	$0x3f, %r10
1800050ac:     	andq	%r8, %r10
1800050af:     	addq	%rdx, %r10
1800050b2:     	movq	%r9, 0x18(%r10,%r12,8)
1800050b7:     	leaq	0x4(%r15,%r12), %r9
1800050bc:     	sarq	$0x3f, %r9
1800050c0:     	andq	%r8, %r9
1800050c3:     	addq	0x118(%rsp), %r9
1800050cb:     	movq	0x20(%r9,%r12,8), %r9
1800050d0:     	leaq	0x4(%rax,%r12), %r10
1800050d5:     	sarq	$0x3f, %r10
1800050d9:     	andq	%r8, %r10
1800050dc:     	addq	%rdx, %r10
1800050df:     	movq	%r9, 0x20(%r10,%r12,8)
1800050e4:     	leaq	0x5(%r15,%r12), %r9
1800050e9:     	sarq	$0x3f, %r9
1800050ed:     	andq	%r8, %r9
1800050f0:     	addq	0x118(%rsp), %r9
1800050f8:     	movq	0x28(%r9,%r12,8), %r9
1800050fd:     	leaq	0x5(%rax,%r12), %r10
180005102:     	sarq	$0x3f, %r10
180005106:     	andq	%r8, %r10
180005109:     	addq	%rdx, %r10
18000510c:     	movq	%r9, 0x28(%r10,%r12,8)
180005111:     	leaq	0x6(%r15,%r12), %r9
180005116:     	sarq	$0x3f, %r9
18000511a:     	andq	%r8, %r9
18000511d:     	addq	0x118(%rsp), %r9
180005125:     	movq	0x30(%r9,%r12,8), %r9
18000512a:     	leaq	0x6(%rax,%r12), %r10
18000512f:     	sarq	$0x3f, %r10
180005133:     	andq	%r8, %r10
180005136:     	addq	%rdx, %r10
180005139:     	movq	%r9, 0x30(%r10,%r12,8)
18000513e:     	leaq	0x7(%r15,%r12), %r9
180005143:     	sarq	$0x3f, %r9
180005147:     	andq	%r8, %r9
18000514a:     	addq	0x118(%rsp), %r9
180005152:     	movq	0x38(%r9,%r12,8), %r9
180005157:     	leaq	0x7(%rax,%r12), %r10
18000515c:     	sarq	$0x3f, %r10
180005160:     	andq	%r8, %r10
180005163:     	addq	%rdx, %r10
180005166:     	movq	%r9, 0x38(%r10,%r12,8)
18000516b:     	addq	$0x8, %r12
18000516f:     	cmpq	%r12, 0x138(%rsp)
180005177:     	jne	0x180004ff7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1517>
18000517d:     	movq	0x160(%rsp), %r10
180005185:     	testq	%r10, %r10
180005188:     	movq	0x158(%rsp), %rdx
180005190:     	je	0x1800051dc <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x16fc>
180005192:     	movq	0x128(%rsp), %r9
18000519a:     	movq	0x138(%rsp), %rax
1800051a2:     	leaq	(%rax,%r9), %r12
1800051a6:     	addq	%rax, %r15
1800051a9:     	movq	%r15, %r9
1800051ac:     	sarq	$0x3f, %r9
1800051b0:     	andq	%r8, %r9
1800051b3:     	addq	%rbp, %r9
1800051b6:     	movq	(%r9,%r15,8), %r9
1800051ba:     	movq	%r10, %rax
1800051bd:     	movq	%r12, %r10
1800051c0:     	sarq	$0x3f, %r10
1800051c4:     	andq	%r8, %r10
1800051c7:     	addq	%rbp, %r10
1800051ca:     	movq	%r9, (%r10,%r12,8)
1800051ce:     	movq	%rax, %r10
1800051d1:     	incq	%r12
1800051d4:     	incq	%r15
1800051d7:     	decq	%r10
1800051da:     	jne	0x1800051a9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x16c9>
1800051dc:     	leaq	(%rbp,%rdx,8), %r10
1800051e1:     	movq	0x170(%rsp), %r8
1800051e9:     	movq	0x168(%rsp), %r9
1800051f1:     	movq	%r9, 0x8(%r10,%r8,8)
1800051f6:     	movq	0x128(%rsp), %r8
1800051fe:     	movq	0x148(%rsp), %r9
180005206:     	movq	%r8, 0x10(%r10,%r9,8)
18000520b:     	movq	0x140(%rsp), %rax
180005213:     	leaq	0x1(%rax), %r8
180005217:     	movq	%r8, (%r10,%r11,8)
18000521b:     	cmpb	$0x0, (%r13)
180005220:     	jne	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
180005226:     	xorl	%r8d, %r8d
180005229:     	cmpq	$-0x2, %rdx
18000522d:     	cmovlq	%rbx, %r8
180005231:     	addq	0x10(%r10,%r8,8), %rax
180005236:     	movq	%rax, %rdx
180005239:     	sarq	$0x3f, %rdx
18000523d:     	andq	%rbx, %rdx
180005240:     	leaq	(%rbp,%rax,8), %rax
180005245:     	movq	%rsi, (%rax,%rdx,8)
180005249:     	movsd	0x48(%r14,%rdi,8), %xmm2
180005250:     	movsd	0x8(%r14,%rsi,8), %xmm1
180005257:     	movapd	%xmm2, %xmm0
18000525b:     	addsd	%xmm1, %xmm0
18000525f:     	xorpd	%xmm3, %xmm3
180005263:     	ucomisd	%xmm3, %xmm0
180005267:     	jbe	0x1800052c2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x17e2>
180005269:     	movq	0x10(%rbp,%rdi,8), %rax
18000526e:     	movq	0x10(%rbp,%rsi,8), %rdx
180005273:     	mulsd	(%r14,%rax,8), %xmm2
180005279:     	mulsd	(%r14,%rdx,8), %xmm1
18000527f:     	addsd	%xmm2, %xmm1
180005283:     	divsd	%xmm0, %xmm1
180005287:     	movsd	%xmm1, (%r14,%rax,8)
18000528d:     	movq	0x10(%rbp,%rdi,8), %rax
180005292:     	movsd	0x8(%r14,%rax,8), %xmm1
180005299:     	movq	0x10(%rbp,%rsi,8), %rdx
18000529e:     	movsd	0x8(%r14,%rdx,8), %xmm2
1800052a5:     	mulsd	0x48(%r14,%rdi,8), %xmm1
1800052ac:     	mulsd	0x8(%r14,%rsi,8), %xmm2
1800052b3:     	addsd	%xmm1, %xmm2
1800052b7:     	divsd	%xmm0, %xmm2
1800052bb:     	movsd	%xmm2, 0x8(%r14,%rax,8)
1800052c2:     	movsd	%xmm0, 0x48(%r14,%rdi,8)
1800052c9:     	cmpb	$0x0, (%r13)
1800052ce:     	sete	%r12b
1800052d2:     	jmp	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
1800052d7:     	movq	0x38(%rbp,%rdi,8), %rax
1800052dc:     	testq	%rax, %rax
1800052df:     	js	0x1800052eb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x180b>
1800052e1:     	movq	%rcx, 0x8(%r15)
1800052e5:     	cmpq	0x10(%r15), %rcx
1800052e9:     	jle	0x1800052fd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x181d>
1800052eb:     	movb	$0x1, (%r13)
1800052f0:     	movq	$0x2dc6cf, 0x18(%r15)   # imm = 0x2DC6CF
1800052f8:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800052fd:     	movb	$0x0, 0x125(%rsp)
180005305:     	movq	%rsi, 0x100(%rsp)
18000530d:     	movq	%rax, 0xf8(%rsp)
180005315:     	movq	0x2a8(%rsp), %rax
18000531d:     	movq	%rax, 0xe8(%rsp)
180005325:     	movq	0x2a0(%rsp), %rax
18000532d:     	movq	%rax, 0xe0(%rsp)
180005335:     	movq	%r13, 0xd8(%rsp)
18000533d:     	movq	0x290(%rsp), %rax
180005345:     	movq	%rax, 0xd0(%rsp)
18000534d:     	movq	0x288(%rsp), %rax
180005355:     	movq	%rax, 0xc8(%rsp)
18000535d:     	movq	0x280(%rsp), %rax
180005365:     	movq	%rax, 0xc0(%rsp)
18000536d:     	movq	0x278(%rsp), %rax
180005375:     	movq	%rax, 0xb8(%rsp)
18000537d:     	movq	0x270(%rsp), %rax
180005385:     	movq	%rax, 0xb0(%rsp)
18000538d:     	movq	0x268(%rsp), %rax
180005395:     	movq	%rax, 0xa8(%rsp)
18000539d:     	movq	%r15, 0xa0(%rsp)
1800053a5:     	movq	0x258(%rsp), %rax
1800053ad:     	movq	%rax, 0x98(%rsp)
1800053b5:     	movq	0x250(%rsp), %rax
1800053bd:     	movq	%rax, 0x90(%rsp)
1800053c5:     	movq	0x248(%rsp), %rax
1800053cd:     	movq	%rax, 0x88(%rsp)
1800053d5:     	movq	0x240(%rsp), %rax
1800053dd:     	movq	%rax, 0x80(%rsp)
1800053e5:     	movq	0x238(%rsp), %rax
1800053ed:     	movq	%rax, 0x78(%rsp)
1800053f2:     	movq	%rbx, 0x70(%rsp)
1800053f7:     	movq	%rbp, 0x68(%rsp)
1800053fc:     	movq	0x220(%rsp), %rax
180005404:     	movq	%rax, 0x60(%rsp)
180005409:     	movq	0x218(%rsp), %rax
180005411:     	movq	%rax, 0x58(%rsp)
180005416:     	movq	0x210(%rsp), %rax
18000541e:     	movq	%rax, 0x50(%rsp)
180005423:     	movq	0x208(%rsp), %rax
18000542b:     	movq	%rax, 0x48(%rsp)
180005430:     	movq	0x200(%rsp), %rax
180005438:     	movq	%rax, 0x40(%rsp)
18000543d:     	movq	0x1f8(%rsp), %rax
180005445:     	movq	%rax, 0x38(%rsp)
18000544a:     	movq	%r14, 0x30(%rsp)
18000544f:     	movq	0x1e8(%rsp), %rax
180005457:     	movq	%rax, 0x28(%rsp)
18000545c:     	movq	0x1e0(%rsp), %rax
180005464:     	movq	%rax, 0x20(%rsp)
180005469:     	movq	$-0x1, 0x108(%rsp)
180005475:     	movq	$0x0, 0xf0(%rsp)
180005481:     	leaq	0x125(%rsp), %rcx
180005489:     	movq	0x128(%rsp), %r8
180005491:     	movq	0x138(%rsp), %r9
180005499:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
18000549e:     	cmpb	$0x0, (%r13)
1800054a3:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800054a9:     	movq	0x8(%r15), %rax
1800054ad:     	leaq	-0x1(%rax), %rcx
1800054b1:     	cmpb	$0x0, 0x125(%rsp)
1800054b9:     	movq	%rcx, 0x8(%r15)
1800054bd:     	movq	0x118(%rsp), %rcx
1800054c5:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
1800054cb:     	movq	0x40(%rbp,%rdi,8), %rcx
1800054d0:     	testq	%rcx, %rcx
1800054d3:     	js	0x1800054e3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1a03>
1800054d5:     	movq	%rax, 0x8(%r15)
1800054d9:     	cmpq	0x10(%r15), %rax
1800054dd:     	jle	0x1800061f6 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2716>
1800054e3:     	movb	$0x1, (%r13)
1800054e8:     	movq	$0x2dc6d0, 0x18(%r15)   # imm = 0x2DC6D0
1800054f0:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800054f5:     	movq	%rax, (%r15)
1800054f8:     	cmpb	$0x0, (%r13)
1800054fd:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005503:     	subsd	%xmm3, %xmm1
180005507:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
18000550e:     	movsd	%xmm5, 0x18(%r14,%rcx,8)
180005515:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
18000551c:     	movsd	%xmm0, (%r14,%rcx,8)
180005522:     	cmpb	$0x0, (%r13)
180005527:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000552d:     	movq	(%r15), %rax
180005530:     	leaq	0xa(%rax), %r8
180005534:     	cmpq	%rbx, %r8
180005537:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
18000553d:     	movq	0x2c8(%rsp), %rdx
180005545:     	movq	0x8(%rbp,%rdx,8), %rdx
18000554a:     	movq	%r8, (%r15)
18000554d:     	cmpb	$0x0, (%r13)
180005552:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005558:     	movq	%rcx, (%rbp,%rax,8)
18000555d:     	movq	%rdx, 0x8(%rbp,%rax,8)
180005562:     	movq	(%r15), %rdx
180005565:     	cmpq	%rbx, %rdx
180005568:     	movq	%rdx, %rcx
18000556b:     	jle	0x180005577 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1a97>
18000556d:     	movb	$0x2, (%r13)
180005572:     	movq	(%r15), %rdx
180005575:     	xorl	%ecx, %ecx
180005577:     	leaq	0x3(%rdx), %r8
18000557b:     	cmpq	%rbx, %r8
18000557e:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
180005584:     	movq	%r8, (%r15)
180005587:     	cmpb	$0x0, (%r13)
18000558c:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005592:     	movq	%rdx, %r8
180005595:     	sarq	$0x3f, %r8
180005599:     	andq	%rbx, %r8
18000559c:     	leaq	(%rbp,%rdx,8), %r9
1800055a1:     	movq	$0x0, (%r9,%r8,8)
1800055a9:     	xorl	%r12d, %r12d
1800055ac:     	cmpq	$-0x1, %rdx
1800055b0:     	movl	$0x0, %r8d
1800055b6:     	cmovlq	%rbx, %r8
1800055ba:     	movq	$0x0, 0x8(%r9,%r8,8)
1800055c3:     	cmpq	$-0x2, %rdx
1800055c7:     	movl	$0x0, %r8d
1800055cd:     	cmovlq	%rbx, %r8
1800055d1:     	movq	%rcx, 0x10(%r9,%r8,8)
1800055d6:     	cmpb	$0x0, (%r13)
1800055db:     	movq	0x118(%rsp), %rcx
1800055e3:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
1800055e9:     	leaq	(%rbp,%rax,8), %rcx
1800055ee:     	movq	%rdx, 0x30(%rcx)
1800055f2:     	movq	$0x0, 0x18(%rcx)
1800055fa:     	movq	(%r15), %rdx
1800055fd:     	leaq	0x2(%rdx), %r8
180005601:     	cmpq	%rbx, %r8
180005604:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
18000560a:     	movq	%r8, (%r15)
18000560d:     	cmpb	$0x0, (%r13)
180005612:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005618:     	movq	$0x0, 0x8(%r14,%rdx,8)
180005621:     	movq	$0x0, (%r14,%rdx,8)
180005629:     	cmpb	$0x0, (%r13)
18000562e:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005634:     	movq	%rdx, 0x10(%rcx)
180005638:     	movq	$0x0, 0x48(%r14,%rax,8)
180005641:     	movq	$-0x1, 0x28(%rcx)
180005649:     	movq	$-0x1, 0x20(%rcx)
180005651:     	movq	$-0x1, 0x38(%rcx)
180005659:     	movq	$-0x1, 0x40(%rcx)
180005661:     	cmpb	$0x0, (%r13)
180005666:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000566c:     	movq	0x2c8(%rsp), %rcx
180005674:     	movq	%rax, 0x28(%rbp,%rcx,8)
180005679:     	movq	(%r15), %rcx
18000567c:     	leaq	0x4(%rcx), %rax
180005680:     	cmpq	%rbx, %rax
180005683:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
180005689:     	movq	%rax, (%r15)
18000568c:     	cmpb	$0x0, (%r13)
180005691:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005697:     	addsd	%xmm0, %xmm2
18000569b:     	movsd	%xmm4, 0x10(%r14,%rcx,8)
1800056a2:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
1800056a9:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
1800056b0:     	movsd	%xmm0, (%r14,%rcx,8)
1800056b6:     	cmpb	$0x0, (%r13)
1800056bb:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800056c1:     	movq	(%r15), %rax
1800056c4:     	leaq	0xa(%rax), %r8
1800056c8:     	cmpq	%rbx, %r8
1800056cb:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
1800056d1:     	movq	0x2c8(%rsp), %rdx
1800056d9:     	movq	0x8(%rbp,%rdx,8), %rdx
1800056de:     	movq	%r8, (%r15)
1800056e1:     	cmpb	$0x0, (%r13)
1800056e6:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800056ec:     	movq	%rcx, (%rbp,%rax,8)
1800056f1:     	movq	%rdx, 0x8(%rbp,%rax,8)
1800056f6:     	movq	(%r15), %rdx
1800056f9:     	cmpq	%rbx, %rdx
1800056fc:     	movq	%rdx, %rcx
1800056ff:     	jle	0x18000570b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1c2b>
180005701:     	movb	$0x2, (%r13)
180005706:     	movq	(%r15), %rdx
180005709:     	xorl	%ecx, %ecx
18000570b:     	leaq	0x3(%rdx), %r8
18000570f:     	cmpq	%rbx, %r8
180005712:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
180005718:     	movq	%r8, (%r15)
18000571b:     	cmpb	$0x0, (%r13)
180005720:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005726:     	movq	%rdx, %r8
180005729:     	sarq	$0x3f, %r8
18000572d:     	andq	%rbx, %r8
180005730:     	leaq	(%rbp,%rdx,8), %r9
180005735:     	movq	$0x0, (%r9,%r8,8)
18000573d:     	xorl	%r12d, %r12d
180005740:     	cmpq	$-0x1, %rdx
180005744:     	movl	$0x0, %r8d
18000574a:     	cmovlq	%rbx, %r8
18000574e:     	movq	$0x0, 0x8(%r9,%r8,8)
180005757:     	cmpq	$-0x2, %rdx
18000575b:     	movl	$0x0, %r8d
180005761:     	cmovlq	%rbx, %r8
180005765:     	movq	%rcx, 0x10(%r9,%r8,8)
18000576a:     	cmpb	$0x0, (%r13)
18000576f:     	movq	0x118(%rsp), %rcx
180005777:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
18000577d:     	leaq	(%rbp,%rax,8), %rcx
180005782:     	movq	%rdx, 0x30(%rcx)
180005786:     	movq	$0x0, 0x18(%rcx)
18000578e:     	movq	(%r15), %rdx
180005791:     	leaq	0x2(%rdx), %r8
180005795:     	cmpq	%rbx, %r8
180005798:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
18000579e:     	movq	%r8, (%r15)
1800057a1:     	cmpb	$0x0, (%r13)
1800057a6:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800057ac:     	movq	$0x0, 0x8(%r14,%rdx,8)
1800057b5:     	movq	$0x0, (%r14,%rdx,8)
1800057bd:     	cmpb	$0x0, (%r13)
1800057c2:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800057c8:     	movq	%rdx, 0x10(%rcx)
1800057cc:     	movq	$0x0, 0x48(%r14,%rax,8)
1800057d5:     	movq	$-0x1, 0x28(%rcx)
1800057dd:     	movq	$-0x1, 0x20(%rcx)
1800057e5:     	movq	$-0x1, 0x38(%rcx)
1800057ed:     	movq	$-0x1, 0x40(%rcx)
1800057f5:     	cmpb	$0x0, (%r13)
1800057fa:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005800:     	movq	0x2c8(%rsp), %rcx
180005808:     	movq	%rax, 0x38(%rbp,%rcx,8)
18000580d:     	movq	(%r15), %rcx
180005810:     	leaq	0x4(%rcx), %rax
180005814:     	cmpq	%rbx, %rax
180005817:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
18000581d:     	movq	%rax, (%r15)
180005820:     	cmpb	$0x0, (%r13)
180005825:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000582b:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
180005832:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005839:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005840:     	movsd	%xmm0, (%r14,%rcx,8)
180005846:     	cmpb	$0x0, (%r13)
18000584b:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005851:     	movq	(%r15), %rax
180005854:     	leaq	0xa(%rax), %r8
180005858:     	cmpq	%rbx, %r8
18000585b:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
180005861:     	movq	0x2c8(%rsp), %rdx
180005869:     	movq	0x8(%rbp,%rdx,8), %rdx
18000586e:     	movq	%r8, (%r15)
180005871:     	cmpb	$0x0, (%r13)
180005876:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000587c:     	movq	%rcx, (%rbp,%rax,8)
180005881:     	movq	%rdx, 0x8(%rbp,%rax,8)
180005886:     	movq	(%r15), %rdx
180005889:     	cmpq	%rbx, %rdx
18000588c:     	movq	%rdx, %rcx
18000588f:     	jle	0x18000589b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1dbb>
180005891:     	movb	$0x2, (%r13)
180005896:     	movq	(%r15), %rdx
180005899:     	xorl	%ecx, %ecx
18000589b:     	leaq	0x3(%rdx), %r8
18000589f:     	cmpq	%rbx, %r8
1800058a2:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
1800058a8:     	movq	%r8, (%r15)
1800058ab:     	cmpb	$0x0, (%r13)
1800058b0:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800058b6:     	movq	%rdx, %r8
1800058b9:     	sarq	$0x3f, %r8
1800058bd:     	andq	%rbx, %r8
1800058c0:     	leaq	(%rbp,%rdx,8), %r9
1800058c5:     	movq	$0x0, (%r9,%r8,8)
1800058cd:     	xorl	%r12d, %r12d
1800058d0:     	cmpq	$-0x1, %rdx
1800058d4:     	movl	$0x0, %r8d
1800058da:     	cmovlq	%rbx, %r8
1800058de:     	movq	$0x0, 0x8(%r9,%r8,8)
1800058e7:     	cmpq	$-0x2, %rdx
1800058eb:     	movl	$0x0, %r8d
1800058f1:     	cmovlq	%rbx, %r8
1800058f5:     	movq	%rcx, 0x10(%r9,%r8,8)
1800058fa:     	cmpb	$0x0, (%r13)
1800058ff:     	movq	0x118(%rsp), %rcx
180005907:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
18000590d:     	leaq	(%rbp,%rax,8), %rcx
180005912:     	movq	%rdx, 0x30(%rcx)
180005916:     	movq	$0x0, 0x18(%rcx)
18000591e:     	movq	(%r15), %rdx
180005921:     	leaq	0x2(%rdx), %r8
180005925:     	cmpq	%rbx, %r8
180005928:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
18000592e:     	movq	%r8, (%r15)
180005931:     	cmpb	$0x0, (%r13)
180005936:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
18000593c:     	movq	$0x0, 0x8(%r14,%rdx,8)
180005945:     	movq	$0x0, (%r14,%rdx,8)
18000594d:     	cmpb	$0x0, (%r13)
180005952:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005958:     	movq	%rdx, 0x10(%rcx)
18000595c:     	movq	$0x0, 0x48(%r14,%rax,8)
180005965:     	movq	$-0x1, 0x28(%rcx)
18000596d:     	movq	$-0x1, 0x20(%rcx)
180005975:     	movq	$-0x1, 0x38(%rcx)
18000597d:     	movq	$-0x1, 0x40(%rcx)
180005985:     	cmpb	$0x0, (%r13)
18000598a:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005990:     	movq	0x2c8(%rsp), %rcx
180005998:     	movq	%rax, 0x40(%rbp,%rcx,8)
18000599d:     	movq	$0x1, 0x18(%rbp,%rcx,8)
1800059a6:     	movq	0x30(%rbp,%rcx,8), %rax
1800059ab:     	movq	%rax, %rcx
1800059ae:     	sarq	$0x3f, %rcx
1800059b2:     	andq	%rbx, %rcx
1800059b5:     	leaq	(%rbp,%rax,8), %rdx
1800059ba:     	movq	%rcx, 0x148(%rsp)
1800059c2:     	movq	%rdx, 0x150(%rsp)
1800059ca:     	cmpq	$0x0, (%rdx,%rcx,8)
1800059cf:     	jle	0x180006164 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2684>
1800059d5:     	leaq	(,%rbx,8), %rcx
1800059dd:     	xorl	%esi, %esi
1800059df:     	cmpq	$-0x2, %rax
1800059e3:     	cmovgeq	%rsi, %rcx
1800059e7:     	movq	%rcx, 0x140(%rsp)
1800059ef:     	movq	0x2c8(%rsp), %rax
1800059f7:     	movq	0x20(%rbp,%rax,8), %rax
1800059fc:     	testq	%rax, %rax
1800059ff:     	js	0x1800063b4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28d4>
180005a05:     	movq	0x150(%rsp), %rcx
180005a0d:     	movq	0x140(%rsp), %rdx
180005a15:     	movq	0x10(%rcx,%rdx), %rcx
180005a1a:     	addq	%rsi, %rcx
180005a1d:     	leaq	(%rbp,%rcx,8), %rdx
180005a22:     	sarq	$0x3f, %rcx
180005a26:     	andq	%rbx, %rcx
180005a29:     	movq	(%rdx,%rcx,8), %r12
180005a2d:     	movq	0x8(%r15), %rcx
180005a31:     	leaq	0x1(%rcx), %rdx
180005a35:     	movq	%rdx, 0x8(%r15)
180005a39:     	cmpq	0x10(%r15), %rcx
180005a3d:     	jge	0x1800063b4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28d4>
180005a43:     	movq	%r12, 0x100(%rsp)
180005a4b:     	movq	%rax, 0xf8(%rsp)
180005a53:     	movq	0x2a8(%rsp), %rax
180005a5b:     	movq	%rax, 0xe8(%rsp)
180005a63:     	movq	0x2a0(%rsp), %rax
180005a6b:     	movq	%rax, 0xe0(%rsp)
180005a73:     	movq	%r13, 0xd8(%rsp)
180005a7b:     	movq	0x290(%rsp), %rax
180005a83:     	movq	%rax, 0xd0(%rsp)
180005a8b:     	movq	0x288(%rsp), %rax
180005a93:     	movq	%rax, 0xc8(%rsp)
180005a9b:     	movq	0x280(%rsp), %rax
180005aa3:     	movq	%rax, 0xc0(%rsp)
180005aab:     	movq	0x278(%rsp), %rax
180005ab3:     	movq	%rax, 0xb8(%rsp)
180005abb:     	movq	0x270(%rsp), %rax
180005ac3:     	movq	%rax, 0xb0(%rsp)
180005acb:     	movq	0x268(%rsp), %rax
180005ad3:     	movq	%rax, 0xa8(%rsp)
180005adb:     	movq	%r15, 0xa0(%rsp)
180005ae3:     	movq	%rdi, 0x98(%rsp)
180005aeb:     	movq	0x250(%rsp), %rax
180005af3:     	movq	%rax, 0x90(%rsp)
180005afb:     	movq	0x248(%rsp), %rax
180005b03:     	movq	%rax, 0x88(%rsp)
180005b0b:     	movq	0x240(%rsp), %rax
180005b13:     	movq	%rax, 0x80(%rsp)
180005b1b:     	movq	0x238(%rsp), %rax
180005b23:     	movq	%rax, 0x78(%rsp)
180005b28:     	movq	%rbx, 0x70(%rsp)
180005b2d:     	movq	%rbp, 0x68(%rsp)
180005b32:     	movq	0x220(%rsp), %rax
180005b3a:     	movq	%rax, 0x60(%rsp)
180005b3f:     	movq	0x218(%rsp), %rax
180005b47:     	movq	%rax, 0x58(%rsp)
180005b4c:     	movq	0x210(%rsp), %rax
180005b54:     	movq	%rax, 0x50(%rsp)
180005b59:     	movq	0x208(%rsp), %rax
180005b61:     	movq	%rax, 0x48(%rsp)
180005b66:     	movq	0x200(%rsp), %rax
180005b6e:     	movq	%rax, 0x40(%rsp)
180005b73:     	movq	0x1f8(%rsp), %rax
180005b7b:     	movq	%rax, 0x38(%rsp)
180005b80:     	movq	%r14, 0x30(%rsp)
180005b85:     	movq	0x1e8(%rsp), %rax
180005b8d:     	movq	%rax, 0x28(%rsp)
180005b92:     	movq	0x1e0(%rsp), %rax
180005b9a:     	movq	%rax, 0x20(%rsp)
180005b9f:     	movq	$-0x1, 0x108(%rsp)
180005bab:     	movq	$0x0, 0xf0(%rsp)
180005bb7:     	leaq	0x136(%rsp), %rcx
180005bbf:     	movq	0x128(%rsp), %r8
180005bc7:     	movq	0x138(%rsp), %r9
180005bcf:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180005bd4:     	cmpb	$0x0, (%r13)
180005bd9:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005bdf:     	movq	0x8(%r15), %rcx
180005be3:     	leaq	-0x1(%rcx), %rax
180005be7:     	movq	%rax, 0x8(%r15)
180005beb:     	movq	0x2c8(%rsp), %rax
180005bf3:     	movq	0x28(%rbp,%rax,8), %rax
180005bf8:     	testq	%rax, %rax
180005bfb:     	js	0x1800063c6 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28e6>
180005c01:     	movq	%rcx, 0x8(%r15)
180005c05:     	cmpq	0x10(%r15), %rcx
180005c09:     	jg	0x1800063c6 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28e6>
180005c0f:     	movq	%r12, 0x100(%rsp)
180005c17:     	movq	%rax, 0xf8(%rsp)
180005c1f:     	movq	0x2a8(%rsp), %rax
180005c27:     	movq	%rax, 0xe8(%rsp)
180005c2f:     	movq	0x2a0(%rsp), %rax
180005c37:     	movq	%rax, 0xe0(%rsp)
180005c3f:     	movq	%r13, 0xd8(%rsp)
180005c47:     	movq	0x290(%rsp), %rax
180005c4f:     	movq	%rax, 0xd0(%rsp)
180005c57:     	movq	0x288(%rsp), %rax
180005c5f:     	movq	%rax, 0xc8(%rsp)
180005c67:     	movq	0x280(%rsp), %rax
180005c6f:     	movq	%rax, 0xc0(%rsp)
180005c77:     	movq	0x278(%rsp), %rax
180005c7f:     	movq	%rax, 0xb8(%rsp)
180005c87:     	movq	0x270(%rsp), %rax
180005c8f:     	movq	%rax, 0xb0(%rsp)
180005c97:     	movq	0x268(%rsp), %rax
180005c9f:     	movq	%rax, 0xa8(%rsp)
180005ca7:     	movq	%r15, 0xa0(%rsp)
180005caf:     	movq	%rdi, 0x98(%rsp)
180005cb7:     	movq	0x250(%rsp), %rax
180005cbf:     	movq	%rax, 0x90(%rsp)
180005cc7:     	movq	0x248(%rsp), %rax
180005ccf:     	movq	%rax, 0x88(%rsp)
180005cd7:     	movq	0x240(%rsp), %rax
180005cdf:     	movq	%rax, 0x80(%rsp)
180005ce7:     	movq	0x238(%rsp), %rax
180005cef:     	movq	%rax, 0x78(%rsp)
180005cf4:     	movq	%rbx, 0x70(%rsp)
180005cf9:     	movq	%rbp, 0x68(%rsp)
180005cfe:     	movq	0x220(%rsp), %rax
180005d06:     	movq	%rax, 0x60(%rsp)
180005d0b:     	movq	0x218(%rsp), %rax
180005d13:     	movq	%rax, 0x58(%rsp)
180005d18:     	movq	0x210(%rsp), %rax
180005d20:     	movq	%rax, 0x50(%rsp)
180005d25:     	movq	0x208(%rsp), %rax
180005d2d:     	movq	%rax, 0x48(%rsp)
180005d32:     	movq	0x200(%rsp), %rax
180005d3a:     	movq	%rax, 0x40(%rsp)
180005d3f:     	movq	0x1f8(%rsp), %rax
180005d47:     	movq	%rax, 0x38(%rsp)
180005d4c:     	movq	%r14, 0x30(%rsp)
180005d51:     	movq	0x1e8(%rsp), %rax
180005d59:     	movq	%rax, 0x28(%rsp)
180005d5e:     	movq	0x1e0(%rsp), %rax
180005d66:     	movq	%rax, 0x20(%rsp)
180005d6b:     	movq	$-0x1, 0x108(%rsp)
180005d77:     	movq	$0x0, 0xf0(%rsp)
180005d83:     	leaq	0x135(%rsp), %rcx
180005d8b:     	movq	0x128(%rsp), %r8
180005d93:     	movq	0x138(%rsp), %r9
180005d9b:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180005da0:     	cmpb	$0x0, (%r13)
180005da5:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005dab:     	movq	0x8(%r15), %rcx
180005daf:     	leaq	-0x1(%rcx), %rax
180005db3:     	movq	%rax, 0x8(%r15)
180005db7:     	movq	0x2c8(%rsp), %rax
180005dbf:     	movq	0x38(%rbp,%rax,8), %rax
180005dc4:     	testq	%rax, %rax
180005dc7:     	js	0x1800063d8 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28f8>
180005dcd:     	movq	%rcx, 0x8(%r15)
180005dd1:     	cmpq	0x10(%r15), %rcx
180005dd5:     	jg	0x1800063d8 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x28f8>
180005ddb:     	movq	%r12, 0x100(%rsp)
180005de3:     	movq	%rax, 0xf8(%rsp)
180005deb:     	movq	0x2a8(%rsp), %rax
180005df3:     	movq	%rax, 0xe8(%rsp)
180005dfb:     	movq	0x2a0(%rsp), %rax
180005e03:     	movq	%rax, 0xe0(%rsp)
180005e0b:     	movq	%r13, 0xd8(%rsp)
180005e13:     	movq	0x290(%rsp), %rax
180005e1b:     	movq	%rax, 0xd0(%rsp)
180005e23:     	movq	0x288(%rsp), %rax
180005e2b:     	movq	%rax, 0xc8(%rsp)
180005e33:     	movq	0x280(%rsp), %rax
180005e3b:     	movq	%rax, 0xc0(%rsp)
180005e43:     	movq	0x278(%rsp), %rax
180005e4b:     	movq	%rax, 0xb8(%rsp)
180005e53:     	movq	0x270(%rsp), %rax
180005e5b:     	movq	%rax, 0xb0(%rsp)
180005e63:     	movq	0x268(%rsp), %rax
180005e6b:     	movq	%rax, 0xa8(%rsp)
180005e73:     	movq	%r15, 0xa0(%rsp)
180005e7b:     	movq	%rdi, 0x98(%rsp)
180005e83:     	movq	0x250(%rsp), %rax
180005e8b:     	movq	%rax, 0x90(%rsp)
180005e93:     	movq	0x248(%rsp), %rax
180005e9b:     	movq	%rax, 0x88(%rsp)
180005ea3:     	movq	0x240(%rsp), %rax
180005eab:     	movq	%rax, 0x80(%rsp)
180005eb3:     	movq	0x238(%rsp), %rax
180005ebb:     	movq	%rax, 0x78(%rsp)
180005ec0:     	movq	%rbx, 0x70(%rsp)
180005ec5:     	movq	%rbp, 0x68(%rsp)
180005eca:     	movq	0x220(%rsp), %rax
180005ed2:     	movq	%rax, 0x60(%rsp)
180005ed7:     	movq	0x218(%rsp), %rax
180005edf:     	movq	%rax, 0x58(%rsp)
180005ee4:     	movq	0x210(%rsp), %rax
180005eec:     	movq	%rax, 0x50(%rsp)
180005ef1:     	movq	0x208(%rsp), %rax
180005ef9:     	movq	%rax, 0x48(%rsp)
180005efe:     	movq	0x200(%rsp), %rax
180005f06:     	movq	%rax, 0x40(%rsp)
180005f0b:     	movq	0x1f8(%rsp), %rax
180005f13:     	movq	%rax, 0x38(%rsp)
180005f18:     	movq	%r14, 0x30(%rsp)
180005f1d:     	movq	0x1e8(%rsp), %rax
180005f25:     	movq	%rax, 0x28(%rsp)
180005f2a:     	movq	0x1e0(%rsp), %rax
180005f32:     	movq	%rax, 0x20(%rsp)
180005f37:     	movq	$-0x1, 0x108(%rsp)
180005f43:     	movq	$0x0, 0xf0(%rsp)
180005f4f:     	leaq	0x134(%rsp), %rcx
180005f57:     	movq	0x128(%rsp), %r8
180005f5f:     	movq	0x138(%rsp), %r9
180005f67:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180005f6c:     	cmpb	$0x0, (%r13)
180005f71:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180005f77:     	movq	0x8(%r15), %rcx
180005f7b:     	leaq	-0x1(%rcx), %rax
180005f7f:     	movq	%rax, 0x8(%r15)
180005f83:     	movq	0x2c8(%rsp), %rax
180005f8b:     	movq	0x40(%rbp,%rax,8), %rax
180005f90:     	testq	%rax, %rax
180005f93:     	js	0x1800063ea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x290a>
180005f99:     	movq	%rcx, 0x8(%r15)
180005f9d:     	cmpq	0x10(%r15), %rcx
180005fa1:     	jg	0x1800063ea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x290a>
180005fa7:     	movq	%r12, 0x100(%rsp)
180005faf:     	movq	%rax, 0xf8(%rsp)
180005fb7:     	movq	0x2a8(%rsp), %rax
180005fbf:     	movq	%rax, 0xe8(%rsp)
180005fc7:     	movq	0x2a0(%rsp), %rax
180005fcf:     	movq	%rax, 0xe0(%rsp)
180005fd7:     	movq	%r13, 0xd8(%rsp)
180005fdf:     	movq	0x290(%rsp), %rax
180005fe7:     	movq	%rax, 0xd0(%rsp)
180005fef:     	movq	0x288(%rsp), %rax
180005ff7:     	movq	%rax, 0xc8(%rsp)
180005fff:     	movq	0x280(%rsp), %rax
180006007:     	movq	%rax, 0xc0(%rsp)
18000600f:     	movq	0x278(%rsp), %rax
180006017:     	movq	%rax, 0xb8(%rsp)
18000601f:     	movq	0x270(%rsp), %rax
180006027:     	movq	%rax, 0xb0(%rsp)
18000602f:     	movq	0x268(%rsp), %rax
180006037:     	movq	%rax, 0xa8(%rsp)
18000603f:     	movq	%r15, 0xa0(%rsp)
180006047:     	movq	%rdi, 0x98(%rsp)
18000604f:     	movq	0x250(%rsp), %rax
180006057:     	movq	%rax, 0x90(%rsp)
18000605f:     	movq	0x248(%rsp), %rax
180006067:     	movq	%rax, 0x88(%rsp)
18000606f:     	movq	0x240(%rsp), %rax
180006077:     	movq	%rax, 0x80(%rsp)
18000607f:     	movq	0x238(%rsp), %rax
180006087:     	movq	%rax, 0x78(%rsp)
18000608c:     	movq	%rbx, 0x70(%rsp)
180006091:     	movq	%rbp, 0x68(%rsp)
180006096:     	movq	0x220(%rsp), %rax
18000609e:     	movq	%rax, 0x60(%rsp)
1800060a3:     	movq	0x218(%rsp), %rax
1800060ab:     	movq	%rax, 0x58(%rsp)
1800060b0:     	movq	0x210(%rsp), %rax
1800060b8:     	movq	%rax, 0x50(%rsp)
1800060bd:     	movq	0x208(%rsp), %rax
1800060c5:     	movq	%rax, 0x48(%rsp)
1800060ca:     	movq	0x200(%rsp), %rax
1800060d2:     	movq	%rax, 0x40(%rsp)
1800060d7:     	movq	0x1f8(%rsp), %rax
1800060df:     	movq	%rax, 0x38(%rsp)
1800060e4:     	movq	%r14, 0x30(%rsp)
1800060e9:     	movq	0x1e8(%rsp), %rax
1800060f1:     	movq	%rax, 0x28(%rsp)
1800060f6:     	movq	0x1e0(%rsp), %rax
1800060fe:     	movq	%rax, 0x20(%rsp)
180006103:     	movq	$-0x1, 0x108(%rsp)
18000610f:     	movq	$0x0, 0xf0(%rsp)
18000611b:     	leaq	0x133(%rsp), %rcx
180006123:     	movq	0x128(%rsp), %r8
18000612b:     	movq	0x138(%rsp), %r9
180006133:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180006138:     	cmpb	$0x0, (%r13)
18000613d:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180006143:     	incq	%rsi
180006146:     	decq	0x8(%r15)
18000614a:     	movq	0x148(%rsp), %rax
180006152:     	movq	0x150(%rsp), %rcx
18000615a:     	cmpq	(%rcx,%rax,8), %rsi
18000615e:     	jl	0x1800059ef <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1f0f>
180006164:     	movq	(%r15), %rax
180006167:     	cmpq	%rbx, %rax
18000616a:     	movq	%rax, %rcx
18000616d:     	jle	0x180006179 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2699>
18000616f:     	movb	$0x2, (%r13)
180006174:     	movq	(%r15), %rax
180006177:     	xorl	%ecx, %ecx
180006179:     	leaq	0x3(%rax), %rdx
18000617d:     	cmpq	%rbx, %rdx
180006180:     	jg	0x180004972 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xe92>
180006186:     	movq	%rdx, (%r15)
180006189:     	cmpb	$0x0, (%r13)
18000618e:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
180006194:     	movq	%rax, %rdx
180006197:     	sarq	$0x3f, %rdx
18000619b:     	andq	%rbx, %rdx
18000619e:     	leaq	(%rbp,%rax,8), %r8
1800061a3:     	movq	$0x0, (%r8,%rdx,8)
1800061ab:     	xorl	%r12d, %r12d
1800061ae:     	cmpq	$-0x1, %rax
1800061b2:     	movl	$0x0, %edx
1800061b7:     	cmovlq	%rbx, %rdx
1800061bb:     	movq	$0x0, 0x8(%r8,%rdx,8)
1800061c4:     	cmpq	$-0x2, %rax
1800061c8:     	cmovgeq	%r12, %rbx
1800061cc:     	movq	%rcx, 0x10(%r8,%rbx,8)
1800061d1:     	cmpb	$0x0, (%r13)
1800061d6:     	movq	0x118(%rsp), %rcx
1800061de:     	jne	0x180004dba <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12da>
1800061e4:     	movq	0x2c8(%rsp), %rdx
1800061ec:     	movq	%rax, 0x30(%rbp,%rdx,8)
1800061f1:     	jmp	0x180004db7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x12d7>
1800061f6:     	movb	$0x0, 0x124(%rsp)
1800061fe:     	movq	%rsi, 0x100(%rsp)
180006206:     	movq	%rcx, 0xf8(%rsp)
18000620e:     	movq	0x2a8(%rsp), %rax
180006216:     	movq	%rax, 0xe8(%rsp)
18000621e:     	movq	0x2a0(%rsp), %rax
180006226:     	movq	%rax, 0xe0(%rsp)
18000622e:     	movq	0x290(%rsp), %rax
180006236:     	movq	%rax, 0xd0(%rsp)
18000623e:     	movq	0x288(%rsp), %rax
180006246:     	movq	%rax, 0xc8(%rsp)
18000624e:     	movq	0x280(%rsp), %rax
180006256:     	movq	%rax, 0xc0(%rsp)
18000625e:     	movq	0x278(%rsp), %rax
180006266:     	movq	%rax, 0xb8(%rsp)
18000626e:     	movq	0x270(%rsp), %rax
180006276:     	movq	%rax, 0xb0(%rsp)
18000627e:     	movq	0x268(%rsp), %rax
180006286:     	movq	%rax, 0xa8(%rsp)
18000628e:     	movq	0x258(%rsp), %rax
180006296:     	movq	%rax, 0x98(%rsp)
18000629e:     	movq	0x250(%rsp), %rax
1800062a6:     	movq	%rax, 0x90(%rsp)
1800062ae:     	movq	0x248(%rsp), %rax
1800062b6:     	movq	%rax, 0x88(%rsp)
1800062be:     	movq	0x240(%rsp), %rax
1800062c6:     	movq	%rax, 0x80(%rsp)
1800062ce:     	movq	0x238(%rsp), %rax
1800062d6:     	movq	%rax, 0x78(%rsp)
1800062db:     	movq	%rbx, 0x70(%rsp)
1800062e0:     	movq	%rbp, 0x68(%rsp)
1800062e5:     	movq	0x220(%rsp), %rax
1800062ed:     	movq	%rax, 0x60(%rsp)
1800062f2:     	movq	0x218(%rsp), %rax
1800062fa:     	movq	%rax, 0x58(%rsp)
1800062ff:     	movq	0x210(%rsp), %rax
180006307:     	movq	%rax, 0x50(%rsp)
18000630c:     	movq	0x208(%rsp), %rax
180006314:     	movq	%rax, 0x48(%rsp)
180006319:     	movq	0x200(%rsp), %rax
180006321:     	movq	%rax, 0x40(%rsp)
180006326:     	movq	0x1f8(%rsp), %rax
18000632e:     	movq	%rax, 0x38(%rsp)
180006333:     	movq	%r14, 0x30(%rsp)
180006338:     	movq	0x1e8(%rsp), %rax
180006340:     	movq	%rax, 0x28(%rsp)
180006345:     	movq	%r13, 0xd8(%rsp)
18000634d:     	movq	%r15, 0xa0(%rsp)
180006355:     	movq	0x1e0(%rsp), %rax
18000635d:     	movq	%rax, 0x20(%rsp)
180006362:     	movq	$-0x1, 0x108(%rsp)
18000636e:     	movq	$0x0, 0xf0(%rsp)
18000637a:     	leaq	0x124(%rsp), %rcx
180006382:     	movq	0x128(%rsp), %r8
18000638a:     	movq	0x138(%rsp), %r9
180006392:     	callq	0x180004550 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0xa70>
180006397:     	cmpb	$0x0, (%r13)
18000639c:     	jne	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800063a2:     	movzbl	0x124(%rsp), %r12d
1800063ab:     	decq	0x8(%r15)
1800063af:     	jmp	0x180004f9d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x14bd>
1800063b4:     	movb	$0x1, (%r13)
1800063b9:     	movq	$0x989697, 0x18(%r15)   # imm = 0x989697
1800063c1:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800063c6:     	movb	$0x1, (%r13)
1800063cb:     	movq	$0x989698, 0x18(%r15)   # imm = 0x989698
1800063d3:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800063d8:     	movb	$0x1, (%r13)
1800063dd:     	movq	$0x989699, 0x18(%r15)   # imm = 0x989699
1800063e5:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800063ea:     	movb	$0x1, (%r13)
1800063ef:     	movq	$0x98969a, 0x18(%r15)   # imm = 0x98969A
1800063f7:     	jmp	0x180004d69 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x1289>
1800063fc:     	nopl	(%rax)
180006400:     	pushq	%r15
180006402:     	pushq	%r14
180006404:     	pushq	%r13
180006406:     	pushq	%r12
180006408:     	pushq	%rsi
180006409:     	pushq	%rdi
18000640a:     	pushq	%rbp
18000640b:     	pushq	%rbx
18000640c:     	subq	$0x198, %rsp            # imm = 0x198
180006413:     	movapd	%xmm8, 0x180(%rsp)
18000641d:     	movapd	%xmm7, 0x170(%rsp)
180006426:     	movapd	%xmm6, 0x160(%rsp)
18000642f:     	movq	0x2d0(%rsp), %r13
180006437:     	movq	0x210(%rsp), %rdi
18000643f:     	movsd	0x48(%rdi,%r13,8), %xmm0
180006446:     	xorpd	%xmm1, %xmm1
18000644a:     	ucomisd	%xmm1, %xmm0
18000644e:     	jne	0x180006456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2976>
180006450:     	jnp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006456:     	movq	0x2d8(%rsp), %r12
18000645e:     	movq	0x250(%rsp), %r15
180006466:     	movq	0x248(%rsp), %r14
18000646e:     	movq	0x30(%r14,%r13,8), %rax
180006473:     	movq	%rax, %r10
180006476:     	sarq	$0x3f, %r10
18000647a:     	andq	%r15, %r10
18000647d:     	leaq	(%r14,%rax,8), %rdx
180006481:     	cmpq	$0x1, (%rdx,%r10,8)
180006486:     	jne	0x1800064ad <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x29cd>
180006488:     	xorl	%r10d, %r10d
18000648b:     	cmpq	$-0x2, %rax
18000648f:     	cmovlq	%r15, %r10
180006493:     	movq	0x10(%rdx,%r10,8), %rax
180006498:     	leaq	(%r14,%rax,8), %rdx
18000649c:     	sarq	$0x3f, %rax
1800064a0:     	andq	%r15, %rax
1800064a3:     	cmpq	%r12, (%rdx,%rax,8)
1800064a7:     	je	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
1800064ad:     	movq	0x2b8(%rsp), %rbx
1800064b5:     	movq	0x280(%rsp), %rsi
1800064bd:     	movq	0x10(%r14,%r13,8), %rax
1800064c2:     	testq	%rax, %rax
1800064c5:     	js	0x180006535 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a55>
1800064c7:     	testq	%r12, %r12
1800064ca:     	js	0x180006535 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a55>
1800064cc:     	movq	0x10(%r14,%r12,8), %rdx
1800064d1:     	testq	%rdx, %rdx
1800064d4:     	js	0x180006535 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a55>
1800064d6:     	movsd	(%rdi,%rax,8), %xmm1
1800064db:     	subsd	(%rdi,%rdx,8), %xmm1
1800064e0:     	movsd	0x8(%rdi,%rax,8), %xmm2
1800064e6:     	subsd	0x8(%rdi,%rdx,8), %xmm2
1800064ec:     	movapd	%xmm1, %xmm3
1800064f0:     	mulsd	%xmm1, %xmm3
1800064f4:     	movapd	%xmm2, %xmm4
1800064f8:     	mulsd	%xmm2, %xmm4
1800064fc:     	addsd	%xmm3, %xmm4
180006500:     	xorps	%xmm3, %xmm3
180006503:     	sqrtsd	%xmm4, %xmm3
180006507:     	cmpq	$0x0, 0x18(%r14,%r13,8)
18000650d:     	je	0x18000659b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2abb>
180006513:     	movq	(%r14,%r13,8), %rax
180006517:     	testq	%rax, %rax
18000651a:     	js	0x180006528 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a48>
18000651c:     	xorpd	%xmm5, %xmm5
180006520:     	ucomisd	%xmm5, %xmm4
180006524:     	jne	0x18000657e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a9e>
180006526:     	jp	0x18000657e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a9e>
180006528:     	movb	$0x1, (%rbx)
18000652b:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180006533:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006535:     	movb	$0x1, (%rbx)
180006538:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180006540:     	movq	$0x0, 0x8(%rcx)
180006548:     	movq	$0x0, (%rcx)
18000654f:     	xorl	%eax, %eax
180006551:     	movaps	0x160(%rsp), %xmm6
180006559:     	movaps	0x170(%rsp), %xmm7
180006561:     	movaps	0x180(%rsp), %xmm8
18000656a:     	addq	$0x198, %rsp            # imm = 0x198
180006571:     	popq	%rbx
180006572:     	popq	%rbp
180006573:     	popq	%rdi
180006574:     	popq	%rsi
180006575:     	popq	%r12
180006577:     	popq	%r13
180006579:     	popq	%r14
18000657b:     	popq	%r15
18000657d:     	retq
18000657e:     	movsd	0x2e0(%rsp), %xmm6
180006587:     	movsd	0x8(%rdi,%rax,8), %xmm4
18000658d:     	addsd	%xmm4, %xmm4
180006591:     	divsd	%xmm3, %xmm4
180006595:     	ucomisd	%xmm4, %xmm6
180006599:     	jbe	0x180006600 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2b20>
18000659b:     	movsd	0x5e15(%rip), %xmm4     # 0x18000c3b8
1800065a3:     	maxsd	%xmm3, %xmm4
1800065a7:     	movapd	%xmm4, %xmm3
1800065ab:     	mulsd	%xmm4, %xmm3
1800065af:     	xorpd	%xmm5, %xmm5
1800065b3:     	ucomisd	%xmm5, %xmm3
1800065b7:     	jne	0x1800065cb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2aeb>
1800065b9:     	jp	0x1800065cb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2aeb>
1800065bb:     	movb	$0x1, (%rbx)
1800065be:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
1800065c6:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
1800065cb:     	movsd	0x8(%rdi,%r12,8), %xmm5
1800065d2:     	mulsd	0x5de6(%rip), %xmm5     # 0x18000c3c0
1800065da:     	mulsd	%xmm5, %xmm0
1800065de:     	divsd	%xmm3, %xmm0
1800065e2:     	mulsd	%xmm0, %xmm1
1800065e6:     	divsd	%xmm4, %xmm1
1800065ea:     	mulsd	%xmm0, %xmm2
1800065ee:     	divsd	%xmm4, %xmm2
1800065f2:     	movsd	%xmm1, (%rcx)
1800065f6:     	movsd	%xmm2, 0x8(%rcx)
1800065fb:     	jmp	0x18000654f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a6f>
180006600:     	movq	0x2b0(%rsp), %rbp
180006608:     	movq	0x2a8(%rsp), %r10
180006610:     	movq	0x2a0(%rsp), %r11
180006618:     	movq	0x298(%rsp), %rdx
180006620:     	movq	0x20(%r14,%r13,8), %rax
180006625:     	testq	%rax, %rax
180006628:     	js	0x180006823 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2d43>
18000662e:     	movq	%r10, %rbp
180006631:     	movq	0x8(%rsi), %rdx
180006635:     	leaq	0x1(%rdx), %r10
180006639:     	movq	%r10, 0x8(%rsi)
18000663d:     	cmpq	0x10(%rsi), %rdx
180006641:     	jge	0x180006bea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x310a>
180006647:     	movq	%rcx, 0x108(%rsp)
18000664f:     	movsd	%xmm6, 0x100(%rsp)
180006658:     	movq	%r12, 0xf8(%rsp)
180006660:     	movq	%rax, 0xf0(%rsp)
180006668:     	movq	0x2c8(%rsp), %rax
180006670:     	movq	%rax, 0xe8(%rsp)
180006678:     	movq	0x2c0(%rsp), %rax
180006680:     	movq	%rax, 0xe0(%rsp)
180006688:     	movq	%rbx, 0xd8(%rsp)
180006690:     	movq	0x2b0(%rsp), %rax
180006698:     	movq	%rax, 0xd0(%rsp)
1800066a0:     	movq	%rbp, 0xc8(%rsp)
1800066a8:     	movq	%r11, 0xc0(%rsp)
1800066b0:     	movq	0x298(%rsp), %rax
1800066b8:     	movq	%rax, 0xb8(%rsp)
1800066c0:     	movq	0x290(%rsp), %rax
1800066c8:     	movq	%rax, 0xb0(%rsp)
1800066d0:     	movq	0x288(%rsp), %rax
1800066d8:     	movq	%rax, 0xa8(%rsp)
1800066e0:     	movq	%rsi, 0xa0(%rsp)
1800066e8:     	movq	0x278(%rsp), %rax
1800066f0:     	movq	%rax, 0x98(%rsp)
1800066f8:     	movq	0x270(%rsp), %rax
180006700:     	movq	%rax, 0x90(%rsp)
180006708:     	movq	0x268(%rsp), %rax
180006710:     	movq	%rax, 0x88(%rsp)
180006718:     	movq	0x260(%rsp), %rax
180006720:     	movq	%rax, 0x80(%rsp)
180006728:     	movq	0x258(%rsp), %rax
180006730:     	movq	%rax, 0x78(%rsp)
180006735:     	movq	%r15, 0x70(%rsp)
18000673a:     	movq	%r14, 0x68(%rsp)
18000673f:     	movq	0x240(%rsp), %rax
180006747:     	movq	%rax, 0x60(%rsp)
18000674c:     	movq	0x238(%rsp), %rax
180006754:     	movq	%rax, 0x58(%rsp)
180006759:     	movq	0x230(%rsp), %rax
180006761:     	movq	%rax, 0x50(%rsp)
180006766:     	movq	0x228(%rsp), %rax
18000676e:     	movq	%rax, 0x48(%rsp)
180006773:     	movq	0x220(%rsp), %rax
18000677b:     	movq	%rax, 0x40(%rsp)
180006780:     	movq	0x218(%rsp), %rax
180006788:     	movq	%rax, 0x38(%rsp)
18000678d:     	movq	%rdi, 0x30(%rsp)
180006792:     	movq	0x208(%rsp), %rax
18000679a:     	movq	%rax, 0x28(%rsp)
18000679f:     	movq	0x200(%rsp), %rax
1800067a7:     	movq	%rax, 0x20(%rsp)
1800067ac:     	leaq	0x150(%rsp), %rcx
1800067b4:     	movq	%r8, 0x110(%rsp)
1800067bc:     	movq	%r9, %rbp
1800067bf:     	callq	0x180006400 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2920>
1800067c4:     	cmpb	$0x0, (%rbx)
1800067c7:     	jne	0x180006bce <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x30ee>
1800067cd:     	xorpd	%xmm8, %xmm8
1800067d2:     	movsd	0x150(%rsp), %xmm7
1800067db:     	addsd	%xmm8, %xmm7
1800067e0:     	addsd	0x158(%rsp), %xmm8
1800067ea:     	decq	0x8(%rsi)
1800067ee:     	movq	0x108(%rsp), %rcx
1800067f6:     	movq	%rbp, %r9
1800067f9:     	movq	0x110(%rsp), %r8
180006801:     	movq	0x298(%rsp), %rdx
180006809:     	movq	0x2a0(%rsp), %r11
180006811:     	movq	0x2a8(%rsp), %r10
180006819:     	movq	0x2b0(%rsp), %rbp
180006821:     	jmp	0x18000682c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2d4c>
180006823:     	xorpd	%xmm7, %xmm7
180006827:     	xorpd	%xmm8, %xmm8
18000682c:     	movq	0x28(%r14,%r13,8), %rax
180006831:     	testq	%rax, %rax
180006834:     	js	0x180006a28 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2f48>
18000683a:     	movq	%r10, %rbp
18000683d:     	movq	0x8(%rsi), %rdx
180006841:     	leaq	0x1(%rdx), %r10
180006845:     	movq	%r10, 0x8(%rsi)
180006849:     	cmpq	0x10(%rsi), %rdx
18000684d:     	jge	0x180006bfa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x311a>
180006853:     	movq	%rcx, 0x108(%rsp)
18000685b:     	movsd	%xmm6, 0x100(%rsp)
180006864:     	movq	%r12, 0xf8(%rsp)
18000686c:     	movq	%rax, 0xf0(%rsp)
180006874:     	movq	0x2c8(%rsp), %rax
18000687c:     	movq	%rax, 0xe8(%rsp)
180006884:     	movq	0x2c0(%rsp), %rax
18000688c:     	movq	%rax, 0xe0(%rsp)
180006894:     	movq	%rbx, 0xd8(%rsp)
18000689c:     	movq	0x2b0(%rsp), %rax
1800068a4:     	movq	%rax, 0xd0(%rsp)
1800068ac:     	movq	%rbp, 0xc8(%rsp)
1800068b4:     	movq	%r11, 0xc0(%rsp)
1800068bc:     	movq	0x298(%rsp), %rax
1800068c4:     	movq	%rax, 0xb8(%rsp)
1800068cc:     	movq	0x290(%rsp), %rax
1800068d4:     	movq	%rax, 0xb0(%rsp)
1800068dc:     	movq	0x288(%rsp), %rax
1800068e4:     	movq	%rax, 0xa8(%rsp)
1800068ec:     	movq	%rsi, 0xa0(%rsp)
1800068f4:     	movq	0x278(%rsp), %rax
1800068fc:     	movq	%rax, 0x98(%rsp)
180006904:     	movq	0x270(%rsp), %rax
18000690c:     	movq	%rax, 0x90(%rsp)
180006914:     	movq	0x268(%rsp), %rax
18000691c:     	movq	%rax, 0x88(%rsp)
180006924:     	movq	0x260(%rsp), %rax
18000692c:     	movq	%rax, 0x80(%rsp)
180006934:     	movq	0x258(%rsp), %rax
18000693c:     	movq	%rax, 0x78(%rsp)
180006941:     	movq	%r15, 0x70(%rsp)
180006946:     	movq	%r14, 0x68(%rsp)
18000694b:     	movq	0x240(%rsp), %rax
180006953:     	movq	%rax, 0x60(%rsp)
180006958:     	movq	0x238(%rsp), %rax
180006960:     	movq	%rax, 0x58(%rsp)
180006965:     	movq	0x230(%rsp), %rax
18000696d:     	movq	%rax, 0x50(%rsp)
180006972:     	movq	0x228(%rsp), %rax
18000697a:     	movq	%rax, 0x48(%rsp)
18000697f:     	movq	0x220(%rsp), %rax
180006987:     	movq	%rax, 0x40(%rsp)
18000698c:     	movq	0x218(%rsp), %rax
180006994:     	movq	%rax, 0x38(%rsp)
180006999:     	movq	%rdi, 0x30(%rsp)
18000699e:     	movq	0x208(%rsp), %rax
1800069a6:     	movq	%rax, 0x28(%rsp)
1800069ab:     	movq	0x200(%rsp), %rax
1800069b3:     	movq	%rax, 0x20(%rsp)
1800069b8:     	leaq	0x140(%rsp), %rcx
1800069c0:     	movq	%r8, 0x110(%rsp)
1800069c8:     	movq	%r9, 0x118(%rsp)
1800069d0:     	callq	0x180006400 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2920>
1800069d5:     	cmpb	$0x0, (%rbx)
1800069d8:     	jne	0x180006bce <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x30ee>
1800069de:     	addsd	0x140(%rsp), %xmm7
1800069e7:     	addsd	0x148(%rsp), %xmm8
1800069f1:     	decq	0x8(%rsi)
1800069f5:     	movq	0x108(%rsp), %rcx
1800069fd:     	movq	0x118(%rsp), %r9
180006a05:     	movq	0x110(%rsp), %r8
180006a0d:     	movq	0x298(%rsp), %rdx
180006a15:     	movq	0x2a0(%rsp), %r11
180006a1d:     	movq	%rbp, %r10
180006a20:     	movq	0x2b0(%rsp), %rbp
180006a28:     	movq	0x38(%r14,%r13,8), %rax
180006a2d:     	testq	%rax, %rax
180006a30:     	js	0x180006c5c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x317c>
180006a36:     	movq	0x8(%rsi), %rdx
180006a3a:     	leaq	0x1(%rdx), %r10
180006a3e:     	movq	%r10, 0x8(%rsi)
180006a42:     	cmpq	0x10(%rsi), %rdx
180006a46:     	jge	0x180006c0a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x312a>
180006a4c:     	movq	%rcx, 0x108(%rsp)
180006a54:     	movsd	%xmm6, 0x100(%rsp)
180006a5d:     	movq	%r12, 0xf8(%rsp)
180006a65:     	movq	%rax, 0xf0(%rsp)
180006a6d:     	movq	0x2c8(%rsp), %rax
180006a75:     	movq	%rax, 0xe8(%rsp)
180006a7d:     	movq	0x2c0(%rsp), %rax
180006a85:     	movq	%rax, 0xe0(%rsp)
180006a8d:     	movq	%rbx, 0xd8(%rsp)
180006a95:     	movq	%rbp, 0xd0(%rsp)
180006a9d:     	movq	0x2a8(%rsp), %rax
180006aa5:     	movq	%rax, 0xc8(%rsp)
180006aad:     	movq	%r11, 0xc0(%rsp)
180006ab5:     	movq	0x298(%rsp), %rax
180006abd:     	movq	%rax, 0xb8(%rsp)
180006ac5:     	movq	0x290(%rsp), %rax
180006acd:     	movq	%rax, 0xb0(%rsp)
180006ad5:     	movq	0x288(%rsp), %rax
180006add:     	movq	%rax, 0xa8(%rsp)
180006ae5:     	movq	%rsi, 0xa0(%rsp)
180006aed:     	movq	0x278(%rsp), %rax
180006af5:     	movq	%rax, 0x98(%rsp)
180006afd:     	movq	0x270(%rsp), %rax
180006b05:     	movq	%rax, 0x90(%rsp)
180006b0d:     	movq	0x268(%rsp), %rax
180006b15:     	movq	%rax, 0x88(%rsp)
180006b1d:     	movq	0x260(%rsp), %rax
180006b25:     	movq	%rax, 0x80(%rsp)
180006b2d:     	movq	0x258(%rsp), %rax
180006b35:     	movq	%rax, 0x78(%rsp)
180006b3a:     	movq	%r15, 0x70(%rsp)
180006b3f:     	movq	%r14, 0x68(%rsp)
180006b44:     	movq	0x240(%rsp), %rax
180006b4c:     	movq	%rax, 0x60(%rsp)
180006b51:     	movq	0x238(%rsp), %rax
180006b59:     	movq	%rax, 0x58(%rsp)
180006b5e:     	movq	0x230(%rsp), %rax
180006b66:     	movq	%rax, 0x50(%rsp)
180006b6b:     	movq	0x228(%rsp), %rax
180006b73:     	movq	%rax, 0x48(%rsp)
180006b78:     	movq	0x220(%rsp), %rax
180006b80:     	movq	%rax, 0x40(%rsp)
180006b85:     	movq	0x218(%rsp), %rax
180006b8d:     	movq	%rax, 0x38(%rsp)
180006b92:     	movq	%rdi, 0x30(%rsp)
180006b97:     	movq	0x208(%rsp), %rax
180006b9f:     	movq	%rax, 0x28(%rsp)
180006ba4:     	movq	0x200(%rsp), %rax
180006bac:     	movq	%rax, 0x20(%rsp)
180006bb1:     	leaq	0x130(%rsp), %rcx
180006bb9:     	movq	%r8, 0x110(%rsp)
180006bc1:     	movq	%r9, %rbp
180006bc4:     	callq	0x180006400 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2920>
180006bc9:     	cmpb	$0x0, (%rbx)
180006bcc:     	je	0x180006c1a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x313a>
180006bce:     	movq	0x108(%rsp), %rax
180006bd6:     	movq	$0x0, 0x8(%rax)
180006bde:     	movq	$0x0, (%rax)
180006be5:     	jmp	0x18000654f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a6f>
180006bea:     	movb	$0x1, (%rbx)
180006bed:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180006bf5:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006bfa:     	movb	$0x1, (%rbx)
180006bfd:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
180006c05:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006c0a:     	movb	$0x1, (%rbx)
180006c0d:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
180006c15:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006c1a:     	addsd	0x130(%rsp), %xmm7
180006c23:     	addsd	0x138(%rsp), %xmm8
180006c2d:     	decq	0x8(%rsi)
180006c31:     	movq	0x108(%rsp), %rcx
180006c39:     	movq	%rbp, %r9
180006c3c:     	movq	0x110(%rsp), %r8
180006c44:     	movq	0x298(%rsp), %rdx
180006c4c:     	movq	0x2a0(%rsp), %r11
180006c54:     	movq	0x2a8(%rsp), %r10
180006c5c:     	movq	0x40(%r14,%r13,8), %rax
180006c61:     	testq	%rax, %rax
180006c64:     	js	0x180006e41 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3361>
180006c6a:     	movq	%r10, %rbp
180006c6d:     	movq	%rdx, %r13
180006c70:     	movq	0x8(%rsi), %rdx
180006c74:     	leaq	0x1(%rdx), %r10
180006c78:     	movq	%r10, 0x8(%rsi)
180006c7c:     	cmpq	0x10(%rsi), %rdx
180006c80:     	jge	0x180006e12 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3332>
180006c86:     	movq	%rcx, 0x108(%rsp)
180006c8e:     	movq	%r12, 0xf8(%rsp)
180006c96:     	movq	%rax, 0xf0(%rsp)
180006c9e:     	movq	0x2c8(%rsp), %rax
180006ca6:     	movq	%rax, 0xe8(%rsp)
180006cae:     	movq	0x2c0(%rsp), %rax
180006cb6:     	movq	%rax, 0xe0(%rsp)
180006cbe:     	movq	0x2b0(%rsp), %rax
180006cc6:     	movq	%rax, 0xd0(%rsp)
180006cce:     	movq	%rbp, 0xc8(%rsp)
180006cd6:     	movq	%r11, 0xc0(%rsp)
180006cde:     	movq	%r13, 0xb8(%rsp)
180006ce6:     	movq	0x290(%rsp), %rax
180006cee:     	movq	%rax, 0xb0(%rsp)
180006cf6:     	movq	0x288(%rsp), %rax
180006cfe:     	movq	%rax, 0xa8(%rsp)
180006d06:     	movq	0x278(%rsp), %rax
180006d0e:     	movq	%rax, 0x98(%rsp)
180006d16:     	movq	0x270(%rsp), %rax
180006d1e:     	movq	%rax, 0x90(%rsp)
180006d26:     	movq	0x268(%rsp), %rax
180006d2e:     	movq	%rax, 0x88(%rsp)
180006d36:     	movq	0x260(%rsp), %rax
180006d3e:     	movq	%rax, 0x80(%rsp)
180006d46:     	movq	0x258(%rsp), %rax
180006d4e:     	movq	%rax, 0x78(%rsp)
180006d53:     	movq	%r15, 0x70(%rsp)
180006d58:     	movq	%r14, 0x68(%rsp)
180006d5d:     	movq	0x240(%rsp), %rax
180006d65:     	movq	%rax, 0x60(%rsp)
180006d6a:     	movq	0x238(%rsp), %rax
180006d72:     	movq	%rax, 0x58(%rsp)
180006d77:     	movq	0x230(%rsp), %rax
180006d7f:     	movq	%rax, 0x50(%rsp)
180006d84:     	movq	0x228(%rsp), %rax
180006d8c:     	movq	%rax, 0x48(%rsp)
180006d91:     	movq	0x220(%rsp), %rax
180006d99:     	movq	%rax, 0x40(%rsp)
180006d9e:     	movq	0x218(%rsp), %rax
180006da6:     	movq	%rax, 0x38(%rsp)
180006dab:     	movq	%rdi, 0x30(%rsp)
180006db0:     	movq	0x208(%rsp), %rax
180006db8:     	movq	%rax, 0x28(%rsp)
180006dbd:     	movsd	%xmm6, 0x100(%rsp)
180006dc6:     	movq	%rbx, 0xd8(%rsp)
180006dce:     	movq	%rsi, 0xa0(%rsp)
180006dd6:     	movq	0x200(%rsp), %rax
180006dde:     	movq	%rax, 0x20(%rsp)
180006de3:     	leaq	0x120(%rsp), %rcx
180006deb:     	callq	0x180006400 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2920>
180006df0:     	cmpb	$0x0, (%rbx)
180006df3:     	je	0x180006e22 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3342>
180006df5:     	movq	0x108(%rsp), %r13
180006dfd:     	movq	$0x0, 0x8(%r13)
180006e05:     	movq	$0x0, (%r13)
180006e0d:     	jmp	0x18000654f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a6f>
180006e12:     	movb	$0x1, (%rbx)
180006e15:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
180006e1d:     	jmp	0x180006540 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a60>
180006e22:     	addsd	0x120(%rsp), %xmm7
180006e2b:     	addsd	0x128(%rsp), %xmm8
180006e35:     	decq	0x8(%rsi)
180006e39:     	movq	0x108(%rsp), %rcx
180006e41:     	movsd	%xmm7, (%rcx)
180006e45:     	movsd	%xmm8, 0x8(%rcx)
180006e4b:     	jmp	0x18000654f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x2a6f>
180006e50:     	pushq	%r15
180006e52:     	pushq	%r14
180006e54:     	pushq	%r13
180006e56:     	pushq	%r12
180006e58:     	pushq	%rsi
180006e59:     	pushq	%rdi
180006e5a:     	pushq	%rbp
180006e5b:     	pushq	%rbx
180006e5c:     	subq	$0x1c8, %rsp            # imm = 0x1C8
180006e63:     	movq	0x300(%rsp), %rax
180006e6b:     	movq	0x2e8(%rsp), %r15
180006e73:     	movq	0x2b0(%rsp), %r12
180006e7b:     	movb	$0x0, 0x12f(%rsp)
180006e83:     	movq	$0x0, 0x1a8(%rsp)
180006e8f:     	movb	$0x0, 0x11f(%rsp)
180006e97:     	movq	$0x0, 0x1a0(%rsp)
180006ea3:     	movb	$0x0, 0x11e(%rsp)
180006eab:     	movq	$0x0, 0x198(%rsp)
180006eb7:     	movb	$0x0, 0x11d(%rsp)
180006ebf:     	movq	$0x0, 0x190(%rsp)
180006ecb:     	movb	$0x0, 0x11c(%rsp)
180006ed3:     	movq	$0x0, 0x188(%rsp)
180006edf:     	movb	$0x0, 0x12e(%rsp)
180006ee7:     	movq	$0x0, 0x180(%rsp)
180006ef3:     	movb	$0x0, 0x12d(%rsp)
180006efb:     	movq	$0x0, 0x178(%rsp)
180006f07:     	movb	$0x0, 0x12c(%rsp)
180006f0f:     	movq	$0x0, 0x170(%rsp)
180006f1b:     	movb	$0x0, 0x12b(%rsp)
180006f23:     	movq	$0x0, 0x168(%rsp)
180006f2f:     	cmpq	$0x1, %rax
180006f33:     	movq	0x280(%rsp), %rbx
180006f3b:     	movq	0x278(%rsp), %r13
180006f43:     	movq	0x258(%rsp), %rdi
180006f4b:     	movq	0x248(%rsp), %r14
180006f53:     	movq	0x240(%rsp), %rbp
180006f5b:     	je	0x180007002 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3522>
180006f61:     	testq	%rax, %rax
180006f64:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180006f6a:     	movq	0x308(%rsp), %rsi
180006f72:     	movq	(%r13,%rsi,8), %rax
180006f77:     	testq	%rax, %rax
180006f7a:     	js	0x18000702f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x354f>
180006f80:     	movq	0x310(%rsp), %r10
180006f88:     	testq	%r10, %r10
180006f8b:     	js	0x18000702f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x354f>
180006f91:     	movq	0x10(%r13,%r10,8), %r11
180006f96:     	testq	%r11, %r11
180006f99:     	js	0x1800070bf <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x35df>
180006f9f:     	movsd	(%rbp,%r11,8), %xmm0
180006fa6:     	movsd	0x8(%rbp,%rax,8), %xmm2
180006fac:     	movsd	0x10(%rbp,%rax,8), %xmm1
180006fb2:     	movapd	%xmm1, %xmm3
180006fb6:     	subsd	%xmm2, %xmm3
180006fba:     	xorl	%r10d, %r10d
180006fbd:     	ucomisd	%xmm3, %xmm0
180006fc1:     	jb	0x1800070e1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3601>
180006fc7:     	addsd	%xmm2, %xmm1
180006fcb:     	ucomisd	%xmm0, %xmm1
180006fcf:     	jbe	0x1800070e1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3601>
180006fd5:     	movsd	0x8(%rbp,%r11,8), %xmm0
180006fdc:     	movsd	(%rbp,%rax,8), %xmm1
180006fe2:     	movsd	0x18(%rbp,%rax,8), %xmm2
180006fe8:     	movapd	%xmm2, %xmm3
180006fec:     	subsd	%xmm1, %xmm3
180006ff0:     	ucomisd	%xmm3, %xmm0
180006ff4:     	jae	0x1800070d5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x35f5>
180006ffa:     	xorl	%r10d, %r10d
180006ffd:     	jmp	0x1800070e1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3601>
180007002:     	movq	0x318(%rsp), %rsi
18000700a:     	testq	%rsi, %rsi
18000700d:     	js	0x180007041 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3561>
18000700f:     	movq	(%r13,%rsi,8), %rax
180007014:     	testq	%rax, %rax
180007017:     	js	0x180007041 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3561>
180007019:     	movq	(%r12), %r10
18000701d:     	leaq	0x4(%r10), %r11
180007021:     	cmpq	%rbx, %r11
180007024:     	jle	0x180007053 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3573>
180007026:     	movb	$0x2, (%r15)
18000702a:     	jmp	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
18000702f:     	movb	$0x1, (%r15)
180007033:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
18000703c:     	jmp	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007041:     	movb	$0x1, (%r15)
180007045:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
18000704e:     	jmp	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007053:     	movsd	0x10(%rbp,%rax,8), %xmm1
180007059:     	movsd	0x18(%rbp,%rax,8), %xmm2
18000705f:     	movsd	0x5349(%rip), %xmm0     # 0x18000c3b0
180007067:     	movsd	0x8(%rbp,%rax,8), %xmm3
18000706d:     	mulsd	%xmm0, %xmm3
180007071:     	mulsd	(%rbp,%rax,8), %xmm0
180007077:     	movq	%r11, (%r12)
18000707b:     	cmpb	$0x0, (%r15)
18000707f:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007085:     	movapd	%xmm1, %xmm4
180007089:     	addsd	%xmm3, %xmm4
18000708d:     	movapd	%xmm2, %xmm5
180007091:     	subsd	%xmm0, %xmm5
180007095:     	testq	%r10, %r10
180007098:     	js	0x1800071fb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x371b>
18000709e:     	movsd	%xmm4, 0x10(%rbp,%r10,8)
1800070a5:     	movsd	%xmm5, 0x18(%rbp,%r10,8)
1800070ac:     	movsd	%xmm3, 0x8(%rbp,%r10,8)
1800070b3:     	movsd	%xmm0, (%rbp,%r10,8)
1800070ba:     	jmp	0x180007208 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3728>
1800070bf:     	movb	$0x1, (%r15)
1800070c3:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
1800070cc:     	cmpb	$0x0, (%r15)
1800070d0:     	jmp	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
1800070d5:     	addsd	%xmm1, %xmm2
1800070d9:     	ucomisd	%xmm0, %xmm2
1800070dd:     	seta	%r10b
1800070e1:     	cmpb	$0x0, (%r15)
1800070e5:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
1800070eb:     	testb	%r10b, %r10b
1800070ee:     	je	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
1800070f4:     	movq	0x18(%r13,%rsi,8), %rax
1800070f9:     	movq	0x30(%r13,%rsi,8), %rdi
1800070fe:     	movq	%rdi, %r11
180007101:     	sarq	$0x3f, %r11
180007105:     	andq	%rbx, %r11
180007108:     	movq	%rdi, %r10
18000710b:     	leaq	(%r13,%rdi,8), %rdi
180007110:     	movq	%r11, 0x140(%rsp)
180007118:     	movq	(%rdi,%r11,8), %r11
18000711c:     	movq	%r11, 0x110(%rsp)
180007124:     	cmpq	0x8(%r13,%rsi,8), %r11
180007129:     	jge	0x18000738c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x38ac>
18000712f:     	testq	%rax, %rax
180007132:     	jne	0x180007395 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x38b5>
180007138:     	movq	%rdi, %r14
18000713b:     	xorl	%r8d, %r8d
18000713e:     	cmpq	$-0x1, %r10
180007142:     	cmovlq	%rbx, %r8
180007146:     	movq	0x110(%rsp), %rdx
18000714e:     	cmpq	0x8(%rdi,%r8,8), %rdx
180007153:     	jne	0x180007c3d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x415d>
180007159:     	leaq	(%rdx,%rdx), %rax
18000715d:     	testq	%rdx, %rdx
180007160:     	movl	$0x4, %r9d
180007166:     	cmovneq	%rax, %r9
18000716a:     	movq	(%r12), %r11
18000716e:     	leaq	(%r11,%r9), %rax
180007172:     	cmpq	%rbx, %rax
180007175:     	jg	0x180007026 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3546>
18000717b:     	movq	%rax, (%r12)
18000717f:     	cmpb	$0x0, (%r15)
180007183:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007189:     	movq	%r14, 0x150(%rsp)
180007191:     	movq	%r11, 0x148(%rsp)
180007199:     	movq	%r9, 0x158(%rsp)
1800071a1:     	movq	%r8, 0x160(%rsp)
1800071a9:     	xorl	%r11d, %r11d
1800071ac:     	movq	%r10, 0x1c0(%rsp)
1800071b4:     	cmpq	$-0x2, %r10
1800071b8:     	cmovlq	%rbx, %r11
1800071bc:     	testq	%rdx, %rdx
1800071bf:     	jle	0x180007c03 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4123>
1800071c5:     	movq	0x150(%rsp), %rax
1800071cd:     	movq	0x10(%rax,%r11,8), %r14
1800071d2:     	movq	0x110(%rsp), %rax
1800071da:     	movl	%eax, %r10d
1800071dd:     	andl	$0x7, %r10d
1800071e1:     	cmpq	$0x7, %rax
1800071e5:     	ja	0x1800079eb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3f0b>
1800071eb:     	leaq	(,%rbx,8), %r8
1800071f3:     	xorl	%r9d, %r9d
1800071f6:     	jmp	0x180007bc7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x40e7>
1800071fb:     	movb	$0x1, (%r15)
1800071ff:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180007208:     	cmpb	$0x0, (%r15)
18000720c:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007212:     	movq	(%r12), %r11
180007216:     	leaq	0xa(%r11), %rax
18000721a:     	cmpq	%rbx, %rax
18000721d:     	jg	0x180007026 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3546>
180007223:     	movq	%r11, 0x140(%rsp)
18000722b:     	movq	0x8(%r13,%rsi,8), %r11
180007230:     	movq	%rax, (%r12)
180007234:     	cmpb	$0x0, (%r15)
180007238:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
18000723e:     	movq	0x140(%rsp), %rax
180007246:     	movq	%r10, (%r13,%rax,8)
18000724b:     	movq	%r11, 0x8(%r13,%rax,8)
180007250:     	movq	(%r12), %r10
180007254:     	cmpq	%rbx, %r10
180007257:     	movq	%r10, %r11
18000725a:     	jle	0x180007267 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3787>
18000725c:     	movb	$0x2, (%r15)
180007260:     	movq	(%r12), %r10
180007264:     	xorl	%r11d, %r11d
180007267:     	leaq	0x3(%r10), %rax
18000726b:     	cmpq	%rbx, %rax
18000726e:     	jg	0x180007026 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3546>
180007274:     	movq	%rax, (%r12)
180007278:     	cmpb	$0x0, (%r15)
18000727c:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007282:     	movq	%r10, %rax
180007285:     	sarq	$0x3f, %rax
180007289:     	andq	%rbx, %rax
18000728c:     	movq	%r11, 0x120(%rsp)
180007294:     	leaq	(%r13,%r10,8), %r11
180007299:     	movq	$0x0, (%r11,%rax,8)
1800072a1:     	movq	$0x0, 0x110(%rsp)
1800072ad:     	cmpq	$-0x1, %r10
1800072b1:     	movl	$0x0, %eax
1800072b6:     	cmovlq	%rbx, %rax
1800072ba:     	leaq	(%r13,%r10,8), %r11
1800072bf:     	movq	$0x0, 0x8(%r11,%rax,8)
1800072c8:     	cmpq	$-0x2, %r10
1800072cc:     	movq	0x110(%rsp), %rax
1800072d4:     	cmovlq	%rbx, %rax
1800072d8:     	movq	%rax, 0x110(%rsp)
1800072e0:     	leaq	(%r13,%r10,8), %rax
1800072e5:     	movq	0x120(%rsp), %r11
1800072ed:     	movq	%r10, 0x130(%rsp)
1800072f5:     	movq	0x110(%rsp), %r10
1800072fd:     	movq	%r11, 0x10(%rax,%r10,8)
180007302:     	movq	0x130(%rsp), %r10
18000730a:     	cmpb	$0x0, (%r15)
18000730e:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007314:     	movq	0x140(%rsp), %rax
18000731c:     	leaq	(%r13,%rax,8), %r11
180007321:     	movq	%r10, 0x30(%r11)
180007325:     	movq	$0x0, 0x18(%r11)
18000732d:     	movq	(%r12), %r10
180007331:     	leaq	0x2(%r10), %rax
180007335:     	cmpq	%rbx, %rax
180007338:     	jg	0x180007026 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3546>
18000733e:     	movq	%rax, (%r12)
180007342:     	cmpb	$0x0, (%r15)
180007346:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
18000734c:     	movq	%r8, 0x130(%rsp)
180007354:     	movq	%r9, 0x138(%rsp)
18000735c:     	movq	%rdx, 0x120(%rsp)
180007364:     	movq	%rcx, 0x110(%rsp)
18000736c:     	testq	%r10, %r10
18000736f:     	js	0x180007fbd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x44dd>
180007375:     	movq	$0x0, 0x8(%rbp,%r10,8)
18000737e:     	movq	$0x0, (%rbp,%r10,8)
180007387:     	jmp	0x180007fca <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x44ea>
18000738c:     	testq	%rax, %rax
18000738f:     	je	0x18000759f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3abf>
180007395:     	movq	0x20(%r13,%rsi,8), %rax
18000739a:     	testq	%rax, %rax
18000739d:     	js	0x1800077ae <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cce>
1800073a3:     	movq	0x8(%r12), %r10
1800073a8:     	leaq	0x1(%r10), %r11
1800073ac:     	movq	%r11, 0x8(%r12)
1800073b1:     	cmpq	0x10(%r12), %r10
1800073b6:     	jge	0x1800077ae <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cce>
1800073bc:     	movq	%rdx, 0x120(%rsp)
1800073c4:     	movq	%rcx, 0x110(%rsp)
1800073cc:     	movb	$0x0, 0x11f(%rsp)
1800073d4:     	movq	0x310(%rsp), %rcx
1800073dc:     	movq	%rcx, 0x100(%rsp)
1800073e4:     	movq	%rax, 0xf8(%rsp)
1800073ec:     	movq	0x2f8(%rsp), %rax
1800073f4:     	movq	%rax, 0xe8(%rsp)
1800073fc:     	movq	0x2f0(%rsp), %rax
180007404:     	movq	%rax, 0xe0(%rsp)
18000740c:     	movq	%r15, 0xd8(%rsp)
180007414:     	movq	0x2e0(%rsp), %rax
18000741c:     	movq	%rax, 0xd0(%rsp)
180007424:     	movq	0x2d8(%rsp), %rax
18000742c:     	movq	%rax, 0xc8(%rsp)
180007434:     	movq	0x2d0(%rsp), %rax
18000743c:     	movq	%rax, 0xc0(%rsp)
180007444:     	movq	0x2c8(%rsp), %rax
18000744c:     	movq	%rax, 0xb8(%rsp)
180007454:     	movq	0x2c0(%rsp), %rax
18000745c:     	movq	%rax, 0xb0(%rsp)
180007464:     	movq	0x2b8(%rsp), %rax
18000746c:     	movq	%rax, 0xa8(%rsp)
180007474:     	movq	%r12, 0xa0(%rsp)
18000747c:     	movq	0x2a8(%rsp), %rax
180007484:     	movq	%rax, 0x98(%rsp)
18000748c:     	movq	0x2a0(%rsp), %rax
180007494:     	movq	%rax, 0x90(%rsp)
18000749c:     	movq	0x298(%rsp), %rax
1800074a4:     	movq	%rax, 0x88(%rsp)
1800074ac:     	movq	0x290(%rsp), %rax
1800074b4:     	movq	%rax, 0x80(%rsp)
1800074bc:     	movq	0x288(%rsp), %rax
1800074c4:     	movq	%rax, 0x78(%rsp)
1800074c9:     	movq	%rbx, 0x70(%rsp)
1800074ce:     	movq	%r13, 0x68(%rsp)
1800074d3:     	movq	0x270(%rsp), %rax
1800074db:     	movq	%rax, 0x60(%rsp)
1800074e0:     	movq	0x268(%rsp), %rax
1800074e8:     	movq	%rax, 0x58(%rsp)
1800074ed:     	movq	0x260(%rsp), %rax
1800074f5:     	movq	%rax, 0x50(%rsp)
1800074fa:     	movq	0x258(%rsp), %rdi
180007502:     	movq	%rdi, 0x48(%rsp)
180007507:     	movq	0x250(%rsp), %rax
18000750f:     	movq	%rax, 0x40(%rsp)
180007514:     	movq	0x248(%rsp), %r14
18000751c:     	movq	%r14, 0x38(%rsp)
180007521:     	movq	%rbp, 0x30(%rsp)
180007526:     	movq	0x238(%rsp), %rax
18000752e:     	movq	%rax, 0x28(%rsp)
180007533:     	movq	0x230(%rsp), %rax
18000753b:     	movq	%rax, 0x20(%rsp)
180007540:     	movq	$-0x1, 0x108(%rsp)
18000754c:     	movq	$0x0, 0xf0(%rsp)
180007558:     	leaq	0x11f(%rsp), %rcx
180007560:     	leaq	0x1a0(%rsp), %rdx
180007568:     	movq	%r8, 0x130(%rsp)
180007570:     	movq	%r9, 0x138(%rsp)
180007578:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
18000757d:     	testl	%eax, %eax
18000757f:     	jne	0x180007d8e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42ae>
180007585:     	cmpb	$0x0, (%r15)
180007589:     	movq	0x110(%rsp), %rax
180007591:     	je	0x1800077e3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3d03>
180007597:     	movb	$0x0, (%rax)
18000759a:     	jmp	0x1800077be <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cde>
18000759f:     	movq	0x8(%r12), %rax
1800075a4:     	leaq	0x1(%rax), %r10
1800075a8:     	movq	%r10, 0x8(%r12)
1800075ad:     	cmpq	0x10(%r12), %rax
1800075b2:     	jge	0x1800077d4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cf4>
1800075b8:     	movq	%rdx, 0x120(%rsp)
1800075c0:     	movq	%rcx, 0x110(%rsp)
1800075c8:     	movq	%rsi, 0x108(%rsp)
1800075d0:     	movq	0x2f8(%rsp), %rax
1800075d8:     	movq	%rax, 0xe8(%rsp)
1800075e0:     	movq	0x2f0(%rsp), %rax
1800075e8:     	movq	%rax, 0xe0(%rsp)
1800075f0:     	movq	%r15, 0xd8(%rsp)
1800075f8:     	movq	0x2e0(%rsp), %rax
180007600:     	movq	%rax, 0xd0(%rsp)
180007608:     	movq	0x2d8(%rsp), %rax
180007610:     	movq	%rax, 0xc8(%rsp)
180007618:     	movq	0x2d0(%rsp), %rax
180007620:     	movq	%rax, 0xc0(%rsp)
180007628:     	movq	0x2c8(%rsp), %rax
180007630:     	movq	%rax, 0xb8(%rsp)
180007638:     	movq	0x2c0(%rsp), %rax
180007640:     	movq	%rax, 0xb0(%rsp)
180007648:     	movq	0x2b8(%rsp), %rax
180007650:     	movq	%rax, 0xa8(%rsp)
180007658:     	movq	%r12, 0xa0(%rsp)
180007660:     	movq	0x2a8(%rsp), %rax
180007668:     	movq	%rax, 0x98(%rsp)
180007670:     	movq	0x2a0(%rsp), %rax
180007678:     	movq	%rax, 0x90(%rsp)
180007680:     	movq	0x298(%rsp), %rax
180007688:     	movq	%rax, 0x88(%rsp)
180007690:     	movq	0x290(%rsp), %rax
180007698:     	movq	%rax, 0x80(%rsp)
1800076a0:     	movq	0x288(%rsp), %rax
1800076a8:     	movq	%rax, 0x78(%rsp)
1800076ad:     	movq	%rbx, 0x70(%rsp)
1800076b2:     	movq	%r13, 0x68(%rsp)
1800076b7:     	movq	0x270(%rsp), %rax
1800076bf:     	movq	%rax, 0x60(%rsp)
1800076c4:     	movq	0x268(%rsp), %rax
1800076cc:     	movq	%rax, 0x58(%rsp)
1800076d1:     	movq	0x260(%rsp), %rax
1800076d9:     	movq	%rax, 0x50(%rsp)
1800076de:     	movq	0x258(%rsp), %rax
1800076e6:     	movq	%rax, 0x48(%rsp)
1800076eb:     	movq	0x250(%rsp), %rax
1800076f3:     	movq	%rax, 0x40(%rsp)
1800076f8:     	movq	0x248(%rsp), %rax
180007700:     	movq	%rax, 0x38(%rsp)
180007705:     	movq	%rbp, 0x30(%rsp)
18000770a:     	movq	0x238(%rsp), %rax
180007712:     	movq	%rax, 0x28(%rsp)
180007717:     	movq	0x230(%rsp), %rax
18000771f:     	movq	%rax, 0x20(%rsp)
180007724:     	movq	$-0x1, 0x100(%rsp)
180007730:     	movq	$-0x1, 0xf8(%rsp)
18000773c:     	movq	$0x1, 0xf0(%rsp)
180007748:     	leaq	0x12f(%rsp), %rcx
180007750:     	leaq	0x1a8(%rsp), %rdx
180007758:     	movq	%r8, 0x130(%rsp)
180007760:     	movq	%r9, 0x138(%rsp)
180007768:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
18000776d:     	testl	%eax, %eax
18000776f:     	jne	0x180007d98 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42b8>
180007775:     	cmpb	$0x0, (%r15)
180007779:     	movq	0x110(%rsp), %rcx
180007781:     	movq	0x120(%rsp), %rdx
180007789:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
18000778b:     	decq	0x8(%r12)
180007790:     	movq	0x138(%rsp), %r9
180007798:     	movq	0x130(%rsp), %r8
1800077a0:     	movq	0x20(%r13,%rsi,8), %rax
1800077a5:     	testq	%rax, %rax
1800077a8:     	jns	0x1800073a3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x38c3>
1800077ae:     	movb	$0x1, (%r15)
1800077b2:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
1800077bb:     	movb	$0x0, (%rcx)
1800077be:     	xorl	%eax, %eax
1800077c0:     	addq	$0x1c8, %rsp            # imm = 0x1C8
1800077c7:     	popq	%rbx
1800077c8:     	popq	%rbp
1800077c9:     	popq	%rdi
1800077ca:     	popq	%rsi
1800077cb:     	popq	%r12
1800077cd:     	popq	%r13
1800077cf:     	popq	%r14
1800077d1:     	popq	%r15
1800077d3:     	retq
1800077d4:     	movb	$0x1, (%r15)
1800077d8:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
1800077e1:     	jmp	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
1800077e3:     	movzbl	0x11f(%rsp), %ecx
1800077eb:     	movq	0x8(%r12), %rdx
1800077f0:     	leaq	-0x1(%rdx), %r8
1800077f4:     	movq	%r8, 0x8(%r12)
1800077f9:     	testb	$0x1, %cl
1800077fc:     	je	0x180007803 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3d23>
1800077fe:     	movb	$0x1, (%rax)
180007801:     	jmp	0x1800077be <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cde>
180007803:     	movq	0x28(%r13,%rsi,8), %rcx
180007808:     	testq	%rcx, %rcx
18000780b:     	js	0x180007819 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3d39>
18000780d:     	movq	%rdx, 0x8(%r12)
180007812:     	cmpq	0x10(%r12), %rdx
180007817:     	jle	0x18000782b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3d4b>
180007819:     	movb	$0x1, (%r15)
18000781d:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180007826:     	jmp	0x180007597 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3ab7>
18000782b:     	movb	$0x0, 0x11e(%rsp)
180007833:     	movq	0x310(%rsp), %rax
18000783b:     	movq	%rax, 0x100(%rsp)
180007843:     	movq	%rcx, 0xf8(%rsp)
18000784b:     	movq	0x2f8(%rsp), %rax
180007853:     	movq	%rax, 0xe8(%rsp)
18000785b:     	movq	0x2f0(%rsp), %rax
180007863:     	movq	%rax, 0xe0(%rsp)
18000786b:     	movq	%r15, 0xd8(%rsp)
180007873:     	movq	0x2e0(%rsp), %rax
18000787b:     	movq	%rax, 0xd0(%rsp)
180007883:     	movq	0x2d8(%rsp), %rax
18000788b:     	movq	%rax, 0xc8(%rsp)
180007893:     	movq	0x2d0(%rsp), %rax
18000789b:     	movq	%rax, 0xc0(%rsp)
1800078a3:     	movq	0x2c8(%rsp), %rax
1800078ab:     	movq	%rax, 0xb8(%rsp)
1800078b3:     	movq	0x2c0(%rsp), %rax
1800078bb:     	movq	%rax, 0xb0(%rsp)
1800078c3:     	movq	0x2b8(%rsp), %rax
1800078cb:     	movq	%rax, 0xa8(%rsp)
1800078d3:     	movq	%r12, 0xa0(%rsp)
1800078db:     	movq	0x2a8(%rsp), %rax
1800078e3:     	movq	%rax, 0x98(%rsp)
1800078eb:     	movq	0x2a0(%rsp), %rax
1800078f3:     	movq	%rax, 0x90(%rsp)
1800078fb:     	movq	0x298(%rsp), %rax
180007903:     	movq	%rax, 0x88(%rsp)
18000790b:     	movq	0x290(%rsp), %rax
180007913:     	movq	%rax, 0x80(%rsp)
18000791b:     	movq	0x288(%rsp), %rax
180007923:     	movq	%rax, 0x78(%rsp)
180007928:     	movq	%rbx, 0x70(%rsp)
18000792d:     	movq	%r13, 0x68(%rsp)
180007932:     	movq	0x270(%rsp), %rax
18000793a:     	movq	%rax, 0x60(%rsp)
18000793f:     	movq	0x268(%rsp), %rax
180007947:     	movq	%rax, 0x58(%rsp)
18000794c:     	movq	0x260(%rsp), %rax
180007954:     	movq	%rax, 0x50(%rsp)
180007959:     	movq	%rdi, 0x48(%rsp)
18000795e:     	movq	0x250(%rsp), %rax
180007966:     	movq	%rax, 0x40(%rsp)
18000796b:     	movq	%r14, 0x38(%rsp)
180007970:     	movq	%rbp, 0x30(%rsp)
180007975:     	movq	0x238(%rsp), %rax
18000797d:     	movq	%rax, 0x28(%rsp)
180007982:     	movq	0x230(%rsp), %rax
18000798a:     	movq	%rax, 0x20(%rsp)
18000798f:     	movq	$-0x1, 0x108(%rsp)
18000799b:     	movq	$0x0, 0xf0(%rsp)
1800079a7:     	leaq	0x11e(%rsp), %rcx
1800079af:     	leaq	0x198(%rsp), %rdx
1800079b7:     	movq	0x130(%rsp), %r8
1800079bf:     	movq	0x138(%rsp), %r9
1800079c7:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
1800079cc:     	testl	%eax, %eax
1800079ce:     	jne	0x18000803e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x455e>
1800079d4:     	cmpb	$0x0, (%r15)
1800079d8:     	je	0x180007d3f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x425f>
1800079de:     	movq	0x110(%rsp), %rax
1800079e6:     	jmp	0x180007597 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3ab7>
1800079eb:     	movq	%r10, 0x1b0(%rsp)
1800079f3:     	movq	%r11, 0x1b8(%rsp)
1800079fb:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180007a05:     	andq	%rax, %r9
180007a08:     	movq	0x148(%rsp), %r11
180007a10:     	leaq	(,%rbx,8), %r8
180007a18:     	xorl	%edx, %edx
180007a1a:     	movq	%r9, 0x138(%rsp)
180007a22:     	leaq	(%r14,%rdx), %rax
180007a26:     	sarq	$0x3f, %rax
180007a2a:     	andq	%r8, %rax
180007a2d:     	leaq	(%r13,%r14,8), %rdi
180007a32:     	addq	%rdi, %rax
180007a35:     	movq	(%rax,%rdx,8), %rax
180007a39:     	leaq	(%r11,%rdx), %r9
180007a3d:     	sarq	$0x3f, %r9
180007a41:     	andq	%r8, %r9
180007a44:     	leaq	(%r13,%r11,8), %r10
180007a49:     	movq	%r10, 0x120(%rsp)
180007a51:     	addq	%r10, %r9
180007a54:     	movq	%rax, (%r9,%rdx,8)
180007a58:     	leaq	0x1(%r14,%rdx), %rax
180007a5d:     	sarq	$0x3f, %rax
180007a61:     	andq	%r8, %rax
180007a64:     	movq	%rdi, %r10
180007a67:     	addq	%rdi, %rax
180007a6a:     	movq	0x8(%rax,%rdx,8), %rax
180007a6f:     	leaq	0x1(%r11,%rdx), %r9
180007a74:     	sarq	$0x3f, %r9
180007a78:     	andq	%r8, %r9
180007a7b:     	movq	0x120(%rsp), %rdi
180007a83:     	addq	%rdi, %r9
180007a86:     	movq	%rax, 0x8(%r9,%rdx,8)
180007a8b:     	leaq	0x2(%r14,%rdx), %rax
180007a90:     	sarq	$0x3f, %rax
180007a94:     	andq	%r8, %rax
180007a97:     	addq	%r10, %rax
180007a9a:     	movq	%r10, 0x130(%rsp)
180007aa2:     	movq	0x10(%rax,%rdx,8), %rax
180007aa7:     	leaq	0x2(%r11,%rdx), %r9
180007aac:     	sarq	$0x3f, %r9
180007ab0:     	andq	%r8, %r9
180007ab3:     	addq	%rdi, %r9
180007ab6:     	movq	%rax, 0x10(%r9,%rdx,8)
180007abb:     	leaq	0x3(%r14,%rdx), %rax
180007ac0:     	sarq	$0x3f, %rax
180007ac4:     	andq	%r8, %rax
180007ac7:     	addq	%r10, %rax
180007aca:     	movq	0x18(%rax,%rdx,8), %rax
180007acf:     	leaq	0x3(%r11,%rdx), %r9
180007ad4:     	sarq	$0x3f, %r9
180007ad8:     	andq	%r8, %r9
180007adb:     	addq	%rdi, %r9
180007ade:     	movq	%rdi, %r10
180007ae1:     	movq	%rax, 0x18(%r9,%rdx,8)
180007ae6:     	leaq	0x4(%r14,%rdx), %rax
180007aeb:     	sarq	$0x3f, %rax
180007aef:     	andq	%r8, %rax
180007af2:     	movq	0x130(%rsp), %rdi
180007afa:     	addq	%rdi, %rax
180007afd:     	movq	0x20(%rax,%rdx,8), %rax
180007b02:     	leaq	0x4(%r11,%rdx), %r9
180007b07:     	sarq	$0x3f, %r9
180007b0b:     	andq	%r8, %r9
180007b0e:     	addq	%r10, %r9
180007b11:     	movq	%rax, 0x20(%r9,%rdx,8)
180007b16:     	leaq	0x5(%r14,%rdx), %rax
180007b1b:     	sarq	$0x3f, %rax
180007b1f:     	andq	%r8, %rax
180007b22:     	addq	%rdi, %rax
180007b25:     	movq	0x28(%rax,%rdx,8), %rax
180007b2a:     	leaq	0x5(%r11,%rdx), %r9
180007b2f:     	sarq	$0x3f, %r9
180007b33:     	andq	%r8, %r9
180007b36:     	addq	0x120(%rsp), %r9
180007b3e:     	movq	%rax, 0x28(%r9,%rdx,8)
180007b43:     	leaq	0x6(%r14,%rdx), %rax
180007b48:     	sarq	$0x3f, %rax
180007b4c:     	andq	%r8, %rax
180007b4f:     	addq	%rdi, %rax
180007b52:     	movq	0x30(%rax,%rdx,8), %rax
180007b57:     	leaq	0x6(%r11,%rdx), %r9
180007b5c:     	sarq	$0x3f, %r9
180007b60:     	andq	%r8, %r9
180007b63:     	addq	0x120(%rsp), %r9
180007b6b:     	movq	%rax, 0x30(%r9,%rdx,8)
180007b70:     	leaq	0x7(%r14,%rdx), %rax
180007b75:     	sarq	$0x3f, %rax
180007b79:     	andq	%r8, %rax
180007b7c:     	addq	%rdi, %rax
180007b7f:     	movq	0x38(%rax,%rdx,8), %rax
180007b84:     	leaq	0x7(%r11,%rdx), %r9
180007b89:     	sarq	$0x3f, %r9
180007b8d:     	andq	%r8, %r9
180007b90:     	addq	0x120(%rsp), %r9
180007b98:     	movq	%rax, 0x38(%r9,%rdx,8)
180007b9d:     	movq	0x138(%rsp), %r9
180007ba5:     	addq	$0x8, %rdx
180007ba9:     	cmpq	%rdx, %r9
180007bac:     	jne	0x180007a22 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3f42>
180007bb2:     	movq	0x1b0(%rsp), %r10
180007bba:     	testq	%r10, %r10
180007bbd:     	movq	0x1b8(%rsp), %r11
180007bc5:     	je	0x180007c03 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4123>
180007bc7:     	movq	0x148(%rsp), %rax
180007bcf:     	leaq	(%r9,%rax), %rdx
180007bd3:     	addq	%r9, %r14
180007bd6:     	movq	%r14, %rax
180007bd9:     	sarq	$0x3f, %rax
180007bdd:     	andq	%r8, %rax
180007be0:     	addq	%r13, %rax
180007be3:     	movq	(%rax,%r14,8), %rax
180007be7:     	movq	%rdx, %r9
180007bea:     	sarq	$0x3f, %r9
180007bee:     	andq	%r8, %r9
180007bf1:     	addq	%r13, %r9
180007bf4:     	movq	%rax, (%r9,%rdx,8)
180007bf8:     	incq	%rdx
180007bfb:     	incq	%r14
180007bfe:     	decq	%r10
180007c01:     	jne	0x180007bd6 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x40f6>
180007c03:     	movq	0x160(%rsp), %rax
180007c0b:     	movq	0x158(%rsp), %rdx
180007c13:     	movq	0x150(%rsp), %r14
180007c1b:     	movq	%rdx, 0x8(%r14,%rax,8)
180007c20:     	movq	0x148(%rsp), %rax
180007c28:     	movq	%rax, 0x10(%r14,%r11,8)
180007c2d:     	movq	0x110(%rsp), %rdx
180007c35:     	movq	0x1c0(%rsp), %r10
180007c3d:     	leaq	0x1(%rdx), %rax
180007c41:     	movq	0x140(%rsp), %r8
180007c49:     	movq	%rax, (%r14,%r8,8)
180007c4d:     	cmpb	$0x0, (%r15)
180007c51:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007c57:     	xorl	%eax, %eax
180007c59:     	cmpq	$-0x2, %r10
180007c5d:     	cmovlq	%rbx, %rax
180007c61:     	addq	0x10(%r14,%rax,8), %rdx
180007c66:     	movq	%rdx, %rax
180007c69:     	sarq	$0x3f, %rax
180007c6d:     	andq	%rbx, %rax
180007c70:     	leaq	(%r13,%rdx,8), %rdx
180007c75:     	movq	0x310(%rsp), %r8
180007c7d:     	movq	%r8, (%rdx,%rax,8)
180007c81:     	movsd	0x48(%rbp,%rsi,8), %xmm2
180007c87:     	movsd	0x8(%rbp,%r8,8), %xmm1
180007c8e:     	movapd	%xmm2, %xmm0
180007c92:     	addsd	%xmm1, %xmm0
180007c96:     	xorpd	%xmm3, %xmm3
180007c9a:     	ucomisd	%xmm3, %xmm0
180007c9e:     	jbe	0x180007d09 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4229>
180007ca0:     	movq	0x10(%r13,%rsi,8), %rax
180007ca5:     	testq	%rax, %rax
180007ca8:     	js	0x180007d11 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4231>
180007caa:     	movq	0x10(%r13,%r8,8), %rdx
180007caf:     	testq	%rdx, %rdx
180007cb2:     	js	0x180007d11 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4231>
180007cb4:     	mulsd	(%rbp,%rax,8), %xmm2
180007cba:     	mulsd	(%rbp,%rdx,8), %xmm1
180007cc0:     	addsd	%xmm2, %xmm1
180007cc4:     	divsd	%xmm0, %xmm1
180007cc8:     	movsd	%xmm1, (%rbp,%rax,8)
180007cce:     	movq	0x10(%r13,%rsi,8), %rax
180007cd3:     	testq	%rax, %rax
180007cd6:     	js	0x180007d20 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4240>
180007cd8:     	movq	0x10(%r13,%r8,8), %rdx
180007cdd:     	testq	%rdx, %rdx
180007ce0:     	js	0x180007d20 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4240>
180007ce2:     	movsd	0x48(%rbp,%rsi,8), %xmm1
180007ce8:     	movsd	0x8(%rbp,%rdx,8), %xmm2
180007cee:     	mulsd	0x8(%rbp,%rax,8), %xmm1
180007cf4:     	mulsd	0x8(%rbp,%r8,8), %xmm2
180007cfb:     	addsd	%xmm1, %xmm2
180007cff:     	divsd	%xmm0, %xmm2
180007d03:     	movsd	%xmm2, 0x8(%rbp,%rax,8)
180007d09:     	movsd	%xmm0, 0x48(%rbp,%rsi,8)
180007d0f:     	jmp	0x180007d2d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x424d>
180007d11:     	movb	$0x1, (%r15)
180007d15:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
180007d1e:     	jmp	0x180007d2d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x424d>
180007d20:     	movb	$0x1, (%r15)
180007d24:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180007d2d:     	cmpb	$0x0, (%r15)
180007d31:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007d37:     	movb	$0x1, (%rcx)
180007d3a:     	jmp	0x1800077be <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cde>
180007d3f:     	movzbl	0x11e(%rsp), %eax
180007d47:     	movq	0x8(%r12), %rcx
180007d4c:     	leaq	-0x1(%rcx), %rdx
180007d50:     	movq	%rdx, 0x8(%r12)
180007d55:     	testb	$0x1, %al
180007d57:     	je	0x180007d66 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4286>
180007d59:     	movq	0x110(%rsp), %rax
180007d61:     	jmp	0x1800077fe <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3d1e>
180007d66:     	movq	0x38(%r13,%rsi,8), %rax
180007d6b:     	testq	%rax, %rax
180007d6e:     	js	0x180007d7c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x429c>
180007d70:     	movq	%rcx, 0x8(%r12)
180007d75:     	cmpq	0x10(%r12), %rcx
180007d7a:     	jle	0x180007db0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42d0>
180007d7c:     	movb	$0x1, (%r15)
180007d80:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
180007d89:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180007d8e:     	movq	0x1a0(%rsp), %rdx
180007d96:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
180007d98:     	movq	0x1a8(%rsp), %rdx
180007da0:     	movq	0x120(%rsp), %rcx
180007da8:     	movq	%rdx, (%rcx)
180007dab:     	jmp	0x1800077c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3ce0>
180007db0:     	movb	$0x0, 0x11d(%rsp)
180007db8:     	movq	0x310(%rsp), %rcx
180007dc0:     	movq	%rcx, 0x100(%rsp)
180007dc8:     	movq	%rax, 0xf8(%rsp)
180007dd0:     	movq	0x2f8(%rsp), %rax
180007dd8:     	movq	%rax, 0xe8(%rsp)
180007de0:     	movq	0x2f0(%rsp), %rax
180007de8:     	movq	%rax, 0xe0(%rsp)
180007df0:     	movq	%r15, 0xd8(%rsp)
180007df8:     	movq	0x2e0(%rsp), %rax
180007e00:     	movq	%rax, 0xd0(%rsp)
180007e08:     	movq	0x2d8(%rsp), %rax
180007e10:     	movq	%rax, 0xc8(%rsp)
180007e18:     	movq	0x2d0(%rsp), %rax
180007e20:     	movq	%rax, 0xc0(%rsp)
180007e28:     	movq	0x2c8(%rsp), %rax
180007e30:     	movq	%rax, 0xb8(%rsp)
180007e38:     	movq	0x2c0(%rsp), %rax
180007e40:     	movq	%rax, 0xb0(%rsp)
180007e48:     	movq	0x2b8(%rsp), %rax
180007e50:     	movq	%rax, 0xa8(%rsp)
180007e58:     	movq	%r12, 0xa0(%rsp)
180007e60:     	movq	0x2a8(%rsp), %rax
180007e68:     	movq	%rax, 0x98(%rsp)
180007e70:     	movq	0x2a0(%rsp), %rax
180007e78:     	movq	%rax, 0x90(%rsp)
180007e80:     	movq	0x298(%rsp), %rax
180007e88:     	movq	%rax, 0x88(%rsp)
180007e90:     	movq	0x290(%rsp), %rax
180007e98:     	movq	%rax, 0x80(%rsp)
180007ea0:     	movq	0x288(%rsp), %rax
180007ea8:     	movq	%rax, 0x78(%rsp)
180007ead:     	movq	%rbx, 0x70(%rsp)
180007eb2:     	movq	%r13, 0x68(%rsp)
180007eb7:     	movq	0x270(%rsp), %rax
180007ebf:     	movq	%rax, 0x60(%rsp)
180007ec4:     	movq	0x268(%rsp), %rax
180007ecc:     	movq	%rax, 0x58(%rsp)
180007ed1:     	movq	0x260(%rsp), %rax
180007ed9:     	movq	%rax, 0x50(%rsp)
180007ede:     	movq	0x258(%rsp), %rax
180007ee6:     	movq	%rax, 0x48(%rsp)
180007eeb:     	movq	0x250(%rsp), %rax
180007ef3:     	movq	%rax, 0x40(%rsp)
180007ef8:     	movq	0x248(%rsp), %rax
180007f00:     	movq	%rax, 0x38(%rsp)
180007f05:     	movq	%rbp, 0x30(%rsp)
180007f0a:     	movq	0x238(%rsp), %rax
180007f12:     	movq	%rax, 0x28(%rsp)
180007f17:     	movq	0x230(%rsp), %rax
180007f1f:     	movq	%rax, 0x20(%rsp)
180007f24:     	movq	$-0x1, 0x108(%rsp)
180007f30:     	movq	$0x0, 0xf0(%rsp)
180007f3c:     	leaq	0x11d(%rsp), %rcx
180007f44:     	leaq	0x190(%rsp), %rdx
180007f4c:     	movq	0x130(%rsp), %r8
180007f54:     	movq	0x138(%rsp), %r9
180007f5c:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
180007f61:     	testl	%eax, %eax
180007f63:     	jne	0x180008367 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4887>
180007f69:     	cmpb	$0x0, (%r15)
180007f6d:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180007f73:     	movzbl	0x11d(%rsp), %eax
180007f7b:     	movq	0x8(%r12), %rcx
180007f80:     	leaq	-0x1(%rcx), %rdx
180007f84:     	movq	%rdx, 0x8(%r12)
180007f89:     	testb	$0x1, %al
180007f8b:     	jne	0x180007d59 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4279>
180007f91:     	movq	0x40(%r13,%rsi,8), %rax
180007f96:     	testq	%rax, %rax
180007f99:     	js	0x180007fab <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x44cb>
180007f9b:     	movq	%rcx, 0x8(%r12)
180007fa0:     	cmpq	0x10(%r12), %rcx
180007fa5:     	jle	0x180008083 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x45a3>
180007fab:     	movb	$0x1, (%r15)
180007faf:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
180007fb8:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180007fbd:     	movb	$0x1, (%r15)
180007fc1:     	movq	$0x6acfc2, 0x18(%r12)   # imm = 0x6ACFC2
180007fca:     	cmpb	$0x0, (%r15)
180007fce:     	movq	0x110(%rsp), %rcx
180007fd6:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
180007fdc:     	movq	%r10, 0x10(%r11)
180007fe0:     	movq	0x140(%rsp), %rax
180007fe8:     	movq	$0x0, 0x48(%rbp,%rax,8)
180007ff1:     	movq	$-0x1, 0x28(%r11)
180007ff9:     	movq	$-0x1, 0x20(%r11)
180008001:     	movq	$-0x1, 0x38(%r11)
180008009:     	movq	$-0x1, 0x40(%r11)
180008011:     	cmpb	$0x0, (%r15)
180008015:     	jne	0x1800077bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3cdb>
18000801b:     	movq	0x140(%rsp), %rax
180008023:     	movq	%rax, 0x20(%r13,%rsi,8)
180008028:     	movq	(%r12), %rcx
18000802c:     	leaq	0x4(%rcx), %rax
180008030:     	cmpq	%rbx, %rax
180008033:     	jle	0x18000804b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x456b>
180008035:     	movb	$0x2, (%r15)
180008039:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000803e:     	movq	0x198(%rsp), %rdx
180008046:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
18000804b:     	movq	%rax, (%r12)
18000804f:     	cmpb	$0x0, (%r15)
180008053:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008059:     	subsd	%xmm3, %xmm1
18000805d:     	testq	%rcx, %rcx
180008060:     	js	0x180008260 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4780>
180008066:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
18000806c:     	movsd	%xmm5, 0x18(%rbp,%rcx,8)
180008072:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008078:     	movsd	%xmm0, (%rbp,%rcx,8)
18000807e:     	jmp	0x18000826d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x478d>
180008083:     	movb	$0x0, 0x11c(%rsp)
18000808b:     	movq	0x310(%rsp), %rcx
180008093:     	movq	%rcx, 0x100(%rsp)
18000809b:     	movq	%rax, 0xf8(%rsp)
1800080a3:     	movq	0x2f8(%rsp), %rax
1800080ab:     	movq	%rax, 0xe8(%rsp)
1800080b3:     	movq	0x2f0(%rsp), %rax
1800080bb:     	movq	%rax, 0xe0(%rsp)
1800080c3:     	movq	0x2e0(%rsp), %rax
1800080cb:     	movq	%rax, 0xd0(%rsp)
1800080d3:     	movq	0x2d8(%rsp), %rax
1800080db:     	movq	%rax, 0xc8(%rsp)
1800080e3:     	movq	0x2d0(%rsp), %rax
1800080eb:     	movq	%rax, 0xc0(%rsp)
1800080f3:     	movq	0x2c8(%rsp), %rax
1800080fb:     	movq	%rax, 0xb8(%rsp)
180008103:     	movq	0x2c0(%rsp), %rax
18000810b:     	movq	%rax, 0xb0(%rsp)
180008113:     	movq	0x2b8(%rsp), %rax
18000811b:     	movq	%rax, 0xa8(%rsp)
180008123:     	movq	0x2a8(%rsp), %rax
18000812b:     	movq	%rax, 0x98(%rsp)
180008133:     	movq	0x2a0(%rsp), %rax
18000813b:     	movq	%rax, 0x90(%rsp)
180008143:     	movq	0x298(%rsp), %rax
18000814b:     	movq	%rax, 0x88(%rsp)
180008153:     	movq	0x290(%rsp), %rax
18000815b:     	movq	%rax, 0x80(%rsp)
180008163:     	movq	0x288(%rsp), %rax
18000816b:     	movq	%rax, 0x78(%rsp)
180008170:     	movq	%rbx, 0x70(%rsp)
180008175:     	movq	%r13, 0x68(%rsp)
18000817a:     	movq	0x270(%rsp), %rax
180008182:     	movq	%rax, 0x60(%rsp)
180008187:     	movq	0x268(%rsp), %rax
18000818f:     	movq	%rax, 0x58(%rsp)
180008194:     	movq	0x260(%rsp), %rax
18000819c:     	movq	%rax, 0x50(%rsp)
1800081a1:     	movq	0x258(%rsp), %rax
1800081a9:     	movq	%rax, 0x48(%rsp)
1800081ae:     	movq	0x250(%rsp), %rax
1800081b6:     	movq	%rax, 0x40(%rsp)
1800081bb:     	movq	0x248(%rsp), %rax
1800081c3:     	movq	%rax, 0x38(%rsp)
1800081c8:     	movq	%rbp, 0x30(%rsp)
1800081cd:     	movq	%r15, 0xd8(%rsp)
1800081d5:     	movq	%r12, 0xa0(%rsp)
1800081dd:     	movq	0x238(%rsp), %rax
1800081e5:     	movq	%rax, 0x28(%rsp)
1800081ea:     	movq	0x230(%rsp), %rax
1800081f2:     	movq	%rax, 0x20(%rsp)
1800081f7:     	movq	$-0x1, 0x108(%rsp)
180008203:     	movq	$0x0, 0xf0(%rsp)
18000820f:     	leaq	0x11c(%rsp), %rcx
180008217:     	leaq	0x188(%rsp), %rdx
18000821f:     	movq	0x130(%rsp), %r8
180008227:     	movq	0x138(%rsp), %r9
18000822f:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
180008234:     	testl	%eax, %eax
180008236:     	jne	0x180008374 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4894>
18000823c:     	cmpb	$0x0, (%r15)
180008240:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008246:     	movzbl	0x11c(%rsp), %eax
18000824e:     	decq	0x8(%r12)
180008253:     	testb	$0x1, %al
180008255:     	je	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000825b:     	jmp	0x180007d59 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4279>
180008260:     	movb	$0x1, (%r15)
180008264:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
18000826d:     	cmpb	$0x0, (%r15)
180008271:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008277:     	movq	(%r12), %rax
18000827b:     	leaq	0xa(%rax), %r8
18000827f:     	cmpq	%rbx, %r8
180008282:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
180008288:     	movq	0x8(%r13,%rsi,8), %rdx
18000828d:     	movq	%r8, (%r12)
180008291:     	cmpb	$0x0, (%r15)
180008295:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000829b:     	movq	%rcx, (%r13,%rax,8)
1800082a0:     	movq	%rdx, 0x8(%r13,%rax,8)
1800082a5:     	movq	(%r12), %rcx
1800082a9:     	cmpq	%rbx, %rcx
1800082ac:     	movq	%rcx, %rdx
1800082af:     	jle	0x1800082bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x47db>
1800082b1:     	movb	$0x2, (%r15)
1800082b5:     	movq	(%r12), %rcx
1800082b9:     	xorl	%edx, %edx
1800082bb:     	leaq	0x3(%rcx), %r8
1800082bf:     	cmpq	%rbx, %r8
1800082c2:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
1800082c8:     	movq	%r8, (%r12)
1800082cc:     	cmpb	$0x0, (%r15)
1800082d0:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800082d6:     	movq	%rcx, %r8
1800082d9:     	sarq	$0x3f, %r8
1800082dd:     	andq	%rbx, %r8
1800082e0:     	leaq	(%r13,%rcx,8), %r9
1800082e5:     	movq	$0x0, (%r9,%r8,8)
1800082ed:     	xorl	%r8d, %r8d
1800082f0:     	cmpq	$-0x1, %rcx
1800082f4:     	movl	$0x0, %r10d
1800082fa:     	cmovlq	%rbx, %r10
1800082fe:     	movq	$0x0, 0x8(%r9,%r10,8)
180008307:     	cmpq	$-0x2, %rcx
18000830b:     	cmovlq	%rbx, %r8
18000830f:     	movq	%rdx, 0x10(%r9,%r8,8)
180008314:     	cmpb	$0x0, (%r15)
180008318:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000831e:     	leaq	(%r13,%rax,8), %rdx
180008323:     	movq	%rcx, 0x30(%rdx)
180008327:     	movq	$0x0, 0x18(%rdx)
18000832f:     	movq	(%r12), %rcx
180008333:     	leaq	0x2(%rcx), %r8
180008337:     	cmpq	%rbx, %r8
18000833a:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
180008340:     	movq	%r8, (%r12)
180008344:     	cmpb	$0x0, (%r15)
180008348:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000834e:     	testq	%rcx, %rcx
180008351:     	js	0x180008381 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x48a1>
180008353:     	movq	$0x0, 0x8(%rbp,%rcx,8)
18000835c:     	movq	$0x0, (%rbp,%rcx,8)
180008365:     	jmp	0x18000838e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x48ae>
180008367:     	movq	0x190(%rsp), %rdx
18000836f:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
180008374:     	movq	0x188(%rsp), %rdx
18000837c:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
180008381:     	movb	$0x1, (%r15)
180008385:     	movq	$0x6acfc2, 0x18(%r12)   # imm = 0x6ACFC2
18000838e:     	cmpb	$0x0, (%r15)
180008392:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008398:     	movq	%rcx, 0x10(%rdx)
18000839c:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800083a5:     	movq	$-0x1, 0x28(%rdx)
1800083ad:     	movq	$-0x1, 0x20(%rdx)
1800083b5:     	movq	$-0x1, 0x38(%rdx)
1800083bd:     	movq	$-0x1, 0x40(%rdx)
1800083c5:     	cmpb	$0x0, (%r15)
1800083c9:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800083cf:     	movq	%rax, 0x28(%r13,%rsi,8)
1800083d4:     	movq	(%r12), %rcx
1800083d8:     	leaq	0x4(%rcx), %rax
1800083dc:     	cmpq	%rbx, %rax
1800083df:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
1800083e5:     	movq	%rax, (%r12)
1800083e9:     	cmpb	$0x0, (%r15)
1800083ed:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800083f3:     	addsd	%xmm0, %xmm2
1800083f7:     	testq	%rcx, %rcx
1800083fa:     	js	0x180008416 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4936>
1800083fc:     	movsd	%xmm4, 0x10(%rbp,%rcx,8)
180008402:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008408:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
18000840e:     	movsd	%xmm0, (%rbp,%rcx,8)
180008414:     	jmp	0x180008423 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4943>
180008416:     	movb	$0x1, (%r15)
18000841a:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008423:     	cmpb	$0x0, (%r15)
180008427:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000842d:     	movq	(%r12), %rax
180008431:     	leaq	0xa(%rax), %r8
180008435:     	cmpq	%rbx, %r8
180008438:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
18000843e:     	movq	0x8(%r13,%rsi,8), %rdx
180008443:     	movq	%r8, (%r12)
180008447:     	cmpb	$0x0, (%r15)
18000844b:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008451:     	movq	%rcx, (%r13,%rax,8)
180008456:     	movq	%rdx, 0x8(%r13,%rax,8)
18000845b:     	movq	(%r12), %rcx
18000845f:     	cmpq	%rbx, %rcx
180008462:     	movq	%rcx, %rdx
180008465:     	jle	0x180008471 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4991>
180008467:     	movb	$0x2, (%r15)
18000846b:     	movq	(%r12), %rcx
18000846f:     	xorl	%edx, %edx
180008471:     	leaq	0x3(%rcx), %r8
180008475:     	cmpq	%rbx, %r8
180008478:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
18000847e:     	movq	%r8, (%r12)
180008482:     	cmpb	$0x0, (%r15)
180008486:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000848c:     	movq	%rcx, %r8
18000848f:     	sarq	$0x3f, %r8
180008493:     	andq	%rbx, %r8
180008496:     	leaq	(%r13,%rcx,8), %r9
18000849b:     	movq	$0x0, (%r9,%r8,8)
1800084a3:     	xorl	%r8d, %r8d
1800084a6:     	cmpq	$-0x1, %rcx
1800084aa:     	movl	$0x0, %r10d
1800084b0:     	cmovlq	%rbx, %r10
1800084b4:     	movq	$0x0, 0x8(%r9,%r10,8)
1800084bd:     	cmpq	$-0x2, %rcx
1800084c1:     	cmovlq	%rbx, %r8
1800084c5:     	movq	%rdx, 0x10(%r9,%r8,8)
1800084ca:     	cmpb	$0x0, (%r15)
1800084ce:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800084d4:     	leaq	(%r13,%rax,8), %rdx
1800084d9:     	movq	%rcx, 0x30(%rdx)
1800084dd:     	movq	$0x0, 0x18(%rdx)
1800084e5:     	movq	(%r12), %rcx
1800084e9:     	leaq	0x2(%rcx), %r8
1800084ed:     	cmpq	%rbx, %r8
1800084f0:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
1800084f6:     	movq	%r8, (%r12)
1800084fa:     	cmpb	$0x0, (%r15)
1800084fe:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008504:     	testq	%rcx, %rcx
180008507:     	js	0x18000851d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4a3d>
180008509:     	movq	$0x0, 0x8(%rbp,%rcx,8)
180008512:     	movq	$0x0, (%rbp,%rcx,8)
18000851b:     	jmp	0x18000852a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4a4a>
18000851d:     	movb	$0x1, (%r15)
180008521:     	movq	$0x6acfc2, 0x18(%r12)   # imm = 0x6ACFC2
18000852a:     	cmpb	$0x0, (%r15)
18000852e:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008534:     	movq	%rcx, 0x10(%rdx)
180008538:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008541:     	movq	$-0x1, 0x28(%rdx)
180008549:     	movq	$-0x1, 0x20(%rdx)
180008551:     	movq	$-0x1, 0x38(%rdx)
180008559:     	movq	$-0x1, 0x40(%rdx)
180008561:     	cmpb	$0x0, (%r15)
180008565:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000856b:     	movq	%rax, 0x38(%r13,%rsi,8)
180008570:     	movq	(%r12), %rcx
180008574:     	leaq	0x4(%rcx), %rax
180008578:     	cmpq	%rbx, %rax
18000857b:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
180008581:     	movq	%rax, (%r12)
180008585:     	cmpb	$0x0, (%r15)
180008589:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000858f:     	testq	%rcx, %rcx
180008592:     	js	0x1800085ae <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4ace>
180008594:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
18000859a:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
1800085a0:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
1800085a6:     	movsd	%xmm0, (%rbp,%rcx,8)
1800085ac:     	jmp	0x1800085bb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4adb>
1800085ae:     	movb	$0x1, (%r15)
1800085b2:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800085bb:     	cmpb	$0x0, (%r15)
1800085bf:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800085c5:     	movq	(%r12), %rax
1800085c9:     	leaq	0xa(%rax), %r8
1800085cd:     	cmpq	%rbx, %r8
1800085d0:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
1800085d6:     	movq	0x8(%r13,%rsi,8), %rdx
1800085db:     	movq	%r8, (%r12)
1800085df:     	cmpb	$0x0, (%r15)
1800085e3:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800085e9:     	movq	%rcx, (%r13,%rax,8)
1800085ee:     	movq	%rdx, 0x8(%r13,%rax,8)
1800085f3:     	movq	(%r12), %rcx
1800085f7:     	cmpq	%rbx, %rcx
1800085fa:     	movq	%rcx, %rdx
1800085fd:     	jle	0x180008609 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4b29>
1800085ff:     	movb	$0x2, (%r15)
180008603:     	movq	(%r12), %rcx
180008607:     	xorl	%edx, %edx
180008609:     	leaq	0x3(%rcx), %r8
18000860d:     	cmpq	%rbx, %r8
180008610:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
180008616:     	movq	%r8, (%r12)
18000861a:     	cmpb	$0x0, (%r15)
18000861e:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008624:     	movq	%rcx, %r8
180008627:     	sarq	$0x3f, %r8
18000862b:     	andq	%rbx, %r8
18000862e:     	leaq	(%r13,%rcx,8), %r9
180008633:     	movq	$0x0, (%r9,%r8,8)
18000863b:     	xorl	%r8d, %r8d
18000863e:     	cmpq	$-0x1, %rcx
180008642:     	movl	$0x0, %r10d
180008648:     	cmovlq	%rbx, %r10
18000864c:     	movq	$0x0, 0x8(%r9,%r10,8)
180008655:     	cmpq	$-0x2, %rcx
180008659:     	cmovlq	%rbx, %r8
18000865d:     	movq	%rdx, 0x10(%r9,%r8,8)
180008662:     	cmpb	$0x0, (%r15)
180008666:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000866c:     	leaq	(%r13,%rax,8), %rdx
180008671:     	movq	%rcx, 0x30(%rdx)
180008675:     	movq	$0x0, 0x18(%rdx)
18000867d:     	movq	(%r12), %rcx
180008681:     	leaq	0x2(%rcx), %r8
180008685:     	cmpq	%rbx, %r8
180008688:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
18000868e:     	movq	%r8, (%r12)
180008692:     	cmpb	$0x0, (%r15)
180008696:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000869c:     	testq	%rcx, %rcx
18000869f:     	js	0x1800086b5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4bd5>
1800086a1:     	movq	$0x0, 0x8(%rbp,%rcx,8)
1800086aa:     	movq	$0x0, (%rbp,%rcx,8)
1800086b3:     	jmp	0x1800086c2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4be2>
1800086b5:     	movb	$0x1, (%r15)
1800086b9:     	movq	$0x6acfc2, 0x18(%r12)   # imm = 0x6ACFC2
1800086c2:     	cmpb	$0x0, (%r15)
1800086c6:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
1800086cc:     	movq	%rcx, 0x10(%rdx)
1800086d0:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800086d9:     	movq	$-0x1, 0x28(%rdx)
1800086e1:     	movq	$-0x1, 0x20(%rdx)
1800086e9:     	movq	$-0x1, 0x38(%rdx)
1800086f1:     	movq	$-0x1, 0x40(%rdx)
1800086f9:     	cmpb	$0x0, (%r15)
1800086fd:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008703:     	movq	%rax, 0x40(%r13,%rsi,8)
180008708:     	movq	$0x1, 0x18(%r13,%rsi,8)
180008711:     	movq	0x30(%r13,%rsi,8), %rax
180008716:     	movq	%rax, %rcx
180008719:     	sarq	$0x3f, %rcx
18000871d:     	andq	%rbx, %rcx
180008720:     	leaq	(%r13,%rax,8), %rdx
180008725:     	movq	%rcx, 0x160(%rsp)
18000872d:     	movq	%rdx, 0x150(%rsp)
180008735:     	cmpq	$0x0, (%rdx,%rcx,8)
18000873a:     	jle	0x180008f25 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5445>
180008740:     	leaq	(,%rbx,8), %rcx
180008748:     	xorl	%edx, %edx
18000874a:     	cmpq	$-0x2, %rax
18000874e:     	movl	$0x0, %eax
180008753:     	movq	%rax, 0x148(%rsp)
18000875b:     	cmovgeq	%rdx, %rcx
18000875f:     	movq	%rcx, 0x158(%rsp)
180008767:     	movq	0x20(%r13,%rsi,8), %rax
18000876c:     	testq	%rax, %rax
18000876f:     	js	0x180008fb2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x54d2>
180008775:     	movq	0x150(%rsp), %rcx
18000877d:     	movq	0x158(%rsp), %rdx
180008785:     	movq	0x10(%rcx,%rdx), %rcx
18000878a:     	addq	0x148(%rsp), %rcx
180008792:     	leaq	(%r13,%rcx,8), %rdx
180008797:     	sarq	$0x3f, %rcx
18000879b:     	andq	%rbx, %rcx
18000879e:     	movq	(%rdx,%rcx,8), %rcx
1800087a2:     	movq	%rcx, 0x140(%rsp)
1800087aa:     	movq	0x8(%r12), %rcx
1800087af:     	leaq	0x1(%rcx), %rdx
1800087b3:     	movq	%rdx, 0x8(%r12)
1800087b8:     	cmpq	0x10(%r12), %rcx
1800087bd:     	jge	0x180008fb2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x54d2>
1800087c3:     	movq	0x140(%rsp), %rcx
1800087cb:     	movq	%rcx, 0x100(%rsp)
1800087d3:     	movq	%rax, 0xf8(%rsp)
1800087db:     	movq	0x2f8(%rsp), %rax
1800087e3:     	movq	%rax, 0xe8(%rsp)
1800087eb:     	movq	0x2f0(%rsp), %rax
1800087f3:     	movq	%rax, 0xe0(%rsp)
1800087fb:     	movq	%r15, 0xd8(%rsp)
180008803:     	movq	0x2e0(%rsp), %rax
18000880b:     	movq	%rax, 0xd0(%rsp)
180008813:     	movq	0x2d8(%rsp), %rax
18000881b:     	movq	%rax, 0xc8(%rsp)
180008823:     	movq	0x2d0(%rsp), %rax
18000882b:     	movq	%rax, 0xc0(%rsp)
180008833:     	movq	0x2c8(%rsp), %rax
18000883b:     	movq	%rax, 0xb8(%rsp)
180008843:     	movq	0x2c0(%rsp), %rax
18000884b:     	movq	%rax, 0xb0(%rsp)
180008853:     	movq	0x2b8(%rsp), %rax
18000885b:     	movq	%rax, 0xa8(%rsp)
180008863:     	movq	%r12, 0xa0(%rsp)
18000886b:     	movq	0x2a8(%rsp), %rax
180008873:     	movq	%rax, 0x98(%rsp)
18000887b:     	movq	0x2a0(%rsp), %rax
180008883:     	movq	%rax, 0x90(%rsp)
18000888b:     	movq	0x298(%rsp), %rax
180008893:     	movq	%rax, 0x88(%rsp)
18000889b:     	movq	0x290(%rsp), %rax
1800088a3:     	movq	%rax, 0x80(%rsp)
1800088ab:     	movq	0x288(%rsp), %rax
1800088b3:     	movq	%rax, 0x78(%rsp)
1800088b8:     	movq	%rbx, 0x70(%rsp)
1800088bd:     	movq	%r13, 0x68(%rsp)
1800088c2:     	movq	0x270(%rsp), %rax
1800088ca:     	movq	%rax, 0x60(%rsp)
1800088cf:     	movq	0x268(%rsp), %rax
1800088d7:     	movq	%rax, 0x58(%rsp)
1800088dc:     	movq	0x260(%rsp), %rax
1800088e4:     	movq	%rax, 0x50(%rsp)
1800088e9:     	movq	%rdi, 0x48(%rsp)
1800088ee:     	movq	0x250(%rsp), %rax
1800088f6:     	movq	%rax, 0x40(%rsp)
1800088fb:     	movq	%r14, 0x38(%rsp)
180008900:     	movq	%rbp, 0x30(%rsp)
180008905:     	movq	0x238(%rsp), %rax
18000890d:     	movq	%rax, 0x28(%rsp)
180008912:     	movq	0x230(%rsp), %rax
18000891a:     	movq	%rax, 0x20(%rsp)
18000891f:     	movq	$-0x1, 0x108(%rsp)
18000892b:     	movq	$0x0, 0xf0(%rsp)
180008937:     	leaq	0x12e(%rsp), %rcx
18000893f:     	leaq	0x180(%rsp), %rdx
180008947:     	movq	0x130(%rsp), %r8
18000894f:     	movq	0x138(%rsp), %r9
180008957:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
18000895c:     	testl	%eax, %eax
18000895e:     	jne	0x180008fc4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x54e4>
180008964:     	cmpb	$0x0, (%r15)
180008968:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
18000896e:     	movq	0x8(%r12), %rcx
180008973:     	leaq	-0x1(%rcx), %rax
180008977:     	movq	%rax, 0x8(%r12)
18000897c:     	movq	0x28(%r13,%rsi,8), %rax
180008981:     	testq	%rax, %rax
180008984:     	js	0x180008fd1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x54f1>
18000898a:     	movq	%rcx, 0x8(%r12)
18000898f:     	cmpq	0x10(%r12), %rcx
180008994:     	jg	0x180008fd1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x54f1>
18000899a:     	movq	0x140(%rsp), %rcx
1800089a2:     	movq	%rcx, 0x100(%rsp)
1800089aa:     	movq	%rax, 0xf8(%rsp)
1800089b2:     	movq	0x2f8(%rsp), %rax
1800089ba:     	movq	%rax, 0xe8(%rsp)
1800089c2:     	movq	0x2f0(%rsp), %rax
1800089ca:     	movq	%rax, 0xe0(%rsp)
1800089d2:     	movq	%r15, 0xd8(%rsp)
1800089da:     	movq	0x2e0(%rsp), %rax
1800089e2:     	movq	%rax, 0xd0(%rsp)
1800089ea:     	movq	0x2d8(%rsp), %rax
1800089f2:     	movq	%rax, 0xc8(%rsp)
1800089fa:     	movq	0x2d0(%rsp), %rax
180008a02:     	movq	%rax, 0xc0(%rsp)
180008a0a:     	movq	0x2c8(%rsp), %rax
180008a12:     	movq	%rax, 0xb8(%rsp)
180008a1a:     	movq	0x2c0(%rsp), %rax
180008a22:     	movq	%rax, 0xb0(%rsp)
180008a2a:     	movq	0x2b8(%rsp), %rax
180008a32:     	movq	%rax, 0xa8(%rsp)
180008a3a:     	movq	%r12, 0xa0(%rsp)
180008a42:     	movq	0x2a8(%rsp), %rax
180008a4a:     	movq	%rax, 0x98(%rsp)
180008a52:     	movq	0x2a0(%rsp), %rax
180008a5a:     	movq	%rax, 0x90(%rsp)
180008a62:     	movq	0x298(%rsp), %rax
180008a6a:     	movq	%rax, 0x88(%rsp)
180008a72:     	movq	0x290(%rsp), %rax
180008a7a:     	movq	%rax, 0x80(%rsp)
180008a82:     	movq	0x288(%rsp), %rax
180008a8a:     	movq	%rax, 0x78(%rsp)
180008a8f:     	movq	%rbx, 0x70(%rsp)
180008a94:     	movq	%r13, 0x68(%rsp)
180008a99:     	movq	0x270(%rsp), %rax
180008aa1:     	movq	%rax, 0x60(%rsp)
180008aa6:     	movq	0x268(%rsp), %rax
180008aae:     	movq	%rax, 0x58(%rsp)
180008ab3:     	movq	0x260(%rsp), %rax
180008abb:     	movq	%rax, 0x50(%rsp)
180008ac0:     	movq	%rdi, 0x48(%rsp)
180008ac5:     	movq	0x250(%rsp), %rax
180008acd:     	movq	%rax, 0x40(%rsp)
180008ad2:     	movq	%r14, 0x38(%rsp)
180008ad7:     	movq	%rbp, 0x30(%rsp)
180008adc:     	movq	0x238(%rsp), %rax
180008ae4:     	movq	%rax, 0x28(%rsp)
180008ae9:     	movq	0x230(%rsp), %rax
180008af1:     	movq	%rax, 0x20(%rsp)
180008af6:     	movq	$-0x1, 0x108(%rsp)
180008b02:     	movq	$0x0, 0xf0(%rsp)
180008b0e:     	leaq	0x12d(%rsp), %rcx
180008b16:     	leaq	0x178(%rsp), %rdx
180008b1e:     	movq	0x130(%rsp), %r8
180008b26:     	movq	0x138(%rsp), %r9
180008b2e:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
180008b33:     	testl	%eax, %eax
180008b35:     	jne	0x180008fe3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5503>
180008b3b:     	cmpb	$0x0, (%r15)
180008b3f:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008b45:     	movq	0x8(%r12), %rcx
180008b4a:     	leaq	-0x1(%rcx), %rax
180008b4e:     	movq	%rax, 0x8(%r12)
180008b53:     	movq	0x38(%r13,%rsi,8), %rax
180008b58:     	testq	%rax, %rax
180008b5b:     	js	0x180008ff0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5510>
180008b61:     	movq	%rcx, 0x8(%r12)
180008b66:     	cmpq	0x10(%r12), %rcx
180008b6b:     	jg	0x180008ff0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5510>
180008b71:     	movq	0x140(%rsp), %rcx
180008b79:     	movq	%rcx, 0x100(%rsp)
180008b81:     	movq	%rax, 0xf8(%rsp)
180008b89:     	movq	0x2f8(%rsp), %rax
180008b91:     	movq	%rax, 0xe8(%rsp)
180008b99:     	movq	0x2f0(%rsp), %rax
180008ba1:     	movq	%rax, 0xe0(%rsp)
180008ba9:     	movq	%r15, 0xd8(%rsp)
180008bb1:     	movq	0x2e0(%rsp), %rax
180008bb9:     	movq	%rax, 0xd0(%rsp)
180008bc1:     	movq	0x2d8(%rsp), %rax
180008bc9:     	movq	%rax, 0xc8(%rsp)
180008bd1:     	movq	0x2d0(%rsp), %rax
180008bd9:     	movq	%rax, 0xc0(%rsp)
180008be1:     	movq	0x2c8(%rsp), %rax
180008be9:     	movq	%rax, 0xb8(%rsp)
180008bf1:     	movq	0x2c0(%rsp), %rax
180008bf9:     	movq	%rax, 0xb0(%rsp)
180008c01:     	movq	0x2b8(%rsp), %rax
180008c09:     	movq	%rax, 0xa8(%rsp)
180008c11:     	movq	%r12, 0xa0(%rsp)
180008c19:     	movq	0x2a8(%rsp), %rax
180008c21:     	movq	%rax, 0x98(%rsp)
180008c29:     	movq	0x2a0(%rsp), %rax
180008c31:     	movq	%rax, 0x90(%rsp)
180008c39:     	movq	0x298(%rsp), %rax
180008c41:     	movq	%rax, 0x88(%rsp)
180008c49:     	movq	0x290(%rsp), %rax
180008c51:     	movq	%rax, 0x80(%rsp)
180008c59:     	movq	0x288(%rsp), %rax
180008c61:     	movq	%rax, 0x78(%rsp)
180008c66:     	movq	%rbx, 0x70(%rsp)
180008c6b:     	movq	%r13, 0x68(%rsp)
180008c70:     	movq	0x270(%rsp), %rax
180008c78:     	movq	%rax, 0x60(%rsp)
180008c7d:     	movq	0x268(%rsp), %rax
180008c85:     	movq	%rax, 0x58(%rsp)
180008c8a:     	movq	0x260(%rsp), %rax
180008c92:     	movq	%rax, 0x50(%rsp)
180008c97:     	movq	%rdi, 0x48(%rsp)
180008c9c:     	movq	0x250(%rsp), %rax
180008ca4:     	movq	%rax, 0x40(%rsp)
180008ca9:     	movq	%r14, 0x38(%rsp)
180008cae:     	movq	%rbp, 0x30(%rsp)
180008cb3:     	movq	0x238(%rsp), %rax
180008cbb:     	movq	%rax, 0x28(%rsp)
180008cc0:     	movq	0x230(%rsp), %rax
180008cc8:     	movq	%rax, 0x20(%rsp)
180008ccd:     	movq	$-0x1, 0x108(%rsp)
180008cd9:     	movq	$0x0, 0xf0(%rsp)
180008ce5:     	leaq	0x12c(%rsp), %rcx
180008ced:     	leaq	0x170(%rsp), %rdx
180008cf5:     	movq	0x130(%rsp), %r8
180008cfd:     	movq	0x138(%rsp), %r9
180008d05:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
180008d0a:     	testl	%eax, %eax
180008d0c:     	jne	0x180009002 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5522>
180008d12:     	cmpb	$0x0, (%r15)
180008d16:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008d1c:     	movq	0x8(%r12), %rcx
180008d21:     	leaq	-0x1(%rcx), %rax
180008d25:     	movq	%rax, 0x8(%r12)
180008d2a:     	movq	0x40(%r13,%rsi,8), %rax
180008d2f:     	testq	%rax, %rax
180008d32:     	js	0x18000900f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x552f>
180008d38:     	movq	%rcx, 0x8(%r12)
180008d3d:     	cmpq	0x10(%r12), %rcx
180008d42:     	jg	0x18000900f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x552f>
180008d48:     	movq	0x140(%rsp), %rcx
180008d50:     	movq	%rcx, 0x100(%rsp)
180008d58:     	movq	%rax, 0xf8(%rsp)
180008d60:     	movq	0x2f8(%rsp), %rax
180008d68:     	movq	%rax, 0xe8(%rsp)
180008d70:     	movq	0x2f0(%rsp), %rax
180008d78:     	movq	%rax, 0xe0(%rsp)
180008d80:     	movq	%r15, 0xd8(%rsp)
180008d88:     	movq	0x2e0(%rsp), %rax
180008d90:     	movq	%rax, 0xd0(%rsp)
180008d98:     	movq	0x2d8(%rsp), %rax
180008da0:     	movq	%rax, 0xc8(%rsp)
180008da8:     	movq	0x2d0(%rsp), %rax
180008db0:     	movq	%rax, 0xc0(%rsp)
180008db8:     	movq	0x2c8(%rsp), %rax
180008dc0:     	movq	%rax, 0xb8(%rsp)
180008dc8:     	movq	0x2c0(%rsp), %rax
180008dd0:     	movq	%rax, 0xb0(%rsp)
180008dd8:     	movq	0x2b8(%rsp), %rax
180008de0:     	movq	%rax, 0xa8(%rsp)
180008de8:     	movq	%r12, 0xa0(%rsp)
180008df0:     	movq	0x2a8(%rsp), %rax
180008df8:     	movq	%rax, 0x98(%rsp)
180008e00:     	movq	0x2a0(%rsp), %rax
180008e08:     	movq	%rax, 0x90(%rsp)
180008e10:     	movq	0x298(%rsp), %rax
180008e18:     	movq	%rax, 0x88(%rsp)
180008e20:     	movq	0x290(%rsp), %rax
180008e28:     	movq	%rax, 0x80(%rsp)
180008e30:     	movq	0x288(%rsp), %rax
180008e38:     	movq	%rax, 0x78(%rsp)
180008e3d:     	movq	%rbx, 0x70(%rsp)
180008e42:     	movq	%r13, 0x68(%rsp)
180008e47:     	movq	0x270(%rsp), %rax
180008e4f:     	movq	%rax, 0x60(%rsp)
180008e54:     	movq	0x268(%rsp), %rax
180008e5c:     	movq	%rax, 0x58(%rsp)
180008e61:     	movq	0x260(%rsp), %rax
180008e69:     	movq	%rax, 0x50(%rsp)
180008e6e:     	movq	%rdi, 0x48(%rsp)
180008e73:     	movq	0x250(%rsp), %rax
180008e7b:     	movq	%rax, 0x40(%rsp)
180008e80:     	movq	%r14, 0x38(%rsp)
180008e85:     	movq	%rbp, 0x30(%rsp)
180008e8a:     	movq	0x238(%rsp), %rax
180008e92:     	movq	%rax, 0x28(%rsp)
180008e97:     	movq	0x230(%rsp), %rax
180008e9f:     	movq	%rax, 0x20(%rsp)
180008ea4:     	movq	$-0x1, 0x108(%rsp)
180008eb0:     	movq	$0x0, 0xf0(%rsp)
180008ebc:     	leaq	0x12b(%rsp), %rcx
180008ec4:     	leaq	0x168(%rsp), %rdx
180008ecc:     	movq	0x130(%rsp), %r8
180008ed4:     	movq	0x138(%rsp), %r9
180008edc:     	callq	0x180006e50 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3370>
180008ee1:     	testl	%eax, %eax
180008ee3:     	jne	0x180009021 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5541>
180008ee9:     	cmpb	$0x0, (%r15)
180008eed:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008ef3:     	movq	0x148(%rsp), %r8
180008efb:     	incq	%r8
180008efe:     	decq	0x8(%r12)
180008f03:     	movq	0x160(%rsp), %rax
180008f0b:     	movq	0x150(%rsp), %rcx
180008f13:     	movq	%r8, 0x148(%rsp)
180008f1b:     	cmpq	(%rcx,%rax,8), %r8
180008f1f:     	jl	0x180008767 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4c87>
180008f25:     	movq	(%r12), %rcx
180008f29:     	cmpq	%rbx, %rcx
180008f2c:     	movq	%rcx, %rdx
180008f2f:     	jle	0x180008f3b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x545b>
180008f31:     	movb	$0x2, (%r15)
180008f35:     	movq	(%r12), %rcx
180008f39:     	xorl	%edx, %edx
180008f3b:     	leaq	0x3(%rcx), %rax
180008f3f:     	cmpq	%rbx, %rax
180008f42:     	jg	0x180008035 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x4555>
180008f48:     	movq	%rax, (%r12)
180008f4c:     	cmpb	$0x0, (%r15)
180008f50:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008f56:     	movq	%rcx, %rax
180008f59:     	sarq	$0x3f, %rax
180008f5d:     	andq	%rbx, %rax
180008f60:     	leaq	(%r13,%rcx,8), %r8
180008f65:     	movq	$0x0, (%r8,%rax,8)
180008f6d:     	xorl	%eax, %eax
180008f6f:     	cmpq	$-0x1, %rcx
180008f73:     	movl	$0x0, %r9d
180008f79:     	cmovlq	%rbx, %r9
180008f7d:     	movq	$0x0, 0x8(%r8,%r9,8)
180008f86:     	cmpq	$-0x2, %rcx
180008f8a:     	cmovgeq	%rax, %rbx
180008f8e:     	movq	%rdx, 0x10(%r8,%rbx,8)
180008f93:     	cmpb	$0x0, (%r15)
180008f97:     	jne	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008f9d:     	movq	%rcx, 0x30(%r13,%rsi,8)
180008fa2:     	movq	0x110(%rsp), %rcx
180008faa:     	movb	$0x0, (%rcx)
180008fad:     	jmp	0x1800077c0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3ce0>
180008fb2:     	movb	$0x1, (%r15)
180008fb6:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
180008fbf:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008fc4:     	movq	0x180(%rsp), %rdx
180008fcc:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
180008fd1:     	movb	$0x1, (%r15)
180008fd5:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
180008fde:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180008fe3:     	movq	0x178(%rsp), %rdx
180008feb:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
180008ff0:     	movb	$0x1, (%r15)
180008ff4:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180008ffd:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180009002:     	movq	0x170(%rsp), %rdx
18000900a:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
18000900f:     	movb	$0x1, (%r15)
180009013:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
18000901c:     	jmp	0x1800079de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x3efe>
180009021:     	movq	0x168(%rsp), %rdx
180009029:     	jmp	0x180007da0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x42c0>
18000902e:     	int3
18000902f:     	int3
180009030:     	pushq	%rbx
180009032:     	subq	$0x20, %rsp
180009036:     	movq	%rcx, %rbx
180009039:     	callq	*0x30b1(%rip)           # 0x18000c0f0
18000903f:     	movl	%eax, (%rbx)
180009041:     	addq	$0x20, %rsp
180009045:     	popq	%rbx
180009046:     	retq
180009047:     	int3
180009048:     	int3
180009049:     	int3
18000904a:     	int3
18000904b:     	int3
18000904c:     	int3
18000904d:     	int3
18000904e:     	int3
18000904f:     	int3
180009050:     	movl	(%rcx), %ecx
180009052:     	jmpq	*0x31b7(%rip)           # 0x18000c210
180009059:     	int3
18000905a:     	int3
18000905b:     	int3
18000905c:     	int3
18000905d:     	int3
18000905e:     	int3
18000905f:     	int3
180009060:     	pushq	%rbp
180009062:     	pushq	%rbx
180009063:     	pushq	%rsi
180009064:     	pushq	%rdi
180009065:     	pushq	%r14
180009067:     	pushq	%r15
180009069:     	movq	%rsp, %rbp
18000906c:     	subq	$0x48, %rsp
180009070:     	movq	0x3169(%rip), %rax      # 0x18000c1e0
180009077:     	xorl	%r15d, %r15d
18000907a:     	movq	%rcx, %rsi
18000907d:     	movq	%r15, 0x38(%rbp)
180009081:     	movl	%r15d, %r14d
180009084:     	movq	%r15, 0x50(%rbp)
180009088:     	movq	%r15, 0x48(%rbp)
18000908c:     	cmpq	%rax, 0x8(%rcx)
180009090:     	jne	0x1800091fe <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x571e>
180009096:     	leaq	0x48(%rbp), %rax
18000909a:     	leaq	0x50(%rbp), %r9
18000909e:     	movq	%rax, 0x20(%rsp)
1800090a3:     	leaq	0x38(%rbp), %r8
1800090a7:     	leaq	0x3db6(%rip), %rdx      # 0x18000ce64
1800090ae:     	callq	*0x307c(%rip)           # 0x18000c130
1800090b4:     	testl	%eax, %eax
1800090b6:     	jne	0x1800091f4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5714>
1800090bc:     	movq	0x48(%rbp), %rbx
1800090c0:     	testq	%rbx, %rbx
1800090c3:     	je	0x1800091e5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5705>
1800090c9:     	cmpq	0x3200(%rip), %rbx      # 0x18000c2d0
1800090d0:     	je	0x1800091e5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5705>
1800090d6:     	movq	0x8(%rbx), %rax
1800090da:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
1800090e4:     	je	0x1800091e5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5705>
1800090ea:     	movq	0x20(%rbx), %rcx
1800090ee:     	callq	*0x308c(%rip)           # 0x18000c180
1800090f4:     	movq	0x28(%rbx), %rcx
1800090f8:     	movq	%rax, %rdi
1800090fb:     	callq	*0x307f(%rip)           # 0x18000c180
180009101:     	movq	0x30(%rbx), %rcx
180009105:     	movq	%rax, %r14
180009108:     	callq	*0x3082(%rip)           # 0x18000c190
18000910e:     	leaq	-0x10(%rbp), %r8
180009112:     	movl	%eax, %ebx
180009114:     	leaq	-0x18(%rbp), %rdx
180009118:     	leaq	0x40(%rbp), %rcx
18000911c:     	callq	*0x307e(%rip)           # 0x18000c1a0
180009122:     	callq	*0x3038(%rip)           # 0x18000c160
180009128:     	movq	%rax, %rsi
18000912b:     	testq	%rax, %rax
18000912e:     	je	0x1800091db <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56fb>
180009134:     	movl	%ebx, %r8d
180009137:     	movq	%rdi, %rdx
18000913a:     	movq	%r14, %rcx
18000913d:     	callq	*0x3115(%rip)           # 0x18000c258
180009143:     	movq	%rax, %rdi
180009146:     	testq	%rax, %rax
180009149:     	je	0x1800091db <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56fb>
18000914f:     	callq	*0x3113(%rip)           # 0x18000c268
180009155:     	xorl	%r9d, %r9d
180009158:     	movq	%rsi, %r8
18000915b:     	movq	%rax, %rcx
18000915e:     	movq	%rdi, %rdx
180009161:     	callq	*0x30d9(%rip)           # 0x18000c240
180009167:     	movl	(%rsi), %ecx
180009169:     	movq	%rax, %rbx
18000916c:     	testl	%ecx, %ecx
18000916e:     	js	0x180009180 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56a0>
180009170:     	subl	$0x1, %ecx
180009173:     	movl	%ecx, (%rsi)
180009175:     	jne	0x180009180 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56a0>
180009177:     	movq	%rsi, %rcx
18000917a:     	callq	*0x3048(%rip)           # 0x18000c1c8
180009180:     	movl	(%rdi), %eax
180009182:     	testl	%eax, %eax
180009184:     	js	0x180009196 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56b6>
180009186:     	subl	$0x1, %eax
180009189:     	movl	%eax, (%rdi)
18000918b:     	jne	0x180009196 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56b6>
18000918d:     	movq	%rdi, %rcx
180009190:     	callq	*0x3032(%rip)           # 0x18000c1c8
180009196:     	testq	%rbx, %rbx
180009199:     	je	0x1800091db <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x56fb>
18000919b:     	movq	-0x10(%rbp), %r8
18000919f:     	movq	-0x18(%rbp), %rdx
1800091a3:     	movq	0x40(%rbp), %rcx
1800091a7:     	callq	*0x3023(%rip)           # 0x18000c1d0
1800091ad:     	movq	%rbx, %rcx
1800091b0:     	callq	*0x3072(%rip)           # 0x18000c228
1800091b6:     	movl	(%rbx), %eax
1800091b8:     	testl	%eax, %eax
1800091ba:     	js	0x1800091e5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5705>
1800091bc:     	subl	$0x1, %eax
1800091bf:     	movl	%eax, (%rbx)
1800091c1:     	jne	0x1800091e5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5705>
1800091c3:     	movq	%rbx, %rcx
1800091c6:     	callq	*0x2ffc(%rip)           # 0x18000c1c8
1800091cc:     	xorl	%eax, %eax
1800091ce:     	addq	$0x48, %rsp
1800091d2:     	popq	%r15
1800091d4:     	popq	%r14
1800091d6:     	popq	%rdi
1800091d7:     	popq	%rsi
1800091d8:     	popq	%rbx
1800091d9:     	popq	%rbp
1800091da:     	retq
1800091db:     	movq	0x40(%rbp), %rcx
1800091df:     	callq	*0x301b(%rip)           # 0x18000c200
1800091e5:     	xorl	%eax, %eax
1800091e7:     	addq	$0x48, %rsp
1800091eb:     	popq	%r15
1800091ed:     	popq	%r14
1800091ef:     	popq	%rdi
1800091f0:     	popq	%rsi
1800091f1:     	popq	%rbx
1800091f2:     	popq	%rbp
1800091f3:     	retq
1800091f4:     	movq	0x38(%rbp), %rbx
1800091f8:     	movq	0x50(%rbp), %r14
1800091fc:     	jmp	0x180009205 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5725>
1800091fe:     	movq	%rsi, %rbx
180009201:     	movq	%rbx, 0x38(%rbp)
180009205:     	cmpq	0x30c4(%rip), %rbx      # 0x18000c2d0
18000920c:     	jne	0x1800092a4 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x57c4>
180009212:     	leaq	-0x18(%rbp), %r8
180009216:     	leaq	-0x10(%rbp), %rdx
18000921a:     	leaq	0x40(%rbp), %rcx
18000921e:     	callq	*0x2efc(%rip)           # 0x18000c120
180009224:     	movq	0x30a5(%rip), %rax      # 0x18000c2d0
18000922b:     	cmpq	%rax, 0x40(%rbp)
18000922f:     	jne	0x180009244 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5764>
180009231:     	movq	0x3078(%rip), %rcx      # 0x18000c2b0
180009238:     	leaq	0x3bd9(%rip), %rdx      # 0x18000ce18
18000923f:     	jmp	0x180009365 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5885>
180009244:     	movq	0x40(%rbp), %rcx
180009248:     	testq	%rcx, %rcx
18000924b:     	je	0x18000925a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x577a>
18000924d:     	movl	(%rcx), %eax
18000924f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009254:     	jae	0x18000925a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x577a>
180009256:     	incl	%eax
180009258:     	movl	%eax, (%rcx)
18000925a:     	movq	-0x10(%rbp), %rcx
18000925e:     	testq	%rcx, %rcx
180009261:     	je	0x180009270 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5790>
180009263:     	movl	(%rcx), %eax
180009265:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000926a:     	jae	0x180009270 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5790>
18000926c:     	incl	%eax
18000926e:     	movl	%eax, (%rcx)
180009270:     	movq	-0x18(%rbp), %r8
180009274:     	testq	%r8, %r8
180009277:     	je	0x18000928c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x57ac>
180009279:     	movl	(%r8), %eax
18000927c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009281:     	jae	0x18000928c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x57ac>
180009283:     	incl	%eax
180009285:     	movl	%eax, (%r8)
180009288:     	movq	-0x18(%rbp), %r8
18000928c:     	movq	-0x10(%rbp), %rdx
180009290:     	movq	0x40(%rbp), %rcx
180009294:     	callq	*0x2f36(%rip)           # 0x18000c1d0
18000929a:     	movl	$0x1, %ebx
18000929f:     	jmp	0x180009371 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5891>
1800092a4:     	movq	0x8(%rbx), %rcx
1800092a8:     	movl	0xa8(%rcx), %eax
1800092ae:     	testl	%eax, %eax
1800092b0:     	jns	0x180009346 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5866>
1800092b6:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
1800092c0:     	je	0x180009346 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5866>
1800092c6:     	movq	%r14, %rdx
1800092c9:     	movq	%rbx, %rcx
1800092cc:     	callq	*0x2e16(%rip)           # 0x18000c0e8
1800092d2:     	movq	%rax, %rdi
1800092d5:     	testq	%rax, %rax
1800092d8:     	je	0x18000936e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x588e>
1800092de:     	movq	0x8(%rax), %rax
1800092e2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
1800092ec:     	jne	0x18000931d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x583d>
1800092ee:     	movq	0x2fab(%rip), %rcx      # 0x18000c2a0
1800092f5:     	leaq	0x3b3c(%rip), %rdx      # 0x18000ce38
1800092fc:     	movq	(%rcx), %rcx
1800092ff:     	callq	*0x2fa3(%rip)           # 0x18000c2a8
180009305:     	movl	(%rdi), %eax
180009307:     	testl	%eax, %eax
180009309:     	js	0x18000936e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x588e>
18000930b:     	subl	$0x1, %eax
18000930e:     	movl	%eax, (%rdi)
180009310:     	jne	0x18000936e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x588e>
180009312:     	movq	%rdi, %rcx
180009315:     	callq	*0x2ead(%rip)           # 0x18000c1c8
18000931b:     	jmp	0x18000936e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x588e>
18000931d:     	movl	(%rdi), %eax
18000931f:     	testl	%eax, %eax
180009321:     	js	0x180009333 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5853>
180009323:     	subl	$0x1, %eax
180009326:     	movl	%eax, (%rdi)
180009328:     	jne	0x180009333 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5853>
18000932a:     	movq	%rdi, %rcx
18000932d:     	callq	*0x2e95(%rip)           # 0x18000c1c8
180009333:     	movq	%r14, %rdx
180009336:     	movq	%rbx, %rcx
180009339:     	callq	*0x2f21(%rip)           # 0x18000c260
18000933f:     	movl	$0x1, %ebx
180009344:     	jmp	0x180009371 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5891>
180009346:     	btl	$0x1e, %eax
18000934a:     	jae	0x180009357 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5877>
18000934c:     	movq	%rbx, %rdx
18000934f:     	callq	*0x2f0b(%rip)           # 0x18000c260
180009355:     	jmp	0x18000936e <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x588e>
180009357:     	movq	0x2f42(%rip), %rcx      # 0x18000c2a0
18000935e:     	leaq	0x3ad3(%rip), %rdx      # 0x18000ce38
180009365:     	movq	(%rcx), %rcx
180009368:     	callq	*0x2f3a(%rip)           # 0x18000c2a8
18000936e:     	movl	%r15d, %ebx
180009371:     	movq	0x48(%rbp), %rdi
180009375:     	testq	%rdi, %rdi
180009378:     	je	0x18000949b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59bb>
18000937e:     	cmpq	0x2f4b(%rip), %rdi      # 0x18000c2d0
180009385:     	je	0x18000949b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59bb>
18000938b:     	movq	0x8(%rdi), %rax
18000938f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009399:     	je	0x18000949b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59bb>
18000939f:     	movq	0x20(%rdi), %rcx
1800093a3:     	movq	%r12, 0x40(%rsp)
1800093a8:     	callq	*0x2dd2(%rip)           # 0x18000c180
1800093ae:     	movq	0x28(%rdi), %rcx
1800093b2:     	movq	%rax, %r14
1800093b5:     	callq	*0x2dc5(%rip)           # 0x18000c180
1800093bb:     	movq	0x30(%rdi), %rcx
1800093bf:     	movq	%rax, %r12
1800093c2:     	callq	*0x2dc8(%rip)           # 0x18000c190
1800093c8:     	leaq	-0x10(%rbp), %r8
1800093cc:     	movl	%eax, %edi
1800093ce:     	leaq	-0x18(%rbp), %rdx
1800093d2:     	leaq	0x40(%rbp), %rcx
1800093d6:     	callq	*0x2dc4(%rip)           # 0x18000c1a0
1800093dc:     	callq	*0x2d7e(%rip)           # 0x18000c160
1800093e2:     	movq	%rax, %r15
1800093e5:     	testq	%rax, %rax
1800093e8:     	je	0x18000948c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59ac>
1800093ee:     	movl	%edi, %r8d
1800093f1:     	movq	%r14, %rdx
1800093f4:     	movq	%r12, %rcx
1800093f7:     	callq	*0x2e5b(%rip)           # 0x18000c258
1800093fd:     	movq	%rax, %r14
180009400:     	testq	%rax, %rax
180009403:     	je	0x18000948c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59ac>
180009409:     	callq	*0x2e59(%rip)           # 0x18000c268
18000940f:     	xorl	%r9d, %r9d
180009412:     	movq	%r15, %r8
180009415:     	movq	%rax, %rcx
180009418:     	movq	%r14, %rdx
18000941b:     	callq	*0x2e1f(%rip)           # 0x18000c240
180009421:     	movl	(%r15), %ecx
180009424:     	movq	%rax, %rdi
180009427:     	testl	%ecx, %ecx
180009429:     	js	0x18000943c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x595c>
18000942b:     	subl	$0x1, %ecx
18000942e:     	movl	%ecx, (%r15)
180009431:     	jne	0x18000943c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x595c>
180009433:     	movq	%r15, %rcx
180009436:     	callq	*0x2d8c(%rip)           # 0x18000c1c8
18000943c:     	movl	(%r14), %eax
18000943f:     	testl	%eax, %eax
180009441:     	js	0x180009454 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5974>
180009443:     	subl	$0x1, %eax
180009446:     	movl	%eax, (%r14)
180009449:     	jne	0x180009454 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5974>
18000944b:     	movq	%r14, %rcx
18000944e:     	callq	*0x2d74(%rip)           # 0x18000c1c8
180009454:     	testq	%rdi, %rdi
180009457:     	je	0x18000948c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59ac>
180009459:     	movq	-0x10(%rbp), %r8
18000945d:     	movq	-0x18(%rbp), %rdx
180009461:     	movq	0x40(%rbp), %rcx
180009465:     	callq	*0x2d65(%rip)           # 0x18000c1d0
18000946b:     	movq	%rdi, %rcx
18000946e:     	callq	*0x2db4(%rip)           # 0x18000c228
180009474:     	movl	(%rdi), %eax
180009476:     	testl	%eax, %eax
180009478:     	js	0x180009496 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59b6>
18000947a:     	subl	$0x1, %eax
18000947d:     	movl	%eax, (%rdi)
18000947f:     	jne	0x180009496 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59b6>
180009481:     	movq	%rdi, %rcx
180009484:     	callq	*0x2d3e(%rip)           # 0x18000c1c8
18000948a:     	jmp	0x180009496 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59b6>
18000948c:     	movq	0x40(%rbp), %rcx
180009490:     	callq	*0x2d6a(%rip)           # 0x18000c200
180009496:     	movq	0x40(%rsp), %r12
18000949b:     	movl	(%rsi), %ecx
18000949d:     	testl	%ecx, %ecx
18000949f:     	js	0x1800094b1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59d1>
1800094a1:     	subl	$0x1, %ecx
1800094a4:     	movl	%ecx, (%rsi)
1800094a6:     	jne	0x1800094b1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x59d1>
1800094a8:     	movq	%rsi, %rcx
1800094ab:     	callq	*0x2d17(%rip)           # 0x18000c1c8
1800094b1:     	movl	%ebx, %eax
1800094b3:     	addq	$0x48, %rsp
1800094b7:     	popq	%r15
1800094b9:     	popq	%r14
1800094bb:     	popq	%rdi
1800094bc:     	popq	%rsi
1800094bd:     	popq	%rbx
1800094be:     	popq	%rbp
1800094bf:     	retq
1800094c0:     	movq	%rbx, 0x8(%rsp)
1800094c5:     	movq	%rsi, 0x10(%rsp)
1800094ca:     	pushq	%rdi
1800094cb:     	subq	$0x20, %rsp
1800094cf:     	cmpq	$0x0, 0xa7c1(%rip)      # 0x180013c98
1800094d7:     	movq	%rcx, %rsi
1800094da:     	movslq	%edx, %rdi
1800094dd:     	jne	0x18000952d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a4d>
1800094df:     	leaq	0x3982(%rip), %rcx      # 0x18000ce68
1800094e6:     	callq	*0x2d4c(%rip)           # 0x18000c238
1800094ec:     	movq	%rax, %rbx
1800094ef:     	testq	%rax, %rax
1800094f2:     	je	0x180009541 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a61>
1800094f4:     	leaq	0x3975(%rip), %rdx      # 0x18000ce70
1800094fb:     	movq	%rax, %rcx
1800094fe:     	callq	*0x2c64(%rip)           # 0x18000c168
180009504:     	movl	(%rbx), %ecx
180009506:     	movq	%rax, 0xa78b(%rip)      # 0x180013c98
18000950d:     	testl	%ecx, %ecx
18000950f:     	js	0x180009528 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a48>
180009511:     	subl	$0x1, %ecx
180009514:     	movl	%ecx, (%rbx)
180009516:     	jne	0x180009528 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a48>
180009518:     	movq	%rbx, %rcx
18000951b:     	callq	*0x2ca7(%rip)           # 0x18000c1c8
180009521:     	movq	0xa770(%rip), %rax      # 0x180013c98
180009528:     	testq	%rax, %rax
18000952b:     	je	0x180009541 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a61>
18000952d:     	movq	%rdi, %rdx
180009530:     	movq	%rsi, %rcx
180009533:     	callq	*0x2d7f(%rip)           # 0x18000c2b8
180009539:     	movq	%rax, %rbx
18000953c:     	testq	%rax, %rax
18000953f:     	jne	0x180009553 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a73>
180009541:     	xorl	%eax, %eax
180009543:     	movq	0x30(%rsp), %rbx
180009548:     	movq	0x38(%rsp), %rsi
18000954d:     	addq	$0x20, %rsp
180009551:     	popq	%rdi
180009552:     	retq
180009553:     	movq	0xa73e(%rip), %rcx      # 0x180013c98
18000955a:     	xorl	%r8d, %r8d
18000955d:     	movq	%rbx, %rdx
180009560:     	callq	*0x2c32(%rip)           # 0x18000c198
180009566:     	movl	(%rbx), %ecx
180009568:     	movq	%rax, %rdi
18000956b:     	testl	%ecx, %ecx
18000956d:     	js	0x18000957f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a9f>
18000956f:     	subl	$0x1, %ecx
180009572:     	movl	%ecx, (%rbx)
180009574:     	jne	0x18000957f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5a9f>
180009576:     	movq	%rbx, %rcx
180009579:     	callq	*0x2c49(%rip)           # 0x18000c1c8
18000957f:     	movq	0x30(%rsp), %rbx
180009584:     	movq	%rdi, %rax
180009587:     	movq	0x38(%rsp), %rsi
18000958c:     	addq	$0x20, %rsp
180009590:     	popq	%rdi
180009591:     	retq
180009592:     	int3
180009593:     	int3
180009594:     	int3
180009595:     	int3
180009596:     	int3
180009597:     	int3
180009598:     	int3
180009599:     	int3
18000959a:     	int3
18000959b:     	int3
18000959c:     	int3
18000959d:     	int3
18000959e:     	int3
18000959f:     	int3
1800095a0:     	movq	%rbx, 0x8(%rsp)
1800095a5:     	movq	%rsi, 0x10(%rsp)
1800095aa:     	pushq	%rdi
1800095ab:     	subq	$0x20, %rsp
1800095af:     	movq	0xa6da(%rip), %rax      # 0x180013c90
1800095b6:     	movq	%rdx, %rdi
1800095b9:     	movq	%rcx, %rsi
1800095bc:     	testq	%rax, %rax
1800095bf:     	jne	0x180009621 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b41>
1800095c1:     	leaq	0x38b0(%rip), %rcx      # 0x18000ce78
1800095c8:     	callq	*0x2c6a(%rip)           # 0x18000c238
1800095ce:     	movq	%rax, %rbx
1800095d1:     	testq	%rax, %rax
1800095d4:     	je	0x18000960f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b2f>
1800095d6:     	leaq	0x38b3(%rip), %rdx      # 0x18000ce90
1800095dd:     	movq	%rax, %rcx
1800095e0:     	callq	*0x2b82(%rip)           # 0x18000c168
1800095e6:     	movl	(%rbx), %ecx
1800095e8:     	movq	%rax, 0xa6a1(%rip)      # 0x180013c90
1800095ef:     	testl	%ecx, %ecx
1800095f1:     	js	0x18000960a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b2a>
1800095f3:     	subl	$0x1, %ecx
1800095f6:     	movl	%ecx, (%rbx)
1800095f8:     	jne	0x18000960a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b2a>
1800095fa:     	movq	%rbx, %rcx
1800095fd:     	callq	*0x2bc5(%rip)           # 0x18000c1c8
180009603:     	movq	0xa686(%rip), %rax      # 0x180013c90
18000960a:     	testq	%rax, %rax
18000960d:     	jne	0x180009621 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b41>
18000960f:     	xorl	%eax, %eax
180009611:     	movq	0x30(%rsp), %rbx
180009616:     	movq	0x38(%rsp), %rsi
18000961b:     	addq	$0x20, %rsp
18000961f:     	popq	%rdi
180009620:     	retq
180009621:     	xorl	%r9d, %r9d
180009624:     	movq	%rdi, %r8
180009627:     	movq	%rsi, %rdx
18000962a:     	movq	%rax, %rcx
18000962d:     	movq	0x30(%rsp), %rbx
180009632:     	movq	0x38(%rsp), %rsi
180009637:     	addq	$0x20, %rsp
18000963b:     	popq	%rdi
18000963c:     	jmpq	*0x2b55(%rip)           # 0x18000c198
180009643:     	int3
180009644:     	int3
180009645:     	int3
180009646:     	int3
180009647:     	int3
180009648:     	int3
180009649:     	int3
18000964a:     	int3
18000964b:     	int3
18000964c:     	int3
18000964d:     	int3
18000964e:     	int3
18000964f:     	int3
180009650:     	movq	%rbx, 0x8(%rsp)
180009655:     	movq	%rsi, 0x10(%rsp)
18000965a:     	pushq	%rdi
18000965b:     	subq	$0x20, %rsp
18000965f:     	movq	%rcx, %rbx
180009662:     	movq	%r8, %rdi
180009665:     	movq	0x10(%rcx), %rcx
180009669:     	movq	%rdx, %rsi
18000966c:     	testq	%rcx, %rcx
18000966f:     	je	0x18000967a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5b9a>
180009671:     	movq	%r8, %rdx
180009674:     	callq	*%rsi
180009676:     	testl	%eax, %eax
180009678:     	jne	0x18000969d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5bbd>
18000967a:     	movq	0x18(%rbx), %rcx
18000967e:     	testq	%rcx, %rcx
180009681:     	je	0x18000969b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5bbb>
180009683:     	movq	%rdi, %rdx
180009686:     	movq	%rsi, %rax
180009689:     	movq	0x30(%rsp), %rbx
18000968e:     	movq	0x38(%rsp), %rsi
180009693:     	addq	$0x20, %rsp
180009697:     	popq	%rdi
180009698:     	jmpq	*%rax
18000969b:     	xorl	%eax, %eax
18000969d:     	movq	0x30(%rsp), %rbx
1800096a2:     	movq	0x38(%rsp), %rsi
1800096a7:     	addq	$0x20, %rsp
1800096ab:     	popq	%rdi
1800096ac:     	retq
1800096ad:     	int3
1800096ae:     	int3
1800096af:     	int3
1800096b0:     	pushq	%rbx
1800096b2:     	subq	$0x20, %rsp
1800096b6:     	movq	%rcx, %rbx
1800096b9:     	movq	0x10(%rcx), %rcx
1800096bd:     	testq	%rcx, %rcx
1800096c0:     	je	0x1800096dd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5bfd>
1800096c2:     	movq	$0x0, 0x10(%rbx)
1800096ca:     	movl	(%rcx), %eax
1800096cc:     	testl	%eax, %eax
1800096ce:     	js	0x1800096dd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5bfd>
1800096d0:     	subl	$0x1, %eax
1800096d3:     	movl	%eax, (%rcx)
1800096d5:     	jne	0x1800096dd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5bfd>
1800096d7:     	callq	*0x2aeb(%rip)           # 0x18000c1c8
1800096dd:     	movq	0x18(%rbx), %rcx
1800096e1:     	testq	%rcx, %rcx
1800096e4:     	je	0x180009701 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c21>
1800096e6:     	movq	$0x0, 0x18(%rbx)
1800096ee:     	movl	(%rcx), %eax
1800096f0:     	testl	%eax, %eax
1800096f2:     	js	0x180009701 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c21>
1800096f4:     	subl	$0x1, %eax
1800096f7:     	movl	%eax, (%rcx)
1800096f9:     	jne	0x180009701 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c21>
1800096fb:     	callq	*0x2ac7(%rip)           # 0x18000c1c8
180009701:     	xorl	%eax, %eax
180009703:     	addq	$0x20, %rsp
180009707:     	popq	%rbx
180009708:     	retq
180009709:     	int3
18000970a:     	int3
18000970b:     	int3
18000970c:     	int3
18000970d:     	int3
18000970e:     	int3
18000970f:     	int3
180009710:     	pushq	%rbx
180009712:     	subq	$0x20, %rsp
180009716:     	movq	%rcx, %rbx
180009719:     	callq	*0x2af9(%rip)           # 0x18000c218
18000971f:     	movq	0x10(%rbx), %rcx
180009723:     	testq	%rcx, %rcx
180009726:     	je	0x180009743 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c63>
180009728:     	movq	$0x0, 0x10(%rbx)
180009730:     	movl	(%rcx), %eax
180009732:     	testl	%eax, %eax
180009734:     	js	0x180009743 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c63>
180009736:     	subl	$0x1, %eax
180009739:     	movl	%eax, (%rcx)
18000973b:     	jne	0x180009743 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c63>
18000973d:     	callq	*0x2a85(%rip)           # 0x18000c1c8
180009743:     	movq	0x18(%rbx), %rcx
180009747:     	testq	%rcx, %rcx
18000974a:     	je	0x180009767 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c87>
18000974c:     	movq	$0x0, 0x18(%rbx)
180009754:     	movl	(%rcx), %eax
180009756:     	testl	%eax, %eax
180009758:     	js	0x180009767 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c87>
18000975a:     	subl	$0x1, %eax
18000975d:     	movl	%eax, (%rcx)
18000975f:     	jne	0x180009767 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5c87>
180009761:     	callq	*0x2a61(%rip)           # 0x18000c1c8
180009767:     	movq	0x8(%rbx), %rax
18000976b:     	movq	%rbx, %rcx
18000976e:     	addq	$0x20, %rsp
180009772:     	popq	%rbx
180009773:     	jmpq	*0x140(%rax)
18000977a:     	int3
18000977b:     	int3
18000977c:     	int3
18000977d:     	int3
18000977e:     	int3
18000977f:     	int3
180009780:     	pushq	%rbx
180009782:     	subq	$0x30, %rsp
180009786:     	movq	%r8, %r10
180009789:     	leaq	0x58(%rsp), %rax
18000978e:     	movq	%rax, 0x28(%rsp)
180009793:     	leaq	0xa236(%rip), %r9       # 0x1800139d0
18000979a:     	movq	0x2a47(%rip), %rax      # 0x18000c1e8
1800097a1:     	leaq	0x3718(%rip), %r8       # 0x18000cec0
1800097a8:     	movq	%rdx, %r11
1800097ab:     	movq	%rax, 0x20(%rsp)
1800097b0:     	movq	%rcx, %rbx
1800097b3:     	movq	%r10, %rdx
1800097b6:     	movq	%r11, %rcx
1800097b9:     	callq	*0x2939(%rip)           # 0x18000c0f8
1800097bf:     	testl	%eax, %eax
1800097c1:     	je	0x18000981c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d3c>
1800097c3:     	xorl	%r8d, %r8d
1800097c6:     	xorl	%edx, %edx
1800097c8:     	movq	%rbx, %rcx
1800097cb:     	callq	*0x2a77(%rip)           # 0x18000c248
1800097d1:     	movq	%rax, %rbx
1800097d4:     	testq	%rax, %rax
1800097d7:     	je	0x18000981c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d3c>
1800097d9:     	movq	0x58(%rsp), %rax
1800097de:     	movl	(%rax), %ecx
1800097e0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800097e6:     	jae	0x1800097f1 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d11>
1800097e8:     	incl	%ecx
1800097ea:     	movl	%ecx, (%rax)
1800097ec:     	movq	0x58(%rsp), %rax
1800097f1:     	xorl	%ecx, %ecx
1800097f3:     	movq	%rax, 0x10(%rbx)
1800097f7:     	callq	*0x297b(%rip)           # 0x18000c178
1800097fd:     	movq	%rax, 0x18(%rbx)
180009801:     	testq	%rax, %rax
180009804:     	jne	0x180009824 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d44>
180009806:     	movl	(%rbx), %eax
180009808:     	testl	%eax, %eax
18000980a:     	js	0x18000981c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d3c>
18000980c:     	subl	$0x1, %eax
18000980f:     	movl	%eax, (%rbx)
180009811:     	jne	0x18000981c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d3c>
180009813:     	movq	%rbx, %rcx
180009816:     	callq	*0x29ac(%rip)           # 0x18000c1c8
18000981c:     	xorl	%eax, %eax
18000981e:     	addq	$0x30, %rsp
180009822:     	popq	%rbx
180009823:     	retq
180009824:     	movq	%rbx, %rax
180009827:     	addq	$0x30, %rsp
18000982b:     	popq	%rbx
18000982c:     	retq
18000982d:     	int3
18000982e:     	int3
18000982f:     	int3
180009830:     	movq	%rbx, 0x8(%rsp)
180009835:     	movq	%rsi, 0x10(%rsp)
18000983a:     	pushq	%rdi
18000983b:     	subq	$0x20, %rsp
18000983f:     	movq	%rcx, %rbx
180009842:     	movq	%r8, %rdi
180009845:     	movq	0x18(%rcx), %rcx
180009849:     	movq	%rdx, %rsi
18000984c:     	testq	%rcx, %rcx
18000984f:     	je	0x18000985a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d7a>
180009851:     	movq	%r8, %rdx
180009854:     	callq	*%rsi
180009856:     	testl	%eax, %eax
180009858:     	jne	0x18000987d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d9d>
18000985a:     	movq	0x40(%rbx), %rcx
18000985e:     	testq	%rcx, %rcx
180009861:     	je	0x18000987b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5d9b>
180009863:     	movq	%rdi, %rdx
180009866:     	movq	%rsi, %rax
180009869:     	movq	0x30(%rsp), %rbx
18000986e:     	movq	0x38(%rsp), %rsi
180009873:     	addq	$0x20, %rsp
180009877:     	popq	%rdi
180009878:     	jmpq	*%rax
18000987b:     	xorl	%eax, %eax
18000987d:     	movq	0x30(%rsp), %rbx
180009882:     	movq	0x38(%rsp), %rsi
180009887:     	addq	$0x20, %rsp
18000988b:     	popq	%rdi
18000988c:     	retq
18000988d:     	int3
18000988e:     	int3
18000988f:     	int3
180009890:     	pushq	%rbx
180009892:     	subq	$0x20, %rsp
180009896:     	movq	%rcx, %rbx
180009899:     	callq	*0x2979(%rip)           # 0x18000c218
18000989f:     	cmpq	$0x0, 0x48(%rbx)
1800098a4:     	je	0x1800098af <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5dcf>
1800098a6:     	movq	%rbx, %rcx
1800098a9:     	callq	*0x28d9(%rip)           # 0x18000c188
1800098af:     	movq	0x20(%rbx), %rcx
1800098b3:     	callq	*0x28ff(%rip)           # 0x18000c1b8
1800098b9:     	movq	0x38(%rbx), %rcx
1800098bd:     	callq	*0x28f5(%rip)           # 0x18000c1b8
1800098c3:     	movq	0x18(%rbx), %rcx
1800098c7:     	testq	%rcx, %rcx
1800098ca:     	je	0x1800098df <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5dff>
1800098cc:     	movl	(%rcx), %eax
1800098ce:     	testl	%eax, %eax
1800098d0:     	js	0x1800098df <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5dff>
1800098d2:     	subl	$0x1, %eax
1800098d5:     	movl	%eax, (%rcx)
1800098d7:     	jne	0x1800098df <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5dff>
1800098d9:     	callq	*0x28e9(%rip)           # 0x18000c1c8
1800098df:     	movq	0x40(%rbx), %rcx
1800098e3:     	testq	%rcx, %rcx
1800098e6:     	je	0x1800098fb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e1b>
1800098e8:     	movl	(%rcx), %eax
1800098ea:     	testl	%eax, %eax
1800098ec:     	js	0x1800098fb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e1b>
1800098ee:     	subl	$0x1, %eax
1800098f1:     	movl	%eax, (%rcx)
1800098f3:     	jne	0x1800098fb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e1b>
1800098f5:     	callq	*0x28cd(%rip)           # 0x18000c1c8
1800098fb:     	movq	0x8(%rbx), %rax
1800098ff:     	movq	%rbx, %rcx
180009902:     	addq	$0x20, %rsp
180009906:     	popq	%rbx
180009907:     	jmpq	*0x140(%rax)
18000990e:     	int3
18000990f:     	int3
180009910:     	pushq	%rbx
180009912:     	subq	$0x20, %rsp
180009916:     	callq	*0x2864(%rip)           # 0x18000c180
18000991c:     	movq	%rax, %rbx
18000991f:     	testq	%rax, %rax
180009922:     	jne	0x18000992a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e4a>
180009924:     	addq	$0x20, %rsp
180009928:     	popq	%rbx
180009929:     	retq
18000992a:     	movq	%rbx, %rcx
18000992d:     	movq	%rdi, 0x30(%rsp)
180009932:     	callq	0x18000bc95 <numba_list_iter_next+0xed5>
180009937:     	leaq	0x1(%rax), %rcx
18000993b:     	callq	*0x290f(%rip)           # 0x18000c250
180009941:     	movq	%rax, %rdi
180009944:     	testq	%rax, %rax
180009947:     	jne	0x18000995c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e7c>
180009949:     	callq	*0x27f1(%rip)           # 0x18000c140
18000994f:     	movq	0x30(%rsp), %rdi
180009954:     	xorl	%eax, %eax
180009956:     	addq	$0x20, %rsp
18000995a:     	popq	%rbx
18000995b:     	retq
18000995c:     	movq	%rbx, %rdx
18000995f:     	movq	%rdi, %rcx
180009962:     	callq	0x18000bc8f <numba_list_iter_next+0xecf>
180009967:     	movq	%rdi, %rax
18000996a:     	movq	0x30(%rsp), %rdi
18000996f:     	addq	$0x20, %rsp
180009973:     	popq	%rbx
180009974:     	retq
180009975:     	int3
180009976:     	int3
180009977:     	int3
180009978:     	int3
180009979:     	int3
18000997a:     	int3
18000997b:     	int3
18000997c:     	int3
18000997d:     	int3
18000997e:     	int3
18000997f:     	int3
180009980:     	movq	0x18(%rcx), %rcx
180009984:     	movq	%rdx, %rax
180009987:     	testq	%rcx, %rcx
18000998a:     	je	0x180009992 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5eb2>
18000998c:     	movq	%r8, %rdx
18000998f:     	jmpq	*%rax
180009992:     	xorl	%eax, %eax
180009994:     	retq
180009995:     	int3
180009996:     	int3
180009997:     	int3
180009998:     	int3
180009999:     	int3
18000999a:     	int3
18000999b:     	int3
18000999c:     	int3
18000999d:     	int3
18000999e:     	int3
18000999f:     	int3
1800099a0:     	movq	%rbx, 0x8(%rsp)
1800099a5:     	pushq	%rdi
1800099a6:     	subq	$0x20, %rsp
1800099aa:     	movq	0x28(%rcx), %rax
1800099ae:     	xorl	%edi, %edi
1800099b0:     	movq	%rcx, %rbx
1800099b3:     	testq	%rax, %rax
1800099b6:     	je	0x1800099c2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5ee2>
1800099b8:     	addq	$0x38, %rcx
1800099bc:     	callq	*%rax
1800099be:     	movq	%rdi, 0x28(%rbx)
1800099c2:     	movq	0x18(%rbx), %rcx
1800099c6:     	testq	%rcx, %rcx
1800099c9:     	je	0x1800099e2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f02>
1800099cb:     	movq	%rdi, 0x18(%rbx)
1800099cf:     	movl	(%rcx), %eax
1800099d1:     	testl	%eax, %eax
1800099d3:     	js	0x1800099e2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f02>
1800099d5:     	subl	$0x1, %eax
1800099d8:     	movl	%eax, (%rcx)
1800099da:     	jne	0x1800099e2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f02>
1800099dc:     	callq	*0x27e6(%rip)           # 0x18000c1c8
1800099e2:     	movq	%rdi, 0x20(%rbx)
1800099e6:     	xorl	%eax, %eax
1800099e8:     	movq	0x30(%rsp), %rbx
1800099ed:     	addq	$0x20, %rsp
1800099f1:     	popq	%rdi
1800099f2:     	retq
1800099f3:     	int3
1800099f4:     	int3
1800099f5:     	int3
1800099f6:     	int3
1800099f7:     	int3
1800099f8:     	int3
1800099f9:     	int3
1800099fa:     	int3
1800099fb:     	int3
1800099fc:     	int3
1800099fd:     	int3
1800099fe:     	int3
1800099ff:     	int3
180009a00:     	pushq	%rbx
180009a02:     	subq	$0x20, %rsp
180009a06:     	movq	%rcx, %rbx
180009a09:     	callq	*0x2809(%rip)           # 0x18000c218
180009a0f:     	cmpq	$0x0, 0x30(%rbx)
180009a14:     	je	0x180009a1f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f3f>
180009a16:     	movq	%rbx, %rcx
180009a19:     	callq	*0x2769(%rip)           # 0x18000c188
180009a1f:     	callq	*0x26e3(%rip)           # 0x18000c108
180009a25:     	testl	%eax, %eax
180009a27:     	jne	0x180009a38 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f58>
180009a29:     	movq	0x28(%rbx), %rax
180009a2d:     	testq	%rax, %rax
180009a30:     	je	0x180009a38 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f58>
180009a32:     	leaq	0x38(%rbx), %rcx
180009a36:     	callq	*%rax
180009a38:     	movq	0x18(%rbx), %rcx
180009a3c:     	testq	%rcx, %rcx
180009a3f:     	je	0x180009a54 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f74>
180009a41:     	movl	(%rcx), %eax
180009a43:     	testl	%eax, %eax
180009a45:     	js	0x180009a54 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f74>
180009a47:     	subl	$0x1, %eax
180009a4a:     	movl	%eax, (%rcx)
180009a4c:     	jne	0x180009a54 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5f74>
180009a4e:     	callq	*0x2774(%rip)           # 0x18000c1c8
180009a54:     	movq	0x8(%rbx), %rax
180009a58:     	movq	%rbx, %rcx
180009a5b:     	addq	$0x20, %rsp
180009a5f:     	popq	%rbx
180009a60:     	jmpq	*0x140(%rax)
180009a67:     	int3
180009a68:     	int3
180009a69:     	int3
180009a6a:     	int3
180009a6b:     	int3
180009a6c:     	int3
180009a6d:     	int3
180009a6e:     	int3
180009a6f:     	int3
180009a70:     	pushq	%rdi
180009a72:     	subq	$0x20, %rsp
180009a76:     	cmpq	$0x0, 0x20(%rcx)
180009a7b:     	movq	%rcx, %rdi
180009a7e:     	jne	0x180009a9f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5fbf>
180009a80:     	movq	0x2829(%rip), %rcx      # 0x18000c2b0
180009a87:     	leaq	0x3482(%rip), %rdx      # 0x18000cf10
180009a8e:     	movq	(%rcx), %rcx
180009a91:     	callq	*0x2811(%rip)           # 0x18000c2a8
180009a97:     	xorl	%eax, %eax
180009a99:     	addq	$0x20, %rsp
180009a9d:     	popq	%rdi
180009a9e:     	retq
180009a9f:     	movq	%rdi, %rdx
180009aa2:     	movq	%rbx, 0x30(%rsp)
180009aa7:     	movl	$0x1, %ecx
180009aac:     	callq	*0x2856(%rip)           # 0x18000c308
180009ab2:     	movq	%rax, %rbx
180009ab5:     	testq	%rax, %rax
180009ab8:     	jne	0x180009ac5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5fe5>
180009aba:     	movq	0x30(%rsp), %rbx
180009abf:     	addq	$0x20, %rsp
180009ac3:     	popq	%rdi
180009ac4:     	retq
180009ac5:     	xorl	%r8d, %r8d
180009ac8:     	movq	%rbx, %rdx
180009acb:     	movq	%rdi, %rcx
180009ace:     	callq	*0x20(%rdi)
180009ad1:     	movl	(%rbx), %ecx
180009ad3:     	movq	%rax, %rdi
180009ad6:     	testl	%ecx, %ecx
180009ad8:     	js	0x180009aea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x600a>
180009ada:     	subl	$0x1, %ecx
180009add:     	movl	%ecx, (%rbx)
180009adf:     	jne	0x180009aea <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x600a>
180009ae1:     	movq	%rbx, %rcx
180009ae4:     	callq	*0x26de(%rip)           # 0x18000c1c8
180009aea:     	movq	0x30(%rsp), %rbx
180009aef:     	movq	%rdi, %rax
180009af2:     	addq	$0x20, %rsp
180009af6:     	popq	%rdi
180009af7:     	retq
180009af8:     	int3
180009af9:     	int3
180009afa:     	int3
180009afb:     	int3
180009afc:     	int3
180009afd:     	int3
180009afe:     	int3
180009aff:     	int3
180009b00:     	movq	%rbx, 0x8(%rsp)
180009b05:     	pushq	%rdi
180009b06:     	subq	$0x20, %rsp
180009b0a:     	movq	%r8, %rbx
180009b0d:     	callq	*0x25dd(%rip)           # 0x18000c0f0
180009b13:     	movl	(%rbx), %ecx
180009b15:     	movl	%eax, %edi
180009b17:     	testl	%ecx, %ecx
180009b19:     	js	0x180009b2b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x604b>
180009b1b:     	subl	$0x1, %ecx
180009b1e:     	movl	%ecx, (%rbx)
180009b20:     	jne	0x180009b2b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x604b>
180009b22:     	movq	%rbx, %rcx
180009b25:     	callq	*0x269d(%rip)           # 0x18000c1c8
180009b2b:     	movl	%edi, %ecx
180009b2d:     	movq	0x30(%rsp), %rbx
180009b32:     	addq	$0x20, %rsp
180009b36:     	popq	%rdi
180009b37:     	jmpq	*0x26d2(%rip)           # 0x18000c210
180009b3e:     	int3
180009b3f:     	int3
180009b40:     	movq	%rbx, 0x8(%rsp)
180009b45:     	pushq	%rdi
180009b46:     	subq	$0x20, %rsp
180009b4a:     	movl	(%rdx), %eax
180009b4c:     	movq	%rdx, %rbx
180009b4f:     	movq	%rcx, %rdi
180009b52:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009b57:     	jae	0x180009b5d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x607d>
180009b59:     	incl	%eax
180009b5b:     	movl	%eax, (%rdx)
180009b5d:     	movl	$0x30, %ecx
180009b62:     	callq	*0xa100(%rip)           # 0x180013c68
180009b68:     	cmpb	$0x0, 0xa0d1(%rip)      # 0x180013c40
180009b6f:     	je	0x180009b79 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6099>
180009b71:     	lock
180009b72:     	incq	0xa0cf(%rip)            # 0x180013c48
180009b79:     	testq	%rax, %rax
180009b7c:     	je	0x180009bb3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60d3>
180009b7e:     	movl	$0x1, %ecx
180009b83:     	leaq	-0x8a(%rip), %rdx       # 0x180009b00 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6020>
180009b8a:     	xchgq	%rcx, (%rax)
180009b8d:     	xorl	%ecx, %ecx
180009b8f:     	movq	%rdx, 0x8(%rax)
180009b93:     	movq	%rcx, 0x20(%rax)
180009b97:     	movq	%rcx, 0x28(%rax)
180009b9b:     	movq	%rbx, 0x10(%rax)
180009b9f:     	movq	%rdi, 0x18(%rax)
180009ba3:     	cmpb	%cl, 0xa097(%rip)       # 0x180013c40
180009ba9:     	je	0x180009bb3 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60d3>
180009bab:     	lock
180009bac:     	incq	0xa0a5(%rip)            # 0x180013c58
180009bb3:     	movq	0x30(%rsp), %rbx
180009bb8:     	addq	$0x20, %rsp
180009bbc:     	popq	%rdi
180009bbd:     	retq
180009bbe:     	int3
180009bbf:     	int3
180009bc0:     	movq	%rbx, 0x8(%rsp)
180009bc5:     	pushq	%rdi
180009bc6:     	subq	$0x30, %rsp
180009bca:     	movq	%rcx, %rdi
180009bcd:     	leaq	0x9dec(%rip), %r9       # 0x1800139c0
180009bd4:     	movq	%r8, %rax
180009bd7:     	leaq	0x58(%rsp), %rcx
180009bdc:     	movq	%rdx, %r10
180009bdf:     	movq	%rcx, 0x20(%rsp)
180009be4:     	movq	%r10, %rcx
180009be7:     	leaq	0x336a(%rip), %r8       # 0x18000cf58
180009bee:     	movq	%rax, %rdx
180009bf1:     	callq	*0x2501(%rip)           # 0x18000c0f8
180009bf7:     	testl	%eax, %eax
180009bf9:     	je	0x180009c23 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6143>
180009bfb:     	movq	0x58(%rsp), %rcx
180009c00:     	callq	*0x24da(%rip)           # 0x18000c0e0
180009c06:     	movq	%rax, %rbx
180009c09:     	callq	*0x26d9(%rip)           # 0x18000c2e8
180009c0f:     	testq	%rax, %rax
180009c12:     	jne	0x180009c23 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6143>
180009c14:     	movq	%rbx, 0x10(%rdi)
180009c18:     	movq	0x40(%rsp), %rbx
180009c1d:     	addq	$0x30, %rsp
180009c21:     	popq	%rdi
180009c22:     	retq
180009c23:     	movq	0x40(%rsp), %rbx
180009c28:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180009c2d:     	addq	$0x30, %rsp
180009c31:     	popq	%rdi
180009c32:     	retq
180009c33:     	int3
180009c34:     	int3
180009c35:     	int3
180009c36:     	int3
180009c37:     	int3
180009c38:     	int3
180009c39:     	int3
180009c3a:     	int3
180009c3b:     	int3
180009c3c:     	int3
180009c3d:     	int3
180009c3e:     	int3
180009c3f:     	int3
180009c40:     	subq	$0x38, %rsp
180009c44:     	movl	%r8d, %eax
180009c47:     	movq	%rdx, %r10
180009c4a:     	movq	0x10(%rcx), %r8
180009c4e:     	movq	%rcx, %rdx
180009c51:     	movl	%eax, 0x28(%rsp)
180009c55:     	movq	%r10, %rcx
180009c58:     	movl	$0x0, 0x20(%rsp)
180009c60:     	movq	0x20(%r8), %r9
180009c64:     	movq	0x18(%r8), %r8
180009c68:     	callq	*0x259a(%rip)           # 0x18000c208
180009c6e:     	addq	$0x38, %rsp
180009c72:     	retq
180009c73:     	int3
180009c74:     	int3
180009c75:     	int3
180009c76:     	int3
180009c77:     	int3
180009c78:     	int3
180009c79:     	int3
180009c7a:     	int3
180009c7b:     	int3
180009c7c:     	int3
180009c7d:     	int3
180009c7e:     	int3
180009c7f:     	int3
180009c80:     	movq	0x10(%rcx), %rax
180009c84:     	lock
180009c85:     	incq	(%rax)
180009c88:     	movq	0x2641(%rip), %rax      # 0x18000c2d0
180009c8f:     	retq
180009c90:     	subq	$0x28, %rsp
180009c94:     	movq	0x10(%rcx), %rcx
180009c98:     	callq	0x18000af90 <numba_list_iter_next+0x1d0>
180009c9d:     	movq	0x262c(%rip), %rax      # 0x18000c2d0
180009ca4:     	addq	$0x28, %rsp
180009ca8:     	retq
180009ca9:     	int3
180009caa:     	int3
180009cab:     	int3
180009cac:     	int3
180009cad:     	int3
180009cae:     	int3
180009caf:     	int3
180009cb0:     	movq	0x10(%rcx), %rcx
180009cb4:     	movq	0x18(%rcx), %rcx
180009cb8:     	jmpq	*0x2499(%rip)           # 0x18000c158
180009cbf:     	int3
180009cc0:     	subq	$0x28, %rsp
180009cc4:     	movq	0x10(%rcx), %rax
180009cc8:     	testq	%rax, %rax
180009ccb:     	je	0x180009ce9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6209>
180009ccd:     	cmpq	$0x0, 0x18(%rax)
180009cd2:     	je	0x180009ce9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6209>
180009cd4:     	movq	(%rax), %rcx
180009cd7:     	nop
180009cd8:     	cmpq	$-0x1, %rcx
180009cdc:     	je	0x180009ce9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6209>
180009cde:     	addq	$0x28, %rsp
180009ce2:     	jmpq	*0x243f(%rip)           # 0x18000c128
180009ce9:     	movq	0x2508(%rip), %rcx      # 0x18000c1f8
180009cf0:     	leaq	0x3269(%rip), %rdx      # 0x18000cf60
180009cf7:     	movq	(%rcx), %rcx
180009cfa:     	callq	*0x25a8(%rip)           # 0x18000c2a8
180009d00:     	xorl	%eax, %eax
180009d02:     	addq	$0x28, %rsp
180009d06:     	retq
180009d07:     	int3
180009d08:     	int3
180009d09:     	int3
180009d0a:     	int3
180009d0b:     	int3
180009d0c:     	int3
180009d0d:     	int3
180009d0e:     	int3
180009d0f:     	int3
180009d10:     	movq	0x10(%rcx), %rcx
180009d14:     	movq	0x28(%rcx), %rcx
180009d18:     	jmpq	*0x2439(%rip)           # 0x18000c158
180009d1f:     	int3
180009d20:     	movq	0x10(%rcx), %rax
180009d24:     	movq	0x10(%rax), %rax
180009d28:     	testq	%rax, %rax
180009d2b:     	je	0x180009d3c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x625c>
180009d2d:     	movl	(%rax), %ecx
180009d2f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180009d35:     	jae	0x180009d5a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x627a>
180009d37:     	incl	%ecx
180009d39:     	movl	%ecx, (%rax)
180009d3b:     	retq
180009d3c:     	movq	0x258d(%rip), %rcx      # 0x18000c2d0
180009d43:     	movl	(%rcx), %eax
180009d45:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009d4a:     	jae	0x180009d57 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6277>
180009d4c:     	incl	%eax
180009d4e:     	movl	%eax, (%rcx)
180009d50:     	movq	0x2579(%rip), %rcx      # 0x18000c2d0
180009d57:     	movq	%rcx, %rax
180009d5a:     	retq
180009d5b:     	int3
180009d5c:     	int3
180009d5d:     	int3
180009d5e:     	int3
180009d5f:     	int3
180009d60:     	pushq	%rbx
180009d62:     	subq	$0x20, %rsp
180009d66:     	movq	%rcx, %rbx
180009d69:     	movq	0x10(%rcx), %rcx
180009d6d:     	callq	0x18000af90 <numba_list_iter_next+0x1d0>
180009d72:     	movq	0x8(%rbx), %rax
180009d76:     	movq	%rbx, %rcx
180009d79:     	addq	$0x20, %rsp
180009d7d:     	popq	%rbx
180009d7e:     	jmpq	*0x140(%rax)
180009d85:     	int3
180009d86:     	int3
180009d87:     	int3
180009d88:     	int3
180009d89:     	int3
180009d8a:     	int3
180009d8b:     	int3
180009d8c:     	int3
180009d8d:     	int3
180009d8e:     	int3
180009d8f:     	int3
180009d90:     	movq	%rdi, 0x18(%rsp)
180009d95:     	pushq	%r14
180009d97:     	subq	$0x20, %rsp
180009d9b:     	movq	0x9ede(%rip), %rax      # 0x180013c80
180009da2:     	movq	%rdx, %r14
180009da5:     	movq	%rcx, %rdi
180009da8:     	movq	0x8(%rcx), %rcx
180009dac:     	movq	0x10(%rax), %rdx
180009db0:     	cmpq	%rdx, %rcx
180009db3:     	je	0x180009dd0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62f0>
180009db5:     	callq	*0x241d(%rip)           # 0x18000c1d8
180009dbb:     	testl	%eax, %eax
180009dbd:     	jne	0x180009dd0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x62f0>
180009dbf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180009dc4:     	movq	0x40(%rsp), %rdi
180009dc9:     	addq	$0x20, %rsp
180009dcd:     	popq	%r14
180009dcf:     	retq
180009dd0:     	movq	%rbx, 0x30(%rsp)
180009dd5:     	movq	%rdi, %rdx
180009dd8:     	movq	0x10(%rdi), %rbx
180009ddc:     	movq	%rbx, %rcx
180009ddf:     	movq	%rsi, 0x38(%rsp)
180009de4:     	movl	0x18(%rdi), %esi
180009de7:     	callq	0x180009b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6060>
180009dec:     	movq	%rax, (%r14)
180009def:     	movq	0x9e8a(%rip), %rax      # 0x180013c80
180009df6:     	movq	%rbx, 0x20(%r14)
180009dfa:     	movl	0x18(%rdi), %edx
180009dfd:     	movq	0x20(%rdi), %rcx
180009e01:     	callq	*0x4f0(%rax)
180009e07:     	cmpl	$0x12, 0x9e7e(%rip)     # 0x180013c8c
180009e0e:     	movq	0x30(%rsp), %rbx
180009e13:     	movq	%rax, 0x10(%r14)
180009e17:     	movq	0x38(%rdi), %rax
180009e1b:     	jl	0x180009e23 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6343>
180009e1d:     	movq	0x28(%rax), %rax
180009e21:     	jmp	0x180009e27 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6347>
180009e23:     	movslq	0x20(%rax), %rax
180009e27:     	xorl	%r8d, %r8d
180009e2a:     	movq	%rax, 0x18(%r14)
180009e2e:     	movq	%rdi, 0x8(%r14)
180009e32:     	leaq	0x28(%r14), %rax
180009e36:     	testl	%esi, %esi
180009e38:     	jle	0x180009e7b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x639b>
180009e3a:     	nopw	(%rax,%rax)
180009e40:     	movq	0x20(%rdi), %rcx
180009e44:     	movq	(%rcx,%r8,8), %rdx
180009e48:     	incl	%r8d
180009e4b:     	movq	%rdx, (%rax)
180009e4e:     	addq	$0x8, %rax
180009e52:     	cmpl	%esi, %r8d
180009e55:     	jl	0x180009e40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6360>
180009e57:     	xorl	%r8d, %r8d
180009e5a:     	nopw	(%rax,%rax)
180009e60:     	movq	0x28(%rdi), %rcx
180009e64:     	leaq	0x8(%rax), %rax
180009e68:     	movslq	%r8d, %rdx
180009e6b:     	incl	%r8d
180009e6e:     	movq	(%rcx,%rdx,8), %rdx
180009e72:     	movq	%rdx, -0x8(%rax)
180009e76:     	cmpl	%esi, %r8d
180009e79:     	jl	0x180009e60 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6380>
180009e7b:     	movq	0x38(%rsp), %rsi
180009e80:     	xorl	%eax, %eax
180009e82:     	movq	0x40(%rsp), %rdi
180009e87:     	addq	$0x20, %rsp
180009e8b:     	popq	%r14
180009e8d:     	retq
180009e8e:     	int3
180009e8f:     	int3
180009e90:     	pushq	%rbx
180009e92:     	pushq	%rbp
180009e93:     	pushq	%rsi
180009e94:     	pushq	%rdi
180009e95:     	subq	$0x28, %rsp
180009e99:     	cmpq	$0x0, 0x9df7(%rip)      # 0x180013c98
180009ea1:     	movq	%rcx, %rbp
180009ea4:     	movslq	0x8(%rdx), %rdi
180009ea8:     	movq	(%rdx), %rsi
180009eab:     	jne	0x180009f03 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6423>
180009ead:     	leaq	0x2fb4(%rip), %rcx      # 0x18000ce68
180009eb4:     	callq	*0x237e(%rip)           # 0x18000c238
180009eba:     	movq	%rax, %rbx
180009ebd:     	testq	%rax, %rax
180009ec0:     	je	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009ec6:     	leaq	0x2fa3(%rip), %rdx      # 0x18000ce70
180009ecd:     	movq	%rax, %rcx
180009ed0:     	callq	*0x2292(%rip)           # 0x18000c168
180009ed6:     	movl	(%rbx), %edx
180009ed8:     	movq	%rax, 0x9db9(%rip)      # 0x180013c98
180009edf:     	testl	%edx, %edx
180009ee1:     	js	0x180009efa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x641a>
180009ee3:     	subl	$0x1, %edx
180009ee6:     	movl	%edx, (%rbx)
180009ee8:     	jne	0x180009efa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x641a>
180009eea:     	movq	%rbx, %rcx
180009eed:     	callq	*0x22d5(%rip)           # 0x18000c1c8
180009ef3:     	movq	0x9d9e(%rip), %rax      # 0x180013c98
180009efa:     	testq	%rax, %rax
180009efd:     	je	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009f03:     	movq	%rdi, %rdx
180009f06:     	movq	%rsi, %rcx
180009f09:     	callq	*0x23a9(%rip)           # 0x18000c2b8
180009f0f:     	movq	%rax, %rdi
180009f12:     	testq	%rax, %rax
180009f15:     	je	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009f17:     	movq	0x9d7a(%rip), %rcx      # 0x180013c98
180009f1e:     	xorl	%r8d, %r8d
180009f21:     	movq	%rax, %rdx
180009f24:     	callq	*0x226e(%rip)           # 0x18000c198
180009f2a:     	movl	(%rdi), %ecx
180009f2c:     	movq	%rax, %rbx
180009f2f:     	testl	%ecx, %ecx
180009f31:     	js	0x180009f43 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6463>
180009f33:     	subl	$0x1, %ecx
180009f36:     	movl	%ecx, (%rdi)
180009f38:     	jne	0x180009f43 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6463>
180009f3a:     	movq	%rdi, %rcx
180009f3d:     	callq	*0x2285(%rip)           # 0x18000c1c8
180009f43:     	testq	%rbx, %rbx
180009f46:     	je	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009f48:     	movq	0x8(%rbx), %r8
180009f4c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180009f57:     	jne	0x180009f95 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64b5>
180009f59:     	movq	0x2340(%rip), %rcx      # 0x18000c2a0
180009f60:     	leaq	0x3101(%rip), %rdx      # 0x18000d068
180009f67:     	movq	0x18(%r8), %r8
180009f6b:     	movq	(%rcx), %rcx
180009f6e:     	callq	*0x227c(%rip)           # 0x18000c1f0
180009f74:     	movl	(%rbx), %eax
180009f76:     	testl	%eax, %eax
180009f78:     	js	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009f7a:     	subl	$0x1, %eax
180009f7d:     	movl	%eax, (%rbx)
180009f7f:     	jne	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009f81:     	movq	%rbx, %rcx
180009f84:     	callq	*0x223e(%rip)           # 0x18000c1c8
180009f8a:     	xorl	%eax, %eax
180009f8c:     	addq	$0x28, %rsp
180009f90:     	popq	%rdi
180009f91:     	popq	%rsi
180009f92:     	popq	%rbp
180009f93:     	popq	%rbx
180009f94:     	retq
180009f95:     	xorl	%r8d, %r8d
180009f98:     	leaq	0x93a1(%rip), %rcx      # 0x180013340
180009f9f:     	xorl	%edx, %edx
180009fa1:     	callq	*0x22a1(%rip)           # 0x18000c248
180009fa7:     	movq	%rax, %rdi
180009faa:     	testq	%rax, %rax
180009fad:     	je	0x180009f74 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6494>
180009faf:     	movq	%rbp, %rcx
180009fb2:     	movq	%rbx, 0x18(%rax)
180009fb6:     	callq	*0x2204(%rip)           # 0x18000c1c0
180009fbc:     	movq	%rax, 0x10(%rdi)
180009fc0:     	movq	%rax, %rcx
180009fc3:     	testq	%rax, %rax
180009fc6:     	jne	0x180009fda <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64fa>
180009fc8:     	movl	(%rdi), %eax
180009fca:     	testl	%eax, %eax
180009fcc:     	js	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009fce:     	subl	$0x1, %eax
180009fd1:     	movl	%eax, (%rdi)
180009fd3:     	jne	0x180009f8a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64aa>
180009fd5:     	movq	%rdi, %rcx
180009fd8:     	jmp	0x180009f84 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x64a4>
180009fda:     	movl	(%rax), %eax
180009fdc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009fe1:     	jae	0x180009fe7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6507>
180009fe3:     	incl	%eax
180009fe5:     	movl	%eax, (%rcx)
180009fe7:     	movq	%rdi, %rax
180009fea:     	addq	$0x28, %rsp
180009fee:     	popq	%rdi
180009fef:     	popq	%rsi
180009ff0:     	popq	%rbp
180009ff1:     	popq	%rbx
180009ff2:     	retq
180009ff3:     	int3
180009ff4:     	int3
180009ff5:     	int3
180009ff6:     	int3
180009ff7:     	int3
180009ff8:     	int3
180009ff9:     	int3
180009ffa:     	int3
180009ffb:     	int3
180009ffc:     	int3
180009ffd:     	int3
180009ffe:     	int3
180009fff:     	int3
18000a000:     	movq	%r9, 0x20(%rsp)
18000a005:     	movq	%r8, 0x18(%rsp)
18000a00a:     	movq	%rdx, 0x10(%rsp)
18000a00f:     	movq	%rcx, 0x8(%rsp)
18000a014:     	pushq	%rbx
18000a015:     	pushq	%rbp
18000a016:     	pushq	%rsi
18000a017:     	pushq	%rdi
18000a018:     	pushq	%r12
18000a01a:     	pushq	%r13
18000a01c:     	pushq	%r14
18000a01e:     	pushq	%r15
18000a020:     	subq	$0x68, %rsp
18000a024:     	movq	%rcx, %r14
18000a027:     	movq	%r9, %r15
18000a02a:     	leaq	0x2aef(%rip), %rcx      # 0x18000cb20
18000a031:     	movq	%r8, %r13
18000a034:     	movq	%rdx, %rsi
18000a037:     	callq	*0x21fb(%rip)           # 0x18000c238
18000a03d:     	movq	%rax, %rdi
18000a040:     	testq	%rax, %rax
18000a043:     	jne	0x18000a07c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x659c>
18000a045:     	movq	0x20ec(%rip), %rcx      # 0x18000c138
18000a04c:     	movq	(%rcx), %rcx
18000a04f:     	callq	*0x215b(%rip)           # 0x18000c1b0
18000a055:     	testl	%eax, %eax
18000a057:     	je	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a05d:     	callq	*0x225d(%rip)           # 0x18000c2c0
18000a063:     	leaq	0x2ad6(%rip), %rcx      # 0x18000cb40
18000a06a:     	callq	*0x21c8(%rip)           # 0x18000c238
18000a070:     	movq	%rax, %rdi
18000a073:     	testq	%rax, %rax
18000a076:     	je	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a07c:     	leaq	0x2add(%rip), %rdx      # 0x18000cb60
18000a083:     	movq	%rdi, %rcx
18000a086:     	callq	*0x20dc(%rip)           # 0x18000c168
18000a08c:     	movl	(%rdi), %ecx
18000a08e:     	movq	%rax, %rbx
18000a091:     	testl	%ecx, %ecx
18000a093:     	js	0x18000a0a5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x65c5>
18000a095:     	subl	$0x1, %ecx
18000a098:     	movl	%ecx, (%rdi)
18000a09a:     	jne	0x18000a0a5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x65c5>
18000a09c:     	movq	%rdi, %rcx
18000a09f:     	callq	*0x2123(%rip)           # 0x18000c1c8
18000a0a5:     	testq	%rbx, %rbx
18000a0a8:     	je	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a0ae:     	movq	0x204b(%rip), %rax      # 0x18000c100
18000a0b5:     	cmpq	%rax, 0x8(%rbx)
18000a0b9:     	je	0x18000a0f5 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6615>
18000a0bb:     	movq	0x21ee(%rip), %rcx      # 0x18000c2b0
18000a0c2:     	leaq	0x2aa7(%rip), %rdx      # 0x18000cb70
18000a0c9:     	movq	(%rcx), %rcx
18000a0cc:     	callq	*0x21d6(%rip)           # 0x18000c2a8
18000a0d2:     	movl	(%rbx), %eax
18000a0d4:     	testl	%eax, %eax
18000a0d6:     	js	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a0dc:     	subl	$0x1, %eax
18000a0df:     	movl	%eax, (%rbx)
18000a0e1:     	jne	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a0e7:     	movq	%rbx, %rcx
18000a0ea:     	callq	*0x20d8(%rip)           # 0x18000c1c8
18000a0f0:     	jmp	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a0f5:     	xorl	%edx, %edx
18000a0f7:     	movq	%rbx, %rcx
18000a0fa:     	callq	*0x20a8(%rip)           # 0x18000c1a8
18000a100:     	movl	(%rbx), %ecx
18000a102:     	movq	%rax, 0x9b77(%rip)      # 0x180013c80
18000a109:     	testl	%ecx, %ecx
18000a10b:     	js	0x18000a124 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6644>
18000a10d:     	subl	$0x1, %ecx
18000a110:     	movl	%ecx, (%rbx)
18000a112:     	jne	0x18000a124 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6644>
18000a114:     	movq	%rbx, %rcx
18000a117:     	callq	*0x20ab(%rip)           # 0x18000c1c8
18000a11d:     	movq	0x9b5c(%rip), %rax      # 0x180013c80
18000a124:     	testq	%rax, %rax
18000a127:     	jne	0x18000a142 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6662>
18000a129:     	leaq	0x2a68(%rip), %rdx      # 0x18000cb98
18000a130:     	movq	0x2179(%rip), %rcx      # 0x18000c2b0
18000a137:     	movq	(%rcx), %rcx
18000a13a:     	callq	*0x2168(%rip)           # 0x18000c2a8
18000a140:     	jmp	0x18000a177 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6697>
18000a142:     	callq	*(%rax)
18000a144:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
18000a149:     	jbe	0x18000a1aa <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66ca>
18000a14b:     	movq	0x215e(%rip), %rax      # 0x18000c2b0
18000a152:     	movq	(%rax), %rbx
18000a155:     	movq	0x9b24(%rip), %rax      # 0x180013c80
18000a15c:     	callq	*(%rax)
18000a15e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
18000a164:     	leaq	0x2a55(%rip), %rdx      # 0x18000cbc0
18000a16b:     	movl	%eax, %r9d
18000a16e:     	movq	%rbx, %rcx
18000a171:     	callq	*0x2079(%rip)           # 0x18000c1f0
18000a177:     	callq	*0x1f9b(%rip)           # 0x18000c118
18000a17d:     	movq	0x1f8c(%rip), %rcx      # 0x18000c110
18000a184:     	leaq	0x2c5d(%rip), %rdx      # 0x18000cde8
18000a18b:     	movq	(%rcx), %rcx
18000a18e:     	callq	*0x2114(%rip)           # 0x18000c2a8
18000a194:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a199:     	addq	$0x68, %rsp
18000a19d:     	popq	%r15
18000a19f:     	popq	%r14
18000a1a1:     	popq	%r13
18000a1a3:     	popq	%r12
18000a1a5:     	popq	%rdi
18000a1a6:     	popq	%rsi
18000a1a7:     	popq	%rbp
18000a1a8:     	popq	%rbx
18000a1a9:     	retq
18000a1aa:     	movq	0x9acf(%rip), %rax      # 0x180013c80
18000a1b1:     	callq	*0x698(%rax)
18000a1b7:     	movl	%eax, 0x9acf(%rip)      # 0x180013c8c
18000a1bd:     	cmpl	$0x10, %eax
18000a1c0:     	jge	0x18000a1de <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66fe>
18000a1c2:     	movq	0x20e7(%rip), %rcx      # 0x18000c2b0
18000a1c9:     	leaq	0x2a40(%rip), %rdx      # 0x18000cc10
18000a1d0:     	movl	%eax, %r9d
18000a1d3:     	movl	$0x10, %r8d
18000a1d9:     	movq	(%rcx), %rcx
18000a1dc:     	jmp	0x18000a171 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6691>
18000a1de:     	movq	0x9a9b(%rip), %rax      # 0x180013c80
18000a1e5:     	callq	*0x690(%rax)
18000a1eb:     	testl	%eax, %eax
18000a1ed:     	jne	0x18000a1fb <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x671b>
18000a1ef:     	leaq	0x2b6a(%rip), %rdx      # 0x18000cd60
18000a1f6:     	jmp	0x18000a130 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6650>
18000a1fb:     	cmpl	$0x1, %eax
18000a1fe:     	je	0x18000a20c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x672c>
18000a200:     	leaq	0x2b89(%rip), %rdx      # 0x18000cd90
18000a207:     	jmp	0x18000a130 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6650>
18000a20c:     	leaq	0x960d(%rip), %rcx      # 0x180013820
18000a213:     	callq	*0x1f57(%rip)           # 0x18000c170
18000a219:     	testl	%eax, %eax
18000a21b:     	jne	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a221:     	leaq	0x9118(%rip), %rcx      # 0x180013340
18000a228:     	callq	*0x1f42(%rip)           # 0x18000c170
18000a22e:     	testl	%eax, %eax
18000a230:     	jne	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a236:     	leaq	0x9443(%rip), %rcx      # 0x180013680
18000a23d:     	callq	*0x1f2d(%rip)           # 0x18000c170
18000a243:     	testl	%eax, %eax
18000a245:     	jne	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a24b:     	xorl	%ebx, %ebx
18000a24d:     	cmpl	%ebx, 0x9a35(%rip)      # 0x180013c88
18000a253:     	jne	0x18000a296 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x67b6>
18000a255:     	movq	%gs:0x58, %rax
18000a25e:     	movl	0x9a3c(%rip), %ecx      # 0x180013ca0
18000a264:     	movl	$0x1, 0x9a1a(%rip)      # 0x180013c88
18000a26e:     	movq	(%rax,%rcx,8), %rdx
18000a272:     	movl	$0x10, %eax
18000a277:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a27e:     	movl	$0x9f0, %eax            # imm = 0x9F0
18000a283:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a28a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000a28f:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a296:     	movl	%ebx, 0x999c(%rip)      # 0x180013c38
18000a29c:     	movq	%rbx, %rax
18000a29f:     	movb	%bl, 0x999b(%rip)       # 0x180013c40
18000a2a5:     	movq	%rbx, %rcx
18000a2a8:     	xchgq	%rax, 0x9999(%rip)      # 0x180013c48
18000a2af:     	xchgq	%rcx, 0x999a(%rip)      # 0x180013c50
18000a2b6:     	movq	%rbx, %rax
18000a2b9:     	movq	%rbx, %rcx
18000a2bc:     	xchgq	%rax, 0x9995(%rip)      # 0x180013c58
18000a2c3:     	xchgq	%rcx, 0x9996(%rip)      # 0x180013c60
18000a2ca:     	movq	0x1d8f(%rip), %rax      # 0x18000c060
18000a2d1:     	leaq	0x9208(%rip), %rcx      # 0x1800134e0
18000a2d8:     	movq	%rax, 0x9989(%rip)      # 0x180013c68
18000a2df:     	movq	0x1d8a(%rip), %rax      # 0x18000c070
18000a2e6:     	movq	%rax, 0x9983(%rip)      # 0x180013c70
18000a2ed:     	movq	0x1d74(%rip), %rax      # 0x18000c068
18000a2f4:     	movq	%rax, 0x997d(%rip)      # 0x180013c78
18000a2fb:     	movq	0x1f46(%rip), %rax      # 0x18000c248
18000a302:     	movq	%rax, 0x930f(%rip)      # 0x180013618
18000a309:     	callq	*0x1e61(%rip)           # 0x18000c170
18000a30f:     	testl	%eax, %eax
18000a311:     	jne	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a317:     	leaq	0x2be2(%rip), %rdx      # 0x18000cf00
18000a31e:     	movq	%r14, %rcx
18000a321:     	callq	*0x1e41(%rip)           # 0x18000c168
18000a327:     	movq	%rax, 0x28(%rsp)
18000a32c:     	movq	%rax, %rdi
18000a32f:     	testq	%rax, %rax
18000a332:     	je	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a338:     	leaq	0x2d5a(%rip), %rcx      # 0x18000d099
18000a33f:     	callq	*0x1f3b(%rip)           # 0x18000c280
18000a345:     	movq	%rax, 0x20(%rsp)
18000a34a:     	movq	%rax, %r12
18000a34d:     	testq	%rax, %rax
18000a350:     	je	0x18000a694 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6bb4>
18000a356:     	movl	%ebx, %ebp
18000a358:     	cmpq	%rbx, (%rsi)
18000a35b:     	je	0x18000a504 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6a24>
18000a361:     	movslq	%ebp, %rbx
18000a364:     	leaq	0x30(%rsp), %rdx
18000a369:     	movq	%r14, %rcx
18000a36c:     	leaq	(%rbx,%rbx,4), %rax
18000a370:     	movups	(%r13,%rax,8), %xmm0
18000a376:     	movups	0x10(%r13,%rax,8), %xmm1
18000a37c:     	movaps	%xmm0, 0x30(%rsp)
18000a381:     	movsd	0x20(%r13,%rax,8), %xmm0
18000a388:     	movsd	%xmm0, 0x50(%rsp)
18000a38e:     	movaps	%xmm1, 0x40(%rsp)
18000a393:     	callq	0x180009e90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x63b0>
18000a398:     	movq	%rax, %r14
18000a39b:     	testq	%rax, %rax
18000a39e:     	je	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a3a4:     	movq	(%rsi), %rcx
18000a3a7:     	callq	*0x1ed3(%rip)           # 0x18000c280
18000a3ad:     	movq	%rax, %r13
18000a3b0:     	testq	%rax, %rax
18000a3b3:     	je	0x18000a6b7 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6bd7>
18000a3b9:     	movq	(%r15,%rbx,8), %rcx
18000a3bd:     	xorl	%edx, %edx
18000a3bf:     	movq	%r14, (%rcx)
18000a3c2:     	leaq	0x9457(%rip), %rcx      # 0x180013820
18000a3c9:     	movq	0x8(%rsi), %r12
18000a3cd:     	callq	*0x1d7d(%rip)           # 0x18000c150
18000a3d3:     	movq	%rax, %rbx
18000a3d6:     	testq	%rax, %rax
18000a3d9:     	je	0x18000a456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6976>
18000a3db:     	movq	%r13, %rcx
18000a3de:     	callq	*0x1d9c(%rip)           # 0x18000c180
18000a3e4:     	movq	%rax, %rdi
18000a3e7:     	testq	%rax, %rax
18000a3ea:     	je	0x18000a40c <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x692c>
18000a3ec:     	movq	%rax, %rcx
18000a3ef:     	callq	0x18000bc95 <numba_list_iter_next+0xed5>
18000a3f4:     	leaq	0x1(%rax), %rcx
18000a3f8:     	callq	*0x1e52(%rip)           # 0x18000c250
18000a3fe:     	movq	%rax, %rsi
18000a401:     	testq	%rax, %rax
18000a404:     	jne	0x18000a414 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6934>
18000a406:     	callq	*0x1d34(%rip)           # 0x18000c140
18000a40c:     	xorl	%eax, %eax
18000a40e:     	movq	%rax, 0x20(%rbx)
18000a412:     	jmp	0x18000a445 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6965>
18000a414:     	movq	%rdi, %rdx
18000a417:     	movq	%rsi, %rcx
18000a41a:     	callq	0x18000bc8f <numba_list_iter_next+0xecf>
18000a41f:     	movq	0x20(%rsp), %rcx
18000a424:     	movq	%rsi, 0x20(%rbx)
18000a428:     	movq	%r12, 0x28(%rbx)
18000a42c:     	movl	$0x3, 0x30(%rbx)
18000a433:     	callq	0x180009910 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x5e30>
18000a438:     	movq	%rax, 0x38(%rbx)
18000a43c:     	testq	%rax, %rax
18000a43f:     	jne	0x18000a5b0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6ad0>
18000a445:     	movl	(%rbx), %eax
18000a447:     	testl	%eax, %eax
18000a449:     	js	0x18000a456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6976>
18000a44b:     	subl	$0x1, %eax
18000a44e:     	movl	%eax, (%rbx)
18000a450:     	je	0x18000a5fd <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b1d>
18000a456:     	xorl	%edi, %edi
18000a458:     	movl	(%r14), %eax
18000a45b:     	testl	%eax, %eax
18000a45d:     	js	0x18000a470 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6990>
18000a45f:     	subl	$0x1, %eax
18000a462:     	movl	%eax, (%r14)
18000a465:     	jne	0x18000a470 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6990>
18000a467:     	movq	%r14, %rcx
18000a46a:     	callq	*0x1d58(%rip)           # 0x18000c1c8
18000a470:     	movl	(%r13), %eax
18000a474:     	testl	%eax, %eax
18000a476:     	js	0x18000a48a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x69aa>
18000a478:     	subl	$0x1, %eax
18000a47b:     	movl	%eax, (%r13)
18000a47f:     	jne	0x18000a48a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x69aa>
18000a481:     	movq	%r13, %rcx
18000a484:     	callq	*0x1d3e(%rip)           # 0x18000c1c8
18000a48a:     	testq	%rdi, %rdi
18000a48d:     	je	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a493:     	movq	0xb8(%rsp), %rsi
18000a49b:     	movq	%rdi, %r8
18000a49e:     	movq	0xb0(%rsp), %r14
18000a4a6:     	movq	%r14, %rcx
18000a4a9:     	movq	(%rsi), %rdx
18000a4ac:     	callq	*0x1d6e(%rip)           # 0x18000c220
18000a4b2:     	movl	(%rdi), %ecx
18000a4b4:     	testl	%eax, %eax
18000a4b6:     	jne	0x18000a65a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b7a>
18000a4bc:     	testl	%ecx, %ecx
18000a4be:     	js	0x18000a4d2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x69f2>
18000a4c0:     	leal	-0x1(%rcx), %eax
18000a4c3:     	movl	%eax, (%rdi)
18000a4c5:     	testl	%eax, %eax
18000a4c7:     	jne	0x18000a4d2 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x69f2>
18000a4c9:     	movq	%rdi, %rcx
18000a4cc:     	callq	*0x1cf6(%rip)           # 0x18000c1c8
18000a4d2:     	movq	0xc8(%rsp), %r15
18000a4da:     	addq	$0x20, %rsi
18000a4de:     	movq	0xc0(%rsp), %r13
18000a4e6:     	incl	%ebp
18000a4e8:     	movq	%rsi, 0xb8(%rsp)
18000a4f0:     	cmpq	$0x0, (%rsi)
18000a4f4:     	jne	0x18000a361 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6881>
18000a4fa:     	movq	0x20(%rsp), %r12
18000a4ff:     	movq	0x28(%rsp), %rdi
18000a504:     	movslq	%ebp, %rax
18000a507:     	cmpq	$0x0, (%r15,%rax,8)
18000a50c:     	je	0x18000a579 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6a99>
18000a50e:     	nop
18000a510:     	movslq	%ebp, %rbx
18000a513:     	leaq	0x30(%rsp), %rdx
18000a518:     	movq	%r14, %rcx
18000a51b:     	leaq	(%rbx,%rbx,4), %rax
18000a51f:     	movups	(%r13,%rax,8), %xmm0
18000a525:     	movups	0x10(%r13,%rax,8), %xmm1
18000a52b:     	movaps	%xmm0, 0x30(%rsp)
18000a530:     	movsd	0x20(%r13,%rax,8), %xmm0
18000a537:     	movsd	%xmm0, 0x50(%rsp)
18000a53d:     	movaps	%xmm1, 0x40(%rsp)
18000a542:     	callq	0x180009e90 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x63b0>
18000a547:     	testq	%rax, %rax
18000a54a:     	je	0x18000a675 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b95>
18000a550:     	movq	(%r15,%rbx,8), %rcx
18000a554:     	movq	%rax, (%rcx)
18000a557:     	movl	(%rax), %ecx
18000a559:     	testl	%ecx, %ecx
18000a55b:     	js	0x18000a56d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6a8d>
18000a55d:     	subl	$0x1, %ecx
18000a560:     	movl	%ecx, (%rax)
18000a562:     	jne	0x18000a56d <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6a8d>
18000a564:     	movq	%rax, %rcx
18000a567:     	callq	*0x1c5b(%rip)           # 0x18000c1c8
18000a56d:     	incl	%ebp
18000a56f:     	movslq	%ebp, %rax
18000a572:     	cmpq	$0x0, (%r15,%rax,8)
18000a577:     	jne	0x18000a510 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6a30>
18000a579:     	movl	(%r12), %eax
18000a57d:     	testl	%eax, %eax
18000a57f:     	js	0x18000a593 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6ab3>
18000a581:     	subl	$0x1, %eax
18000a584:     	movl	%eax, (%r12)
18000a588:     	jne	0x18000a593 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6ab3>
18000a58a:     	movq	%r12, %rcx
18000a58d:     	callq	*0x1c35(%rip)           # 0x18000c1c8
18000a593:     	movl	(%rdi), %eax
18000a595:     	testl	%eax, %eax
18000a597:     	js	0x18000a5a9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6ac9>
18000a599:     	subl	$0x1, %eax
18000a59c:     	movl	%eax, (%rdi)
18000a59e:     	jne	0x18000a5a9 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6ac9>
18000a5a0:     	movq	%rdi, %rcx
18000a5a3:     	callq	*0x1c1f(%rip)           # 0x18000c1c8
18000a5a9:     	xorl	%eax, %eax
18000a5ab:     	jmp	0x18000a199 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b9>
18000a5b0:     	movl	(%r14), %eax
18000a5b3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a5b8:     	jae	0x18000a5bf <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6adf>
18000a5ba:     	incl	%eax
18000a5bc:     	movl	%eax, (%r14)
18000a5bf:     	movq	0xb0(%rsp), %rcx
18000a5c7:     	leaq	0x2932(%rip), %rdx      # 0x18000cf00
18000a5ce:     	movq	%r14, 0x18(%rbx)
18000a5d2:     	movq	$0x0, 0x40(%rbx)
18000a5da:     	callq	*0x1b88(%rip)           # 0x18000c168
18000a5e0:     	movq	%rax, %rsi
18000a5e3:     	testq	%rax, %rax
18000a5e6:     	jne	0x18000a60b <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b2b>
18000a5e8:     	movl	(%rbx), %eax
18000a5ea:     	testl	%eax, %eax
18000a5ec:     	js	0x18000a456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6976>
18000a5f2:     	subl	$0x1, %eax
18000a5f5:     	movl	%eax, (%rbx)
18000a5f7:     	jne	0x18000a456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6976>
18000a5fd:     	movq	%rbx, %rcx
18000a600:     	callq	*0x1bc2(%rip)           # 0x18000c1c8
18000a606:     	jmp	0x18000a456 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6976>
18000a60b:     	xorl	%r9d, %r9d
18000a60e:     	leaq	0x20(%rbx), %rcx
18000a612:     	movq	%rsi, %r8
18000a615:     	movq	%rbx, %rdx
18000a618:     	callq	*0x1b2a(%rip)           # 0x18000c148
18000a61e:     	movq	%rax, %rdi
18000a621:     	movl	(%rbx), %eax
18000a623:     	testl	%eax, %eax
18000a625:     	js	0x18000a637 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b57>
18000a627:     	subl	$0x1, %eax
18000a62a:     	movl	%eax, (%rbx)
18000a62c:     	jne	0x18000a637 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b57>
18000a62e:     	movq	%rbx, %rcx
18000a631:     	callq	*0x1b91(%rip)           # 0x18000c1c8
18000a637:     	movl	(%rsi), %eax
18000a639:     	testl	%eax, %eax
18000a63b:     	js	0x18000a458 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6978>
18000a641:     	subl	$0x1, %eax
18000a644:     	movl	%eax, (%rsi)
18000a646:     	jne	0x18000a458 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6978>
18000a64c:     	movq	%rsi, %rcx
18000a64f:     	callq	*0x1b73(%rip)           # 0x18000c1c8
18000a655:     	jmp	0x18000a458 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6978>
18000a65a:     	testl	%ecx, %ecx
18000a65c:     	js	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a65e:     	leal	-0x1(%rcx), %eax
18000a661:     	movl	%eax, (%rdi)
18000a663:     	testl	%eax, %eax
18000a665:     	jne	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a667:     	movq	%rdi, %rcx
18000a66a:     	callq	*0x1b58(%rip)           # 0x18000c1c8
18000a670:     	movq	0x20(%rsp), %r12
18000a675:     	movl	(%r12), %eax
18000a679:     	testl	%eax, %eax
18000a67b:     	js	0x18000a68f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6baf>
18000a67d:     	subl	$0x1, %eax
18000a680:     	movl	%eax, (%r12)
18000a684:     	jne	0x18000a68f <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6baf>
18000a686:     	movq	%r12, %rcx
18000a689:     	callq	*0x1b39(%rip)           # 0x18000c1c8
18000a68f:     	movq	0x28(%rsp), %rdi
18000a694:     	movl	(%rdi), %eax
18000a696:     	testl	%eax, %eax
18000a698:     	js	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a69e:     	subl	$0x1, %eax
18000a6a1:     	movl	%eax, (%rdi)
18000a6a3:     	jne	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a6a9:     	movq	%rdi, %rcx
18000a6ac:     	callq	*0x1b16(%rip)           # 0x18000c1c8
18000a6b2:     	jmp	0x18000a194 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x66b4>
18000a6b7:     	movl	(%r14), %eax
18000a6ba:     	testl	%eax, %eax
18000a6bc:     	js	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a6be:     	subl	$0x1, %eax
18000a6c1:     	movl	%eax, (%r14)
18000a6c4:     	jne	0x18000a670 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b90>
18000a6c6:     	movq	%r14, %rcx
18000a6c9:     	jmp	0x18000a66a <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6b8a>
18000a6cb:     	int3
18000a6cc:     	int3
18000a6cd:     	int3
18000a6ce:     	int3
18000a6cf:     	int3
18000a6d0:     	leaq	0x9609(%rip), %rax      # 0x180013ce0
18000a6d7:     	retq
18000a6d8:     	int3
18000a6d9:     	int3
18000a6da:     	int3
18000a6db:     	int3
18000a6dc:     	int3
18000a6dd:     	int3
18000a6de:     	int3
18000a6df:     	int3

000000018000a6e0 <numba_list_set_method_table>:
18000a6e0:     	movups	(%rdx), %xmm0
18000a6e3:     	movups	%xmm0, 0x20(%rcx)
18000a6e7:     	retq
18000a6e8:     	int3
18000a6e9:     	int3
18000a6ea:     	int3
18000a6eb:     	int3
18000a6ec:     	int3
18000a6ed:     	int3
18000a6ee:     	int3
18000a6ef:     	int3

000000018000a6f0 <numba_list_new>:
18000a6f0:     	pushq	%rbx
18000a6f2:     	pushq	%rbp
18000a6f3:     	pushq	%rsi
18000a6f4:     	pushq	%rdi
18000a6f5:     	subq	$0x28, %rsp
18000a6f9:     	movq	%rcx, %rsi
18000a6fc:     	movq	%r8, %rdi
18000a6ff:     	movl	$0x38, %ecx
18000a704:     	movq	%rdx, %rbp
18000a707:     	callq	*0x1953(%rip)           # 0x18000c060
18000a70d:     	movq	%rax, %rbx
18000a710:     	testq	%rax, %rax
18000a713:     	je	0x18000a77d <numba_list_new+0x8d>
18000a715:     	movq	$0x0, (%rax)
18000a71c:     	xorps	%xmm0, %xmm0
18000a71f:     	movq	%rbp, 0x8(%rax)
18000a723:     	movq	%rdi, 0x10(%rax)
18000a727:     	movl	$0x1, 0x18(%rax)
18000a72e:     	movups	%xmm0, 0x20(%rax)
18000a732:     	testq	%rdi, %rdi
18000a735:     	je	0x18000a78b <numba_list_new+0x9b>
18000a737:     	imulq	%rbp, %rdi
18000a73b:     	movl	$0x8, %ecx
18000a740:     	movq	%rdi, %rax
18000a743:     	cqto
18000a745:     	andl	$0x7, %edx
18000a748:     	addq	%rdx, %rax
18000a74b:     	andl	$0x7, %eax
18000a74e:     	subq	%rdx, %rax
18000a751:     	subq	%rax, %rcx
18000a754:     	movq	%rcx, %rax
18000a757:     	cqto
18000a759:     	andl	$0x7, %edx
18000a75c:     	leaq	(%rdx,%rax), %rcx
18000a760:     	andl	$0x7, %ecx
18000a763:     	subq	%rdx, %rcx
18000a766:     	addq	%rdi, %rcx
18000a769:     	callq	*0x18f1(%rip)           # 0x18000c060
18000a76f:     	testq	%rax, %rax
18000a772:     	jne	0x18000a78d <numba_list_new+0x9d>
18000a774:     	movq	%rbx, %rcx
18000a777:     	callq	*0x18eb(%rip)           # 0x18000c068
18000a77d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000a782:     	addq	$0x28, %rsp
18000a786:     	popq	%rdi
18000a787:     	popq	%rsi
18000a788:     	popq	%rbp
18000a789:     	popq	%rbx
18000a78a:     	retq
18000a78b:     	xorl	%eax, %eax
18000a78d:     	movq	%rax, 0x30(%rbx)
18000a791:     	xorl	%eax, %eax
18000a793:     	movq	%rbx, (%rsi)
18000a796:     	addq	$0x28, %rsp
18000a79a:     	popq	%rdi
18000a79b:     	popq	%rsi
18000a79c:     	popq	%rbp
18000a79d:     	popq	%rbx
18000a79e:     	retq
18000a79f:     	int3

000000018000a7a0 <numba_list_free>:
18000a7a0:     	pushq	%rbx
18000a7a2:     	subq	$0x20, %rsp
18000a7a6:     	cmpq	$0x0, 0x28(%rcx)
18000a7ab:     	movq	%rcx, %rbx
18000a7ae:     	je	0x18000a7e4 <numba_list_free+0x44>
18000a7b0:     	movq	%rdi, 0x30(%rsp)
18000a7b5:     	xorl	%edi, %edi
18000a7b7:     	cmpq	%rdi, (%rcx)
18000a7ba:     	jle	0x18000a7df <numba_list_free+0x3f>
18000a7bc:     	nopl	(%rax)
18000a7c0:     	movq	0x28(%rbx), %rax
18000a7c4:     	testq	%rax, %rax
18000a7c7:     	je	0x18000a7d7 <numba_list_free+0x37>
18000a7c9:     	movq	%rdi, %rcx
18000a7cc:     	imulq	0x8(%rbx), %rcx
18000a7d1:     	addq	0x30(%rbx), %rcx
18000a7d5:     	callq	*%rax
18000a7d7:     	incq	%rdi
18000a7da:     	cmpq	(%rbx), %rdi
18000a7dd:     	jl	0x18000a7c0 <numba_list_free+0x20>
18000a7df:     	movq	0x30(%rsp), %rdi
18000a7e4:     	movq	0x30(%rbx), %rcx
18000a7e8:     	testq	%rcx, %rcx
18000a7eb:     	je	0x18000a7f3 <numba_list_free+0x53>
18000a7ed:     	callq	*0x1875(%rip)           # 0x18000c068
18000a7f3:     	movq	%rbx, %rcx
18000a7f6:     	addq	$0x20, %rsp
18000a7fa:     	popq	%rbx
18000a7fb:     	jmpq	*0x1866(%rip)           # 0x18000c068
18000a802:     	int3
18000a803:     	int3
18000a804:     	int3
18000a805:     	int3
18000a806:     	int3
18000a807:     	int3
18000a808:     	int3
18000a809:     	int3
18000a80a:     	int3
18000a80b:     	int3
18000a80c:     	int3
18000a80d:     	int3
18000a80e:     	int3
18000a80f:     	int3

000000018000a810 <numba_list_base_ptr>:
18000a810:     	movq	0x30(%rcx), %rax
18000a814:     	retq
18000a815:     	int3
18000a816:     	int3
18000a817:     	int3
18000a818:     	int3
18000a819:     	int3
18000a81a:     	int3
18000a81b:     	int3
18000a81c:     	int3
18000a81d:     	int3
18000a81e:     	int3
18000a81f:     	int3

000000018000a820 <numba_list_size_address>:
18000a820:     	movq	%rcx, %rax
18000a823:     	retq
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

000000018000a830 <numba_list_length>:
18000a830:     	movq	(%rcx), %rax
18000a833:     	retq
18000a834:     	int3
18000a835:     	int3
18000a836:     	int3
18000a837:     	int3
18000a838:     	int3
18000a839:     	int3
18000a83a:     	int3
18000a83b:     	int3
18000a83c:     	int3
18000a83d:     	int3
18000a83e:     	int3
18000a83f:     	int3

000000018000a840 <numba_list_allocated>:
18000a840:     	movq	0x10(%rcx), %rax
18000a844:     	retq
18000a845:     	int3
18000a846:     	int3
18000a847:     	int3
18000a848:     	int3
18000a849:     	int3
18000a84a:     	int3
18000a84b:     	int3
18000a84c:     	int3
18000a84d:     	int3
18000a84e:     	int3
18000a84f:     	int3

000000018000a850 <numba_list_is_mutable>:
18000a850:     	movl	0x18(%rcx), %eax
18000a853:     	retq
18000a854:     	int3
18000a855:     	int3
18000a856:     	int3
18000a857:     	int3
18000a858:     	int3
18000a859:     	int3
18000a85a:     	int3
18000a85b:     	int3
18000a85c:     	int3
18000a85d:     	int3
18000a85e:     	int3
18000a85f:     	int3

000000018000a860 <numba_list_set_is_mutable>:
18000a860:     	movl	%edx, 0x18(%rcx)
18000a863:     	retq
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

000000018000a870 <numba_list_setitem>:
18000a870:     	movq	%rbx, 0x10(%rsp)
18000a875:     	pushq	%rsi
18000a876:     	subq	$0x20, %rsp
18000a87a:     	cmpl	$0x0, 0x18(%rcx)
18000a87e:     	movq	%r8, %rsi
18000a881:     	movq	%rcx, %rbx
18000a884:     	jne	0x18000a896 <numba_list_setitem+0x26>
18000a886:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000a88b:     	movq	0x38(%rsp), %rbx
18000a890:     	addq	$0x20, %rsp
18000a894:     	popq	%rsi
18000a895:     	retq
18000a896:     	cmpq	(%rcx), %rdx
18000a899:     	jb	0x18000a8ab <numba_list_setitem+0x3b>
18000a89b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a8a0:     	movq	0x38(%rsp), %rbx
18000a8a5:     	addq	$0x20, %rsp
18000a8a9:     	popq	%rsi
18000a8aa:     	retq
18000a8ab:     	imulq	0x8(%rcx), %rdx
18000a8b0:     	movq	0x28(%rcx), %rax
18000a8b4:     	movq	%rdi, 0x30(%rsp)
18000a8b9:     	movq	0x30(%rcx), %rdi
18000a8bd:     	addq	%rdx, %rdi
18000a8c0:     	testq	%rax, %rax
18000a8c3:     	je	0x18000a8ca <numba_list_setitem+0x5a>
18000a8c5:     	movq	%rdi, %rcx
18000a8c8:     	callq	*%rax
18000a8ca:     	movq	0x8(%rbx), %r8
18000a8ce:     	movq	%rsi, %rdx
18000a8d1:     	movq	%rdi, %rcx
18000a8d4:     	callq	0x18000bc83 <numba_list_iter_next+0xec3>
18000a8d9:     	movq	0x20(%rbx), %rax
18000a8dd:     	testq	%rax, %rax
18000a8e0:     	je	0x18000a8e7 <numba_list_setitem+0x77>
18000a8e2:     	movq	%rdi, %rcx
18000a8e5:     	callq	*%rax
18000a8e7:     	movq	0x30(%rsp), %rdi
18000a8ec:     	xorl	%eax, %eax
18000a8ee:     	movq	0x38(%rsp), %rbx
18000a8f3:     	addq	$0x20, %rsp
18000a8f7:     	popq	%rsi
18000a8f8:     	retq
18000a8f9:     	int3
18000a8fa:     	int3
18000a8fb:     	int3
18000a8fc:     	int3
18000a8fd:     	int3
18000a8fe:     	int3
18000a8ff:     	int3

000000018000a900 <numba_list_getitem>:
18000a900:     	subq	$0x28, %rsp
18000a904:     	movq	%r8, %r9
18000a907:     	movq	%rdx, %rax
18000a90a:     	cmpq	(%rcx), %rdx
18000a90d:     	jb	0x18000a919 <numba_list_getitem+0x19>
18000a90f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a914:     	addq	$0x28, %rsp
18000a918:     	retq
18000a919:     	movq	0x8(%rcx), %r8
18000a91d:     	movq	%r8, %rdx
18000a920:     	imulq	%rax, %rdx
18000a924:     	addq	0x30(%rcx), %rdx
18000a928:     	movq	%r9, %rcx
18000a92b:     	callq	0x18000bc83 <numba_list_iter_next+0xec3>
18000a930:     	xorl	%eax, %eax
18000a932:     	addq	$0x28, %rsp
18000a936:     	retq
18000a937:     	int3
18000a938:     	int3
18000a939:     	int3
18000a93a:     	int3
18000a93b:     	int3
18000a93c:     	int3
18000a93d:     	int3
18000a93e:     	int3
18000a93f:     	int3

000000018000a940 <numba_list_append>:
18000a940:     	movq	%rbx, 0x10(%rsp)
18000a945:     	pushq	%rsi
18000a946:     	subq	$0x20, %rsp
18000a94a:     	cmpl	$0x0, 0x18(%rcx)
18000a94e:     	movq	%rdx, %rsi
18000a951:     	movq	%rcx, %rbx
18000a954:     	jne	0x18000a966 <numba_list_append+0x26>
18000a956:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000a95b:     	movq	0x38(%rsp), %rbx
18000a960:     	addq	$0x20, %rsp
18000a964:     	popq	%rsi
18000a965:     	retq
18000a966:     	movq	(%rcx), %rdx
18000a969:     	incq	%rdx
18000a96c:     	callq	0x18000a9c0 <numba_list_resize>
18000a971:     	testl	%eax, %eax
18000a973:     	js	0x18000a9ac <numba_list_append+0x6c>
18000a975:     	movq	0x8(%rbx), %r8
18000a979:     	movq	%rsi, %rdx
18000a97c:     	movq	%rdi, 0x30(%rsp)
18000a981:     	movq	(%rbx), %rdi
18000a984:     	decq	%rdi
18000a987:     	imulq	%r8, %rdi
18000a98b:     	addq	0x30(%rbx), %rdi
18000a98f:     	movq	%rdi, %rcx
18000a992:     	callq	0x18000bc83 <numba_list_iter_next+0xec3>
18000a997:     	movq	0x20(%rbx), %rax
18000a99b:     	testq	%rax, %rax
18000a99e:     	je	0x18000a9a5 <numba_list_append+0x65>
18000a9a0:     	movq	%rdi, %rcx
18000a9a3:     	callq	*%rax
18000a9a5:     	movq	0x30(%rsp), %rdi
18000a9aa:     	xorl	%eax, %eax
18000a9ac:     	movq	0x38(%rsp), %rbx
18000a9b1:     	addq	$0x20, %rsp
18000a9b5:     	popq	%rsi
18000a9b6:     	retq
18000a9b7:     	int3
18000a9b8:     	int3
18000a9b9:     	int3
18000a9ba:     	int3
18000a9bb:     	int3
18000a9bc:     	int3
18000a9bd:     	int3
18000a9be:     	int3
18000a9bf:     	int3

000000018000a9c0 <numba_list_resize>:
18000a9c0:     	movq	%rsi, 0x18(%rsp)
18000a9c5:     	pushq	%rdi
18000a9c6:     	subq	$0x20, %rsp
18000a9ca:     	cmpl	$0x0, 0x18(%rcx)
18000a9ce:     	movq	%rdx, %rsi
18000a9d1:     	movq	%rcx, %rdi
18000a9d4:     	jne	0x18000a9e6 <numba_list_resize+0x26>
18000a9d6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000a9db:     	movq	0x40(%rsp), %rsi
18000a9e0:     	addq	$0x20, %rsp
18000a9e4:     	popq	%rdi
18000a9e5:     	retq
18000a9e6:     	movq	0x10(%rcx), %rax
18000a9ea:     	cmpq	%rsi, %rax
18000a9ed:     	jl	0x18000aa07 <numba_list_resize+0x47>
18000a9ef:     	sarq	%rax
18000a9f2:     	cmpq	%rax, %rsi
18000a9f5:     	jl	0x18000aa07 <numba_list_resize+0x47>
18000a9f7:     	movq	%rsi, (%rcx)
18000a9fa:     	xorl	%eax, %eax
18000a9fc:     	movq	0x40(%rsp), %rsi
18000aa01:     	addq	$0x20, %rsp
18000aa05:     	popq	%rdi
18000aa06:     	retq
18000aa07:     	cmpq	$0x9, %rsi
18000aa0b:     	movq	%rbp, 0x38(%rsp)
18000aa10:     	movl	$0x3, %ecx
18000aa15:     	movl	$0x6, %eax
18000aa1a:     	cmovll	%ecx, %eax
18000aa1d:     	movq	%rsi, %r8
18000aa20:     	movq	0x8(%rdi), %rcx
18000aa24:     	addq	%rsi, %rax
18000aa27:     	sarq	$0x3, %r8
18000aa2b:     	xorl	%edx, %edx
18000aa2d:     	addq	%rax, %r8
18000aa30:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000aa3a:     	divq	%rcx
18000aa3d:     	cmpq	%rax, %r8
18000aa40:     	ja	0x18000aabb <numba_list_resize+0xfb>
18000aa42:     	xorl	%ebp, %ebp
18000aa44:     	movq	%rbx, 0x30(%rsp)
18000aa49:     	testq	%rsi, %rsi
18000aa4c:     	cmovneq	%r8, %rbp
18000aa50:     	movq	%rbp, %rbx
18000aa53:     	imulq	%rcx, %rbx
18000aa57:     	movl	$0x8, %ecx
18000aa5c:     	movq	%rbx, %rax
18000aa5f:     	cqto
18000aa61:     	andl	$0x7, %edx
18000aa64:     	addq	%rdx, %rax
18000aa67:     	andl	$0x7, %eax
18000aa6a:     	subq	%rdx, %rax
18000aa6d:     	subq	%rax, %rcx
18000aa70:     	movq	%rcx, %rax
18000aa73:     	movq	0x30(%rdi), %rcx
18000aa77:     	cqto
18000aa79:     	andl	$0x7, %edx
18000aa7c:     	addq	%rdx, %rax
18000aa7f:     	andl	$0x7, %eax
18000aa82:     	subq	%rdx, %rax
18000aa85:     	leaq	(%rbx,%rax), %rdx
18000aa89:     	callq	*0x15e1(%rip)           # 0x18000c070
18000aa8f:     	testq	%rbx, %rbx
18000aa92:     	movq	0x30(%rsp), %rbx
18000aa97:     	je	0x18000aa9e <numba_list_resize+0xde>
18000aa99:     	testq	%rax, %rax
18000aa9c:     	je	0x18000aabb <numba_list_resize+0xfb>
18000aa9e:     	movq	%rax, 0x30(%rdi)
18000aaa2:     	xorl	%eax, %eax
18000aaa4:     	movq	%rbp, 0x10(%rdi)
18000aaa8:     	movq	0x38(%rsp), %rbp
18000aaad:     	movq	%rsi, (%rdi)
18000aab0:     	movq	0x40(%rsp), %rsi
18000aab5:     	addq	$0x20, %rsp
18000aab9:     	popq	%rdi
18000aaba:     	retq
18000aabb:     	movq	0x38(%rsp), %rbp
18000aac0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000aac5:     	movq	0x40(%rsp), %rsi
18000aaca:     	addq	$0x20, %rsp
18000aace:     	popq	%rdi
18000aacf:     	retq

000000018000aad0 <numba_list_delitem>:
18000aad0:     	movq	%rbx, 0x10(%rsp)
18000aad5:     	pushq	%rdi
18000aad6:     	subq	$0x20, %rsp
18000aada:     	cmpl	$0x0, 0x18(%rcx)
18000aade:     	movq	%rdx, %rdi
18000aae1:     	movq	%rcx, %rbx
18000aae4:     	jne	0x18000aaf6 <numba_list_delitem+0x26>
18000aae6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000aaeb:     	movq	0x38(%rsp), %rbx
18000aaf0:     	addq	$0x20, %rsp
18000aaf4:     	popq	%rdi
18000aaf5:     	retq
18000aaf6:     	cmpq	(%rcx), %rdi
18000aaf9:     	jb	0x18000ab0b <numba_list_delitem+0x3b>
18000aafb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000ab00:     	movq	0x38(%rsp), %rbx
18000ab05:     	addq	$0x20, %rsp
18000ab09:     	popq	%rdi
18000ab0a:     	retq
18000ab0b:     	movq	0x28(%rcx), %rax
18000ab0f:     	movq	%rsi, 0x30(%rsp)
18000ab14:     	movq	%rdi, %rsi
18000ab17:     	imulq	0x8(%rcx), %rsi
18000ab1c:     	addq	0x30(%rcx), %rsi
18000ab20:     	testq	%rax, %rax
18000ab23:     	je	0x18000ab2a <numba_list_delitem+0x5a>
18000ab25:     	movq	%rsi, %rcx
18000ab28:     	callq	*%rax
18000ab2a:     	movq	(%rbx), %r8
18000ab2d:     	leaq	-0x1(%r8), %rax
18000ab31:     	cmpq	%rax, %rdi
18000ab34:     	je	0x18000ab56 <numba_list_delitem+0x86>
18000ab36:     	subq	%rdi, %r8
18000ab39:     	leaq	0x1(%rdi), %rdx
18000ab3d:     	imulq	0x8(%rbx), %rdx
18000ab42:     	decq	%r8
18000ab45:     	movq	%rsi, %rcx
18000ab48:     	imulq	0x8(%rbx), %r8
18000ab4d:     	addq	0x30(%rbx), %rdx
18000ab51:     	callq	0x18000bc89 <numba_list_iter_next+0xec9>
18000ab56:     	movq	(%rbx), %rdx
18000ab59:     	movq	%rbx, %rcx
18000ab5c:     	decq	%rdx
18000ab5f:     	callq	0x18000a9c0 <numba_list_resize>
18000ab64:     	movq	0x30(%rsp), %rsi
18000ab69:     	xorl	%ecx, %ecx
18000ab6b:     	movq	0x38(%rsp), %rbx
18000ab70:     	testl	%eax, %eax
18000ab72:     	cmovsl	%eax, %ecx
18000ab75:     	movl	%ecx, %eax
18000ab77:     	addq	$0x20, %rsp
18000ab7b:     	popq	%rdi
18000ab7c:     	retq
18000ab7d:     	int3
18000ab7e:     	int3
18000ab7f:     	int3

000000018000ab80 <numba_list_delete_slice>:
18000ab80:     	pushq	%rbx
18000ab82:     	pushq	%rbp
18000ab83:     	pushq	%rdi
18000ab84:     	pushq	%r15
18000ab86:     	subq	$0x38, %rsp
18000ab8a:     	cmpl	$0x0, 0x18(%rcx)
18000ab8e:     	movq	%r9, %rdi
18000ab91:     	movq	%r8, %rbp
18000ab94:     	movq	%rdx, %r15
18000ab97:     	movq	%rcx, %rbx
18000ab9a:     	jne	0x18000abab <numba_list_delete_slice+0x2b>
18000ab9c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000aba1:     	addq	$0x38, %rsp
18000aba5:     	popq	%r15
18000aba7:     	popq	%rdi
18000aba8:     	popq	%rbp
18000aba9:     	popq	%rbx
18000abaa:     	retq
18000abab:     	movq	%r13, 0x78(%rsp)
18000abb0:     	testq	%rdi, %rdi
18000abb3:     	jle	0x18000abd2 <numba_list_delete_slice+0x52>
18000abb5:     	cmpq	%r8, %r15
18000abb8:     	jge	0x18000ad71 <numba_list_delete_slice+0x1f1>
18000abbe:     	movq	%r8, %rax
18000abc1:     	subq	%r15, %rax
18000abc4:     	decq	%rax
18000abc7:     	cqto
18000abc9:     	idivq	%rdi
18000abcc:     	leal	0x1(%rax), %r13d
18000abd0:     	jmp	0x18000abf2 <numba_list_delete_slice+0x72>
18000abd2:     	cmpq	%r15, %r8
18000abd5:     	jge	0x18000ad71 <numba_list_delete_slice+0x1f1>
18000abdb:     	movq	%r15, %rax
18000abde:     	movl	$0x1, %r13d
18000abe4:     	subq	%r8, %rax
18000abe7:     	decq	%rax
18000abea:     	cqto
18000abec:     	idivq	%rdi
18000abef:     	subl	%eax, %r13d
18000abf2:     	testl	%r13d, %r13d
18000abf5:     	jle	0x18000ad71 <numba_list_delete_slice+0x1f1>
18000abfb:     	movq	%rsi, 0x68(%rsp)
18000ac00:     	movl	(%rcx), %esi
18000ac02:     	subl	%r13d, %esi
18000ac05:     	movl	%esi, 0x20(%rsp)
18000ac09:     	testq	%rdi, %rdi
18000ac0c:     	jns	0x18000ac27 <numba_list_delete_slice+0xa7>
18000ac0e:     	leaq	0x1(%r15), %rbp
18000ac12:     	leal	-0x1(%r13), %eax
18000ac16:     	movslq	%eax, %rcx
18000ac19:     	leaq	-0x1(%rbp), %r15
18000ac1d:     	imulq	%rdi, %rcx
18000ac21:     	addq	%rcx, %r15
18000ac24:     	negq	%rdi
18000ac27:     	cmpq	$0x1, %rdi
18000ac2b:     	jne	0x18000ac77 <numba_list_delete_slice+0xf7>
18000ac2d:     	cmpq	$0x0, 0x28(%rbx)
18000ac32:     	je	0x18000ac59 <numba_list_delete_slice+0xd9>
18000ac34:     	movslq	%r15d, %rdi
18000ac37:     	cmpq	%rbp, %rdi
18000ac3a:     	jge	0x18000ac59 <numba_list_delete_slice+0xd9>
18000ac3c:     	nopl	(%rax)
18000ac40:     	movslq	%edi, %rcx
18000ac43:     	imulq	0x8(%rbx), %rcx
18000ac48:     	addq	0x30(%rbx), %rcx
18000ac4c:     	callq	*0x28(%rbx)
18000ac4f:     	incl	%edi
18000ac51:     	movslq	%edi, %rax
18000ac54:     	cmpq	%rbp, %rax
18000ac57:     	jl	0x18000ac40 <numba_list_delete_slice+0xc0>
18000ac59:     	movq	0x8(%rbx), %rcx
18000ac5d:     	movq	(%rbx), %r8
18000ac60:     	movq	%rcx, %rdx
18000ac63:     	subq	%rbp, %r8
18000ac66:     	imulq	%rcx, %r8
18000ac6a:     	imulq	%rbp, %rdx
18000ac6e:     	imulq	%r15, %rcx
18000ac72:     	jmp	0x18000ad3c <numba_list_delete_slice+0x1bc>
18000ac77:     	movq	%r14, 0x30(%rsp)
18000ac7c:     	movq	%r15, %r14
18000ac7f:     	movl	$0x0, 0x60(%rsp)
18000ac87:     	cmpq	%rbp, %r15
18000ac8a:     	jge	0x18000ad09 <numba_list_delete_slice+0x189>
18000ac8c:     	movq	%r12, 0x70(%rsp)
18000ac91:     	movq	(%rbx), %rax
18000ac94:     	leaq	(%r14,%rdi), %r12
18000ac98:     	cmpq	%rax, %r12
18000ac9b:     	jl	0x18000aca8 <numba_list_delete_slice+0x128>
18000ac9d:     	movq	%r14, %rsi
18000aca0:     	notq	%rsi
18000aca3:     	addq	%rax, %rsi
18000aca6:     	jmp	0x18000acac <numba_list_delete_slice+0x12c>
18000aca8:     	leaq	-0x1(%rdi), %rsi
18000acac:     	movq	0x28(%rbx), %rax
18000acb0:     	testq	%rax, %rax
18000acb3:     	je	0x18000acc3 <numba_list_delete_slice+0x143>
18000acb5:     	movq	%r14, %rcx
18000acb8:     	imulq	0x8(%rbx), %rcx
18000acbd:     	addq	0x30(%rbx), %rcx
18000acc1:     	callq	*%rax
18000acc3:     	movq	0x8(%rbx), %r9
18000acc7:     	leaq	0x1(%r14), %rdx
18000accb:     	movq	0x30(%rbx), %r10
18000accf:     	movq	%r9, %r8
18000acd2:     	imulq	%rsi, %r8
18000acd6:     	imulq	%r9, %rdx
18000acda:     	movslq	0x60(%rsp), %rsi
18000acdf:     	subq	%rsi, %r14
18000ace2:     	imulq	%r9, %r14
18000ace6:     	addq	%r10, %rdx
18000ace9:     	leaq	(%r10,%r14), %rcx
18000aced:     	callq	0x18000bc89 <numba_list_iter_next+0xec9>
18000acf2:     	incl	%esi
18000acf4:     	movq	%r12, %r14
18000acf7:     	movl	%esi, 0x60(%rsp)
18000acfb:     	cmpq	%rbp, %r12
18000acfe:     	jl	0x18000ac91 <numba_list_delete_slice+0x111>
18000ad00:     	movq	0x70(%rsp), %r12
18000ad05:     	movl	0x20(%rsp), %esi
18000ad09:     	movq	(%rbx), %r8
18000ad0c:     	movq	0x30(%rsp), %r14
18000ad11:     	movslq	%r13d, %r10
18000ad14:     	movq	%r10, %rcx
18000ad17:     	imulq	%rdi, %rcx
18000ad1b:     	addq	%r15, %rcx
18000ad1e:     	cmpq	%r8, %rcx
18000ad21:     	jge	0x18000ad49 <numba_list_delete_slice+0x1c9>
18000ad23:     	movq	0x8(%rbx), %rax
18000ad27:     	subq	%rcx, %r8
18000ad2a:     	movq	%rax, %rdx
18000ad2d:     	imulq	%rcx, %rdx
18000ad31:     	imulq	%rax, %r8
18000ad35:     	subq	%r10, %rcx
18000ad38:     	imulq	%rax, %rcx
18000ad3c:     	addq	0x30(%rbx), %rdx
18000ad40:     	addq	0x30(%rbx), %rcx
18000ad44:     	callq	0x18000bc89 <numba_list_iter_next+0xec9>
18000ad49:     	movslq	%esi, %rdx
18000ad4c:     	movq	%rbx, %rcx
18000ad4f:     	callq	0x18000a9c0 <numba_list_resize>
18000ad54:     	movq	0x68(%rsp), %rsi
18000ad59:     	xorl	%ecx, %ecx
18000ad5b:     	movq	0x78(%rsp), %r13
18000ad60:     	testl	%eax, %eax
18000ad62:     	cmovsl	%eax, %ecx
18000ad65:     	movl	%ecx, %eax
18000ad67:     	addq	$0x38, %rsp
18000ad6b:     	popq	%r15
18000ad6d:     	popq	%rdi
18000ad6e:     	popq	%rbp
18000ad6f:     	popq	%rbx
18000ad70:     	retq
18000ad71:     	movq	0x78(%rsp), %r13
18000ad76:     	xorl	%eax, %eax
18000ad78:     	addq	$0x38, %rsp
18000ad7c:     	popq	%r15
18000ad7e:     	popq	%rdi
18000ad7f:     	popq	%rbp
18000ad80:     	popq	%rbx
18000ad81:     	retq
18000ad82:     	int3
18000ad83:     	int3
18000ad84:     	int3
18000ad85:     	int3
18000ad86:     	int3
18000ad87:     	int3
18000ad88:     	int3
18000ad89:     	int3
18000ad8a:     	int3
18000ad8b:     	int3
18000ad8c:     	int3
18000ad8d:     	int3
18000ad8e:     	int3
18000ad8f:     	int3

000000018000ad90 <numba_list_iter_sizeof>:
18000ad90:     	movl	$0x18, %eax
18000ad95:     	retq
18000ad96:     	int3
18000ad97:     	int3
18000ad98:     	int3
18000ad99:     	int3
18000ad9a:     	int3
18000ad9b:     	int3
18000ad9c:     	int3
18000ad9d:     	int3
18000ad9e:     	int3
18000ad9f:     	int3

000000018000ada0 <numba_list_iter>:
18000ada0:     	movq	%rdx, (%rcx)
18000ada3:     	movq	(%rdx), %rax
18000ada6:     	movq	%rax, 0x8(%rcx)
18000adaa:     	movq	$0x0, 0x10(%rcx)
18000adb2:     	retq
18000adb3:     	int3
18000adb4:     	int3
18000adb5:     	int3
18000adb6:     	int3
18000adb7:     	int3
18000adb8:     	int3
18000adb9:     	int3
18000adba:     	int3
18000adbb:     	int3
18000adbc:     	int3
18000adbd:     	int3
18000adbe:     	int3
18000adbf:     	int3

000000018000adc0 <numba_list_iter_next>:
18000adc0:     	movq	(%rcx), %r8
18000adc3:     	movq	(%r8), %r9
18000adc6:     	cmpq	0x8(%rcx), %r9
18000adca:     	je	0x18000add2 <numba_list_iter_next+0x12>
18000adcc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
18000add1:     	retq
18000add2:     	movq	0x10(%rcx), %rax
18000add6:     	cmpq	%r9, %rax
18000add9:     	jge	0x18000adee <numba_list_iter_next+0x2e>
18000addb:     	imulq	0x8(%r8), %rax
18000ade0:     	addq	0x30(%r8), %rax
18000ade4:     	movq	%rax, (%rdx)
18000ade7:     	incq	0x10(%rcx)
18000adeb:     	xorl	%eax, %eax
18000aded:     	retq
18000adee:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
18000adf3:     	retq
18000adf4:     	int3
18000adf5:     	int3
18000adf6:     	int3
18000adf7:     	int3
18000adf8:     	int3
18000adf9:     	int3
18000adfa:     	int3
18000adfb:     	int3
18000adfc:     	int3
18000adfd:     	int3
18000adfe:     	int3
18000adff:     	int3
18000ae00:     	pushq	%rbx
18000ae02:     	subq	$0x20, %rsp
18000ae06:     	movq	%rcx, %rbx
18000ae09:     	addq	$0x30, %rcx
18000ae0d:     	callq	*0x8e55(%rip)           # 0x180013c68
18000ae13:     	cmpb	$0x0, 0x8e26(%rip)      # 0x180013c40
18000ae1a:     	je	0x18000ae24 <numba_list_iter_next+0x64>
18000ae1c:     	lock
18000ae1d:     	incq	0x8e24(%rip)            # 0x180013c48
18000ae24:     	testq	%rax, %rax
18000ae27:     	je	0x18000ae68 <numba_list_iter_next+0xa8>
18000ae29:     	leaq	0x30(%rax), %rdx
18000ae2d:     	testq	%rdx, %rdx
18000ae30:     	je	0x18000ae68 <numba_list_iter_next+0xa8>
18000ae32:     	xorl	%r8d, %r8d
18000ae35:     	movl	$0x1, %ecx
18000ae3a:     	xchgq	%rcx, (%rax)
18000ae3d:     	movq	%r8, 0x8(%rax)
18000ae41:     	movq	%r8, 0x10(%rax)
18000ae45:     	movq	%rdx, 0x18(%rax)
18000ae49:     	movq	%rbx, 0x20(%rax)
18000ae4d:     	movq	%r8, 0x28(%rax)
18000ae51:     	cmpb	%r8b, 0x8de8(%rip)      # 0x180013c40
18000ae58:     	je	0x18000ae6a <numba_list_iter_next+0xaa>
18000ae5a:     	lock
18000ae5b:     	incq	0x8df6(%rip)            # 0x180013c58
18000ae62:     	addq	$0x20, %rsp
18000ae66:     	popq	%rbx
18000ae67:     	retq
18000ae68:     	xorl	%eax, %eax
18000ae6a:     	addq	$0x20, %rsp
18000ae6e:     	popq	%rbx
18000ae6f:     	retq
18000ae70:     	movq	%rbx, 0x8(%rsp)
18000ae75:     	pushq	%rdi
18000ae76:     	subq	$0x20, %rsp
18000ae7a:     	movq	%rcx, %rdi
18000ae7d:     	movq	%rdx, %rbx
18000ae80:     	addq	$0x30, %rcx
18000ae84:     	testq	%rdx, %rdx
18000ae87:     	je	0x18000ae91 <numba_list_iter_next+0xd1>
18000ae89:     	movq	0x18(%rdx), %rdx
18000ae8d:     	callq	*(%rbx)
18000ae8f:     	jmp	0x18000ae97 <numba_list_iter_next+0xd7>
18000ae91:     	callq	*0x8dd1(%rip)           # 0x180013c68
18000ae97:     	cmpb	$0x0, 0x8da2(%rip)      # 0x180013c40
18000ae9e:     	movq	%rax, %r8
18000aea1:     	je	0x18000aeab <numba_list_iter_next+0xeb>
18000aea3:     	lock
18000aea4:     	incq	0x8d9d(%rip)            # 0x180013c48
18000aeab:     	xorl	%edx, %edx
18000aead:     	leaq	0x30(%r8), %rax
18000aeb1:     	testq	%r8, %r8
18000aeb4:     	movl	%edx, %ecx
18000aeb6:     	cmovneq	%rax, %rcx
18000aeba:     	testq	%rcx, %rcx
18000aebd:     	jne	0x18000aecc <numba_list_iter_next+0x10c>
18000aebf:     	xorl	%eax, %eax
18000aec1:     	movq	0x30(%rsp), %rbx
18000aec6:     	addq	$0x20, %rsp
18000aeca:     	popq	%rdi
18000aecb:     	retq
18000aecc:     	movl	$0x1, %eax
18000aed1:     	xchgq	%rax, (%r8)
18000aed4:     	movq	%rdx, 0x8(%r8)
18000aed8:     	movq	%rdx, 0x10(%r8)
18000aedc:     	movq	%rcx, 0x18(%r8)
18000aee0:     	movq	%rdi, 0x20(%r8)
18000aee4:     	movq	%rbx, 0x28(%r8)
18000aee8:     	cmpb	%dl, 0x8d52(%rip)       # 0x180013c40
18000aeee:     	je	0x18000aef8 <numba_list_iter_next+0x138>
18000aef0:     	lock
18000aef1:     	incq	0x8d60(%rip)            # 0x180013c58
18000aef8:     	movq	0x30(%rsp), %rbx
18000aefd:     	movq	%r8, %rax
18000af00:     	addq	$0x20, %rsp
18000af04:     	popq	%rdi
18000af05:     	retq
18000af06:     	int3
18000af07:     	int3
18000af08:     	int3
18000af09:     	int3
18000af0a:     	int3
18000af0b:     	int3
18000af0c:     	int3
18000af0d:     	int3
18000af0e:     	int3
18000af0f:     	int3
18000af10:     	lock
18000af11:     	incq	(%rcx)
18000af14:     	retq
18000af15:     	int3
18000af16:     	int3
18000af17:     	int3
18000af18:     	int3
18000af19:     	int3
18000af1a:     	int3
18000af1b:     	int3
18000af1c:     	int3
18000af1d:     	int3
18000af1e:     	int3
18000af1f:     	int3
18000af20:     	pushq	%rbx
18000af22:     	subq	$0x20, %rsp
18000af26:     	movq	0x8(%rcx), %rax
18000af2a:     	movq	%rcx, %rbx
18000af2d:     	testq	%rax, %rax
18000af30:     	je	0x18000af49 <numba_list_iter_next+0x189>
18000af32:     	cmpl	$0x0, 0x8cff(%rip)      # 0x180013c38
18000af39:     	jne	0x18000af49 <numba_list_iter_next+0x189>
18000af3b:     	movq	0x10(%rcx), %r8
18000af3f:     	movq	0x20(%rcx), %rdx
18000af43:     	movq	0x18(%rcx), %rcx
18000af47:     	callq	*%rax
18000af49:     	movq	0x28(%rbx), %rax
18000af4d:     	movq	%rbx, %rcx
18000af50:     	testq	%rax, %rax
18000af53:     	je	0x18000af5e <numba_list_iter_next+0x19e>
18000af55:     	movq	0x18(%rax), %rdx
18000af59:     	callq	*0x10(%rax)
18000af5c:     	jmp	0x18000af64 <numba_list_iter_next+0x1a4>
18000af5e:     	callq	*0x8d14(%rip)           # 0x180013c78
18000af64:     	cmpb	$0x0, 0x8cd5(%rip)      # 0x180013c40
18000af6b:     	je	0x18000af89 <numba_list_iter_next+0x1c9>
18000af6d:     	leaq	0x8cdc(%rip), %rax      # 0x180013c50
18000af74:     	lock
18000af75:     	incq	(%rax)
18000af78:     	cmpb	$0x0, 0x8cc1(%rip)      # 0x180013c40
18000af7f:     	je	0x18000af89 <numba_list_iter_next+0x1c9>
18000af81:     	lock
18000af82:     	incq	0x8cd7(%rip)            # 0x180013c60
18000af89:     	addq	$0x20, %rsp
18000af8d:     	popq	%rbx
18000af8e:     	retq
18000af8f:     	int3
18000af90:     	pushq	%rbx
18000af92:     	subq	$0x20, %rsp
18000af96:     	movq	%rcx, %rbx
18000af99:     	movq	$-0x1, %rax
18000afa0:     	lock
18000afa1:     	xaddq	%rax, (%rcx)
18000afa5:     	cmpq	$0x1, %rax
18000afa9:     	jne	0x18000b00b <numba_list_iter_next+0x24b>
18000afab:     	movq	0x8(%rcx), %rax
18000afaf:     	testq	%rax, %rax
18000afb2:     	je	0x18000afcb <numba_list_iter_next+0x20b>
18000afb4:     	cmpl	$0x0, 0x8c7d(%rip)      # 0x180013c38
18000afbb:     	jne	0x18000afcb <numba_list_iter_next+0x20b>
18000afbd:     	movq	0x10(%rcx), %r8
18000afc1:     	movq	0x20(%rcx), %rdx
18000afc5:     	movq	0x18(%rcx), %rcx
18000afc9:     	callq	*%rax
18000afcb:     	movq	0x28(%rbx), %rax
18000afcf:     	movq	%rbx, %rcx
18000afd2:     	testq	%rax, %rax
18000afd5:     	je	0x18000afe0 <numba_list_iter_next+0x220>
18000afd7:     	movq	0x18(%rax), %rdx
18000afdb:     	callq	*0x10(%rax)
18000afde:     	jmp	0x18000afe6 <numba_list_iter_next+0x226>
18000afe0:     	callq	*0x8c92(%rip)           # 0x180013c78
18000afe6:     	cmpb	$0x0, 0x8c53(%rip)      # 0x180013c40
18000afed:     	je	0x18000b00b <numba_list_iter_next+0x24b>
18000afef:     	leaq	0x8c5a(%rip), %rax      # 0x180013c50
18000aff6:     	lock
18000aff7:     	incq	(%rax)
18000affa:     	cmpb	$0x0, 0x8c3f(%rip)      # 0x180013c40
18000b001:     	je	0x18000b00b <numba_list_iter_next+0x24b>
18000b003:     	lock
18000b004:     	incq	0x8c55(%rip)            # 0x180013c60
18000b00b:     	addq	$0x20, %rsp
18000b00f:     	popq	%rbx
18000b010:     	retq
18000b011:     	int3
18000b012:     	int3
18000b013:     	int3
18000b014:     	int3
18000b015:     	int3
18000b016:     	int3
18000b017:     	int3
18000b018:     	int3
18000b019:     	int3
18000b01a:     	int3
18000b01b:     	int3
18000b01c:     	int3
18000b01d:     	int3
18000b01e:     	int3
18000b01f:     	int3
18000b020:     	movq	0x18(%rcx), %rax
18000b024:     	retq
18000b025:     	int3
18000b026:     	int3
18000b027:     	int3
18000b028:     	int3
18000b029:     	int3
18000b02a:     	int3
18000b02b:     	int3
18000b02c:     	int3
18000b02d:     	int3
18000b02e:     	int3
18000b02f:     	int3
18000b030:     	subq	$0x28, %rsp
18000b034:     	callq	*0x8c3e(%rip)           # 0x180013c78
18000b03a:     	cmpb	$0x0, 0x8bff(%rip)      # 0x180013c40
18000b041:     	je	0x18000b04b <numba_list_iter_next+0x28b>
18000b043:     	lock
18000b044:     	incq	0x8c05(%rip)            # 0x180013c50
18000b04b:     	addq	$0x28, %rsp
18000b04f:     	retq
18000b050:     	jmpq	*%r8
18000b053:     	int3
18000b054:     	int3
18000b055:     	int3
18000b056:     	int3
18000b057:     	int3
18000b058:     	int3
18000b059:     	int3
18000b05a:     	int3
18000b05b:     	int3
18000b05c:     	int3
18000b05d:     	int3
18000b05e:     	int3
18000b05f:     	int3
18000b060:     	movq	%rbx, 0x8(%rsp)
18000b065:     	pushq	%rdi
18000b066:     	subq	$0x20, %rsp
18000b06a:     	movq	%rcx, %rdi
18000b06d:     	movq	%rdx, %rbx
18000b070:     	movl	$0x30, %ecx
18000b075:     	callq	*0x8bed(%rip)           # 0x180013c68
18000b07b:     	cmpb	$0x0, 0x8bbe(%rip)      # 0x180013c40
18000b082:     	je	0x18000b08c <numba_list_iter_next+0x2cc>
18000b084:     	lock
18000b085:     	incq	0x8bbc(%rip)            # 0x180013c48
18000b08c:     	testq	%rax, %rax
18000b08f:     	je	0x18000b0c6 <numba_list_iter_next+0x306>
18000b091:     	leaq	-0x48(%rip), %rcx       # 0x18000b050 <numba_list_iter_next+0x290>
18000b098:     	movl	$0x1, %edx
18000b09d:     	xchgq	%rdx, (%rax)
18000b0a0:     	movq	%rcx, 0x8(%rax)
18000b0a4:     	xorl	%ecx, %ecx
18000b0a6:     	movq	%rcx, 0x20(%rax)
18000b0aa:     	movq	%rcx, 0x28(%rax)
18000b0ae:     	movq	%rbx, 0x10(%rax)
18000b0b2:     	movq	%rdi, 0x18(%rax)
18000b0b6:     	cmpb	%cl, 0x8b84(%rip)       # 0x180013c40
18000b0bc:     	je	0x18000b0c6 <numba_list_iter_next+0x306>
18000b0be:     	lock
18000b0bf:     	incq	0x8b92(%rip)            # 0x180013c58
18000b0c6:     	movq	0x30(%rsp), %rbx
18000b0cb:     	addq	$0x20, %rsp
18000b0cf:     	popq	%rdi
18000b0d0:     	retq
18000b0d1:     	jmpq	*0x1239(%rip)           # 0x18000c310
18000b0d7:     	jmpq	*0x1223(%rip)           # 0x18000c300
18000b0dd:     	jmpq	*0x1215(%rip)           # 0x18000c2f8
18000b0e3:     	jmpq	*0x1207(%rip)           # 0x18000c2f0
18000b0e9:     	jmpq	*0x11f9(%rip)           # 0x18000c2e8
18000b0ef:     	jmpq	*0x11eb(%rip)           # 0x18000c2e0
18000b0f5:     	jmpq	*0x11dd(%rip)           # 0x18000c2d8
18000b0fb:     	jmpq	*0x11c7(%rip)           # 0x18000c2c8
18000b101:     	jmpq	*0x11b9(%rip)           # 0x18000c2c0
18000b107:     	jmpq	*0x11ab(%rip)           # 0x18000c2b8
18000b10d:     	jmpq	*0x1195(%rip)           # 0x18000c2a8
18000b113:     	jmpq	*0x116f(%rip)           # 0x18000c288
18000b119:     	jmpq	*0x1161(%rip)           # 0x18000c280
18000b11f:     	jmpq	*0x1153(%rip)           # 0x18000c278
18000b125:     	jmpq	*0x1145(%rip)           # 0x18000c270
18000b12b:     	jmpq	*0x10ff(%rip)           # 0x18000c230
18000b131:     	int3
18000b132:     	int3
18000b133:     	int3
18000b134:     	int3
18000b135:     	int3
18000b136:     	int3
18000b137:     	int3
18000b138:     	int3
18000b139:     	int3
18000b13a:     	int3
18000b13b:     	int3
18000b13c:     	int3
18000b13d:     	int3
18000b13e:     	int3
18000b13f:     	int3
18000b140:     	int3
18000b141:     	int3
18000b142:     	int3
18000b143:     	int3
18000b144:     	int3
18000b145:     	int3
18000b146:     	nopw	(%rax,%rax)
18000b150:     	cmpq	0x7fa9(%rip), %rcx      # 0x180013100
18000b157:     	jne	0x18000b169 <numba_list_iter_next+0x3a9>
18000b159:     	rolq	$0x10, %rcx
18000b15d:     	testw	$0xffff, %cx            # imm = 0xFFFF
18000b162:     	jne	0x18000b165 <numba_list_iter_next+0x3a5>
18000b164:     	retq
18000b165:     	rorq	$0x10, %rcx
18000b169:     	jmp	0x18000b4c4 <numba_list_iter_next+0x704>
18000b16e:     	int3
18000b16f:     	int3
18000b170:     	subq	$0x28, %rsp
18000b174:     	testl	%edx, %edx
18000b176:     	je	0x18000b1b1 <numba_list_iter_next+0x3f1>
18000b178:     	subl	$0x1, %edx
18000b17b:     	je	0x18000b1a5 <numba_list_iter_next+0x3e5>
18000b17d:     	subl	$0x1, %edx
18000b180:     	je	0x18000b198 <numba_list_iter_next+0x3d8>
18000b182:     	cmpl	$0x1, %edx
18000b185:     	je	0x18000b191 <numba_list_iter_next+0x3d1>
18000b187:     	movl	$0x1, %eax
18000b18c:     	addq	$0x28, %rsp
18000b190:     	retq
18000b191:     	callq	0x18000b690 <numba_list_iter_next+0x8d0>
18000b196:     	jmp	0x18000b19d <numba_list_iter_next+0x3dd>
18000b198:     	callq	0x18000b668 <numba_list_iter_next+0x8a8>
18000b19d:     	movzbl	%al, %eax
18000b1a0:     	addq	$0x28, %rsp
18000b1a4:     	retq
18000b1a5:     	movq	%r8, %rdx
18000b1a8:     	addq	$0x28, %rsp
18000b1ac:     	jmp	0x18000b1c0 <numba_list_iter_next+0x400>
18000b1b1:     	testq	%r8, %r8
18000b1b4:     	setne	%cl
18000b1b7:     	addq	$0x28, %rsp
18000b1bb:     	jmp	0x18000b2d8 <numba_list_iter_next+0x518>
18000b1c0:     	movq	%rbx, 0x8(%rsp)
18000b1c5:     	movq	%rsi, 0x10(%rsp)
18000b1ca:     	movq	%rdi, 0x20(%rsp)
18000b1cf:     	pushq	%r14
18000b1d1:     	subq	$0x20, %rsp
18000b1d5:     	movq	%rdx, %rsi
18000b1d8:     	movq	%rcx, %r14
18000b1db:     	xorl	%ecx, %ecx
18000b1dd:     	callq	0x18000b74c <numba_list_iter_next+0x98c>
18000b1e2:     	testb	%al, %al
18000b1e4:     	je	0x18000b2b2 <numba_list_iter_next+0x4f2>
18000b1ea:     	callq	0x18000b5e0 <numba_list_iter_next+0x820>
18000b1ef:     	movb	%al, %bl
18000b1f1:     	movb	%al, 0x40(%rsp)
18000b1f5:     	movb	$0x1, %dil
18000b1f8:     	cmpl	$0x0, 0x8809(%rip)      # 0x180013a08
18000b1ff:     	jne	0x18000b2ca <numba_list_iter_next+0x50a>
18000b205:     	movl	$0x1, 0x87f9(%rip)      # 0x180013a08
18000b20f:     	callq	0x18000b650 <numba_list_iter_next+0x890>
18000b214:     	testb	%al, %al
18000b216:     	je	0x18000b267 <numba_list_iter_next+0x4a7>
18000b218:     	callq	0x18000b90c <numba_list_iter_next+0xb4c>
18000b21d:     	callq	0x18000b5a0 <numba_list_iter_next+0x7e0>
18000b222:     	callq	0x18000b5c4 <numba_list_iter_next+0x804>
18000b227:     	leaq	0x1142(%rip), %rdx      # 0x18000c370
18000b22e:     	leaq	0x1133(%rip), %rcx      # 0x18000c368
18000b235:     	callq	0x18000bc52 <numba_list_iter_next+0xe92>
18000b23a:     	testl	%eax, %eax
18000b23c:     	jne	0x18000b267 <numba_list_iter_next+0x4a7>
18000b23e:     	callq	0x18000b61c <numba_list_iter_next+0x85c>
18000b243:     	testb	%al, %al
18000b245:     	je	0x18000b267 <numba_list_iter_next+0x4a7>
18000b247:     	leaq	0x1112(%rip), %rdx      # 0x18000c360
18000b24e:     	leaq	0x1103(%rip), %rcx      # 0x18000c358
18000b255:     	callq	0x18000bc4c <numba_list_iter_next+0xe8c>
18000b25a:     	movl	$0x2, 0x87a4(%rip)      # 0x180013a08
18000b264:     	xorb	%dil, %dil
18000b267:     	movb	%bl, %cl
18000b269:     	callq	0x18000b8ac <numba_list_iter_next+0xaec>
18000b26e:     	testb	%dil, %dil
18000b271:     	jne	0x18000b2b2 <numba_list_iter_next+0x4f2>
18000b273:     	callq	0x18000b8fc <numba_list_iter_next+0xb3c>
18000b278:     	movq	%rax, %rbx
18000b27b:     	cmpq	$0x0, (%rax)
18000b27f:     	je	0x18000b2a5 <numba_list_iter_next+0x4e5>
18000b281:     	movq	%rax, %rcx
18000b284:     	callq	0x18000b814 <numba_list_iter_next+0xa54>
18000b289:     	testb	%al, %al
18000b28b:     	je	0x18000b2a5 <numba_list_iter_next+0x4e5>
18000b28d:     	movq	%rsi, %r8
18000b290:     	movl	$0x2, %edx
18000b295:     	movq	%r14, %rcx
18000b298:     	movq	(%rbx), %rax
18000b29b:     	movq	0x108e(%rip), %r9       # 0x18000c330
18000b2a2:     	callq	*%r9
18000b2a5:     	incl	0x8735(%rip)            # 0x1800139e0
18000b2ab:     	movl	$0x1, %eax
18000b2b0:     	jmp	0x18000b2b4 <numba_list_iter_next+0x4f4>
18000b2b2:     	xorl	%eax, %eax
18000b2b4:     	movq	0x30(%rsp), %rbx
18000b2b9:     	movq	0x38(%rsp), %rsi
18000b2be:     	movq	0x48(%rsp), %rdi
18000b2c3:     	addq	$0x20, %rsp
18000b2c7:     	popq	%r14
18000b2c9:     	retq
18000b2ca:     	movl	$0x7, %ecx
18000b2cf:     	callq	0x18000b904 <numba_list_iter_next+0xb44>
18000b2d4:     	nop
18000b2d5:     	int3
18000b2d6:     	int3
18000b2d7:     	int3
18000b2d8:     	movq	%rbx, 0x8(%rsp)
18000b2dd:     	pushq	%rdi
18000b2de:     	subq	$0x30, %rsp
18000b2e2:     	movb	%cl, %dil
18000b2e5:     	movl	0x86f5(%rip), %eax      # 0x1800139e0
18000b2eb:     	testl	%eax, %eax
18000b2ed:     	jg	0x18000b2fc <numba_list_iter_next+0x53c>
18000b2ef:     	xorl	%eax, %eax
18000b2f1:     	movq	0x40(%rsp), %rbx
18000b2f6:     	addq	$0x30, %rsp
18000b2fa:     	popq	%rdi
18000b2fb:     	retq
18000b2fc:     	decl	%eax
18000b2fe:     	movl	%eax, 0x86dc(%rip)      # 0x1800139e0
18000b304:     	callq	0x18000b5e0 <numba_list_iter_next+0x820>
18000b309:     	movb	%al, %bl
18000b30b:     	movb	%al, 0x20(%rsp)
18000b30f:     	cmpl	$0x2, 0x86f2(%rip)      # 0x180013a08
18000b316:     	jne	0x18000b34e <numba_list_iter_next+0x58e>
18000b318:     	callq	0x18000b708 <numba_list_iter_next+0x948>
18000b31d:     	callq	0x18000b5b0 <numba_list_iter_next+0x7f0>
18000b322:     	callq	0x18000b948 <numba_list_iter_next+0xb88>
18000b327:     	movl	$0x0, 0x86d7(%rip)      # 0x180013a08
18000b331:     	movb	%bl, %cl
18000b333:     	callq	0x18000b8ac <numba_list_iter_next+0xaec>
18000b338:     	xorl	%edx, %edx
18000b33a:     	movb	%dil, %cl
18000b33d:     	callq	0x18000b8d0 <numba_list_iter_next+0xb10>
18000b342:     	movzbl	%al, %ebx
18000b345:     	callq	0x18000b738 <numba_list_iter_next+0x978>
18000b34a:     	movl	%ebx, %eax
18000b34c:     	jmp	0x18000b2f1 <numba_list_iter_next+0x531>
18000b34e:     	movl	$0x7, %ecx
18000b353:     	callq	0x18000b904 <numba_list_iter_next+0xb44>
18000b358:     	nop
18000b359:     	nop
18000b35a:     	int3
18000b35b:     	int3
18000b35c:     	movq	%rsp, %rax
18000b35f:     	movq	%rbx, 0x20(%rax)
18000b363:     	movq	%r8, 0x18(%rax)
18000b367:     	movl	%edx, 0x10(%rax)
18000b36a:     	movq	%rcx, 0x8(%rax)
18000b36e:     	pushq	%rsi
18000b36f:     	pushq	%rdi
18000b370:     	pushq	%r14
18000b372:     	subq	$0x40, %rsp
18000b376:     	movq	%r8, %rsi
18000b379:     	movl	%edx, %edi
18000b37b:     	movq	%rcx, %r14
18000b37e:     	testl	%edx, %edx
18000b380:     	jne	0x18000b391 <numba_list_iter_next+0x5d1>
18000b382:     	cmpl	%edx, 0x8658(%rip)      # 0x1800139e0
18000b388:     	jg	0x18000b391 <numba_list_iter_next+0x5d1>
18000b38a:     	xorl	%eax, %eax
18000b38c:     	jmp	0x18000b476 <numba_list_iter_next+0x6b6>
18000b391:     	leal	-0x1(%rdx), %eax
18000b394:     	cmpl	$0x1, %eax
18000b397:     	ja	0x18000b3d9 <numba_list_iter_next+0x619>
18000b399:     	movq	0x1768(%rip), %rax      # 0x18000cb08
18000b3a0:     	testq	%rax, %rax
18000b3a3:     	jne	0x18000b3aa <numba_list_iter_next+0x5ea>
18000b3a5:     	leal	0x1(%rax), %ebx
18000b3a8:     	jmp	0x18000b3b2 <numba_list_iter_next+0x5f2>
18000b3aa:     	callq	*0xf80(%rip)            # 0x18000c330
18000b3b0:     	movl	%eax, %ebx
18000b3b2:     	movl	%ebx, 0x30(%rsp)
18000b3b6:     	testl	%ebx, %ebx
18000b3b8:     	je	0x18000b46c <numba_list_iter_next+0x6ac>
18000b3be:     	movq	%rsi, %r8
18000b3c1:     	movl	%edi, %edx
18000b3c3:     	movq	%r14, %rcx
18000b3c6:     	callq	0x18000b170 <numba_list_iter_next+0x3b0>
18000b3cb:     	movl	%eax, %ebx
18000b3cd:     	movl	%eax, 0x30(%rsp)
18000b3d1:     	testl	%eax, %eax
18000b3d3:     	je	0x18000b46c <numba_list_iter_next+0x6ac>
18000b3d9:     	movq	%rsi, %r8
18000b3dc:     	movl	%edi, %edx
18000b3de:     	movq	%r14, %rcx
18000b3e1:     	callq	0x18000b57c <numba_list_iter_next+0x7bc>
18000b3e6:     	movl	%eax, %ebx
18000b3e8:     	movl	%eax, 0x30(%rsp)
18000b3ec:     	cmpl	$0x1, %edi
18000b3ef:     	jne	0x18000b427 <numba_list_iter_next+0x667>
18000b3f1:     	testl	%eax, %eax
18000b3f3:     	jne	0x18000b427 <numba_list_iter_next+0x667>
18000b3f5:     	movq	%rsi, %r8
18000b3f8:     	xorl	%edx, %edx
18000b3fa:     	movq	%r14, %rcx
18000b3fd:     	callq	0x18000b57c <numba_list_iter_next+0x7bc>
18000b402:     	testq	%rsi, %rsi
18000b405:     	setne	%cl
18000b408:     	callq	0x18000b2d8 <numba_list_iter_next+0x518>
18000b40d:     	movq	0x16f4(%rip), %rax      # 0x18000cb08
18000b414:     	testq	%rax, %rax
18000b417:     	je	0x18000b427 <numba_list_iter_next+0x667>
18000b419:     	movq	%rsi, %r8
18000b41c:     	xorl	%edx, %edx
18000b41e:     	movq	%r14, %rcx
18000b421:     	callq	*0xf09(%rip)            # 0x18000c330
18000b427:     	testl	%edi, %edi
18000b429:     	je	0x18000b430 <numba_list_iter_next+0x670>
18000b42b:     	cmpl	$0x3, %edi
18000b42e:     	jne	0x18000b46c <numba_list_iter_next+0x6ac>
18000b430:     	movq	%rsi, %r8
18000b433:     	movl	%edi, %edx
18000b435:     	movq	%r14, %rcx
18000b438:     	callq	0x18000b170 <numba_list_iter_next+0x3b0>
18000b43d:     	movl	%eax, %ebx
18000b43f:     	movl	%eax, 0x30(%rsp)
18000b443:     	testl	%eax, %eax
18000b445:     	je	0x18000b46c <numba_list_iter_next+0x6ac>
18000b447:     	movq	0x16ba(%rip), %rax      # 0x18000cb08
18000b44e:     	testq	%rax, %rax
18000b451:     	jne	0x18000b458 <numba_list_iter_next+0x698>
18000b453:     	leal	0x1(%rax), %ebx
18000b456:     	jmp	0x18000b468 <numba_list_iter_next+0x6a8>
18000b458:     	movq	%rsi, %r8
18000b45b:     	movl	%edi, %edx
18000b45d:     	movq	%r14, %rcx
18000b460:     	callq	*0xeca(%rip)            # 0x18000c330
18000b466:     	movl	%eax, %ebx
18000b468:     	movl	%ebx, 0x30(%rsp)
18000b46c:     	jmp	0x18000b474 <numba_list_iter_next+0x6b4>
18000b46e:     	xorl	%ebx, %ebx
18000b470:     	movl	%ebx, 0x30(%rsp)
18000b474:     	movl	%ebx, %eax
18000b476:     	movq	0x78(%rsp), %rbx
18000b47b:     	addq	$0x40, %rsp
18000b47f:     	popq	%r14
18000b481:     	popq	%rdi
18000b482:     	popq	%rsi
18000b483:     	retq
18000b484:     	movq	%rbx, 0x8(%rsp)
18000b489:     	movq	%rsi, 0x10(%rsp)
18000b48e:     	pushq	%rdi
18000b48f:     	subq	$0x20, %rsp
18000b493:     	movq	%r8, %rdi
18000b496:     	movl	%edx, %ebx
18000b498:     	movq	%rcx, %rsi
18000b49b:     	cmpl	$0x1, %edx
18000b49e:     	jne	0x18000b4a5 <numba_list_iter_next+0x6e5>
18000b4a0:     	callq	0x18000b4cc <numba_list_iter_next+0x70c>
18000b4a5:     	movq	%rdi, %r8
18000b4a8:     	movl	%ebx, %edx
18000b4aa:     	movq	%rsi, %rcx
18000b4ad:     	movq	0x30(%rsp), %rbx
18000b4b2:     	movq	0x38(%rsp), %rsi
18000b4b7:     	addq	$0x20, %rsp
18000b4bb:     	popq	%rdi
18000b4bc:     	jmp	0x18000b35c <numba_list_iter_next+0x59c>
18000b4c1:     	int3
18000b4c2:     	int3
18000b4c3:     	int3
18000b4c4:     	movl	$0x2, %ecx
18000b4c9:     	int	$0x29
18000b4cb:     	retq
18000b4cc:     	movq	%rbx, 0x18(%rsp)
18000b4d1:     	pushq	%rbp
18000b4d2:     	movq	%rsp, %rbp
18000b4d5:     	subq	$0x30, %rsp
18000b4d9:     	movq	0x7c20(%rip), %rax      # 0x180013100
18000b4e0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000b4ea:     	cmpq	%rbx, %rax
18000b4ed:     	jne	0x18000b566 <numba_list_iter_next+0x7a6>
18000b4ef:     	leaq	0x10(%rbp), %rcx
18000b4f3:     	movq	$0x0, 0x10(%rbp)
18000b4fb:     	callq	*0xb1f(%rip)            # 0x18000c020
18000b501:     	movq	0x10(%rbp), %rax
18000b505:     	movq	%rax, -0x10(%rbp)
18000b509:     	callq	*0xb09(%rip)            # 0x18000c018
18000b50f:     	movl	%eax, %eax
18000b511:     	xorq	%rax, -0x10(%rbp)
18000b515:     	callq	*0xaf5(%rip)            # 0x18000c010
18000b51b:     	movl	%eax, %eax
18000b51d:     	leaq	0x18(%rbp), %rcx
18000b521:     	xorq	%rax, -0x10(%rbp)
18000b525:     	callq	*0xad5(%rip)            # 0x18000c000
18000b52b:     	movl	0x18(%rbp), %eax
18000b52e:     	leaq	-0x10(%rbp), %rcx
18000b532:     	shlq	$0x20, %rax
18000b536:     	xorq	0x18(%rbp), %rax
18000b53a:     	xorq	-0x10(%rbp), %rax
18000b53e:     	xorq	%rcx, %rax
18000b541:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000b54b:     	andq	%rcx, %rax
18000b54e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
18000b558:     	cmpq	%rbx, %rax
18000b55b:     	cmoveq	%rcx, %rax
18000b55f:     	movq	%rax, 0x7b9a(%rip)      # 0x180013100
18000b566:     	movq	0x50(%rsp), %rbx
18000b56b:     	notq	%rax
18000b56e:     	movq	%rax, 0x7bcb(%rip)      # 0x180013140
18000b575:     	addq	$0x30, %rsp
18000b579:     	popq	%rbp
18000b57a:     	retq
18000b57b:     	int3
18000b57c:     	subq	$0x28, %rsp
18000b580:     	cmpl	$0x1, %edx
18000b583:     	jne	0x18000b595 <numba_list_iter_next+0x7d5>
18000b585:     	cmpq	$0x0, 0x157b(%rip)      # 0x18000cb08
18000b58d:     	jne	0x18000b595 <numba_list_iter_next+0x7d5>
18000b58f:     	callq	*0xa93(%rip)            # 0x18000c028
18000b595:     	movl	$0x1, %eax
18000b59a:     	addq	$0x28, %rsp
18000b59e:     	retq
18000b59f:     	int3
18000b5a0:     	leaq	0x8449(%rip), %rcx      # 0x1800139f0
18000b5a7:     	jmpq	*0xa5a(%rip)            # 0x18000c008
18000b5ae:     	int3
18000b5af:     	int3
18000b5b0:     	leaq	0x8439(%rip), %rcx      # 0x1800139f0
18000b5b7:     	jmp	0x18000bc46 <numba_list_iter_next+0xe86>
18000b5bc:     	leaq	0x843d(%rip), %rax      # 0x180013a00
18000b5c3:     	retq
18000b5c4:     	subq	$0x28, %rsp
18000b5c8:     	callq	0x18000a6d0 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x6bf0>
18000b5cd:     	orq	$0x24, (%rax)
18000b5d1:     	callq	0x18000b5bc <numba_list_iter_next+0x7fc>
18000b5d6:     	orq	$0x2, (%rax)
18000b5da:     	addq	$0x28, %rsp
18000b5de:     	retq
18000b5df:     	int3
18000b5e0:     	subq	$0x28, %rsp
18000b5e4:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b5e9:     	testl	%eax, %eax
18000b5eb:     	je	0x18000b60e <numba_list_iter_next+0x84e>
18000b5ed:     	movq	%gs:0x30, %rax
18000b5f6:     	movq	0x8(%rax), %rcx
18000b5fa:     	jmp	0x18000b601 <numba_list_iter_next+0x841>
18000b5fc:     	cmpq	%rax, %rcx
18000b5ff:     	je	0x18000b615 <numba_list_iter_next+0x855>
18000b601:     	xorl	%eax, %eax
18000b603:     	lock
18000b604:     	cmpxchgq	%rcx, 0x8404(%rip)      # 0x180013a10
18000b60c:     	jne	0x18000b5fc <numba_list_iter_next+0x83c>
18000b60e:     	xorb	%al, %al
18000b610:     	addq	$0x28, %rsp
18000b614:     	retq
18000b615:     	movb	$0x1, %al
18000b617:     	jmp	0x18000b610 <numba_list_iter_next+0x850>
18000b619:     	int3
18000b61a:     	int3
18000b61b:     	int3
18000b61c:     	subq	$0x28, %rsp
18000b620:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b625:     	testl	%eax, %eax
18000b627:     	je	0x18000b630 <numba_list_iter_next+0x870>
18000b629:     	callq	0x18000b988 <numba_list_iter_next+0xbc8>
18000b62e:     	jmp	0x18000b649 <numba_list_iter_next+0x889>
18000b630:     	callq	0x18000bc24 <numba_list_iter_next+0xe64>
18000b635:     	movl	%eax, %ecx
18000b637:     	callq	0x18000bc5e <numba_list_iter_next+0xe9e>
18000b63c:     	testl	%eax, %eax
18000b63e:     	je	0x18000b644 <numba_list_iter_next+0x884>
18000b640:     	xorb	%al, %al
18000b642:     	jmp	0x18000b64b <numba_list_iter_next+0x88b>
18000b644:     	callq	0x18000bc64 <numba_list_iter_next+0xea4>
18000b649:     	movb	$0x1, %al
18000b64b:     	addq	$0x28, %rsp
18000b64f:     	retq
18000b650:     	subq	$0x28, %rsp
18000b654:     	xorl	%ecx, %ecx
18000b656:     	callq	0x18000b788 <numba_list_iter_next+0x9c8>
18000b65b:     	testb	%al, %al
18000b65d:     	setne	%al
18000b660:     	addq	$0x28, %rsp
18000b664:     	retq
18000b665:     	int3
18000b666:     	int3
18000b667:     	int3
18000b668:     	subq	$0x28, %rsp
18000b66c:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b671:     	testb	%al, %al
18000b673:     	jne	0x18000b679 <numba_list_iter_next+0x8b9>
18000b675:     	xorb	%al, %al
18000b677:     	jmp	0x18000b68b <numba_list_iter_next+0x8cb>
18000b679:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b67e:     	testb	%al, %al
18000b680:     	jne	0x18000b689 <numba_list_iter_next+0x8c9>
18000b682:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b687:     	jmp	0x18000b675 <numba_list_iter_next+0x8b5>
18000b689:     	movb	$0x1, %al
18000b68b:     	addq	$0x28, %rsp
18000b68f:     	retq
18000b690:     	subq	$0x28, %rsp
18000b694:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b699:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b69e:     	movb	$0x1, %al
18000b6a0:     	addq	$0x28, %rsp
18000b6a4:     	retq
18000b6a5:     	int3
18000b6a6:     	int3
18000b6a7:     	int3
18000b6a8:     	movq	%rbx, 0x8(%rsp)
18000b6ad:     	movq	%rbp, 0x10(%rsp)
18000b6b2:     	movq	%rsi, 0x18(%rsp)
18000b6b7:     	pushq	%rdi
18000b6b8:     	subq	$0x20, %rsp
18000b6bc:     	movq	%r9, %rdi
18000b6bf:     	movq	%r8, %rsi
18000b6c2:     	movl	%edx, %ebx
18000b6c4:     	movq	%rcx, %rbp
18000b6c7:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b6cc:     	testl	%eax, %eax
18000b6ce:     	jne	0x18000b6e6 <numba_list_iter_next+0x926>
18000b6d0:     	cmpl	$0x1, %ebx
18000b6d3:     	jne	0x18000b6e6 <numba_list_iter_next+0x926>
18000b6d5:     	movq	%rsi, %r8
18000b6d8:     	xorl	%edx, %edx
18000b6da:     	movq	%rbp, %rcx
18000b6dd:     	movq	%rdi, %rax
18000b6e0:     	callq	*0xc4a(%rip)            # 0x18000c330
18000b6e6:     	movq	0x58(%rsp), %rdx
18000b6eb:     	movl	0x50(%rsp), %ecx
18000b6ef:     	movq	0x30(%rsp), %rbx
18000b6f4:     	movq	0x38(%rsp), %rbp
18000b6f9:     	movq	0x40(%rsp), %rsi
18000b6fe:     	addq	$0x20, %rsp
18000b702:     	popq	%rdi
18000b703:     	jmp	0x18000bc58 <numba_list_iter_next+0xe98>
18000b708:     	subq	$0x28, %rsp
18000b70c:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b711:     	testl	%eax, %eax
18000b713:     	je	0x18000b725 <numba_list_iter_next+0x965>
18000b715:     	leaq	0x8304(%rip), %rcx      # 0x180013a20
18000b71c:     	addq	$0x28, %rsp
18000b720:     	jmp	0x18000bc70 <numba_list_iter_next+0xeb0>
18000b725:     	callq	0x18000bc80 <numba_list_iter_next+0xec0>
18000b72a:     	testl	%eax, %eax
18000b72c:     	jne	0x18000b733 <numba_list_iter_next+0x973>
18000b72e:     	callq	0x18000bc76 <numba_list_iter_next+0xeb6>
18000b733:     	addq	$0x28, %rsp
18000b737:     	retq
18000b738:     	subq	$0x28, %rsp
18000b73c:     	xorl	%ecx, %ecx
18000b73e:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b743:     	addq	$0x28, %rsp
18000b747:     	jmp	0x18000bc7c <numba_list_iter_next+0xebc>
18000b74c:     	subq	$0x28, %rsp
18000b750:     	testl	%ecx, %ecx
18000b752:     	jne	0x18000b75b <numba_list_iter_next+0x99b>
18000b754:     	movb	$0x1, 0x82bd(%rip)      # 0x180013a18
18000b75b:     	callq	0x18000b988 <numba_list_iter_next+0xbc8>
18000b760:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b765:     	testb	%al, %al
18000b767:     	jne	0x18000b76d <numba_list_iter_next+0x9ad>
18000b769:     	xorb	%al, %al
18000b76b:     	jmp	0x18000b781 <numba_list_iter_next+0x9c1>
18000b76d:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b772:     	testb	%al, %al
18000b774:     	jne	0x18000b77f <numba_list_iter_next+0x9bf>
18000b776:     	xorl	%ecx, %ecx
18000b778:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b77d:     	jmp	0x18000b769 <numba_list_iter_next+0x9a9>
18000b77f:     	movb	$0x1, %al
18000b781:     	addq	$0x28, %rsp
18000b785:     	retq
18000b786:     	int3
18000b787:     	int3
18000b788:     	pushq	%rbx
18000b78a:     	subq	$0x20, %rsp
18000b78e:     	cmpb	$0x0, 0x8284(%rip)      # 0x180013a19
18000b795:     	movl	%ecx, %ebx
18000b797:     	jne	0x18000b800 <numba_list_iter_next+0xa40>
18000b799:     	cmpl	$0x1, %ecx
18000b79c:     	ja	0x18000b808 <numba_list_iter_next+0xa48>
18000b79e:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b7a3:     	testl	%eax, %eax
18000b7a5:     	je	0x18000b7cf <numba_list_iter_next+0xa0f>
18000b7a7:     	testl	%ebx, %ebx
18000b7a9:     	jne	0x18000b7cf <numba_list_iter_next+0xa0f>
18000b7ab:     	leaq	0x826e(%rip), %rcx      # 0x180013a20
18000b7b2:     	callq	0x18000bc6a <numba_list_iter_next+0xeaa>
18000b7b7:     	testl	%eax, %eax
18000b7b9:     	jne	0x18000b7cb <numba_list_iter_next+0xa0b>
18000b7bb:     	leaq	0x8276(%rip), %rcx      # 0x180013a38
18000b7c2:     	callq	0x18000bc6a <numba_list_iter_next+0xeaa>
18000b7c7:     	testl	%eax, %eax
18000b7c9:     	je	0x18000b7f9 <numba_list_iter_next+0xa39>
18000b7cb:     	xorb	%al, %al
18000b7cd:     	jmp	0x18000b802 <numba_list_iter_next+0xa42>
18000b7cf:     	movdqa	0x1339(%rip), %xmm0     # 0x18000cb10
18000b7d7:     	orq	$-0x1, %rax
18000b7db:     	movdqu	%xmm0, 0x823d(%rip)     # 0x180013a20
18000b7e3:     	movq	%rax, 0x8246(%rip)      # 0x180013a30
18000b7ea:     	movdqu	%xmm0, 0x8246(%rip)     # 0x180013a38
18000b7f2:     	movq	%rax, 0x824f(%rip)      # 0x180013a48
18000b7f9:     	movb	$0x1, 0x8219(%rip)      # 0x180013a19
18000b800:     	movb	$0x1, %al
18000b802:     	addq	$0x20, %rsp
18000b806:     	popq	%rbx
18000b807:     	retq
18000b808:     	movl	$0x5, %ecx
18000b80d:     	callq	0x18000b904 <numba_list_iter_next+0xb44>
18000b812:     	int3
18000b813:     	int3
18000b814:     	subq	$0x18, %rsp
18000b818:     	movq	%rcx, %r8
18000b81b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
18000b820:     	cmpw	%ax, -0xb827(%rip)      # 0x180000000
18000b827:     	jne	0x18000b8a1 <numba_list_iter_next+0xae1>
18000b829:     	movslq	-0xb7f4(%rip), %rcx     # 0x18000003c
18000b830:     	leaq	-0xb837(%rip), %rdx     # 0x180000000
18000b837:     	addq	%rdx, %rcx
18000b83a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
18000b840:     	jne	0x18000b8a1 <numba_list_iter_next+0xae1>
18000b842:     	movl	$0x20b, %eax            # imm = 0x20B
18000b847:     	cmpw	%ax, 0x18(%rcx)
18000b84b:     	jne	0x18000b8a1 <numba_list_iter_next+0xae1>
18000b84d:     	subq	%rdx, %r8
18000b850:     	movzwl	0x14(%rcx), %edx
18000b854:     	addq	$0x18, %rdx
18000b858:     	addq	%rcx, %rdx
18000b85b:     	movzwl	0x6(%rcx), %eax
18000b85f:     	leaq	(%rax,%rax,4), %rcx
18000b863:     	leaq	(%rdx,%rcx,8), %r9
18000b867:     	movq	%rdx, (%rsp)
18000b86b:     	cmpq	%r9, %rdx
18000b86e:     	je	0x18000b888 <numba_list_iter_next+0xac8>
18000b870:     	movl	0xc(%rdx), %ecx
18000b873:     	cmpq	%rcx, %r8
18000b876:     	jb	0x18000b882 <numba_list_iter_next+0xac2>
18000b878:     	movl	0x8(%rdx), %eax
18000b87b:     	addl	%ecx, %eax
18000b87d:     	cmpq	%rax, %r8
18000b880:     	jb	0x18000b88a <numba_list_iter_next+0xaca>
18000b882:     	addq	$0x28, %rdx
18000b886:     	jmp	0x18000b867 <numba_list_iter_next+0xaa7>
18000b888:     	xorl	%edx, %edx
18000b88a:     	testq	%rdx, %rdx
18000b88d:     	jne	0x18000b893 <numba_list_iter_next+0xad3>
18000b88f:     	xorb	%al, %al
18000b891:     	jmp	0x18000b8a7 <numba_list_iter_next+0xae7>
18000b893:     	cmpl	$0x0, 0x24(%rdx)
18000b897:     	jge	0x18000b89d <numba_list_iter_next+0xadd>
18000b899:     	xorb	%al, %al
18000b89b:     	jmp	0x18000b8a7 <numba_list_iter_next+0xae7>
18000b89d:     	movb	$0x1, %al
18000b89f:     	jmp	0x18000b8a7 <numba_list_iter_next+0xae7>
18000b8a1:     	xorb	%al, %al
18000b8a3:     	jmp	0x18000b8a7 <numba_list_iter_next+0xae7>
18000b8a5:     	xorb	%al, %al
18000b8a7:     	addq	$0x18, %rsp
18000b8ab:     	retq
18000b8ac:     	pushq	%rbx
18000b8ae:     	subq	$0x20, %rsp
18000b8b2:     	movb	%cl, %bl
18000b8b4:     	callq	0x18000bc2c <numba_list_iter_next+0xe6c>
18000b8b9:     	xorl	%edx, %edx
18000b8bb:     	testl	%eax, %eax
18000b8bd:     	je	0x18000b8ca <numba_list_iter_next+0xb0a>
18000b8bf:     	testb	%bl, %bl
18000b8c1:     	jne	0x18000b8ca <numba_list_iter_next+0xb0a>
18000b8c3:     	xchgq	%rdx, 0x8146(%rip)      # 0x180013a10
18000b8ca:     	addq	$0x20, %rsp
18000b8ce:     	popq	%rbx
18000b8cf:     	retq
18000b8d0:     	pushq	%rbx
18000b8d2:     	subq	$0x20, %rsp
18000b8d6:     	cmpb	$0x0, 0x813b(%rip)      # 0x180013a18
18000b8dd:     	movb	%cl, %bl
18000b8df:     	je	0x18000b8e5 <numba_list_iter_next+0xb25>
18000b8e1:     	testb	%dl, %dl
18000b8e3:     	jne	0x18000b8f1 <numba_list_iter_next+0xb31>
18000b8e5:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b8ea:     	movb	%bl, %cl
18000b8ec:     	callq	0x18000bc7c <numba_list_iter_next+0xebc>
18000b8f1:     	movb	$0x1, %al
18000b8f3:     	addq	$0x20, %rsp
18000b8f7:     	popq	%rbx
18000b8f8:     	retq
18000b8f9:     	int3
18000b8fa:     	int3
18000b8fb:     	int3
18000b8fc:     	leaq	0x83d5(%rip), %rax      # 0x180013cd8
18000b903:     	retq
18000b904:     	movl	%ecx, %ecx
18000b906:     	int	$0x29
18000b908:     	retq
18000b909:     	int3
18000b90a:     	int3
18000b90b:     	int3
18000b90c:     	movq	%rbx, 0x8(%rsp)
18000b911:     	pushq	%rdi
18000b912:     	subq	$0x20, %rsp
18000b916:     	leaq	0x3c2b(%rip), %rbx      # 0x18000f548
18000b91d:     	leaq	0x3c24(%rip), %rdi      # 0x18000f548
18000b924:     	jmp	0x18000b938 <numba_list_iter_next+0xb78>
18000b926:     	movq	(%rbx), %rax
18000b929:     	testq	%rax, %rax
18000b92c:     	je	0x18000b934 <numba_list_iter_next+0xb74>
18000b92e:     	callq	*0x9fc(%rip)            # 0x18000c330
18000b934:     	addq	$0x8, %rbx
18000b938:     	cmpq	%rdi, %rbx
18000b93b:     	jb	0x18000b926 <numba_list_iter_next+0xb66>
18000b93d:     	movq	0x30(%rsp), %rbx
18000b942:     	addq	$0x20, %rsp
18000b946:     	popq	%rdi
18000b947:     	retq
18000b948:     	movq	%rbx, 0x8(%rsp)
18000b94d:     	pushq	%rdi
18000b94e:     	subq	$0x20, %rsp
18000b952:     	leaq	0x3bff(%rip), %rbx      # 0x18000f558
18000b959:     	leaq	0x3bf8(%rip), %rdi      # 0x18000f558
18000b960:     	jmp	0x18000b974 <numba_list_iter_next+0xbb4>
18000b962:     	movq	(%rbx), %rax
18000b965:     	testq	%rax, %rax
18000b968:     	je	0x18000b970 <numba_list_iter_next+0xbb0>
18000b96a:     	callq	*0x9c0(%rip)            # 0x18000c330
18000b970:     	addq	$0x8, %rbx
18000b974:     	cmpq	%rdi, %rbx
18000b977:     	jb	0x18000b962 <numba_list_iter_next+0xba2>
18000b979:     	movq	0x30(%rsp), %rbx
18000b97e:     	addq	$0x20, %rsp
18000b982:     	popq	%rdi
18000b983:     	retq
18000b984:     	retq	$0x0
18000b987:     	int3
18000b988:     	movq	%rbx, 0x10(%rsp)
18000b98d:     	movq	%rbp, 0x18(%rsp)
18000b992:     	movq	%rsi, 0x20(%rsp)
18000b997:     	pushq	%rdi
18000b998:     	subq	$0x10, %rsp
18000b99c:     	xorl	%eax, %eax
18000b99e:     	xorl	%ecx, %ecx
18000b9a0:     	cpuid
18000b9a2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
18000b9a8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000b9ae:     	orl	%ecx, %edx
18000b9b0:     	movl	%eax, %ebp
18000b9b2:     	movl	$0x1, %eax
18000b9b7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000b9bd:     	orl	%ebx, %edx
18000b9bf:     	leal	-0x1(%rax), %ecx
18000b9c2:     	cpuid
18000b9c4:     	movl	%ecx, %edi
18000b9c6:     	jne	0x18000ba26 <numba_list_iter_next+0xc66>
18000b9c8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000b9cd:     	movq	$0x8000, 0x7780(%rip)   # imm = 0x8000
                                                # 0x180013158
18000b9d8:     	movq	$-0x1, 0x777d(%rip)     # 0x180013160
18000b9e3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
18000b9e8:     	je	0x18000ba12 <numba_list_iter_next+0xc52>
18000b9ea:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000b9ef:     	je	0x18000ba12 <numba_list_iter_next+0xc52>
18000b9f1:     	cmpl	$0x20670, %eax          # imm = 0x20670
18000b9f6:     	je	0x18000ba12 <numba_list_iter_next+0xc52>
18000b9f8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000b9fd:     	cmpl	$0x20, %eax
18000ba00:     	ja	0x18000ba26 <numba_list_iter_next+0xc66>
18000ba02:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000ba0c:     	btq	%rax, %rcx
18000ba10:     	jae	0x18000ba26 <numba_list_iter_next+0xc66>
18000ba12:     	movl	0x803b(%rip), %r8d      # 0x180013a54
18000ba19:     	orl	$0x1, %r8d
18000ba1d:     	movl	%r8d, 0x8030(%rip)      # 0x180013a54
18000ba24:     	jmp	0x18000ba2d <numba_list_iter_next+0xc6d>
18000ba26:     	movl	0x8027(%rip), %r8d      # 0x180013a54
18000ba2d:     	xorl	%r9d, %r9d
18000ba30:     	movl	%r9d, %r11d
18000ba33:     	cmpl	$0x7, %ebp
18000ba36:     	jl	0x18000ba7a <numba_list_iter_next+0xcba>
18000ba38:     	xorl	%ecx, %ecx
18000ba3a:     	leal	0x7(%r9), %eax
18000ba3e:     	cpuid
18000ba40:     	movl	%edx, %esi
18000ba42:     	movl	%ebx, %r10d
18000ba45:     	btl	$0x9, %ebx
18000ba49:     	jae	0x18000ba56 <numba_list_iter_next+0xc96>
18000ba4b:     	orl	$0x2, %r8d
18000ba4f:     	movl	%r8d, 0x7ffe(%rip)      # 0x180013a54
18000ba56:     	cmpl	$0x1, %eax
18000ba59:     	jl	0x18000ba68 <numba_list_iter_next+0xca8>
18000ba5b:     	movl	$0x7, %eax
18000ba60:     	leal	-0x6(%rax), %ecx
18000ba63:     	cpuid
18000ba65:     	movl	%edx, %r9d
18000ba68:     	movl	$0x24, %eax
18000ba6d:     	cmpl	%eax, %ebp
18000ba6f:     	jl	0x18000ba80 <numba_list_iter_next+0xcc0>
18000ba71:     	xorl	%ecx, %ecx
18000ba73:     	cpuid
18000ba75:     	movl	%ebx, %r11d
18000ba78:     	jmp	0x18000ba80 <numba_list_iter_next+0xcc0>
18000ba7a:     	movl	%r9d, %r10d
18000ba7d:     	movl	%r9d, %esi
18000ba80:     	movq	0x76e1(%rip), %rax      # 0x180013168
18000ba87:     	andq	$-0x2, %rax
18000ba8b:     	movl	$0x1, 0x76bb(%rip)      # 0x180013150
18000ba95:     	movl	$0x2, 0x76b5(%rip)      # 0x180013154
18000ba9f:     	movq	%rax, 0x76c2(%rip)      # 0x180013168
18000baa6:     	btl	$0x14, %edi
18000baaa:     	jae	0x18000bacb <numba_list_iter_next+0xd0b>
18000baac:     	andq	$-0x11, %rax
18000bab0:     	movl	$0x2, 0x7696(%rip)      # 0x180013150
18000baba:     	movq	%rax, 0x76a7(%rip)      # 0x180013168
18000bac1:     	movl	$0x6, 0x7689(%rip)      # 0x180013154
18000bacb:     	btl	$0x1b, %edi
18000bacf:     	jae	0x18000bc0c <numba_list_iter_next+0xe4c>
18000bad5:     	xorl	%ecx, %ecx
18000bad7:     	xgetbv
18000bada:     	shlq	$0x20, %rdx
18000bade:     	orq	%rax, %rdx
18000bae1:     	movq	%rdx, 0x20(%rsp)
18000bae6:     	btl	$0x1c, %edi
18000baea:     	jae	0x18000bbf0 <numba_list_iter_next+0xe30>
18000baf0:     	movq	0x20(%rsp), %rax
18000baf5:     	andb	$0x6, %al
18000baf7:     	cmpb	$0x6, %al
18000baf9:     	jne	0x18000bbf0 <numba_list_iter_next+0xe30>
18000baff:     	movl	0x764f(%rip), %eax      # 0x180013154
18000bb05:     	movb	$-0x20, %dl
18000bb07:     	orl	$0x8, %eax
18000bb0a:     	movl	$0x3, 0x763c(%rip)      # 0x180013150
18000bb14:     	movl	%eax, 0x763a(%rip)      # 0x180013154
18000bb1a:     	testb	$0x20, %r10b
18000bb1e:     	je	0x18000bb82 <numba_list_iter_next+0xdc2>
18000bb20:     	orl	$0x20, %eax
18000bb23:     	movl	$0x5, 0x7623(%rip)      # 0x180013150
18000bb2d:     	movl	%eax, 0x7621(%rip)      # 0x180013154
18000bb33:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
18000bb38:     	movq	0x7629(%rip), %rax      # 0x180013168
18000bb3f:     	andl	%ecx, %r10d
18000bb42:     	andq	$-0x3, %rax
18000bb46:     	movq	%rax, 0x761b(%rip)      # 0x180013168
18000bb4d:     	cmpl	%ecx, %r10d
18000bb50:     	jne	0x18000bb89 <numba_list_iter_next+0xdc9>
18000bb52:     	movq	0x20(%rsp), %rax
18000bb57:     	andb	%dl, %al
18000bb59:     	cmpb	%dl, %al
18000bb5b:     	jne	0x18000bb82 <numba_list_iter_next+0xdc2>
18000bb5d:     	movq	0x7604(%rip), %rax      # 0x180013168
18000bb64:     	orl	$0x40, 0x75e9(%rip)     # 0x180013154
18000bb6b:     	andq	$-0x25, %rax
18000bb6f:     	movl	$0x6, 0x75d7(%rip)      # 0x180013150
18000bb79:     	movq	%rax, 0x75e8(%rip)      # 0x180013168
18000bb80:     	jmp	0x18000bb89 <numba_list_iter_next+0xdc9>
18000bb82:     	movq	0x75df(%rip), %rax      # 0x180013168
18000bb89:     	btl	$0x17, %esi
18000bb8d:     	jae	0x18000bb9b <numba_list_iter_next+0xddb>
18000bb8f:     	btrq	$0x18, %rax
18000bb94:     	movq	%rax, 0x75cd(%rip)      # 0x180013168
18000bb9b:     	btl	$0x13, %r9d
18000bba0:     	jae	0x18000bbf0 <numba_list_iter_next+0xe30>
18000bba2:     	movq	0x20(%rsp), %rax
18000bba7:     	andb	%dl, %al
18000bba9:     	cmpb	%dl, %al
18000bbab:     	jne	0x18000bbf0 <numba_list_iter_next+0xe30>
18000bbad:     	movq	0x75b4(%rip), %rdx      # 0x180013168
18000bbb4:     	movl	%r11d, %eax
18000bbb7:     	shrq	$0x10, %rax
18000bbbb:     	movl	%r11d, %ecx
18000bbbe:     	andl	$0x6, %eax
18000bbc1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
18000bbc7:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000bbcd:     	movl	%ecx, 0x7e85(%rip)      # 0x180013a58
18000bbd3:     	notq	%rax
18000bbd6:     	andq	%rax, %rdx
18000bbd9:     	movq	%rdx, 0x7588(%rip)      # 0x180013168
18000bbe0:     	cmpb	$0x1, %cl
18000bbe3:     	jbe	0x18000bbf0 <numba_list_iter_next+0xe30>
18000bbe5:     	andq	$-0x41, %rdx
18000bbe9:     	movq	%rdx, 0x7578(%rip)      # 0x180013168
18000bbf0:     	btl	$0x15, %r9d
18000bbf5:     	jae	0x18000bc0c <numba_list_iter_next+0xe4c>
18000bbf7:     	movq	0x20(%rsp), %rax
18000bbfc:     	btq	$0x13, %rax
18000bc01:     	jae	0x18000bc0c <numba_list_iter_next+0xe4c>
18000bc03:     	btrq	$0x7, 0x755c(%rip)      # 0x180013168
18000bc0c:     	movq	0x28(%rsp), %rbx
18000bc11:     	xorl	%eax, %eax
18000bc13:     	movq	0x30(%rsp), %rbp
18000bc18:     	movq	0x38(%rsp), %rsi
18000bc1d:     	addq	$0x10, %rsp
18000bc21:     	popq	%rdi
18000bc22:     	retq
18000bc23:     	int3
18000bc24:     	movl	$0x1, %eax
18000bc29:     	retq
18000bc2a:     	int3
18000bc2b:     	int3
18000bc2c:     	xorl	%eax, %eax
18000bc2e:     	cmpl	%eax, 0x753c(%rip)      # 0x180013170
18000bc34:     	setne	%al
18000bc37:     	retq
18000bc38:     	int3
18000bc39:     	int3
18000bc3a:     	int3
18000bc3b:     	int3
18000bc3c:     	int3
18000bc3d:     	int3
18000bc3e:     	int3
18000bc3f:     	int3
18000bc40:     	jmpq	*0x402(%rip)            # 0x18000c048
18000bc46:     	jmpq	*0x404(%rip)            # 0x18000c050
18000bc4c:     	jmpq	*0x43e(%rip)            # 0x18000c090
18000bc52:     	jmpq	*0x440(%rip)            # 0x18000c098
18000bc58:     	jmpq	*0x442(%rip)            # 0x18000c0a0
18000bc5e:     	jmpq	*0x444(%rip)            # 0x18000c0a8
18000bc64:     	jmpq	*0x446(%rip)            # 0x18000c0b0
18000bc6a:     	jmpq	*0x410(%rip)            # 0x18000c080
18000bc70:     	jmpq	*0x442(%rip)            # 0x18000c0b8
18000bc76:     	jmpq	*0x40c(%rip)            # 0x18000c088
18000bc7c:     	movb	$0x1, %al
18000bc7e:     	retq
18000bc7f:     	int3
18000bc80:     	xorl	%eax, %eax
18000bc82:     	retq
18000bc83:     	jmpq	*0x3af(%rip)            # 0x18000c038
18000bc89:     	jmpq	*0x3b1(%rip)            # 0x18000c040
18000bc8f:     	jmpq	*0x433(%rip)            # 0x18000c0c8
18000bc95:     	jmpq	*0x435(%rip)            # 0x18000c0d0
18000bc9b:     	int3
18000bc9c:     	int3
18000bc9d:     	int3
18000bc9e:     	int3
18000bc9f:     	int3
18000bca0:     	int3
18000bca1:     	int3
18000bca2:     	int3
18000bca3:     	int3
18000bca4:     	int3
18000bca5:     	int3
18000bca6:     	nopw	(%rax,%rax)
18000bcb0:     	jmpq	*%rax
18000bcb2:     	int3
18000bcb3:     	int3
18000bcb4:     	int3
18000bcb5:     	int3
18000bcb6:     	int3
18000bcb7:     	int3
18000bcb8:     	int3
18000bcb9:     	int3
18000bcba:     	int3
18000bcbb:     	int3
18000bcbc:     	int3
18000bcbd:     	int3
18000bcbe:     	int3
18000bcbf:     	int3
18000bcc0:     	int3
18000bcc1:     	int3
18000bcc2:     	int3
18000bcc3:     	int3
18000bcc4:     	int3
18000bcc5:     	int3
18000bcc6:     	nopw	(%rax,%rax)
18000bcd0:     	jmpq	*0x65a(%rip)            # 0x18000c330
18000bcd6:     	pushq	%rbp
18000bcd8:     	subq	$0x20, %rsp
18000bcdc:     	movq	%rdx, %rbp
18000bcdf:     	movb	0x40(%rbp), %cl
18000bce2:     	addq	$0x20, %rsp
18000bce6:     	popq	%rbp
18000bce7:     	jmp	0x18000b8ac <numba_list_iter_next+0xaec>
18000bcec:     	int3
18000bced:     	pushq	%rbp
18000bcef:     	subq	$0x20, %rsp
18000bcf3:     	movq	%rdx, %rbp
18000bcf6:     	movb	0x20(%rbp), %cl
18000bcf9:     	callq	0x18000b8ac <numba_list_iter_next+0xaec>
18000bcfe:     	nop
18000bcff:     	addq	$0x20, %rsp
18000bd03:     	popq	%rbp
18000bd04:     	retq
18000bd05:     	int3
18000bd06:     	pushq	%rbp
18000bd08:     	subq	$0x20, %rsp
18000bd0c:     	movq	%rdx, %rbp
18000bd0f:     	addq	$0x20, %rsp
18000bd13:     	popq	%rbp
18000bd14:     	jmp	0x18000b738 <numba_list_iter_next+0x978>
18000bd19:     	int3
18000bd1a:     	pushq	%rbp
18000bd1c:     	subq	$0x30, %rsp
18000bd20:     	movq	%rdx, %rbp
18000bd23:     	movq	(%rcx), %rax
18000bd26:     	movl	(%rax), %edx
18000bd28:     	movq	%rcx, 0x28(%rsp)
18000bd2d:     	movl	%edx, 0x20(%rsp)
18000bd31:     	leaq	-0xbc8(%rip), %r9       # 0x18000b170 <numba_list_iter_next+0x3b0>
18000bd38:     	movq	0x70(%rbp), %r8
18000bd3c:     	movl	0x68(%rbp), %edx
18000bd3f:     	movq	0x60(%rbp), %rcx
18000bd43:     	callq	0x18000b6a8 <numba_list_iter_next+0x8e8>
18000bd48:     	nop
18000bd49:     	addq	$0x30, %rsp
18000bd4d:     	popq	%rbp
18000bd4e:     	retq
18000bd4f:     	int3
18000bd50:     	pushq	%rbp
18000bd52:     	movq	%rdx, %rbp
18000bd55:     	movq	(%rcx), %rax
18000bd58:     	xorl	%ecx, %ecx
18000bd5a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
18000bd60:     	sete	%cl
18000bd63:     	movl	%ecx, %eax
18000bd65:     	popq	%rbp
18000bd66:     	retq
18000bd67:     	int3
