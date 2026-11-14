
D:\Code\Datathon\recompyler-codex-20261111\wave5-study\results\cache\scimark\candidate\recompyler\rcaot_05cb37762ef1645705ed4668.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180005220 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x63d9(%rip), %rax      # 0x180007460
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
18000109c:     	subq	$0x108, %rsp            # imm = 0x108
1800010a3:     	movapd	%xmm15, 0xf0(%rsp)
1800010ad:     	movapd	%xmm14, 0xe0(%rsp)
1800010b7:     	movapd	%xmm13, 0xd0(%rsp)
1800010c1:     	movapd	%xmm12, 0xc0(%rsp)
1800010cb:     	movapd	%xmm11, 0xb0(%rsp)
1800010d5:     	movapd	%xmm10, 0xa0(%rsp)
1800010df:     	movapd	%xmm9, 0x90(%rsp)
1800010e9:     	movapd	%xmm8, 0x80(%rsp)
1800010f3:     	movapd	%xmm7, 0x70(%rsp)
1800010f9:     	movapd	%xmm6, 0x60(%rsp)
1800010ff:     	movq	%r8, %rdi
180001102:     	movq	%rcx, %r11
180001105:     	movq	%r9, %rax
180001108:     	movq	%r9, %rsi
18000110b:     	shrq	$0x20, %rax
18000110f:     	jne	0x180001124 <.text+0x124>
180001111:     	shrq	%rsi
180001114:     	xorl	%ecx, %ecx
180001116:     	addq	%rcx, %rsi
180001119:     	cmpq	$0x1, %rsi
18000111d:     	jne	0x18000115b <.text+0x15b>
18000111f:     	jmp	0x18000124a <.text+0x24a>
180001124:     	shrq	$0x3f, %rsi
180001128:     	addq	%r9, %rsi
18000112b:     	sarq	%rsi
18000112e:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
180001138:     	addq	$0x2, %rcx
18000113c:     	movq	%r9, %r8
18000113f:     	notq	%r8
180001142:     	andq	%rcx, %r8
180001145:     	xorl	%ecx, %ecx
180001147:     	cmpq	$0x1, %r8
18000114b:     	sbbq	%rcx, %rcx
18000114e:     	addq	%rcx, %rsi
180001151:     	cmpq	$0x1, %rsi
180001155:     	je	0x18000124a <.text+0x24a>
18000115b:     	movzbl	(%rdi), %r10d
18000115f:     	testb	%r10b, %r10b
180001162:     	setne	%cl
180001165:     	cmpq	$0x2, %rsi
180001169:     	setl	%r8b
18000116d:     	orb	%cl, %r8b
180001170:     	jne	0x1800011db <.text+0x1db>
180001172:     	movl	$0x1, %r8d
180001178:     	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
180001182:     	xorl	%ecx, %ecx
180001184:     	movapd	0x6204(%rip), %xmm0     # 0x180007390
18000118c:     	movsd	0x620c(%rip), %xmm1     # 0x1800073a0
180001194:     	nopw	%cs:(%rax,%rax)
18000119e:     	nop
1800011a0:     	leaq	0x1(%rcx), %rbx
1800011a4:     	cmpq	%r10, %rcx
1800011a7:     	movl	$0x0, %ecx
1800011ac:     	cmovneq	%rbx, %rcx
1800011b0:     	je	0x1800011df <.text+0x1df>
1800011b2:     	xorps	%xmm2, %xmm2
1800011b5:     	cvtsi2sd	%r8, %xmm2
1800011ba:     	addsd	%xmm2, %xmm2
1800011be:     	andpd	%xmm0, %xmm2
1800011c2:     	ucomisd	%xmm2, %xmm1
1800011c6:     	jbe	0x1800011df <.text+0x1df>
1800011c8:     	addq	%r8, %r8
1800011cb:     	cmpq	%rsi, %r8
1800011ce:     	jl	0x1800011a0 <.text+0x1a0>
1800011d0:     	xorl	%r10d, %r10d
1800011d3:     	cmpq	$0x3f, %rcx
1800011d7:     	jae	0x1800011eb <.text+0x1eb>
1800011d9:     	jmp	0x18000120d <.text+0x20d>
1800011db:     	xorl	%ecx, %ecx
1800011dd:     	jmp	0x18000120d <.text+0x20d>
1800011df:     	movb	$0x1, (%rdi)
1800011e2:     	movb	$0x1, %r10b
1800011e5:     	cmpq	$0x3f, %rcx
1800011e9:     	jb	0x18000120d <.text+0x20d>
1800011eb:     	movb	$0x1, (%rdi)
1800011ee:     	movb	$0x1, %r10b
1800011f1:     	xorl	%r8d, %r8d
1800011f4:     	testb	%r8b, %r8b
1800011f7:     	jne	0x180001225 <.text+0x225>
1800011f9:     	leaq	0x6380(%rip), %rax      # 0x180007580
180001200:     	movq	%rax, (%rdx)
180001203:     	movl	$0x1, %eax
180001208:     	jmp	0x1800012b5 <.text+0x2b5>
18000120d:     	movl	$0x1, %r8d
180001213:     	shlq	%cl, %r8
180001216:     	cmpq	%r8, %rsi
180001219:     	sete	%r8b
18000121d:     	movq	%rcx, %rbx
180001220:     	testb	%r8b, %r8b
180001223:     	je	0x1800011f9 <.text+0x1f9>
180001225:     	testq	%r9, %r9
180001228:     	je	0x18000124a <.text+0x24a>
18000122a:     	testq	%rax, %rax
18000122d:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180001237:     	jne	0x180001253 <.text+0x253>
180001239:     	movq	%rbx, 0x48(%rsp)
18000123e:     	movq	%rsi, 0x30(%rsp)
180001243:     	shrq	%r9
180001246:     	xorl	%eax, %eax
180001248:     	jmp	0x180001280 <.text+0x280>
18000124a:     	movq	$0x0, (%r11)
180001251:     	jmp	0x1800012b3 <.text+0x2b3>
180001253:     	movq	%rbx, 0x48(%rsp)
180001258:     	movq	%rsi, 0x30(%rsp)
18000125d:     	movq	%r9, %rcx
180001260:     	shrq	$0x3f, %rcx
180001264:     	addq	%r9, %rcx
180001267:     	sarq	%rcx
18000126a:     	addq	$0x2, %rax
18000126e:     	notq	%r9
180001271:     	andq	%rax, %r9
180001274:     	xorl	%eax, %eax
180001276:     	cmpq	$0x1, %r9
18000127a:     	sbbq	%rax, %rax
18000127d:     	movq	%rcx, %r9
180001280:     	movq	%r11, 0x40(%rsp)
180001285:     	addq	%rax, %r9
180001288:     	movq	0x178(%rsp), %r12
180001290:     	movq	0x170(%rsp), %rbx
180001298:     	cmpq	$0x2, %r9
18000129c:     	jge	0x18000131b <.text+0x31b>
18000129e:     	testb	%r10b, %r10b
1800012a1:     	je	0x18000160a <.text+0x60a>
1800012a7:     	movq	0x40(%rsp), %rax
1800012ac:     	movq	$0x0, (%rax)
1800012b3:     	xorl	%eax, %eax
1800012b5:     	movaps	0x60(%rsp), %xmm6
1800012ba:     	movaps	0x70(%rsp), %xmm7
1800012bf:     	movaps	0x80(%rsp), %xmm8
1800012c8:     	movaps	0x90(%rsp), %xmm9
1800012d1:     	movaps	0xa0(%rsp), %xmm10
1800012da:     	movaps	0xb0(%rsp), %xmm11
1800012e3:     	movaps	0xc0(%rsp), %xmm12
1800012ec:     	movaps	0xd0(%rsp), %xmm13
1800012f5:     	movaps	0xe0(%rsp), %xmm14
1800012fe:     	movaps	0xf0(%rsp), %xmm15
180001307:     	addq	$0x108, %rsp            # imm = 0x108
18000130e:     	popq	%rbx
18000130f:     	popq	%rbp
180001310:     	popq	%rdi
180001311:     	popq	%rsi
180001312:     	popq	%r12
180001314:     	popq	%r13
180001316:     	popq	%r14
180001318:     	popq	%r15
18000131a:     	retq
18000131b:     	movq	%r9, %rax
18000131e:     	shrq	%rax
180001321:     	movq	%r9, %rcx
180001324:     	shrq	$0x2, %rcx
180001328:     	xorl	%r11d, %r11d
18000132b:     	movabsq	$-0x4000000000000000, %rdx # imm = 0xC000000000000000
180001335:     	movl	%r10d, %esi
180001338:     	xorl	%r8d, %r8d
18000133b:     	jmp	0x18000135f <.text+0x35f>
18000133d:     	nopl	(%rax)
180001340:     	addq	%rbx, %r11
180001343:     	leaq	0x1(%r8), %rbx
180001347:     	addq	$0x2, %r8
18000134b:     	cmpq	%r8, %r9
18000134e:     	movq	%rbx, %r8
180001351:     	movq	0x170(%rsp), %rbx
180001359:     	je	0x18000129e <.text+0x29e>
18000135f:     	testb	%sil, %sil
180001362:     	jne	0x1800012a7 <.text+0x2a7>
180001368:     	testq	%r8, %r8
18000136b:     	je	0x180001390 <.text+0x390>
18000136d:     	movq	%r8, %rsi
180001370:     	shrq	$0x3e, %rsi
180001374:     	je	0x1800013c0 <.text+0x3c0>
180001376:     	movb	$0x1, (%rdi)
180001379:     	movb	$0x1, %r10b
18000137c:     	movb	$0x1, %sil
18000137f:     	xorl	%r15d, %r15d
180001382:     	testq	%r11, %r11
180001385:     	jne	0x18000139a <.text+0x39a>
180001387:     	jmp	0x1800013cb <.text+0x3cb>
180001389:     	nopl	(%rax)
180001390:     	xorl	%esi, %esi
180001392:     	xorl	%r15d, %r15d
180001395:     	testq	%r11, %r11
180001398:     	je	0x1800013cb <.text+0x3cb>
18000139a:     	movq	%r11, %rbx
18000139d:     	addq	%rdx, %rbx
1800013a0:     	js	0x1800013e0 <.text+0x3e0>
1800013a2:     	movb	$0x1, (%rdi)
1800013a5:     	movb	$0x1, %r10b
1800013a8:     	movb	$0x1, %sil
1800013ab:     	xorl	%ebx, %ebx
1800013ad:     	cmpq	%r11, %r8
1800013b0:     	jl	0x1800013ed <.text+0x3ed>
1800013b2:     	jmp	0x180001573 <.text+0x573>
1800013b7:     	nopw	(%rax,%rax)
1800013c0:     	leaq	(%r8,%r8), %r15
1800013c4:     	xorl	%esi, %esi
1800013c6:     	testq	%r11, %r11
1800013c9:     	jne	0x18000139a <.text+0x39a>
1800013cb:     	xorl	%ebx, %ebx
1800013cd:     	cmpq	%r11, %r8
1800013d0:     	jl	0x1800013ed <.text+0x3ed>
1800013d2:     	jmp	0x180001573 <.text+0x573>
1800013d7:     	nopw	(%rax,%rax)
1800013e0:     	leaq	(%r11,%r11), %rbx
1800013e4:     	cmpq	%r11, %r8
1800013e7:     	jge	0x180001573 <.text+0x573>
1800013ed:     	cmpq	%r12, %r15
1800013f0:     	jae	0x180001420 <.text+0x420>
1800013f2:     	movq	0x170(%rsp), %r10
1800013fa:     	movsd	(%r10,%r15,8), %xmm0
180001400:     	movq	%r15, %r10
180001403:     	orq	$0x1, %r10
180001407:     	cmpq	%r12, %r10
18000140a:     	jb	0x180001433 <.text+0x433>
18000140c:     	movb	$0x1, (%rdi)
18000140f:     	xorpd	%xmm1, %xmm1
180001413:     	jmp	0x180001441 <.text+0x441>
180001415:     	nopw	%cs:(%rax,%rax)
18000141f:     	nop
180001420:     	movb	$0x1, (%rdi)
180001423:     	xorpd	%xmm0, %xmm0
180001427:     	movq	%r15, %r10
18000142a:     	orq	$0x1, %r10
18000142e:     	cmpq	%r12, %r10
180001431:     	jae	0x18000140c <.text+0x40c>
180001433:     	movq	0x170(%rsp), %rsi
18000143b:     	movsd	(%rsi,%r10,8), %xmm1
180001441:     	movq	%rbx, %r14
180001444:     	sarq	$0x3f, %r14
180001448:     	andq	%r12, %r14
18000144b:     	leaq	(%r14,%rbx), %rsi
18000144f:     	cmpq	%r12, %rsi
180001452:     	jae	0x1800014d0 <.text+0x4d0>
180001454:     	movq	%rsi, %r13
180001457:     	sarq	$0x3f, %r13
18000145b:     	andq	%r12, %r13
18000145e:     	movq	0x170(%rsp), %rbp
180001466:     	leaq	(%rbp,%rsi,8), %rbp
18000146b:     	movsd	(%rbp,%r13,8), %xmm2
180001472:     	cmpq	%r12, %r15
180001475:     	jb	0x1800014dc <.text+0x4dc>
180001477:     	movb	$0x1, (%rdi)
18000147a:     	leaq	0x1(%r14,%rbx), %rbx
18000147f:     	cmpq	%r12, %rbx
180001482:     	jb	0x1800014f5 <.text+0x4f5>
180001484:     	movb	$0x1, (%rdi)
180001487:     	xorpd	%xmm2, %xmm2
18000148b:     	cmpq	%r12, %r10
18000148e:     	jb	0x18000151a <.text+0x51a>
180001494:     	movb	$0x1, (%rdi)
180001497:     	cmpq	%r12, %rsi
18000149a:     	jb	0x180001531 <.text+0x531>
1800014a0:     	movb	$0x1, (%rdi)
1800014a3:     	cmpq	%r12, %rbx
1800014a6:     	jb	0x180001553 <.text+0x553>
1800014ac:     	movb	$0x1, (%rdi)
1800014af:     	movb	$0x1, %r10b
1800014b2:     	movb	$0x1, %sil
1800014b5:     	movq	%rax, %rbx
1800014b8:     	testq	%rbx, %rbx
1800014bb:     	jne	0x1800015e0 <.text+0x5e0>
1800014c1:     	jmp	0x180001340 <.text+0x340>
1800014c6:     	nopw	%cs:(%rax,%rax)
1800014d0:     	movb	$0x1, (%rdi)
1800014d3:     	xorpd	%xmm2, %xmm2
1800014d7:     	cmpq	%r12, %r15
1800014da:     	jae	0x180001477 <.text+0x477>
1800014dc:     	movq	0x170(%rsp), %r13
1800014e4:     	movsd	%xmm2, (%r13,%r15,8)
1800014eb:     	leaq	0x1(%r14,%rbx), %rbx
1800014f0:     	cmpq	%r12, %rbx
1800014f3:     	jae	0x180001484 <.text+0x484>
1800014f5:     	movq	%rbx, %r14
1800014f8:     	sarq	$0x3f, %r14
1800014fc:     	andq	%r12, %r14
1800014ff:     	movq	0x170(%rsp), %r15
180001507:     	leaq	(%r15,%rbx,8), %r15
18000150b:     	movsd	(%r15,%r14,8), %xmm2
180001511:     	cmpq	%r12, %r10
180001514:     	jae	0x180001494 <.text+0x494>
18000151a:     	movq	0x170(%rsp), %r14
180001522:     	movsd	%xmm2, (%r14,%r10,8)
180001528:     	cmpq	%r12, %rsi
18000152b:     	jae	0x1800014a0 <.text+0x4a0>
180001531:     	movq	0x170(%rsp), %r10
180001539:     	leaq	(%r10,%rsi,8), %r10
18000153d:     	sarq	$0x3f, %rsi
180001541:     	andq	%r12, %rsi
180001544:     	movsd	%xmm0, (%r10,%rsi,8)
18000154a:     	cmpq	%r12, %rbx
18000154d:     	jae	0x1800014ac <.text+0x4ac>
180001553:     	movq	0x170(%rsp), %r10
18000155b:     	leaq	(%r10,%rbx,8), %r10
18000155f:     	sarq	$0x3f, %rbx
180001563:     	andq	%r12, %rbx
180001566:     	movsd	%xmm1, (%r10,%rbx,8)
18000156c:     	movzbl	(%rdi), %r10d
180001570:     	movl	%r10d, %esi
180001573:     	testb	%sil, %sil
180001576:     	setne	%bl
180001579:     	movq	%r11, %r14
18000157c:     	subq	%rax, %r14
18000157f:     	setl	%bpl
180001583:     	orb	%bl, %bpl
180001586:     	jne	0x1800015c0 <.text+0x5c0>
180001588:     	testb	%r10b, %r10b
18000158b:     	jne	0x1800015cd <.text+0x5cd>
18000158d:     	cmpq	%r14, %rcx
180001590:     	jg	0x1800015cd <.text+0x5cd>
180001592:     	movq	%rcx, %rbx
180001595:     	nopw	%cs:(%rax,%rax)
18000159f:     	nop
1800015a0:     	subq	%rbx, %r14
1800015a3:     	shrq	%rbx
1800015a6:     	cmpq	%r14, %rbx
1800015a9:     	jle	0x1800015a0 <.text+0x5a0>
1800015ab:     	xorl	%esi, %esi
1800015ad:     	movq	%r14, %r11
1800015b0:     	testq	%rbx, %rbx
1800015b3:     	jne	0x1800015e0 <.text+0x5e0>
1800015b5:     	jmp	0x180001340 <.text+0x340>
1800015ba:     	nopw	(%rax,%rax)
1800015c0:     	movq	%rax, %rbx
1800015c3:     	testq	%rbx, %rbx
1800015c6:     	jne	0x1800015e0 <.text+0x5e0>
1800015c8:     	jmp	0x180001340 <.text+0x340>
1800015cd:     	movl	%r10d, %esi
1800015d0:     	movq	%r14, %r11
1800015d3:     	movq	%rcx, %rbx
1800015d6:     	testq	%rbx, %rbx
1800015d9:     	je	0x180001340 <.text+0x340>
1800015df:     	nop
1800015e0:     	movq	%rbx, %r14
1800015e3:     	movabsq	$0x7fffffffffffffff, %r15 # imm = 0x7FFFFFFFFFFFFFFF
1800015ed:     	xorq	%r15, %r14
1800015f0:     	cmpq	%r14, %r11
1800015f3:     	jle	0x180001340 <.text+0x340>
1800015f9:     	movb	$0x1, (%rdi)
1800015fc:     	movb	$0x1, %r10b
1800015ff:     	movb	$0x1, %sil
180001602:     	xorl	%r11d, %r11d
180001605:     	jmp	0x180001343 <.text+0x343>
18000160a:     	cvtsi2sdq	0x180(%rsp), %xmm9
180001614:     	addsd	%xmm9, %xmm9
180001619:     	mulsd	0x5d86(%rip), %xmm9     # 0x1800073a8
180001622:     	movl	$0x1, %eax
180001627:     	movq	%rax, 0x20(%rsp)
18000162c:     	xorl	%ecx, %ecx
18000162e:     	xorpd	%xmm10, %xmm10
180001633:     	movsd	0x5d74(%rip), %xmm11    # 0x1800073b0
18000163c:     	movsd	0x5d5b(%rip), %xmm12    # 0x1800073a0
180001645:     	movsd	0x5d6a(%rip), %xmm13    # 0x1800073b8
18000164e:     	movapd	0x5d39(%rip), %xmm14    # 0x180007390
180001657:     	nopw	(%rax,%rax)
180001660:     	cmpq	0x48(%rsp), %rcx
180001665:     	jge	0x1800012a7 <.text+0x2a7>
18000166b:     	movq	%rcx, 0x50(%rsp)
180001670:     	xorps	%xmm15, %xmm15
180001674:     	cvtsi2sdq	0x20(%rsp), %xmm15
18000167b:     	addsd	%xmm15, %xmm15
180001680:     	movapd	%xmm9, %xmm0
180001685:     	divsd	%xmm15, %xmm0
18000168a:     	movapd	%xmm15, %xmm8
18000168f:     	cmpeqsd	%xmm10, %xmm8
180001695:     	andnpd	%xmm0, %xmm8
18000169a:     	movapd	%xmm8, %xmm0
18000169f:     	callq	0x180005f2c <numba_list_iter_next+0xe6c>
1800016a4:     	movapd	%xmm0, %xmm6
1800016a8:     	movapd	%xmm8, %xmm7
1800016ad:     	mulsd	%xmm11, %xmm7
1800016b2:     	movapd	%xmm7, %xmm0
1800016b6:     	callq	0x180005f2c <numba_list_iter_next+0xe6c>
1800016bb:     	ucomisd	%xmm10, %xmm15
1800016c0:     	jne	0x1800016c4 <.text+0x6c4>
1800016c2:     	jnp	0x180001720 <.text+0x720>
1800016c4:     	cmpordsd	%xmm10, %xmm8
1800016ca:     	movapd	%xmm6, %xmm1
1800016ce:     	cmpunordsd	%xmm10, %xmm1
1800016d4:     	andpd	%xmm8, %xmm1
1800016d9:     	movd	%xmm1, %eax
1800016dd:     	testb	$0x1, %al
1800016df:     	jne	0x180001720 <.text+0x720>
1800016e1:     	cmpordsd	%xmm10, %xmm7
1800016e7:     	movapd	%xmm0, %xmm1
1800016eb:     	cmpunordsd	%xmm10, %xmm1
1800016f1:     	andpd	%xmm7, %xmm1
1800016f5:     	movd	%xmm1, %eax
1800016f9:     	testb	$0x1, %al
1800016fb:     	jne	0x180001720 <.text+0x720>
1800016fd:     	ucomisd	%xmm15, %xmm12
180001702:     	jbe	0x18000172a <.text+0x72a>
180001704:     	cmpq	$0x0, 0x30(%rsp)
18000170a:     	jle	0x1800019b0 <.text+0x9b0>
180001710:     	movq	0x20(%rsp), %rax
180001715:     	addq	%rax, %rax
180001718:     	movq	%rax, 0x28(%rsp)
18000171d:     	jmp	0x180001743 <.text+0x743>
18000171f:     	nop
180001720:     	movb	$0x1, (%rdi)
180001723:     	ucomisd	%xmm15, %xmm12
180001728:     	ja	0x180001704 <.text+0x704>
18000172a:     	cmpq	$0x0, 0x30(%rsp)
180001730:     	movb	$0x1, (%rdi)
180001733:     	movl	$0x1, %eax
180001738:     	movq	%rax, 0x28(%rsp)
18000173d:     	jle	0x1800019b0 <.text+0x9b0>
180001743:     	movq	0x30(%rsp), %rax
180001748:     	cqto
18000174a:     	idivq	0x28(%rsp)
18000174f:     	xorl	%r8d, %r8d
180001752:     	testq	%rdx, %rdx
180001755:     	setne	%r8b
180001759:     	movq	%rax, %rdx
18000175c:     	addq	%r8, %rdx
18000175f:     	jle	0x1800019b0 <.text+0x9b0>
180001765:     	movq	0x20(%rsp), %rdx
18000176a:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
180001774:     	xorq	%rcx, %rdx
180001777:     	leaq	0x1(%rax,%r8), %rax
18000177c:     	movq	0x28(%rsp), %rcx
180001781:     	addq	%rcx, %rcx
180001784:     	movq	%rcx, 0x38(%rsp)
180001789:     	xorl	%r9d, %r9d
18000178c:     	xorl	%r10d, %r10d
18000178f:     	jmp	0x1800017ca <.text+0x7ca>
180001791:     	nopw	%cs:(%rax,%rax)
18000179b:     	nopl	(%rax,%rax)
1800017a0:     	sarq	$0x3f, %r8
1800017a4:     	andq	%r12, %r8
1800017a7:     	addsd	(%r11,%r8,8), %xmm2
1800017ad:     	movsd	%xmm2, (%r11,%r8,8)
1800017b3:     	addq	0x28(%rsp), %r10
1800017b8:     	decq	%rax
1800017bb:     	addq	0x38(%rsp), %r9
1800017c0:     	cmpq	$0x1, %rax
1800017c4:     	jbe	0x1800019b0 <.text+0x9b0>
1800017ca:     	cmpb	$0x0, (%rdi)
1800017cd:     	jne	0x1800019b0 <.text+0x9b0>
1800017d3:     	xorps	%xmm1, %xmm1
1800017d6:     	cvtsi2sd	%r10, %xmm1
1800017db:     	addsd	%xmm1, %xmm1
1800017df:     	andpd	%xmm14, %xmm1
1800017e4:     	ucomisd	%xmm1, %xmm12
1800017e9:     	movq	%r9, %r11
1800017ec:     	ja	0x1800017f4 <.text+0x7f4>
1800017ee:     	movb	$0x1, (%rdi)
1800017f1:     	xorl	%r11d, %r11d
1800017f4:     	cmpq	%rdx, %r10
1800017f7:     	jle	0x180001800 <.text+0x800>
1800017f9:     	movb	$0x1, (%rdi)
1800017fc:     	xorl	%esi, %esi
1800017fe:     	jmp	0x180001809 <.text+0x809>
180001800:     	movq	0x20(%rsp), %rcx
180001805:     	leaq	(%rcx,%r10), %rsi
180001809:     	xorps	%xmm1, %xmm1
18000180c:     	cvtsi2sd	%rsi, %xmm1
180001811:     	addsd	%xmm1, %xmm1
180001815:     	andpd	%xmm14, %xmm1
18000181a:     	ucomisd	%xmm1, %xmm12
18000181f:     	jbe	0x180001830 <.text+0x830>
180001821:     	leaq	(%rsi,%rsi), %rbx
180001825:     	sarq	$0x3f, %rsi
180001829:     	andq	%r12, %rsi
18000182c:     	jmp	0x180001837 <.text+0x837>
18000182e:     	nop
180001830:     	movb	$0x1, (%rdi)
180001833:     	xorl	%ebx, %ebx
180001835:     	xorl	%esi, %esi
180001837:     	addq	%rbx, %rsi
18000183a:     	cmpq	%r12, %rsi
18000183d:     	movq	0x170(%rsp), %rcx
180001845:     	leaq	(%rcx,%rsi,8), %r8
180001849:     	jae	0x180001860 <.text+0x860>
18000184b:     	movq	%rsi, %r14
18000184e:     	sarq	$0x3f, %r14
180001852:     	andq	%r12, %r14
180001855:     	movsd	(%r8,%r14,8), %xmm1
18000185b:     	jmp	0x180001867 <.text+0x867>
18000185d:     	nopl	(%rax)
180001860:     	movb	$0x1, (%rdi)
180001863:     	xorpd	%xmm1, %xmm1
180001867:     	movq	%rbx, %r14
18000186a:     	sarq	$0x3f, %r14
18000186e:     	andq	%r12, %r14
180001871:     	leaq	0x1(%r14,%rbx), %rbx
180001876:     	cmpq	%r12, %rbx
180001879:     	leaq	(%rcx,%rbx,8), %r14
18000187d:     	jae	0x1800018a0 <.text+0x8a0>
18000187f:     	movq	%rbx, %r15
180001882:     	sarq	$0x3f, %r15
180001886:     	andq	%r12, %r15
180001889:     	movsd	(%r14,%r15,8), %xmm2
18000188f:     	jmp	0x1800018a7 <.text+0x8a7>
180001891:     	nopw	%cs:(%rax,%rax)
18000189b:     	nopl	(%rax,%rax)
1800018a0:     	movb	$0x1, (%rdi)
1800018a3:     	xorpd	%xmm2, %xmm2
1800018a7:     	movq	%r11, %r13
1800018aa:     	sarq	$0x3f, %r13
1800018ae:     	andq	%r12, %r13
1800018b1:     	leaq	(%r13,%r11), %rcx
1800018b6:     	cmpq	%r12, %rcx
1800018b9:     	movq	0x170(%rsp), %r15
1800018c1:     	leaq	(%r15,%rcx,8), %rbp
1800018c5:     	jae	0x1800018f0 <.text+0x8f0>
1800018c7:     	movq	%rcx, %r15
1800018ca:     	sarq	$0x3f, %r15
1800018ce:     	andq	%r12, %r15
1800018d1:     	movsd	(%rbp,%r15,8), %xmm3
1800018d8:     	cmpq	%r12, %rsi
1800018db:     	jb	0x1800018fc <.text+0x8fc>
1800018dd:     	movb	$0x1, (%rdi)
1800018e0:     	jmp	0x18000190d <.text+0x90d>
1800018e2:     	nopw	%cs:(%rax,%rax)
1800018ec:     	nopl	(%rax)
1800018f0:     	movb	$0x1, (%rdi)
1800018f3:     	xorpd	%xmm3, %xmm3
1800018f7:     	cmpq	%r12, %rsi
1800018fa:     	jae	0x1800018dd <.text+0x8dd>
1800018fc:     	subsd	%xmm1, %xmm3
180001900:     	sarq	$0x3f, %rsi
180001904:     	andq	%r12, %rsi
180001907:     	movsd	%xmm3, (%r8,%rsi,8)
18000190d:     	leaq	0x1(%r13,%r11), %r8
180001912:     	cmpq	%r12, %r8
180001915:     	movq	0x170(%rsp), %r11
18000191d:     	leaq	(%r11,%r8,8), %r11
180001921:     	jae	0x180001960 <.text+0x960>
180001923:     	movq	%r8, %rsi
180001926:     	sarq	$0x3f, %rsi
18000192a:     	andq	%r12, %rsi
18000192d:     	movsd	(%r11,%rsi,8), %xmm3
180001933:     	cmpq	%r12, %rbx
180001936:     	jb	0x18000196c <.text+0x96c>
180001938:     	movb	$0x1, (%rdi)
18000193b:     	movq	0x170(%rsp), %rbx
180001943:     	cmpq	%r12, %rcx
180001946:     	jb	0x18000198a <.text+0x98a>
180001948:     	movb	$0x1, (%rdi)
18000194b:     	cmpq	%r12, %r8
18000194e:     	jb	0x1800017a0 <.text+0x7a0>
180001954:     	jmp	0x1800019a6 <.text+0x9a6>
180001956:     	nopw	%cs:(%rax,%rax)
180001960:     	movb	$0x1, (%rdi)
180001963:     	xorpd	%xmm3, %xmm3
180001967:     	cmpq	%r12, %rbx
18000196a:     	jae	0x180001938 <.text+0x938>
18000196c:     	subsd	%xmm2, %xmm3
180001970:     	sarq	$0x3f, %rbx
180001974:     	andq	%r12, %rbx
180001977:     	movsd	%xmm3, (%r14,%rbx,8)
18000197d:     	movq	0x170(%rsp), %rbx
180001985:     	cmpq	%r12, %rcx
180001988:     	jae	0x180001948 <.text+0x948>
18000198a:     	sarq	$0x3f, %rcx
18000198e:     	andq	%r12, %rcx
180001991:     	addsd	(%rbp,%rcx,8), %xmm1
180001997:     	movsd	%xmm1, (%rbp,%rcx,8)
18000199d:     	cmpq	%r12, %r8
1800019a0:     	jb	0x1800017a0 <.text+0x7a0>
1800019a6:     	movb	$0x1, (%rdi)
1800019a9:     	jmp	0x1800017b3 <.text+0x7b3>
1800019ae:     	nop
1800019b0:     	cmpq	$0x2, 0x20(%rsp)
1800019b6:     	jge	0x1800019f0 <.text+0x9f0>
1800019b8:     	ucomisd	%xmm15, %xmm12
1800019bd:     	jbe	0x180001d4e <.text+0xd4e>
1800019c3:     	movq	0x50(%rsp), %rcx
1800019c8:     	incq	%rcx
1800019cb:     	movq	0x20(%rsp), %rax
1800019d0:     	addq	%rax, %rax
1800019d3:     	movq	%rax, 0x20(%rsp)
1800019d8:     	cmpb	$0x0, (%rdi)
1800019db:     	je	0x180001660 <.text+0x660>
1800019e1:     	jmp	0x1800012a7 <.text+0x2a7>
1800019e6:     	nopw	%cs:(%rax,%rax)
1800019f0:     	movapd	%xmm0, %xmm1
1800019f4:     	addsd	%xmm0, %xmm1
1800019f8:     	mulsd	%xmm0, %xmm1
1800019fc:     	movq	0x20(%rsp), %rcx
180001a01:     	leaq	(%rcx,%rcx), %rax
180001a05:     	movq	%rax, 0x58(%rsp)
180001a0a:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180001a14:     	subq	%rcx, %rax
180001a17:     	movq	%rax, 0x38(%rsp)
180001a1c:     	movl	$0x1, %r9d
180001a22:     	xorpd	%xmm0, %xmm0
180001a26:     	movapd	%xmm13, %xmm2
180001a2b:     	jmp	0x180001a3e <.text+0xa3e>
180001a2d:     	nopl	(%rax)
180001a30:     	incq	%r9
180001a33:     	cmpq	0x20(%rsp), %r9
180001a38:     	je	0x1800019b8 <.text+0x9b8>
180001a3e:     	cmpb	$0x0, (%rdi)
180001a41:     	jne	0x1800019b8 <.text+0x9b8>
180001a47:     	movapd	%xmm2, %xmm3
180001a4b:     	ucomisd	%xmm15, %xmm12
180001a50:     	movapd	%xmm6, %xmm4
180001a54:     	mulsd	%xmm0, %xmm4
180001a58:     	subsd	%xmm4, %xmm2
180001a5c:     	movapd	%xmm1, %xmm4
180001a60:     	mulsd	%xmm3, %xmm4
180001a64:     	subsd	%xmm4, %xmm2
180001a68:     	mulsd	%xmm6, %xmm3
180001a6c:     	addsd	%xmm0, %xmm3
180001a70:     	movapd	%xmm0, %xmm4
180001a74:     	mulsd	%xmm1, %xmm4
180001a78:     	movapd	%xmm3, %xmm0
180001a7c:     	subsd	%xmm4, %xmm0
180001a80:     	jbe	0x180001aa0 <.text+0xaa0>
180001a82:     	cmpq	$0x0, 0x30(%rsp)
180001a88:     	movq	0x58(%rsp), %rax
180001a8d:     	movq	%rax, 0x28(%rsp)
180001a92:     	jg	0x180001ab9 <.text+0xab9>
180001a94:     	jmp	0x180001a30 <.text+0xa30>
180001a96:     	nopw	%cs:(%rax,%rax)
180001aa0:     	cmpq	$0x0, 0x30(%rsp)
180001aa6:     	movb	$0x1, (%rdi)
180001aa9:     	movl	$0x1, %eax
180001aae:     	movq	%rax, 0x28(%rsp)
180001ab3:     	jle	0x180001a30 <.text+0xa30>
180001ab9:     	movq	0x30(%rsp), %rax
180001abe:     	cqto
180001ac0:     	idivq	0x28(%rsp)
180001ac5:     	xorl	%ecx, %ecx
180001ac7:     	testq	%rdx, %rdx
180001aca:     	setne	%cl
180001acd:     	movq	%rax, %rdx
180001ad0:     	addq	%rcx, %rdx
180001ad3:     	jle	0x180001a30 <.text+0xa30>
180001ad9:     	movq	%r9, %rdx
180001adc:     	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
180001ae6:     	xorq	%r8, %rdx
180001ae9:     	leaq	0x1(%rax,%rcx), %rax
180001aee:     	xorl	%r11d, %r11d
180001af1:     	jmp	0x180001b23 <.text+0xb23>
180001af3:     	nopw	%cs:(%rax,%rax)
180001afd:     	nopl	(%rax)
180001b00:     	sarq	$0x3f, %rcx
180001b04:     	andq	%r12, %rcx
180001b07:     	addsd	(%rsi,%rcx,8), %xmm3
180001b0c:     	movsd	%xmm3, (%rsi,%rcx,8)
180001b11:     	addq	0x28(%rsp), %r11
180001b16:     	decq	%rax
180001b19:     	cmpq	$0x1, %rax
180001b1d:     	jbe	0x180001a30 <.text+0xa30>
180001b23:     	cmpb	$0x0, (%rdi)
180001b26:     	jne	0x180001a30 <.text+0xa30>
180001b2c:     	cmpq	%rdx, %r11
180001b2f:     	jle	0x180001b40 <.text+0xb40>
180001b31:     	movb	$0x1, (%rdi)
180001b34:     	xorl	%r13d, %r13d
180001b37:     	jmp	0x180001b44 <.text+0xb44>
180001b39:     	nopl	(%rax)
180001b40:     	leaq	(%r9,%r11), %r13
180001b44:     	xorps	%xmm3, %xmm3
180001b47:     	cvtsi2sd	%r13, %xmm3
180001b4c:     	addsd	%xmm3, %xmm3
180001b50:     	andpd	%xmm14, %xmm3
180001b55:     	ucomisd	%xmm3, %xmm12
180001b5a:     	jbe	0x180001b80 <.text+0xb80>
180001b5c:     	addq	%r13, %r13
180001b5f:     	cmpq	%rdx, %r11
180001b62:     	jg	0x180001b8b <.text+0xb8b>
180001b64:     	leaq	(%r9,%r11), %rcx
180001b68:     	cmpq	0x38(%rsp), %rcx
180001b6d:     	jle	0x180001b90 <.text+0xb90>
180001b6f:     	movb	$0x1, (%rdi)
180001b72:     	xorl	%ecx, %ecx
180001b74:     	jmp	0x180001b95 <.text+0xb95>
180001b76:     	nopw	%cs:(%rax,%rax)
180001b80:     	movb	$0x1, (%rdi)
180001b83:     	xorl	%r13d, %r13d
180001b86:     	cmpq	%rdx, %r11
180001b89:     	jle	0x180001b64 <.text+0xb64>
180001b8b:     	movb	$0x1, (%rdi)
180001b8e:     	xorl	%ecx, %ecx
180001b90:     	addq	0x20(%rsp), %rcx
180001b95:     	xorps	%xmm3, %xmm3
180001b98:     	cvtsi2sd	%rcx, %xmm3
180001b9d:     	addsd	%xmm3, %xmm3
180001ba1:     	andpd	%xmm14, %xmm3
180001ba6:     	ucomisd	%xmm3, %xmm12
180001bab:     	jbe	0x180001bd0 <.text+0xbd0>
180001bad:     	leaq	(%rcx,%rcx), %r8
180001bb1:     	sarq	$0x3f, %rcx
180001bb5:     	andq	%r12, %rcx
180001bb8:     	addq	%r8, %rcx
180001bbb:     	cmpq	%r12, %rcx
180001bbe:     	leaq	(%rbx,%rcx,8), %rbp
180001bc2:     	jb	0x180001be4 <.text+0xbe4>
180001bc4:     	movb	$0x1, (%rdi)
180001bc7:     	xorpd	%xmm3, %xmm3
180001bcb:     	jmp	0x180001bf4 <.text+0xbf4>
180001bcd:     	nopl	(%rax)
180001bd0:     	movb	$0x1, (%rdi)
180001bd3:     	xorl	%r8d, %r8d
180001bd6:     	xorl	%ecx, %ecx
180001bd8:     	addq	%r8, %rcx
180001bdb:     	cmpq	%r12, %rcx
180001bde:     	leaq	(%rbx,%rcx,8), %rbp
180001be2:     	jae	0x180001bc4 <.text+0xbc4>
180001be4:     	movq	%rcx, %rsi
180001be7:     	sarq	$0x3f, %rsi
180001beb:     	andq	%r12, %rsi
180001bee:     	movsd	(%rbp,%rsi,8), %xmm3
180001bf4:     	movq	%r8, %rsi
180001bf7:     	sarq	$0x3f, %rsi
180001bfb:     	andq	%r12, %rsi
180001bfe:     	leaq	0x1(%rsi,%r8), %r15
180001c03:     	cmpq	%r12, %r15
180001c06:     	leaq	(%rbx,%r15,8), %r14
180001c0a:     	jae	0x180001c20 <.text+0xc20>
180001c0c:     	movq	%r15, %r8
180001c0f:     	sarq	$0x3f, %r8
180001c13:     	andq	%r12, %r8
180001c16:     	movsd	(%r14,%r8,8), %xmm4
180001c1c:     	jmp	0x180001c27 <.text+0xc27>
180001c1e:     	nop
180001c20:     	movb	$0x1, (%rdi)
180001c23:     	xorpd	%xmm4, %xmm4
180001c27:     	movq	%r13, %rsi
180001c2a:     	sarq	$0x3f, %rsi
180001c2e:     	andq	%r12, %rsi
180001c31:     	leaq	(%rsi,%r13), %r10
180001c35:     	cmpq	%r12, %r10
180001c38:     	leaq	(%rbx,%r10,8), %r8
180001c3c:     	jae	0x180001c60 <.text+0xc60>
180001c3e:     	movq	%r10, %rbx
180001c41:     	sarq	$0x3f, %rbx
180001c45:     	andq	%r12, %rbx
180001c48:     	movsd	(%r8,%rbx,8), %xmm7
180001c4e:     	movq	0x170(%rsp), %rbx
180001c56:     	jmp	0x180001c67 <.text+0xc67>
180001c58:     	nopl	(%rax,%rax)
180001c60:     	movb	$0x1, (%rdi)
180001c63:     	xorpd	%xmm7, %xmm7
180001c67:     	movapd	%xmm2, %xmm5
180001c6b:     	mulsd	%xmm3, %xmm5
180001c6f:     	movapd	%xmm0, %xmm8
180001c74:     	mulsd	%xmm4, %xmm8
180001c79:     	subsd	%xmm8, %xmm5
180001c7e:     	cmpq	%r12, %rcx
180001c81:     	jae	0x180001cb0 <.text+0xcb0>
180001c83:     	subsd	%xmm5, %xmm7
180001c87:     	sarq	$0x3f, %rcx
180001c8b:     	andq	%r12, %rcx
180001c8e:     	movsd	%xmm7, (%rbp,%rcx,8)
180001c94:     	leaq	0x1(%rsi,%r13), %rcx
180001c99:     	cmpq	%r12, %rcx
180001c9c:     	leaq	(%rbx,%rcx,8), %rsi
180001ca0:     	jb	0x180001cc1 <.text+0xcc1>
180001ca2:     	movb	$0x1, (%rdi)
180001ca5:     	xorpd	%xmm7, %xmm7
180001ca9:     	jmp	0x180001cd8 <.text+0xcd8>
180001cab:     	nopl	(%rax,%rax)
180001cb0:     	movb	$0x1, (%rdi)
180001cb3:     	leaq	0x1(%rsi,%r13), %rcx
180001cb8:     	cmpq	%r12, %rcx
180001cbb:     	leaq	(%rbx,%rcx,8), %rsi
180001cbf:     	jae	0x180001ca2 <.text+0xca2>
180001cc1:     	movq	%rcx, %rbx
180001cc4:     	sarq	$0x3f, %rbx
180001cc8:     	andq	%r12, %rbx
180001ccb:     	movsd	(%rsi,%rbx,8), %xmm7
180001cd0:     	movq	0x170(%rsp), %rbx
180001cd8:     	mulsd	%xmm2, %xmm4
180001cdc:     	mulsd	%xmm0, %xmm3
180001ce0:     	addsd	%xmm4, %xmm3
180001ce4:     	cmpq	%r12, %r15
180001ce7:     	jae	0x180001d10 <.text+0xd10>
180001ce9:     	subsd	%xmm3, %xmm7
180001ced:     	sarq	$0x3f, %r15
180001cf1:     	andq	%r12, %r15
180001cf4:     	movsd	%xmm7, (%r14,%r15,8)
180001cfa:     	cmpq	%r12, %r10
180001cfd:     	jb	0x180001d18 <.text+0xd18>
180001cff:     	movb	$0x1, (%rdi)
180001d02:     	cmpq	%r12, %rcx
180001d05:     	jb	0x180001b00 <.text+0xb00>
180001d0b:     	jmp	0x180001d34 <.text+0xd34>
180001d0d:     	nopl	(%rax)
180001d10:     	movb	$0x1, (%rdi)
180001d13:     	cmpq	%r12, %r10
180001d16:     	jae	0x180001cff <.text+0xcff>
180001d18:     	sarq	$0x3f, %r10
180001d1c:     	andq	%r12, %r10
180001d1f:     	addsd	(%r8,%r10,8), %xmm5
180001d25:     	movsd	%xmm5, (%r8,%r10,8)
180001d2b:     	cmpq	%r12, %rcx
180001d2e:     	jb	0x180001b00 <.text+0xb00>
180001d34:     	movb	$0x1, (%rdi)
180001d37:     	addq	0x28(%rsp), %r11
180001d3c:     	decq	%rax
180001d3f:     	cmpq	$0x1, %rax
180001d43:     	ja	0x180001b23 <.text+0xb23>
180001d49:     	jmp	0x180001a30 <.text+0xa30>
180001d4e:     	movb	$0x1, (%rdi)
180001d51:     	jmp	0x1800012a7 <.text+0x2a7>
180001d56:     	nopw	%cs:(%rax,%rax)
180001d60:     	pushq	%r15
180001d62:     	pushq	%r14
180001d64:     	pushq	%r13
180001d66:     	pushq	%r12
180001d68:     	pushq	%rsi
180001d69:     	pushq	%rdi
180001d6a:     	pushq	%rbp
180001d6b:     	pushq	%rbx
180001d6c:     	subq	$0xf8, %rsp
180001d73:     	movq	%rdx, %rcx
180001d76:     	leaq	0x50(%rsp), %rax
180001d7b:     	movq	%rax, 0x38(%rsp)
180001d80:     	leaq	0x58(%rsp), %rax
180001d85:     	movq	%rax, 0x30(%rsp)
180001d8a:     	leaq	0x60(%rsp), %rax
180001d8f:     	movq	%rax, 0x28(%rsp)
180001d94:     	leaq	0x68(%rsp), %rax
180001d99:     	movq	%rax, 0x20(%rsp)
180001d9e:     	leaq	0x580b(%rip), %rdx      # 0x1800075b0
180001da5:     	movl	$0x4, %r8d
180001dab:     	movl	$0x4, %r9d
180001db1:     	callq	0x1800053d1 <numba_list_iter_next+0x311>
180001db6:     	testl	%eax, %eax
180001db8:     	movq	$0x0, 0x48(%rsp)
180001dc1:     	je	0x180002042 <.text+0x1042>
180001dc7:     	cmpq	$0x0, 0xd029(%rip)      # 0x18000edf8
180001dcf:     	je	0x180001fb5 <.text+0xfb5>
180001dd5:     	movq	0x68(%rsp), %rcx
180001dda:     	xorps	%xmm0, %xmm0
180001ddd:     	movaps	%xmm0, 0xb0(%rsp)
180001de5:     	movaps	%xmm0, 0xc0(%rsp)
180001ded:     	movaps	%xmm0, 0xd0(%rsp)
180001df5:     	movq	$0x0, 0xe0(%rsp)
180001e01:     	leaq	0xb0(%rsp), %rdx
180001e09:     	callq	0x180004090 <PyInit_rcaot_05cb37762ef1645705ed4668+0xdc0>
180001e0e:     	testl	%eax, %eax
180001e10:     	jne	0x180001fca <.text+0xfca>
180001e16:     	cmpq	$0x1, 0xc8(%rsp)
180001e1f:     	jne	0x180001fca <.text+0xfca>
180001e25:     	movq	0xb0(%rsp), %rsi
180001e2d:     	movq	0xd0(%rsp), %rdi
180001e35:     	movq	0x60(%rsp), %rcx
180001e3a:     	callq	0x1800053d7 <numba_list_iter_next+0x317>
180001e3f:     	testq	%rax, %rax
180001e42:     	je	0x180001fdf <.text+0xfdf>
180001e48:     	movq	%rax, %r14
180001e4b:     	movq	%rax, %rcx
180001e4e:     	callq	0x1800053dd <numba_list_iter_next+0x31d>
180001e53:     	movq	%rax, %rbx
180001e56:     	movq	%r14, %rcx
180001e59:     	callq	0x1800053e3 <numba_list_iter_next+0x323>
180001e5e:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
180001e63:     	testq	%rax, %rax
180001e66:     	jne	0x18000201f <.text+0x101f>
180001e6c:     	movq	0x58(%rsp), %rcx
180001e71:     	xorps	%xmm0, %xmm0
180001e74:     	movaps	%xmm0, 0x70(%rsp)
180001e79:     	movaps	%xmm0, 0x80(%rsp)
180001e81:     	movaps	%xmm0, 0x90(%rsp)
180001e89:     	movq	$0x0, 0xa0(%rsp)
180001e95:     	leaq	0x70(%rsp), %rdx
180001e9a:     	callq	0x180004090 <PyInit_rcaot_05cb37762ef1645705ed4668+0xdc0>
180001e9f:     	testl	%eax, %eax
180001ea1:     	jne	0x180001ff1 <.text+0xff1>
180001ea7:     	cmpq	$0x8, 0x88(%rsp)
180001eb0:     	jne	0x180001ff1 <.text+0xff1>
180001eb6:     	movq	0x70(%rsp), %r14
180001ebb:     	movq	0x90(%rsp), %r13
180001ec3:     	movq	0x98(%rsp), %rbp
180001ecb:     	movq	0x50(%rsp), %rcx
180001ed0:     	callq	0x1800053d7 <numba_list_iter_next+0x317>
180001ed5:     	testq	%rax, %rax
180001ed8:     	je	0x180002006 <.text+0x1006>
180001ede:     	movq	%rax, %r12
180001ee1:     	movq	%rax, %rcx
180001ee4:     	callq	0x1800053dd <numba_list_iter_next+0x31d>
180001ee9:     	movq	%rax, %r15
180001eec:     	movq	%r12, %rcx
180001eef:     	callq	0x1800053e3 <numba_list_iter_next+0x323>
180001ef4:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
180001ef9:     	testq	%rax, %rax
180001efc:     	jne	0x180002017 <.text+0x1017>
180001f02:     	movq	%r15, 0x30(%rsp)
180001f07:     	movq	%rbp, 0x28(%rsp)
180001f0c:     	movq	%r13, 0x20(%rsp)
180001f11:     	leaq	0xf0(%rsp), %rcx
180001f19:     	leaq	0x48(%rsp), %rdx
180001f1e:     	movq	%rdi, %r8
180001f21:     	movq	%rbx, %r9
180001f24:     	callq	0x180001090 <.text+0x90>
180001f29:     	movl	%eax, %ebx
180001f2b:     	movq	0x48(%rsp), %rdi
180001f30:     	movq	%rsi, %rcx
180001f33:     	callq	0x180001060 <.text+0x60>
180001f38:     	movq	%r14, %rcx
180001f3b:     	callq	0x180001060 <.text+0x60>
180001f40:     	testl	%ebx, %ebx
180001f42:     	jne	0x180001f6a <.text+0xf6a>
180001f44:     	movq	0x5385(%rip), %rsi      # 0x1800072d0
180001f4b:     	movq	%rsi, %rcx
180001f4e:     	callq	0x1800053ef <numba_list_iter_next+0x32f>
180001f53:     	movq	%rsi, %rax
180001f56:     	addq	$0xf8, %rsp
180001f5d:     	popq	%rbx
180001f5e:     	popq	%rbp
180001f5f:     	popq	%rdi
180001f60:     	popq	%rsi
180001f61:     	popq	%r12
180001f63:     	popq	%r13
180001f65:     	popq	%r14
180001f67:     	popq	%r15
180001f69:     	retq
180001f6a:     	callq	0x1800053f5 <numba_list_iter_next+0x335>
180001f6f:     	movl	0x8(%rdi), %edx
180001f72:     	movq	(%rdi), %rcx
180001f75:     	cmpl	$0x0, 0x20(%rdi)
180001f79:     	jle	0x180002029 <.text+0x1029>
180001f7f:     	movslq	%edx, %rdx
180001f82:     	callq	0x1800053fb <numba_list_iter_next+0x33b>
180001f87:     	movq	%rax, %rsi
180001f8a:     	movq	0x10(%rdi), %rcx
180001f8e:     	callq	*0x18(%rdi)
180001f91:     	testq	%rax, %rax
180001f94:     	je	0x180002049 <.text+0x1049>
180001f9a:     	movq	%rsi, %rcx
180001f9d:     	movq	%rax, %rdx
180001fa0:     	callq	0x1800038a0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x5d0>
180001fa5:     	movq	%rax, %rsi
180001fa8:     	movq	%rdi, %rcx
180001fab:     	callq	0x180005330 <numba_list_iter_next+0x270>
180001fb0:     	jmp	0x180002035 <.text+0x1035>
180001fb5:     	movq	0x52f4(%rip), %rcx      # 0x1800072b0
180001fbc:     	leaq	0x560d(%rip), %rdx      # 0x1800075d0
180001fc3:     	callq	0x180005401 <numba_list_iter_next+0x341>
180001fc8:     	jmp	0x180002042 <.text+0x1042>
180001fca:     	movq	0x52cf(%rip), %rcx      # 0x1800072a0
180001fd1:     	leaq	0x56d8(%rip), %rdx      # 0x1800076b0
180001fd8:     	callq	0x180005401 <numba_list_iter_next+0x341>
180001fdd:     	jmp	0x180002042 <.text+0x1042>
180001fdf:     	xorl	%ebx, %ebx
180001fe1:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
180001fe6:     	testq	%rax, %rax
180001fe9:     	je	0x180001e6c <.text+0xe6c>
180001fef:     	jmp	0x18000201f <.text+0x101f>
180001ff1:     	movq	0x52a8(%rip), %rcx      # 0x1800072a0
180001ff8:     	leaq	0x56b1(%rip), %rdx      # 0x1800076b0
180001fff:     	callq	0x180005401 <numba_list_iter_next+0x341>
180002004:     	jmp	0x18000201f <.text+0x101f>
180002006:     	xorl	%r15d, %r15d
180002009:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
18000200e:     	testq	%rax, %rax
180002011:     	je	0x180001f02 <.text+0xf02>
180002017:     	movq	%r14, %rcx
18000201a:     	callq	0x180001060 <.text+0x60>
18000201f:     	movq	%rsi, %rcx
180002022:     	callq	0x180001060 <.text+0x60>
180002027:     	jmp	0x180002042 <.text+0x1042>
180002029:     	movq	0x10(%rdi), %r8
18000202d:     	callq	0x1800037c0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4f0>
180002032:     	movq	%rax, %rsi
180002035:     	testq	%rsi, %rsi
180002038:     	je	0x180002042 <.text+0x1042>
18000203a:     	movq	%rsi, %rcx
18000203d:     	callq	0x180003360 <PyInit_rcaot_05cb37762ef1645705ed4668+0x90>
180002042:     	xorl	%esi, %esi
180002044:     	jmp	0x180001f53 <.text+0xf53>
180002049:     	movq	0x5260(%rip), %rcx      # 0x1800072b0
180002050:     	leaq	0x56b9(%rip), %rdx      # 0x180007710
180002057:     	callq	0x180005401 <numba_list_iter_next+0x341>
18000205c:     	jmp	0x180002042 <.text+0x1042>
18000205e:     	nop
180002060:     	pushq	%rsi
180002061:     	pushq	%rdi
180002062:     	pushq	%rbx
180002063:     	subq	$0x50, %rsp
180002067:     	movq	0x90(%rsp), %r8
18000206f:     	movq	0xa8(%rsp), %r9
180002077:     	movq	0xd0(%rsp), %rax
18000207f:     	movq	0xd8(%rsp), %rcx
180002087:     	movq	0xe8(%rsp), %rdx
18000208f:     	movq	$0x0, 0x48(%rsp)
180002098:     	movq	$0x0, 0x40(%rsp)
1800020a1:     	movq	%rdx, 0x30(%rsp)
1800020a6:     	movq	%rcx, 0x28(%rsp)
1800020ab:     	movq	%rax, 0x20(%rsp)
1800020b0:     	leaq	0x48(%rsp), %rcx
1800020b5:     	leaq	0x40(%rsp), %rdx
1800020ba:     	callq	0x180001090 <.text+0x90>
1800020bf:     	movl	%eax, %ecx
1800020c1:     	movq	0x40(%rsp), %rsi
1800020c6:     	movq	0x48(%rsp), %rax
1800020cb:     	movl	$0x0, 0x3c(%rsp)
1800020d3:     	testl	%ecx, %ecx
1800020d5:     	jne	0x1800020df <.text+0x10df>
1800020d7:     	addq	$0x50, %rsp
1800020db:     	popq	%rbx
1800020dc:     	popq	%rdi
1800020dd:     	popq	%rsi
1800020de:     	retq
1800020df:     	movq	%rax, %rbx
1800020e2:     	leaq	0x3c(%rsp), %rcx
1800020e7:     	callq	0x180003330 <PyInit_rcaot_05cb37762ef1645705ed4668+0x60>
1800020ec:     	callq	0x1800053f5 <numba_list_iter_next+0x335>
1800020f1:     	movl	0x8(%rsi), %edx
1800020f4:     	movq	(%rsi), %rcx
1800020f7:     	cmpl	$0x0, 0x20(%rsi)
1800020fb:     	jle	0x18000212c <.text+0x112c>
1800020fd:     	movslq	%edx, %rdx
180002100:     	callq	0x1800053fb <numba_list_iter_next+0x33b>
180002105:     	movq	%rax, %rdi
180002108:     	movq	0x10(%rsi), %rcx
18000210c:     	callq	*0x18(%rsi)
18000210f:     	testq	%rax, %rax
180002112:     	je	0x180002176 <.text+0x1176>
180002114:     	movq	%rdi, %rcx
180002117:     	movq	%rax, %rdx
18000211a:     	callq	0x1800038a0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x5d0>
18000211f:     	movq	%rax, %rdi
180002122:     	movq	%rsi, %rcx
180002125:     	callq	0x180005330 <numba_list_iter_next+0x270>
18000212a:     	jmp	0x180002138 <.text+0x1138>
18000212c:     	movq	0x10(%rsi), %r8
180002130:     	callq	0x1800037c0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4f0>
180002135:     	movq	%rax, %rdi
180002138:     	testq	%rdi, %rdi
18000213b:     	je	0x180002145 <.text+0x1145>
18000213d:     	movq	%rdi, %rcx
180002140:     	callq	0x180003360 <PyInit_rcaot_05cb37762ef1645705ed4668+0x90>
180002145:     	leaq	0x5644(%rip), %rcx      # 0x180007790
18000214c:     	callq	0x180005407 <numba_list_iter_next+0x347>
180002151:     	movq	%rax, %rsi
180002154:     	movq	%rax, %rcx
180002157:     	callq	0x18000540d <numba_list_iter_next+0x34d>
18000215c:     	movq	%rsi, %rcx
18000215f:     	callq	0x1800053e3 <numba_list_iter_next+0x323>
180002164:     	leaq	0x3c(%rsp), %rcx
180002169:     	callq	0x180003350 <PyInit_rcaot_05cb37762ef1645705ed4668+0x80>
18000216e:     	movq	%rbx, %rax
180002171:     	jmp	0x1800020d7 <.text+0x10d7>
180002176:     	movq	0x5133(%rip), %rcx      # 0x1800072b0
18000217d:     	leaq	0x55cc(%rip), %rdx      # 0x180007750
180002184:     	callq	0x180005401 <numba_list_iter_next+0x341>
180002189:     	xorl	%eax, %eax
18000218b:     	jmp	0x1800020d7 <.text+0x10d7>
180002190:     	pushq	%r15
180002192:     	pushq	%r14
180002194:     	pushq	%r13
180002196:     	pushq	%r12
180002198:     	pushq	%rsi
180002199:     	pushq	%rdi
18000219a:     	pushq	%rbp
18000219b:     	pushq	%rbx
18000219c:     	subq	$0x128, %rsp            # imm = 0x128
1800021a3:     	movapd	%xmm15, 0x110(%rsp)
1800021ad:     	movapd	%xmm14, 0x100(%rsp)
1800021b7:     	movapd	%xmm13, 0xf0(%rsp)
1800021c1:     	movapd	%xmm12, 0xe0(%rsp)
1800021cb:     	movapd	%xmm11, 0xd0(%rsp)
1800021d5:     	movapd	%xmm10, 0xc0(%rsp)
1800021df:     	movapd	%xmm9, 0xb0(%rsp)
1800021e9:     	movapd	%xmm8, 0xa0(%rsp)
1800021f3:     	movapd	%xmm7, 0x90(%rsp)
1800021fc:     	movapd	%xmm6, 0x80(%rsp)
180002205:     	movq	%r8, %rbx
180002208:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180002212:     	addq	%r9, %rax
180002215:     	movabsq	$-0x40000000000002, %r8 # imm = 0xFFBFFFFFFFFFFFFE
18000221f:     	cmpq	%r8, %rax
180002222:     	movq	%r9, 0x38(%rsp)
180002227:     	movq	%rcx, 0x60(%rsp)
18000222c:     	ja	0x180002238 <.text+0x1238>
18000222e:     	movb	$0x1, (%rbx)
180002231:     	xorpd	%xmm8, %xmm8
180002236:     	jmp	0x18000225f <.text+0x125f>
180002238:     	xorps	%xmm8, %xmm8
18000223c:     	cvtsi2sd	%r9, %xmm8
180002241:     	mulsd	0x5166(%rip), %xmm8     # 0x1800073b0
18000224a:     	movq	%r9, %rax
18000224d:     	shrq	$0x20, %rax
180002251:     	jne	0x18000225f <.text+0x125f>
180002253:     	movq	%r9, %r8
180002256:     	shrq	%r8
180002259:     	movb	$0x1, %al
18000225b:     	xorl	%ecx, %ecx
18000225d:     	jmp	0x180002291 <.text+0x1291>
18000225f:     	movq	%r9, %r8
180002262:     	shrq	$0x3f, %r8
180002266:     	addq	%r9, %r8
180002269:     	sarq	%r8
18000226c:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002276:     	addq	$0x2, %rax
18000227a:     	movq	%r9, %rcx
18000227d:     	notq	%rcx
180002280:     	andq	%rax, %rcx
180002283:     	xorl	%eax, %eax
180002285:     	cmpq	$0x1, %rcx
180002289:     	movl	$0x0, %ecx
18000228e:     	sbbq	%rcx, %rcx
180002291:     	addq	%rcx, %r8
180002294:     	movq	0x198(%rsp), %r12
18000229c:     	movq	0x190(%rsp), %r13
1800022a4:     	movq	%r8, 0x30(%rsp)
1800022a9:     	cmpq	$0x1, %r8
1800022ad:     	jne	0x1800022da <.text+0x12da>
1800022af:     	xorpd	%xmm0, %xmm0
1800022b3:     	ucomisd	%xmm0, %xmm8
1800022b8:     	jne	0x180002362 <.text+0x1362>
1800022be:     	jp	0x180002362 <.text+0x1362>
1800022c4:     	movb	$0x1, (%rbx)
1800022c7:     	movq	0x38(%rsp), %rcx
1800022cc:     	testq	%rcx, %rcx
1800022cf:     	jg	0x180002379 <.text+0x1379>
1800022d5:     	jmp	0x1800023af <.text+0x13af>
1800022da:     	movzbl	(%rbx), %r9d
1800022de:     	testb	%r9b, %r9b
1800022e1:     	setne	%cl
1800022e4:     	movq	0x30(%rsp), %r10
1800022e9:     	cmpq	$0x2, %r10
1800022ed:     	setl	%r8b
1800022f1:     	orb	%cl, %r8b
1800022f4:     	jne	0x1800023bf <.text+0x13bf>
1800022fa:     	movl	$0x1, %r8d
180002300:     	xorl	%ecx, %ecx
180002302:     	movapd	0x5086(%rip), %xmm0     # 0x180007390
18000230a:     	movsd	0x508e(%rip), %xmm1     # 0x1800073a0
180002312:     	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
18000231c:     	nopl	(%rax)
180002320:     	leaq	0x1(%rcx), %r11
180002324:     	cmpq	%r9, %rcx
180002327:     	movl	$0x0, %ecx
18000232c:     	cmovneq	%r11, %rcx
180002330:     	je	0x1800023c6 <.text+0x13c6>
180002336:     	xorps	%xmm2, %xmm2
180002339:     	cvtsi2sd	%r8, %xmm2
18000233e:     	addsd	%xmm2, %xmm2
180002342:     	andpd	%xmm0, %xmm2
180002346:     	ucomisd	%xmm2, %xmm1
18000234a:     	jbe	0x1800023c6 <.text+0x13c6>
18000234c:     	addq	%r8, %r8
18000234f:     	cmpq	%r10, %r8
180002352:     	jl	0x180002320 <.text+0x1320>
180002354:     	xorl	%r9d, %r9d
180002357:     	cmpq	$0x3f, %rcx
18000235b:     	jae	0x1800023d6 <.text+0x13d6>
18000235d:     	jmp	0x180002463 <.text+0x1463>
180002362:     	movsd	0x504e(%rip), %xmm0     # 0x1800073b8
18000236a:     	divsd	%xmm8, %xmm0
18000236f:     	movq	0x38(%rsp), %rcx
180002374:     	testq	%rcx, %rcx
180002377:     	jle	0x1800023af <.text+0x13af>
180002379:     	xorl	%eax, %eax
18000237b:     	jmp	0x18000239a <.text+0x139a>
18000237d:     	nopl	(%rax)
180002380:     	movsd	(%r13,%rax,8), %xmm1
180002387:     	mulsd	%xmm0, %xmm1
18000238b:     	movsd	%xmm1, (%r13,%rax,8)
180002392:     	incq	%rax
180002395:     	cmpq	%rax, %rcx
180002398:     	je	0x1800023af <.text+0x13af>
18000239a:     	cmpb	$0x0, (%rbx)
18000239d:     	jne	0x1800023af <.text+0x13af>
18000239f:     	cmpq	%r12, %rax
1800023a2:     	jb	0x180002380 <.text+0x1380>
1800023a4:     	movb	$0x1, (%rbx)
1800023a7:     	incq	%rax
1800023aa:     	cmpq	%rax, %rcx
1800023ad:     	jne	0x18000239a <.text+0x139a>
1800023af:     	movq	0x60(%rsp), %rax
1800023b4:     	movq	$0x0, (%rax)
1800023bb:     	xorl	%eax, %eax
1800023bd:     	jmp	0x1800023f7 <.text+0x13f7>
1800023bf:     	xorl	%ecx, %ecx
1800023c1:     	jmp	0x180002463 <.text+0x1463>
1800023c6:     	movb	$0x1, (%rbx)
1800023c9:     	movb	$0x1, %r9b
1800023cc:     	cmpq	$0x3f, %rcx
1800023d0:     	jb	0x180002463 <.text+0x1463>
1800023d6:     	movb	$0x1, (%rbx)
1800023d9:     	movb	$0x1, %r9b
1800023dc:     	xorl	%r8d, %r8d
1800023df:     	testb	%r8b, %r8b
1800023e2:     	jne	0x18000247f <.text+0x147f>
1800023e8:     	leaq	0x54b1(%rip), %rax      # 0x1800078a0
1800023ef:     	movq	%rax, (%rdx)
1800023f2:     	movl	$0x1, %eax
1800023f7:     	movaps	0x80(%rsp), %xmm6
1800023ff:     	movaps	0x90(%rsp), %xmm7
180002407:     	movaps	0xa0(%rsp), %xmm8
180002410:     	movaps	0xb0(%rsp), %xmm9
180002419:     	movaps	0xc0(%rsp), %xmm10
180002422:     	movaps	0xd0(%rsp), %xmm11
18000242b:     	movaps	0xe0(%rsp), %xmm12
180002434:     	movaps	0xf0(%rsp), %xmm13
18000243d:     	movaps	0x100(%rsp), %xmm14
180002446:     	movaps	0x110(%rsp), %xmm15
18000244f:     	addq	$0x128, %rsp            # imm = 0x128
180002456:     	popq	%rbx
180002457:     	popq	%rbp
180002458:     	popq	%rdi
180002459:     	popq	%rsi
18000245a:     	popq	%r12
18000245c:     	popq	%r13
18000245e:     	popq	%r14
180002460:     	popq	%r15
180002462:     	retq
180002463:     	movl	$0x1, %r8d
180002469:     	shlq	%cl, %r8
18000246c:     	cmpq	%r8, %r10
18000246f:     	sete	%r8b
180002473:     	movq	%rcx, %r11
180002476:     	testb	%r8b, %r8b
180002479:     	je	0x1800023e8 <.text+0x13e8>
18000247f:     	cmpq	$0x0, 0x38(%rsp)
180002485:     	je	0x1800022af <.text+0x12af>
18000248b:     	testb	%al, %al
18000248d:     	je	0x1800024ac <.text+0x14ac>
18000248f:     	movq	0x38(%rsp), %rax
180002494:     	shrq	%rax
180002497:     	xorl	%ecx, %ecx
180002499:     	movq	%r11, 0x58(%rsp)
18000249e:     	addq	%rcx, %rax
1800024a1:     	cmpq	$0x2, %rax
1800024a5:     	jl	0x1800024ed <.text+0x14ed>
1800024a7:     	jmp	0x180002c57 <.text+0x1c57>
1800024ac:     	movq	0x38(%rsp), %rdx
1800024b1:     	movq	%rdx, %rax
1800024b4:     	shrq	$0x3f, %rax
1800024b8:     	addq	%rdx, %rax
1800024bb:     	sarq	%rax
1800024be:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
1800024c8:     	addq	$0x2, %rcx
1800024cc:     	notq	%rdx
1800024cf:     	andq	%rcx, %rdx
1800024d2:     	xorl	%ecx, %ecx
1800024d4:     	cmpq	$0x1, %rdx
1800024d8:     	sbbq	%rcx, %rcx
1800024db:     	movq	%r11, 0x58(%rsp)
1800024e0:     	addq	%rcx, %rax
1800024e3:     	cmpq	$0x2, %rax
1800024e7:     	jge	0x180002c57 <.text+0x1c57>
1800024ed:     	cmpq	$0x0, 0x58(%rsp)
1800024f3:     	jle	0x1800022af <.text+0x12af>
1800024f9:     	testb	%r9b, %r9b
1800024fc:     	jne	0x1800022af <.text+0x12af>
180002502:     	movl	$0x1, %edi
180002507:     	movsd	0x4eb0(%rip), %xmm9     # 0x1800073c0
180002510:     	xorpd	%xmm10, %xmm10
180002515:     	movsd	0x4e92(%rip), %xmm11    # 0x1800073b0
18000251e:     	movapd	0x4e69(%rip), %xmm12    # 0x180007390
180002527:     	movsd	0x4e70(%rip), %xmm13    # 0x1800073a0
180002530:     	xorl	%ecx, %ecx
180002532:     	nopw	%cs:(%rax,%rax)
18000253c:     	nopl	(%rax)
180002540:     	movq	%rcx, 0x70(%rsp)
180002545:     	xorps	%xmm15, %xmm15
180002549:     	cvtsi2sd	%rdi, %xmm15
18000254e:     	addsd	%xmm15, %xmm15
180002553:     	movapd	%xmm9, %xmm0
180002558:     	divsd	%xmm15, %xmm0
18000255d:     	movapd	%xmm15, %xmm7
180002562:     	cmpeqsd	%xmm10, %xmm7
180002568:     	andnpd	%xmm0, %xmm7
18000256c:     	movapd	%xmm7, %xmm0
180002570:     	callq	0x180005f2c <numba_list_iter_next+0xe6c>
180002575:     	movapd	%xmm0, %xmm6
180002579:     	mulsd	%xmm11, %xmm7
18000257e:     	movapd	%xmm7, %xmm0
180002582:     	callq	0x180005f2c <numba_list_iter_next+0xe6c>
180002587:     	ucomisd	%xmm10, %xmm15
18000258c:     	jne	0x180002590 <.text+0x1590>
18000258e:     	jnp	0x180002596 <.text+0x1596>
180002590:     	ucomisd	%xmm6, %xmm0
180002594:     	jnp	0x180002599 <.text+0x1599>
180002596:     	movb	$0x1, (%rbx)
180002599:     	andpd	%xmm12, %xmm15
18000259e:     	ucomisd	%xmm15, %xmm13
1800025a3:     	seta	%al
1800025a6:     	testq	%rdi, %rdi
1800025a9:     	setne	%cl
1800025ac:     	testb	%cl, %al
1800025ae:     	movq	0x30(%rsp), %rax
1800025b3:     	movq	%rdi, 0x48(%rsp)
1800025b8:     	jne	0x1800025d0 <.text+0x15d0>
1800025ba:     	testq	%rax, %rax
1800025bd:     	movb	$0x1, (%rbx)
1800025c0:     	movl	$0x1, %ecx
1800025c5:     	jg	0x1800025e8 <.text+0x15e8>
1800025c7:     	jmp	0x180002850 <.text+0x1850>
1800025cc:     	nopl	(%rax)
1800025d0:     	testq	%rax, %rax
1800025d3:     	setg	%al
1800025d6:     	testq	%rdi, %rdi
1800025d9:     	setg	%cl
1800025dc:     	xorb	%al, %cl
1800025de:     	jne	0x180002850 <.text+0x1850>
1800025e4:     	leaq	(%rdi,%rdi), %rcx
1800025e8:     	movq	0x30(%rsp), %r8
1800025ed:     	movq	%r8, %rax
1800025f0:     	cqto
1800025f2:     	idivq	%rcx
1800025f5:     	movq	%rdx, %r9
1800025f8:     	negq	%r9
1800025fb:     	testq	%r8, %r8
1800025fe:     	cmovgq	%rdx, %r9
180002602:     	xorl	%r8d, %r8d
180002605:     	testq	%r9, %r9
180002608:     	setg	%r8b
18000260c:     	movq	%rax, %rdx
18000260f:     	addq	%r8, %rdx
180002612:     	jle	0x180002850 <.text+0x1850>
180002618:     	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
180002622:     	subq	%rdi, %rdx
180002625:     	movq	%rdx, 0x40(%rsp)
18000262a:     	incq	%rdx
18000262d:     	movq	%rdx, 0x50(%rsp)
180002632:     	leaq	0x1(%rax,%r8), %rax
180002637:     	xorl	%r10d, %r10d
18000263a:     	xorl	%r11d, %r11d
18000263d:     	jmp	0x180002669 <.text+0x1669>
18000263f:     	nop
180002640:     	sarq	$0x3f, %r9
180002644:     	andq	%r12, %r9
180002647:     	addsd	(%r15,%r9,8), %xmm2
18000264d:     	movsd	%xmm2, (%r15,%r9,8)
180002653:     	addq	%rcx, %r11
180002656:     	decq	%rax
180002659:     	addq	%rcx, %r10
18000265c:     	addq	%rcx, %r10
18000265f:     	cmpq	$0x1, %rax
180002663:     	jbe	0x180002850 <.text+0x1850>
180002669:     	cmpb	$0x0, (%rbx)
18000266c:     	jne	0x180002850 <.text+0x1850>
180002672:     	xorps	%xmm1, %xmm1
180002675:     	cvtsi2sd	%r11, %xmm1
18000267a:     	addsd	%xmm1, %xmm1
18000267e:     	andpd	%xmm12, %xmm1
180002683:     	ucomisd	%xmm1, %xmm13
180002688:     	movq	%r10, %r15
18000268b:     	ja	0x180002693 <.text+0x1693>
18000268d:     	movb	$0x1, (%rbx)
180002690:     	xorl	%r15d, %r15d
180002693:     	testq	%rdi, %rdi
180002696:     	jle	0x1800026b0 <.text+0x16b0>
180002698:     	cmpq	0x40(%rsp), %r11
18000269d:     	jg	0x1800026b9 <.text+0x16b9>
18000269f:     	jmp	0x1800026c0 <.text+0x16c0>
1800026a1:     	nopw	%cs:(%rax,%rax)
1800026ab:     	nopl	(%rax,%rax)
1800026b0:     	je	0x1800026c0 <.text+0x16c0>
1800026b2:     	cmpq	0x50(%rsp), %r11
1800026b7:     	jge	0x1800026c0 <.text+0x16c0>
1800026b9:     	movb	$0x1, (%rbx)
1800026bc:     	xorl	%ebp, %ebp
1800026be:     	jmp	0x1800026c4 <.text+0x16c4>
1800026c0:     	leaq	(%rdi,%r11), %rbp
1800026c4:     	xorps	%xmm1, %xmm1
1800026c7:     	cvtsi2sd	%rbp, %xmm1
1800026cc:     	addsd	%xmm1, %xmm1
1800026d0:     	andpd	%xmm12, %xmm1
1800026d5:     	ucomisd	%xmm1, %xmm13
1800026da:     	jbe	0x180002700 <.text+0x1700>
1800026dc:     	leaq	(%rbp,%rbp), %r8
1800026e1:     	sarq	$0x3f, %rbp
1800026e5:     	andq	%r12, %rbp
1800026e8:     	addq	%r8, %rbp
1800026eb:     	cmpq	%r12, %rbp
1800026ee:     	leaq	(%r13,%rbp,8), %r9
1800026f3:     	jb	0x180002715 <.text+0x1715>
1800026f5:     	movb	$0x1, (%rbx)
1800026f8:     	xorpd	%xmm1, %xmm1
1800026fc:     	jmp	0x180002725 <.text+0x1725>
1800026fe:     	nop
180002700:     	movb	$0x1, (%rbx)
180002703:     	xorl	%r8d, %r8d
180002706:     	xorl	%ebp, %ebp
180002708:     	addq	%r8, %rbp
18000270b:     	cmpq	%r12, %rbp
18000270e:     	leaq	(%r13,%rbp,8), %r9
180002713:     	jae	0x1800026f5 <.text+0x16f5>
180002715:     	movq	%rbp, %rsi
180002718:     	sarq	$0x3f, %rsi
18000271c:     	andq	%r12, %rsi
18000271f:     	movsd	(%r9,%rsi,8), %xmm1
180002725:     	movq	%r8, %rsi
180002728:     	sarq	$0x3f, %rsi
18000272c:     	andq	%r12, %rsi
18000272f:     	leaq	0x1(%rsi,%r8), %rdi
180002734:     	cmpq	%r12, %rdi
180002737:     	leaq	(%r13,%rdi,8), %r14
18000273c:     	jae	0x180002750 <.text+0x1750>
18000273e:     	movq	%rdi, %r8
180002741:     	sarq	$0x3f, %r8
180002745:     	andq	%r12, %r8
180002748:     	movsd	(%r14,%r8,8), %xmm2
18000274e:     	jmp	0x180002757 <.text+0x1757>
180002750:     	movb	$0x1, (%rbx)
180002753:     	xorpd	%xmm2, %xmm2
180002757:     	movq	%r15, %rsi
18000275a:     	sarq	$0x3f, %rsi
18000275e:     	andq	%r12, %rsi
180002761:     	leaq	(%rsi,%r15), %rdx
180002765:     	cmpq	%r12, %rdx
180002768:     	leaq	(%r13,%rdx,8), %r8
18000276d:     	jae	0x1800027d0 <.text+0x17d0>
18000276f:     	movq	%rdx, %r13
180002772:     	sarq	$0x3f, %r13
180002776:     	andq	%r12, %r13
180002779:     	movsd	(%r8,%r13,8), %xmm3
18000277f:     	movq	0x190(%rsp), %r13
180002787:     	cmpq	%r12, %rbp
18000278a:     	jb	0x1800027dc <.text+0x17dc>
18000278c:     	movb	$0x1, (%rbx)
18000278f:     	leaq	0x1(%rsi,%r15), %r9
180002794:     	cmpq	%r12, %r9
180002797:     	leaq	(%r13,%r9,8), %r15
18000279c:     	jb	0x1800027fc <.text+0x17fc>
18000279e:     	movb	$0x1, (%rbx)
1800027a1:     	xorpd	%xmm3, %xmm3
1800027a5:     	cmpq	%r12, %rdi
1800027a8:     	jb	0x180002811 <.text+0x1811>
1800027aa:     	movb	$0x1, (%rbx)
1800027ad:     	movq	0x48(%rsp), %rdi
1800027b2:     	cmpq	%r12, %rdx
1800027b5:     	jb	0x18000282c <.text+0x182c>
1800027b7:     	movb	$0x1, (%rbx)
1800027ba:     	cmpq	%r12, %r9
1800027bd:     	jb	0x180002640 <.text+0x1640>
1800027c3:     	jmp	0x180002848 <.text+0x1848>
1800027c8:     	nopl	(%rax,%rax)
1800027d0:     	movb	$0x1, (%rbx)
1800027d3:     	xorpd	%xmm3, %xmm3
1800027d7:     	cmpq	%r12, %rbp
1800027da:     	jae	0x18000278c <.text+0x178c>
1800027dc:     	subsd	%xmm1, %xmm3
1800027e0:     	sarq	$0x3f, %rbp
1800027e4:     	andq	%r12, %rbp
1800027e7:     	movsd	%xmm3, (%r9,%rbp,8)
1800027ed:     	leaq	0x1(%rsi,%r15), %r9
1800027f2:     	cmpq	%r12, %r9
1800027f5:     	leaq	(%r13,%r9,8), %r15
1800027fa:     	jae	0x18000279e <.text+0x179e>
1800027fc:     	movq	%r9, %rsi
1800027ff:     	sarq	$0x3f, %rsi
180002803:     	andq	%r12, %rsi
180002806:     	movsd	(%r15,%rsi,8), %xmm3
18000280c:     	cmpq	%r12, %rdi
18000280f:     	jae	0x1800027aa <.text+0x17aa>
180002811:     	subsd	%xmm2, %xmm3
180002815:     	sarq	$0x3f, %rdi
180002819:     	andq	%r12, %rdi
18000281c:     	movsd	%xmm3, (%r14,%rdi,8)
180002822:     	movq	0x48(%rsp), %rdi
180002827:     	cmpq	%r12, %rdx
18000282a:     	jae	0x1800027b7 <.text+0x17b7>
18000282c:     	sarq	$0x3f, %rdx
180002830:     	andq	%r12, %rdx
180002833:     	addsd	(%r8,%rdx,8), %xmm1
180002839:     	movsd	%xmm1, (%r8,%rdx,8)
18000283f:     	cmpq	%r12, %r9
180002842:     	jb	0x180002640 <.text+0x1640>
180002848:     	movb	$0x1, (%rbx)
18000284b:     	jmp	0x180002653 <.text+0x1653>
180002850:     	leaq	-0x1(%rdi), %rax
180002854:     	leaq	(%rdi,%rdi), %rcx
180002858:     	movq	%rcx, 0x68(%rsp)
18000285d:     	testq	%rax, %rax
180002860:     	jle	0x180002c10 <.text+0x1c10>
180002866:     	movapd	%xmm0, %xmm1
18000286a:     	addsd	%xmm0, %xmm1
18000286e:     	mulsd	%xmm0, %xmm1
180002872:     	cmpq	$0x0, 0x30(%rsp)
180002878:     	setg	%al
18000287b:     	testq	%rdi, %rdi
18000287e:     	setg	%cl
180002881:     	xorb	%al, %cl
180002883:     	movb	%cl, 0x2f(%rsp)
180002887:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002891:     	subq	%rdi, %rax
180002894:     	movq	%rax, 0x50(%rsp)
180002899:     	incq	%rax
18000289c:     	movq	%rax, 0x78(%rsp)
1800028a1:     	movl	$0x1, %r11d
1800028a7:     	xorpd	%xmm14, %xmm14
1800028ac:     	movsd	0x4b04(%rip), %xmm2     # 0x1800073b8
1800028b4:     	jmp	0x1800028cc <.text+0x18cc>
1800028b6:     	nopw	%cs:(%rax,%rax)
1800028c0:     	incq	%r11
1800028c3:     	cmpq	%rdi, %r11
1800028c6:     	je	0x180002c10 <.text+0x1c10>
1800028cc:     	cmpb	$0x0, (%rbx)
1800028cf:     	jne	0x180002c10 <.text+0x1c10>
1800028d5:     	movapd	%xmm2, %xmm3
1800028d9:     	ucomisd	%xmm15, %xmm13
1800028de:     	movapd	%xmm6, %xmm4
1800028e2:     	mulsd	%xmm14, %xmm4
1800028e7:     	subsd	%xmm4, %xmm2
1800028eb:     	movapd	%xmm1, %xmm4
1800028ef:     	mulsd	%xmm3, %xmm4
1800028f3:     	subsd	%xmm4, %xmm2
1800028f7:     	mulsd	%xmm6, %xmm3
1800028fb:     	addsd	%xmm14, %xmm3
180002900:     	movapd	%xmm14, %xmm4
180002905:     	mulsd	%xmm1, %xmm4
180002909:     	movapd	%xmm3, %xmm14
18000290e:     	subsd	%xmm4, %xmm14
180002913:     	ja	0x180002930 <.text+0x1930>
180002915:     	cmpq	$0x0, 0x30(%rsp)
18000291b:     	movb	$0x1, (%rbx)
18000291e:     	movl	$0x1, %eax
180002923:     	movq	%rax, 0x40(%rsp)
180002928:     	jg	0x180002945 <.text+0x1945>
18000292a:     	jmp	0x1800028c0 <.text+0x18c0>
18000292c:     	nopl	(%rax)
180002930:     	cmpb	$0x0, 0x2f(%rsp)
180002935:     	movq	0x68(%rsp), %rax
18000293a:     	movq	%rax, 0x40(%rsp)
18000293f:     	jne	0x1800028c0 <.text+0x18c0>
180002945:     	movq	0x30(%rsp), %rcx
18000294a:     	movq	%rcx, %rax
18000294d:     	cqto
18000294f:     	idivq	0x40(%rsp)
180002954:     	movq	%rdx, %r9
180002957:     	negq	%r9
18000295a:     	testq	%rcx, %rcx
18000295d:     	cmovgq	%rdx, %r9
180002961:     	xorl	%r8d, %r8d
180002964:     	testq	%r9, %r9
180002967:     	setg	%r8b
18000296b:     	movq	%rax, %rdx
18000296e:     	addq	%r8, %rdx
180002971:     	jle	0x1800028c0 <.text+0x18c0>
180002977:     	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
180002981:     	subq	%r11, %rdx
180002984:     	leaq	0x1(%rax,%r8), %rax
180002989:     	xorl	%ebp, %ebp
18000298b:     	jmp	0x1800029b5 <.text+0x19b5>
18000298d:     	nopl	(%rax)
180002990:     	sarq	$0x3f, %r8
180002994:     	andq	%r12, %r8
180002997:     	addsd	(%r9,%r8,8), %xmm3
18000299d:     	movsd	%xmm3, (%r9,%r8,8)
1800029a3:     	addq	0x40(%rsp), %rbp
1800029a8:     	decq	%rax
1800029ab:     	cmpq	$0x1, %rax
1800029af:     	jbe	0x1800028c0 <.text+0x18c0>
1800029b5:     	cmpb	$0x0, (%rbx)
1800029b8:     	jne	0x1800028c0 <.text+0x18c0>
1800029be:     	cmpq	%rdx, %rbp
1800029c1:     	jle	0x1800029d0 <.text+0x19d0>
1800029c3:     	movb	$0x1, (%rbx)
1800029c6:     	xorl	%esi, %esi
1800029c8:     	jmp	0x1800029d4 <.text+0x19d4>
1800029ca:     	nopw	(%rax,%rax)
1800029d0:     	leaq	(%r11,%rbp), %rsi
1800029d4:     	xorps	%xmm3, %xmm3
1800029d7:     	cvtsi2sd	%rsi, %xmm3
1800029dc:     	addsd	%xmm3, %xmm3
1800029e0:     	andpd	%xmm12, %xmm3
1800029e5:     	addq	%rsi, %rsi
1800029e8:     	leaq	(%r11,%rbp), %r8
1800029ec:     	cmpq	%rdx, %rbp
1800029ef:     	movl	$0x0, %ecx
1800029f4:     	cmovgq	%rcx, %r8
1800029f8:     	ucomisd	%xmm3, %xmm13
1800029fd:     	cmovbeq	%rcx, %rsi
180002a01:     	jbe	0x180002a20 <.text+0x1a20>
180002a03:     	cmpq	%rdx, %rbp
180002a06:     	jg	0x180002a20 <.text+0x1a20>
180002a08:     	testq	%rdi, %rdi
180002a0b:     	jle	0x180002a28 <.text+0x1a28>
180002a0d:     	cmpq	0x50(%rsp), %r8
180002a12:     	jle	0x180002a2f <.text+0x1a2f>
180002a14:     	movb	$0x1, (%rbx)
180002a17:     	xorl	%r8d, %r8d
180002a1a:     	jmp	0x180002a32 <.text+0x1a32>
180002a1c:     	nopl	(%rax)
180002a20:     	movb	$0x1, (%rbx)
180002a23:     	testq	%rdi, %rdi
180002a26:     	jg	0x180002a0d <.text+0x1a0d>
180002a28:     	cmpq	0x78(%rsp), %r8
180002a2d:     	jl	0x180002a14 <.text+0x1a14>
180002a2f:     	addq	%rdi, %r8
180002a32:     	xorps	%xmm3, %xmm3
180002a35:     	cvtsi2sd	%r8, %xmm3
180002a3a:     	addsd	%xmm3, %xmm3
180002a3e:     	andpd	%xmm12, %xmm3
180002a43:     	ucomisd	%xmm3, %xmm13
180002a48:     	jbe	0x180002a70 <.text+0x1a70>
180002a4a:     	leaq	(%r8,%r8), %r10
180002a4e:     	sarq	$0x3f, %r8
180002a52:     	andq	%r12, %r8
180002a55:     	addq	%r10, %r8
180002a58:     	cmpq	%r12, %r8
180002a5b:     	leaq	(%r13,%r8,8), %r9
180002a60:     	jb	0x180002a86 <.text+0x1a86>
180002a62:     	movb	$0x1, (%rbx)
180002a65:     	xorpd	%xmm3, %xmm3
180002a69:     	jmp	0x180002a96 <.text+0x1a96>
180002a6b:     	nopl	(%rax,%rax)
180002a70:     	movb	$0x1, (%rbx)
180002a73:     	xorl	%r10d, %r10d
180002a76:     	xorl	%r8d, %r8d
180002a79:     	addq	%r10, %r8
180002a7c:     	cmpq	%r12, %r8
180002a7f:     	leaq	(%r13,%r8,8), %r9
180002a84:     	jae	0x180002a62 <.text+0x1a62>
180002a86:     	movq	%r8, %rdi
180002a89:     	sarq	$0x3f, %rdi
180002a8d:     	andq	%r12, %rdi
180002a90:     	movsd	(%r9,%rdi,8), %xmm3
180002a96:     	movq	%r10, %rdi
180002a99:     	sarq	$0x3f, %rdi
180002a9d:     	andq	%r12, %rdi
180002aa0:     	leaq	0x1(%rdi,%r10), %r14
180002aa5:     	cmpq	%r12, %r14
180002aa8:     	leaq	(%r13,%r14,8), %r10
180002aad:     	jae	0x180002ad0 <.text+0x1ad0>
180002aaf:     	movq	%r14, %rdi
180002ab2:     	sarq	$0x3f, %rdi
180002ab6:     	andq	%r12, %rdi
180002ab9:     	movsd	(%r10,%rdi,8), %xmm4
180002abf:     	jmp	0x180002ad7 <.text+0x1ad7>
180002ac1:     	nopw	%cs:(%rax,%rax)
180002acb:     	nopl	(%rax,%rax)
180002ad0:     	movb	$0x1, (%rbx)
180002ad3:     	xorpd	%xmm4, %xmm4
180002ad7:     	movq	%rsi, %r15
180002ada:     	sarq	$0x3f, %r15
180002ade:     	andq	%r12, %r15
180002ae1:     	leaq	(%r15,%rsi), %rcx
180002ae5:     	cmpq	%r12, %rcx
180002ae8:     	leaq	(%r13,%rcx,8), %r13
180002aed:     	jae	0x180002b10 <.text+0x1b10>
180002aef:     	movq	%rcx, %rdi
180002af2:     	sarq	$0x3f, %rdi
180002af6:     	andq	%r12, %rdi
180002af9:     	movsd	(%r13,%rdi,8), %xmm7
180002b00:     	jmp	0x180002b17 <.text+0x1b17>
180002b02:     	nopw	%cs:(%rax,%rax)
180002b0c:     	nopl	(%rax)
180002b10:     	movb	$0x1, (%rbx)
180002b13:     	xorpd	%xmm7, %xmm7
180002b17:     	movq	0x48(%rsp), %rdi
180002b1c:     	movapd	%xmm2, %xmm5
180002b20:     	mulsd	%xmm3, %xmm5
180002b24:     	movapd	%xmm14, %xmm0
180002b29:     	mulsd	%xmm4, %xmm0
180002b2d:     	subsd	%xmm0, %xmm5
180002b31:     	cmpq	%r12, %r8
180002b34:     	jae	0x180002b50 <.text+0x1b50>
180002b36:     	subsd	%xmm5, %xmm7
180002b3a:     	sarq	$0x3f, %r8
180002b3e:     	andq	%r12, %r8
180002b41:     	movsd	%xmm7, (%r9,%r8,8)
180002b47:     	jmp	0x180002b53 <.text+0x1b53>
180002b49:     	nopl	(%rax)
180002b50:     	movb	$0x1, (%rbx)
180002b53:     	leaq	0x1(%r15,%rsi), %r8
180002b58:     	cmpq	%r12, %r8
180002b5b:     	movq	0x190(%rsp), %r9
180002b63:     	leaq	(%r9,%r8,8), %r9
180002b67:     	jae	0x180002b80 <.text+0x1b80>
180002b69:     	movq	%r8, %rsi
180002b6c:     	sarq	$0x3f, %rsi
180002b70:     	andq	%r12, %rsi
180002b73:     	movsd	(%r9,%rsi,8), %xmm7
180002b79:     	jmp	0x180002b87 <.text+0x1b87>
180002b7b:     	nopl	(%rax,%rax)
180002b80:     	movb	$0x1, (%rbx)
180002b83:     	xorpd	%xmm7, %xmm7
180002b87:     	mulsd	%xmm2, %xmm4
180002b8b:     	mulsd	%xmm14, %xmm3
180002b90:     	addsd	%xmm4, %xmm3
180002b94:     	cmpq	%r12, %r14
180002b97:     	jae	0x180002bd0 <.text+0x1bd0>
180002b99:     	subsd	%xmm3, %xmm7
180002b9d:     	sarq	$0x3f, %r14
180002ba1:     	andq	%r12, %r14
180002ba4:     	movsd	%xmm7, (%r10,%r14,8)
180002baa:     	cmpq	%r12, %rcx
180002bad:     	jb	0x180002bd8 <.text+0x1bd8>
180002baf:     	movb	$0x1, (%rbx)
180002bb2:     	movq	0x190(%rsp), %r13
180002bba:     	cmpq	%r12, %r8
180002bbd:     	jb	0x180002990 <.text+0x1990>
180002bc3:     	jmp	0x180002bfe <.text+0x1bfe>
180002bc5:     	nopw	%cs:(%rax,%rax)
180002bcf:     	nop
180002bd0:     	movb	$0x1, (%rbx)
180002bd3:     	cmpq	%r12, %rcx
180002bd6:     	jae	0x180002baf <.text+0x1baf>
180002bd8:     	sarq	$0x3f, %rcx
180002bdc:     	andq	%r12, %rcx
180002bdf:     	addsd	(%r13,%rcx,8), %xmm5
180002be6:     	movsd	%xmm5, (%r13,%rcx,8)
180002bed:     	movq	0x190(%rsp), %r13
180002bf5:     	cmpq	%r12, %r8
180002bf8:     	jb	0x180002990 <.text+0x1990>
180002bfe:     	movb	$0x1, (%rbx)
180002c01:     	jmp	0x1800029a3 <.text+0x19a3>
180002c06:     	nopw	%cs:(%rax,%rax)
180002c10:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002c1a:     	movq	0x70(%rsp), %rcx
180002c1f:     	cmpq	%rax, %rcx
180002c22:     	je	0x180002efa <.text+0x1efa>
180002c28:     	ucomisd	%xmm15, %xmm13
180002c2d:     	jbe	0x180002efa <.text+0x1efa>
180002c33:     	cmpb	$0x0, (%rbx)
180002c36:     	movq	0x58(%rsp), %rax
180002c3b:     	jne	0x1800022af <.text+0x12af>
180002c41:     	incq	%rcx
180002c44:     	cmpq	%rax, %rcx
180002c47:     	movq	0x68(%rsp), %rdi
180002c4c:     	jl	0x180002540 <.text+0x1540>
180002c52:     	jmp	0x1800022af <.text+0x12af>
180002c57:     	movq	%rax, %rcx
180002c5a:     	shrq	%rcx
180002c5d:     	movq	%rax, %rdx
180002c60:     	shrq	$0x2, %rdx
180002c64:     	xorl	%r11d, %r11d
180002c67:     	movabsq	$-0x4000000000000000, %r8 # imm = 0xC000000000000000
180002c71:     	movl	%r9d, %esi
180002c74:     	xorl	%r10d, %r10d
180002c77:     	jmp	0x180002c97 <.text+0x1c97>
180002c79:     	nopl	(%rax)
180002c80:     	addq	%rdi, %r11
180002c83:     	leaq	0x1(%r10), %rdi
180002c87:     	addq	$0x2, %r10
180002c8b:     	cmpq	%r10, %rax
180002c8e:     	movq	%rdi, %r10
180002c91:     	je	0x1800024ed <.text+0x14ed>
180002c97:     	testb	%sil, %sil
180002c9a:     	jne	0x1800024ed <.text+0x14ed>
180002ca0:     	testq	%r10, %r10
180002ca3:     	je	0x180002cc0 <.text+0x1cc0>
180002ca5:     	movq	%r10, %rsi
180002ca8:     	shrq	$0x3e, %rsi
180002cac:     	je	0x180002cf0 <.text+0x1cf0>
180002cae:     	movb	$0x1, (%rbx)
180002cb1:     	movb	$0x1, %r9b
180002cb4:     	movb	$0x1, %sil
180002cb7:     	xorl	%edi, %edi
180002cb9:     	testq	%r11, %r11
180002cbc:     	jne	0x180002cc9 <.text+0x1cc9>
180002cbe:     	jmp	0x180002cfb <.text+0x1cfb>
180002cc0:     	xorl	%esi, %esi
180002cc2:     	xorl	%edi, %edi
180002cc4:     	testq	%r11, %r11
180002cc7:     	je	0x180002cfb <.text+0x1cfb>
180002cc9:     	movq	%r11, %r14
180002ccc:     	addq	%r8, %r14
180002ccf:     	js	0x180002d10 <.text+0x1d10>
180002cd1:     	movb	$0x1, (%rbx)
180002cd4:     	movb	$0x1, %r9b
180002cd7:     	movb	$0x1, %sil
180002cda:     	xorl	%r14d, %r14d
180002cdd:     	cmpq	%r11, %r10
180002ce0:     	jl	0x180002d1d <.text+0x1d1d>
180002ce2:     	jmp	0x180002e5f <.text+0x1e5f>
180002ce7:     	nopw	(%rax,%rax)
180002cf0:     	leaq	(%r10,%r10), %rdi
180002cf4:     	xorl	%esi, %esi
180002cf6:     	testq	%r11, %r11
180002cf9:     	jne	0x180002cc9 <.text+0x1cc9>
180002cfb:     	xorl	%r14d, %r14d
180002cfe:     	cmpq	%r11, %r10
180002d01:     	jl	0x180002d1d <.text+0x1d1d>
180002d03:     	jmp	0x180002e5f <.text+0x1e5f>
180002d08:     	nopl	(%rax,%rax)
180002d10:     	leaq	(%r11,%r11), %r14
180002d14:     	cmpq	%r11, %r10
180002d17:     	jge	0x180002e5f <.text+0x1e5f>
180002d1d:     	cmpq	%r12, %rdi
180002d20:     	jae	0x180002d40 <.text+0x1d40>
180002d22:     	movsd	(%r13,%rdi,8), %xmm0
180002d29:     	movq	%rdi, %r9
180002d2c:     	orq	$0x1, %r9
180002d30:     	cmpq	%r12, %r9
180002d33:     	jb	0x180002d53 <.text+0x1d53>
180002d35:     	movb	$0x1, (%rbx)
180002d38:     	xorpd	%xmm1, %xmm1
180002d3c:     	jmp	0x180002d5a <.text+0x1d5a>
180002d3e:     	nop
180002d40:     	movb	$0x1, (%rbx)
180002d43:     	xorpd	%xmm0, %xmm0
180002d47:     	movq	%rdi, %r9
180002d4a:     	orq	$0x1, %r9
180002d4e:     	cmpq	%r12, %r9
180002d51:     	jae	0x180002d35 <.text+0x1d35>
180002d53:     	movsd	(%r13,%r9,8), %xmm1
180002d5a:     	movq	%r14, %r15
180002d5d:     	sarq	$0x3f, %r15
180002d61:     	andq	%r12, %r15
180002d64:     	leaq	(%r15,%r14), %rsi
180002d68:     	cmpq	%r12, %rsi
180002d6b:     	jae	0x180002de0 <.text+0x1de0>
180002d6d:     	movq	%r13, %rbp
180002d70:     	movq	%rsi, %r13
180002d73:     	sarq	$0x3f, %r13
180002d77:     	andq	%r12, %r13
180002d7a:     	leaq	(%rbp,%rsi,8), %rbp
180002d7f:     	movsd	(%rbp,%r13,8), %xmm2
180002d86:     	cmpq	%r12, %rdi
180002d89:     	jb	0x180002dec <.text+0x1dec>
180002d8b:     	movb	$0x1, (%rbx)
180002d8e:     	movq	0x190(%rsp), %r13
180002d96:     	leaq	0x1(%r15,%r14), %rdi
180002d9b:     	cmpq	%r12, %rdi
180002d9e:     	jb	0x180002e05 <.text+0x1e05>
180002da0:     	movb	$0x1, (%rbx)
180002da3:     	xorpd	%xmm2, %xmm2
180002da7:     	cmpq	%r12, %r9
180002daa:     	jb	0x180002e1f <.text+0x1e1f>
180002dac:     	movb	$0x1, (%rbx)
180002daf:     	cmpq	%r12, %rsi
180002db2:     	jb	0x180002e2b <.text+0x1e2b>
180002db4:     	movb	$0x1, (%rbx)
180002db7:     	cmpq	%r12, %rdi
180002dba:     	jb	0x180002e46 <.text+0x1e46>
180002dc0:     	movb	$0x1, (%rbx)
180002dc3:     	movb	$0x1, %r9b
180002dc6:     	movb	$0x1, %sil
180002dc9:     	movq	%rcx, %rdi
180002dcc:     	testq	%rdi, %rdi
180002dcf:     	jne	0x180002ed0 <.text+0x1ed0>
180002dd5:     	jmp	0x180002c80 <.text+0x1c80>
180002dda:     	nopw	(%rax,%rax)
180002de0:     	movb	$0x1, (%rbx)
180002de3:     	xorpd	%xmm2, %xmm2
180002de7:     	cmpq	%r12, %rdi
180002dea:     	jae	0x180002d8b <.text+0x1d8b>
180002dec:     	movq	0x190(%rsp), %r13
180002df4:     	movsd	%xmm2, (%r13,%rdi,8)
180002dfb:     	leaq	0x1(%r15,%r14), %rdi
180002e00:     	cmpq	%r12, %rdi
180002e03:     	jae	0x180002da0 <.text+0x1da0>
180002e05:     	movq	%rdi, %r14
180002e08:     	sarq	$0x3f, %r14
180002e0c:     	andq	%r12, %r14
180002e0f:     	leaq	(%r13,%rdi,8), %r15
180002e14:     	movsd	(%r15,%r14,8), %xmm2
180002e1a:     	cmpq	%r12, %r9
180002e1d:     	jae	0x180002dac <.text+0x1dac>
180002e1f:     	movsd	%xmm2, (%r13,%r9,8)
180002e26:     	cmpq	%r12, %rsi
180002e29:     	jae	0x180002db4 <.text+0x1db4>
180002e2b:     	leaq	(%r13,%rsi,8), %r9
180002e30:     	sarq	$0x3f, %rsi
180002e34:     	andq	%r12, %rsi
180002e37:     	movsd	%xmm0, (%r9,%rsi,8)
180002e3d:     	cmpq	%r12, %rdi
180002e40:     	jae	0x180002dc0 <.text+0x1dc0>
180002e46:     	leaq	(%r13,%rdi,8), %r9
180002e4b:     	sarq	$0x3f, %rdi
180002e4f:     	andq	%r12, %rdi
180002e52:     	movsd	%xmm1, (%r9,%rdi,8)
180002e58:     	movzbl	(%rbx), %r9d
180002e5c:     	movl	%r9d, %esi
180002e5f:     	testb	%sil, %sil
180002e62:     	setne	%dil
180002e66:     	movq	%r11, %r14
180002e69:     	subq	%rcx, %r14
180002e6c:     	setl	%bpl
180002e70:     	orb	%dil, %bpl
180002e73:     	jne	0x180002eb0 <.text+0x1eb0>
180002e75:     	testb	%r9b, %r9b
180002e78:     	jne	0x180002ebd <.text+0x1ebd>
180002e7a:     	cmpq	%r14, %rdx
180002e7d:     	jg	0x180002ebd <.text+0x1ebd>
180002e7f:     	movq	%rdx, %rdi
180002e82:     	nopw	%cs:(%rax,%rax)
180002e8c:     	nopl	(%rax)
180002e90:     	subq	%rdi, %r14
180002e93:     	shrq	%rdi
180002e96:     	cmpq	%r14, %rdi
180002e99:     	jle	0x180002e90 <.text+0x1e90>
180002e9b:     	xorl	%esi, %esi
180002e9d:     	movq	%r14, %r11
180002ea0:     	testq	%rdi, %rdi
180002ea3:     	jne	0x180002ed0 <.text+0x1ed0>
180002ea5:     	jmp	0x180002c80 <.text+0x1c80>
180002eaa:     	nopw	(%rax,%rax)
180002eb0:     	movq	%rcx, %rdi
180002eb3:     	testq	%rdi, %rdi
180002eb6:     	jne	0x180002ed0 <.text+0x1ed0>
180002eb8:     	jmp	0x180002c80 <.text+0x1c80>
180002ebd:     	movl	%r9d, %esi
180002ec0:     	movq	%r14, %r11
180002ec3:     	movq	%rdx, %rdi
180002ec6:     	testq	%rdi, %rdi
180002ec9:     	je	0x180002c80 <.text+0x1c80>
180002ecf:     	nop
180002ed0:     	movq	%rdi, %r14
180002ed3:     	movabsq	$0x7fffffffffffffff, %r15 # imm = 0x7FFFFFFFFFFFFFFF
180002edd:     	xorq	%r15, %r14
180002ee0:     	cmpq	%r14, %r11
180002ee3:     	jle	0x180002c80 <.text+0x1c80>
180002ee9:     	movb	$0x1, (%rbx)
180002eec:     	movb	$0x1, %r9b
180002eef:     	movb	$0x1, %sil
180002ef2:     	xorl	%r11d, %r11d
180002ef5:     	jmp	0x180002c83 <.text+0x1c83>
180002efa:     	movb	$0x1, (%rbx)
180002efd:     	jmp	0x1800022af <.text+0x12af>
180002f02:     	nopw	%cs:(%rax,%rax)
180002f0c:     	nopl	(%rax)
180002f10:     	pushq	%r14
180002f12:     	pushq	%rsi
180002f13:     	pushq	%rdi
180002f14:     	pushq	%rbx
180002f15:     	subq	$0xe8, %rsp
180002f1c:     	movq	%rdx, %rcx
180002f1f:     	leaq	0x48(%rsp), %rax
180002f24:     	movq	%rax, 0x30(%rsp)
180002f29:     	leaq	0x50(%rsp), %rax
180002f2e:     	movq	%rax, 0x28(%rsp)
180002f33:     	leaq	0x58(%rsp), %rax
180002f38:     	movq	%rax, 0x20(%rsp)
180002f3d:     	leaq	0x498c(%rip), %rdx      # 0x1800078d0
180002f44:     	movl	$0x3, %r8d
180002f4a:     	movl	$0x3, %r9d
180002f50:     	callq	0x1800053d1 <numba_list_iter_next+0x311>
180002f55:     	testl	%eax, %eax
180002f57:     	movq	$0x0, 0x40(%rsp)
180002f60:     	je	0x18000317a <.text+0x217a>
180002f66:     	cmpq	$0x0, 0xbe82(%rip)      # 0x18000edf0
180002f6e:     	je	0x180003108 <.text+0x2108>
180002f74:     	movq	0x58(%rsp), %rcx
180002f79:     	xorps	%xmm0, %xmm0
180002f7c:     	movaps	%xmm0, 0xa0(%rsp)
180002f84:     	movaps	%xmm0, 0xb0(%rsp)
180002f8c:     	movaps	%xmm0, 0xc0(%rsp)
180002f94:     	movq	$0x0, 0xd0(%rsp)
180002fa0:     	leaq	0xa0(%rsp), %rdx
180002fa8:     	callq	0x180004090 <PyInit_rcaot_05cb37762ef1645705ed4668+0xdc0>
180002fad:     	testl	%eax, %eax
180002faf:     	jne	0x18000311d <.text+0x211d>
180002fb5:     	cmpq	$0x1, 0xb8(%rsp)
180002fbe:     	jne	0x18000311d <.text+0x211d>
180002fc4:     	movq	0xa0(%rsp), %rsi
180002fcc:     	movq	0xc0(%rsp), %rdi
180002fd4:     	movq	0x50(%rsp), %rcx
180002fd9:     	callq	0x1800053d7 <numba_list_iter_next+0x317>
180002fde:     	testq	%rax, %rax
180002fe1:     	je	0x180003132 <.text+0x2132>
180002fe7:     	movq	%rax, %r14
180002fea:     	movq	%rax, %rcx
180002fed:     	callq	0x1800053dd <numba_list_iter_next+0x31d>
180002ff2:     	movq	%rax, %rbx
180002ff5:     	movq	%r14, %rcx
180002ff8:     	callq	0x1800053e3 <numba_list_iter_next+0x323>
180002ffd:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
180003002:     	testq	%rax, %rax
180003005:     	jne	0x180003157 <.text+0x2157>
18000300b:     	movq	0x48(%rsp), %rcx
180003010:     	xorps	%xmm0, %xmm0
180003013:     	movaps	%xmm0, 0x60(%rsp)
180003018:     	movaps	%xmm0, 0x70(%rsp)
18000301d:     	movaps	%xmm0, 0x80(%rsp)
180003025:     	movq	$0x0, 0x90(%rsp)
180003031:     	leaq	0x60(%rsp), %rdx
180003036:     	callq	0x180004090 <PyInit_rcaot_05cb37762ef1645705ed4668+0xdc0>
18000303b:     	testl	%eax, %eax
18000303d:     	jne	0x180003144 <.text+0x2144>
180003043:     	cmpq	$0x8, 0x78(%rsp)
180003049:     	jne	0x180003144 <.text+0x2144>
18000304f:     	movq	0x60(%rsp), %r14
180003054:     	movq	0x80(%rsp), %rax
18000305c:     	movq	0x88(%rsp), %rcx
180003064:     	movq	%rcx, 0x28(%rsp)
180003069:     	movq	%rax, 0x20(%rsp)
18000306e:     	leaq	0xe0(%rsp), %rcx
180003076:     	leaq	0x40(%rsp), %rdx
18000307b:     	movq	%rdi, %r8
18000307e:     	movq	%rbx, %r9
180003081:     	callq	0x180002190 <.text+0x1190>
180003086:     	movl	%eax, %ebx
180003088:     	movq	0x40(%rsp), %rdi
18000308d:     	movq	%rsi, %rcx
180003090:     	callq	0x180001060 <.text+0x60>
180003095:     	movq	%r14, %rcx
180003098:     	callq	0x180001060 <.text+0x60>
18000309d:     	testl	%ebx, %ebx
18000309f:     	jne	0x1800030c0 <.text+0x20c0>
1800030a1:     	movq	0x4228(%rip), %rsi      # 0x1800072d0
1800030a8:     	movq	%rsi, %rcx
1800030ab:     	callq	0x1800053ef <numba_list_iter_next+0x32f>
1800030b0:     	movq	%rsi, %rax
1800030b3:     	addq	$0xe8, %rsp
1800030ba:     	popq	%rbx
1800030bb:     	popq	%rdi
1800030bc:     	popq	%rsi
1800030bd:     	popq	%r14
1800030bf:     	retq
1800030c0:     	callq	0x1800053f5 <numba_list_iter_next+0x335>
1800030c5:     	movl	0x8(%rdi), %edx
1800030c8:     	movq	(%rdi), %rcx
1800030cb:     	cmpl	$0x0, 0x20(%rdi)
1800030cf:     	jle	0x180003161 <.text+0x2161>
1800030d5:     	movslq	%edx, %rdx
1800030d8:     	callq	0x1800053fb <numba_list_iter_next+0x33b>
1800030dd:     	movq	%rax, %rsi
1800030e0:     	movq	0x10(%rdi), %rcx
1800030e4:     	callq	*0x18(%rdi)
1800030e7:     	testq	%rax, %rax
1800030ea:     	je	0x180003181 <.text+0x2181>
1800030f0:     	movq	%rsi, %rcx
1800030f3:     	movq	%rax, %rdx
1800030f6:     	callq	0x1800038a0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x5d0>
1800030fb:     	movq	%rax, %rsi
1800030fe:     	movq	%rdi, %rcx
180003101:     	callq	0x180005330 <numba_list_iter_next+0x270>
180003106:     	jmp	0x18000316d <.text+0x216d>
180003108:     	movq	0x41a1(%rip), %rcx      # 0x1800072b0
18000310f:     	leaq	0x47da(%rip), %rdx      # 0x1800078f0
180003116:     	callq	0x180005401 <numba_list_iter_next+0x341>
18000311b:     	jmp	0x18000317a <.text+0x217a>
18000311d:     	movq	0x417c(%rip), %rcx      # 0x1800072a0
180003124:     	leaq	0x4895(%rip), %rdx      # 0x1800079c0
18000312b:     	callq	0x180005401 <numba_list_iter_next+0x341>
180003130:     	jmp	0x18000317a <.text+0x217a>
180003132:     	xorl	%ebx, %ebx
180003134:     	callq	0x1800053e9 <numba_list_iter_next+0x329>
180003139:     	testq	%rax, %rax
18000313c:     	je	0x18000300b <.text+0x200b>
180003142:     	jmp	0x180003157 <.text+0x2157>
180003144:     	movq	0x4155(%rip), %rcx      # 0x1800072a0
18000314b:     	leaq	0x486e(%rip), %rdx      # 0x1800079c0
180003152:     	callq	0x180005401 <numba_list_iter_next+0x341>
180003157:     	movq	%rsi, %rcx
18000315a:     	callq	0x180001060 <.text+0x60>
18000315f:     	jmp	0x18000317a <.text+0x217a>
180003161:     	movq	0x10(%rdi), %r8
180003165:     	callq	0x1800037c0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4f0>
18000316a:     	movq	%rax, %rsi
18000316d:     	testq	%rsi, %rsi
180003170:     	je	0x18000317a <.text+0x217a>
180003172:     	movq	%rsi, %rcx
180003175:     	callq	0x180003360 <PyInit_rcaot_05cb37762ef1645705ed4668+0x90>
18000317a:     	xorl	%esi, %esi
18000317c:     	jmp	0x1800030b0 <.text+0x20b0>
180003181:     	movq	0x4128(%rip), %rcx      # 0x1800072b0
180003188:     	leaq	0x4891(%rip), %rdx      # 0x180007a20
18000318f:     	callq	0x180005401 <numba_list_iter_next+0x341>
180003194:     	jmp	0x18000317a <.text+0x217a>
180003196:     	nopw	%cs:(%rax,%rax)
1800031a0:     	pushq	%rsi
1800031a1:     	pushq	%rdi
1800031a2:     	pushq	%rbx
1800031a3:     	subq	$0x50, %rsp
1800031a7:     	movq	0x90(%rsp), %r8
1800031af:     	movq	0xa8(%rsp), %r9
1800031b7:     	movq	0xd0(%rsp), %rax
1800031bf:     	movq	0xd8(%rsp), %rcx
1800031c7:     	movq	$0x0, 0x48(%rsp)
1800031d0:     	movq	$0x0, 0x40(%rsp)
1800031d9:     	movq	%rcx, 0x28(%rsp)
1800031de:     	movq	%rax, 0x20(%rsp)
1800031e3:     	leaq	0x48(%rsp), %rcx
1800031e8:     	leaq	0x40(%rsp), %rdx
1800031ed:     	callq	0x180002190 <.text+0x1190>
1800031f2:     	movl	%eax, %ecx
1800031f4:     	movq	0x40(%rsp), %rsi
1800031f9:     	movq	0x48(%rsp), %rax
1800031fe:     	movl	$0x0, 0x3c(%rsp)
180003206:     	testl	%ecx, %ecx
180003208:     	jne	0x180003212 <.text+0x2212>
18000320a:     	addq	$0x50, %rsp
18000320e:     	popq	%rbx
18000320f:     	popq	%rdi
180003210:     	popq	%rsi
180003211:     	retq
180003212:     	movq	%rax, %rbx
180003215:     	leaq	0x3c(%rsp), %rcx
18000321a:     	callq	0x180003330 <PyInit_rcaot_05cb37762ef1645705ed4668+0x60>
18000321f:     	callq	0x1800053f5 <numba_list_iter_next+0x335>
180003224:     	movl	0x8(%rsi), %edx
180003227:     	movq	(%rsi), %rcx
18000322a:     	cmpl	$0x0, 0x20(%rsi)
18000322e:     	jle	0x18000325f <.text+0x225f>
180003230:     	movslq	%edx, %rdx
180003233:     	callq	0x1800053fb <numba_list_iter_next+0x33b>
180003238:     	movq	%rax, %rdi
18000323b:     	movq	0x10(%rsi), %rcx
18000323f:     	callq	*0x18(%rsi)
180003242:     	testq	%rax, %rax
180003245:     	je	0x1800032a9 <.text+0x22a9>
180003247:     	movq	%rdi, %rcx
18000324a:     	movq	%rax, %rdx
18000324d:     	callq	0x1800038a0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x5d0>
180003252:     	movq	%rax, %rdi
180003255:     	movq	%rsi, %rcx
180003258:     	callq	0x180005330 <numba_list_iter_next+0x270>
18000325d:     	jmp	0x18000326b <.text+0x226b>
18000325f:     	movq	0x10(%rsi), %r8
180003263:     	callq	0x1800037c0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4f0>
180003268:     	movq	%rax, %rdi
18000326b:     	testq	%rdi, %rdi
18000326e:     	je	0x180003278 <.text+0x2278>
180003270:     	movq	%rdi, %rcx
180003273:     	callq	0x180003360 <PyInit_rcaot_05cb37762ef1645705ed4668+0x90>
180003278:     	leaq	0x4821(%rip), %rcx      # 0x180007aa0
18000327f:     	callq	0x180005407 <numba_list_iter_next+0x347>
180003284:     	movq	%rax, %rsi
180003287:     	movq	%rax, %rcx
18000328a:     	callq	0x18000540d <numba_list_iter_next+0x34d>
18000328f:     	movq	%rsi, %rcx
180003292:     	callq	0x1800053e3 <numba_list_iter_next+0x323>
180003297:     	leaq	0x3c(%rsp), %rcx
18000329c:     	callq	0x180003350 <PyInit_rcaot_05cb37762ef1645705ed4668+0x80>
1800032a1:     	movq	%rbx, %rax
1800032a4:     	jmp	0x18000320a <.text+0x220a>
1800032a9:     	movq	0x4000(%rip), %rcx      # 0x1800072b0
1800032b0:     	leaq	0x47a9(%rip), %rdx      # 0x180007a60
1800032b7:     	callq	0x180005401 <numba_list_iter_next+0x341>
1800032bc:     	xorl	%eax, %eax
1800032be:     	jmp	0x18000320a <.text+0x220a>
1800032c3:     	nopw	%cs:(%rax,%rax)
1800032cd:     	nopl	(%rax)

00000001800032d0 <PyInit_rcaot_05cb37762ef1645705ed4668>:
1800032d0:     	pushq	%rsi
1800032d1:     	subq	$0x20, %rsp
1800032d5:     	leaq	0xad84(%rip), %rcx      # 0x18000e060
1800032dc:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800032e1:     	callq	0x180005413 <numba_list_iter_next+0x353>
1800032e6:     	testq	%rax, %rax
1800032e9:     	je	0x18000331b <PyInit_rcaot_05cb37762ef1645705ed4668+0x4b>
1800032eb:     	leaq	0xad0e(%rip), %rdx      # 0x18000e000
1800032f2:     	leaq	0x4817(%rip), %r8       # 0x180007b10
1800032f9:     	leaq	0x4ed0(%rip), %r9       # 0x1800081d0
180003300:     	movq	%rax, %rcx
180003303:     	movq	%rax, %rsi
180003306:     	callq	0x180004300 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1030>
18000330b:     	movl	%eax, %ecx
18000330d:     	xorl	%eax, %eax
18000330f:     	testl	%ecx, %ecx
180003311:     	cmoveq	%rsi, %rax
180003315:     	addq	$0x20, %rsp
180003319:     	popq	%rsi
18000331a:     	retq
18000331b:     	xorl	%eax, %eax
18000331d:     	addq	$0x20, %rsp
180003321:     	popq	%rsi
180003322:     	retq
180003323:     	int3
180003324:     	int3
180003325:     	int3
180003326:     	int3
180003327:     	int3
180003328:     	int3
180003329:     	int3
18000332a:     	int3
18000332b:     	int3
18000332c:     	int3
18000332d:     	int3
18000332e:     	int3
18000332f:     	int3
180003330:     	pushq	%rbx
180003332:     	subq	$0x20, %rsp
180003336:     	movq	%rcx, %rbx
180003339:     	callq	*0x3df9(%rip)           # 0x180007138
18000333f:     	movl	%eax, (%rbx)
180003341:     	addq	$0x20, %rsp
180003345:     	popq	%rbx
180003346:     	retq
180003347:     	int3
180003348:     	int3
180003349:     	int3
18000334a:     	int3
18000334b:     	int3
18000334c:     	int3
18000334d:     	int3
18000334e:     	int3
18000334f:     	int3
180003350:     	movl	(%rcx), %ecx
180003352:     	jmpq	*0x3ecf(%rip)           # 0x180007228
180003359:     	int3
18000335a:     	int3
18000335b:     	int3
18000335c:     	int3
18000335d:     	int3
18000335e:     	int3
18000335f:     	int3
180003360:     	pushq	%rbp
180003362:     	pushq	%rbx
180003363:     	pushq	%rsi
180003364:     	pushq	%rdi
180003365:     	pushq	%r14
180003367:     	pushq	%r15
180003369:     	movq	%rsp, %rbp
18000336c:     	subq	$0x48, %rsp
180003370:     	movq	0x3e81(%rip), %rax      # 0x1800071f8
180003377:     	xorl	%r15d, %r15d
18000337a:     	movq	%rcx, %rsi
18000337d:     	movq	%r15, 0x38(%rbp)
180003381:     	movl	%r15d, %r14d
180003384:     	movq	%r15, 0x50(%rbp)
180003388:     	movq	%r15, 0x48(%rbp)
18000338c:     	cmpq	%rax, 0x8(%rcx)
180003390:     	jne	0x1800034fe <PyInit_rcaot_05cb37762ef1645705ed4668+0x22e>
180003396:     	leaq	0x48(%rbp), %rax
18000339a:     	leaq	0x50(%rbp), %r9
18000339e:     	movq	%rax, 0x20(%rsp)
1800033a3:     	leaq	0x38(%rbp), %r8
1800033a7:     	leaq	0x52e6(%rip), %rdx      # 0x180008694
1800033ae:     	callq	*0x3d74(%rip)           # 0x180007128
1800033b4:     	testl	%eax, %eax
1800033b6:     	jne	0x1800034f4 <PyInit_rcaot_05cb37762ef1645705ed4668+0x224>
1800033bc:     	movq	0x48(%rbp), %rbx
1800033c0:     	testq	%rbx, %rbx
1800033c3:     	je	0x1800034e5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x215>
1800033c9:     	cmpq	0x3f00(%rip), %rbx      # 0x1800072d0
1800033d0:     	je	0x1800034e5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x215>
1800033d6:     	movq	0x8(%rbx), %rax
1800033da:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
1800033e4:     	je	0x1800034e5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x215>
1800033ea:     	movq	0x20(%rbx), %rcx
1800033ee:     	callq	*0x3da4(%rip)           # 0x180007198
1800033f4:     	movq	0x28(%rbx), %rcx
1800033f8:     	movq	%rax, %rdi
1800033fb:     	callq	*0x3d97(%rip)           # 0x180007198
180003401:     	movq	0x30(%rbx), %rcx
180003405:     	movq	%rax, %r14
180003408:     	callq	*0x3d9a(%rip)           # 0x1800071a8
18000340e:     	leaq	-0x10(%rbp), %r8
180003412:     	movl	%eax, %ebx
180003414:     	leaq	-0x18(%rbp), %rdx
180003418:     	leaq	0x40(%rbp), %rcx
18000341c:     	callq	*0x3d96(%rip)           # 0x1800071b8
180003422:     	callq	*0x3d50(%rip)           # 0x180007178
180003428:     	movq	%rax, %rsi
18000342b:     	testq	%rax, %rax
18000342e:     	je	0x1800034db <PyInit_rcaot_05cb37762ef1645705ed4668+0x20b>
180003434:     	movl	%ebx, %r8d
180003437:     	movq	%rdi, %rdx
18000343a:     	movq	%r14, %rcx
18000343d:     	callq	*0x3e2d(%rip)           # 0x180007270
180003443:     	movq	%rax, %rdi
180003446:     	testq	%rax, %rax
180003449:     	je	0x1800034db <PyInit_rcaot_05cb37762ef1645705ed4668+0x20b>
18000344f:     	callq	*0x3e2b(%rip)           # 0x180007280
180003455:     	xorl	%r9d, %r9d
180003458:     	movq	%rsi, %r8
18000345b:     	movq	%rax, %rcx
18000345e:     	movq	%rdi, %rdx
180003461:     	callq	*0x3df1(%rip)           # 0x180007258
180003467:     	movl	(%rsi), %ecx
180003469:     	movq	%rax, %rbx
18000346c:     	testl	%ecx, %ecx
18000346e:     	js	0x180003480 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1b0>
180003470:     	subl	$0x1, %ecx
180003473:     	movl	%ecx, (%rsi)
180003475:     	jne	0x180003480 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1b0>
180003477:     	movq	%rsi, %rcx
18000347a:     	callq	*0x3d60(%rip)           # 0x1800071e0
180003480:     	movl	(%rdi), %eax
180003482:     	testl	%eax, %eax
180003484:     	js	0x180003496 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1c6>
180003486:     	subl	$0x1, %eax
180003489:     	movl	%eax, (%rdi)
18000348b:     	jne	0x180003496 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1c6>
18000348d:     	movq	%rdi, %rcx
180003490:     	callq	*0x3d4a(%rip)           # 0x1800071e0
180003496:     	testq	%rbx, %rbx
180003499:     	je	0x1800034db <PyInit_rcaot_05cb37762ef1645705ed4668+0x20b>
18000349b:     	movq	-0x10(%rbp), %r8
18000349f:     	movq	-0x18(%rbp), %rdx
1800034a3:     	movq	0x40(%rbp), %rcx
1800034a7:     	callq	*0x3d3b(%rip)           # 0x1800071e8
1800034ad:     	movq	%rbx, %rcx
1800034b0:     	callq	*0x3d8a(%rip)           # 0x180007240
1800034b6:     	movl	(%rbx), %eax
1800034b8:     	testl	%eax, %eax
1800034ba:     	js	0x1800034e5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x215>
1800034bc:     	subl	$0x1, %eax
1800034bf:     	movl	%eax, (%rbx)
1800034c1:     	jne	0x1800034e5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x215>
1800034c3:     	movq	%rbx, %rcx
1800034c6:     	callq	*0x3d14(%rip)           # 0x1800071e0
1800034cc:     	xorl	%eax, %eax
1800034ce:     	addq	$0x48, %rsp
1800034d2:     	popq	%r15
1800034d4:     	popq	%r14
1800034d6:     	popq	%rdi
1800034d7:     	popq	%rsi
1800034d8:     	popq	%rbx
1800034d9:     	popq	%rbp
1800034da:     	retq
1800034db:     	movq	0x40(%rbp), %rcx
1800034df:     	callq	*0x3d33(%rip)           # 0x180007218
1800034e5:     	xorl	%eax, %eax
1800034e7:     	addq	$0x48, %rsp
1800034eb:     	popq	%r15
1800034ed:     	popq	%r14
1800034ef:     	popq	%rdi
1800034f0:     	popq	%rsi
1800034f1:     	popq	%rbx
1800034f2:     	popq	%rbp
1800034f3:     	retq
1800034f4:     	movq	0x38(%rbp), %rbx
1800034f8:     	movq	0x50(%rbp), %r14
1800034fc:     	jmp	0x180003505 <PyInit_rcaot_05cb37762ef1645705ed4668+0x235>
1800034fe:     	movq	%rsi, %rbx
180003501:     	movq	%rbx, 0x38(%rbp)
180003505:     	cmpq	0x3dc4(%rip), %rbx      # 0x1800072d0
18000350c:     	jne	0x1800035a4 <PyInit_rcaot_05cb37762ef1645705ed4668+0x2d4>
180003512:     	leaq	-0x18(%rbp), %r8
180003516:     	leaq	-0x10(%rbp), %rdx
18000351a:     	leaq	0x40(%rbp), %rcx
18000351e:     	callq	*0x3bf4(%rip)           # 0x180007118
180003524:     	movq	0x3da5(%rip), %rax      # 0x1800072d0
18000352b:     	cmpq	%rax, 0x40(%rbp)
18000352f:     	jne	0x180003544 <PyInit_rcaot_05cb37762ef1645705ed4668+0x274>
180003531:     	movq	0x3d78(%rip), %rcx      # 0x1800072b0
180003538:     	leaq	0x5109(%rip), %rdx      # 0x180008648
18000353f:     	jmp	0x180003665 <PyInit_rcaot_05cb37762ef1645705ed4668+0x395>
180003544:     	movq	0x40(%rbp), %rcx
180003548:     	testq	%rcx, %rcx
18000354b:     	je	0x18000355a <PyInit_rcaot_05cb37762ef1645705ed4668+0x28a>
18000354d:     	movl	(%rcx), %eax
18000354f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180003554:     	jae	0x18000355a <PyInit_rcaot_05cb37762ef1645705ed4668+0x28a>
180003556:     	incl	%eax
180003558:     	movl	%eax, (%rcx)
18000355a:     	movq	-0x10(%rbp), %rcx
18000355e:     	testq	%rcx, %rcx
180003561:     	je	0x180003570 <PyInit_rcaot_05cb37762ef1645705ed4668+0x2a0>
180003563:     	movl	(%rcx), %eax
180003565:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000356a:     	jae	0x180003570 <PyInit_rcaot_05cb37762ef1645705ed4668+0x2a0>
18000356c:     	incl	%eax
18000356e:     	movl	%eax, (%rcx)
180003570:     	movq	-0x18(%rbp), %r8
180003574:     	testq	%r8, %r8
180003577:     	je	0x18000358c <PyInit_rcaot_05cb37762ef1645705ed4668+0x2bc>
180003579:     	movl	(%r8), %eax
18000357c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180003581:     	jae	0x18000358c <PyInit_rcaot_05cb37762ef1645705ed4668+0x2bc>
180003583:     	incl	%eax
180003585:     	movl	%eax, (%r8)
180003588:     	movq	-0x18(%rbp), %r8
18000358c:     	movq	-0x10(%rbp), %rdx
180003590:     	movq	0x40(%rbp), %rcx
180003594:     	callq	*0x3c4e(%rip)           # 0x1800071e8
18000359a:     	movl	$0x1, %ebx
18000359f:     	jmp	0x180003671 <PyInit_rcaot_05cb37762ef1645705ed4668+0x3a1>
1800035a4:     	movq	0x8(%rbx), %rcx
1800035a8:     	movl	0xa8(%rcx), %eax
1800035ae:     	testl	%eax, %eax
1800035b0:     	jns	0x180003646 <PyInit_rcaot_05cb37762ef1645705ed4668+0x376>
1800035b6:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
1800035c0:     	je	0x180003646 <PyInit_rcaot_05cb37762ef1645705ed4668+0x376>
1800035c6:     	movq	%r14, %rdx
1800035c9:     	movq	%rbx, %rcx
1800035cc:     	callq	*0x3b6e(%rip)           # 0x180007140
1800035d2:     	movq	%rax, %rdi
1800035d5:     	testq	%rax, %rax
1800035d8:     	je	0x18000366e <PyInit_rcaot_05cb37762ef1645705ed4668+0x39e>
1800035de:     	movq	0x8(%rax), %rax
1800035e2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
1800035ec:     	jne	0x18000361d <PyInit_rcaot_05cb37762ef1645705ed4668+0x34d>
1800035ee:     	movq	0x3cab(%rip), %rcx      # 0x1800072a0
1800035f5:     	leaq	0x506c(%rip), %rdx      # 0x180008668
1800035fc:     	movq	(%rcx), %rcx
1800035ff:     	callq	*0x3ca3(%rip)           # 0x1800072a8
180003605:     	movl	(%rdi), %eax
180003607:     	testl	%eax, %eax
180003609:     	js	0x18000366e <PyInit_rcaot_05cb37762ef1645705ed4668+0x39e>
18000360b:     	subl	$0x1, %eax
18000360e:     	movl	%eax, (%rdi)
180003610:     	jne	0x18000366e <PyInit_rcaot_05cb37762ef1645705ed4668+0x39e>
180003612:     	movq	%rdi, %rcx
180003615:     	callq	*0x3bc5(%rip)           # 0x1800071e0
18000361b:     	jmp	0x18000366e <PyInit_rcaot_05cb37762ef1645705ed4668+0x39e>
18000361d:     	movl	(%rdi), %eax
18000361f:     	testl	%eax, %eax
180003621:     	js	0x180003633 <PyInit_rcaot_05cb37762ef1645705ed4668+0x363>
180003623:     	subl	$0x1, %eax
180003626:     	movl	%eax, (%rdi)
180003628:     	jne	0x180003633 <PyInit_rcaot_05cb37762ef1645705ed4668+0x363>
18000362a:     	movq	%rdi, %rcx
18000362d:     	callq	*0x3bad(%rip)           # 0x1800071e0
180003633:     	movq	%r14, %rdx
180003636:     	movq	%rbx, %rcx
180003639:     	callq	*0x3c39(%rip)           # 0x180007278
18000363f:     	movl	$0x1, %ebx
180003644:     	jmp	0x180003671 <PyInit_rcaot_05cb37762ef1645705ed4668+0x3a1>
180003646:     	btl	$0x1e, %eax
18000364a:     	jae	0x180003657 <PyInit_rcaot_05cb37762ef1645705ed4668+0x387>
18000364c:     	movq	%rbx, %rdx
18000364f:     	callq	*0x3c23(%rip)           # 0x180007278
180003655:     	jmp	0x18000366e <PyInit_rcaot_05cb37762ef1645705ed4668+0x39e>
180003657:     	movq	0x3c42(%rip), %rcx      # 0x1800072a0
18000365e:     	leaq	0x5003(%rip), %rdx      # 0x180008668
180003665:     	movq	(%rcx), %rcx
180003668:     	callq	*0x3c3a(%rip)           # 0x1800072a8
18000366e:     	movl	%r15d, %ebx
180003671:     	movq	0x48(%rbp), %rdi
180003675:     	testq	%rdi, %rdi
180003678:     	je	0x18000379b <PyInit_rcaot_05cb37762ef1645705ed4668+0x4cb>
18000367e:     	cmpq	0x3c4b(%rip), %rdi      # 0x1800072d0
180003685:     	je	0x18000379b <PyInit_rcaot_05cb37762ef1645705ed4668+0x4cb>
18000368b:     	movq	0x8(%rdi), %rax
18000368f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180003699:     	je	0x18000379b <PyInit_rcaot_05cb37762ef1645705ed4668+0x4cb>
18000369f:     	movq	0x20(%rdi), %rcx
1800036a3:     	movq	%r12, 0x40(%rsp)
1800036a8:     	callq	*0x3aea(%rip)           # 0x180007198
1800036ae:     	movq	0x28(%rdi), %rcx
1800036b2:     	movq	%rax, %r14
1800036b5:     	callq	*0x3add(%rip)           # 0x180007198
1800036bb:     	movq	0x30(%rdi), %rcx
1800036bf:     	movq	%rax, %r12
1800036c2:     	callq	*0x3ae0(%rip)           # 0x1800071a8
1800036c8:     	leaq	-0x10(%rbp), %r8
1800036cc:     	movl	%eax, %edi
1800036ce:     	leaq	-0x18(%rbp), %rdx
1800036d2:     	leaq	0x40(%rbp), %rcx
1800036d6:     	callq	*0x3adc(%rip)           # 0x1800071b8
1800036dc:     	callq	*0x3a96(%rip)           # 0x180007178
1800036e2:     	movq	%rax, %r15
1800036e5:     	testq	%rax, %rax
1800036e8:     	je	0x18000378c <PyInit_rcaot_05cb37762ef1645705ed4668+0x4bc>
1800036ee:     	movl	%edi, %r8d
1800036f1:     	movq	%r14, %rdx
1800036f4:     	movq	%r12, %rcx
1800036f7:     	callq	*0x3b73(%rip)           # 0x180007270
1800036fd:     	movq	%rax, %r14
180003700:     	testq	%rax, %rax
180003703:     	je	0x18000378c <PyInit_rcaot_05cb37762ef1645705ed4668+0x4bc>
180003709:     	callq	*0x3b71(%rip)           # 0x180007280
18000370f:     	xorl	%r9d, %r9d
180003712:     	movq	%r15, %r8
180003715:     	movq	%rax, %rcx
180003718:     	movq	%r14, %rdx
18000371b:     	callq	*0x3b37(%rip)           # 0x180007258
180003721:     	movl	(%r15), %ecx
180003724:     	movq	%rax, %rdi
180003727:     	testl	%ecx, %ecx
180003729:     	js	0x18000373c <PyInit_rcaot_05cb37762ef1645705ed4668+0x46c>
18000372b:     	subl	$0x1, %ecx
18000372e:     	movl	%ecx, (%r15)
180003731:     	jne	0x18000373c <PyInit_rcaot_05cb37762ef1645705ed4668+0x46c>
180003733:     	movq	%r15, %rcx
180003736:     	callq	*0x3aa4(%rip)           # 0x1800071e0
18000373c:     	movl	(%r14), %eax
18000373f:     	testl	%eax, %eax
180003741:     	js	0x180003754 <PyInit_rcaot_05cb37762ef1645705ed4668+0x484>
180003743:     	subl	$0x1, %eax
180003746:     	movl	%eax, (%r14)
180003749:     	jne	0x180003754 <PyInit_rcaot_05cb37762ef1645705ed4668+0x484>
18000374b:     	movq	%r14, %rcx
18000374e:     	callq	*0x3a8c(%rip)           # 0x1800071e0
180003754:     	testq	%rdi, %rdi
180003757:     	je	0x18000378c <PyInit_rcaot_05cb37762ef1645705ed4668+0x4bc>
180003759:     	movq	-0x10(%rbp), %r8
18000375d:     	movq	-0x18(%rbp), %rdx
180003761:     	movq	0x40(%rbp), %rcx
180003765:     	callq	*0x3a7d(%rip)           # 0x1800071e8
18000376b:     	movq	%rdi, %rcx
18000376e:     	callq	*0x3acc(%rip)           # 0x180007240
180003774:     	movl	(%rdi), %eax
180003776:     	testl	%eax, %eax
180003778:     	js	0x180003796 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4c6>
18000377a:     	subl	$0x1, %eax
18000377d:     	movl	%eax, (%rdi)
18000377f:     	jne	0x180003796 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4c6>
180003781:     	movq	%rdi, %rcx
180003784:     	callq	*0x3a56(%rip)           # 0x1800071e0
18000378a:     	jmp	0x180003796 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4c6>
18000378c:     	movq	0x40(%rbp), %rcx
180003790:     	callq	*0x3a82(%rip)           # 0x180007218
180003796:     	movq	0x40(%rsp), %r12
18000379b:     	movl	(%rsi), %ecx
18000379d:     	testl	%ecx, %ecx
18000379f:     	js	0x1800037b1 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4e1>
1800037a1:     	subl	$0x1, %ecx
1800037a4:     	movl	%ecx, (%rsi)
1800037a6:     	jne	0x1800037b1 <PyInit_rcaot_05cb37762ef1645705ed4668+0x4e1>
1800037a8:     	movq	%rsi, %rcx
1800037ab:     	callq	*0x3a2f(%rip)           # 0x1800071e0
1800037b1:     	movl	%ebx, %eax
1800037b3:     	addq	$0x48, %rsp
1800037b7:     	popq	%r15
1800037b9:     	popq	%r14
1800037bb:     	popq	%rdi
1800037bc:     	popq	%rsi
1800037bd:     	popq	%rbx
1800037be:     	popq	%rbp
1800037bf:     	retq
1800037c0:     	movq	%rbx, 0x8(%rsp)
1800037c5:     	movq	%rsi, 0x10(%rsp)
1800037ca:     	pushq	%rdi
1800037cb:     	subq	$0x20, %rsp
1800037cf:     	cmpq	$0x0, 0xb4c1(%rip)      # 0x18000ec98
1800037d7:     	movq	%rcx, %rsi
1800037da:     	movslq	%edx, %rdi
1800037dd:     	jne	0x18000382d <PyInit_rcaot_05cb37762ef1645705ed4668+0x55d>
1800037df:     	leaq	0x4eb2(%rip), %rcx      # 0x180008698
1800037e6:     	callq	*0x3a64(%rip)           # 0x180007250
1800037ec:     	movq	%rax, %rbx
1800037ef:     	testq	%rax, %rax
1800037f2:     	je	0x180003841 <PyInit_rcaot_05cb37762ef1645705ed4668+0x571>
1800037f4:     	leaq	0x4ea5(%rip), %rdx      # 0x1800086a0
1800037fb:     	movq	%rax, %rcx
1800037fe:     	callq	*0x397c(%rip)           # 0x180007180
180003804:     	movl	(%rbx), %ecx
180003806:     	movq	%rax, 0xb48b(%rip)      # 0x18000ec98
18000380d:     	testl	%ecx, %ecx
18000380f:     	js	0x180003828 <PyInit_rcaot_05cb37762ef1645705ed4668+0x558>
180003811:     	subl	$0x1, %ecx
180003814:     	movl	%ecx, (%rbx)
180003816:     	jne	0x180003828 <PyInit_rcaot_05cb37762ef1645705ed4668+0x558>
180003818:     	movq	%rbx, %rcx
18000381b:     	callq	*0x39bf(%rip)           # 0x1800071e0
180003821:     	movq	0xb470(%rip), %rax      # 0x18000ec98
180003828:     	testq	%rax, %rax
18000382b:     	je	0x180003841 <PyInit_rcaot_05cb37762ef1645705ed4668+0x571>
18000382d:     	movq	%rdi, %rdx
180003830:     	movq	%rsi, %rcx
180003833:     	callq	*0x3a7f(%rip)           # 0x1800072b8
180003839:     	movq	%rax, %rbx
18000383c:     	testq	%rax, %rax
18000383f:     	jne	0x180003853 <PyInit_rcaot_05cb37762ef1645705ed4668+0x583>
180003841:     	xorl	%eax, %eax
180003843:     	movq	0x30(%rsp), %rbx
180003848:     	movq	0x38(%rsp), %rsi
18000384d:     	addq	$0x20, %rsp
180003851:     	popq	%rdi
180003852:     	retq
180003853:     	movq	0xb43e(%rip), %rcx      # 0x18000ec98
18000385a:     	xorl	%r8d, %r8d
18000385d:     	movq	%rbx, %rdx
180003860:     	callq	*0x394a(%rip)           # 0x1800071b0
180003866:     	movl	(%rbx), %ecx
180003868:     	movq	%rax, %rdi
18000386b:     	testl	%ecx, %ecx
18000386d:     	js	0x18000387f <PyInit_rcaot_05cb37762ef1645705ed4668+0x5af>
18000386f:     	subl	$0x1, %ecx
180003872:     	movl	%ecx, (%rbx)
180003874:     	jne	0x18000387f <PyInit_rcaot_05cb37762ef1645705ed4668+0x5af>
180003876:     	movq	%rbx, %rcx
180003879:     	callq	*0x3961(%rip)           # 0x1800071e0
18000387f:     	movq	0x30(%rsp), %rbx
180003884:     	movq	%rdi, %rax
180003887:     	movq	0x38(%rsp), %rsi
18000388c:     	addq	$0x20, %rsp
180003890:     	popq	%rdi
180003891:     	retq
180003892:     	int3
180003893:     	int3
180003894:     	int3
180003895:     	int3
180003896:     	int3
180003897:     	int3
180003898:     	int3
180003899:     	int3
18000389a:     	int3
18000389b:     	int3
18000389c:     	int3
18000389d:     	int3
18000389e:     	int3
18000389f:     	int3
1800038a0:     	movq	%rbx, 0x8(%rsp)
1800038a5:     	movq	%rsi, 0x10(%rsp)
1800038aa:     	pushq	%rdi
1800038ab:     	subq	$0x20, %rsp
1800038af:     	movq	0xb3da(%rip), %rax      # 0x18000ec90
1800038b6:     	movq	%rdx, %rdi
1800038b9:     	movq	%rcx, %rsi
1800038bc:     	testq	%rax, %rax
1800038bf:     	jne	0x180003921 <PyInit_rcaot_05cb37762ef1645705ed4668+0x651>
1800038c1:     	leaq	0x4de0(%rip), %rcx      # 0x1800086a8
1800038c8:     	callq	*0x3982(%rip)           # 0x180007250
1800038ce:     	movq	%rax, %rbx
1800038d1:     	testq	%rax, %rax
1800038d4:     	je	0x18000390f <PyInit_rcaot_05cb37762ef1645705ed4668+0x63f>
1800038d6:     	leaq	0x4de3(%rip), %rdx      # 0x1800086c0
1800038dd:     	movq	%rax, %rcx
1800038e0:     	callq	*0x389a(%rip)           # 0x180007180
1800038e6:     	movl	(%rbx), %ecx
1800038e8:     	movq	%rax, 0xb3a1(%rip)      # 0x18000ec90
1800038ef:     	testl	%ecx, %ecx
1800038f1:     	js	0x18000390a <PyInit_rcaot_05cb37762ef1645705ed4668+0x63a>
1800038f3:     	subl	$0x1, %ecx
1800038f6:     	movl	%ecx, (%rbx)
1800038f8:     	jne	0x18000390a <PyInit_rcaot_05cb37762ef1645705ed4668+0x63a>
1800038fa:     	movq	%rbx, %rcx
1800038fd:     	callq	*0x38dd(%rip)           # 0x1800071e0
180003903:     	movq	0xb386(%rip), %rax      # 0x18000ec90
18000390a:     	testq	%rax, %rax
18000390d:     	jne	0x180003921 <PyInit_rcaot_05cb37762ef1645705ed4668+0x651>
18000390f:     	xorl	%eax, %eax
180003911:     	movq	0x30(%rsp), %rbx
180003916:     	movq	0x38(%rsp), %rsi
18000391b:     	addq	$0x20, %rsp
18000391f:     	popq	%rdi
180003920:     	retq
180003921:     	xorl	%r9d, %r9d
180003924:     	movq	%rdi, %r8
180003927:     	movq	%rsi, %rdx
18000392a:     	movq	%rax, %rcx
18000392d:     	movq	0x30(%rsp), %rbx
180003932:     	movq	0x38(%rsp), %rsi
180003937:     	addq	$0x20, %rsp
18000393b:     	popq	%rdi
18000393c:     	jmpq	*0x386d(%rip)           # 0x1800071b0
180003943:     	int3
180003944:     	int3
180003945:     	int3
180003946:     	int3
180003947:     	int3
180003948:     	int3
180003949:     	int3
18000394a:     	int3
18000394b:     	int3
18000394c:     	int3
18000394d:     	int3
18000394e:     	int3
18000394f:     	int3
180003950:     	movq	%rbx, 0x8(%rsp)
180003955:     	movq	%rsi, 0x10(%rsp)
18000395a:     	pushq	%rdi
18000395b:     	subq	$0x20, %rsp
18000395f:     	movq	%rcx, %rbx
180003962:     	movq	%r8, %rdi
180003965:     	movq	0x10(%rcx), %rcx
180003969:     	movq	%rdx, %rsi
18000396c:     	testq	%rcx, %rcx
18000396f:     	je	0x18000397a <PyInit_rcaot_05cb37762ef1645705ed4668+0x6aa>
180003971:     	movq	%r8, %rdx
180003974:     	callq	*%rsi
180003976:     	testl	%eax, %eax
180003978:     	jne	0x18000399d <PyInit_rcaot_05cb37762ef1645705ed4668+0x6cd>
18000397a:     	movq	0x18(%rbx), %rcx
18000397e:     	testq	%rcx, %rcx
180003981:     	je	0x18000399b <PyInit_rcaot_05cb37762ef1645705ed4668+0x6cb>
180003983:     	movq	%rdi, %rdx
180003986:     	movq	%rsi, %rax
180003989:     	movq	0x30(%rsp), %rbx
18000398e:     	movq	0x38(%rsp), %rsi
180003993:     	addq	$0x20, %rsp
180003997:     	popq	%rdi
180003998:     	jmpq	*%rax
18000399b:     	xorl	%eax, %eax
18000399d:     	movq	0x30(%rsp), %rbx
1800039a2:     	movq	0x38(%rsp), %rsi
1800039a7:     	addq	$0x20, %rsp
1800039ab:     	popq	%rdi
1800039ac:     	retq
1800039ad:     	int3
1800039ae:     	int3
1800039af:     	int3
1800039b0:     	pushq	%rbx
1800039b2:     	subq	$0x20, %rsp
1800039b6:     	movq	%rcx, %rbx
1800039b9:     	movq	0x10(%rcx), %rcx
1800039bd:     	testq	%rcx, %rcx
1800039c0:     	je	0x1800039dd <PyInit_rcaot_05cb37762ef1645705ed4668+0x70d>
1800039c2:     	movq	$0x0, 0x10(%rbx)
1800039ca:     	movl	(%rcx), %eax
1800039cc:     	testl	%eax, %eax
1800039ce:     	js	0x1800039dd <PyInit_rcaot_05cb37762ef1645705ed4668+0x70d>
1800039d0:     	subl	$0x1, %eax
1800039d3:     	movl	%eax, (%rcx)
1800039d5:     	jne	0x1800039dd <PyInit_rcaot_05cb37762ef1645705ed4668+0x70d>
1800039d7:     	callq	*0x3803(%rip)           # 0x1800071e0
1800039dd:     	movq	0x18(%rbx), %rcx
1800039e1:     	testq	%rcx, %rcx
1800039e4:     	je	0x180003a01 <PyInit_rcaot_05cb37762ef1645705ed4668+0x731>
1800039e6:     	movq	$0x0, 0x18(%rbx)
1800039ee:     	movl	(%rcx), %eax
1800039f0:     	testl	%eax, %eax
1800039f2:     	js	0x180003a01 <PyInit_rcaot_05cb37762ef1645705ed4668+0x731>
1800039f4:     	subl	$0x1, %eax
1800039f7:     	movl	%eax, (%rcx)
1800039f9:     	jne	0x180003a01 <PyInit_rcaot_05cb37762ef1645705ed4668+0x731>
1800039fb:     	callq	*0x37df(%rip)           # 0x1800071e0
180003a01:     	xorl	%eax, %eax
180003a03:     	addq	$0x20, %rsp
180003a07:     	popq	%rbx
180003a08:     	retq
180003a09:     	int3
180003a0a:     	int3
180003a0b:     	int3
180003a0c:     	int3
180003a0d:     	int3
180003a0e:     	int3
180003a0f:     	int3
180003a10:     	pushq	%rbx
180003a12:     	subq	$0x20, %rsp
180003a16:     	movq	%rcx, %rbx
180003a19:     	callq	*0x3811(%rip)           # 0x180007230
180003a1f:     	movq	0x10(%rbx), %rcx
180003a23:     	testq	%rcx, %rcx
180003a26:     	je	0x180003a43 <PyInit_rcaot_05cb37762ef1645705ed4668+0x773>
180003a28:     	movq	$0x0, 0x10(%rbx)
180003a30:     	movl	(%rcx), %eax
180003a32:     	testl	%eax, %eax
180003a34:     	js	0x180003a43 <PyInit_rcaot_05cb37762ef1645705ed4668+0x773>
180003a36:     	subl	$0x1, %eax
180003a39:     	movl	%eax, (%rcx)
180003a3b:     	jne	0x180003a43 <PyInit_rcaot_05cb37762ef1645705ed4668+0x773>
180003a3d:     	callq	*0x379d(%rip)           # 0x1800071e0
180003a43:     	movq	0x18(%rbx), %rcx
180003a47:     	testq	%rcx, %rcx
180003a4a:     	je	0x180003a67 <PyInit_rcaot_05cb37762ef1645705ed4668+0x797>
180003a4c:     	movq	$0x0, 0x18(%rbx)
180003a54:     	movl	(%rcx), %eax
180003a56:     	testl	%eax, %eax
180003a58:     	js	0x180003a67 <PyInit_rcaot_05cb37762ef1645705ed4668+0x797>
180003a5a:     	subl	$0x1, %eax
180003a5d:     	movl	%eax, (%rcx)
180003a5f:     	jne	0x180003a67 <PyInit_rcaot_05cb37762ef1645705ed4668+0x797>
180003a61:     	callq	*0x3779(%rip)           # 0x1800071e0
180003a67:     	movq	0x8(%rbx), %rax
180003a6b:     	movq	%rbx, %rcx
180003a6e:     	addq	$0x20, %rsp
180003a72:     	popq	%rbx
180003a73:     	jmpq	*0x140(%rax)
180003a7a:     	int3
180003a7b:     	int3
180003a7c:     	int3
180003a7d:     	int3
180003a7e:     	int3
180003a7f:     	int3
180003a80:     	pushq	%rbx
180003a82:     	subq	$0x30, %rsp
180003a86:     	movq	%r8, %r10
180003a89:     	leaq	0x58(%rsp), %rax
180003a8e:     	movq	%rax, 0x28(%rsp)
180003a93:     	leaq	0xaf36(%rip), %r9       # 0x18000e9d0
180003a9a:     	movq	0x375f(%rip), %rax      # 0x180007200
180003aa1:     	leaq	0x4c48(%rip), %r8       # 0x1800086f0
180003aa8:     	movq	%rdx, %r11
180003aab:     	movq	%rax, 0x20(%rsp)
180003ab0:     	movq	%rcx, %rbx
180003ab3:     	movq	%r10, %rdx
180003ab6:     	movq	%r11, %rcx
180003ab9:     	callq	*0x3631(%rip)           # 0x1800070f0
180003abf:     	testl	%eax, %eax
180003ac1:     	je	0x180003b1c <PyInit_rcaot_05cb37762ef1645705ed4668+0x84c>
180003ac3:     	xorl	%r8d, %r8d
180003ac6:     	xorl	%edx, %edx
180003ac8:     	movq	%rbx, %rcx
180003acb:     	callq	*0x378f(%rip)           # 0x180007260
180003ad1:     	movq	%rax, %rbx
180003ad4:     	testq	%rax, %rax
180003ad7:     	je	0x180003b1c <PyInit_rcaot_05cb37762ef1645705ed4668+0x84c>
180003ad9:     	movq	0x58(%rsp), %rax
180003ade:     	movl	(%rax), %ecx
180003ae0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180003ae6:     	jae	0x180003af1 <PyInit_rcaot_05cb37762ef1645705ed4668+0x821>
180003ae8:     	incl	%ecx
180003aea:     	movl	%ecx, (%rax)
180003aec:     	movq	0x58(%rsp), %rax
180003af1:     	xorl	%ecx, %ecx
180003af3:     	movq	%rax, 0x10(%rbx)
180003af7:     	callq	*0x3693(%rip)           # 0x180007190
180003afd:     	movq	%rax, 0x18(%rbx)
180003b01:     	testq	%rax, %rax
180003b04:     	jne	0x180003b24 <PyInit_rcaot_05cb37762ef1645705ed4668+0x854>
180003b06:     	movl	(%rbx), %eax
180003b08:     	testl	%eax, %eax
180003b0a:     	js	0x180003b1c <PyInit_rcaot_05cb37762ef1645705ed4668+0x84c>
180003b0c:     	subl	$0x1, %eax
180003b0f:     	movl	%eax, (%rbx)
180003b11:     	jne	0x180003b1c <PyInit_rcaot_05cb37762ef1645705ed4668+0x84c>
180003b13:     	movq	%rbx, %rcx
180003b16:     	callq	*0x36c4(%rip)           # 0x1800071e0
180003b1c:     	xorl	%eax, %eax
180003b1e:     	addq	$0x30, %rsp
180003b22:     	popq	%rbx
180003b23:     	retq
180003b24:     	movq	%rbx, %rax
180003b27:     	addq	$0x30, %rsp
180003b2b:     	popq	%rbx
180003b2c:     	retq
180003b2d:     	int3
180003b2e:     	int3
180003b2f:     	int3
180003b30:     	movq	%rbx, 0x8(%rsp)
180003b35:     	movq	%rsi, 0x10(%rsp)
180003b3a:     	pushq	%rdi
180003b3b:     	subq	$0x20, %rsp
180003b3f:     	movq	%rcx, %rbx
180003b42:     	movq	%r8, %rdi
180003b45:     	movq	0x18(%rcx), %rcx
180003b49:     	movq	%rdx, %rsi
180003b4c:     	testq	%rcx, %rcx
180003b4f:     	je	0x180003b5a <PyInit_rcaot_05cb37762ef1645705ed4668+0x88a>
180003b51:     	movq	%r8, %rdx
180003b54:     	callq	*%rsi
180003b56:     	testl	%eax, %eax
180003b58:     	jne	0x180003b7d <PyInit_rcaot_05cb37762ef1645705ed4668+0x8ad>
180003b5a:     	movq	0x40(%rbx), %rcx
180003b5e:     	testq	%rcx, %rcx
180003b61:     	je	0x180003b7b <PyInit_rcaot_05cb37762ef1645705ed4668+0x8ab>
180003b63:     	movq	%rdi, %rdx
180003b66:     	movq	%rsi, %rax
180003b69:     	movq	0x30(%rsp), %rbx
180003b6e:     	movq	0x38(%rsp), %rsi
180003b73:     	addq	$0x20, %rsp
180003b77:     	popq	%rdi
180003b78:     	jmpq	*%rax
180003b7b:     	xorl	%eax, %eax
180003b7d:     	movq	0x30(%rsp), %rbx
180003b82:     	movq	0x38(%rsp), %rsi
180003b87:     	addq	$0x20, %rsp
180003b8b:     	popq	%rdi
180003b8c:     	retq
180003b8d:     	int3
180003b8e:     	int3
180003b8f:     	int3
180003b90:     	pushq	%rbx
180003b92:     	subq	$0x20, %rsp
180003b96:     	movq	%rcx, %rbx
180003b99:     	callq	*0x3691(%rip)           # 0x180007230
180003b9f:     	cmpq	$0x0, 0x48(%rbx)
180003ba4:     	je	0x180003baf <PyInit_rcaot_05cb37762ef1645705ed4668+0x8df>
180003ba6:     	movq	%rbx, %rcx
180003ba9:     	callq	*0x35f1(%rip)           # 0x1800071a0
180003baf:     	movq	0x20(%rbx), %rcx
180003bb3:     	callq	*0x3617(%rip)           # 0x1800071d0
180003bb9:     	movq	0x38(%rbx), %rcx
180003bbd:     	callq	*0x360d(%rip)           # 0x1800071d0
180003bc3:     	movq	0x18(%rbx), %rcx
180003bc7:     	testq	%rcx, %rcx
180003bca:     	je	0x180003bdf <PyInit_rcaot_05cb37762ef1645705ed4668+0x90f>
180003bcc:     	movl	(%rcx), %eax
180003bce:     	testl	%eax, %eax
180003bd0:     	js	0x180003bdf <PyInit_rcaot_05cb37762ef1645705ed4668+0x90f>
180003bd2:     	subl	$0x1, %eax
180003bd5:     	movl	%eax, (%rcx)
180003bd7:     	jne	0x180003bdf <PyInit_rcaot_05cb37762ef1645705ed4668+0x90f>
180003bd9:     	callq	*0x3601(%rip)           # 0x1800071e0
180003bdf:     	movq	0x40(%rbx), %rcx
180003be3:     	testq	%rcx, %rcx
180003be6:     	je	0x180003bfb <PyInit_rcaot_05cb37762ef1645705ed4668+0x92b>
180003be8:     	movl	(%rcx), %eax
180003bea:     	testl	%eax, %eax
180003bec:     	js	0x180003bfb <PyInit_rcaot_05cb37762ef1645705ed4668+0x92b>
180003bee:     	subl	$0x1, %eax
180003bf1:     	movl	%eax, (%rcx)
180003bf3:     	jne	0x180003bfb <PyInit_rcaot_05cb37762ef1645705ed4668+0x92b>
180003bf5:     	callq	*0x35e5(%rip)           # 0x1800071e0
180003bfb:     	movq	0x8(%rbx), %rax
180003bff:     	movq	%rbx, %rcx
180003c02:     	addq	$0x20, %rsp
180003c06:     	popq	%rbx
180003c07:     	jmpq	*0x140(%rax)
180003c0e:     	int3
180003c0f:     	int3
180003c10:     	pushq	%rbx
180003c12:     	subq	$0x20, %rsp
180003c16:     	callq	*0x357c(%rip)           # 0x180007198
180003c1c:     	movq	%rax, %rbx
180003c1f:     	testq	%rax, %rax
180003c22:     	jne	0x180003c2a <PyInit_rcaot_05cb37762ef1645705ed4668+0x95a>
180003c24:     	addq	$0x20, %rsp
180003c28:     	popq	%rbx
180003c29:     	retq
180003c2a:     	movq	%rbx, %rcx
180003c2d:     	movq	%rdi, 0x30(%rsp)
180003c32:     	callq	0x180005f7d <numba_list_iter_next+0xebd>
180003c37:     	leaq	0x1(%rax), %rcx
180003c3b:     	callq	*0x3627(%rip)           # 0x180007268
180003c41:     	movq	%rax, %rdi
180003c44:     	testq	%rax, %rax
180003c47:     	jne	0x180003c5c <PyInit_rcaot_05cb37762ef1645705ed4668+0x98c>
180003c49:     	callq	*0x3509(%rip)           # 0x180007158
180003c4f:     	movq	0x30(%rsp), %rdi
180003c54:     	xorl	%eax, %eax
180003c56:     	addq	$0x20, %rsp
180003c5a:     	popq	%rbx
180003c5b:     	retq
180003c5c:     	movq	%rbx, %rdx
180003c5f:     	movq	%rdi, %rcx
180003c62:     	callq	0x180005f77 <numba_list_iter_next+0xeb7>
180003c67:     	movq	%rdi, %rax
180003c6a:     	movq	0x30(%rsp), %rdi
180003c6f:     	addq	$0x20, %rsp
180003c73:     	popq	%rbx
180003c74:     	retq
180003c75:     	int3
180003c76:     	int3
180003c77:     	int3
180003c78:     	int3
180003c79:     	int3
180003c7a:     	int3
180003c7b:     	int3
180003c7c:     	int3
180003c7d:     	int3
180003c7e:     	int3
180003c7f:     	int3
180003c80:     	movq	0x18(%rcx), %rcx
180003c84:     	movq	%rdx, %rax
180003c87:     	testq	%rcx, %rcx
180003c8a:     	je	0x180003c92 <PyInit_rcaot_05cb37762ef1645705ed4668+0x9c2>
180003c8c:     	movq	%r8, %rdx
180003c8f:     	jmpq	*%rax
180003c92:     	xorl	%eax, %eax
180003c94:     	retq
180003c95:     	int3
180003c96:     	int3
180003c97:     	int3
180003c98:     	int3
180003c99:     	int3
180003c9a:     	int3
180003c9b:     	int3
180003c9c:     	int3
180003c9d:     	int3
180003c9e:     	int3
180003c9f:     	int3
180003ca0:     	movq	%rbx, 0x8(%rsp)
180003ca5:     	pushq	%rdi
180003ca6:     	subq	$0x20, %rsp
180003caa:     	movq	0x28(%rcx), %rax
180003cae:     	xorl	%edi, %edi
180003cb0:     	movq	%rcx, %rbx
180003cb3:     	testq	%rax, %rax
180003cb6:     	je	0x180003cc2 <PyInit_rcaot_05cb37762ef1645705ed4668+0x9f2>
180003cb8:     	addq	$0x38, %rcx
180003cbc:     	callq	*%rax
180003cbe:     	movq	%rdi, 0x28(%rbx)
180003cc2:     	movq	0x18(%rbx), %rcx
180003cc6:     	testq	%rcx, %rcx
180003cc9:     	je	0x180003ce2 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa12>
180003ccb:     	movq	%rdi, 0x18(%rbx)
180003ccf:     	movl	(%rcx), %eax
180003cd1:     	testl	%eax, %eax
180003cd3:     	js	0x180003ce2 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa12>
180003cd5:     	subl	$0x1, %eax
180003cd8:     	movl	%eax, (%rcx)
180003cda:     	jne	0x180003ce2 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa12>
180003cdc:     	callq	*0x34fe(%rip)           # 0x1800071e0
180003ce2:     	movq	%rdi, 0x20(%rbx)
180003ce6:     	xorl	%eax, %eax
180003ce8:     	movq	0x30(%rsp), %rbx
180003ced:     	addq	$0x20, %rsp
180003cf1:     	popq	%rdi
180003cf2:     	retq
180003cf3:     	int3
180003cf4:     	int3
180003cf5:     	int3
180003cf6:     	int3
180003cf7:     	int3
180003cf8:     	int3
180003cf9:     	int3
180003cfa:     	int3
180003cfb:     	int3
180003cfc:     	int3
180003cfd:     	int3
180003cfe:     	int3
180003cff:     	int3
180003d00:     	pushq	%rbx
180003d02:     	subq	$0x20, %rsp
180003d06:     	movq	%rcx, %rbx
180003d09:     	callq	*0x3521(%rip)           # 0x180007230
180003d0f:     	cmpq	$0x0, 0x30(%rbx)
180003d14:     	je	0x180003d1f <PyInit_rcaot_05cb37762ef1645705ed4668+0xa4f>
180003d16:     	movq	%rbx, %rcx
180003d19:     	callq	*0x3481(%rip)           # 0x1800071a0
180003d1f:     	callq	*0x342b(%rip)           # 0x180007150
180003d25:     	testl	%eax, %eax
180003d27:     	jne	0x180003d38 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa68>
180003d29:     	movq	0x28(%rbx), %rax
180003d2d:     	testq	%rax, %rax
180003d30:     	je	0x180003d38 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa68>
180003d32:     	leaq	0x38(%rbx), %rcx
180003d36:     	callq	*%rax
180003d38:     	movq	0x18(%rbx), %rcx
180003d3c:     	testq	%rcx, %rcx
180003d3f:     	je	0x180003d54 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa84>
180003d41:     	movl	(%rcx), %eax
180003d43:     	testl	%eax, %eax
180003d45:     	js	0x180003d54 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa84>
180003d47:     	subl	$0x1, %eax
180003d4a:     	movl	%eax, (%rcx)
180003d4c:     	jne	0x180003d54 <PyInit_rcaot_05cb37762ef1645705ed4668+0xa84>
180003d4e:     	callq	*0x348c(%rip)           # 0x1800071e0
180003d54:     	movq	0x8(%rbx), %rax
180003d58:     	movq	%rbx, %rcx
180003d5b:     	addq	$0x20, %rsp
180003d5f:     	popq	%rbx
180003d60:     	jmpq	*0x140(%rax)
180003d67:     	int3
180003d68:     	int3
180003d69:     	int3
180003d6a:     	int3
180003d6b:     	int3
180003d6c:     	int3
180003d6d:     	int3
180003d6e:     	int3
180003d6f:     	int3
180003d70:     	pushq	%rdi
180003d72:     	subq	$0x20, %rsp
180003d76:     	cmpq	$0x0, 0x20(%rcx)
180003d7b:     	movq	%rcx, %rdi
180003d7e:     	jne	0x180003d9f <PyInit_rcaot_05cb37762ef1645705ed4668+0xacf>
180003d80:     	movq	0x3529(%rip), %rcx      # 0x1800072b0
180003d87:     	leaq	0x49b2(%rip), %rdx      # 0x180008740
180003d8e:     	movq	(%rcx), %rcx
180003d91:     	callq	*0x3511(%rip)           # 0x1800072a8
180003d97:     	xorl	%eax, %eax
180003d99:     	addq	$0x20, %rsp
180003d9d:     	popq	%rdi
180003d9e:     	retq
180003d9f:     	movq	%rdi, %rdx
180003da2:     	movq	%rbx, 0x30(%rsp)
180003da7:     	movl	$0x1, %ecx
180003dac:     	callq	*0x334e(%rip)           # 0x180007100
180003db2:     	movq	%rax, %rbx
180003db5:     	testq	%rax, %rax
180003db8:     	jne	0x180003dc5 <PyInit_rcaot_05cb37762ef1645705ed4668+0xaf5>
180003dba:     	movq	0x30(%rsp), %rbx
180003dbf:     	addq	$0x20, %rsp
180003dc3:     	popq	%rdi
180003dc4:     	retq
180003dc5:     	xorl	%r8d, %r8d
180003dc8:     	movq	%rbx, %rdx
180003dcb:     	movq	%rdi, %rcx
180003dce:     	callq	*0x20(%rdi)
180003dd1:     	movl	(%rbx), %ecx
180003dd3:     	movq	%rax, %rdi
180003dd6:     	testl	%ecx, %ecx
180003dd8:     	js	0x180003dea <PyInit_rcaot_05cb37762ef1645705ed4668+0xb1a>
180003dda:     	subl	$0x1, %ecx
180003ddd:     	movl	%ecx, (%rbx)
180003ddf:     	jne	0x180003dea <PyInit_rcaot_05cb37762ef1645705ed4668+0xb1a>
180003de1:     	movq	%rbx, %rcx
180003de4:     	callq	*0x33f6(%rip)           # 0x1800071e0
180003dea:     	movq	0x30(%rsp), %rbx
180003def:     	movq	%rdi, %rax
180003df2:     	addq	$0x20, %rsp
180003df6:     	popq	%rdi
180003df7:     	retq
180003df8:     	int3
180003df9:     	int3
180003dfa:     	int3
180003dfb:     	int3
180003dfc:     	int3
180003dfd:     	int3
180003dfe:     	int3
180003dff:     	int3
180003e00:     	movq	%rbx, 0x8(%rsp)
180003e05:     	pushq	%rdi
180003e06:     	subq	$0x20, %rsp
180003e0a:     	movq	%r8, %rbx
180003e0d:     	callq	*0x3325(%rip)           # 0x180007138
180003e13:     	movl	(%rbx), %ecx
180003e15:     	movl	%eax, %edi
180003e17:     	testl	%ecx, %ecx
180003e19:     	js	0x180003e2b <PyInit_rcaot_05cb37762ef1645705ed4668+0xb5b>
180003e1b:     	subl	$0x1, %ecx
180003e1e:     	movl	%ecx, (%rbx)
180003e20:     	jne	0x180003e2b <PyInit_rcaot_05cb37762ef1645705ed4668+0xb5b>
180003e22:     	movq	%rbx, %rcx
180003e25:     	callq	*0x33b5(%rip)           # 0x1800071e0
180003e2b:     	movl	%edi, %ecx
180003e2d:     	movq	0x30(%rsp), %rbx
180003e32:     	addq	$0x20, %rsp
180003e36:     	popq	%rdi
180003e37:     	jmpq	*0x33ea(%rip)           # 0x180007228
180003e3e:     	int3
180003e3f:     	int3
180003e40:     	movq	%rbx, 0x8(%rsp)
180003e45:     	pushq	%rdi
180003e46:     	subq	$0x20, %rsp
180003e4a:     	movl	(%rdx), %eax
180003e4c:     	movq	%rdx, %rbx
180003e4f:     	movq	%rcx, %rdi
180003e52:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180003e57:     	jae	0x180003e5d <PyInit_rcaot_05cb37762ef1645705ed4668+0xb8d>
180003e59:     	incl	%eax
180003e5b:     	movl	%eax, (%rdx)
180003e5d:     	movl	$0x30, %ecx
180003e62:     	callq	*0xae00(%rip)           # 0x18000ec68
180003e68:     	cmpb	$0x0, 0xadd1(%rip)      # 0x18000ec40
180003e6f:     	je	0x180003e79 <PyInit_rcaot_05cb37762ef1645705ed4668+0xba9>
180003e71:     	lock
180003e72:     	incq	0xadcf(%rip)            # 0x18000ec48
180003e79:     	testq	%rax, %rax
180003e7c:     	je	0x180003eb3 <PyInit_rcaot_05cb37762ef1645705ed4668+0xbe3>
180003e7e:     	movl	$0x1, %ecx
180003e83:     	leaq	-0x8a(%rip), %rdx       # 0x180003e00 <PyInit_rcaot_05cb37762ef1645705ed4668+0xb30>
180003e8a:     	xchgq	%rcx, (%rax)
180003e8d:     	xorl	%ecx, %ecx
180003e8f:     	movq	%rdx, 0x8(%rax)
180003e93:     	movq	%rcx, 0x20(%rax)
180003e97:     	movq	%rcx, 0x28(%rax)
180003e9b:     	movq	%rbx, 0x10(%rax)
180003e9f:     	movq	%rdi, 0x18(%rax)
180003ea3:     	cmpb	%cl, 0xad97(%rip)       # 0x18000ec40
180003ea9:     	je	0x180003eb3 <PyInit_rcaot_05cb37762ef1645705ed4668+0xbe3>
180003eab:     	lock
180003eac:     	incq	0xada5(%rip)            # 0x18000ec58
180003eb3:     	movq	0x30(%rsp), %rbx
180003eb8:     	addq	$0x20, %rsp
180003ebc:     	popq	%rdi
180003ebd:     	retq
180003ebe:     	int3
180003ebf:     	int3
180003ec0:     	movq	%rbx, 0x8(%rsp)
180003ec5:     	pushq	%rdi
180003ec6:     	subq	$0x30, %rsp
180003eca:     	movq	%rcx, %rdi
180003ecd:     	leaq	0xaaec(%rip), %r9       # 0x18000e9c0
180003ed4:     	movq	%r8, %rax
180003ed7:     	leaq	0x58(%rsp), %rcx
180003edc:     	movq	%rdx, %r10
180003edf:     	movq	%rcx, 0x20(%rsp)
180003ee4:     	movq	%r10, %rcx
180003ee7:     	leaq	0x489a(%rip), %r8       # 0x180008788
180003eee:     	movq	%rax, %rdx
180003ef1:     	callq	*0x31f9(%rip)           # 0x1800070f0
180003ef7:     	testl	%eax, %eax
180003ef9:     	je	0x180003f23 <PyInit_rcaot_05cb37762ef1645705ed4668+0xc53>
180003efb:     	movq	0x58(%rsp), %rcx
180003f00:     	callq	*0x3242(%rip)           # 0x180007148
180003f06:     	movq	%rax, %rbx
180003f09:     	callq	*0x33c9(%rip)           # 0x1800072d8
180003f0f:     	testq	%rax, %rax
180003f12:     	jne	0x180003f23 <PyInit_rcaot_05cb37762ef1645705ed4668+0xc53>
180003f14:     	movq	%rbx, 0x10(%rdi)
180003f18:     	movq	0x40(%rsp), %rbx
180003f1d:     	addq	$0x30, %rsp
180003f21:     	popq	%rdi
180003f22:     	retq
180003f23:     	movq	0x40(%rsp), %rbx
180003f28:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180003f2d:     	addq	$0x30, %rsp
180003f31:     	popq	%rdi
180003f32:     	retq
180003f33:     	int3
180003f34:     	int3
180003f35:     	int3
180003f36:     	int3
180003f37:     	int3
180003f38:     	int3
180003f39:     	int3
180003f3a:     	int3
180003f3b:     	int3
180003f3c:     	int3
180003f3d:     	int3
180003f3e:     	int3
180003f3f:     	int3
180003f40:     	subq	$0x38, %rsp
180003f44:     	movl	%r8d, %eax
180003f47:     	movq	%rdx, %r10
180003f4a:     	movq	0x10(%rcx), %r8
180003f4e:     	movq	%rcx, %rdx
180003f51:     	movl	%eax, 0x28(%rsp)
180003f55:     	movq	%r10, %rcx
180003f58:     	movl	$0x0, 0x20(%rsp)
180003f60:     	movq	0x20(%r8), %r9
180003f64:     	movq	0x18(%r8), %r8
180003f68:     	callq	*0x32b2(%rip)           # 0x180007220
180003f6e:     	addq	$0x38, %rsp
180003f72:     	retq
180003f73:     	int3
180003f74:     	int3
180003f75:     	int3
180003f76:     	int3
180003f77:     	int3
180003f78:     	int3
180003f79:     	int3
180003f7a:     	int3
180003f7b:     	int3
180003f7c:     	int3
180003f7d:     	int3
180003f7e:     	int3
180003f7f:     	int3
180003f80:     	movq	0x10(%rcx), %rax
180003f84:     	lock
180003f85:     	incq	(%rax)
180003f88:     	movq	0x3341(%rip), %rax      # 0x1800072d0
180003f8f:     	retq
180003f90:     	subq	$0x28, %rsp
180003f94:     	movq	0x10(%rcx), %rcx
180003f98:     	callq	0x180005290 <numba_list_iter_next+0x1d0>
180003f9d:     	movq	0x332c(%rip), %rax      # 0x1800072d0
180003fa4:     	addq	$0x28, %rsp
180003fa8:     	retq
180003fa9:     	int3
180003faa:     	int3
180003fab:     	int3
180003fac:     	int3
180003fad:     	int3
180003fae:     	int3
180003faf:     	int3
180003fb0:     	movq	0x10(%rcx), %rcx
180003fb4:     	movq	0x18(%rcx), %rcx
180003fb8:     	jmpq	*0x31b1(%rip)           # 0x180007170
180003fbf:     	int3
180003fc0:     	subq	$0x28, %rsp
180003fc4:     	movq	0x10(%rcx), %rax
180003fc8:     	testq	%rax, %rax
180003fcb:     	je	0x180003fe9 <PyInit_rcaot_05cb37762ef1645705ed4668+0xd19>
180003fcd:     	cmpq	$0x0, 0x18(%rax)
180003fd2:     	je	0x180003fe9 <PyInit_rcaot_05cb37762ef1645705ed4668+0xd19>
180003fd4:     	movq	(%rax), %rcx
180003fd7:     	nop
180003fd8:     	cmpq	$-0x1, %rcx
180003fdc:     	je	0x180003fe9 <PyInit_rcaot_05cb37762ef1645705ed4668+0xd19>
180003fde:     	addq	$0x28, %rsp
180003fe2:     	jmpq	*0x3137(%rip)           # 0x180007120
180003fe9:     	movq	0x3220(%rip), %rcx      # 0x180007210
180003ff0:     	leaq	0x4799(%rip), %rdx      # 0x180008790
180003ff7:     	movq	(%rcx), %rcx
180003ffa:     	callq	*0x32a8(%rip)           # 0x1800072a8
180004000:     	xorl	%eax, %eax
180004002:     	addq	$0x28, %rsp
180004006:     	retq
180004007:     	int3
180004008:     	int3
180004009:     	int3
18000400a:     	int3
18000400b:     	int3
18000400c:     	int3
18000400d:     	int3
18000400e:     	int3
18000400f:     	int3
180004010:     	movq	0x10(%rcx), %rcx
180004014:     	movq	0x28(%rcx), %rcx
180004018:     	jmpq	*0x3151(%rip)           # 0x180007170
18000401f:     	int3
180004020:     	movq	0x10(%rcx), %rax
180004024:     	movq	0x10(%rax), %rax
180004028:     	testq	%rax, %rax
18000402b:     	je	0x18000403c <PyInit_rcaot_05cb37762ef1645705ed4668+0xd6c>
18000402d:     	movl	(%rax), %ecx
18000402f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180004035:     	jae	0x18000405a <PyInit_rcaot_05cb37762ef1645705ed4668+0xd8a>
180004037:     	incl	%ecx
180004039:     	movl	%ecx, (%rax)
18000403b:     	retq
18000403c:     	movq	0x328d(%rip), %rcx      # 0x1800072d0
180004043:     	movl	(%rcx), %eax
180004045:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000404a:     	jae	0x180004057 <PyInit_rcaot_05cb37762ef1645705ed4668+0xd87>
18000404c:     	incl	%eax
18000404e:     	movl	%eax, (%rcx)
180004050:     	movq	0x3279(%rip), %rcx      # 0x1800072d0
180004057:     	movq	%rcx, %rax
18000405a:     	retq
18000405b:     	int3
18000405c:     	int3
18000405d:     	int3
18000405e:     	int3
18000405f:     	int3
180004060:     	pushq	%rbx
180004062:     	subq	$0x20, %rsp
180004066:     	movq	%rcx, %rbx
180004069:     	movq	0x10(%rcx), %rcx
18000406d:     	callq	0x180005290 <numba_list_iter_next+0x1d0>
180004072:     	movq	0x8(%rbx), %rax
180004076:     	movq	%rbx, %rcx
180004079:     	addq	$0x20, %rsp
18000407d:     	popq	%rbx
18000407e:     	jmpq	*0x140(%rax)
180004085:     	int3
180004086:     	int3
180004087:     	int3
180004088:     	int3
180004089:     	int3
18000408a:     	int3
18000408b:     	int3
18000408c:     	int3
18000408d:     	int3
18000408e:     	int3
18000408f:     	int3
180004090:     	movq	%rdi, 0x18(%rsp)
180004095:     	pushq	%r14
180004097:     	subq	$0x20, %rsp
18000409b:     	movq	0xabde(%rip), %rax      # 0x18000ec80
1800040a2:     	movq	%rdx, %r14
1800040a5:     	movq	%rcx, %rdi
1800040a8:     	movq	0x8(%rcx), %rcx
1800040ac:     	movq	0x10(%rax), %rdx
1800040b0:     	cmpq	%rdx, %rcx
1800040b3:     	je	0x1800040d0 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe00>
1800040b5:     	callq	*0x3135(%rip)           # 0x1800071f0
1800040bb:     	testl	%eax, %eax
1800040bd:     	jne	0x1800040d0 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe00>
1800040bf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800040c4:     	movq	0x40(%rsp), %rdi
1800040c9:     	addq	$0x20, %rsp
1800040cd:     	popq	%r14
1800040cf:     	retq
1800040d0:     	movq	%rbx, 0x30(%rsp)
1800040d5:     	movq	%rdi, %rdx
1800040d8:     	movq	0x10(%rdi), %rbx
1800040dc:     	movq	%rbx, %rcx
1800040df:     	movq	%rsi, 0x38(%rsp)
1800040e4:     	movl	0x18(%rdi), %esi
1800040e7:     	callq	0x180003e40 <PyInit_rcaot_05cb37762ef1645705ed4668+0xb70>
1800040ec:     	movq	%rax, (%r14)
1800040ef:     	movq	0xab8a(%rip), %rax      # 0x18000ec80
1800040f6:     	movq	%rbx, 0x20(%r14)
1800040fa:     	movl	0x18(%rdi), %edx
1800040fd:     	movq	0x20(%rdi), %rcx
180004101:     	callq	*0x4f0(%rax)
180004107:     	cmpl	$0x12, 0xab7e(%rip)     # 0x18000ec8c
18000410e:     	movq	0x30(%rsp), %rbx
180004113:     	movq	%rax, 0x10(%r14)
180004117:     	movq	0x38(%rdi), %rax
18000411b:     	jl	0x180004123 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe53>
18000411d:     	movq	0x28(%rax), %rax
180004121:     	jmp	0x180004127 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe57>
180004123:     	movslq	0x20(%rax), %rax
180004127:     	xorl	%r8d, %r8d
18000412a:     	movq	%rax, 0x18(%r14)
18000412e:     	movq	%rdi, 0x8(%r14)
180004132:     	leaq	0x28(%r14), %rax
180004136:     	testl	%esi, %esi
180004138:     	jle	0x18000417b <PyInit_rcaot_05cb37762ef1645705ed4668+0xeab>
18000413a:     	nopw	(%rax,%rax)
180004140:     	movq	0x20(%rdi), %rcx
180004144:     	movq	(%rcx,%r8,8), %rdx
180004148:     	incl	%r8d
18000414b:     	movq	%rdx, (%rax)
18000414e:     	addq	$0x8, %rax
180004152:     	cmpl	%esi, %r8d
180004155:     	jl	0x180004140 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe70>
180004157:     	xorl	%r8d, %r8d
18000415a:     	nopw	(%rax,%rax)
180004160:     	movq	0x28(%rdi), %rcx
180004164:     	leaq	0x8(%rax), %rax
180004168:     	movslq	%r8d, %rdx
18000416b:     	incl	%r8d
18000416e:     	movq	(%rcx,%rdx,8), %rdx
180004172:     	movq	%rdx, -0x8(%rax)
180004176:     	cmpl	%esi, %r8d
180004179:     	jl	0x180004160 <PyInit_rcaot_05cb37762ef1645705ed4668+0xe90>
18000417b:     	movq	0x38(%rsp), %rsi
180004180:     	xorl	%eax, %eax
180004182:     	movq	0x40(%rsp), %rdi
180004187:     	addq	$0x20, %rsp
18000418b:     	popq	%r14
18000418d:     	retq
18000418e:     	int3
18000418f:     	int3
180004190:     	pushq	%rbx
180004192:     	pushq	%rbp
180004193:     	pushq	%rsi
180004194:     	pushq	%rdi
180004195:     	subq	$0x28, %rsp
180004199:     	cmpq	$0x0, 0xaaf7(%rip)      # 0x18000ec98
1800041a1:     	movq	%rcx, %rbp
1800041a4:     	movslq	0x8(%rdx), %rdi
1800041a8:     	movq	(%rdx), %rsi
1800041ab:     	jne	0x180004203 <PyInit_rcaot_05cb37762ef1645705ed4668+0xf33>
1800041ad:     	leaq	0x44e4(%rip), %rcx      # 0x180008698
1800041b4:     	callq	*0x3096(%rip)           # 0x180007250
1800041ba:     	movq	%rax, %rbx
1800041bd:     	testq	%rax, %rax
1800041c0:     	je	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
1800041c6:     	leaq	0x44d3(%rip), %rdx      # 0x1800086a0
1800041cd:     	movq	%rax, %rcx
1800041d0:     	callq	*0x2faa(%rip)           # 0x180007180
1800041d6:     	movl	(%rbx), %edx
1800041d8:     	movq	%rax, 0xaab9(%rip)      # 0x18000ec98
1800041df:     	testl	%edx, %edx
1800041e1:     	js	0x1800041fa <PyInit_rcaot_05cb37762ef1645705ed4668+0xf2a>
1800041e3:     	subl	$0x1, %edx
1800041e6:     	movl	%edx, (%rbx)
1800041e8:     	jne	0x1800041fa <PyInit_rcaot_05cb37762ef1645705ed4668+0xf2a>
1800041ea:     	movq	%rbx, %rcx
1800041ed:     	callq	*0x2fed(%rip)           # 0x1800071e0
1800041f3:     	movq	0xaa9e(%rip), %rax      # 0x18000ec98
1800041fa:     	testq	%rax, %rax
1800041fd:     	je	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
180004203:     	movq	%rdi, %rdx
180004206:     	movq	%rsi, %rcx
180004209:     	callq	*0x30a9(%rip)           # 0x1800072b8
18000420f:     	movq	%rax, %rdi
180004212:     	testq	%rax, %rax
180004215:     	je	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
180004217:     	movq	0xaa7a(%rip), %rcx      # 0x18000ec98
18000421e:     	xorl	%r8d, %r8d
180004221:     	movq	%rax, %rdx
180004224:     	callq	*0x2f86(%rip)           # 0x1800071b0
18000422a:     	movl	(%rdi), %ecx
18000422c:     	movq	%rax, %rbx
18000422f:     	testl	%ecx, %ecx
180004231:     	js	0x180004243 <PyInit_rcaot_05cb37762ef1645705ed4668+0xf73>
180004233:     	subl	$0x1, %ecx
180004236:     	movl	%ecx, (%rdi)
180004238:     	jne	0x180004243 <PyInit_rcaot_05cb37762ef1645705ed4668+0xf73>
18000423a:     	movq	%rdi, %rcx
18000423d:     	callq	*0x2f9d(%rip)           # 0x1800071e0
180004243:     	testq	%rbx, %rbx
180004246:     	je	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
180004248:     	movq	0x8(%rbx), %r8
18000424c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180004257:     	jne	0x180004295 <PyInit_rcaot_05cb37762ef1645705ed4668+0xfc5>
180004259:     	movq	0x3040(%rip), %rcx      # 0x1800072a0
180004260:     	leaq	0x4631(%rip), %rdx      # 0x180008898
180004267:     	movq	0x18(%r8), %r8
18000426b:     	movq	(%rcx), %rcx
18000426e:     	callq	*0x2f94(%rip)           # 0x180007208
180004274:     	movl	(%rbx), %eax
180004276:     	testl	%eax, %eax
180004278:     	js	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
18000427a:     	subl	$0x1, %eax
18000427d:     	movl	%eax, (%rbx)
18000427f:     	jne	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
180004281:     	movq	%rbx, %rcx
180004284:     	callq	*0x2f56(%rip)           # 0x1800071e0
18000428a:     	xorl	%eax, %eax
18000428c:     	addq	$0x28, %rsp
180004290:     	popq	%rdi
180004291:     	popq	%rsi
180004292:     	popq	%rbp
180004293:     	popq	%rbx
180004294:     	retq
180004295:     	xorl	%r8d, %r8d
180004298:     	leaq	0xa0a1(%rip), %rcx      # 0x18000e340
18000429f:     	xorl	%edx, %edx
1800042a1:     	callq	*0x2fb9(%rip)           # 0x180007260
1800042a7:     	movq	%rax, %rdi
1800042aa:     	testq	%rax, %rax
1800042ad:     	je	0x180004274 <PyInit_rcaot_05cb37762ef1645705ed4668+0xfa4>
1800042af:     	movq	%rbp, %rcx
1800042b2:     	movq	%rbx, 0x18(%rax)
1800042b6:     	callq	*0x2f1c(%rip)           # 0x1800071d8
1800042bc:     	movq	%rax, 0x10(%rdi)
1800042c0:     	movq	%rax, %rcx
1800042c3:     	testq	%rax, %rax
1800042c6:     	jne	0x1800042da <PyInit_rcaot_05cb37762ef1645705ed4668+0x100a>
1800042c8:     	movl	(%rdi), %eax
1800042ca:     	testl	%eax, %eax
1800042cc:     	js	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
1800042ce:     	subl	$0x1, %eax
1800042d1:     	movl	%eax, (%rdi)
1800042d3:     	jne	0x18000428a <PyInit_rcaot_05cb37762ef1645705ed4668+0xfba>
1800042d5:     	movq	%rdi, %rcx
1800042d8:     	jmp	0x180004284 <PyInit_rcaot_05cb37762ef1645705ed4668+0xfb4>
1800042da:     	movl	(%rax), %eax
1800042dc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800042e1:     	jae	0x1800042e7 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1017>
1800042e3:     	incl	%eax
1800042e5:     	movl	%eax, (%rcx)
1800042e7:     	movq	%rdi, %rax
1800042ea:     	addq	$0x28, %rsp
1800042ee:     	popq	%rdi
1800042ef:     	popq	%rsi
1800042f0:     	popq	%rbp
1800042f1:     	popq	%rbx
1800042f2:     	retq
1800042f3:     	int3
1800042f4:     	int3
1800042f5:     	int3
1800042f6:     	int3
1800042f7:     	int3
1800042f8:     	int3
1800042f9:     	int3
1800042fa:     	int3
1800042fb:     	int3
1800042fc:     	int3
1800042fd:     	int3
1800042fe:     	int3
1800042ff:     	int3
180004300:     	movq	%r9, 0x20(%rsp)
180004305:     	movq	%r8, 0x18(%rsp)
18000430a:     	movq	%rdx, 0x10(%rsp)
18000430f:     	movq	%rcx, 0x8(%rsp)
180004314:     	pushq	%rbx
180004315:     	pushq	%rbp
180004316:     	pushq	%rsi
180004317:     	pushq	%rdi
180004318:     	pushq	%r12
18000431a:     	pushq	%r13
18000431c:     	pushq	%r14
18000431e:     	pushq	%r15
180004320:     	subq	$0x68, %rsp
180004324:     	movq	%rcx, %r14
180004327:     	movq	%r9, %r15
18000432a:     	leaq	0x401f(%rip), %rcx      # 0x180008350
180004331:     	movq	%r8, %r13
180004334:     	movq	%rdx, %rsi
180004337:     	callq	*0x2f13(%rip)           # 0x180007250
18000433d:     	movq	%rax, %rdi
180004340:     	testq	%rax, %rax
180004343:     	jne	0x18000437c <PyInit_rcaot_05cb37762ef1645705ed4668+0x10ac>
180004345:     	movq	0x2de4(%rip), %rcx      # 0x180007130
18000434c:     	movq	(%rcx), %rcx
18000434f:     	callq	*0x2e73(%rip)           # 0x1800071c8
180004355:     	testl	%eax, %eax
180004357:     	je	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
18000435d:     	callq	*0x2f5d(%rip)           # 0x1800072c0
180004363:     	leaq	0x4006(%rip), %rcx      # 0x180008370
18000436a:     	callq	*0x2ee0(%rip)           # 0x180007250
180004370:     	movq	%rax, %rdi
180004373:     	testq	%rax, %rax
180004376:     	je	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
18000437c:     	leaq	0x400d(%rip), %rdx      # 0x180008390
180004383:     	movq	%rdi, %rcx
180004386:     	callq	*0x2df4(%rip)           # 0x180007180
18000438c:     	movl	(%rdi), %ecx
18000438e:     	movq	%rax, %rbx
180004391:     	testl	%ecx, %ecx
180004393:     	js	0x1800043a5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x10d5>
180004395:     	subl	$0x1, %ecx
180004398:     	movl	%ecx, (%rdi)
18000439a:     	jne	0x1800043a5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x10d5>
18000439c:     	movq	%rdi, %rcx
18000439f:     	callq	*0x2e3b(%rip)           # 0x1800071e0
1800043a5:     	testq	%rbx, %rbx
1800043a8:     	je	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
1800043ae:     	movq	0x2d43(%rip), %rax      # 0x1800070f8
1800043b5:     	cmpq	%rax, 0x8(%rbx)
1800043b9:     	je	0x1800043f5 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1125>
1800043bb:     	movq	0x2eee(%rip), %rcx      # 0x1800072b0
1800043c2:     	leaq	0x3fd7(%rip), %rdx      # 0x1800083a0
1800043c9:     	movq	(%rcx), %rcx
1800043cc:     	callq	*0x2ed6(%rip)           # 0x1800072a8
1800043d2:     	movl	(%rbx), %eax
1800043d4:     	testl	%eax, %eax
1800043d6:     	js	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
1800043dc:     	subl	$0x1, %eax
1800043df:     	movl	%eax, (%rbx)
1800043e1:     	jne	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
1800043e7:     	movq	%rbx, %rcx
1800043ea:     	callq	*0x2df0(%rip)           # 0x1800071e0
1800043f0:     	jmp	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
1800043f5:     	xorl	%edx, %edx
1800043f7:     	movq	%rbx, %rcx
1800043fa:     	callq	*0x2dc0(%rip)           # 0x1800071c0
180004400:     	movl	(%rbx), %ecx
180004402:     	movq	%rax, 0xa877(%rip)      # 0x18000ec80
180004409:     	testl	%ecx, %ecx
18000440b:     	js	0x180004424 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1154>
18000440d:     	subl	$0x1, %ecx
180004410:     	movl	%ecx, (%rbx)
180004412:     	jne	0x180004424 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1154>
180004414:     	movq	%rbx, %rcx
180004417:     	callq	*0x2dc3(%rip)           # 0x1800071e0
18000441d:     	movq	0xa85c(%rip), %rax      # 0x18000ec80
180004424:     	testq	%rax, %rax
180004427:     	jne	0x180004442 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1172>
180004429:     	leaq	0x3f98(%rip), %rdx      # 0x1800083c8
180004430:     	movq	0x2e79(%rip), %rcx      # 0x1800072b0
180004437:     	movq	(%rcx), %rcx
18000443a:     	callq	*0x2e68(%rip)           # 0x1800072a8
180004440:     	jmp	0x180004477 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a7>
180004442:     	callq	*(%rax)
180004444:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180004449:     	jbe	0x1800044aa <PyInit_rcaot_05cb37762ef1645705ed4668+0x11da>
18000444b:     	movq	0x2e5e(%rip), %rax      # 0x1800072b0
180004452:     	movq	(%rax), %rbx
180004455:     	movq	0xa824(%rip), %rax      # 0x18000ec80
18000445c:     	callq	*(%rax)
18000445e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180004464:     	leaq	0x3f85(%rip), %rdx      # 0x1800083f0
18000446b:     	movl	%eax, %r9d
18000446e:     	movq	%rbx, %rcx
180004471:     	callq	*0x2d91(%rip)           # 0x180007208
180004477:     	callq	*0x2c93(%rip)           # 0x180007110
18000447d:     	movq	0x2c84(%rip), %rcx      # 0x180007108
180004484:     	leaq	0x418d(%rip), %rdx      # 0x180008618
18000448b:     	movq	(%rcx), %rcx
18000448e:     	callq	*0x2e14(%rip)           # 0x1800072a8
180004494:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180004499:     	addq	$0x68, %rsp
18000449d:     	popq	%r15
18000449f:     	popq	%r14
1800044a1:     	popq	%r13
1800044a3:     	popq	%r12
1800044a5:     	popq	%rdi
1800044a6:     	popq	%rsi
1800044a7:     	popq	%rbp
1800044a8:     	popq	%rbx
1800044a9:     	retq
1800044aa:     	movq	0xa7cf(%rip), %rax      # 0x18000ec80
1800044b1:     	callq	*0x698(%rax)
1800044b7:     	movl	%eax, 0xa7cf(%rip)      # 0x18000ec8c
1800044bd:     	cmpl	$0x10, %eax
1800044c0:     	jge	0x1800044de <PyInit_rcaot_05cb37762ef1645705ed4668+0x120e>
1800044c2:     	movq	0x2de7(%rip), %rcx      # 0x1800072b0
1800044c9:     	leaq	0x3f70(%rip), %rdx      # 0x180008440
1800044d0:     	movl	%eax, %r9d
1800044d3:     	movl	$0x10, %r8d
1800044d9:     	movq	(%rcx), %rcx
1800044dc:     	jmp	0x180004471 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11a1>
1800044de:     	movq	0xa79b(%rip), %rax      # 0x18000ec80
1800044e5:     	callq	*0x690(%rax)
1800044eb:     	testl	%eax, %eax
1800044ed:     	jne	0x1800044fb <PyInit_rcaot_05cb37762ef1645705ed4668+0x122b>
1800044ef:     	leaq	0x409a(%rip), %rdx      # 0x180008590
1800044f6:     	jmp	0x180004430 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1160>
1800044fb:     	cmpl	$0x1, %eax
1800044fe:     	je	0x18000450c <PyInit_rcaot_05cb37762ef1645705ed4668+0x123c>
180004500:     	leaq	0x40b9(%rip), %rdx      # 0x1800085c0
180004507:     	jmp	0x180004430 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1160>
18000450c:     	leaq	0xa30d(%rip), %rcx      # 0x18000e820
180004513:     	callq	*0x2c6f(%rip)           # 0x180007188
180004519:     	testl	%eax, %eax
18000451b:     	jne	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
180004521:     	leaq	0x9e18(%rip), %rcx      # 0x18000e340
180004528:     	callq	*0x2c5a(%rip)           # 0x180007188
18000452e:     	testl	%eax, %eax
180004530:     	jne	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
180004536:     	leaq	0xa143(%rip), %rcx      # 0x18000e680
18000453d:     	callq	*0x2c45(%rip)           # 0x180007188
180004543:     	testl	%eax, %eax
180004545:     	jne	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
18000454b:     	xorl	%ebx, %ebx
18000454d:     	cmpl	%ebx, 0xa735(%rip)      # 0x18000ec88
180004553:     	jne	0x180004596 <PyInit_rcaot_05cb37762ef1645705ed4668+0x12c6>
180004555:     	movq	%gs:0x58, %rax
18000455e:     	movl	0xa73c(%rip), %ecx      # 0x18000eca0
180004564:     	movl	$0x1, 0xa71a(%rip)      # 0x18000ec88
18000456e:     	movq	(%rax,%rcx,8), %rdx
180004572:     	movl	$0x10, %eax
180004577:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000457e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180004583:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000458a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000458f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180004596:     	movl	%ebx, 0xa69c(%rip)      # 0x18000ec38
18000459c:     	movq	%rbx, %rax
18000459f:     	movb	%bl, 0xa69b(%rip)       # 0x18000ec40
1800045a5:     	movq	%rbx, %rcx
1800045a8:     	xchgq	%rax, 0xa699(%rip)      # 0x18000ec48
1800045af:     	xchgq	%rcx, 0xa69a(%rip)      # 0x18000ec50
1800045b6:     	movq	%rbx, %rax
1800045b9:     	movq	%rbx, %rcx
1800045bc:     	xchgq	%rax, 0xa695(%rip)      # 0x18000ec58
1800045c3:     	xchgq	%rcx, 0xa696(%rip)      # 0x18000ec60
1800045ca:     	movq	0x2a97(%rip), %rax      # 0x180007068
1800045d1:     	leaq	0x9f08(%rip), %rcx      # 0x18000e4e0
1800045d8:     	movq	%rax, 0xa689(%rip)      # 0x18000ec68
1800045df:     	movq	0x2a7a(%rip), %rax      # 0x180007060
1800045e6:     	movq	%rax, 0xa683(%rip)      # 0x18000ec70
1800045ed:     	movq	0x2a7c(%rip), %rax      # 0x180007070
1800045f4:     	movq	%rax, 0xa67d(%rip)      # 0x18000ec78
1800045fb:     	movq	0x2c5e(%rip), %rax      # 0x180007260
180004602:     	movq	%rax, 0xa00f(%rip)      # 0x18000e618
180004609:     	callq	*0x2b79(%rip)           # 0x180007188
18000460f:     	testl	%eax, %eax
180004611:     	jne	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
180004617:     	leaq	0x4112(%rip), %rdx      # 0x180008730
18000461e:     	movq	%r14, %rcx
180004621:     	callq	*0x2b59(%rip)           # 0x180007180
180004627:     	movq	%rax, 0x28(%rsp)
18000462c:     	movq	%rax, %rdi
18000462f:     	testq	%rax, %rax
180004632:     	je	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
180004638:     	leaq	0x428a(%rip), %rcx      # 0x1800088c9
18000463f:     	callq	*0x2c53(%rip)           # 0x180007298
180004645:     	movq	%rax, 0x20(%rsp)
18000464a:     	movq	%rax, %r12
18000464d:     	testq	%rax, %rax
180004650:     	je	0x180004994 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16c4>
180004656:     	movl	%ebx, %ebp
180004658:     	cmpq	%rbx, (%rsi)
18000465b:     	je	0x180004804 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1534>
180004661:     	movslq	%ebp, %rbx
180004664:     	leaq	0x30(%rsp), %rdx
180004669:     	movq	%r14, %rcx
18000466c:     	leaq	(%rbx,%rbx,4), %rax
180004670:     	movups	(%r13,%rax,8), %xmm0
180004676:     	movups	0x10(%r13,%rax,8), %xmm1
18000467c:     	movaps	%xmm0, 0x30(%rsp)
180004681:     	movsd	0x20(%r13,%rax,8), %xmm0
180004688:     	movsd	%xmm0, 0x50(%rsp)
18000468e:     	movaps	%xmm1, 0x40(%rsp)
180004693:     	callq	0x180004190 <PyInit_rcaot_05cb37762ef1645705ed4668+0xec0>
180004698:     	movq	%rax, %r14
18000469b:     	testq	%rax, %rax
18000469e:     	je	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
1800046a4:     	movq	(%rsi), %rcx
1800046a7:     	callq	*0x2beb(%rip)           # 0x180007298
1800046ad:     	movq	%rax, %r13
1800046b0:     	testq	%rax, %rax
1800046b3:     	je	0x1800049b7 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16e7>
1800046b9:     	movq	(%r15,%rbx,8), %rcx
1800046bd:     	xorl	%edx, %edx
1800046bf:     	movq	%r14, (%rcx)
1800046c2:     	leaq	0xa157(%rip), %rcx      # 0x18000e820
1800046c9:     	movq	0x8(%rsi), %r12
1800046cd:     	callq	*0x2a95(%rip)           # 0x180007168
1800046d3:     	movq	%rax, %rbx
1800046d6:     	testq	%rax, %rax
1800046d9:     	je	0x180004756 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1486>
1800046db:     	movq	%r13, %rcx
1800046de:     	callq	*0x2ab4(%rip)           # 0x180007198
1800046e4:     	movq	%rax, %rdi
1800046e7:     	testq	%rax, %rax
1800046ea:     	je	0x18000470c <PyInit_rcaot_05cb37762ef1645705ed4668+0x143c>
1800046ec:     	movq	%rax, %rcx
1800046ef:     	callq	0x180005f7d <numba_list_iter_next+0xebd>
1800046f4:     	leaq	0x1(%rax), %rcx
1800046f8:     	callq	*0x2b6a(%rip)           # 0x180007268
1800046fe:     	movq	%rax, %rsi
180004701:     	testq	%rax, %rax
180004704:     	jne	0x180004714 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1444>
180004706:     	callq	*0x2a4c(%rip)           # 0x180007158
18000470c:     	xorl	%eax, %eax
18000470e:     	movq	%rax, 0x20(%rbx)
180004712:     	jmp	0x180004745 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1475>
180004714:     	movq	%rdi, %rdx
180004717:     	movq	%rsi, %rcx
18000471a:     	callq	0x180005f77 <numba_list_iter_next+0xeb7>
18000471f:     	movq	0x20(%rsp), %rcx
180004724:     	movq	%rsi, 0x20(%rbx)
180004728:     	movq	%r12, 0x28(%rbx)
18000472c:     	movl	$0x3, 0x30(%rbx)
180004733:     	callq	0x180003c10 <PyInit_rcaot_05cb37762ef1645705ed4668+0x940>
180004738:     	movq	%rax, 0x38(%rbx)
18000473c:     	testq	%rax, %rax
18000473f:     	jne	0x1800048b0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15e0>
180004745:     	movl	(%rbx), %eax
180004747:     	testl	%eax, %eax
180004749:     	js	0x180004756 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1486>
18000474b:     	subl	$0x1, %eax
18000474e:     	movl	%eax, (%rbx)
180004750:     	je	0x1800048fd <PyInit_rcaot_05cb37762ef1645705ed4668+0x162d>
180004756:     	xorl	%edi, %edi
180004758:     	movl	(%r14), %eax
18000475b:     	testl	%eax, %eax
18000475d:     	js	0x180004770 <PyInit_rcaot_05cb37762ef1645705ed4668+0x14a0>
18000475f:     	subl	$0x1, %eax
180004762:     	movl	%eax, (%r14)
180004765:     	jne	0x180004770 <PyInit_rcaot_05cb37762ef1645705ed4668+0x14a0>
180004767:     	movq	%r14, %rcx
18000476a:     	callq	*0x2a70(%rip)           # 0x1800071e0
180004770:     	movl	(%r13), %eax
180004774:     	testl	%eax, %eax
180004776:     	js	0x18000478a <PyInit_rcaot_05cb37762ef1645705ed4668+0x14ba>
180004778:     	subl	$0x1, %eax
18000477b:     	movl	%eax, (%r13)
18000477f:     	jne	0x18000478a <PyInit_rcaot_05cb37762ef1645705ed4668+0x14ba>
180004781:     	movq	%r13, %rcx
180004784:     	callq	*0x2a56(%rip)           # 0x1800071e0
18000478a:     	testq	%rdi, %rdi
18000478d:     	je	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
180004793:     	movq	0xb8(%rsp), %rsi
18000479b:     	movq	%rdi, %r8
18000479e:     	movq	0xb0(%rsp), %r14
1800047a6:     	movq	%r14, %rcx
1800047a9:     	movq	(%rsi), %rdx
1800047ac:     	callq	*0x2a86(%rip)           # 0x180007238
1800047b2:     	movl	(%rdi), %ecx
1800047b4:     	testl	%eax, %eax
1800047b6:     	jne	0x18000495a <PyInit_rcaot_05cb37762ef1645705ed4668+0x168a>
1800047bc:     	testl	%ecx, %ecx
1800047be:     	js	0x1800047d2 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1502>
1800047c0:     	leal	-0x1(%rcx), %eax
1800047c3:     	movl	%eax, (%rdi)
1800047c5:     	testl	%eax, %eax
1800047c7:     	jne	0x1800047d2 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1502>
1800047c9:     	movq	%rdi, %rcx
1800047cc:     	callq	*0x2a0e(%rip)           # 0x1800071e0
1800047d2:     	movq	0xc8(%rsp), %r15
1800047da:     	addq	$0x20, %rsi
1800047de:     	movq	0xc0(%rsp), %r13
1800047e6:     	incl	%ebp
1800047e8:     	movq	%rsi, 0xb8(%rsp)
1800047f0:     	cmpq	$0x0, (%rsi)
1800047f4:     	jne	0x180004661 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1391>
1800047fa:     	movq	0x20(%rsp), %r12
1800047ff:     	movq	0x28(%rsp), %rdi
180004804:     	movslq	%ebp, %rax
180004807:     	cmpq	$0x0, (%r15,%rax,8)
18000480c:     	je	0x180004879 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15a9>
18000480e:     	nop
180004810:     	movslq	%ebp, %rbx
180004813:     	leaq	0x30(%rsp), %rdx
180004818:     	movq	%r14, %rcx
18000481b:     	leaq	(%rbx,%rbx,4), %rax
18000481f:     	movups	(%r13,%rax,8), %xmm0
180004825:     	movups	0x10(%r13,%rax,8), %xmm1
18000482b:     	movaps	%xmm0, 0x30(%rsp)
180004830:     	movsd	0x20(%r13,%rax,8), %xmm0
180004837:     	movsd	%xmm0, 0x50(%rsp)
18000483d:     	movaps	%xmm1, 0x40(%rsp)
180004842:     	callq	0x180004190 <PyInit_rcaot_05cb37762ef1645705ed4668+0xec0>
180004847:     	testq	%rax, %rax
18000484a:     	je	0x180004975 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a5>
180004850:     	movq	(%r15,%rbx,8), %rcx
180004854:     	movq	%rax, (%rcx)
180004857:     	movl	(%rax), %ecx
180004859:     	testl	%ecx, %ecx
18000485b:     	js	0x18000486d <PyInit_rcaot_05cb37762ef1645705ed4668+0x159d>
18000485d:     	subl	$0x1, %ecx
180004860:     	movl	%ecx, (%rax)
180004862:     	jne	0x18000486d <PyInit_rcaot_05cb37762ef1645705ed4668+0x159d>
180004864:     	movq	%rax, %rcx
180004867:     	callq	*0x2973(%rip)           # 0x1800071e0
18000486d:     	incl	%ebp
18000486f:     	movslq	%ebp, %rax
180004872:     	cmpq	$0x0, (%r15,%rax,8)
180004877:     	jne	0x180004810 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1540>
180004879:     	movl	(%r12), %eax
18000487d:     	testl	%eax, %eax
18000487f:     	js	0x180004893 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15c3>
180004881:     	subl	$0x1, %eax
180004884:     	movl	%eax, (%r12)
180004888:     	jne	0x180004893 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15c3>
18000488a:     	movq	%r12, %rcx
18000488d:     	callq	*0x294d(%rip)           # 0x1800071e0
180004893:     	movl	(%rdi), %eax
180004895:     	testl	%eax, %eax
180004897:     	js	0x1800048a9 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15d9>
180004899:     	subl	$0x1, %eax
18000489c:     	movl	%eax, (%rdi)
18000489e:     	jne	0x1800048a9 <PyInit_rcaot_05cb37762ef1645705ed4668+0x15d9>
1800048a0:     	movq	%rdi, %rcx
1800048a3:     	callq	*0x2937(%rip)           # 0x1800071e0
1800048a9:     	xorl	%eax, %eax
1800048ab:     	jmp	0x180004499 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c9>
1800048b0:     	movl	(%r14), %eax
1800048b3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800048b8:     	jae	0x1800048bf <PyInit_rcaot_05cb37762ef1645705ed4668+0x15ef>
1800048ba:     	incl	%eax
1800048bc:     	movl	%eax, (%r14)
1800048bf:     	movq	0xb0(%rsp), %rcx
1800048c7:     	leaq	0x3e62(%rip), %rdx      # 0x180008730
1800048ce:     	movq	%r14, 0x18(%rbx)
1800048d2:     	movq	$0x0, 0x40(%rbx)
1800048da:     	callq	*0x28a0(%rip)           # 0x180007180
1800048e0:     	movq	%rax, %rsi
1800048e3:     	testq	%rax, %rax
1800048e6:     	jne	0x18000490b <PyInit_rcaot_05cb37762ef1645705ed4668+0x163b>
1800048e8:     	movl	(%rbx), %eax
1800048ea:     	testl	%eax, %eax
1800048ec:     	js	0x180004756 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1486>
1800048f2:     	subl	$0x1, %eax
1800048f5:     	movl	%eax, (%rbx)
1800048f7:     	jne	0x180004756 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1486>
1800048fd:     	movq	%rbx, %rcx
180004900:     	callq	*0x28da(%rip)           # 0x1800071e0
180004906:     	jmp	0x180004756 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1486>
18000490b:     	xorl	%r9d, %r9d
18000490e:     	leaq	0x20(%rbx), %rcx
180004912:     	movq	%rsi, %r8
180004915:     	movq	%rbx, %rdx
180004918:     	callq	*0x2842(%rip)           # 0x180007160
18000491e:     	movq	%rax, %rdi
180004921:     	movl	(%rbx), %eax
180004923:     	testl	%eax, %eax
180004925:     	js	0x180004937 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1667>
180004927:     	subl	$0x1, %eax
18000492a:     	movl	%eax, (%rbx)
18000492c:     	jne	0x180004937 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1667>
18000492e:     	movq	%rbx, %rcx
180004931:     	callq	*0x28a9(%rip)           # 0x1800071e0
180004937:     	movl	(%rsi), %eax
180004939:     	testl	%eax, %eax
18000493b:     	js	0x180004758 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1488>
180004941:     	subl	$0x1, %eax
180004944:     	movl	%eax, (%rsi)
180004946:     	jne	0x180004758 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1488>
18000494c:     	movq	%rsi, %rcx
18000494f:     	callq	*0x288b(%rip)           # 0x1800071e0
180004955:     	jmp	0x180004758 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1488>
18000495a:     	testl	%ecx, %ecx
18000495c:     	js	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
18000495e:     	leal	-0x1(%rcx), %eax
180004961:     	movl	%eax, (%rdi)
180004963:     	testl	%eax, %eax
180004965:     	jne	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
180004967:     	movq	%rdi, %rcx
18000496a:     	callq	*0x2870(%rip)           # 0x1800071e0
180004970:     	movq	0x20(%rsp), %r12
180004975:     	movl	(%r12), %eax
180004979:     	testl	%eax, %eax
18000497b:     	js	0x18000498f <PyInit_rcaot_05cb37762ef1645705ed4668+0x16bf>
18000497d:     	subl	$0x1, %eax
180004980:     	movl	%eax, (%r12)
180004984:     	jne	0x18000498f <PyInit_rcaot_05cb37762ef1645705ed4668+0x16bf>
180004986:     	movq	%r12, %rcx
180004989:     	callq	*0x2851(%rip)           # 0x1800071e0
18000498f:     	movq	0x28(%rsp), %rdi
180004994:     	movl	(%rdi), %eax
180004996:     	testl	%eax, %eax
180004998:     	js	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
18000499e:     	subl	$0x1, %eax
1800049a1:     	movl	%eax, (%rdi)
1800049a3:     	jne	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
1800049a9:     	movq	%rdi, %rcx
1800049ac:     	callq	*0x282e(%rip)           # 0x1800071e0
1800049b2:     	jmp	0x180004494 <PyInit_rcaot_05cb37762ef1645705ed4668+0x11c4>
1800049b7:     	movl	(%r14), %eax
1800049ba:     	testl	%eax, %eax
1800049bc:     	js	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
1800049be:     	subl	$0x1, %eax
1800049c1:     	movl	%eax, (%r14)
1800049c4:     	jne	0x180004970 <PyInit_rcaot_05cb37762ef1645705ed4668+0x16a0>
1800049c6:     	movq	%r14, %rcx
1800049c9:     	jmp	0x18000496a <PyInit_rcaot_05cb37762ef1645705ed4668+0x169a>
1800049cb:     	int3
1800049cc:     	int3
1800049cd:     	int3
1800049ce:     	int3
1800049cf:     	int3
1800049d0:     	leaq	0xa431(%rip), %rax      # 0x18000ee08
1800049d7:     	retq
1800049d8:     	int3
1800049d9:     	int3
1800049da:     	int3
1800049db:     	int3
1800049dc:     	int3
1800049dd:     	int3
1800049de:     	int3
1800049df:     	int3

00000001800049e0 <numba_list_set_method_table>:
1800049e0:     	movups	(%rdx), %xmm0
1800049e3:     	movups	%xmm0, 0x20(%rcx)
1800049e7:     	retq
1800049e8:     	int3
1800049e9:     	int3
1800049ea:     	int3
1800049eb:     	int3
1800049ec:     	int3
1800049ed:     	int3
1800049ee:     	int3
1800049ef:     	int3

00000001800049f0 <numba_list_new>:
1800049f0:     	pushq	%rbx
1800049f2:     	pushq	%rbp
1800049f3:     	pushq	%rsi
1800049f4:     	pushq	%rdi
1800049f5:     	subq	$0x28, %rsp
1800049f9:     	movq	%rcx, %rsi
1800049fc:     	movq	%r8, %rdi
1800049ff:     	movl	$0x38, %ecx
180004a04:     	movq	%rdx, %rbp
180004a07:     	callq	*0x265b(%rip)           # 0x180007068
180004a0d:     	movq	%rax, %rbx
180004a10:     	testq	%rax, %rax
180004a13:     	je	0x180004a7d <numba_list_new+0x8d>
180004a15:     	movq	$0x0, (%rax)
180004a1c:     	xorps	%xmm0, %xmm0
180004a1f:     	movq	%rbp, 0x8(%rax)
180004a23:     	movq	%rdi, 0x10(%rax)
180004a27:     	movl	$0x1, 0x18(%rax)
180004a2e:     	movups	%xmm0, 0x20(%rax)
180004a32:     	testq	%rdi, %rdi
180004a35:     	je	0x180004a8b <numba_list_new+0x9b>
180004a37:     	imulq	%rbp, %rdi
180004a3b:     	movl	$0x8, %ecx
180004a40:     	movq	%rdi, %rax
180004a43:     	cqto
180004a45:     	andl	$0x7, %edx
180004a48:     	addq	%rdx, %rax
180004a4b:     	andl	$0x7, %eax
180004a4e:     	subq	%rdx, %rax
180004a51:     	subq	%rax, %rcx
180004a54:     	movq	%rcx, %rax
180004a57:     	cqto
180004a59:     	andl	$0x7, %edx
180004a5c:     	leaq	(%rdx,%rax), %rcx
180004a60:     	andl	$0x7, %ecx
180004a63:     	subq	%rdx, %rcx
180004a66:     	addq	%rdi, %rcx
180004a69:     	callq	*0x25f9(%rip)           # 0x180007068
180004a6f:     	testq	%rax, %rax
180004a72:     	jne	0x180004a8d <numba_list_new+0x9d>
180004a74:     	movq	%rbx, %rcx
180004a77:     	callq	*0x25f3(%rip)           # 0x180007070
180004a7d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180004a82:     	addq	$0x28, %rsp
180004a86:     	popq	%rdi
180004a87:     	popq	%rsi
180004a88:     	popq	%rbp
180004a89:     	popq	%rbx
180004a8a:     	retq
180004a8b:     	xorl	%eax, %eax
180004a8d:     	movq	%rax, 0x30(%rbx)
180004a91:     	xorl	%eax, %eax
180004a93:     	movq	%rbx, (%rsi)
180004a96:     	addq	$0x28, %rsp
180004a9a:     	popq	%rdi
180004a9b:     	popq	%rsi
180004a9c:     	popq	%rbp
180004a9d:     	popq	%rbx
180004a9e:     	retq
180004a9f:     	int3

0000000180004aa0 <numba_list_free>:
180004aa0:     	pushq	%rbx
180004aa2:     	subq	$0x20, %rsp
180004aa6:     	cmpq	$0x0, 0x28(%rcx)
180004aab:     	movq	%rcx, %rbx
180004aae:     	je	0x180004ae4 <numba_list_free+0x44>
180004ab0:     	movq	%rdi, 0x30(%rsp)
180004ab5:     	xorl	%edi, %edi
180004ab7:     	cmpq	%rdi, (%rcx)
180004aba:     	jle	0x180004adf <numba_list_free+0x3f>
180004abc:     	nopl	(%rax)
180004ac0:     	movq	0x28(%rbx), %rax
180004ac4:     	testq	%rax, %rax
180004ac7:     	je	0x180004ad7 <numba_list_free+0x37>
180004ac9:     	movq	%rdi, %rcx
180004acc:     	imulq	0x8(%rbx), %rcx
180004ad1:     	addq	0x30(%rbx), %rcx
180004ad5:     	callq	*%rax
180004ad7:     	incq	%rdi
180004ada:     	cmpq	(%rbx), %rdi
180004add:     	jl	0x180004ac0 <numba_list_free+0x20>
180004adf:     	movq	0x30(%rsp), %rdi
180004ae4:     	movq	0x30(%rbx), %rcx
180004ae8:     	testq	%rcx, %rcx
180004aeb:     	je	0x180004af3 <numba_list_free+0x53>
180004aed:     	callq	*0x257d(%rip)           # 0x180007070
180004af3:     	movq	%rbx, %rcx
180004af6:     	addq	$0x20, %rsp
180004afa:     	popq	%rbx
180004afb:     	jmpq	*0x256e(%rip)           # 0x180007070
180004b02:     	int3
180004b03:     	int3
180004b04:     	int3
180004b05:     	int3
180004b06:     	int3
180004b07:     	int3
180004b08:     	int3
180004b09:     	int3
180004b0a:     	int3
180004b0b:     	int3
180004b0c:     	int3
180004b0d:     	int3
180004b0e:     	int3
180004b0f:     	int3

0000000180004b10 <numba_list_base_ptr>:
180004b10:     	movq	0x30(%rcx), %rax
180004b14:     	retq
180004b15:     	int3
180004b16:     	int3
180004b17:     	int3
180004b18:     	int3
180004b19:     	int3
180004b1a:     	int3
180004b1b:     	int3
180004b1c:     	int3
180004b1d:     	int3
180004b1e:     	int3
180004b1f:     	int3

0000000180004b20 <numba_list_size_address>:
180004b20:     	movq	%rcx, %rax
180004b23:     	retq
180004b24:     	int3
180004b25:     	int3
180004b26:     	int3
180004b27:     	int3
180004b28:     	int3
180004b29:     	int3
180004b2a:     	int3
180004b2b:     	int3
180004b2c:     	int3
180004b2d:     	int3
180004b2e:     	int3
180004b2f:     	int3

0000000180004b30 <numba_list_length>:
180004b30:     	movq	(%rcx), %rax
180004b33:     	retq
180004b34:     	int3
180004b35:     	int3
180004b36:     	int3
180004b37:     	int3
180004b38:     	int3
180004b39:     	int3
180004b3a:     	int3
180004b3b:     	int3
180004b3c:     	int3
180004b3d:     	int3
180004b3e:     	int3
180004b3f:     	int3

0000000180004b40 <numba_list_allocated>:
180004b40:     	movq	0x10(%rcx), %rax
180004b44:     	retq
180004b45:     	int3
180004b46:     	int3
180004b47:     	int3
180004b48:     	int3
180004b49:     	int3
180004b4a:     	int3
180004b4b:     	int3
180004b4c:     	int3
180004b4d:     	int3
180004b4e:     	int3
180004b4f:     	int3

0000000180004b50 <numba_list_is_mutable>:
180004b50:     	movl	0x18(%rcx), %eax
180004b53:     	retq
180004b54:     	int3
180004b55:     	int3
180004b56:     	int3
180004b57:     	int3
180004b58:     	int3
180004b59:     	int3
180004b5a:     	int3
180004b5b:     	int3
180004b5c:     	int3
180004b5d:     	int3
180004b5e:     	int3
180004b5f:     	int3

0000000180004b60 <numba_list_set_is_mutable>:
180004b60:     	movl	%edx, 0x18(%rcx)
180004b63:     	retq
180004b64:     	int3
180004b65:     	int3
180004b66:     	int3
180004b67:     	int3
180004b68:     	int3
180004b69:     	int3
180004b6a:     	int3
180004b6b:     	int3
180004b6c:     	int3
180004b6d:     	int3
180004b6e:     	int3
180004b6f:     	int3

0000000180004b70 <numba_list_setitem>:
180004b70:     	movq	%rbx, 0x10(%rsp)
180004b75:     	pushq	%rsi
180004b76:     	subq	$0x20, %rsp
180004b7a:     	cmpl	$0x0, 0x18(%rcx)
180004b7e:     	movq	%r8, %rsi
180004b81:     	movq	%rcx, %rbx
180004b84:     	jne	0x180004b96 <numba_list_setitem+0x26>
180004b86:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180004b8b:     	movq	0x38(%rsp), %rbx
180004b90:     	addq	$0x20, %rsp
180004b94:     	popq	%rsi
180004b95:     	retq
180004b96:     	cmpq	(%rcx), %rdx
180004b99:     	jb	0x180004bab <numba_list_setitem+0x3b>
180004b9b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180004ba0:     	movq	0x38(%rsp), %rbx
180004ba5:     	addq	$0x20, %rsp
180004ba9:     	popq	%rsi
180004baa:     	retq
180004bab:     	imulq	0x8(%rcx), %rdx
180004bb0:     	movq	0x28(%rcx), %rax
180004bb4:     	movq	%rdi, 0x30(%rsp)
180004bb9:     	movq	0x30(%rcx), %rdi
180004bbd:     	addq	%rdx, %rdi
180004bc0:     	testq	%rax, %rax
180004bc3:     	je	0x180004bca <numba_list_setitem+0x5a>
180004bc5:     	movq	%rdi, %rcx
180004bc8:     	callq	*%rax
180004bca:     	movq	0x8(%rbx), %r8
180004bce:     	movq	%rsi, %rdx
180004bd1:     	movq	%rdi, %rcx
180004bd4:     	callq	0x180005f6b <numba_list_iter_next+0xeab>
180004bd9:     	movq	0x20(%rbx), %rax
180004bdd:     	testq	%rax, %rax
180004be0:     	je	0x180004be7 <numba_list_setitem+0x77>
180004be2:     	movq	%rdi, %rcx
180004be5:     	callq	*%rax
180004be7:     	movq	0x30(%rsp), %rdi
180004bec:     	xorl	%eax, %eax
180004bee:     	movq	0x38(%rsp), %rbx
180004bf3:     	addq	$0x20, %rsp
180004bf7:     	popq	%rsi
180004bf8:     	retq
180004bf9:     	int3
180004bfa:     	int3
180004bfb:     	int3
180004bfc:     	int3
180004bfd:     	int3
180004bfe:     	int3
180004bff:     	int3

0000000180004c00 <numba_list_getitem>:
180004c00:     	subq	$0x28, %rsp
180004c04:     	movq	%r8, %r9
180004c07:     	movq	%rdx, %rax
180004c0a:     	cmpq	(%rcx), %rdx
180004c0d:     	jb	0x180004c19 <numba_list_getitem+0x19>
180004c0f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180004c14:     	addq	$0x28, %rsp
180004c18:     	retq
180004c19:     	movq	0x8(%rcx), %r8
180004c1d:     	movq	%r8, %rdx
180004c20:     	imulq	%rax, %rdx
180004c24:     	addq	0x30(%rcx), %rdx
180004c28:     	movq	%r9, %rcx
180004c2b:     	callq	0x180005f6b <numba_list_iter_next+0xeab>
180004c30:     	xorl	%eax, %eax
180004c32:     	addq	$0x28, %rsp
180004c36:     	retq
180004c37:     	int3
180004c38:     	int3
180004c39:     	int3
180004c3a:     	int3
180004c3b:     	int3
180004c3c:     	int3
180004c3d:     	int3
180004c3e:     	int3
180004c3f:     	int3

0000000180004c40 <numba_list_append>:
180004c40:     	movq	%rbx, 0x10(%rsp)
180004c45:     	pushq	%rsi
180004c46:     	subq	$0x20, %rsp
180004c4a:     	cmpl	$0x0, 0x18(%rcx)
180004c4e:     	movq	%rdx, %rsi
180004c51:     	movq	%rcx, %rbx
180004c54:     	jne	0x180004c66 <numba_list_append+0x26>
180004c56:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180004c5b:     	movq	0x38(%rsp), %rbx
180004c60:     	addq	$0x20, %rsp
180004c64:     	popq	%rsi
180004c65:     	retq
180004c66:     	movq	(%rcx), %rdx
180004c69:     	incq	%rdx
180004c6c:     	callq	0x180004cc0 <numba_list_resize>
180004c71:     	testl	%eax, %eax
180004c73:     	js	0x180004cac <numba_list_append+0x6c>
180004c75:     	movq	0x8(%rbx), %r8
180004c79:     	movq	%rsi, %rdx
180004c7c:     	movq	%rdi, 0x30(%rsp)
180004c81:     	movq	(%rbx), %rdi
180004c84:     	decq	%rdi
180004c87:     	imulq	%r8, %rdi
180004c8b:     	addq	0x30(%rbx), %rdi
180004c8f:     	movq	%rdi, %rcx
180004c92:     	callq	0x180005f6b <numba_list_iter_next+0xeab>
180004c97:     	movq	0x20(%rbx), %rax
180004c9b:     	testq	%rax, %rax
180004c9e:     	je	0x180004ca5 <numba_list_append+0x65>
180004ca0:     	movq	%rdi, %rcx
180004ca3:     	callq	*%rax
180004ca5:     	movq	0x30(%rsp), %rdi
180004caa:     	xorl	%eax, %eax
180004cac:     	movq	0x38(%rsp), %rbx
180004cb1:     	addq	$0x20, %rsp
180004cb5:     	popq	%rsi
180004cb6:     	retq
180004cb7:     	int3
180004cb8:     	int3
180004cb9:     	int3
180004cba:     	int3
180004cbb:     	int3
180004cbc:     	int3
180004cbd:     	int3
180004cbe:     	int3
180004cbf:     	int3

0000000180004cc0 <numba_list_resize>:
180004cc0:     	movq	%rsi, 0x18(%rsp)
180004cc5:     	pushq	%rdi
180004cc6:     	subq	$0x20, %rsp
180004cca:     	cmpl	$0x0, 0x18(%rcx)
180004cce:     	movq	%rdx, %rsi
180004cd1:     	movq	%rcx, %rdi
180004cd4:     	jne	0x180004ce6 <numba_list_resize+0x26>
180004cd6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180004cdb:     	movq	0x40(%rsp), %rsi
180004ce0:     	addq	$0x20, %rsp
180004ce4:     	popq	%rdi
180004ce5:     	retq
180004ce6:     	movq	0x10(%rcx), %rax
180004cea:     	cmpq	%rsi, %rax
180004ced:     	jl	0x180004d07 <numba_list_resize+0x47>
180004cef:     	sarq	%rax
180004cf2:     	cmpq	%rax, %rsi
180004cf5:     	jl	0x180004d07 <numba_list_resize+0x47>
180004cf7:     	movq	%rsi, (%rcx)
180004cfa:     	xorl	%eax, %eax
180004cfc:     	movq	0x40(%rsp), %rsi
180004d01:     	addq	$0x20, %rsp
180004d05:     	popq	%rdi
180004d06:     	retq
180004d07:     	cmpq	$0x9, %rsi
180004d0b:     	movq	%rbp, 0x38(%rsp)
180004d10:     	movl	$0x3, %ecx
180004d15:     	movl	$0x6, %eax
180004d1a:     	cmovll	%ecx, %eax
180004d1d:     	movq	%rsi, %r8
180004d20:     	movq	0x8(%rdi), %rcx
180004d24:     	addq	%rsi, %rax
180004d27:     	sarq	$0x3, %r8
180004d2b:     	xorl	%edx, %edx
180004d2d:     	addq	%rax, %r8
180004d30:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180004d3a:     	divq	%rcx
180004d3d:     	cmpq	%rax, %r8
180004d40:     	ja	0x180004dbb <numba_list_resize+0xfb>
180004d42:     	xorl	%ebp, %ebp
180004d44:     	movq	%rbx, 0x30(%rsp)
180004d49:     	testq	%rsi, %rsi
180004d4c:     	cmovneq	%r8, %rbp
180004d50:     	movq	%rbp, %rbx
180004d53:     	imulq	%rcx, %rbx
180004d57:     	movl	$0x8, %ecx
180004d5c:     	movq	%rbx, %rax
180004d5f:     	cqto
180004d61:     	andl	$0x7, %edx
180004d64:     	addq	%rdx, %rax
180004d67:     	andl	$0x7, %eax
180004d6a:     	subq	%rdx, %rax
180004d6d:     	subq	%rax, %rcx
180004d70:     	movq	%rcx, %rax
180004d73:     	movq	0x30(%rdi), %rcx
180004d77:     	cqto
180004d79:     	andl	$0x7, %edx
180004d7c:     	addq	%rdx, %rax
180004d7f:     	andl	$0x7, %eax
180004d82:     	subq	%rdx, %rax
180004d85:     	leaq	(%rbx,%rax), %rdx
180004d89:     	callq	*0x22d1(%rip)           # 0x180007060
180004d8f:     	testq	%rbx, %rbx
180004d92:     	movq	0x30(%rsp), %rbx
180004d97:     	je	0x180004d9e <numba_list_resize+0xde>
180004d99:     	testq	%rax, %rax
180004d9c:     	je	0x180004dbb <numba_list_resize+0xfb>
180004d9e:     	movq	%rax, 0x30(%rdi)
180004da2:     	xorl	%eax, %eax
180004da4:     	movq	%rbp, 0x10(%rdi)
180004da8:     	movq	0x38(%rsp), %rbp
180004dad:     	movq	%rsi, (%rdi)
180004db0:     	movq	0x40(%rsp), %rsi
180004db5:     	addq	$0x20, %rsp
180004db9:     	popq	%rdi
180004dba:     	retq
180004dbb:     	movq	0x38(%rsp), %rbp
180004dc0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180004dc5:     	movq	0x40(%rsp), %rsi
180004dca:     	addq	$0x20, %rsp
180004dce:     	popq	%rdi
180004dcf:     	retq

0000000180004dd0 <numba_list_delitem>:
180004dd0:     	movq	%rbx, 0x10(%rsp)
180004dd5:     	pushq	%rdi
180004dd6:     	subq	$0x20, %rsp
180004dda:     	cmpl	$0x0, 0x18(%rcx)
180004dde:     	movq	%rdx, %rdi
180004de1:     	movq	%rcx, %rbx
180004de4:     	jne	0x180004df6 <numba_list_delitem+0x26>
180004de6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180004deb:     	movq	0x38(%rsp), %rbx
180004df0:     	addq	$0x20, %rsp
180004df4:     	popq	%rdi
180004df5:     	retq
180004df6:     	cmpq	(%rcx), %rdi
180004df9:     	jb	0x180004e0b <numba_list_delitem+0x3b>
180004dfb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180004e00:     	movq	0x38(%rsp), %rbx
180004e05:     	addq	$0x20, %rsp
180004e09:     	popq	%rdi
180004e0a:     	retq
180004e0b:     	movq	0x28(%rcx), %rax
180004e0f:     	movq	%rsi, 0x30(%rsp)
180004e14:     	movq	%rdi, %rsi
180004e17:     	imulq	0x8(%rcx), %rsi
180004e1c:     	addq	0x30(%rcx), %rsi
180004e20:     	testq	%rax, %rax
180004e23:     	je	0x180004e2a <numba_list_delitem+0x5a>
180004e25:     	movq	%rsi, %rcx
180004e28:     	callq	*%rax
180004e2a:     	movq	(%rbx), %r8
180004e2d:     	leaq	-0x1(%r8), %rax
180004e31:     	cmpq	%rax, %rdi
180004e34:     	je	0x180004e56 <numba_list_delitem+0x86>
180004e36:     	subq	%rdi, %r8
180004e39:     	leaq	0x1(%rdi), %rdx
180004e3d:     	imulq	0x8(%rbx), %rdx
180004e42:     	decq	%r8
180004e45:     	movq	%rsi, %rcx
180004e48:     	imulq	0x8(%rbx), %r8
180004e4d:     	addq	0x30(%rbx), %rdx
180004e51:     	callq	0x180005f71 <numba_list_iter_next+0xeb1>
180004e56:     	movq	(%rbx), %rdx
180004e59:     	movq	%rbx, %rcx
180004e5c:     	decq	%rdx
180004e5f:     	callq	0x180004cc0 <numba_list_resize>
180004e64:     	movq	0x30(%rsp), %rsi
180004e69:     	xorl	%ecx, %ecx
180004e6b:     	movq	0x38(%rsp), %rbx
180004e70:     	testl	%eax, %eax
180004e72:     	cmovsl	%eax, %ecx
180004e75:     	movl	%ecx, %eax
180004e77:     	addq	$0x20, %rsp
180004e7b:     	popq	%rdi
180004e7c:     	retq
180004e7d:     	int3
180004e7e:     	int3
180004e7f:     	int3

0000000180004e80 <numba_list_delete_slice>:
180004e80:     	pushq	%rbx
180004e82:     	pushq	%rbp
180004e83:     	pushq	%rdi
180004e84:     	pushq	%r15
180004e86:     	subq	$0x38, %rsp
180004e8a:     	cmpl	$0x0, 0x18(%rcx)
180004e8e:     	movq	%r9, %rdi
180004e91:     	movq	%r8, %rbp
180004e94:     	movq	%rdx, %r15
180004e97:     	movq	%rcx, %rbx
180004e9a:     	jne	0x180004eab <numba_list_delete_slice+0x2b>
180004e9c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180004ea1:     	addq	$0x38, %rsp
180004ea5:     	popq	%r15
180004ea7:     	popq	%rdi
180004ea8:     	popq	%rbp
180004ea9:     	popq	%rbx
180004eaa:     	retq
180004eab:     	movq	%r13, 0x78(%rsp)
180004eb0:     	testq	%rdi, %rdi
180004eb3:     	jle	0x180004ed2 <numba_list_delete_slice+0x52>
180004eb5:     	cmpq	%r8, %r15
180004eb8:     	jge	0x180005071 <numba_list_delete_slice+0x1f1>
180004ebe:     	movq	%r8, %rax
180004ec1:     	subq	%r15, %rax
180004ec4:     	decq	%rax
180004ec7:     	cqto
180004ec9:     	idivq	%rdi
180004ecc:     	leal	0x1(%rax), %r13d
180004ed0:     	jmp	0x180004ef2 <numba_list_delete_slice+0x72>
180004ed2:     	cmpq	%r15, %r8
180004ed5:     	jge	0x180005071 <numba_list_delete_slice+0x1f1>
180004edb:     	movq	%r15, %rax
180004ede:     	movl	$0x1, %r13d
180004ee4:     	subq	%r8, %rax
180004ee7:     	decq	%rax
180004eea:     	cqto
180004eec:     	idivq	%rdi
180004eef:     	subl	%eax, %r13d
180004ef2:     	testl	%r13d, %r13d
180004ef5:     	jle	0x180005071 <numba_list_delete_slice+0x1f1>
180004efb:     	movq	%rsi, 0x68(%rsp)
180004f00:     	movl	(%rcx), %esi
180004f02:     	subl	%r13d, %esi
180004f05:     	movl	%esi, 0x20(%rsp)
180004f09:     	testq	%rdi, %rdi
180004f0c:     	jns	0x180004f27 <numba_list_delete_slice+0xa7>
180004f0e:     	leaq	0x1(%r15), %rbp
180004f12:     	leal	-0x1(%r13), %eax
180004f16:     	movslq	%eax, %rcx
180004f19:     	leaq	-0x1(%rbp), %r15
180004f1d:     	imulq	%rdi, %rcx
180004f21:     	addq	%rcx, %r15
180004f24:     	negq	%rdi
180004f27:     	cmpq	$0x1, %rdi
180004f2b:     	jne	0x180004f77 <numba_list_delete_slice+0xf7>
180004f2d:     	cmpq	$0x0, 0x28(%rbx)
180004f32:     	je	0x180004f59 <numba_list_delete_slice+0xd9>
180004f34:     	movslq	%r15d, %rdi
180004f37:     	cmpq	%rbp, %rdi
180004f3a:     	jge	0x180004f59 <numba_list_delete_slice+0xd9>
180004f3c:     	nopl	(%rax)
180004f40:     	movslq	%edi, %rcx
180004f43:     	imulq	0x8(%rbx), %rcx
180004f48:     	addq	0x30(%rbx), %rcx
180004f4c:     	callq	*0x28(%rbx)
180004f4f:     	incl	%edi
180004f51:     	movslq	%edi, %rax
180004f54:     	cmpq	%rbp, %rax
180004f57:     	jl	0x180004f40 <numba_list_delete_slice+0xc0>
180004f59:     	movq	0x8(%rbx), %rcx
180004f5d:     	movq	(%rbx), %r8
180004f60:     	movq	%rcx, %rdx
180004f63:     	subq	%rbp, %r8
180004f66:     	imulq	%rcx, %r8
180004f6a:     	imulq	%rbp, %rdx
180004f6e:     	imulq	%r15, %rcx
180004f72:     	jmp	0x18000503c <numba_list_delete_slice+0x1bc>
180004f77:     	movq	%r14, 0x30(%rsp)
180004f7c:     	movq	%r15, %r14
180004f7f:     	movl	$0x0, 0x60(%rsp)
180004f87:     	cmpq	%rbp, %r15
180004f8a:     	jge	0x180005009 <numba_list_delete_slice+0x189>
180004f8c:     	movq	%r12, 0x70(%rsp)
180004f91:     	movq	(%rbx), %rax
180004f94:     	leaq	(%r14,%rdi), %r12
180004f98:     	cmpq	%rax, %r12
180004f9b:     	jl	0x180004fa8 <numba_list_delete_slice+0x128>
180004f9d:     	movq	%r14, %rsi
180004fa0:     	notq	%rsi
180004fa3:     	addq	%rax, %rsi
180004fa6:     	jmp	0x180004fac <numba_list_delete_slice+0x12c>
180004fa8:     	leaq	-0x1(%rdi), %rsi
180004fac:     	movq	0x28(%rbx), %rax
180004fb0:     	testq	%rax, %rax
180004fb3:     	je	0x180004fc3 <numba_list_delete_slice+0x143>
180004fb5:     	movq	%r14, %rcx
180004fb8:     	imulq	0x8(%rbx), %rcx
180004fbd:     	addq	0x30(%rbx), %rcx
180004fc1:     	callq	*%rax
180004fc3:     	movq	0x8(%rbx), %r9
180004fc7:     	leaq	0x1(%r14), %rdx
180004fcb:     	movq	0x30(%rbx), %r10
180004fcf:     	movq	%r9, %r8
180004fd2:     	imulq	%rsi, %r8
180004fd6:     	imulq	%r9, %rdx
180004fda:     	movslq	0x60(%rsp), %rsi
180004fdf:     	subq	%rsi, %r14
180004fe2:     	imulq	%r9, %r14
180004fe6:     	addq	%r10, %rdx
180004fe9:     	leaq	(%r10,%r14), %rcx
180004fed:     	callq	0x180005f71 <numba_list_iter_next+0xeb1>
180004ff2:     	incl	%esi
180004ff4:     	movq	%r12, %r14
180004ff7:     	movl	%esi, 0x60(%rsp)
180004ffb:     	cmpq	%rbp, %r12
180004ffe:     	jl	0x180004f91 <numba_list_delete_slice+0x111>
180005000:     	movq	0x70(%rsp), %r12
180005005:     	movl	0x20(%rsp), %esi
180005009:     	movq	(%rbx), %r8
18000500c:     	movq	0x30(%rsp), %r14
180005011:     	movslq	%r13d, %r10
180005014:     	movq	%r10, %rcx
180005017:     	imulq	%rdi, %rcx
18000501b:     	addq	%r15, %rcx
18000501e:     	cmpq	%r8, %rcx
180005021:     	jge	0x180005049 <numba_list_delete_slice+0x1c9>
180005023:     	movq	0x8(%rbx), %rax
180005027:     	subq	%rcx, %r8
18000502a:     	movq	%rax, %rdx
18000502d:     	imulq	%rcx, %rdx
180005031:     	imulq	%rax, %r8
180005035:     	subq	%r10, %rcx
180005038:     	imulq	%rax, %rcx
18000503c:     	addq	0x30(%rbx), %rdx
180005040:     	addq	0x30(%rbx), %rcx
180005044:     	callq	0x180005f71 <numba_list_iter_next+0xeb1>
180005049:     	movslq	%esi, %rdx
18000504c:     	movq	%rbx, %rcx
18000504f:     	callq	0x180004cc0 <numba_list_resize>
180005054:     	movq	0x68(%rsp), %rsi
180005059:     	xorl	%ecx, %ecx
18000505b:     	movq	0x78(%rsp), %r13
180005060:     	testl	%eax, %eax
180005062:     	cmovsl	%eax, %ecx
180005065:     	movl	%ecx, %eax
180005067:     	addq	$0x38, %rsp
18000506b:     	popq	%r15
18000506d:     	popq	%rdi
18000506e:     	popq	%rbp
18000506f:     	popq	%rbx
180005070:     	retq
180005071:     	movq	0x78(%rsp), %r13
180005076:     	xorl	%eax, %eax
180005078:     	addq	$0x38, %rsp
18000507c:     	popq	%r15
18000507e:     	popq	%rdi
18000507f:     	popq	%rbp
180005080:     	popq	%rbx
180005081:     	retq
180005082:     	int3
180005083:     	int3
180005084:     	int3
180005085:     	int3
180005086:     	int3
180005087:     	int3
180005088:     	int3
180005089:     	int3
18000508a:     	int3
18000508b:     	int3
18000508c:     	int3
18000508d:     	int3
18000508e:     	int3
18000508f:     	int3

0000000180005090 <numba_list_iter_sizeof>:
180005090:     	movl	$0x18, %eax
180005095:     	retq
180005096:     	int3
180005097:     	int3
180005098:     	int3
180005099:     	int3
18000509a:     	int3
18000509b:     	int3
18000509c:     	int3
18000509d:     	int3
18000509e:     	int3
18000509f:     	int3

00000001800050a0 <numba_list_iter>:
1800050a0:     	movq	%rdx, (%rcx)
1800050a3:     	movq	(%rdx), %rax
1800050a6:     	movq	%rax, 0x8(%rcx)
1800050aa:     	movq	$0x0, 0x10(%rcx)
1800050b2:     	retq
1800050b3:     	int3
1800050b4:     	int3
1800050b5:     	int3
1800050b6:     	int3
1800050b7:     	int3
1800050b8:     	int3
1800050b9:     	int3
1800050ba:     	int3
1800050bb:     	int3
1800050bc:     	int3
1800050bd:     	int3
1800050be:     	int3
1800050bf:     	int3

00000001800050c0 <numba_list_iter_next>:
1800050c0:     	movq	(%rcx), %r8
1800050c3:     	movq	(%r8), %r9
1800050c6:     	cmpq	0x8(%rcx), %r9
1800050ca:     	je	0x1800050d2 <numba_list_iter_next+0x12>
1800050cc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
1800050d1:     	retq
1800050d2:     	movq	0x10(%rcx), %rax
1800050d6:     	cmpq	%r9, %rax
1800050d9:     	jge	0x1800050ee <numba_list_iter_next+0x2e>
1800050db:     	imulq	0x8(%r8), %rax
1800050e0:     	addq	0x30(%r8), %rax
1800050e4:     	movq	%rax, (%rdx)
1800050e7:     	incq	0x10(%rcx)
1800050eb:     	xorl	%eax, %eax
1800050ed:     	retq
1800050ee:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
1800050f3:     	retq
1800050f4:     	int3
1800050f5:     	int3
1800050f6:     	int3
1800050f7:     	int3
1800050f8:     	int3
1800050f9:     	int3
1800050fa:     	int3
1800050fb:     	int3
1800050fc:     	int3
1800050fd:     	int3
1800050fe:     	int3
1800050ff:     	int3
180005100:     	pushq	%rbx
180005102:     	subq	$0x20, %rsp
180005106:     	movq	%rcx, %rbx
180005109:     	addq	$0x30, %rcx
18000510d:     	callq	*0x9b55(%rip)           # 0x18000ec68
180005113:     	cmpb	$0x0, 0x9b26(%rip)      # 0x18000ec40
18000511a:     	je	0x180005124 <numba_list_iter_next+0x64>
18000511c:     	lock
18000511d:     	incq	0x9b24(%rip)            # 0x18000ec48
180005124:     	testq	%rax, %rax
180005127:     	je	0x180005168 <numba_list_iter_next+0xa8>
180005129:     	leaq	0x30(%rax), %rdx
18000512d:     	testq	%rdx, %rdx
180005130:     	je	0x180005168 <numba_list_iter_next+0xa8>
180005132:     	xorl	%r8d, %r8d
180005135:     	movl	$0x1, %ecx
18000513a:     	xchgq	%rcx, (%rax)
18000513d:     	movq	%r8, 0x8(%rax)
180005141:     	movq	%r8, 0x10(%rax)
180005145:     	movq	%rdx, 0x18(%rax)
180005149:     	movq	%rbx, 0x20(%rax)
18000514d:     	movq	%r8, 0x28(%rax)
180005151:     	cmpb	%r8b, 0x9ae8(%rip)      # 0x18000ec40
180005158:     	je	0x18000516a <numba_list_iter_next+0xaa>
18000515a:     	lock
18000515b:     	incq	0x9af6(%rip)            # 0x18000ec58
180005162:     	addq	$0x20, %rsp
180005166:     	popq	%rbx
180005167:     	retq
180005168:     	xorl	%eax, %eax
18000516a:     	addq	$0x20, %rsp
18000516e:     	popq	%rbx
18000516f:     	retq
180005170:     	movq	%rbx, 0x8(%rsp)
180005175:     	pushq	%rdi
180005176:     	subq	$0x20, %rsp
18000517a:     	movq	%rcx, %rdi
18000517d:     	movq	%rdx, %rbx
180005180:     	addq	$0x30, %rcx
180005184:     	testq	%rdx, %rdx
180005187:     	je	0x180005191 <numba_list_iter_next+0xd1>
180005189:     	movq	0x18(%rdx), %rdx
18000518d:     	callq	*(%rbx)
18000518f:     	jmp	0x180005197 <numba_list_iter_next+0xd7>
180005191:     	callq	*0x9ad1(%rip)           # 0x18000ec68
180005197:     	cmpb	$0x0, 0x9aa2(%rip)      # 0x18000ec40
18000519e:     	movq	%rax, %r8
1800051a1:     	je	0x1800051ab <numba_list_iter_next+0xeb>
1800051a3:     	lock
1800051a4:     	incq	0x9a9d(%rip)            # 0x18000ec48
1800051ab:     	xorl	%edx, %edx
1800051ad:     	leaq	0x30(%r8), %rax
1800051b1:     	testq	%r8, %r8
1800051b4:     	movl	%edx, %ecx
1800051b6:     	cmovneq	%rax, %rcx
1800051ba:     	testq	%rcx, %rcx
1800051bd:     	jne	0x1800051cc <numba_list_iter_next+0x10c>
1800051bf:     	xorl	%eax, %eax
1800051c1:     	movq	0x30(%rsp), %rbx
1800051c6:     	addq	$0x20, %rsp
1800051ca:     	popq	%rdi
1800051cb:     	retq
1800051cc:     	movl	$0x1, %eax
1800051d1:     	xchgq	%rax, (%r8)
1800051d4:     	movq	%rdx, 0x8(%r8)
1800051d8:     	movq	%rdx, 0x10(%r8)
1800051dc:     	movq	%rcx, 0x18(%r8)
1800051e0:     	movq	%rdi, 0x20(%r8)
1800051e4:     	movq	%rbx, 0x28(%r8)
1800051e8:     	cmpb	%dl, 0x9a52(%rip)       # 0x18000ec40
1800051ee:     	je	0x1800051f8 <numba_list_iter_next+0x138>
1800051f0:     	lock
1800051f1:     	incq	0x9a60(%rip)            # 0x18000ec58
1800051f8:     	movq	0x30(%rsp), %rbx
1800051fd:     	movq	%r8, %rax
180005200:     	addq	$0x20, %rsp
180005204:     	popq	%rdi
180005205:     	retq
180005206:     	int3
180005207:     	int3
180005208:     	int3
180005209:     	int3
18000520a:     	int3
18000520b:     	int3
18000520c:     	int3
18000520d:     	int3
18000520e:     	int3
18000520f:     	int3
180005210:     	lock
180005211:     	incq	(%rcx)
180005214:     	retq
180005215:     	int3
180005216:     	int3
180005217:     	int3
180005218:     	int3
180005219:     	int3
18000521a:     	int3
18000521b:     	int3
18000521c:     	int3
18000521d:     	int3
18000521e:     	int3
18000521f:     	int3
180005220:     	pushq	%rbx
180005222:     	subq	$0x20, %rsp
180005226:     	movq	0x8(%rcx), %rax
18000522a:     	movq	%rcx, %rbx
18000522d:     	testq	%rax, %rax
180005230:     	je	0x180005249 <numba_list_iter_next+0x189>
180005232:     	cmpl	$0x0, 0x99ff(%rip)      # 0x18000ec38
180005239:     	jne	0x180005249 <numba_list_iter_next+0x189>
18000523b:     	movq	0x10(%rcx), %r8
18000523f:     	movq	0x20(%rcx), %rdx
180005243:     	movq	0x18(%rcx), %rcx
180005247:     	callq	*%rax
180005249:     	movq	0x28(%rbx), %rax
18000524d:     	movq	%rbx, %rcx
180005250:     	testq	%rax, %rax
180005253:     	je	0x18000525e <numba_list_iter_next+0x19e>
180005255:     	movq	0x18(%rax), %rdx
180005259:     	callq	*0x10(%rax)
18000525c:     	jmp	0x180005264 <numba_list_iter_next+0x1a4>
18000525e:     	callq	*0x9a14(%rip)           # 0x18000ec78
180005264:     	cmpb	$0x0, 0x99d5(%rip)      # 0x18000ec40
18000526b:     	je	0x180005289 <numba_list_iter_next+0x1c9>
18000526d:     	leaq	0x99dc(%rip), %rax      # 0x18000ec50
180005274:     	lock
180005275:     	incq	(%rax)
180005278:     	cmpb	$0x0, 0x99c1(%rip)      # 0x18000ec40
18000527f:     	je	0x180005289 <numba_list_iter_next+0x1c9>
180005281:     	lock
180005282:     	incq	0x99d7(%rip)            # 0x18000ec60
180005289:     	addq	$0x20, %rsp
18000528d:     	popq	%rbx
18000528e:     	retq
18000528f:     	int3
180005290:     	pushq	%rbx
180005292:     	subq	$0x20, %rsp
180005296:     	movq	%rcx, %rbx
180005299:     	movq	$-0x1, %rax
1800052a0:     	lock
1800052a1:     	xaddq	%rax, (%rcx)
1800052a5:     	cmpq	$0x1, %rax
1800052a9:     	jne	0x18000530b <numba_list_iter_next+0x24b>
1800052ab:     	movq	0x8(%rcx), %rax
1800052af:     	testq	%rax, %rax
1800052b2:     	je	0x1800052cb <numba_list_iter_next+0x20b>
1800052b4:     	cmpl	$0x0, 0x997d(%rip)      # 0x18000ec38
1800052bb:     	jne	0x1800052cb <numba_list_iter_next+0x20b>
1800052bd:     	movq	0x10(%rcx), %r8
1800052c1:     	movq	0x20(%rcx), %rdx
1800052c5:     	movq	0x18(%rcx), %rcx
1800052c9:     	callq	*%rax
1800052cb:     	movq	0x28(%rbx), %rax
1800052cf:     	movq	%rbx, %rcx
1800052d2:     	testq	%rax, %rax
1800052d5:     	je	0x1800052e0 <numba_list_iter_next+0x220>
1800052d7:     	movq	0x18(%rax), %rdx
1800052db:     	callq	*0x10(%rax)
1800052de:     	jmp	0x1800052e6 <numba_list_iter_next+0x226>
1800052e0:     	callq	*0x9992(%rip)           # 0x18000ec78
1800052e6:     	cmpb	$0x0, 0x9953(%rip)      # 0x18000ec40
1800052ed:     	je	0x18000530b <numba_list_iter_next+0x24b>
1800052ef:     	leaq	0x995a(%rip), %rax      # 0x18000ec50
1800052f6:     	lock
1800052f7:     	incq	(%rax)
1800052fa:     	cmpb	$0x0, 0x993f(%rip)      # 0x18000ec40
180005301:     	je	0x18000530b <numba_list_iter_next+0x24b>
180005303:     	lock
180005304:     	incq	0x9955(%rip)            # 0x18000ec60
18000530b:     	addq	$0x20, %rsp
18000530f:     	popq	%rbx
180005310:     	retq
180005311:     	int3
180005312:     	int3
180005313:     	int3
180005314:     	int3
180005315:     	int3
180005316:     	int3
180005317:     	int3
180005318:     	int3
180005319:     	int3
18000531a:     	int3
18000531b:     	int3
18000531c:     	int3
18000531d:     	int3
18000531e:     	int3
18000531f:     	int3
180005320:     	movq	0x18(%rcx), %rax
180005324:     	retq
180005325:     	int3
180005326:     	int3
180005327:     	int3
180005328:     	int3
180005329:     	int3
18000532a:     	int3
18000532b:     	int3
18000532c:     	int3
18000532d:     	int3
18000532e:     	int3
18000532f:     	int3
180005330:     	subq	$0x28, %rsp
180005334:     	callq	*0x993e(%rip)           # 0x18000ec78
18000533a:     	cmpb	$0x0, 0x98ff(%rip)      # 0x18000ec40
180005341:     	je	0x18000534b <numba_list_iter_next+0x28b>
180005343:     	lock
180005344:     	incq	0x9905(%rip)            # 0x18000ec50
18000534b:     	addq	$0x28, %rsp
18000534f:     	retq
180005350:     	jmpq	*%r8
180005353:     	int3
180005354:     	int3
180005355:     	int3
180005356:     	int3
180005357:     	int3
180005358:     	int3
180005359:     	int3
18000535a:     	int3
18000535b:     	int3
18000535c:     	int3
18000535d:     	int3
18000535e:     	int3
18000535f:     	int3
180005360:     	movq	%rbx, 0x8(%rsp)
180005365:     	pushq	%rdi
180005366:     	subq	$0x20, %rsp
18000536a:     	movq	%rcx, %rdi
18000536d:     	movq	%rdx, %rbx
180005370:     	movl	$0x30, %ecx
180005375:     	callq	*0x98ed(%rip)           # 0x18000ec68
18000537b:     	cmpb	$0x0, 0x98be(%rip)      # 0x18000ec40
180005382:     	je	0x18000538c <numba_list_iter_next+0x2cc>
180005384:     	lock
180005385:     	incq	0x98bc(%rip)            # 0x18000ec48
18000538c:     	testq	%rax, %rax
18000538f:     	je	0x1800053c6 <numba_list_iter_next+0x306>
180005391:     	leaq	-0x48(%rip), %rcx       # 0x180005350 <numba_list_iter_next+0x290>
180005398:     	movl	$0x1, %edx
18000539d:     	xchgq	%rdx, (%rax)
1800053a0:     	movq	%rcx, 0x8(%rax)
1800053a4:     	xorl	%ecx, %ecx
1800053a6:     	movq	%rcx, 0x20(%rax)
1800053aa:     	movq	%rcx, 0x28(%rax)
1800053ae:     	movq	%rbx, 0x10(%rax)
1800053b2:     	movq	%rdi, 0x18(%rax)
1800053b6:     	cmpb	%cl, 0x9884(%rip)       # 0x18000ec40
1800053bc:     	je	0x1800053c6 <numba_list_iter_next+0x306>
1800053be:     	lock
1800053bf:     	incq	0x9892(%rip)            # 0x18000ec58
1800053c6:     	movq	0x30(%rsp), %rbx
1800053cb:     	addq	$0x20, %rsp
1800053cf:     	popq	%rdi
1800053d0:     	retq
1800053d1:     	jmpq	*0x1f21(%rip)           # 0x1800072f8
1800053d7:     	jmpq	*0x1f13(%rip)           # 0x1800072f0
1800053dd:     	jmpq	*0x1f05(%rip)           # 0x1800072e8
1800053e3:     	jmpq	*0x1ef7(%rip)           # 0x1800072e0
1800053e9:     	jmpq	*0x1ee9(%rip)           # 0x1800072d8
1800053ef:     	jmpq	*0x1ed3(%rip)           # 0x1800072c8
1800053f5:     	jmpq	*0x1ec5(%rip)           # 0x1800072c0
1800053fb:     	jmpq	*0x1eb7(%rip)           # 0x1800072b8
180005401:     	jmpq	*0x1ea1(%rip)           # 0x1800072a8
180005407:     	jmpq	*0x1e8b(%rip)           # 0x180007298
18000540d:     	jmpq	*0x1e7d(%rip)           # 0x180007290
180005413:     	jmpq	*0x1e6f(%rip)           # 0x180007288
180005419:     	jmpq	*0x1e29(%rip)           # 0x180007248
18000541f:     	int3
180005420:     	int3
180005421:     	int3
180005422:     	int3
180005423:     	int3
180005424:     	int3
180005425:     	int3
180005426:     	nopw	(%rax,%rax)
180005430:     	cmpq	0x8cc9(%rip), %rcx      # 0x18000e100
180005437:     	jne	0x180005449 <numba_list_iter_next+0x389>
180005439:     	rolq	$0x10, %rcx
18000543d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180005442:     	jne	0x180005445 <numba_list_iter_next+0x385>
180005444:     	retq
180005445:     	rorq	$0x10, %rcx
180005449:     	jmp	0x1800057a4 <numba_list_iter_next+0x6e4>
18000544e:     	int3
18000544f:     	int3
180005450:     	subq	$0x28, %rsp
180005454:     	testl	%edx, %edx
180005456:     	je	0x180005491 <numba_list_iter_next+0x3d1>
180005458:     	subl	$0x1, %edx
18000545b:     	je	0x180005485 <numba_list_iter_next+0x3c5>
18000545d:     	subl	$0x1, %edx
180005460:     	je	0x180005478 <numba_list_iter_next+0x3b8>
180005462:     	cmpl	$0x1, %edx
180005465:     	je	0x180005471 <numba_list_iter_next+0x3b1>
180005467:     	movl	$0x1, %eax
18000546c:     	addq	$0x28, %rsp
180005470:     	retq
180005471:     	callq	0x180005970 <numba_list_iter_next+0x8b0>
180005476:     	jmp	0x18000547d <numba_list_iter_next+0x3bd>
180005478:     	callq	0x180005948 <numba_list_iter_next+0x888>
18000547d:     	movzbl	%al, %eax
180005480:     	addq	$0x28, %rsp
180005484:     	retq
180005485:     	movq	%r8, %rdx
180005488:     	addq	$0x28, %rsp
18000548c:     	jmp	0x1800054a0 <numba_list_iter_next+0x3e0>
180005491:     	testq	%r8, %r8
180005494:     	setne	%cl
180005497:     	addq	$0x28, %rsp
18000549b:     	jmp	0x1800055b8 <numba_list_iter_next+0x4f8>
1800054a0:     	movq	%rbx, 0x8(%rsp)
1800054a5:     	movq	%rsi, 0x10(%rsp)
1800054aa:     	movq	%rdi, 0x20(%rsp)
1800054af:     	pushq	%r14
1800054b1:     	subq	$0x20, %rsp
1800054b5:     	movq	%rdx, %rsi
1800054b8:     	movq	%rcx, %r14
1800054bb:     	xorl	%ecx, %ecx
1800054bd:     	callq	0x180005a2c <numba_list_iter_next+0x96c>
1800054c2:     	testb	%al, %al
1800054c4:     	je	0x180005592 <numba_list_iter_next+0x4d2>
1800054ca:     	callq	0x1800058c0 <numba_list_iter_next+0x800>
1800054cf:     	movb	%al, %bl
1800054d1:     	movb	%al, 0x40(%rsp)
1800054d5:     	movb	$0x1, %dil
1800054d8:     	cmpl	$0x0, 0x9529(%rip)      # 0x18000ea08
1800054df:     	jne	0x1800055aa <numba_list_iter_next+0x4ea>
1800054e5:     	movl	$0x1, 0x9519(%rip)      # 0x18000ea08
1800054ef:     	callq	0x180005930 <numba_list_iter_next+0x870>
1800054f4:     	testb	%al, %al
1800054f6:     	je	0x180005547 <numba_list_iter_next+0x487>
1800054f8:     	callq	0x180005bec <numba_list_iter_next+0xb2c>
1800054fd:     	callq	0x180005880 <numba_list_iter_next+0x7c0>
180005502:     	callq	0x1800058a4 <numba_list_iter_next+0x7e4>
180005507:     	leaq	0x1e4a(%rip), %rdx      # 0x180007358
18000550e:     	leaq	0x1e3b(%rip), %rcx      # 0x180007350
180005515:     	callq	0x180005f38 <numba_list_iter_next+0xe78>
18000551a:     	testl	%eax, %eax
18000551c:     	jne	0x180005547 <numba_list_iter_next+0x487>
18000551e:     	callq	0x1800058fc <numba_list_iter_next+0x83c>
180005523:     	testb	%al, %al
180005525:     	je	0x180005547 <numba_list_iter_next+0x487>
180005527:     	leaq	0x1e1a(%rip), %rdx      # 0x180007348
18000552e:     	leaq	0x1e0b(%rip), %rcx      # 0x180007340
180005535:     	callq	0x180005f32 <numba_list_iter_next+0xe72>
18000553a:     	movl	$0x2, 0x94c4(%rip)      # 0x18000ea08
180005544:     	xorb	%dil, %dil
180005547:     	movb	%bl, %cl
180005549:     	callq	0x180005b8c <numba_list_iter_next+0xacc>
18000554e:     	testb	%dil, %dil
180005551:     	jne	0x180005592 <numba_list_iter_next+0x4d2>
180005553:     	callq	0x180005bdc <numba_list_iter_next+0xb1c>
180005558:     	movq	%rax, %rbx
18000555b:     	cmpq	$0x0, (%rax)
18000555f:     	je	0x180005585 <numba_list_iter_next+0x4c5>
180005561:     	movq	%rax, %rcx
180005564:     	callq	0x180005af4 <numba_list_iter_next+0xa34>
180005569:     	testb	%al, %al
18000556b:     	je	0x180005585 <numba_list_iter_next+0x4c5>
18000556d:     	movq	%rsi, %r8
180005570:     	movl	$0x2, %edx
180005575:     	movq	%r14, %rcx
180005578:     	movq	(%rbx), %rax
18000557b:     	movq	0x1d96(%rip), %r9       # 0x180007318
180005582:     	callq	*%r9
180005585:     	incl	0x9455(%rip)            # 0x18000e9e0
18000558b:     	movl	$0x1, %eax
180005590:     	jmp	0x180005594 <numba_list_iter_next+0x4d4>
180005592:     	xorl	%eax, %eax
180005594:     	movq	0x30(%rsp), %rbx
180005599:     	movq	0x38(%rsp), %rsi
18000559e:     	movq	0x48(%rsp), %rdi
1800055a3:     	addq	$0x20, %rsp
1800055a7:     	popq	%r14
1800055a9:     	retq
1800055aa:     	movl	$0x7, %ecx
1800055af:     	callq	0x180005be4 <numba_list_iter_next+0xb24>
1800055b4:     	nop
1800055b5:     	int3
1800055b6:     	int3
1800055b7:     	int3
1800055b8:     	movq	%rbx, 0x8(%rsp)
1800055bd:     	pushq	%rdi
1800055be:     	subq	$0x30, %rsp
1800055c2:     	movb	%cl, %dil
1800055c5:     	movl	0x9415(%rip), %eax      # 0x18000e9e0
1800055cb:     	testl	%eax, %eax
1800055cd:     	jg	0x1800055dc <numba_list_iter_next+0x51c>
1800055cf:     	xorl	%eax, %eax
1800055d1:     	movq	0x40(%rsp), %rbx
1800055d6:     	addq	$0x30, %rsp
1800055da:     	popq	%rdi
1800055db:     	retq
1800055dc:     	decl	%eax
1800055de:     	movl	%eax, 0x93fc(%rip)      # 0x18000e9e0
1800055e4:     	callq	0x1800058c0 <numba_list_iter_next+0x800>
1800055e9:     	movb	%al, %bl
1800055eb:     	movb	%al, 0x20(%rsp)
1800055ef:     	cmpl	$0x2, 0x9412(%rip)      # 0x18000ea08
1800055f6:     	jne	0x18000562e <numba_list_iter_next+0x56e>
1800055f8:     	callq	0x1800059e8 <numba_list_iter_next+0x928>
1800055fd:     	callq	0x180005890 <numba_list_iter_next+0x7d0>
180005602:     	callq	0x180005c28 <numba_list_iter_next+0xb68>
180005607:     	movl	$0x0, 0x93f7(%rip)      # 0x18000ea08
180005611:     	movb	%bl, %cl
180005613:     	callq	0x180005b8c <numba_list_iter_next+0xacc>
180005618:     	xorl	%edx, %edx
18000561a:     	movb	%dil, %cl
18000561d:     	callq	0x180005bb0 <numba_list_iter_next+0xaf0>
180005622:     	movzbl	%al, %ebx
180005625:     	callq	0x180005a18 <numba_list_iter_next+0x958>
18000562a:     	movl	%ebx, %eax
18000562c:     	jmp	0x1800055d1 <numba_list_iter_next+0x511>
18000562e:     	movl	$0x7, %ecx
180005633:     	callq	0x180005be4 <numba_list_iter_next+0xb24>
180005638:     	nop
180005639:     	nop
18000563a:     	int3
18000563b:     	int3
18000563c:     	movq	%rsp, %rax
18000563f:     	movq	%rbx, 0x20(%rax)
180005643:     	movq	%r8, 0x18(%rax)
180005647:     	movl	%edx, 0x10(%rax)
18000564a:     	movq	%rcx, 0x8(%rax)
18000564e:     	pushq	%rsi
18000564f:     	pushq	%rdi
180005650:     	pushq	%r14
180005652:     	subq	$0x40, %rsp
180005656:     	movq	%r8, %rsi
180005659:     	movl	%edx, %edi
18000565b:     	movq	%rcx, %r14
18000565e:     	testl	%edx, %edx
180005660:     	jne	0x180005671 <numba_list_iter_next+0x5b1>
180005662:     	cmpl	%edx, 0x9378(%rip)      # 0x18000e9e0
180005668:     	jg	0x180005671 <numba_list_iter_next+0x5b1>
18000566a:     	xorl	%eax, %eax
18000566c:     	jmp	0x180005756 <numba_list_iter_next+0x696>
180005671:     	leal	-0x1(%rdx), %eax
180005674:     	cmpl	$0x1, %eax
180005677:     	ja	0x1800056b9 <numba_list_iter_next+0x5f9>
180005679:     	movq	0x2cb0(%rip), %rax      # 0x180008330
180005680:     	testq	%rax, %rax
180005683:     	jne	0x18000568a <numba_list_iter_next+0x5ca>
180005685:     	leal	0x1(%rax), %ebx
180005688:     	jmp	0x180005692 <numba_list_iter_next+0x5d2>
18000568a:     	callq	*0x1c88(%rip)           # 0x180007318
180005690:     	movl	%eax, %ebx
180005692:     	movl	%ebx, 0x30(%rsp)
180005696:     	testl	%ebx, %ebx
180005698:     	je	0x18000574c <numba_list_iter_next+0x68c>
18000569e:     	movq	%rsi, %r8
1800056a1:     	movl	%edi, %edx
1800056a3:     	movq	%r14, %rcx
1800056a6:     	callq	0x180005450 <numba_list_iter_next+0x390>
1800056ab:     	movl	%eax, %ebx
1800056ad:     	movl	%eax, 0x30(%rsp)
1800056b1:     	testl	%eax, %eax
1800056b3:     	je	0x18000574c <numba_list_iter_next+0x68c>
1800056b9:     	movq	%rsi, %r8
1800056bc:     	movl	%edi, %edx
1800056be:     	movq	%r14, %rcx
1800056c1:     	callq	0x18000585c <numba_list_iter_next+0x79c>
1800056c6:     	movl	%eax, %ebx
1800056c8:     	movl	%eax, 0x30(%rsp)
1800056cc:     	cmpl	$0x1, %edi
1800056cf:     	jne	0x180005707 <numba_list_iter_next+0x647>
1800056d1:     	testl	%eax, %eax
1800056d3:     	jne	0x180005707 <numba_list_iter_next+0x647>
1800056d5:     	movq	%rsi, %r8
1800056d8:     	xorl	%edx, %edx
1800056da:     	movq	%r14, %rcx
1800056dd:     	callq	0x18000585c <numba_list_iter_next+0x79c>
1800056e2:     	testq	%rsi, %rsi
1800056e5:     	setne	%cl
1800056e8:     	callq	0x1800055b8 <numba_list_iter_next+0x4f8>
1800056ed:     	movq	0x2c3c(%rip), %rax      # 0x180008330
1800056f4:     	testq	%rax, %rax
1800056f7:     	je	0x180005707 <numba_list_iter_next+0x647>
1800056f9:     	movq	%rsi, %r8
1800056fc:     	xorl	%edx, %edx
1800056fe:     	movq	%r14, %rcx
180005701:     	callq	*0x1c11(%rip)           # 0x180007318
180005707:     	testl	%edi, %edi
180005709:     	je	0x180005710 <numba_list_iter_next+0x650>
18000570b:     	cmpl	$0x3, %edi
18000570e:     	jne	0x18000574c <numba_list_iter_next+0x68c>
180005710:     	movq	%rsi, %r8
180005713:     	movl	%edi, %edx
180005715:     	movq	%r14, %rcx
180005718:     	callq	0x180005450 <numba_list_iter_next+0x390>
18000571d:     	movl	%eax, %ebx
18000571f:     	movl	%eax, 0x30(%rsp)
180005723:     	testl	%eax, %eax
180005725:     	je	0x18000574c <numba_list_iter_next+0x68c>
180005727:     	movq	0x2c02(%rip), %rax      # 0x180008330
18000572e:     	testq	%rax, %rax
180005731:     	jne	0x180005738 <numba_list_iter_next+0x678>
180005733:     	leal	0x1(%rax), %ebx
180005736:     	jmp	0x180005748 <numba_list_iter_next+0x688>
180005738:     	movq	%rsi, %r8
18000573b:     	movl	%edi, %edx
18000573d:     	movq	%r14, %rcx
180005740:     	callq	*0x1bd2(%rip)           # 0x180007318
180005746:     	movl	%eax, %ebx
180005748:     	movl	%ebx, 0x30(%rsp)
18000574c:     	jmp	0x180005754 <numba_list_iter_next+0x694>
18000574e:     	xorl	%ebx, %ebx
180005750:     	movl	%ebx, 0x30(%rsp)
180005754:     	movl	%ebx, %eax
180005756:     	movq	0x78(%rsp), %rbx
18000575b:     	addq	$0x40, %rsp
18000575f:     	popq	%r14
180005761:     	popq	%rdi
180005762:     	popq	%rsi
180005763:     	retq
180005764:     	movq	%rbx, 0x8(%rsp)
180005769:     	movq	%rsi, 0x10(%rsp)
18000576e:     	pushq	%rdi
18000576f:     	subq	$0x20, %rsp
180005773:     	movq	%r8, %rdi
180005776:     	movl	%edx, %ebx
180005778:     	movq	%rcx, %rsi
18000577b:     	cmpl	$0x1, %edx
18000577e:     	jne	0x180005785 <numba_list_iter_next+0x6c5>
180005780:     	callq	0x1800057ac <numba_list_iter_next+0x6ec>
180005785:     	movq	%rdi, %r8
180005788:     	movl	%ebx, %edx
18000578a:     	movq	%rsi, %rcx
18000578d:     	movq	0x30(%rsp), %rbx
180005792:     	movq	0x38(%rsp), %rsi
180005797:     	addq	$0x20, %rsp
18000579b:     	popq	%rdi
18000579c:     	jmp	0x18000563c <numba_list_iter_next+0x57c>
1800057a1:     	int3
1800057a2:     	int3
1800057a3:     	int3
1800057a4:     	movl	$0x2, %ecx
1800057a9:     	int	$0x29
1800057ab:     	retq
1800057ac:     	movq	%rbx, 0x18(%rsp)
1800057b1:     	pushq	%rbp
1800057b2:     	movq	%rsp, %rbp
1800057b5:     	subq	$0x30, %rsp
1800057b9:     	movq	0x8940(%rip), %rax      # 0x18000e100
1800057c0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1800057ca:     	cmpq	%rbx, %rax
1800057cd:     	jne	0x180005846 <numba_list_iter_next+0x786>
1800057cf:     	leaq	0x10(%rbp), %rcx
1800057d3:     	movq	$0x0, 0x10(%rbp)
1800057db:     	callq	*0x1847(%rip)           # 0x180007028
1800057e1:     	movq	0x10(%rbp), %rax
1800057e5:     	movq	%rax, -0x10(%rbp)
1800057e9:     	callq	*0x1821(%rip)           # 0x180007010
1800057ef:     	movl	%eax, %eax
1800057f1:     	xorq	%rax, -0x10(%rbp)
1800057f5:     	callq	*0x180d(%rip)           # 0x180007008
1800057fb:     	movl	%eax, %eax
1800057fd:     	leaq	0x18(%rbp), %rcx
180005801:     	xorq	%rax, -0x10(%rbp)
180005805:     	callq	*0x17f5(%rip)           # 0x180007000
18000580b:     	movl	0x18(%rbp), %eax
18000580e:     	leaq	-0x10(%rbp), %rcx
180005812:     	shlq	$0x20, %rax
180005816:     	xorq	0x18(%rbp), %rax
18000581a:     	xorq	-0x10(%rbp), %rax
18000581e:     	xorq	%rcx, %rax
180005821:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000582b:     	andq	%rcx, %rax
18000582e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180005838:     	cmpq	%rbx, %rax
18000583b:     	cmoveq	%rcx, %rax
18000583f:     	movq	%rax, 0x88ba(%rip)      # 0x18000e100
180005846:     	movq	0x50(%rsp), %rbx
18000584b:     	notq	%rax
18000584e:     	movq	%rax, 0x88eb(%rip)      # 0x18000e140
180005855:     	addq	$0x30, %rsp
180005859:     	popq	%rbp
18000585a:     	retq
18000585b:     	int3
18000585c:     	subq	$0x28, %rsp
180005860:     	cmpl	$0x1, %edx
180005863:     	jne	0x180005875 <numba_list_iter_next+0x7b5>
180005865:     	cmpq	$0x0, 0x2ac3(%rip)      # 0x180008330
18000586d:     	jne	0x180005875 <numba_list_iter_next+0x7b5>
18000586f:     	callq	*0x17ab(%rip)           # 0x180007020
180005875:     	movl	$0x1, %eax
18000587a:     	addq	$0x28, %rsp
18000587e:     	retq
18000587f:     	int3
180005880:     	leaq	0x9169(%rip), %rcx      # 0x18000e9f0
180005887:     	jmpq	*0x178a(%rip)           # 0x180007018
18000588e:     	int3
18000588f:     	int3
180005890:     	leaq	0x9159(%rip), %rcx      # 0x18000e9f0
180005897:     	jmp	0x180005f26 <numba_list_iter_next+0xe66>
18000589c:     	leaq	0x915d(%rip), %rax      # 0x18000ea00
1800058a3:     	retq
1800058a4:     	subq	$0x28, %rsp
1800058a8:     	callq	0x1800049d0 <PyInit_rcaot_05cb37762ef1645705ed4668+0x1700>
1800058ad:     	orq	$0x24, (%rax)
1800058b1:     	callq	0x18000589c <numba_list_iter_next+0x7dc>
1800058b6:     	orq	$0x2, (%rax)
1800058ba:     	addq	$0x28, %rsp
1800058be:     	retq
1800058bf:     	int3
1800058c0:     	subq	$0x28, %rsp
1800058c4:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
1800058c9:     	testl	%eax, %eax
1800058cb:     	je	0x1800058ee <numba_list_iter_next+0x82e>
1800058cd:     	movq	%gs:0x30, %rax
1800058d6:     	movq	0x8(%rax), %rcx
1800058da:     	jmp	0x1800058e1 <numba_list_iter_next+0x821>
1800058dc:     	cmpq	%rax, %rcx
1800058df:     	je	0x1800058f5 <numba_list_iter_next+0x835>
1800058e1:     	xorl	%eax, %eax
1800058e3:     	lock
1800058e4:     	cmpxchgq	%rcx, 0x9124(%rip)      # 0x18000ea10
1800058ec:     	jne	0x1800058dc <numba_list_iter_next+0x81c>
1800058ee:     	xorb	%al, %al
1800058f0:     	addq	$0x28, %rsp
1800058f4:     	retq
1800058f5:     	movb	$0x1, %al
1800058f7:     	jmp	0x1800058f0 <numba_list_iter_next+0x830>
1800058f9:     	int3
1800058fa:     	int3
1800058fb:     	int3
1800058fc:     	subq	$0x28, %rsp
180005900:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
180005905:     	testl	%eax, %eax
180005907:     	je	0x180005910 <numba_list_iter_next+0x850>
180005909:     	callq	0x180005c68 <numba_list_iter_next+0xba8>
18000590e:     	jmp	0x180005929 <numba_list_iter_next+0x869>
180005910:     	callq	0x180005f04 <numba_list_iter_next+0xe44>
180005915:     	movl	%eax, %ecx
180005917:     	callq	0x180005f44 <numba_list_iter_next+0xe84>
18000591c:     	testl	%eax, %eax
18000591e:     	je	0x180005924 <numba_list_iter_next+0x864>
180005920:     	xorb	%al, %al
180005922:     	jmp	0x18000592b <numba_list_iter_next+0x86b>
180005924:     	callq	0x180005f4a <numba_list_iter_next+0xe8a>
180005929:     	movb	$0x1, %al
18000592b:     	addq	$0x28, %rsp
18000592f:     	retq
180005930:     	subq	$0x28, %rsp
180005934:     	xorl	%ecx, %ecx
180005936:     	callq	0x180005a68 <numba_list_iter_next+0x9a8>
18000593b:     	testb	%al, %al
18000593d:     	setne	%al
180005940:     	addq	$0x28, %rsp
180005944:     	retq
180005945:     	int3
180005946:     	int3
180005947:     	int3
180005948:     	subq	$0x28, %rsp
18000594c:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005951:     	testb	%al, %al
180005953:     	jne	0x180005959 <numba_list_iter_next+0x899>
180005955:     	xorb	%al, %al
180005957:     	jmp	0x18000596b <numba_list_iter_next+0x8ab>
180005959:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
18000595e:     	testb	%al, %al
180005960:     	jne	0x180005969 <numba_list_iter_next+0x8a9>
180005962:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005967:     	jmp	0x180005955 <numba_list_iter_next+0x895>
180005969:     	movb	$0x1, %al
18000596b:     	addq	$0x28, %rsp
18000596f:     	retq
180005970:     	subq	$0x28, %rsp
180005974:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005979:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
18000597e:     	movb	$0x1, %al
180005980:     	addq	$0x28, %rsp
180005984:     	retq
180005985:     	int3
180005986:     	int3
180005987:     	int3
180005988:     	movq	%rbx, 0x8(%rsp)
18000598d:     	movq	%rbp, 0x10(%rsp)
180005992:     	movq	%rsi, 0x18(%rsp)
180005997:     	pushq	%rdi
180005998:     	subq	$0x20, %rsp
18000599c:     	movq	%r9, %rdi
18000599f:     	movq	%r8, %rsi
1800059a2:     	movl	%edx, %ebx
1800059a4:     	movq	%rcx, %rbp
1800059a7:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
1800059ac:     	testl	%eax, %eax
1800059ae:     	jne	0x1800059c6 <numba_list_iter_next+0x906>
1800059b0:     	cmpl	$0x1, %ebx
1800059b3:     	jne	0x1800059c6 <numba_list_iter_next+0x906>
1800059b5:     	movq	%rsi, %r8
1800059b8:     	xorl	%edx, %edx
1800059ba:     	movq	%rbp, %rcx
1800059bd:     	movq	%rdi, %rax
1800059c0:     	callq	*0x1952(%rip)           # 0x180007318
1800059c6:     	movq	0x58(%rsp), %rdx
1800059cb:     	movl	0x50(%rsp), %ecx
1800059cf:     	movq	0x30(%rsp), %rbx
1800059d4:     	movq	0x38(%rsp), %rbp
1800059d9:     	movq	0x40(%rsp), %rsi
1800059de:     	addq	$0x20, %rsp
1800059e2:     	popq	%rdi
1800059e3:     	jmp	0x180005f3e <numba_list_iter_next+0xe7e>
1800059e8:     	subq	$0x28, %rsp
1800059ec:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
1800059f1:     	testl	%eax, %eax
1800059f3:     	je	0x180005a05 <numba_list_iter_next+0x945>
1800059f5:     	leaq	0x9024(%rip), %rcx      # 0x18000ea20
1800059fc:     	addq	$0x28, %rsp
180005a00:     	jmp	0x180005f56 <numba_list_iter_next+0xe96>
180005a05:     	callq	0x180005f68 <numba_list_iter_next+0xea8>
180005a0a:     	testl	%eax, %eax
180005a0c:     	jne	0x180005a13 <numba_list_iter_next+0x953>
180005a0e:     	callq	0x180005f5c <numba_list_iter_next+0xe9c>
180005a13:     	addq	$0x28, %rsp
180005a17:     	retq
180005a18:     	subq	$0x28, %rsp
180005a1c:     	xorl	%ecx, %ecx
180005a1e:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005a23:     	addq	$0x28, %rsp
180005a27:     	jmp	0x180005f64 <numba_list_iter_next+0xea4>
180005a2c:     	subq	$0x28, %rsp
180005a30:     	testl	%ecx, %ecx
180005a32:     	jne	0x180005a3b <numba_list_iter_next+0x97b>
180005a34:     	movb	$0x1, 0x8fdd(%rip)      # 0x18000ea18
180005a3b:     	callq	0x180005c68 <numba_list_iter_next+0xba8>
180005a40:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005a45:     	testb	%al, %al
180005a47:     	jne	0x180005a4d <numba_list_iter_next+0x98d>
180005a49:     	xorb	%al, %al
180005a4b:     	jmp	0x180005a61 <numba_list_iter_next+0x9a1>
180005a4d:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005a52:     	testb	%al, %al
180005a54:     	jne	0x180005a5f <numba_list_iter_next+0x99f>
180005a56:     	xorl	%ecx, %ecx
180005a58:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005a5d:     	jmp	0x180005a49 <numba_list_iter_next+0x989>
180005a5f:     	movb	$0x1, %al
180005a61:     	addq	$0x28, %rsp
180005a65:     	retq
180005a66:     	int3
180005a67:     	int3
180005a68:     	pushq	%rbx
180005a6a:     	subq	$0x20, %rsp
180005a6e:     	cmpb	$0x0, 0x8fa4(%rip)      # 0x18000ea19
180005a75:     	movl	%ecx, %ebx
180005a77:     	jne	0x180005ae0 <numba_list_iter_next+0xa20>
180005a79:     	cmpl	$0x1, %ecx
180005a7c:     	ja	0x180005ae8 <numba_list_iter_next+0xa28>
180005a7e:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
180005a83:     	testl	%eax, %eax
180005a85:     	je	0x180005aaf <numba_list_iter_next+0x9ef>
180005a87:     	testl	%ebx, %ebx
180005a89:     	jne	0x180005aaf <numba_list_iter_next+0x9ef>
180005a8b:     	leaq	0x8f8e(%rip), %rcx      # 0x18000ea20
180005a92:     	callq	0x180005f50 <numba_list_iter_next+0xe90>
180005a97:     	testl	%eax, %eax
180005a99:     	jne	0x180005aab <numba_list_iter_next+0x9eb>
180005a9b:     	leaq	0x8f96(%rip), %rcx      # 0x18000ea38
180005aa2:     	callq	0x180005f50 <numba_list_iter_next+0xe90>
180005aa7:     	testl	%eax, %eax
180005aa9:     	je	0x180005ad9 <numba_list_iter_next+0xa19>
180005aab:     	xorb	%al, %al
180005aad:     	jmp	0x180005ae2 <numba_list_iter_next+0xa22>
180005aaf:     	movdqa	0x2889(%rip), %xmm0     # 0x180008340
180005ab7:     	orq	$-0x1, %rax
180005abb:     	movdqu	%xmm0, 0x8f5d(%rip)     # 0x18000ea20
180005ac3:     	movq	%rax, 0x8f66(%rip)      # 0x18000ea30
180005aca:     	movdqu	%xmm0, 0x8f66(%rip)     # 0x18000ea38
180005ad2:     	movq	%rax, 0x8f6f(%rip)      # 0x18000ea48
180005ad9:     	movb	$0x1, 0x8f39(%rip)      # 0x18000ea19
180005ae0:     	movb	$0x1, %al
180005ae2:     	addq	$0x20, %rsp
180005ae6:     	popq	%rbx
180005ae7:     	retq
180005ae8:     	movl	$0x5, %ecx
180005aed:     	callq	0x180005be4 <numba_list_iter_next+0xb24>
180005af2:     	int3
180005af3:     	int3
180005af4:     	subq	$0x18, %rsp
180005af8:     	movq	%rcx, %r8
180005afb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180005b00:     	cmpw	%ax, -0x5b07(%rip)      # 0x180000000
180005b07:     	jne	0x180005b81 <numba_list_iter_next+0xac1>
180005b09:     	movslq	-0x5ad4(%rip), %rcx     # 0x18000003c
180005b10:     	leaq	-0x5b17(%rip), %rdx     # 0x180000000
180005b17:     	addq	%rdx, %rcx
180005b1a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180005b20:     	jne	0x180005b81 <numba_list_iter_next+0xac1>
180005b22:     	movl	$0x20b, %eax            # imm = 0x20B
180005b27:     	cmpw	%ax, 0x18(%rcx)
180005b2b:     	jne	0x180005b81 <numba_list_iter_next+0xac1>
180005b2d:     	subq	%rdx, %r8
180005b30:     	movzwl	0x14(%rcx), %edx
180005b34:     	addq	$0x18, %rdx
180005b38:     	addq	%rcx, %rdx
180005b3b:     	movzwl	0x6(%rcx), %eax
180005b3f:     	leaq	(%rax,%rax,4), %rcx
180005b43:     	leaq	(%rdx,%rcx,8), %r9
180005b47:     	movq	%rdx, (%rsp)
180005b4b:     	cmpq	%r9, %rdx
180005b4e:     	je	0x180005b68 <numba_list_iter_next+0xaa8>
180005b50:     	movl	0xc(%rdx), %ecx
180005b53:     	cmpq	%rcx, %r8
180005b56:     	jb	0x180005b62 <numba_list_iter_next+0xaa2>
180005b58:     	movl	0x8(%rdx), %eax
180005b5b:     	addl	%ecx, %eax
180005b5d:     	cmpq	%rax, %r8
180005b60:     	jb	0x180005b6a <numba_list_iter_next+0xaaa>
180005b62:     	addq	$0x28, %rdx
180005b66:     	jmp	0x180005b47 <numba_list_iter_next+0xa87>
180005b68:     	xorl	%edx, %edx
180005b6a:     	testq	%rdx, %rdx
180005b6d:     	jne	0x180005b73 <numba_list_iter_next+0xab3>
180005b6f:     	xorb	%al, %al
180005b71:     	jmp	0x180005b87 <numba_list_iter_next+0xac7>
180005b73:     	cmpl	$0x0, 0x24(%rdx)
180005b77:     	jge	0x180005b7d <numba_list_iter_next+0xabd>
180005b79:     	xorb	%al, %al
180005b7b:     	jmp	0x180005b87 <numba_list_iter_next+0xac7>
180005b7d:     	movb	$0x1, %al
180005b7f:     	jmp	0x180005b87 <numba_list_iter_next+0xac7>
180005b81:     	xorb	%al, %al
180005b83:     	jmp	0x180005b87 <numba_list_iter_next+0xac7>
180005b85:     	xorb	%al, %al
180005b87:     	addq	$0x18, %rsp
180005b8b:     	retq
180005b8c:     	pushq	%rbx
180005b8e:     	subq	$0x20, %rsp
180005b92:     	movb	%cl, %bl
180005b94:     	callq	0x180005f0c <numba_list_iter_next+0xe4c>
180005b99:     	xorl	%edx, %edx
180005b9b:     	testl	%eax, %eax
180005b9d:     	je	0x180005baa <numba_list_iter_next+0xaea>
180005b9f:     	testb	%bl, %bl
180005ba1:     	jne	0x180005baa <numba_list_iter_next+0xaea>
180005ba3:     	xchgq	%rdx, 0x8e66(%rip)      # 0x18000ea10
180005baa:     	addq	$0x20, %rsp
180005bae:     	popq	%rbx
180005baf:     	retq
180005bb0:     	pushq	%rbx
180005bb2:     	subq	$0x20, %rsp
180005bb6:     	cmpb	$0x0, 0x8e5b(%rip)      # 0x18000ea18
180005bbd:     	movb	%cl, %bl
180005bbf:     	je	0x180005bc5 <numba_list_iter_next+0xb05>
180005bc1:     	testb	%dl, %dl
180005bc3:     	jne	0x180005bd1 <numba_list_iter_next+0xb11>
180005bc5:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005bca:     	movb	%bl, %cl
180005bcc:     	callq	0x180005f64 <numba_list_iter_next+0xea4>
180005bd1:     	movb	$0x1, %al
180005bd3:     	addq	$0x20, %rsp
180005bd7:     	popq	%rbx
180005bd8:     	retq
180005bd9:     	int3
180005bda:     	int3
180005bdb:     	int3
180005bdc:     	leaq	0x921d(%rip), %rax      # 0x18000ee00
180005be3:     	retq
180005be4:     	movl	%ecx, %ecx
180005be6:     	int	$0x29
180005be8:     	retq
180005be9:     	int3
180005bea:     	int3
180005beb:     	int3
180005bec:     	movq	%rbx, 0x8(%rsp)
180005bf1:     	pushq	%rdi
180005bf2:     	subq	$0x20, %rsp
180005bf6:     	leaq	0x514b(%rip), %rbx      # 0x18000ad48
180005bfd:     	leaq	0x5144(%rip), %rdi      # 0x18000ad48
180005c04:     	jmp	0x180005c18 <numba_list_iter_next+0xb58>
180005c06:     	movq	(%rbx), %rax
180005c09:     	testq	%rax, %rax
180005c0c:     	je	0x180005c14 <numba_list_iter_next+0xb54>
180005c0e:     	callq	*0x1704(%rip)           # 0x180007318
180005c14:     	addq	$0x8, %rbx
180005c18:     	cmpq	%rdi, %rbx
180005c1b:     	jb	0x180005c06 <numba_list_iter_next+0xb46>
180005c1d:     	movq	0x30(%rsp), %rbx
180005c22:     	addq	$0x20, %rsp
180005c26:     	popq	%rdi
180005c27:     	retq
180005c28:     	movq	%rbx, 0x8(%rsp)
180005c2d:     	pushq	%rdi
180005c2e:     	subq	$0x20, %rsp
180005c32:     	leaq	0x511f(%rip), %rbx      # 0x18000ad58
180005c39:     	leaq	0x5118(%rip), %rdi      # 0x18000ad58
180005c40:     	jmp	0x180005c54 <numba_list_iter_next+0xb94>
180005c42:     	movq	(%rbx), %rax
180005c45:     	testq	%rax, %rax
180005c48:     	je	0x180005c50 <numba_list_iter_next+0xb90>
180005c4a:     	callq	*0x16c8(%rip)           # 0x180007318
180005c50:     	addq	$0x8, %rbx
180005c54:     	cmpq	%rdi, %rbx
180005c57:     	jb	0x180005c42 <numba_list_iter_next+0xb82>
180005c59:     	movq	0x30(%rsp), %rbx
180005c5e:     	addq	$0x20, %rsp
180005c62:     	popq	%rdi
180005c63:     	retq
180005c64:     	retq	$0x0
180005c67:     	int3
180005c68:     	movq	%rbx, 0x10(%rsp)
180005c6d:     	movq	%rbp, 0x18(%rsp)
180005c72:     	movq	%rsi, 0x20(%rsp)
180005c77:     	pushq	%rdi
180005c78:     	subq	$0x10, %rsp
180005c7c:     	xorl	%eax, %eax
180005c7e:     	xorl	%ecx, %ecx
180005c80:     	cpuid
180005c82:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180005c88:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
180005c8e:     	orl	%ecx, %edx
180005c90:     	movl	%eax, %ebp
180005c92:     	movl	$0x1, %eax
180005c97:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
180005c9d:     	orl	%ebx, %edx
180005c9f:     	leal	-0x1(%rax), %ecx
180005ca2:     	cpuid
180005ca4:     	movl	%ecx, %edi
180005ca6:     	jne	0x180005d06 <numba_list_iter_next+0xc46>
180005ca8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
180005cad:     	movq	$0x8000, 0x84a0(%rip)   # imm = 0x8000
                                                # 0x18000e158
180005cb8:     	movq	$-0x1, 0x849d(%rip)     # 0x18000e160
180005cc3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180005cc8:     	je	0x180005cf2 <numba_list_iter_next+0xc32>
180005cca:     	cmpl	$0x20660, %eax          # imm = 0x20660
180005ccf:     	je	0x180005cf2 <numba_list_iter_next+0xc32>
180005cd1:     	cmpl	$0x20670, %eax          # imm = 0x20670
180005cd6:     	je	0x180005cf2 <numba_list_iter_next+0xc32>
180005cd8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180005cdd:     	cmpl	$0x20, %eax
180005ce0:     	ja	0x180005d06 <numba_list_iter_next+0xc46>
180005ce2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180005cec:     	btq	%rax, %rcx
180005cf0:     	jae	0x180005d06 <numba_list_iter_next+0xc46>
180005cf2:     	movl	0x8d5b(%rip), %r8d      # 0x18000ea54
180005cf9:     	orl	$0x1, %r8d
180005cfd:     	movl	%r8d, 0x8d50(%rip)      # 0x18000ea54
180005d04:     	jmp	0x180005d0d <numba_list_iter_next+0xc4d>
180005d06:     	movl	0x8d47(%rip), %r8d      # 0x18000ea54
180005d0d:     	xorl	%r9d, %r9d
180005d10:     	movl	%r9d, %r11d
180005d13:     	cmpl	$0x7, %ebp
180005d16:     	jl	0x180005d5a <numba_list_iter_next+0xc9a>
180005d18:     	xorl	%ecx, %ecx
180005d1a:     	leal	0x7(%r9), %eax
180005d1e:     	cpuid
180005d20:     	movl	%edx, %esi
180005d22:     	movl	%ebx, %r10d
180005d25:     	btl	$0x9, %ebx
180005d29:     	jae	0x180005d36 <numba_list_iter_next+0xc76>
180005d2b:     	orl	$0x2, %r8d
180005d2f:     	movl	%r8d, 0x8d1e(%rip)      # 0x18000ea54
180005d36:     	cmpl	$0x1, %eax
180005d39:     	jl	0x180005d48 <numba_list_iter_next+0xc88>
180005d3b:     	movl	$0x7, %eax
180005d40:     	leal	-0x6(%rax), %ecx
180005d43:     	cpuid
180005d45:     	movl	%edx, %r9d
180005d48:     	movl	$0x24, %eax
180005d4d:     	cmpl	%eax, %ebp
180005d4f:     	jl	0x180005d60 <numba_list_iter_next+0xca0>
180005d51:     	xorl	%ecx, %ecx
180005d53:     	cpuid
180005d55:     	movl	%ebx, %r11d
180005d58:     	jmp	0x180005d60 <numba_list_iter_next+0xca0>
180005d5a:     	movl	%r9d, %r10d
180005d5d:     	movl	%r9d, %esi
180005d60:     	movq	0x8401(%rip), %rax      # 0x18000e168
180005d67:     	andq	$-0x2, %rax
180005d6b:     	movl	$0x1, 0x83db(%rip)      # 0x18000e150
180005d75:     	movl	$0x2, 0x83d5(%rip)      # 0x18000e154
180005d7f:     	movq	%rax, 0x83e2(%rip)      # 0x18000e168
180005d86:     	btl	$0x14, %edi
180005d8a:     	jae	0x180005dab <numba_list_iter_next+0xceb>
180005d8c:     	andq	$-0x11, %rax
180005d90:     	movl	$0x2, 0x83b6(%rip)      # 0x18000e150
180005d9a:     	movq	%rax, 0x83c7(%rip)      # 0x18000e168
180005da1:     	movl	$0x6, 0x83a9(%rip)      # 0x18000e154
180005dab:     	btl	$0x1b, %edi
180005daf:     	jae	0x180005eec <numba_list_iter_next+0xe2c>
180005db5:     	xorl	%ecx, %ecx
180005db7:     	xgetbv
180005dba:     	shlq	$0x20, %rdx
180005dbe:     	orq	%rax, %rdx
180005dc1:     	movq	%rdx, 0x20(%rsp)
180005dc6:     	btl	$0x1c, %edi
180005dca:     	jae	0x180005ed0 <numba_list_iter_next+0xe10>
180005dd0:     	movq	0x20(%rsp), %rax
180005dd5:     	andb	$0x6, %al
180005dd7:     	cmpb	$0x6, %al
180005dd9:     	jne	0x180005ed0 <numba_list_iter_next+0xe10>
180005ddf:     	movl	0x836f(%rip), %eax      # 0x18000e154
180005de5:     	movb	$-0x20, %dl
180005de7:     	orl	$0x8, %eax
180005dea:     	movl	$0x3, 0x835c(%rip)      # 0x18000e150
180005df4:     	movl	%eax, 0x835a(%rip)      # 0x18000e154
180005dfa:     	testb	$0x20, %r10b
180005dfe:     	je	0x180005e62 <numba_list_iter_next+0xda2>
180005e00:     	orl	$0x20, %eax
180005e03:     	movl	$0x5, 0x8343(%rip)      # 0x18000e150
180005e0d:     	movl	%eax, 0x8341(%rip)      # 0x18000e154
180005e13:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180005e18:     	movq	0x8349(%rip), %rax      # 0x18000e168
180005e1f:     	andl	%ecx, %r10d
180005e22:     	andq	$-0x3, %rax
180005e26:     	movq	%rax, 0x833b(%rip)      # 0x18000e168
180005e2d:     	cmpl	%ecx, %r10d
180005e30:     	jne	0x180005e69 <numba_list_iter_next+0xda9>
180005e32:     	movq	0x20(%rsp), %rax
180005e37:     	andb	%dl, %al
180005e39:     	cmpb	%dl, %al
180005e3b:     	jne	0x180005e62 <numba_list_iter_next+0xda2>
180005e3d:     	movq	0x8324(%rip), %rax      # 0x18000e168
180005e44:     	orl	$0x40, 0x8309(%rip)     # 0x18000e154
180005e4b:     	andq	$-0x25, %rax
180005e4f:     	movl	$0x6, 0x82f7(%rip)      # 0x18000e150
180005e59:     	movq	%rax, 0x8308(%rip)      # 0x18000e168
180005e60:     	jmp	0x180005e69 <numba_list_iter_next+0xda9>
180005e62:     	movq	0x82ff(%rip), %rax      # 0x18000e168
180005e69:     	btl	$0x17, %esi
180005e6d:     	jae	0x180005e7b <numba_list_iter_next+0xdbb>
180005e6f:     	btrq	$0x18, %rax
180005e74:     	movq	%rax, 0x82ed(%rip)      # 0x18000e168
180005e7b:     	btl	$0x13, %r9d
180005e80:     	jae	0x180005ed0 <numba_list_iter_next+0xe10>
180005e82:     	movq	0x20(%rsp), %rax
180005e87:     	andb	%dl, %al
180005e89:     	cmpb	%dl, %al
180005e8b:     	jne	0x180005ed0 <numba_list_iter_next+0xe10>
180005e8d:     	movq	0x82d4(%rip), %rdx      # 0x18000e168
180005e94:     	movl	%r11d, %eax
180005e97:     	shrq	$0x10, %rax
180005e9b:     	movl	%r11d, %ecx
180005e9e:     	andl	$0x6, %eax
180005ea1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180005ea7:     	orq	$0x1000029, %rax        # imm = 0x1000029
180005ead:     	movl	%ecx, 0x8ba5(%rip)      # 0x18000ea58
180005eb3:     	notq	%rax
180005eb6:     	andq	%rax, %rdx
180005eb9:     	movq	%rdx, 0x82a8(%rip)      # 0x18000e168
180005ec0:     	cmpb	$0x1, %cl
180005ec3:     	jbe	0x180005ed0 <numba_list_iter_next+0xe10>
180005ec5:     	andq	$-0x41, %rdx
180005ec9:     	movq	%rdx, 0x8298(%rip)      # 0x18000e168
180005ed0:     	btl	$0x15, %r9d
180005ed5:     	jae	0x180005eec <numba_list_iter_next+0xe2c>
180005ed7:     	movq	0x20(%rsp), %rax
180005edc:     	btq	$0x13, %rax
180005ee1:     	jae	0x180005eec <numba_list_iter_next+0xe2c>
180005ee3:     	btrq	$0x7, 0x827c(%rip)      # 0x18000e168
180005eec:     	movq	0x28(%rsp), %rbx
180005ef1:     	xorl	%eax, %eax
180005ef3:     	movq	0x30(%rsp), %rbp
180005ef8:     	movq	0x38(%rsp), %rsi
180005efd:     	addq	$0x10, %rsp
180005f01:     	popq	%rdi
180005f02:     	retq
180005f03:     	int3
180005f04:     	movl	$0x1, %eax
180005f09:     	retq
180005f0a:     	int3
180005f0b:     	int3
180005f0c:     	xorl	%eax, %eax
180005f0e:     	cmpl	%eax, 0x825c(%rip)      # 0x18000e170
180005f14:     	setne	%al
180005f17:     	retq
180005f18:     	int3
180005f19:     	int3
180005f1a:     	int3
180005f1b:     	int3
180005f1c:     	int3
180005f1d:     	int3
180005f1e:     	int3
180005f1f:     	int3
180005f20:     	jmpq	*0x1122(%rip)           # 0x180007048
180005f26:     	jmpq	*0x1124(%rip)           # 0x180007050
180005f2c:     	jmpq	*0x114e(%rip)           # 0x180007080
180005f32:     	jmpq	*0x1160(%rip)           # 0x180007098
180005f38:     	jmpq	*0x1162(%rip)           # 0x1800070a0
180005f3e:     	jmpq	*0x1164(%rip)           # 0x1800070a8
180005f44:     	jmpq	*0x1166(%rip)           # 0x1800070b0
180005f4a:     	jmpq	*0x1168(%rip)           # 0x1800070b8
180005f50:     	jmpq	*0x116a(%rip)           # 0x1800070c0
180005f56:     	jmpq	*0x116c(%rip)           # 0x1800070c8
180005f5c:     	jmpq	*0x112e(%rip)           # 0x180007090
180005f62:     	int3
180005f63:     	int3
180005f64:     	movb	$0x1, %al
180005f66:     	retq
180005f67:     	int3
180005f68:     	xorl	%eax, %eax
180005f6a:     	retq
180005f6b:     	jmpq	*0x10cf(%rip)           # 0x180007040
180005f71:     	jmpq	*0x10c1(%rip)           # 0x180007038
180005f77:     	jmpq	*0x115b(%rip)           # 0x1800070d8
180005f7d:     	jmpq	*0x115d(%rip)           # 0x1800070e0
180005f83:     	int3
180005f84:     	int3
180005f85:     	int3
180005f86:     	int3
180005f87:     	int3
180005f88:     	int3
180005f89:     	int3
180005f8a:     	int3
180005f8b:     	int3
180005f8c:     	int3
180005f8d:     	int3
180005f8e:     	int3
180005f8f:     	int3
180005f90:     	int3
180005f91:     	int3
180005f92:     	int3
180005f93:     	int3
180005f94:     	int3
180005f95:     	int3
180005f96:     	nopw	(%rax,%rax)
180005fa0:     	jmpq	*%rax
180005fa2:     	int3
180005fa3:     	int3
180005fa4:     	int3
180005fa5:     	int3
180005fa6:     	int3
180005fa7:     	int3
180005fa8:     	int3
180005fa9:     	int3
180005faa:     	int3
180005fab:     	int3
180005fac:     	int3
180005fad:     	int3
180005fae:     	int3
180005faf:     	int3
180005fb0:     	int3
180005fb1:     	int3
180005fb2:     	int3
180005fb3:     	int3
180005fb4:     	int3
180005fb5:     	int3
180005fb6:     	nopw	(%rax,%rax)
180005fc0:     	jmpq	*0x1352(%rip)           # 0x180007318
180005fc6:     	pushq	%rbp
180005fc8:     	subq	$0x20, %rsp
180005fcc:     	movq	%rdx, %rbp
180005fcf:     	movb	0x40(%rbp), %cl
180005fd2:     	addq	$0x20, %rsp
180005fd6:     	popq	%rbp
180005fd7:     	jmp	0x180005b8c <numba_list_iter_next+0xacc>
180005fdc:     	int3
180005fdd:     	pushq	%rbp
180005fdf:     	subq	$0x20, %rsp
180005fe3:     	movq	%rdx, %rbp
180005fe6:     	movb	0x20(%rbp), %cl
180005fe9:     	callq	0x180005b8c <numba_list_iter_next+0xacc>
180005fee:     	nop
180005fef:     	addq	$0x20, %rsp
180005ff3:     	popq	%rbp
180005ff4:     	retq
180005ff5:     	int3
180005ff6:     	pushq	%rbp
180005ff8:     	subq	$0x20, %rsp
180005ffc:     	movq	%rdx, %rbp
180005fff:     	addq	$0x20, %rsp
180006003:     	popq	%rbp
180006004:     	jmp	0x180005a18 <numba_list_iter_next+0x958>
180006009:     	int3
18000600a:     	pushq	%rbp
18000600c:     	subq	$0x30, %rsp
180006010:     	movq	%rdx, %rbp
180006013:     	movq	(%rcx), %rax
180006016:     	movl	(%rax), %edx
180006018:     	movq	%rcx, 0x28(%rsp)
18000601d:     	movl	%edx, 0x20(%rsp)
180006021:     	leaq	-0xbd8(%rip), %r9       # 0x180005450 <numba_list_iter_next+0x390>
180006028:     	movq	0x70(%rbp), %r8
18000602c:     	movl	0x68(%rbp), %edx
18000602f:     	movq	0x60(%rbp), %rcx
180006033:     	callq	0x180005988 <numba_list_iter_next+0x8c8>
180006038:     	nop
180006039:     	addq	$0x30, %rsp
18000603d:     	popq	%rbp
18000603e:     	retq
18000603f:     	int3
180006040:     	pushq	%rbp
180006042:     	movq	%rdx, %rbp
180006045:     	movq	(%rcx), %rax
180006048:     	xorl	%ecx, %ecx
18000604a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180006050:     	sete	%cl
180006053:     	movl	%ecx, %eax
180006055:     	popq	%rbp
180006056:     	retq
180006057:     	int3
