
D:\Code\Datathon\recompyler-codex-20261111\wave5-study\results\bin\scimark.exe:	file format coff-x86-64

Disassembly of section .text:

0000000140001000 <.text>:
140001000:     	pushq	%r15
140001002:     	pushq	%r14
140001004:     	pushq	%r13
140001006:     	pushq	%r12
140001008:     	pushq	%rsi
140001009:     	pushq	%rdi
14000100a:     	pushq	%rbp
14000100b:     	pushq	%rbx
14000100c:     	subq	$0x4e8, %rsp            # imm = 0x4E8
140001013:     	vmovapd	%xmm15, 0x4d0(%rsp)
14000101c:     	vmovapd	%xmm14, 0x4c0(%rsp)
140001025:     	vmovapd	%xmm13, 0x4b0(%rsp)
14000102e:     	vmovapd	%xmm12, 0x4a0(%rsp)
140001037:     	vmovapd	%xmm11, 0x490(%rsp)
140001040:     	vmovdqa	%xmm10, 0x480(%rsp)
140001049:     	vmovaps	%xmm9, 0x470(%rsp)
140001052:     	vmovdqa	%xmm8, 0x460(%rsp)
14000105b:     	vmovaps	%xmm7, 0x450(%rsp)
140001064:     	vmovaps	%xmm6, 0x440(%rsp)
14000106d:     	movl	$0xa, 0x7c(%rsp)
140001075:     	cmpl	$0x2, %ecx
140001078:     	jl	0x140001090 <.text+0x90>
14000107a:     	movq	0x8(%rdx), %rcx
14000107e:     	callq	*0x4fe4(%rip)           # 0x140006068
140001084:     	movl	%eax, 0x7c(%rsp)
140001088:     	testl	%eax, %eax
14000108a:     	jle	0x140004f04 <.text+0x3f04>
140001090:     	vmovddup	0x51a8(%rip), %xmm0     # xmm0 = mem[0,0]
                                                # 0x140006240
140001098:     	vmovsd	0x51a0(%rip), %xmm1     # 0x140006240
1400010a0:     	vmovddup	0x5298(%rip), %xmm2     # xmm2 = mem[0,0]
                                                # 0x140006340
1400010a8:     	vmovsd	0x5198(%rip), %xmm15    # 0x140006248
1400010b0:     	vmovsd	0x5198(%rip), %xmm6     # 0x140006250
1400010b8:     	vmovsd	0x52a0(%rip), %xmm13    # 0x140006360
1400010c0:     	vmovsd	0x52b0(%rip), %xmm7     # 0x140006378
1400010c8:     	vmovsd	0x52b0(%rip), %xmm9     # 0x140006380
1400010d0:     	vpbroadcastd	0x52af(%rip), %xmm10 # 0x140006388
1400010d9:     	movq	0x4fa8(%rip), %rdi      # 0x140006088
1400010e0:     	vpcmpeqd	%xmm8, %xmm8, %xmm8
1400010e5:     	xorl	%eax, %eax
1400010e7:     	vxorpd	%xmm14, %xmm14, %xmm14
1400010ec:     	vmovsd	%xmm1, 0xc8(%rsp)
1400010f5:     	vmovapd	%xmm2, 0x150(%rsp)
1400010fe:     	vmovapd	%xmm0, 0x100(%rsp)
140001107:     	vmovapd	%xmm0, 0x110(%rsp)
140001110:     	leaq	0x2b0(%rsp), %rcx
140001118:     	movl	$0x1, %edx
14000111d:     	movq	%rax, 0x140(%rsp)
140001125:     	callq	*0x506d(%rip)           # 0x140006198
14000112b:     	movl	0x2b8(%rsp), %ecx
140001132:     	movq	0x2b0(%rsp), %rax
14000113a:     	movl	$0x8, %edx
14000113f:     	movl	%ecx, 0x40(%rsp)
140001143:     	movl	$0x2710, %ecx           # imm = 0x2710
140001148:     	movq	%rax, 0x30(%rsp)
14000114d:     	callq	*0x4f2d(%rip)           # 0x140006080
140001153:     	movq	%rax, %rcx
140001156:     	addq	$0x678, %rcx            # imm = 0x678
14000115d:     	movl	$0x1, %edx
140001162:     	xorl	%r9d, %r9d
140001165:     	movq	%rcx, %r8
140001168:     	nopl	(%rax,%rax)
140001170:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001177:     	vmovsd	0x320(%rax,%r10), %xmm0
140001181:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001188:     	nopl	(%rax,%rax)
140001190:     	vmovsd	-0x360(%r8,%r10), %xmm1
14000119a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
1400011a1:     	vmovsd	-0x358(%r8,%r10), %xmm2
1400011ab:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
1400011b5:     	vaddsd	%xmm0, %xmm1, %xmm0
1400011b9:     	vmovsd	-0x38(%r8,%r10), %xmm1
1400011c0:     	vaddsd	%xmm1, %xmm0, %xmm0
1400011c4:     	vmulsd	%xmm6, %xmm1, %xmm1
1400011c8:     	vmulsd	%xmm0, %xmm15, %xmm0
1400011cc:     	vsubsd	%xmm3, %xmm0, %xmm0
1400011d0:     	vmovsd	%xmm0, -0x40(%r8,%r10)
1400011d7:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
1400011e1:     	vaddsd	%xmm0, %xmm2, %xmm0
1400011e5:     	vmovsd	-0x30(%r8,%r10), %xmm2
1400011ec:     	vaddsd	%xmm2, %xmm0, %xmm0
1400011f0:     	vmulsd	%xmm6, %xmm2, %xmm2
1400011f4:     	vmulsd	%xmm0, %xmm15, %xmm0
1400011f8:     	vsubsd	%xmm1, %xmm0, %xmm0
1400011fc:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001203:     	vmovsd	-0x350(%r8,%r10), %xmm1
14000120d:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001217:     	vaddsd	%xmm0, %xmm1, %xmm0
14000121b:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001222:     	vaddsd	%xmm1, %xmm0, %xmm0
140001226:     	vmulsd	%xmm6, %xmm1, %xmm1
14000122a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000122e:     	vsubsd	%xmm2, %xmm0, %xmm0
140001232:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001239:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001243:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
14000124d:     	vaddsd	%xmm0, %xmm2, %xmm0
140001251:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001258:     	vaddsd	%xmm2, %xmm0, %xmm0
14000125c:     	vmulsd	%xmm6, %xmm2, %xmm2
140001260:     	vmulsd	%xmm0, %xmm15, %xmm0
140001264:     	vsubsd	%xmm1, %xmm0, %xmm0
140001268:     	vmovsd	%xmm0, -0x28(%r8,%r10)
14000126f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001279:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001283:     	vaddsd	%xmm0, %xmm1, %xmm0
140001287:     	vmovsd	-0x18(%r8,%r10), %xmm1
14000128e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001292:     	vmulsd	%xmm6, %xmm1, %xmm1
140001296:     	vmulsd	%xmm0, %xmm15, %xmm0
14000129a:     	vsubsd	%xmm2, %xmm0, %xmm0
14000129e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
1400012a5:     	vmovsd	-0x338(%r8,%r10), %xmm2
1400012af:     	vmovsd	-0x10(%r8,%r10), %xmm3
1400012b6:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
1400012c0:     	vaddsd	%xmm0, %xmm2, %xmm0
1400012c4:     	vaddsd	%xmm3, %xmm0, %xmm0
1400012c8:     	vmulsd	%xmm0, %xmm15, %xmm0
1400012cc:     	vsubsd	%xmm1, %xmm0, %xmm0
1400012d0:     	vmovsd	%xmm0, -0x18(%r8,%r10)
1400012d7:     	vmovsd	-0x330(%r8,%r10), %xmm1
1400012e1:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
1400012eb:     	vaddsd	%xmm0, %xmm1, %xmm0
1400012ef:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
1400012f6:     	vmulsd	%xmm6, %xmm3, %xmm1
1400012fa:     	vmulsd	%xmm0, %xmm15, %xmm0
1400012fe:     	vsubsd	%xmm1, %xmm0, %xmm0
140001302:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001309:     	addq	$0x38, %r10
14000130d:     	jne	0x140001190 <.text+0x190>
140001313:     	incq	%rdx
140001316:     	incq	%r9
140001319:     	addq	$0x320, %r8             # imm = 0x320
140001320:     	cmpq	$0x63, %rdx
140001324:     	jne	0x140001170 <.text+0x170>
14000132a:     	movl	$0x1, %edx
14000132f:     	movq	%rcx, %r8
140001332:     	xorl	%r9d, %r9d
140001335:     	nopw	%cs:(%rax,%rax)
140001340:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001347:     	vmovsd	0x320(%rax,%r10), %xmm0
140001351:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001358:     	nopl	(%rax,%rax)
140001360:     	vmovsd	-0x360(%r8,%r10), %xmm1
14000136a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001371:     	vmovsd	-0x358(%r8,%r10), %xmm2
14000137b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001385:     	vaddsd	%xmm0, %xmm1, %xmm0
140001389:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001390:     	vaddsd	%xmm1, %xmm0, %xmm0
140001394:     	vmulsd	%xmm6, %xmm1, %xmm1
140001398:     	vmulsd	%xmm0, %xmm15, %xmm0
14000139c:     	vsubsd	%xmm3, %xmm0, %xmm0
1400013a0:     	vmovsd	%xmm0, -0x40(%r8,%r10)
1400013a7:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
1400013b1:     	vaddsd	%xmm0, %xmm2, %xmm0
1400013b5:     	vmovsd	-0x30(%r8,%r10), %xmm2
1400013bc:     	vaddsd	%xmm2, %xmm0, %xmm0
1400013c0:     	vmulsd	%xmm6, %xmm2, %xmm2
1400013c4:     	vmulsd	%xmm0, %xmm15, %xmm0
1400013c8:     	vsubsd	%xmm1, %xmm0, %xmm0
1400013cc:     	vmovsd	%xmm0, -0x38(%r8,%r10)
1400013d3:     	vmovsd	-0x350(%r8,%r10), %xmm1
1400013dd:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
1400013e7:     	vaddsd	%xmm0, %xmm1, %xmm0
1400013eb:     	vmovsd	-0x28(%r8,%r10), %xmm1
1400013f2:     	vaddsd	%xmm1, %xmm0, %xmm0
1400013f6:     	vmulsd	%xmm6, %xmm1, %xmm1
1400013fa:     	vmulsd	%xmm0, %xmm15, %xmm0
1400013fe:     	vsubsd	%xmm2, %xmm0, %xmm0
140001402:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001409:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001413:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
14000141d:     	vaddsd	%xmm0, %xmm2, %xmm0
140001421:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001428:     	vaddsd	%xmm2, %xmm0, %xmm0
14000142c:     	vmulsd	%xmm6, %xmm2, %xmm2
140001430:     	vmulsd	%xmm0, %xmm15, %xmm0
140001434:     	vsubsd	%xmm1, %xmm0, %xmm0
140001438:     	vmovsd	%xmm0, -0x28(%r8,%r10)
14000143f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001449:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001453:     	vaddsd	%xmm0, %xmm1, %xmm0
140001457:     	vmovsd	-0x18(%r8,%r10), %xmm1
14000145e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001462:     	vmulsd	%xmm6, %xmm1, %xmm1
140001466:     	vmulsd	%xmm0, %xmm15, %xmm0
14000146a:     	vsubsd	%xmm2, %xmm0, %xmm0
14000146e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001475:     	vmovsd	-0x338(%r8,%r10), %xmm2
14000147f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001486:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001490:     	vaddsd	%xmm0, %xmm2, %xmm0
140001494:     	vaddsd	%xmm3, %xmm0, %xmm0
140001498:     	vmulsd	%xmm0, %xmm15, %xmm0
14000149c:     	vsubsd	%xmm1, %xmm0, %xmm0
1400014a0:     	vmovsd	%xmm0, -0x18(%r8,%r10)
1400014a7:     	vmovsd	-0x330(%r8,%r10), %xmm1
1400014b1:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
1400014bb:     	vaddsd	%xmm0, %xmm1, %xmm0
1400014bf:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
1400014c6:     	vmulsd	%xmm6, %xmm3, %xmm1
1400014ca:     	vmulsd	%xmm0, %xmm15, %xmm0
1400014ce:     	vsubsd	%xmm1, %xmm0, %xmm0
1400014d2:     	vmovsd	%xmm0, -0x10(%r8,%r10)
1400014d9:     	addq	$0x38, %r10
1400014dd:     	jne	0x140001360 <.text+0x360>
1400014e3:     	incq	%rdx
1400014e6:     	incq	%r9
1400014e9:     	addq	$0x320, %r8             # imm = 0x320
1400014f0:     	cmpq	$0x63, %rdx
1400014f4:     	jne	0x140001340 <.text+0x340>
1400014fa:     	movl	$0x1, %edx
1400014ff:     	movq	%rcx, %r8
140001502:     	xorl	%r9d, %r9d
140001505:     	nopw	%cs:(%rax,%rax)
140001510:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001517:     	vmovsd	0x320(%rax,%r10), %xmm0
140001521:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001528:     	nopl	(%rax,%rax)
140001530:     	vmovsd	-0x360(%r8,%r10), %xmm1
14000153a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001541:     	vmovsd	-0x358(%r8,%r10), %xmm2
14000154b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001555:     	vaddsd	%xmm0, %xmm1, %xmm0
140001559:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001560:     	vaddsd	%xmm1, %xmm0, %xmm0
140001564:     	vmulsd	%xmm6, %xmm1, %xmm1
140001568:     	vmulsd	%xmm0, %xmm15, %xmm0
14000156c:     	vsubsd	%xmm3, %xmm0, %xmm0
140001570:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001577:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001581:     	vaddsd	%xmm0, %xmm2, %xmm0
140001585:     	vmovsd	-0x30(%r8,%r10), %xmm2
14000158c:     	vaddsd	%xmm2, %xmm0, %xmm0
140001590:     	vmulsd	%xmm6, %xmm2, %xmm2
140001594:     	vmulsd	%xmm0, %xmm15, %xmm0
140001598:     	vsubsd	%xmm1, %xmm0, %xmm0
14000159c:     	vmovsd	%xmm0, -0x38(%r8,%r10)
1400015a3:     	vmovsd	-0x350(%r8,%r10), %xmm1
1400015ad:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
1400015b7:     	vaddsd	%xmm0, %xmm1, %xmm0
1400015bb:     	vmovsd	-0x28(%r8,%r10), %xmm1
1400015c2:     	vaddsd	%xmm1, %xmm0, %xmm0
1400015c6:     	vmulsd	%xmm6, %xmm1, %xmm1
1400015ca:     	vmulsd	%xmm0, %xmm15, %xmm0
1400015ce:     	vsubsd	%xmm2, %xmm0, %xmm0
1400015d2:     	vmovsd	%xmm0, -0x30(%r8,%r10)
1400015d9:     	vmovsd	-0x348(%r8,%r10), %xmm2
1400015e3:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
1400015ed:     	vaddsd	%xmm0, %xmm2, %xmm0
1400015f1:     	vmovsd	-0x20(%r8,%r10), %xmm2
1400015f8:     	vaddsd	%xmm2, %xmm0, %xmm0
1400015fc:     	vmulsd	%xmm6, %xmm2, %xmm2
140001600:     	vmulsd	%xmm0, %xmm15, %xmm0
140001604:     	vsubsd	%xmm1, %xmm0, %xmm0
140001608:     	vmovsd	%xmm0, -0x28(%r8,%r10)
14000160f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001619:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001623:     	vaddsd	%xmm0, %xmm1, %xmm0
140001627:     	vmovsd	-0x18(%r8,%r10), %xmm1
14000162e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001632:     	vmulsd	%xmm6, %xmm1, %xmm1
140001636:     	vmulsd	%xmm0, %xmm15, %xmm0
14000163a:     	vsubsd	%xmm2, %xmm0, %xmm0
14000163e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001645:     	vmovsd	-0x338(%r8,%r10), %xmm2
14000164f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001656:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001660:     	vaddsd	%xmm0, %xmm2, %xmm0
140001664:     	vaddsd	%xmm3, %xmm0, %xmm0
140001668:     	vmulsd	%xmm0, %xmm15, %xmm0
14000166c:     	vsubsd	%xmm1, %xmm0, %xmm0
140001670:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001677:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001681:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
14000168b:     	vaddsd	%xmm0, %xmm1, %xmm0
14000168f:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001696:     	vmulsd	%xmm6, %xmm3, %xmm1
14000169a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000169e:     	vsubsd	%xmm1, %xmm0, %xmm0
1400016a2:     	vmovsd	%xmm0, -0x10(%r8,%r10)
1400016a9:     	addq	$0x38, %r10
1400016ad:     	jne	0x140001530 <.text+0x530>
1400016b3:     	incq	%rdx
1400016b6:     	incq	%r9
1400016b9:     	addq	$0x320, %r8             # imm = 0x320
1400016c0:     	cmpq	$0x63, %rdx
1400016c4:     	jne	0x140001510 <.text+0x510>
1400016ca:     	movl	$0x1, %edx
1400016cf:     	movq	%rcx, %r8
1400016d2:     	xorl	%r9d, %r9d
1400016d5:     	nopw	%cs:(%rax,%rax)
1400016e0:     	imulq	$0x320, %r9, %r10       # imm = 0x320
1400016e7:     	vmovsd	0x320(%rax,%r10), %xmm0
1400016f1:     	movq	$-0x310, %r10           # imm = 0xFCF0
1400016f8:     	nopl	(%rax,%rax)
140001700:     	vmovsd	-0x360(%r8,%r10), %xmm1
14000170a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001711:     	vmovsd	-0x358(%r8,%r10), %xmm2
14000171b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001725:     	vaddsd	%xmm0, %xmm1, %xmm0
140001729:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001730:     	vaddsd	%xmm1, %xmm0, %xmm0
140001734:     	vmulsd	%xmm6, %xmm1, %xmm1
140001738:     	vmulsd	%xmm0, %xmm15, %xmm0
14000173c:     	vsubsd	%xmm3, %xmm0, %xmm0
140001740:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001747:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001751:     	vaddsd	%xmm0, %xmm2, %xmm0
140001755:     	vmovsd	-0x30(%r8,%r10), %xmm2
14000175c:     	vaddsd	%xmm2, %xmm0, %xmm0
140001760:     	vmulsd	%xmm6, %xmm2, %xmm2
140001764:     	vmulsd	%xmm0, %xmm15, %xmm0
140001768:     	vsubsd	%xmm1, %xmm0, %xmm0
14000176c:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001773:     	vmovsd	-0x350(%r8,%r10), %xmm1
14000177d:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001787:     	vaddsd	%xmm0, %xmm1, %xmm0
14000178b:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001792:     	vaddsd	%xmm1, %xmm0, %xmm0
140001796:     	vmulsd	%xmm6, %xmm1, %xmm1
14000179a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000179e:     	vsubsd	%xmm2, %xmm0, %xmm0
1400017a2:     	vmovsd	%xmm0, -0x30(%r8,%r10)
1400017a9:     	vmovsd	-0x348(%r8,%r10), %xmm2
1400017b3:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
1400017bd:     	vaddsd	%xmm0, %xmm2, %xmm0
1400017c1:     	vmovsd	-0x20(%r8,%r10), %xmm2
1400017c8:     	vaddsd	%xmm2, %xmm0, %xmm0
1400017cc:     	vmulsd	%xmm6, %xmm2, %xmm2
1400017d0:     	vmulsd	%xmm0, %xmm15, %xmm0
1400017d4:     	vsubsd	%xmm1, %xmm0, %xmm0
1400017d8:     	vmovsd	%xmm0, -0x28(%r8,%r10)
1400017df:     	vmovsd	-0x340(%r8,%r10), %xmm1
1400017e9:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
1400017f3:     	vaddsd	%xmm0, %xmm1, %xmm0
1400017f7:     	vmovsd	-0x18(%r8,%r10), %xmm1
1400017fe:     	vaddsd	%xmm1, %xmm0, %xmm0
140001802:     	vmulsd	%xmm6, %xmm1, %xmm1
140001806:     	vmulsd	%xmm0, %xmm15, %xmm0
14000180a:     	vsubsd	%xmm2, %xmm0, %xmm0
14000180e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001815:     	vmovsd	-0x338(%r8,%r10), %xmm2
14000181f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001826:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001830:     	vaddsd	%xmm0, %xmm2, %xmm0
140001834:     	vaddsd	%xmm3, %xmm0, %xmm0
140001838:     	vmulsd	%xmm0, %xmm15, %xmm0
14000183c:     	vsubsd	%xmm1, %xmm0, %xmm0
140001840:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001847:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001851:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
14000185b:     	vaddsd	%xmm0, %xmm1, %xmm0
14000185f:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001866:     	vmulsd	%xmm6, %xmm3, %xmm1
14000186a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000186e:     	vsubsd	%xmm1, %xmm0, %xmm0
140001872:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001879:     	addq	$0x38, %r10
14000187d:     	jne	0x140001700 <.text+0x700>
140001883:     	incq	%rdx
140001886:     	incq	%r9
140001889:     	addq	$0x320, %r8             # imm = 0x320
140001890:     	cmpq	$0x63, %rdx
140001894:     	jne	0x1400016e0 <.text+0x6e0>
14000189a:     	movl	$0x1, %edx
14000189f:     	movq	%rcx, %r8
1400018a2:     	xorl	%r9d, %r9d
1400018a5:     	nopw	%cs:(%rax,%rax)
1400018b0:     	imulq	$0x320, %r9, %r10       # imm = 0x320
1400018b7:     	vmovsd	0x320(%rax,%r10), %xmm0
1400018c1:     	movq	$-0x310, %r10           # imm = 0xFCF0
1400018c8:     	nopl	(%rax,%rax)
1400018d0:     	vmovsd	-0x360(%r8,%r10), %xmm1
1400018da:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
1400018e1:     	vmovsd	-0x358(%r8,%r10), %xmm2
1400018eb:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
1400018f5:     	vaddsd	%xmm0, %xmm1, %xmm0
1400018f9:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001900:     	vaddsd	%xmm1, %xmm0, %xmm0
140001904:     	vmulsd	%xmm6, %xmm1, %xmm1
140001908:     	vmulsd	%xmm0, %xmm15, %xmm0
14000190c:     	vsubsd	%xmm3, %xmm0, %xmm0
140001910:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001917:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001921:     	vaddsd	%xmm0, %xmm2, %xmm0
140001925:     	vmovsd	-0x30(%r8,%r10), %xmm2
14000192c:     	vaddsd	%xmm2, %xmm0, %xmm0
140001930:     	vmulsd	%xmm6, %xmm2, %xmm2
140001934:     	vmulsd	%xmm0, %xmm15, %xmm0
140001938:     	vsubsd	%xmm1, %xmm0, %xmm0
14000193c:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001943:     	vmovsd	-0x350(%r8,%r10), %xmm1
14000194d:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001957:     	vaddsd	%xmm0, %xmm1, %xmm0
14000195b:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001962:     	vaddsd	%xmm1, %xmm0, %xmm0
140001966:     	vmulsd	%xmm6, %xmm1, %xmm1
14000196a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000196e:     	vsubsd	%xmm2, %xmm0, %xmm0
140001972:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001979:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001983:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
14000198d:     	vaddsd	%xmm0, %xmm2, %xmm0
140001991:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001998:     	vaddsd	%xmm2, %xmm0, %xmm0
14000199c:     	vmulsd	%xmm6, %xmm2, %xmm2
1400019a0:     	vmulsd	%xmm0, %xmm15, %xmm0
1400019a4:     	vsubsd	%xmm1, %xmm0, %xmm0
1400019a8:     	vmovsd	%xmm0, -0x28(%r8,%r10)
1400019af:     	vmovsd	-0x340(%r8,%r10), %xmm1
1400019b9:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
1400019c3:     	vaddsd	%xmm0, %xmm1, %xmm0
1400019c7:     	vmovsd	-0x18(%r8,%r10), %xmm1
1400019ce:     	vaddsd	%xmm1, %xmm0, %xmm0
1400019d2:     	vmulsd	%xmm6, %xmm1, %xmm1
1400019d6:     	vmulsd	%xmm0, %xmm15, %xmm0
1400019da:     	vsubsd	%xmm2, %xmm0, %xmm0
1400019de:     	vmovsd	%xmm0, -0x20(%r8,%r10)
1400019e5:     	vmovsd	-0x338(%r8,%r10), %xmm2
1400019ef:     	vmovsd	-0x10(%r8,%r10), %xmm3
1400019f6:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001a00:     	vaddsd	%xmm0, %xmm2, %xmm0
140001a04:     	vaddsd	%xmm3, %xmm0, %xmm0
140001a08:     	vmulsd	%xmm0, %xmm15, %xmm0
140001a0c:     	vsubsd	%xmm1, %xmm0, %xmm0
140001a10:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001a17:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001a21:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
140001a2b:     	vaddsd	%xmm0, %xmm1, %xmm0
140001a2f:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001a36:     	vmulsd	%xmm6, %xmm3, %xmm1
140001a3a:     	vmulsd	%xmm0, %xmm15, %xmm0
140001a3e:     	vsubsd	%xmm1, %xmm0, %xmm0
140001a42:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001a49:     	addq	$0x38, %r10
140001a4d:     	jne	0x1400018d0 <.text+0x8d0>
140001a53:     	incq	%rdx
140001a56:     	incq	%r9
140001a59:     	addq	$0x320, %r8             # imm = 0x320
140001a60:     	cmpq	$0x63, %rdx
140001a64:     	jne	0x1400018b0 <.text+0x8b0>
140001a6a:     	movl	$0x1, %edx
140001a6f:     	movq	%rcx, %r8
140001a72:     	xorl	%r9d, %r9d
140001a75:     	nopw	%cs:(%rax,%rax)
140001a80:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001a87:     	vmovsd	0x320(%rax,%r10), %xmm0
140001a91:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001a98:     	nopl	(%rax,%rax)
140001aa0:     	vmovsd	-0x360(%r8,%r10), %xmm1
140001aaa:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001ab1:     	vmovsd	-0x358(%r8,%r10), %xmm2
140001abb:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001ac5:     	vaddsd	%xmm0, %xmm1, %xmm0
140001ac9:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001ad0:     	vaddsd	%xmm1, %xmm0, %xmm0
140001ad4:     	vmulsd	%xmm6, %xmm1, %xmm1
140001ad8:     	vmulsd	%xmm0, %xmm15, %xmm0
140001adc:     	vsubsd	%xmm3, %xmm0, %xmm0
140001ae0:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001ae7:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001af1:     	vaddsd	%xmm0, %xmm2, %xmm0
140001af5:     	vmovsd	-0x30(%r8,%r10), %xmm2
140001afc:     	vaddsd	%xmm2, %xmm0, %xmm0
140001b00:     	vmulsd	%xmm6, %xmm2, %xmm2
140001b04:     	vmulsd	%xmm0, %xmm15, %xmm0
140001b08:     	vsubsd	%xmm1, %xmm0, %xmm0
140001b0c:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001b13:     	vmovsd	-0x350(%r8,%r10), %xmm1
140001b1d:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001b27:     	vaddsd	%xmm0, %xmm1, %xmm0
140001b2b:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001b32:     	vaddsd	%xmm1, %xmm0, %xmm0
140001b36:     	vmulsd	%xmm6, %xmm1, %xmm1
140001b3a:     	vmulsd	%xmm0, %xmm15, %xmm0
140001b3e:     	vsubsd	%xmm2, %xmm0, %xmm0
140001b42:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001b49:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001b53:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
140001b5d:     	vaddsd	%xmm0, %xmm2, %xmm0
140001b61:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001b68:     	vaddsd	%xmm2, %xmm0, %xmm0
140001b6c:     	vmulsd	%xmm6, %xmm2, %xmm2
140001b70:     	vmulsd	%xmm0, %xmm15, %xmm0
140001b74:     	vsubsd	%xmm1, %xmm0, %xmm0
140001b78:     	vmovsd	%xmm0, -0x28(%r8,%r10)
140001b7f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001b89:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001b93:     	vaddsd	%xmm0, %xmm1, %xmm0
140001b97:     	vmovsd	-0x18(%r8,%r10), %xmm1
140001b9e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001ba2:     	vmulsd	%xmm6, %xmm1, %xmm1
140001ba6:     	vmulsd	%xmm0, %xmm15, %xmm0
140001baa:     	vsubsd	%xmm2, %xmm0, %xmm0
140001bae:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001bb5:     	vmovsd	-0x338(%r8,%r10), %xmm2
140001bbf:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001bc6:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001bd0:     	vaddsd	%xmm0, %xmm2, %xmm0
140001bd4:     	vaddsd	%xmm3, %xmm0, %xmm0
140001bd8:     	vmulsd	%xmm0, %xmm15, %xmm0
140001bdc:     	vsubsd	%xmm1, %xmm0, %xmm0
140001be0:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001be7:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001bf1:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
140001bfb:     	vaddsd	%xmm0, %xmm1, %xmm0
140001bff:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001c06:     	vmulsd	%xmm6, %xmm3, %xmm1
140001c0a:     	vmulsd	%xmm0, %xmm15, %xmm0
140001c0e:     	vsubsd	%xmm1, %xmm0, %xmm0
140001c12:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001c19:     	addq	$0x38, %r10
140001c1d:     	jne	0x140001aa0 <.text+0xaa0>
140001c23:     	incq	%rdx
140001c26:     	incq	%r9
140001c29:     	addq	$0x320, %r8             # imm = 0x320
140001c30:     	cmpq	$0x63, %rdx
140001c34:     	jne	0x140001a80 <.text+0xa80>
140001c3a:     	movl	$0x1, %edx
140001c3f:     	movq	%rcx, %r8
140001c42:     	xorl	%r9d, %r9d
140001c45:     	nopw	%cs:(%rax,%rax)
140001c50:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001c57:     	vmovsd	0x320(%rax,%r10), %xmm0
140001c61:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001c68:     	nopl	(%rax,%rax)
140001c70:     	vmovsd	-0x360(%r8,%r10), %xmm1
140001c7a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001c81:     	vmovsd	-0x358(%r8,%r10), %xmm2
140001c8b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001c95:     	vaddsd	%xmm0, %xmm1, %xmm0
140001c99:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001ca0:     	vaddsd	%xmm1, %xmm0, %xmm0
140001ca4:     	vmulsd	%xmm6, %xmm1, %xmm1
140001ca8:     	vmulsd	%xmm0, %xmm15, %xmm0
140001cac:     	vsubsd	%xmm3, %xmm0, %xmm0
140001cb0:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001cb7:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001cc1:     	vaddsd	%xmm0, %xmm2, %xmm0
140001cc5:     	vmovsd	-0x30(%r8,%r10), %xmm2
140001ccc:     	vaddsd	%xmm2, %xmm0, %xmm0
140001cd0:     	vmulsd	%xmm6, %xmm2, %xmm2
140001cd4:     	vmulsd	%xmm0, %xmm15, %xmm0
140001cd8:     	vsubsd	%xmm1, %xmm0, %xmm0
140001cdc:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001ce3:     	vmovsd	-0x350(%r8,%r10), %xmm1
140001ced:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001cf7:     	vaddsd	%xmm0, %xmm1, %xmm0
140001cfb:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001d02:     	vaddsd	%xmm1, %xmm0, %xmm0
140001d06:     	vmulsd	%xmm6, %xmm1, %xmm1
140001d0a:     	vmulsd	%xmm0, %xmm15, %xmm0
140001d0e:     	vsubsd	%xmm2, %xmm0, %xmm0
140001d12:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001d19:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001d23:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
140001d2d:     	vaddsd	%xmm0, %xmm2, %xmm0
140001d31:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001d38:     	vaddsd	%xmm2, %xmm0, %xmm0
140001d3c:     	vmulsd	%xmm6, %xmm2, %xmm2
140001d40:     	vmulsd	%xmm0, %xmm15, %xmm0
140001d44:     	vsubsd	%xmm1, %xmm0, %xmm0
140001d48:     	vmovsd	%xmm0, -0x28(%r8,%r10)
140001d4f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001d59:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001d63:     	vaddsd	%xmm0, %xmm1, %xmm0
140001d67:     	vmovsd	-0x18(%r8,%r10), %xmm1
140001d6e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001d72:     	vmulsd	%xmm6, %xmm1, %xmm1
140001d76:     	vmulsd	%xmm0, %xmm15, %xmm0
140001d7a:     	vsubsd	%xmm2, %xmm0, %xmm0
140001d7e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001d85:     	vmovsd	-0x338(%r8,%r10), %xmm2
140001d8f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001d96:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001da0:     	vaddsd	%xmm0, %xmm2, %xmm0
140001da4:     	vaddsd	%xmm3, %xmm0, %xmm0
140001da8:     	vmulsd	%xmm0, %xmm15, %xmm0
140001dac:     	vsubsd	%xmm1, %xmm0, %xmm0
140001db0:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001db7:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001dc1:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
140001dcb:     	vaddsd	%xmm0, %xmm1, %xmm0
140001dcf:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001dd6:     	vmulsd	%xmm6, %xmm3, %xmm1
140001dda:     	vmulsd	%xmm0, %xmm15, %xmm0
140001dde:     	vsubsd	%xmm1, %xmm0, %xmm0
140001de2:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001de9:     	addq	$0x38, %r10
140001ded:     	jne	0x140001c70 <.text+0xc70>
140001df3:     	incq	%rdx
140001df6:     	incq	%r9
140001df9:     	addq	$0x320, %r8             # imm = 0x320
140001e00:     	cmpq	$0x63, %rdx
140001e04:     	jne	0x140001c50 <.text+0xc50>
140001e0a:     	movl	$0x1, %edx
140001e0f:     	movq	%rcx, %r8
140001e12:     	xorl	%r9d, %r9d
140001e15:     	nopw	%cs:(%rax,%rax)
140001e20:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001e27:     	vmovsd	0x320(%rax,%r10), %xmm0
140001e31:     	movq	$-0x310, %r10           # imm = 0xFCF0
140001e38:     	nopl	(%rax,%rax)
140001e40:     	vmovsd	-0x360(%r8,%r10), %xmm1
140001e4a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140001e51:     	vmovsd	-0x358(%r8,%r10), %xmm2
140001e5b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140001e65:     	vaddsd	%xmm0, %xmm1, %xmm0
140001e69:     	vmovsd	-0x38(%r8,%r10), %xmm1
140001e70:     	vaddsd	%xmm1, %xmm0, %xmm0
140001e74:     	vmulsd	%xmm6, %xmm1, %xmm1
140001e78:     	vmulsd	%xmm0, %xmm15, %xmm0
140001e7c:     	vsubsd	%xmm3, %xmm0, %xmm0
140001e80:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140001e87:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140001e91:     	vaddsd	%xmm0, %xmm2, %xmm0
140001e95:     	vmovsd	-0x30(%r8,%r10), %xmm2
140001e9c:     	vaddsd	%xmm2, %xmm0, %xmm0
140001ea0:     	vmulsd	%xmm6, %xmm2, %xmm2
140001ea4:     	vmulsd	%xmm0, %xmm15, %xmm0
140001ea8:     	vsubsd	%xmm1, %xmm0, %xmm0
140001eac:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140001eb3:     	vmovsd	-0x350(%r8,%r10), %xmm1
140001ebd:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140001ec7:     	vaddsd	%xmm0, %xmm1, %xmm0
140001ecb:     	vmovsd	-0x28(%r8,%r10), %xmm1
140001ed2:     	vaddsd	%xmm1, %xmm0, %xmm0
140001ed6:     	vmulsd	%xmm6, %xmm1, %xmm1
140001eda:     	vmulsd	%xmm0, %xmm15, %xmm0
140001ede:     	vsubsd	%xmm2, %xmm0, %xmm0
140001ee2:     	vmovsd	%xmm0, -0x30(%r8,%r10)
140001ee9:     	vmovsd	-0x348(%r8,%r10), %xmm2
140001ef3:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
140001efd:     	vaddsd	%xmm0, %xmm2, %xmm0
140001f01:     	vmovsd	-0x20(%r8,%r10), %xmm2
140001f08:     	vaddsd	%xmm2, %xmm0, %xmm0
140001f0c:     	vmulsd	%xmm6, %xmm2, %xmm2
140001f10:     	vmulsd	%xmm0, %xmm15, %xmm0
140001f14:     	vsubsd	%xmm1, %xmm0, %xmm0
140001f18:     	vmovsd	%xmm0, -0x28(%r8,%r10)
140001f1f:     	vmovsd	-0x340(%r8,%r10), %xmm1
140001f29:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140001f33:     	vaddsd	%xmm0, %xmm1, %xmm0
140001f37:     	vmovsd	-0x18(%r8,%r10), %xmm1
140001f3e:     	vaddsd	%xmm1, %xmm0, %xmm0
140001f42:     	vmulsd	%xmm6, %xmm1, %xmm1
140001f46:     	vmulsd	%xmm0, %xmm15, %xmm0
140001f4a:     	vsubsd	%xmm2, %xmm0, %xmm0
140001f4e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140001f55:     	vmovsd	-0x338(%r8,%r10), %xmm2
140001f5f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140001f66:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140001f70:     	vaddsd	%xmm0, %xmm2, %xmm0
140001f74:     	vaddsd	%xmm3, %xmm0, %xmm0
140001f78:     	vmulsd	%xmm0, %xmm15, %xmm0
140001f7c:     	vsubsd	%xmm1, %xmm0, %xmm0
140001f80:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140001f87:     	vmovsd	-0x330(%r8,%r10), %xmm1
140001f91:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
140001f9b:     	vaddsd	%xmm0, %xmm1, %xmm0
140001f9f:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140001fa6:     	vmulsd	%xmm6, %xmm3, %xmm1
140001faa:     	vmulsd	%xmm0, %xmm15, %xmm0
140001fae:     	vsubsd	%xmm1, %xmm0, %xmm0
140001fb2:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140001fb9:     	addq	$0x38, %r10
140001fbd:     	jne	0x140001e40 <.text+0xe40>
140001fc3:     	incq	%rdx
140001fc6:     	incq	%r9
140001fc9:     	addq	$0x320, %r8             # imm = 0x320
140001fd0:     	cmpq	$0x63, %rdx
140001fd4:     	jne	0x140001e20 <.text+0xe20>
140001fda:     	movl	$0x1, %edx
140001fdf:     	movq	%rcx, %r8
140001fe2:     	xorl	%r9d, %r9d
140001fe5:     	nopw	%cs:(%rax,%rax)
140001ff0:     	imulq	$0x320, %r9, %r10       # imm = 0x320
140001ff7:     	vmovsd	0x320(%rax,%r10), %xmm0
140002001:     	movq	$-0x310, %r10           # imm = 0xFCF0
140002008:     	nopl	(%rax,%rax)
140002010:     	vmovsd	-0x360(%r8,%r10), %xmm1
14000201a:     	vmulsd	-0x40(%r8,%r10), %xmm6, %xmm3
140002021:     	vmovsd	-0x358(%r8,%r10), %xmm2
14000202b:     	vaddsd	0x2e0(%r8,%r10), %xmm1, %xmm1
140002035:     	vaddsd	%xmm0, %xmm1, %xmm0
140002039:     	vmovsd	-0x38(%r8,%r10), %xmm1
140002040:     	vaddsd	%xmm1, %xmm0, %xmm0
140002044:     	vmulsd	%xmm6, %xmm1, %xmm1
140002048:     	vmulsd	%xmm0, %xmm15, %xmm0
14000204c:     	vsubsd	%xmm3, %xmm0, %xmm0
140002050:     	vmovsd	%xmm0, -0x40(%r8,%r10)
140002057:     	vaddsd	0x2e8(%r8,%r10), %xmm2, %xmm2
140002061:     	vaddsd	%xmm0, %xmm2, %xmm0
140002065:     	vmovsd	-0x30(%r8,%r10), %xmm2
14000206c:     	vaddsd	%xmm2, %xmm0, %xmm0
140002070:     	vmulsd	%xmm6, %xmm2, %xmm2
140002074:     	vmulsd	%xmm0, %xmm15, %xmm0
140002078:     	vsubsd	%xmm1, %xmm0, %xmm0
14000207c:     	vmovsd	%xmm0, -0x38(%r8,%r10)
140002083:     	vmovsd	-0x350(%r8,%r10), %xmm1
14000208d:     	vaddsd	0x2f0(%r8,%r10), %xmm1, %xmm1
140002097:     	vaddsd	%xmm0, %xmm1, %xmm0
14000209b:     	vmovsd	-0x28(%r8,%r10), %xmm1
1400020a2:     	vaddsd	%xmm1, %xmm0, %xmm0
1400020a6:     	vmulsd	%xmm6, %xmm1, %xmm1
1400020aa:     	vmulsd	%xmm0, %xmm15, %xmm0
1400020ae:     	vsubsd	%xmm2, %xmm0, %xmm0
1400020b2:     	vmovsd	%xmm0, -0x30(%r8,%r10)
1400020b9:     	vmovsd	-0x348(%r8,%r10), %xmm2
1400020c3:     	vaddsd	0x2f8(%r8,%r10), %xmm2, %xmm2
1400020cd:     	vaddsd	%xmm0, %xmm2, %xmm0
1400020d1:     	vmovsd	-0x20(%r8,%r10), %xmm2
1400020d8:     	vaddsd	%xmm2, %xmm0, %xmm0
1400020dc:     	vmulsd	%xmm6, %xmm2, %xmm2
1400020e0:     	vmulsd	%xmm0, %xmm15, %xmm0
1400020e4:     	vsubsd	%xmm1, %xmm0, %xmm0
1400020e8:     	vmovsd	%xmm0, -0x28(%r8,%r10)
1400020ef:     	vmovsd	-0x340(%r8,%r10), %xmm1
1400020f9:     	vaddsd	0x300(%r8,%r10), %xmm1, %xmm1
140002103:     	vaddsd	%xmm0, %xmm1, %xmm0
140002107:     	vmovsd	-0x18(%r8,%r10), %xmm1
14000210e:     	vaddsd	%xmm1, %xmm0, %xmm0
140002112:     	vmulsd	%xmm6, %xmm1, %xmm1
140002116:     	vmulsd	%xmm0, %xmm15, %xmm0
14000211a:     	vsubsd	%xmm2, %xmm0, %xmm0
14000211e:     	vmovsd	%xmm0, -0x20(%r8,%r10)
140002125:     	vmovsd	-0x338(%r8,%r10), %xmm2
14000212f:     	vmovsd	-0x10(%r8,%r10), %xmm3
140002136:     	vaddsd	0x308(%r8,%r10), %xmm2, %xmm2
140002140:     	vaddsd	%xmm0, %xmm2, %xmm0
140002144:     	vaddsd	%xmm3, %xmm0, %xmm0
140002148:     	vmulsd	%xmm0, %xmm15, %xmm0
14000214c:     	vsubsd	%xmm1, %xmm0, %xmm0
140002150:     	vmovsd	%xmm0, -0x18(%r8,%r10)
140002157:     	vmovsd	-0x330(%r8,%r10), %xmm1
140002161:     	vaddsd	0x310(%r8,%r10), %xmm1, %xmm1
14000216b:     	vaddsd	%xmm0, %xmm1, %xmm0
14000216f:     	vaddsd	-0x8(%r8,%r10), %xmm0, %xmm0
140002176:     	vmulsd	%xmm6, %xmm3, %xmm1
14000217a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000217e:     	vsubsd	%xmm1, %xmm0, %xmm0
140002182:     	vmovsd	%xmm0, -0x10(%r8,%r10)
140002189:     	addq	$0x38, %r10
14000218d:     	jne	0x140002010 <.text+0x1010>
140002193:     	incq	%rdx
140002196:     	incq	%r9
140002199:     	addq	$0x320, %r8             # imm = 0x320
1400021a0:     	cmpq	$0x63, %rdx
1400021a4:     	jne	0x140001ff0 <.text+0xff0>
1400021aa:     	movl	$0x1, %edx
1400021af:     	xorl	%r8d, %r8d
1400021b2:     	nopw	%cs:(%rax,%rax)
1400021c0:     	imulq	$0x320, %r8, %r9        # imm = 0x320
1400021c7:     	vmovsd	0x320(%rax,%r9), %xmm0
1400021d1:     	movq	$-0x310, %r9            # imm = 0xFCF0
1400021d8:     	nopl	(%rax,%rax)
1400021e0:     	vmovsd	-0x360(%rcx,%r9), %xmm1
1400021ea:     	vmulsd	-0x40(%rcx,%r9), %xmm6, %xmm3
1400021f1:     	vmovsd	-0x358(%rcx,%r9), %xmm2
1400021fb:     	vaddsd	0x2e0(%rcx,%r9), %xmm1, %xmm1
140002205:     	vaddsd	%xmm0, %xmm1, %xmm0
140002209:     	vmovsd	-0x38(%rcx,%r9), %xmm1
140002210:     	vaddsd	%xmm1, %xmm0, %xmm0
140002214:     	vmulsd	%xmm6, %xmm1, %xmm1
140002218:     	vmulsd	%xmm0, %xmm15, %xmm0
14000221c:     	vsubsd	%xmm3, %xmm0, %xmm0
140002220:     	vmovsd	%xmm0, -0x40(%rcx,%r9)
140002227:     	vaddsd	0x2e8(%rcx,%r9), %xmm2, %xmm2
140002231:     	vaddsd	%xmm0, %xmm2, %xmm0
140002235:     	vmovsd	-0x30(%rcx,%r9), %xmm2
14000223c:     	vaddsd	%xmm2, %xmm0, %xmm0
140002240:     	vmulsd	%xmm6, %xmm2, %xmm2
140002244:     	vmulsd	%xmm0, %xmm15, %xmm0
140002248:     	vsubsd	%xmm1, %xmm0, %xmm0
14000224c:     	vmovsd	%xmm0, -0x38(%rcx,%r9)
140002253:     	vmovsd	-0x350(%rcx,%r9), %xmm1
14000225d:     	vaddsd	0x2f0(%rcx,%r9), %xmm1, %xmm1
140002267:     	vaddsd	%xmm0, %xmm1, %xmm0
14000226b:     	vmovsd	-0x28(%rcx,%r9), %xmm1
140002272:     	vaddsd	%xmm1, %xmm0, %xmm0
140002276:     	vmulsd	%xmm6, %xmm1, %xmm1
14000227a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000227e:     	vsubsd	%xmm2, %xmm0, %xmm0
140002282:     	vmovsd	%xmm0, -0x30(%rcx,%r9)
140002289:     	vmovsd	-0x348(%rcx,%r9), %xmm2
140002293:     	vaddsd	0x2f8(%rcx,%r9), %xmm2, %xmm2
14000229d:     	vaddsd	%xmm0, %xmm2, %xmm0
1400022a1:     	vmovsd	-0x20(%rcx,%r9), %xmm2
1400022a8:     	vaddsd	%xmm2, %xmm0, %xmm0
1400022ac:     	vmulsd	%xmm6, %xmm2, %xmm2
1400022b0:     	vmulsd	%xmm0, %xmm15, %xmm0
1400022b4:     	vsubsd	%xmm1, %xmm0, %xmm0
1400022b8:     	vmovsd	%xmm0, -0x28(%rcx,%r9)
1400022bf:     	vmovsd	-0x340(%rcx,%r9), %xmm1
1400022c9:     	vaddsd	0x300(%rcx,%r9), %xmm1, %xmm1
1400022d3:     	vaddsd	%xmm0, %xmm1, %xmm0
1400022d7:     	vmovsd	-0x18(%rcx,%r9), %xmm1
1400022de:     	vaddsd	%xmm1, %xmm0, %xmm0
1400022e2:     	vmulsd	%xmm6, %xmm1, %xmm1
1400022e6:     	vmulsd	%xmm0, %xmm15, %xmm0
1400022ea:     	vsubsd	%xmm2, %xmm0, %xmm0
1400022ee:     	vmovsd	%xmm0, -0x20(%rcx,%r9)
1400022f5:     	vmovsd	-0x338(%rcx,%r9), %xmm2
1400022ff:     	vmovsd	-0x10(%rcx,%r9), %xmm3
140002306:     	vaddsd	0x308(%rcx,%r9), %xmm2, %xmm2
140002310:     	vaddsd	%xmm0, %xmm2, %xmm0
140002314:     	vaddsd	%xmm3, %xmm0, %xmm0
140002318:     	vmulsd	%xmm0, %xmm15, %xmm0
14000231c:     	vsubsd	%xmm1, %xmm0, %xmm0
140002320:     	vmovsd	%xmm0, -0x18(%rcx,%r9)
140002327:     	vmovsd	-0x330(%rcx,%r9), %xmm1
140002331:     	vaddsd	0x310(%rcx,%r9), %xmm1, %xmm1
14000233b:     	vaddsd	%xmm0, %xmm1, %xmm0
14000233f:     	vaddsd	-0x8(%rcx,%r9), %xmm0, %xmm0
140002346:     	vmulsd	%xmm6, %xmm3, %xmm1
14000234a:     	vmulsd	%xmm0, %xmm15, %xmm0
14000234e:     	vsubsd	%xmm1, %xmm0, %xmm0
140002352:     	vmovsd	%xmm0, -0x10(%rcx,%r9)
140002359:     	addq	$0x38, %r9
14000235d:     	jne	0x1400021e0 <.text+0x11e0>
140002363:     	incq	%rdx
140002366:     	incq	%r8
140002369:     	addq	$0x320, %rcx            # imm = 0x320
140002370:     	cmpq	$0x63, %rdx
140002374:     	jne	0x1400021c0 <.text+0x11c0>
14000237a:     	movl	$0x18, %ecx
14000237f:     	vxorpd	%xmm0, %xmm0, %xmm0
140002383:     	nopw	%cs:(%rax,%rax)
140002390:     	vaddsd	-0xc0(%rax,%rcx,8), %xmm0, %xmm0
140002399:     	vaddsd	-0xb8(%rax,%rcx,8), %xmm0, %xmm0
1400023a2:     	vaddsd	-0xb0(%rax,%rcx,8), %xmm0, %xmm0
1400023ab:     	vaddsd	-0xa8(%rax,%rcx,8), %xmm0, %xmm0
1400023b4:     	vaddsd	-0xa0(%rax,%rcx,8), %xmm0, %xmm0
1400023bd:     	vaddsd	-0x98(%rax,%rcx,8), %xmm0, %xmm0
1400023c6:     	vaddsd	-0x90(%rax,%rcx,8), %xmm0, %xmm0
1400023cf:     	vaddsd	-0x88(%rax,%rcx,8), %xmm0, %xmm0
1400023d8:     	vaddsd	-0x80(%rax,%rcx,8), %xmm0, %xmm0
1400023de:     	vaddsd	-0x78(%rax,%rcx,8), %xmm0, %xmm0
1400023e4:     	vaddsd	-0x70(%rax,%rcx,8), %xmm0, %xmm0
1400023ea:     	vaddsd	-0x68(%rax,%rcx,8), %xmm0, %xmm0
1400023f0:     	vaddsd	-0x60(%rax,%rcx,8), %xmm0, %xmm0
1400023f6:     	vaddsd	-0x58(%rax,%rcx,8), %xmm0, %xmm0
1400023fc:     	vaddsd	-0x50(%rax,%rcx,8), %xmm0, %xmm0
140002402:     	vaddsd	-0x48(%rax,%rcx,8), %xmm0, %xmm0
140002408:     	vaddsd	-0x40(%rax,%rcx,8), %xmm0, %xmm0
14000240e:     	vaddsd	-0x38(%rax,%rcx,8), %xmm0, %xmm0
140002414:     	vaddsd	-0x30(%rax,%rcx,8), %xmm0, %xmm0
14000241a:     	vaddsd	-0x28(%rax,%rcx,8), %xmm0, %xmm0
140002420:     	vaddsd	-0x20(%rax,%rcx,8), %xmm0, %xmm0
140002426:     	vaddsd	-0x18(%rax,%rcx,8), %xmm0, %xmm0
14000242c:     	vaddsd	-0x10(%rax,%rcx,8), %xmm0, %xmm0
140002432:     	vaddsd	-0x8(%rax,%rcx,8), %xmm0, %xmm0
140002438:     	vaddsd	(%rax,%rcx,8), %xmm0, %xmm0
14000243d:     	addq	$0x19, %rcx
140002441:     	cmpq	$0x2728, %rcx           # imm = 0x2728
140002448:     	jne	0x140002390 <.text+0x1390>
14000244e:     	movq	%rax, %rcx
140002451:     	vmovsd	%xmm0, 0x128(%rsp)
14000245a:     	callq	*0x3c18(%rip)           # 0x140006078
140002460:     	leaq	0x2b0(%rsp), %rcx
140002468:     	movl	$0x1, %edx
14000246d:     	callq	*0x3d25(%rip)           # 0x140006198
140002473:     	movl	0x2b8(%rsp), %eax
14000247a:     	movq	0x2b0(%rsp), %r14
140002482:     	movl	$0x1f40, %ecx           # imm = 0x1F40
140002487:     	movl	%eax, 0x58(%rsp)
14000248b:     	callq	*%rdi
14000248d:     	movl	$0x3e8, %ecx            # imm = 0x3E8
140002492:     	movl	$0x8, %edx
140002497:     	movq	%rax, %r15
14000249a:     	callq	*0x3be0(%rip)           # 0x140006080
1400024a0:     	movl	$0x61a80, %ecx          # imm = 0x61A80
1400024a5:     	movq	%rax, %r12
1400024a8:     	callq	*%rdi
1400024aa:     	movq	%rax, %r13
1400024ad:     	movl	$0x18, %eax
1400024b2:     	nopw	%cs:(%rax,%rax)
1400024c0:     	movq	0x5be1(%rip), %rcx      # 0x1400080a8
1400024c7:     	movq	%rcx, -0xc0(%r15,%rax,8)
1400024cf:     	movq	0x5bd2(%rip), %rcx      # 0x1400080a8
1400024d6:     	movq	%rcx, -0xb8(%r15,%rax,8)
1400024de:     	movq	0x5bc3(%rip), %rcx      # 0x1400080a8
1400024e5:     	movq	%rcx, -0xb0(%r15,%rax,8)
1400024ed:     	movq	0x5bb4(%rip), %rcx      # 0x1400080a8
1400024f4:     	movq	%rcx, -0xa8(%r15,%rax,8)
1400024fc:     	movq	0x5ba5(%rip), %rcx      # 0x1400080a8
140002503:     	movq	%rcx, -0xa0(%r15,%rax,8)
14000250b:     	movq	0x5b96(%rip), %rcx      # 0x1400080a8
140002512:     	movq	%rcx, -0x98(%r15,%rax,8)
14000251a:     	movq	0x5b87(%rip), %rcx      # 0x1400080a8
140002521:     	movq	%rcx, -0x90(%r15,%rax,8)
140002529:     	movq	0x5b78(%rip), %rcx      # 0x1400080a8
140002530:     	movq	%rcx, -0x88(%r15,%rax,8)
140002538:     	movq	0x5b69(%rip), %rcx      # 0x1400080a8
14000253f:     	movq	%rcx, -0x80(%r15,%rax,8)
140002544:     	movq	0x5b5d(%rip), %rcx      # 0x1400080a8
14000254b:     	movq	%rcx, -0x78(%r15,%rax,8)
140002550:     	movq	0x5b51(%rip), %rcx      # 0x1400080a8
140002557:     	movq	%rcx, -0x70(%r15,%rax,8)
14000255c:     	movq	0x5b45(%rip), %rcx      # 0x1400080a8
140002563:     	movq	%rcx, -0x68(%r15,%rax,8)
140002568:     	movq	0x5b39(%rip), %rcx      # 0x1400080a8
14000256f:     	movq	%rcx, -0x60(%r15,%rax,8)
140002574:     	movq	0x5b2d(%rip), %rcx      # 0x1400080a8
14000257b:     	movq	%rcx, -0x58(%r15,%rax,8)
140002580:     	movq	0x5b21(%rip), %rcx      # 0x1400080a8
140002587:     	movq	%rcx, -0x50(%r15,%rax,8)
14000258c:     	movq	0x5b15(%rip), %rcx      # 0x1400080a8
140002593:     	movq	%rcx, -0x48(%r15,%rax,8)
140002598:     	movq	0x5b09(%rip), %rcx      # 0x1400080a8
14000259f:     	movq	%rcx, -0x40(%r15,%rax,8)
1400025a4:     	movq	0x5afd(%rip), %rcx      # 0x1400080a8
1400025ab:     	movq	%rcx, -0x38(%r15,%rax,8)
1400025b0:     	movq	0x5af1(%rip), %rcx      # 0x1400080a8
1400025b7:     	movq	%rcx, -0x30(%r15,%rax,8)
1400025bc:     	movq	0x5ae5(%rip), %rcx      # 0x1400080a8
1400025c3:     	movq	%rcx, -0x28(%r15,%rax,8)
1400025c8:     	movq	0x5ad9(%rip), %rcx      # 0x1400080a8
1400025cf:     	movq	%rcx, -0x20(%r15,%rax,8)
1400025d4:     	movq	0x5acd(%rip), %rcx      # 0x1400080a8
1400025db:     	movq	%rcx, -0x18(%r15,%rax,8)
1400025e0:     	movq	0x5ac1(%rip), %rcx      # 0x1400080a8
1400025e7:     	movq	%rcx, -0x10(%r15,%rax,8)
1400025ec:     	movq	0x5ab5(%rip), %rcx      # 0x1400080a8
1400025f3:     	movq	%rcx, -0x8(%r15,%rax,8)
1400025f8:     	movq	0x5aa9(%rip), %rcx      # 0x1400080a8
1400025ff:     	movq	%rcx, (%r15,%rax,8)
140002603:     	addq	$0x19, %rax
140002607:     	cmpq	$0x400, %rax            # imm = 0x400
14000260d:     	jne	0x1400024c0 <.text+0x14c0>
140002613:     	movl	$0x18, %eax
140002618:     	nopl	(%rax,%rax)
140002620:     	movq	0x5a81(%rip), %rcx      # 0x1400080a8
140002627:     	movq	%rcx, -0xc0(%r13,%rax,8)
14000262f:     	movq	0x5a72(%rip), %rcx      # 0x1400080a8
140002636:     	movq	%rcx, -0xb8(%r13,%rax,8)
14000263e:     	movq	0x5a63(%rip), %rcx      # 0x1400080a8
140002645:     	movq	%rcx, -0xb0(%r13,%rax,8)
14000264d:     	movq	0x5a54(%rip), %rcx      # 0x1400080a8
140002654:     	movq	%rcx, -0xa8(%r13,%rax,8)
14000265c:     	movq	0x5a45(%rip), %rcx      # 0x1400080a8
140002663:     	movq	%rcx, -0xa0(%r13,%rax,8)
14000266b:     	movq	0x5a36(%rip), %rcx      # 0x1400080a8
140002672:     	movq	%rcx, -0x98(%r13,%rax,8)
14000267a:     	movq	0x5a27(%rip), %rcx      # 0x1400080a8
140002681:     	movq	%rcx, -0x90(%r13,%rax,8)
140002689:     	movq	0x5a18(%rip), %rcx      # 0x1400080a8
140002690:     	movq	%rcx, -0x88(%r13,%rax,8)
140002698:     	movq	0x5a09(%rip), %rcx      # 0x1400080a8
14000269f:     	movq	%rcx, -0x80(%r13,%rax,8)
1400026a4:     	movq	0x59fd(%rip), %rcx      # 0x1400080a8
1400026ab:     	movq	%rcx, -0x78(%r13,%rax,8)
1400026b0:     	movq	0x59f1(%rip), %rcx      # 0x1400080a8
1400026b7:     	movq	%rcx, -0x70(%r13,%rax,8)
1400026bc:     	movq	0x59e5(%rip), %rcx      # 0x1400080a8
1400026c3:     	movq	%rcx, -0x68(%r13,%rax,8)
1400026c8:     	movq	0x59d9(%rip), %rcx      # 0x1400080a8
1400026cf:     	movq	%rcx, -0x60(%r13,%rax,8)
1400026d4:     	movq	0x59cd(%rip), %rcx      # 0x1400080a8
1400026db:     	movq	%rcx, -0x58(%r13,%rax,8)
1400026e0:     	movq	0x59c1(%rip), %rcx      # 0x1400080a8
1400026e7:     	movq	%rcx, -0x50(%r13,%rax,8)
1400026ec:     	movq	0x59b5(%rip), %rcx      # 0x1400080a8
1400026f3:     	movq	%rcx, -0x48(%r13,%rax,8)
1400026f8:     	movq	0x59a9(%rip), %rcx      # 0x1400080a8
1400026ff:     	movq	%rcx, -0x40(%r13,%rax,8)
140002704:     	movq	0x599d(%rip), %rcx      # 0x1400080a8
14000270b:     	movq	%rcx, -0x38(%r13,%rax,8)
140002710:     	movq	0x5991(%rip), %rcx      # 0x1400080a8
140002717:     	movq	%rcx, -0x30(%r13,%rax,8)
14000271c:     	movq	0x5985(%rip), %rcx      # 0x1400080a8
140002723:     	movq	%rcx, -0x28(%r13,%rax,8)
140002728:     	movq	0x5979(%rip), %rcx      # 0x1400080a8
14000272f:     	movq	%rcx, -0x20(%r13,%rax,8)
140002734:     	movq	0x596d(%rip), %rcx      # 0x1400080a8
14000273b:     	movq	%rcx, -0x18(%r13,%rax,8)
140002740:     	movq	0x5961(%rip), %rcx      # 0x1400080a8
140002747:     	movq	%rcx, -0x10(%r13,%rax,8)
14000274c:     	movq	0x5955(%rip), %rcx      # 0x1400080a8
140002753:     	movq	%rcx, -0x8(%r13,%rax,8)
140002758:     	movq	0x5949(%rip), %rcx      # 0x1400080a8
14000275f:     	movq	%rcx, (%r13,%rax,8)
140002764:     	addq	$0x19, %rax
140002768:     	cmpq	$0xc368, %rax           # imm = 0xC368
14000276e:     	jne	0x140002620 <.text+0x1620>
140002774:     	movq	0x3905(%rip), %rsi      # 0x140006080
14000277b:     	movl	$0xc350, %ecx           # imm = 0xC350
140002780:     	movl	$0x4, %edx
140002785:     	callq	*%rsi
140002787:     	movl	$0x3e9, %ecx            # imm = 0x3E9
14000278c:     	movl	$0x4, %edx
140002791:     	movq	%rax, %rbp
140002794:     	callq	*%rsi
140002796:     	vmovdqa64	0x3ae0(%rip), %zmm3 # 0x140006280
1400027a0:     	vmovdqa64	0x3b16(%rip), %zmm4 # 0x1400062c0
1400027aa:     	vmovdqa64	0x3b4c(%rip), %zmm5 # 0x140006300
1400027b4:     	movl	$0x1, %r9d
1400027ba:     	movq	%rax, %rbx
1400027bd:     	movl	$0x0, (%rax)
1400027c3:     	xorl	%eax, %eax
1400027c5:     	nopw	%cs:(%rax,%rax)
1400027d0:     	movzwl	%ax, %edx
1400027d3:     	movslq	(%rbx,%rax,4), %rcx
1400027d7:     	shrl	%edx
1400027d9:     	imull	$0x147b, %edx, %edx     # imm = 0x147B
1400027df:     	shrl	$0x11, %edx
1400027e2:     	cmpq	$0x32, %rax
1400027e6:     	leal	0x32(%rcx), %r8d
1400027ea:     	movl	$0x0, (%rbp,%rcx,4)
1400027f2:     	cmovbl	%r9d, %edx
1400027f6:     	movl	%r8d, 0x4(%rbx,%rax,4)
1400027fb:     	vpbroadcastd	%edx, %zmm0
140002801:     	movl	%edx, 0x4(%rbp,%rcx,4)
140002805:     	vpmaddwd	%zmm3, %zmm0, %zmm1
14000280b:     	vpmaddwd	%zmm4, %zmm0, %zmm2
140002811:     	vpmaddwd	%zmm5, %zmm0, %zmm0
140002817:     	vmovdqu64	%zmm1, 0x8(%rbp,%rcx,4)
140002822:     	vmovdqu64	%zmm2, 0x48(%rbp,%rcx,4)
14000282d:     	vmovdqu64	%zmm0, 0x88(%rbp,%rcx,4)
140002838:     	movslq	0x4(%rbx,%rax,4), %rcx
14000283d:     	leal	0x32(%rcx), %r8d
140002841:     	movl	$0x0, (%rbp,%rcx,4)
140002849:     	movl	%edx, 0x4(%rbp,%rcx,4)
14000284d:     	vmovdqu64	%zmm1, 0x8(%rbp,%rcx,4)
140002858:     	vmovdqu64	%zmm2, 0x48(%rbp,%rcx,4)
140002863:     	vmovdqu64	%zmm0, 0x88(%rbp,%rcx,4)
14000286e:     	movl	%r8d, 0x8(%rbx,%rax,4)
140002873:     	addq	$0x2, %rax
140002877:     	cmpq	$0x3e8, %rax            # imm = 0x3E8
14000287d:     	jne	0x1400027d0 <.text+0x17d0>
140002883:     	leaq	0x2b0(%rsp), %rcx
14000288b:     	movl	$0x1, %edx
140002890:     	vzeroupper
140002893:     	callq	*0x38ff(%rip)           # 0x140006198
140002899:     	movq	0x2b0(%rsp), %rsi
1400028a1:     	movl	0x2b8(%rsp), %edi
1400028a8:     	movl	(%rbx), %eax
1400028aa:     	xorl	%ecx, %ecx
1400028ac:     	jmp	0x1400028c6 <.text+0x18c6>
1400028ae:     	nop
1400028b0:     	vmovsd	%xmm0, (%r12,%rcx,8)
1400028b6:     	incq	%rcx
1400028b9:     	cmpq	$0x3e8, %rcx            # imm = 0x3E8
1400028c0:     	je	0x1400029f0 <.text+0x19f0>
1400028c6:     	movl	%eax, %edx
1400028c8:     	movl	0x4(%rbx,%rcx,4), %eax
1400028cc:     	vpxor	%xmm0, %xmm0, %xmm0
1400028d0:     	cmpl	%eax, %edx
1400028d2:     	jge	0x1400028b0 <.text+0x18b0>
1400028d4:     	movl	%eax, %r8d
1400028d7:     	subl	%edx, %r8d
1400028da:     	movslq	%edx, %r9
1400028dd:     	andl	$0x7, %r8d
1400028e1:     	movq	%r9, %rdx
1400028e4:     	je	0x14000290e <.text+0x190e>
1400028e6:     	nopw	%cs:(%rax,%rax)
1400028f0:     	movslq	(%rbp,%rdx,4), %r10
1400028f5:     	vmovsd	(%r15,%r10,8), %xmm1
1400028fb:     	vmulsd	(%r13,%rdx,8), %xmm1, %xmm1
140002902:     	incq	%rdx
140002905:     	decq	%r8
140002908:     	vaddsd	%xmm1, %xmm0, %xmm0
14000290c:     	jne	0x1400028f0 <.text+0x18f0>
14000290e:     	movslq	%eax, %r8
140002911:     	subq	%r8, %r9
140002914:     	cmpq	$-0x8, %r9
140002918:     	ja	0x1400028b0 <.text+0x18b0>
14000291a:     	nopw	(%rax,%rax)
140002920:     	movslq	(%rbp,%rdx,4), %r9
140002925:     	vmovsd	(%r15,%r9,8), %xmm1
14000292b:     	movslq	0x4(%rbp,%rdx,4), %r9
140002930:     	vmulsd	(%r13,%rdx,8), %xmm1, %xmm1
140002937:     	vaddsd	%xmm1, %xmm0, %xmm0
14000293b:     	vmovsd	(%r15,%r9,8), %xmm1
140002941:     	movslq	0x8(%rbp,%rdx,4), %r9
140002946:     	vmulsd	0x8(%r13,%rdx,8), %xmm1, %xmm1
14000294d:     	vaddsd	%xmm1, %xmm0, %xmm0
140002951:     	vmovsd	(%r15,%r9,8), %xmm1
140002957:     	movslq	0xc(%rbp,%rdx,4), %r9
14000295c:     	vmulsd	0x10(%r13,%rdx,8), %xmm1, %xmm1
140002963:     	vaddsd	%xmm1, %xmm0, %xmm0
140002967:     	vmovsd	(%r15,%r9,8), %xmm1
14000296d:     	movslq	0x10(%rbp,%rdx,4), %r9
140002972:     	vmulsd	0x18(%r13,%rdx,8), %xmm1, %xmm1
140002979:     	vaddsd	%xmm1, %xmm0, %xmm0
14000297d:     	vmovsd	(%r15,%r9,8), %xmm1
140002983:     	movslq	0x14(%rbp,%rdx,4), %r9
140002988:     	vmulsd	0x20(%r13,%rdx,8), %xmm1, %xmm1
14000298f:     	vaddsd	%xmm1, %xmm0, %xmm0
140002993:     	vmovsd	(%r15,%r9,8), %xmm1
140002999:     	movslq	0x18(%rbp,%rdx,4), %r9
14000299e:     	vmulsd	0x28(%r13,%rdx,8), %xmm1, %xmm1
1400029a5:     	vaddsd	%xmm1, %xmm0, %xmm0
1400029a9:     	vmovsd	(%r15,%r9,8), %xmm1
1400029af:     	movslq	0x1c(%rbp,%rdx,4), %r9
1400029b4:     	vmulsd	0x30(%r13,%rdx,8), %xmm1, %xmm1
1400029bb:     	vaddsd	%xmm1, %xmm0, %xmm0
1400029bf:     	vmovsd	(%r15,%r9,8), %xmm1
1400029c5:     	vmulsd	0x38(%r13,%rdx,8), %xmm1, %xmm1
1400029cc:     	addq	$0x8, %rdx
1400029d0:     	vaddsd	%xmm1, %xmm0, %xmm0
1400029d4:     	cmpq	%rdx, %r8
1400029d7:     	jne	0x140002920 <.text+0x1920>
1400029dd:     	jmp	0x1400028b0 <.text+0x18b0>
1400029e2:     	nopw	%cs:(%rax,%rax)
1400029f0:     	leaq	0x2b0(%rsp), %rcx
1400029f8:     	movl	$0x1, %edx
1400029fd:     	callq	*0x3795(%rip)           # 0x140006198
140002a03:     	movq	0x2b0(%rsp), %rax
140002a0b:     	movl	0x2b8(%rsp), %ecx
140002a12:     	movl	$0x18, %edx
140002a17:     	vxorpd	%xmm0, %xmm0, %xmm0
140002a1b:     	nopl	(%rax,%rax)
140002a20:     	vaddsd	-0xc0(%r12,%rdx,8), %xmm0, %xmm0
140002a2a:     	vaddsd	-0xb8(%r12,%rdx,8), %xmm0, %xmm0
140002a34:     	vaddsd	-0xb0(%r12,%rdx,8), %xmm0, %xmm0
140002a3e:     	vaddsd	-0xa8(%r12,%rdx,8), %xmm0, %xmm0
140002a48:     	vaddsd	-0xa0(%r12,%rdx,8), %xmm0, %xmm0
140002a52:     	vaddsd	-0x98(%r12,%rdx,8), %xmm0, %xmm0
140002a5c:     	vaddsd	-0x90(%r12,%rdx,8), %xmm0, %xmm0
140002a66:     	vaddsd	-0x88(%r12,%rdx,8), %xmm0, %xmm0
140002a70:     	vaddsd	-0x80(%r12,%rdx,8), %xmm0, %xmm0
140002a77:     	vaddsd	-0x78(%r12,%rdx,8), %xmm0, %xmm0
140002a7e:     	vaddsd	-0x70(%r12,%rdx,8), %xmm0, %xmm0
140002a85:     	vaddsd	-0x68(%r12,%rdx,8), %xmm0, %xmm0
140002a8c:     	vaddsd	-0x60(%r12,%rdx,8), %xmm0, %xmm0
140002a93:     	vaddsd	-0x58(%r12,%rdx,8), %xmm0, %xmm0
140002a9a:     	vaddsd	-0x50(%r12,%rdx,8), %xmm0, %xmm0
140002aa1:     	vaddsd	-0x48(%r12,%rdx,8), %xmm0, %xmm0
140002aa8:     	vaddsd	-0x40(%r12,%rdx,8), %xmm0, %xmm0
140002aaf:     	vaddsd	-0x38(%r12,%rdx,8), %xmm0, %xmm0
140002ab6:     	vaddsd	-0x30(%r12,%rdx,8), %xmm0, %xmm0
140002abd:     	vaddsd	-0x28(%r12,%rdx,8), %xmm0, %xmm0
140002ac4:     	vaddsd	-0x20(%r12,%rdx,8), %xmm0, %xmm0
140002acb:     	vaddsd	-0x18(%r12,%rdx,8), %xmm0, %xmm0
140002ad2:     	vaddsd	-0x10(%r12,%rdx,8), %xmm0, %xmm0
140002ad9:     	vaddsd	-0x8(%r12,%rdx,8), %xmm0, %xmm0
140002ae0:     	vaddsd	(%r12,%rdx,8), %xmm0, %xmm0
140002ae6:     	addq	$0x19, %rdx
140002aea:     	cmpq	$0x400, %rdx            # imm = 0x400
140002af1:     	jne	0x140002a20 <.text+0x1a20>
140002af7:     	vmovsd	0x3841(%rip), %xmm3     # 0x140006340
140002aff:     	vmovsd	%xmm0, 0xe0(%rsp)
140002b08:     	vcvtsi2sd	%ecx, %xmm31, %xmm0
140002b0e:     	movq	%r15, %rcx
140002b11:     	vmulsd	%xmm3, %xmm0, %xmm0
140002b15:     	vcvtsi2sd	%rax, %xmm31, %xmm1
140002b1b:     	vcvtsi2sd	%edi, %xmm31, %xmm2
140002b21:     	vaddsd	%xmm1, %xmm0, %xmm0
140002b25:     	vmulsd	%xmm3, %xmm2, %xmm1
140002b29:     	vcvtsi2sd	%rsi, %xmm31, %xmm2
140002b2f:     	movq	0x3542(%rip), %rsi      # 0x140006078
140002b36:     	vaddsd	%xmm2, %xmm1, %xmm1
140002b3a:     	vsubsd	%xmm1, %xmm0, %xmm0
140002b3e:     	vmovsd	%xmm0, 0x50(%rsp)
140002b44:     	callq	*%rsi
140002b46:     	movq	%r12, %rcx
140002b49:     	callq	*%rsi
140002b4b:     	movq	%r13, %rcx
140002b4e:     	callq	*%rsi
140002b50:     	movq	%rbp, %rcx
140002b53:     	callq	*%rsi
140002b55:     	movq	%rbx, %rcx
140002b58:     	callq	*%rsi
140002b5a:     	leaq	0x2b0(%rsp), %rcx
140002b62:     	movl	$0x1, %edx
140002b67:     	callq	*0x362b(%rip)           # 0x140006198
140002b6d:     	vmovaps	0x2b0(%rsp), %xmm0
140002b76:     	vmovsd	0x37d2(%rip), %xmm11    # 0x140006350
140002b7e:     	vmovsd	0x37d2(%rip), %xmm12    # 0x140006358
140002b86:     	movl	$0x71, %eax
140002b8b:     	xorl	%esi, %esi
140002b8d:     	vmovaps	%xmm0, 0x90(%rsp)
140002b96:     	vmovddup	0x2b8(%rsp), %xmm0      # xmm0 = mem[0,0]
140002b9f:     	vmovaps	%xmm0, 0x80(%rsp)
140002ba8:     	vmovsd	0x3798(%rip), %xmm0     # 0x140006348
140002bb0:     	imulq	$0x236d, %rax, %rdi     # imm = 0x236D
140002bb7:     	vcvtsi2sd	%rax, %xmm31, %xmm2
140002bbd:     	vcvtsi2sd	%rdi, %xmm31, %xmm1
140002bc3:     	vmulsd	%xmm0, %xmm13, %xmm0
140002bc7:     	vmulsd	%xmm2, %xmm12, %xmm2
140002bcb:     	vmulsd	%xmm1, %xmm11, %xmm1
140002bcf:     	vaddsd	%xmm1, %xmm2, %xmm1
140002bd3:     	vaddsd	%xmm1, %xmm0, %xmm0
140002bd7:     	vmovsd	0x3789(%rip), %xmm1     # 0x140006368
140002bdf:     	callq	0x140005000 <.text+0x4000>
140002be4:     	vmulsd	0x3784(%rip), %xmm0, %xmm2 # 0x140006370
140002bec:     	movzwl	%di, %eax
140002bef:     	vcvtsi2sd	%rax, %xmm5, %xmm1
140002bf4:     	vaddsd	%xmm1, %xmm2, %xmm1
140002bf8:     	vmovsd	%xmm1, 0x2b0(%rsp,%rsi,8)
140002c01:     	incq	%rsi
140002c04:     	cmpq	$0x11, %rsi
140002c08:     	jne	0x140002bb0 <.text+0x1bb0>
140002c0a:     	vpmovsxbd	0x37c5(%rip), %xmm0 # 0x1400063d8
140002c13:     	vmovsd	0x3775(%rip), %xmm4     # 0x140006390
140002c1b:     	movabsq	$0x1000000004, %rax     # imm = 0x1000000004
140002c25:     	xorl	%r8d, %r8d
140002c28:     	movq	%rax, 0x338(%rsp)
140002c30:     	movl	$0x186a0, %eax          # imm = 0x186A0
140002c35:     	nopw	%cs:(%rax,%rax)
140002c40:     	vmovd	%xmm0, %ecx
140002c44:     	vpextrd	$0x1, %xmm0, %edx
140002c4a:     	movslq	%ecx, %rcx
140002c4d:     	vmovsd	0x2b0(%rsp,%rcx,8), %xmm1
140002c56:     	movslq	%edx, %rcx
140002c59:     	vsubsd	0x2b0(%rsp,%rcx,8), %xmm1, %xmm1
140002c62:     	vaddsd	%xmm7, %xmm1, %xmm2
140002c66:     	vcmpltsd	%xmm14, %xmm1, %k1
140002c6d:     	vmovsd	%xmm2, %xmm1, %xmm1 {%k1}
140002c73:     	vptestmd	%xmm0, %xmm0, %k1
140002c79:     	vmovdqa	%xmm10, %xmm2
140002c7d:     	vpaddd	%xmm8, %xmm0, %xmm2 {%k1}
140002c83:     	vmovsd	%xmm1, 0x2b0(%rsp,%rcx,8)
140002c8c:     	vmulsd	%xmm1, %xmm9, %xmm1
140002c90:     	vmovd	%xmm2, %ecx
140002c94:     	vmovq	%xmm2, 0x338(%rsp)
140002c9d:     	vpextrd	$0x1, %xmm2, %r9d
140002ca3:     	movslq	%ecx, %rcx
140002ca6:     	vmovsd	0x2b0(%rsp,%rcx,8), %xmm0
140002caf:     	movslq	%r9d, %rcx
140002cb2:     	vmulsd	%xmm1, %xmm1, %xmm1
140002cb6:     	vsubsd	0x2b0(%rsp,%rcx,8), %xmm0, %xmm0
140002cbf:     	vaddsd	%xmm7, %xmm0, %xmm3
140002cc3:     	vcmpltsd	%xmm14, %xmm0, %k1
140002cca:     	vmovsd	%xmm3, %xmm0, %xmm0 {%k1}
140002cd0:     	vptestmd	%xmm2, %xmm2, %k1
140002cd6:     	vmovdqa	%xmm10, %xmm3
140002cda:     	vmovsd	%xmm0, 0x2b0(%rsp,%rcx,8)
140002ce3:     	vmulsd	%xmm0, %xmm9, %xmm0
140002ce7:     	vpaddd	%xmm8, %xmm2, %xmm3 {%k1}
140002ced:     	vmovd	%xmm3, %ecx
140002cf1:     	vmovq	%xmm3, 0x338(%rsp)
140002cfa:     	vpextrd	$0x1, %xmm3, %edx
140002d00:     	movslq	%ecx, %rcx
140002d03:     	vmulsd	%xmm0, %xmm0, %xmm0
140002d07:     	vaddsd	%xmm0, %xmm1, %xmm0
140002d0b:     	vucomisd	%xmm0, %xmm4
140002d0f:     	vmovsd	0x2b0(%rsp,%rcx,8), %xmm0
140002d18:     	movslq	%edx, %rcx
140002d1b:     	vsubsd	0x2b0(%rsp,%rcx,8), %xmm0, %xmm0
140002d24:     	sbbl	$-0x1, %r8d
140002d28:     	vaddsd	%xmm7, %xmm0, %xmm1
140002d2c:     	vcmpltsd	%xmm14, %xmm0, %k1
140002d33:     	vmovsd	%xmm1, %xmm0, %xmm0 {%k1}
140002d39:     	vptestmd	%xmm3, %xmm3, %k1
140002d3f:     	vmovdqa	%xmm10, %xmm1
140002d43:     	vpaddd	%xmm8, %xmm3, %xmm1 {%k1}
140002d49:     	vmovsd	%xmm0, 0x2b0(%rsp,%rcx,8)
140002d52:     	vmovd	%xmm1, %ecx
140002d56:     	vmovq	%xmm1, 0x338(%rsp)
140002d5f:     	vpextrd	$0x1, %xmm1, %edx
140002d65:     	movslq	%ecx, %rcx
140002d68:     	vmovsd	0x2b0(%rsp,%rcx,8), %xmm2
140002d71:     	movslq	%edx, %rcx
140002d74:     	vsubsd	0x2b0(%rsp,%rcx,8), %xmm2, %xmm2
140002d7d:     	vaddsd	%xmm7, %xmm2, %xmm3
140002d81:     	vcmpltsd	%xmm14, %xmm2, %k1
140002d88:     	vmovsd	%xmm3, %xmm2, %xmm2 {%k1}
140002d8e:     	vptestmd	%xmm1, %xmm1, %k1
140002d94:     	vmulsd	%xmm0, %xmm9, %xmm3
140002d98:     	vmovdqa	%xmm10, %xmm0
140002d9c:     	vpaddd	%xmm8, %xmm1, %xmm0 {%k1}
140002da2:     	vmulsd	%xmm2, %xmm9, %xmm1
140002da6:     	vmovsd	%xmm2, 0x2b0(%rsp,%rcx,8)
140002daf:     	vmovq	%xmm0, 0x338(%rsp)
140002db8:     	vmulsd	%xmm3, %xmm3, %xmm3
140002dbc:     	vmulsd	%xmm1, %xmm1, %xmm1
140002dc0:     	vaddsd	%xmm1, %xmm3, %xmm1
140002dc4:     	vucomisd	%xmm1, %xmm4
140002dc8:     	sbbl	$-0x1, %r8d
140002dcc:     	addl	$-0x2, %eax
140002dcf:     	jne	0x140002c40 <.text+0x1c40>
140002dd5:     	leaq	0x2b0(%rsp), %rcx
140002ddd:     	movl	$0x1, %edx
140002de2:     	movl	%r8d, 0xd8(%rsp)
140002dea:     	callq	*0x33a8(%rip)           # 0x140006198
140002df0:     	vmovaps	0x2b0(%rsp), %xmm0
140002df9:     	vmovsd	0x355f(%rip), %xmm12    # 0x140006360
140002e01:     	vmovsd	0x355f(%rip), %xmm13    # 0x140006368
140002e09:     	vmovsd	0x355f(%rip), %xmm11    # 0x140006370
140002e11:     	movl	$0x7, %eax
140002e16:     	xorl	%esi, %esi
140002e18:     	vmovaps	%xmm0, 0xa0(%rsp)
140002e21:     	vmovddup	0x2b8(%rsp), %xmm0      # xmm0 = mem[0,0]
140002e2a:     	vmovaps	%xmm0, 0xb0(%rsp)
140002e33:     	vmovsd	0x355d(%rip), %xmm0     # 0x140006398
140002e3b:     	nopl	(%rax,%rax)
140002e40:     	imulq	$0x236d, %rax, %rdi     # imm = 0x236D
140002e47:     	vcvtsi2sd	%rax, %xmm5, %xmm2
140002e4c:     	vmulsd	0x3504(%rip), %xmm2, %xmm2 # 0x140006358
140002e54:     	vcvtsi2sd	%rdi, %xmm5, %xmm1
140002e59:     	vmulsd	0x34ef(%rip), %xmm1, %xmm1 # 0x140006350
140002e61:     	vmulsd	%xmm0, %xmm12, %xmm0
140002e65:     	vaddsd	%xmm1, %xmm2, %xmm1
140002e69:     	vaddsd	%xmm1, %xmm0, %xmm0
140002e6d:     	vmovapd	%xmm13, %xmm1
140002e71:     	callq	0x140005000 <.text+0x4000>
140002e76:     	movzwl	%di, %eax
140002e79:     	vmulsd	%xmm0, %xmm11, %xmm2
140002e7d:     	vcvtsi2sd	%rax, %xmm5, %xmm1
140002e82:     	vaddsd	%xmm1, %xmm2, %xmm1
140002e86:     	vmovsd	%xmm1, 0x160(%rsp,%rsi,8)
140002e8f:     	incq	%rsi
140002e92:     	cmpq	$0x11, %rsi
140002e96:     	jne	0x140002e40 <.text+0x1e40>
140002e98:     	movq	0x31e9(%rip), %rdi      # 0x140006088
140002e9f:     	movabsq	$0x1000000004, %rax     # imm = 0x1000000004
140002ea9:     	movl	$0x320, %ecx            # imm = 0x320
140002eae:     	movq	%rax, 0x1e8(%rsp)
140002eb6:     	callq	*%rdi
140002eb8:     	movl	$0x320, %ecx            # imm = 0x320
140002ebd:     	movq	%rax, %r15
140002ec0:     	callq	*%rdi
140002ec2:     	movq	%rax, %r12
140002ec5:     	xorl	%esi, %esi
140002ec7:     	nopw	(%rax,%rax)
140002ed0:     	movl	$0x320, %ecx            # imm = 0x320
140002ed5:     	callq	*%rdi
140002ed7:     	movl	$0x320, %ecx            # imm = 0x320
140002edc:     	movq	%rax, (%r15,%rsi,8)
140002ee0:     	callq	*%rdi
140002ee2:     	movq	%rax, (%r12,%rsi,8)
140002ee6:     	incq	%rsi
140002ee9:     	cmpq	$0x64, %rsi
140002eed:     	jne	0x140002ed0 <.text+0x1ed0>
140002eef:     	vpmovsxbd	0x34e0(%rip), %xmm0 # 0x1400063d8
140002ef8:     	xorl	%eax, %eax
140002efa:     	nopw	(%rax,%rax)
140002f00:     	movq	(%r15,%rax,8), %rcx
140002f04:     	movl	$0x4, %edx
140002f09:     	nopl	(%rax)
140002f10:     	vmovd	%xmm0, %r8d
140002f15:     	vpextrd	$0x1, %xmm0, %r10d
140002f1b:     	movslq	%r8d, %r8
140002f1e:     	vmovsd	0x160(%rsp,%r8,8), %xmm1
140002f28:     	movslq	%r10d, %r8
140002f2b:     	vsubsd	0x160(%rsp,%r8,8), %xmm1, %xmm1
140002f35:     	vaddsd	%xmm7, %xmm1, %xmm2
140002f39:     	vcmpltsd	%xmm14, %xmm1, %k1
140002f40:     	vmovsd	%xmm2, %xmm1, %xmm1 {%k1}
140002f46:     	vptestmd	%xmm0, %xmm0, %k1
140002f4c:     	vmovdqa	%xmm10, %xmm2
140002f50:     	vpaddd	%xmm8, %xmm0, %xmm2 {%k1}
140002f56:     	vmulsd	%xmm1, %xmm9, %xmm0
140002f5a:     	vmovsd	%xmm1, 0x160(%rsp,%r8,8)
140002f64:     	vmovd	%xmm2, %r8d
140002f69:     	vmovq	%xmm2, 0x1e8(%rsp)
140002f72:     	vpextrd	$0x1, %xmm2, %r9d
140002f78:     	movslq	%r8d, %r8
140002f7b:     	vmovsd	%xmm0, -0x20(%rcx,%rdx,8)
140002f81:     	vmovsd	0x160(%rsp,%r8,8), %xmm0
140002f8b:     	movslq	%r9d, %r8
140002f8e:     	vsubsd	0x160(%rsp,%r8,8), %xmm0, %xmm0
140002f98:     	vaddsd	%xmm7, %xmm0, %xmm1
140002f9c:     	vcmpltsd	%xmm14, %xmm0, %k1
140002fa3:     	vmovsd	%xmm1, %xmm0, %xmm0 {%k1}
140002fa9:     	vptestmd	%xmm2, %xmm2, %k1
140002faf:     	vmovdqa	%xmm10, %xmm1
140002fb3:     	vmovsd	%xmm0, 0x160(%rsp,%r8,8)
140002fbd:     	vmulsd	%xmm0, %xmm9, %xmm0
140002fc1:     	vpaddd	%xmm8, %xmm2, %xmm1 {%k1}
140002fc7:     	vmovd	%xmm1, %r8d
140002fcc:     	vmovq	%xmm1, 0x1e8(%rsp)
140002fd5:     	vpextrd	$0x1, %xmm1, %r9d
140002fdb:     	movslq	%r8d, %r8
140002fde:     	vmovsd	%xmm0, -0x18(%rcx,%rdx,8)
140002fe4:     	vmovsd	0x160(%rsp,%r8,8), %xmm0
140002fee:     	movslq	%r9d, %r8
140002ff1:     	vsubsd	0x160(%rsp,%r8,8), %xmm0, %xmm0
140002ffb:     	vaddsd	%xmm7, %xmm0, %xmm2
140002fff:     	vcmpltsd	%xmm14, %xmm0, %k1
140003006:     	vmovsd	%xmm2, %xmm0, %xmm0 {%k1}
14000300c:     	vptestmd	%xmm1, %xmm1, %k1
140003012:     	vmovdqa	%xmm10, %xmm2
140003016:     	vmovsd	%xmm0, 0x160(%rsp,%r8,8)
140003020:     	vmulsd	%xmm0, %xmm9, %xmm0
140003024:     	vpaddd	%xmm8, %xmm1, %xmm2 {%k1}
14000302a:     	vmovd	%xmm2, %r8d
14000302f:     	vmovq	%xmm2, 0x1e8(%rsp)
140003038:     	vpextrd	$0x1, %xmm2, %r10d
14000303e:     	movslq	%r8d, %r8
140003041:     	vmovsd	%xmm0, -0x10(%rcx,%rdx,8)
140003047:     	vmovsd	0x160(%rsp,%r8,8), %xmm0
140003051:     	movslq	%r10d, %r8
140003054:     	vsubsd	0x160(%rsp,%r8,8), %xmm0, %xmm0
14000305e:     	vaddsd	%xmm7, %xmm0, %xmm1
140003062:     	vcmpltsd	%xmm14, %xmm0, %k1
140003069:     	vmovsd	%xmm1, %xmm0, %xmm0 {%k1}
14000306f:     	vptestmd	%xmm2, %xmm2, %k1
140003075:     	vmovdqa	%xmm10, %xmm1
140003079:     	vmovsd	%xmm0, 0x160(%rsp,%r8,8)
140003083:     	vmulsd	%xmm0, %xmm9, %xmm0
140003087:     	vpaddd	%xmm8, %xmm2, %xmm1 {%k1}
14000308d:     	vmovd	%xmm1, %r8d
140003092:     	vmovq	%xmm1, 0x1e8(%rsp)
14000309b:     	vpextrd	$0x1, %xmm1, %r9d
1400030a1:     	movslq	%r8d, %r8
1400030a4:     	vmovsd	%xmm0, -0x8(%rcx,%rdx,8)
1400030aa:     	vmovsd	0x160(%rsp,%r8,8), %xmm0
1400030b4:     	movslq	%r9d, %r8
1400030b7:     	vsubsd	0x160(%rsp,%r8,8), %xmm0, %xmm2
1400030c1:     	vaddsd	%xmm7, %xmm2, %xmm0
1400030c5:     	vcmpltsd	%xmm14, %xmm2, %k1
1400030cc:     	vmovsd	%xmm0, %xmm2, %xmm2 {%k1}
1400030d2:     	vptestmd	%xmm1, %xmm1, %k1
1400030d8:     	vmovdqa	%xmm10, %xmm0
1400030dc:     	vmovsd	%xmm2, 0x160(%rsp,%r8,8)
1400030e6:     	vmulsd	%xmm2, %xmm9, %xmm2
1400030ea:     	vpaddd	%xmm8, %xmm1, %xmm0 {%k1}
1400030f0:     	vmovq	%xmm0, 0x1e8(%rsp)
1400030f9:     	vmovsd	%xmm2, (%rcx,%rdx,8)
1400030fe:     	addq	$0x5, %rdx
140003102:     	cmpq	$0x68, %rdx
140003106:     	jne	0x140002f10 <.text+0x1f10>
14000310c:     	incq	%rax
14000310f:     	cmpq	$0x64, %rax
140003113:     	jne	0x140002f00 <.text+0x1f00>
140003119:     	leaq	0x2b0(%rsp), %rcx
140003121:     	movl	$0x1, %edx
140003126:     	callq	*0x306c(%rip)           # 0x140006198
14000312c:     	movq	0x2b0(%rsp), %rsi
140003134:     	movl	0x2b8(%rsp), %edi
14000313b:     	movl	$0x9, %ebx
140003140:     	movq	-0x48(%r12,%rbx,8), %rcx
140003145:     	movq	-0x48(%r15,%rbx,8), %rdx
14000314a:     	movl	$0x320, %r8d            # imm = 0x320
140003150:     	callq	0x140005018 <.text+0x4018>
140003155:     	movq	-0x40(%r12,%rbx,8), %rcx
14000315a:     	movq	-0x40(%r15,%rbx,8), %rdx
14000315f:     	movl	$0x320, %r8d            # imm = 0x320
140003165:     	callq	0x140005018 <.text+0x4018>
14000316a:     	movq	-0x38(%r12,%rbx,8), %rcx
14000316f:     	movq	-0x38(%r15,%rbx,8), %rdx
140003174:     	movl	$0x320, %r8d            # imm = 0x320
14000317a:     	callq	0x140005018 <.text+0x4018>
14000317f:     	movq	-0x30(%r12,%rbx,8), %rcx
140003184:     	movq	-0x30(%r15,%rbx,8), %rdx
140003189:     	movl	$0x320, %r8d            # imm = 0x320
14000318f:     	callq	0x140005018 <.text+0x4018>
140003194:     	movq	-0x28(%r12,%rbx,8), %rcx
140003199:     	movq	-0x28(%r15,%rbx,8), %rdx
14000319e:     	movl	$0x320, %r8d            # imm = 0x320
1400031a4:     	callq	0x140005018 <.text+0x4018>
1400031a9:     	movq	-0x20(%r12,%rbx,8), %rcx
1400031ae:     	movq	-0x20(%r15,%rbx,8), %rdx
1400031b3:     	movl	$0x320, %r8d            # imm = 0x320
1400031b9:     	callq	0x140005018 <.text+0x4018>
1400031be:     	movq	-0x18(%r12,%rbx,8), %rcx
1400031c3:     	movq	-0x18(%r15,%rbx,8), %rdx
1400031c8:     	movl	$0x320, %r8d            # imm = 0x320
1400031ce:     	callq	0x140005018 <.text+0x4018>
1400031d3:     	movq	-0x10(%r12,%rbx,8), %rcx
1400031d8:     	movq	-0x10(%r15,%rbx,8), %rdx
1400031dd:     	movl	$0x320, %r8d            # imm = 0x320
1400031e3:     	callq	0x140005018 <.text+0x4018>
1400031e8:     	movq	-0x8(%r12,%rbx,8), %rcx
1400031ed:     	movq	-0x8(%r15,%rbx,8), %rdx
1400031f2:     	movl	$0x320, %r8d            # imm = 0x320
1400031f8:     	callq	0x140005018 <.text+0x4018>
1400031fd:     	movq	(%r12,%rbx,8), %rcx
140003201:     	movq	(%r15,%rbx,8), %rdx
140003205:     	movl	$0x320, %r8d            # imm = 0x320
14000320b:     	callq	0x140005018 <.text+0x4018>
140003210:     	addq	$0xa, %rbx
140003214:     	cmpq	$0x6d, %rbx
140003218:     	jne	0x140003140 <.text+0x2140>
14000321e:     	vmovsd	0xc8(%rsp), %xmm4
140003227:     	vmovsd	0x50(%rsp), %xmm5
14000322d:     	vmovdqa	0x80(%rsp), %xmm1
140003236:     	vmovdqa	0x90(%rsp), %xmm0
14000323f:     	vmovdqa	0xb0(%rsp), %xmm3
140003248:     	vmovdqa	0xa0(%rsp), %xmm2
140003251:     	movl	$0x48, %ecx
140003256:     	movq	%r12, %rax
140003259:     	addq	$0x8, %rax
14000325d:     	movl	$0x1, %r8d
140003263:     	movl	$0x63, %ebx
140003268:     	xorl	%r11d, %r11d
14000326b:     	movq	%r15, 0x70(%rsp)
140003270:     	movq	%rcx, 0x80(%rsp)
140003278:     	movl	$0x8, %ecx
14000327d:     	movq	%rcx, 0x50(%rsp)
140003282:     	vpinsrd	$0x1, 0x40(%rsp), %xmm1, %xmm1
14000328a:     	vpinsrq	$0x1, 0x30(%rsp), %xmm0, %xmm0
140003292:     	vpinsrd	$0x1, 0x58(%rsp), %xmm3, %xmm3
14000329a:     	vminsd	%xmm4, %xmm5, %xmm4
14000329e:     	vpinsrq	$0x1, %r14, %xmm2, %xmm2
1400032a4:     	vmovsd	%xmm4, 0xc8(%rsp)
1400032ad:     	vmovapd	0x150(%rsp), %xmm4
1400032b6:     	vcvtqq2pd	%xmm2, %xmm2
1400032bc:     	vcvtdq2pd	%xmm1, %xmm1
1400032c0:     	vcvtqq2pd	%xmm0, %xmm0
1400032c6:     	vcvtdq2pd	%xmm3, %xmm3
1400032ca:     	vmulpd	%xmm4, %xmm1, %xmm1
1400032ce:     	vaddpd	%xmm0, %xmm1, %xmm0
1400032d2:     	vmulpd	%xmm4, %xmm3, %xmm1
1400032d6:     	vmovsd	0x30b2(%rip), %xmm3     # 0x140006390
1400032de:     	vmovddup	0x30ba(%rip), %xmm4     # xmm4 = mem[0,0]
                                                # 0x1400063a0
1400032e6:     	vaddpd	%xmm2, %xmm1, %xmm1
1400032ea:     	vsubpd	%xmm0, %xmm1, %xmm0
1400032ee:     	vmovapd	0x110(%rsp), %xmm1
1400032f7:     	vminpd	%xmm1, %xmm0, %xmm1
1400032fb:     	vcvtsi2sd	%rsi, %xmm31, %xmm0
140003301:     	movq	$-0x1, %rsi
140003308:     	vmovapd	%xmm1, 0x110(%rsp)
140003311:     	vcvtsi2sd	%edi, %xmm31, %xmm1
140003317:     	vmulsd	0x3021(%rip), %xmm1, %xmm1 # 0x140006340
14000331f:     	vaddsd	%xmm0, %xmm1, %xmm5
140003323:     	jmp	0x14000335e <.text+0x235e>
140003325:     	nopw	%cs:(%rax,%rax)
140003330:     	movq	0x68(%rsp), %rbx
140003335:     	movq	0x38(%rsp), %rsi
14000333a:     	addq	$0x8, 0x80(%rsp)
140003343:     	addq	$0x8, 0x50(%rsp)
140003349:     	movq	0x70(%rsp), %r15
14000334e:     	incq	%r11
140003351:     	incq	%r8
140003354:     	addq	$0x8, %rax
140003358:     	decq	%rbx
14000335b:     	decq	%rsi
14000335e:     	movl	%ebx, %r14d
140003361:     	andl	$0x7, %r14d
140003365:     	cmpq	$0x62, %r11
140003369:     	ja	0x1400033c0 <.text+0x23c0>
14000336b:     	movq	(%r12,%r11,8), %rdx
14000336f:     	movl	$0x3, %ecx
140003374:     	subl	%r11d, %ecx
140003377:     	vmovsd	(%rdx,%r11,8), %xmm0
14000337d:     	vandpd	%xmm4, %xmm0, %xmm0
140003381:     	testb	$0x7, %cl
140003384:     	je	0x1400033c8 <.text+0x23c8>
140003386:     	movq	%r14, %r9
140003389:     	movq	%r8, %rcx
14000338c:     	movl	%r11d, %edx
14000338f:     	nop
140003390:     	movq	(%r12,%rcx,8), %r10
140003394:     	vmovsd	(%r10,%r11,8), %xmm1
14000339a:     	vandpd	%xmm4, %xmm1, %xmm1
14000339e:     	vucomisd	%xmm0, %xmm1
1400033a2:     	vmaxsd	%xmm0, %xmm1, %xmm0
1400033a6:     	cmoval	%ecx, %edx
1400033a9:     	incq	%rcx
1400033ac:     	decq	%r9
1400033af:     	jne	0x140003390 <.text+0x2390>
1400033b1:     	leaq	-0x5c(%r11), %r9
1400033b5:     	cmpq	$0x7, %r9
1400033b9:     	jae	0x1400033e0 <.text+0x23e0>
1400033bb:     	jmp	0x1400034e5 <.text+0x24e5>
1400033c0:     	movl	%r11d, %edx
1400033c3:     	jmp	0x1400034e5 <.text+0x24e5>
1400033c8:     	movq	%r8, %rcx
1400033cb:     	movl	%r11d, %edx
1400033ce:     	leaq	-0x5c(%r11), %r9
1400033d2:     	cmpq	$0x7, %r9
1400033d6:     	jb	0x1400034e5 <.text+0x24e5>
1400033dc:     	nopl	(%rax)
1400033e0:     	movq	(%r12,%rcx,8), %r9
1400033e4:     	vmovddup	0x2fb4(%rip), %xmm2     # xmm2 = mem[0,0]
                                                # 0x1400063a0
1400033ec:     	leal	0x6(%rcx), %r10d
1400033f0:     	vmovsd	(%r9,%r11,8), %xmm1
1400033f6:     	movq	0x8(%r12,%rcx,8), %r9
1400033fb:     	vandpd	%xmm2, %xmm1, %xmm1
1400033ff:     	vucomisd	%xmm0, %xmm1
140003403:     	vmaxsd	%xmm0, %xmm1, %xmm0
140003407:     	vmovsd	(%r9,%r11,8), %xmm1
14000340d:     	leal	0x1(%rcx), %r9d
140003411:     	cmoval	%ecx, %edx
140003414:     	vandpd	%xmm2, %xmm1, %xmm1
140003418:     	vucomisd	%xmm0, %xmm1
14000341c:     	vmaxsd	%xmm0, %xmm1, %xmm0
140003420:     	cmovbel	%edx, %r9d
140003424:     	movq	0x10(%r12,%rcx,8), %rdx
140003429:     	vmovsd	(%rdx,%r11,8), %xmm1
14000342f:     	leal	0x2(%rcx), %edx
140003432:     	vandpd	%xmm2, %xmm1, %xmm1
140003436:     	vucomisd	%xmm0, %xmm1
14000343a:     	vmaxsd	%xmm0, %xmm1, %xmm0
14000343e:     	cmovbel	%r9d, %edx
140003442:     	movq	0x18(%r12,%rcx,8), %r9
140003447:     	vmovsd	(%r9,%r11,8), %xmm1
14000344d:     	leal	0x3(%rcx), %r9d
140003451:     	vandpd	%xmm2, %xmm1, %xmm1
140003455:     	vucomisd	%xmm0, %xmm1
140003459:     	vmaxsd	%xmm0, %xmm1, %xmm0
14000345d:     	cmovbel	%edx, %r9d
140003461:     	movq	0x20(%r12,%rcx,8), %rdx
140003466:     	vmovsd	(%rdx,%r11,8), %xmm1
14000346c:     	leal	0x4(%rcx), %edx
14000346f:     	vandpd	%xmm2, %xmm1, %xmm1
140003473:     	vucomisd	%xmm0, %xmm1
140003477:     	vmaxsd	%xmm0, %xmm1, %xmm0
14000347b:     	cmovbel	%r9d, %edx
14000347f:     	movq	0x28(%r12,%rcx,8), %r9
140003484:     	vmovsd	(%r9,%r11,8), %xmm1
14000348a:     	leal	0x5(%rcx), %r9d
14000348e:     	vandpd	%xmm2, %xmm1, %xmm1
140003492:     	vucomisd	%xmm0, %xmm1
140003496:     	vmaxsd	%xmm0, %xmm1, %xmm0
14000349a:     	cmovbel	%edx, %r9d
14000349e:     	movq	0x30(%r12,%rcx,8), %rdx
1400034a3:     	vmovsd	(%rdx,%r11,8), %xmm1
1400034a9:     	movq	0x38(%r12,%rcx,8), %rdx
1400034ae:     	vandpd	%xmm2, %xmm1, %xmm1
1400034b2:     	vucomisd	%xmm0, %xmm1
1400034b6:     	vmaxsd	%xmm0, %xmm1, %xmm0
1400034ba:     	vmovsd	(%rdx,%r11,8), %xmm1
1400034c0:     	leal	0x7(%rcx), %edx
1400034c3:     	cmovbel	%r9d, %r10d
1400034c7:     	vandpd	%xmm2, %xmm1, %xmm1
1400034cb:     	vucomisd	%xmm0, %xmm1
1400034cf:     	vmaxsd	%xmm0, %xmm1, %xmm0
1400034d3:     	cmovbel	%r10d, %edx
1400034d7:     	addq	$0x8, %rcx
1400034db:     	cmpq	$0x64, %rcx
1400034df:     	jne	0x1400033e0 <.text+0x23e0>
1400034e5:     	movl	%edx, 0x2b0(%rsp,%r11,4)
1400034ed:     	movl	%edx, %ecx
1400034ef:     	movq	(%r12,%rcx,8), %rdx
1400034f3:     	vmovsd	(%rdx,%r11,8), %xmm0
1400034f9:     	vucomisd	%xmm14, %xmm0
1400034fe:     	jne	0x140003506 <.text+0x2506>
140003500:     	jnp	0x140004f44 <.text+0x3f44>
140003506:     	cmpq	%rcx, %r11
140003509:     	je	0x140003517 <.text+0x2517>
14000350b:     	movq	(%r12,%r11,8), %r9
14000350f:     	movq	%rdx, (%r12,%r11,8)
140003513:     	movq	%r9, (%r12,%rcx,8)
140003517:     	cmpq	$0x63, %r11
14000351b:     	je	0x140003920 <.text+0x2920>
140003521:     	movq	(%r12,%r11,8), %rdi
140003525:     	movl	$0x3, %edx
14000352a:     	movq	%r8, %rcx
14000352d:     	subq	%r11, %rdx
140003530:     	vdivsd	(%rdi,%r11,8), %xmm3, %xmm0
140003536:     	testb	$0x7, %dl
140003539:     	je	0x14000355b <.text+0x255b>
14000353b:     	xorl	%ecx, %ecx
14000353d:     	nopl	(%rax)
140003540:     	movq	(%rax,%rcx,8), %rdx
140003544:     	incq	%rcx
140003547:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
14000354d:     	vmovsd	%xmm1, (%rdx,%r11,8)
140003553:     	cmpq	%rcx, %r14
140003556:     	jne	0x140003540 <.text+0x2540>
140003558:     	subq	%rsi, %rcx
14000355b:     	leaq	-0x5c(%r11), %rdx
14000355f:     	movq	%rbx, 0x68(%rsp)
140003564:     	movq	%rsi, 0x38(%rsp)
140003569:     	cmpq	$0x7, %rdx
14000356d:     	jb	0x140003615 <.text+0x2615>
140003573:     	nopw	%cs:(%rax,%rax)
140003580:     	movq	(%r12,%rcx,8), %rdx
140003584:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
14000358a:     	vmovsd	%xmm1, (%rdx,%r11,8)
140003590:     	movq	0x8(%r12,%rcx,8), %rdx
140003595:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
14000359b:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035a1:     	movq	0x10(%r12,%rcx,8), %rdx
1400035a6:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
1400035ac:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035b2:     	movq	0x18(%r12,%rcx,8), %rdx
1400035b7:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
1400035bd:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035c3:     	movq	0x20(%r12,%rcx,8), %rdx
1400035c8:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
1400035ce:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035d4:     	movq	0x28(%r12,%rcx,8), %rdx
1400035d9:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
1400035df:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035e5:     	movq	0x30(%r12,%rcx,8), %rdx
1400035ea:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
1400035f0:     	vmovsd	%xmm1, (%rdx,%r11,8)
1400035f6:     	movq	0x38(%r12,%rcx,8), %rdx
1400035fb:     	addq	$0x8, %rcx
1400035ff:     	vmulsd	(%rdx,%r11,8), %xmm0, %xmm1
140003605:     	vmovsd	%xmm1, (%rdx,%r11,8)
14000360b:     	cmpq	$0x64, %rcx
14000360f:     	jne	0x140003580 <.text+0x2580>
140003615:     	cmpq	$0x62, %r11
140003619:     	ja	0x140003330 <.text+0x2330>
14000361f:     	leaq	0x8(,%r11,8), %rcx
140003627:     	movl	$0x63, %ebp
14000362c:     	movq	0x68(%rsp), %r13
140003631:     	subq	%r11, %rbp
140003634:     	movq	%rcx, 0x40(%rsp)
140003639:     	addq	%rdi, %rcx
14000363c:     	movq	%rcx, 0x58(%rsp)
140003641:     	leaq	0x320(%rdi), %rcx
140003648:     	movq	%rcx, 0x30(%rsp)
14000364d:     	movq	%rbp, %rcx
140003650:     	andq	$-0x10, %rcx
140003654:     	movq	%rcx, 0x90(%rsp)
14000365c:     	addq	%r8, %rcx
14000365f:     	movq	%r13, %r14
140003662:     	andq	$-0x4, %r14
140003666:     	andq	$-0x10, %r13
14000366a:     	movq	%rcx, 0x48(%rsp)
14000366f:     	movq	%rbp, %rcx
140003672:     	andq	$-0x4, %rcx
140003676:     	movq	%rcx, 0xb0(%rsp)
14000367e:     	addq	%r8, %rcx
140003681:     	movq	%rcx, 0xa0(%rsp)
140003689:     	movq	0x80(%rsp), %rcx
140003691:     	leaq	(%rdi,%rcx), %r15
140003695:     	movq	0x50(%rsp), %rcx
14000369a:     	leaq	(%rdi,%rcx), %r10
14000369e:     	movq	%r8, %rcx
1400036a1:     	jmp	0x1400036bd <.text+0x26bd>
1400036a3:     	nopw	%cs:(%rax,%rax)
1400036b0:     	incq	%rcx
1400036b3:     	cmpq	$0x64, %rcx
1400036b7:     	je	0x140003330 <.text+0x2330>
1400036bd:     	movq	(%r12,%rcx,8), %rsi
1400036c1:     	movq	%r8, %r9
1400036c4:     	cmpq	$0x4, %rbp
1400036c8:     	jb	0x1400037d0 <.text+0x27d0>
1400036ce:     	movq	0x40(%rsp), %rdx
1400036d3:     	addq	%rsi, %rdx
1400036d6:     	cmpq	0x30(%rsp), %rdx
1400036db:     	jae	0x1400036f2 <.text+0x26f2>
1400036dd:     	leaq	0x320(%rsi), %rdx
1400036e4:     	movq	%r8, %r9
1400036e7:     	cmpq	%rdx, 0x58(%rsp)
1400036ec:     	jb	0x1400037d0 <.text+0x27d0>
1400036f2:     	cmpq	$0x10, %rbp
1400036f6:     	jae	0x1400036fc <.text+0x26fc>
1400036f8:     	xorl	%edx, %edx
1400036fa:     	jmp	0x14000377a <.text+0x277a>
1400036fc:     	movq	0x80(%rsp), %rdx
140003704:     	xorl	%r9d, %r9d
140003707:     	addq	%rsi, %rdx
14000370a:     	nopw	(%rax,%rax)
140003710:     	vbroadcastsd	(%rsi,%r11,8), %zmm0
140003717:     	vmovupd	-0x40(%rdx,%r9,8), %zmm2
14000371f:     	vmovupd	(%rdx,%r9,8), %zmm16
140003726:     	vmulpd	-0x40(%r15,%r9,8), %zmm0, %zmm1
14000372e:     	vmulpd	(%r15,%r9,8), %zmm0, %zmm0
140003735:     	vsubpd	%zmm1, %zmm2, %zmm1
14000373b:     	vsubpd	%zmm0, %zmm16, %zmm0
140003741:     	vmovupd	%zmm1, -0x40(%rdx,%r9,8)
140003749:     	vmovupd	%zmm0, (%rdx,%r9,8)
140003750:     	addq	$0x10, %r9
140003754:     	cmpq	%r9, %r13
140003757:     	jne	0x140003710 <.text+0x2710>
140003759:     	cmpq	0x90(%rsp), %rbp
140003761:     	je	0x1400036b0 <.text+0x26b0>
140003767:     	movq	0x90(%rsp), %rdx
14000376f:     	movq	0x48(%rsp), %r9
140003774:     	testb	$0xc, %bpl
140003778:     	je	0x1400037d0 <.text+0x27d0>
14000377a:     	movq	0x50(%rsp), %r9
14000377f:     	addq	%rsi, %r9
140003782:     	nopw	%cs:(%rax,%rax)
140003790:     	vbroadcastsd	(%rsi,%r11,8), %ymm0
140003796:     	vmovupd	(%r9,%rdx,8), %ymm1
14000379c:     	vmulpd	(%r10,%rdx,8), %ymm0, %ymm0
1400037a2:     	vsubpd	%ymm0, %ymm1, %ymm0
1400037a6:     	vmovupd	%ymm0, (%r9,%rdx,8)
1400037ac:     	addq	$0x4, %rdx
1400037b0:     	cmpq	%rdx, %r14
1400037b3:     	jne	0x140003790 <.text+0x2790>
1400037b5:     	movq	0xa0(%rsp), %r9
1400037bd:     	cmpq	0xb0(%rsp), %rbp
1400037c5:     	je	0x1400036b0 <.text+0x26b0>
1400037cb:     	nopl	(%rax,%rax)
1400037d0:     	movl	$0x4, %ebx
1400037d5:     	movq	%r9, %rdx
1400037d8:     	subl	%r9d, %ebx
1400037db:     	andl	$0x7, %ebx
1400037de:     	je	0x140003811 <.text+0x2811>
1400037e0:     	movq	%r9, %rdx
1400037e3:     	nopw	%cs:(%rax,%rax)
1400037f0:     	vmovsd	(%rsi,%r11,8), %xmm0
1400037f6:     	vmovsd	(%rsi,%rdx,8), %xmm1
1400037fb:     	vmulsd	(%rdi,%rdx,8), %xmm0, %xmm0
140003800:     	vsubsd	%xmm0, %xmm1, %xmm0
140003804:     	vmovsd	%xmm0, (%rsi,%rdx,8)
140003809:     	incq	%rdx
14000380c:     	decq	%rbx
14000380f:     	jne	0x1400037f0 <.text+0x27f0>
140003811:     	addq	$-0x5d, %r9
140003815:     	cmpq	$0x7, %r9
140003819:     	jb	0x1400036b0 <.text+0x26b0>
14000381f:     	addq	$0x7, %rdx
140003823:     	nopw	%cs:(%rax,%rax)
140003830:     	vmovsd	(%rsi,%r11,8), %xmm0
140003836:     	vmovsd	-0x38(%rsi,%rdx,8), %xmm1
14000383c:     	vmulsd	-0x38(%rdi,%rdx,8), %xmm0, %xmm0
140003842:     	vsubsd	%xmm0, %xmm1, %xmm0
140003846:     	vmovsd	-0x30(%rsi,%rdx,8), %xmm1
14000384c:     	vmovsd	%xmm0, -0x38(%rsi,%rdx,8)
140003852:     	vmovsd	(%rsi,%r11,8), %xmm0
140003858:     	vmulsd	-0x30(%rdi,%rdx,8), %xmm0, %xmm0
14000385e:     	vsubsd	%xmm0, %xmm1, %xmm0
140003862:     	vmovsd	%xmm0, -0x30(%rsi,%rdx,8)
140003868:     	vmovsd	(%rsi,%r11,8), %xmm0
14000386e:     	vmovsd	-0x28(%rsi,%rdx,8), %xmm1
140003874:     	vmulsd	-0x28(%rdi,%rdx,8), %xmm0, %xmm0
14000387a:     	vsubsd	%xmm0, %xmm1, %xmm0
14000387e:     	vmovsd	%xmm0, -0x28(%rsi,%rdx,8)
140003884:     	vmovsd	(%rsi,%r11,8), %xmm0
14000388a:     	vmovsd	-0x20(%rsi,%rdx,8), %xmm1
140003890:     	vmulsd	-0x20(%rdi,%rdx,8), %xmm0, %xmm0
140003896:     	vsubsd	%xmm0, %xmm1, %xmm0
14000389a:     	vmovsd	%xmm0, -0x20(%rsi,%rdx,8)
1400038a0:     	vmovsd	(%rsi,%r11,8), %xmm0
1400038a6:     	vmovsd	-0x18(%rsi,%rdx,8), %xmm1
1400038ac:     	vmulsd	-0x18(%rdi,%rdx,8), %xmm0, %xmm0
1400038b2:     	vsubsd	%xmm0, %xmm1, %xmm0
1400038b6:     	vmovsd	%xmm0, -0x18(%rsi,%rdx,8)
1400038bc:     	vmovsd	(%rsi,%r11,8), %xmm0
1400038c2:     	vmovsd	-0x10(%rsi,%rdx,8), %xmm1
1400038c8:     	vmulsd	-0x10(%rdi,%rdx,8), %xmm0, %xmm0
1400038ce:     	vsubsd	%xmm0, %xmm1, %xmm0
1400038d2:     	vmovsd	%xmm0, -0x10(%rsi,%rdx,8)
1400038d8:     	vmovsd	(%rsi,%r11,8), %xmm0
1400038de:     	vmovsd	-0x8(%rsi,%rdx,8), %xmm1
1400038e4:     	vmulsd	-0x8(%rdi,%rdx,8), %xmm0, %xmm0
1400038ea:     	vsubsd	%xmm0, %xmm1, %xmm0
1400038ee:     	vmovsd	%xmm0, -0x8(%rsi,%rdx,8)
1400038f4:     	vmovsd	(%rsi,%r11,8), %xmm0
1400038fa:     	vmovsd	(%rsi,%rdx,8), %xmm1
1400038ff:     	vmulsd	(%rdi,%rdx,8), %xmm0, %xmm0
140003904:     	vsubsd	%xmm0, %xmm1, %xmm0
140003908:     	vmovsd	%xmm0, (%rsi,%rdx,8)
14000390d:     	addq	$0x8, %rdx
140003911:     	cmpq	$0x6b, %rdx
140003915:     	jne	0x140003830 <.text+0x2830>
14000391b:     	jmp	0x1400036b0 <.text+0x26b0>
140003920:     	leaq	0x1f0(%rsp), %rcx
140003928:     	movl	$0x1, %edx
14000392d:     	vmovapd	%xmm5, 0x2a0(%rsp)
140003936:     	vzeroupper
140003939:     	callq	*0x2859(%rip)           # 0x140006198
14000393f:     	vmovaps	0x1f0(%rsp), %xmm0
140003948:     	vmovddup	0x1f8(%rsp), %xmm1      # xmm1 = mem[0,0]
140003951:     	xorl	%eax, %eax
140003953:     	vxorpd	%xmm11, %xmm11, %xmm11
140003958:     	xorl	%r8d, %r8d
14000395b:     	vmovaps	%xmm0, 0x280(%rsp)
140003964:     	vmovapd	%xmm1, 0x290(%rsp)
14000396d:     	nopl	(%rax)
140003970:     	movq	(%r12,%rax,8), %rcx
140003974:     	movl	$0x18, %edx
140003979:     	nopl	(%rax)
140003980:     	vaddsd	-0xc0(%rcx,%rdx,8), %xmm11, %xmm0
140003989:     	vaddsd	-0xb8(%rcx,%rdx,8), %xmm0, %xmm0
140003992:     	vaddsd	-0xb0(%rcx,%rdx,8), %xmm0, %xmm0
14000399b:     	vaddsd	-0xa8(%rcx,%rdx,8), %xmm0, %xmm0
1400039a4:     	vaddsd	-0xa0(%rcx,%rdx,8), %xmm0, %xmm0
1400039ad:     	vaddsd	-0x98(%rcx,%rdx,8), %xmm0, %xmm0
1400039b6:     	vaddsd	-0x90(%rcx,%rdx,8), %xmm0, %xmm0
1400039bf:     	vaddsd	-0x88(%rcx,%rdx,8), %xmm0, %xmm0
1400039c8:     	vaddsd	-0x80(%rcx,%rdx,8), %xmm0, %xmm0
1400039ce:     	vaddsd	-0x78(%rcx,%rdx,8), %xmm0, %xmm0
1400039d4:     	vaddsd	-0x70(%rcx,%rdx,8), %xmm0, %xmm0
1400039da:     	vaddsd	-0x68(%rcx,%rdx,8), %xmm0, %xmm0
1400039e0:     	vaddsd	-0x60(%rcx,%rdx,8), %xmm0, %xmm0
1400039e6:     	vaddsd	-0x58(%rcx,%rdx,8), %xmm0, %xmm0
1400039ec:     	vaddsd	-0x50(%rcx,%rdx,8), %xmm0, %xmm0
1400039f2:     	vaddsd	-0x48(%rcx,%rdx,8), %xmm0, %xmm0
1400039f8:     	vaddsd	-0x40(%rcx,%rdx,8), %xmm0, %xmm0
1400039fe:     	vaddsd	-0x38(%rcx,%rdx,8), %xmm0, %xmm0
140003a04:     	vaddsd	-0x30(%rcx,%rdx,8), %xmm0, %xmm0
140003a0a:     	vaddsd	-0x28(%rcx,%rdx,8), %xmm0, %xmm0
140003a10:     	vaddsd	-0x20(%rcx,%rdx,8), %xmm0, %xmm0
140003a16:     	vaddsd	-0x18(%rcx,%rdx,8), %xmm0, %xmm0
140003a1c:     	vaddsd	-0x10(%rcx,%rdx,8), %xmm0, %xmm0
140003a22:     	vaddsd	-0x8(%rcx,%rdx,8), %xmm0, %xmm0
140003a28:     	vaddsd	(%rcx,%rdx,8), %xmm0, %xmm11
140003a2d:     	addq	$0x19, %rdx
140003a31:     	cmpq	$0x7c, %rdx
140003a35:     	jne	0x140003980 <.text+0x2980>
140003a3b:     	addl	0x2b0(%rsp,%rax,4), %r8d
140003a43:     	incq	%rax
140003a46:     	cmpq	$0x64, %rax
140003a4a:     	jne	0x140003970 <.text+0x2970>
140003a50:     	xorl	%esi, %esi
140003a52:     	movl	%r8d, 0xd4(%rsp)
140003a5a:     	nopw	(%rax,%rax)
140003a60:     	movq	(%r15,%rsi,8), %rcx
140003a64:     	callq	*0x260e(%rip)           # 0x140006078
140003a6a:     	movq	(%r12,%rsi,8), %rcx
140003a6e:     	callq	*0x2604(%rip)           # 0x140006078
140003a74:     	movq	0x25fd(%rip), %rax      # 0x140006078
140003a7b:     	incq	%rsi
140003a7e:     	cmpq	$0x64, %rsi
140003a82:     	jne	0x140003a60 <.text+0x2a60>
140003a84:     	movq	%r15, %rcx
140003a87:     	movq	%rax, %rsi
140003a8a:     	callq	*%rax
140003a8c:     	movq	%r12, %rcx
140003a8f:     	callq	*%rsi
140003a91:     	vmovsd	0x28ff(%rip), %xmm0     # 0x140006398
140003a99:     	vmovsd	0x28bf(%rip), %xmm12    # 0x140006360
140003aa1:     	vmovsd	0x28c7(%rip), %xmm13    # 0x140006370
140003aa9:     	movl	$0x7, %eax
140003aae:     	xorl	%esi, %esi
140003ab0:     	imulq	$0x236d, %rax, %rdi     # imm = 0x236D
140003ab7:     	vcvtsi2sd	%rax, %xmm31, %xmm2
140003abd:     	vmulsd	0x2893(%rip), %xmm2, %xmm2 # 0x140006358
140003ac5:     	vcvtsi2sd	%rdi, %xmm31, %xmm1
140003acb:     	vmulsd	0x287d(%rip), %xmm1, %xmm1 # 0x140006350
140003ad3:     	vmulsd	%xmm0, %xmm12, %xmm0
140003ad7:     	vaddsd	%xmm1, %xmm2, %xmm1
140003adb:     	vaddsd	%xmm1, %xmm0, %xmm0
140003adf:     	vmovsd	0x2881(%rip), %xmm1     # 0x140006368
140003ae7:     	callq	0x140005000 <.text+0x4000>
140003aec:     	movzwl	%di, %eax
140003aef:     	vmulsd	%xmm0, %xmm13, %xmm2
140003af3:     	vcvtsi2sd	%rax, %xmm31, %xmm1
140003af9:     	vaddsd	%xmm1, %xmm2, %xmm1
140003afd:     	vmovsd	%xmm1, 0x1f0(%rsp,%rsi,8)
140003b06:     	incq	%rsi
140003b09:     	cmpq	$0x11, %rsi
140003b0d:     	jne	0x140003ab0 <.text+0x2ab0>
140003b0f:     	movq	0x2572(%rip), %rsi      # 0x140006088
140003b16:     	movabsq	$0x1000000004, %rax     # imm = 0x1000000004
140003b20:     	movl	$0x4000, %ecx           # imm = 0x4000
140003b25:     	movq	%rax, 0x278(%rsp)
140003b2d:     	callq	*%rsi
140003b2f:     	movl	$0x4000, %ecx           # imm = 0x4000
140003b34:     	movq	%rax, %rdi
140003b37:     	callq	*%rsi
140003b39:     	vpmovsxbd	0x2896(%rip), %xmm0 # 0x1400063d8
140003b42:     	movq	%rax, %rbx
140003b45:     	movl	$0x3, %eax
140003b4a:     	nopw	(%rax,%rax)
140003b50:     	vmovd	%xmm0, %ecx
140003b54:     	vpextrd	$0x1, %xmm0, %edx
140003b5a:     	movslq	%ecx, %rcx
140003b5d:     	vmovsd	0x1f0(%rsp,%rcx,8), %xmm1
140003b66:     	movslq	%edx, %rcx
140003b69:     	vsubsd	0x1f0(%rsp,%rcx,8), %xmm1, %xmm1
140003b72:     	vaddsd	%xmm7, %xmm1, %xmm2
140003b76:     	vcmpltsd	%xmm14, %xmm1, %k1
140003b7d:     	vmovsd	%xmm2, %xmm1, %xmm1 {%k1}
140003b83:     	vptestmd	%xmm0, %xmm0, %k1
140003b89:     	vmovdqa	%xmm10, %xmm2
140003b8d:     	vpaddd	%xmm8, %xmm0, %xmm2 {%k1}
140003b93:     	vmovsd	%xmm1, 0x1f0(%rsp,%rcx,8)
140003b9c:     	vmulsd	%xmm1, %xmm9, %xmm0
140003ba0:     	vmovd	%xmm2, %ecx
140003ba4:     	vmovq	%xmm2, 0x278(%rsp)
140003bad:     	vpextrd	$0x1, %xmm2, %edx
140003bb3:     	movslq	%ecx, %rcx
140003bb6:     	vmovsd	0x1f0(%rsp,%rcx,8), %xmm1
140003bbf:     	movslq	%edx, %rcx
140003bc2:     	vmovsd	%xmm0, -0x18(%rdi,%rax,8)
140003bc8:     	vsubsd	0x1f0(%rsp,%rcx,8), %xmm1, %xmm0
140003bd1:     	vaddsd	%xmm7, %xmm0, %xmm1
140003bd5:     	vcmpltsd	%xmm14, %xmm0, %k1
140003bdc:     	vmovsd	%xmm1, %xmm0, %xmm0 {%k1}
140003be2:     	vptestmd	%xmm2, %xmm2, %k1
140003be8:     	vmovdqa	%xmm10, %xmm1
140003bec:     	vpaddd	%xmm8, %xmm2, %xmm1 {%k1}
140003bf2:     	vmovsd	%xmm0, 0x1f0(%rsp,%rcx,8)
140003bfb:     	vmulsd	%xmm0, %xmm9, %xmm0
140003bff:     	vmovd	%xmm1, %ecx
140003c03:     	vmovq	%xmm1, 0x278(%rsp)
140003c0c:     	vpextrd	$0x1, %xmm1, %r8d
140003c12:     	movslq	%ecx, %rcx
140003c15:     	vmovsd	0x1f0(%rsp,%rcx,8), %xmm2
140003c1e:     	movslq	%r8d, %rcx
140003c21:     	vmovsd	%xmm0, -0x10(%rdi,%rax,8)
140003c27:     	vsubsd	0x1f0(%rsp,%rcx,8), %xmm2, %xmm0
140003c30:     	vaddsd	%xmm7, %xmm0, %xmm2
140003c34:     	vcmpltsd	%xmm14, %xmm0, %k1
140003c3b:     	vmovsd	%xmm2, %xmm0, %xmm0 {%k1}
140003c41:     	vptestmd	%xmm1, %xmm1, %k1
140003c47:     	vmovdqa	%xmm10, %xmm2
140003c4b:     	vpaddd	%xmm8, %xmm1, %xmm2 {%k1}
140003c51:     	vmovsd	%xmm0, 0x1f0(%rsp,%rcx,8)
140003c5a:     	vmulsd	%xmm0, %xmm9, %xmm0
140003c5e:     	vmovd	%xmm2, %ecx
140003c62:     	vmovq	%xmm2, 0x278(%rsp)
140003c6b:     	vpextrd	$0x1, %xmm2, %edx
140003c71:     	movslq	%ecx, %rcx
140003c74:     	vmovsd	0x1f0(%rsp,%rcx,8), %xmm1
140003c7d:     	movslq	%edx, %rcx
140003c80:     	vmovsd	%xmm0, -0x8(%rdi,%rax,8)
140003c86:     	vsubsd	0x1f0(%rsp,%rcx,8), %xmm1, %xmm1
140003c8f:     	vaddsd	%xmm7, %xmm1, %xmm0
140003c93:     	vcmpltsd	%xmm14, %xmm1, %k1
140003c9a:     	vmovsd	%xmm0, %xmm1, %xmm1 {%k1}
140003ca0:     	vptestmd	%xmm2, %xmm2, %k1
140003ca6:     	vmovdqa	%xmm10, %xmm0
140003caa:     	vmovsd	%xmm1, 0x1f0(%rsp,%rcx,8)
140003cb3:     	vmulsd	%xmm1, %xmm9, %xmm1
140003cb7:     	vpaddd	%xmm8, %xmm2, %xmm0 {%k1}
140003cbd:     	vmovq	%xmm0, 0x278(%rsp)
140003cc6:     	vmovsd	%xmm1, (%rdi,%rax,8)
140003ccb:     	addq	$0x4, %rax
140003ccf:     	cmpq	$0x803, %rax            # imm = 0x803
140003cd5:     	jne	0x140003b50 <.text+0x2b50>
140003cdb:     	leaq	0xf0(%rsp), %rcx
140003ce3:     	movl	$0x1, %edx
140003ce8:     	callq	*0x24aa(%rip)           # 0x140006198
140003cee:     	movq	0xf0(%rsp), %rax
140003cf6:     	movl	0xf8(%rsp), %ecx
140003cfd:     	movl	$0x4000, %r8d           # imm = 0x4000
140003d03:     	movq	%rdi, 0x138(%rsp)
140003d0b:     	movq	%rdi, %rdx
140003d0e:     	movl	%ecx, 0xdc(%rsp)
140003d15:     	movq	%rbx, %rcx
140003d18:     	movq	%rax, 0x130(%rsp)
140003d20:     	callq	0x140005018 <.text+0x4018>
140003d25:     	movq	%rbx, %rax
140003d28:     	addq	$0x10, %rax
140003d2c:     	movq	%rbx, 0x48(%rsp)
140003d31:     	movq	%rax, 0xe8(%rsp)
140003d39:     	xorl	%eax, %eax
140003d3b:     	nopl	(%rax,%rax)
140003d40:     	movq	%rax, 0x148(%rsp)
140003d48:     	xorl	%eax, %eax
140003d4a:     	xorl	%ecx, %ecx
140003d4c:     	jmp	0x140003d63 <.text+0x2d63>
140003d4e:     	nop
140003d50:     	addl	%r8d, %ecx
140003d53:     	addq	$0x3, %rax
140003d57:     	cmpq	$0x3ff, %rax            # imm = 0x3FF
140003d5d:     	je	0x140003e80 <.text+0x2e80>
140003d63:     	movslq	%ecx, %rdx
140003d66:     	cmpq	%rdx, %rax
140003d69:     	jge	0x140003d9b <.text+0x2d9b>
140003d6b:     	leal	(%rcx,%rcx), %edx
140003d6e:     	movq	%rax, %r8
140003d71:     	shlq	$0x4, %r8
140003d75:     	movslq	%edx, %rdx
140003d78:     	vmovupd	(%rbx,%r8), %xmm1
140003d7e:     	vmovsd	(%rbx,%rdx,8), %xmm0
140003d83:     	vmovsd	%xmm0, (%rbx,%r8)
140003d89:     	vmovq	0x8(%rbx,%rdx,8), %xmm0
140003d8f:     	vmovq	%xmm0, 0x8(%rbx,%r8)
140003d96:     	vmovupd	%xmm1, (%rbx,%rdx,8)
140003d9b:     	movl	$0x200, %edx            # imm = 0x200
140003da0:     	cmpl	$0x200, %ecx            # imm = 0x200
140003da6:     	jl	0x140003db8 <.text+0x2db8>
140003da8:     	movl	$0x200, %edx            # imm = 0x200
140003dad:     	nopl	(%rax)
140003db0:     	subl	%edx, %ecx
140003db2:     	shrl	%edx
140003db4:     	cmpl	%ecx, %edx
140003db6:     	jle	0x140003db0 <.text+0x2db0>
140003db8:     	addl	%ecx, %edx
140003dba:     	leaq	0x1(%rax), %rcx
140003dbe:     	movslq	%edx, %r8
140003dc1:     	cmpq	%r8, %rcx
140003dc4:     	jge	0x140003df4 <.text+0x2df4>
140003dc6:     	leal	(%rdx,%rdx), %r8d
140003dca:     	shlq	$0x4, %rcx
140003dce:     	movslq	%r8d, %r8
140003dd1:     	vmovupd	(%rbx,%rcx), %xmm1
140003dd6:     	vmovsd	(%rbx,%r8,8), %xmm0
140003ddc:     	vmovsd	%xmm0, (%rbx,%rcx)
140003de1:     	vmovq	0x8(%rbx,%r8,8), %xmm0
140003de8:     	vmovq	%xmm0, 0x8(%rbx,%rcx)
140003dee:     	vmovupd	%xmm1, (%rbx,%r8,8)
140003df4:     	movl	$0x200, %r8d            # imm = 0x200
140003dfa:     	cmpl	$0x200, %edx            # imm = 0x200
140003e00:     	jl	0x140003e1b <.text+0x2e1b>
140003e02:     	movl	$0x200, %r8d            # imm = 0x200
140003e08:     	nopl	(%rax,%rax)
140003e10:     	subl	%r8d, %edx
140003e13:     	shrl	%r8d
140003e16:     	cmpl	%edx, %r8d
140003e19:     	jle	0x140003e10 <.text+0x2e10>
140003e1b:     	addl	%edx, %r8d
140003e1e:     	leaq	0x2(%rax), %rcx
140003e22:     	movslq	%r8d, %rdx
140003e25:     	cmpq	%rdx, %rcx
140003e28:     	jge	0x140003e55 <.text+0x2e55>
140003e2a:     	leal	(%r8,%r8), %edx
140003e2e:     	shlq	$0x4, %rcx
140003e32:     	movslq	%edx, %rdx
140003e35:     	vmovupd	(%rbx,%rcx), %xmm1
140003e3a:     	vmovsd	(%rbx,%rdx,8), %xmm0
140003e3f:     	vmovsd	%xmm0, (%rbx,%rcx)
140003e44:     	vmovq	0x8(%rbx,%rdx,8), %xmm0
140003e4a:     	vmovq	%xmm0, 0x8(%rbx,%rcx)
140003e50:     	vmovupd	%xmm1, (%rbx,%rdx,8)
140003e55:     	movl	$0x200, %ecx            # imm = 0x200
140003e5a:     	cmpl	$0x200, %r8d            # imm = 0x200
140003e61:     	jl	0x140003d50 <.text+0x2d50>
140003e67:     	movl	$0x200, %ecx            # imm = 0x200
140003e6c:     	nopl	(%rax)
140003e70:     	subl	%ecx, %r8d
140003e73:     	shrl	%ecx
140003e75:     	cmpl	%r8d, %ecx
140003e78:     	jle	0x140003e70 <.text+0x2e70>
140003e7a:     	jmp	0x140003d50 <.text+0x2d50>
140003e7f:     	nop
140003e80:     	movl	$0x1, %eax
140003e85:     	xorl	%edi, %edi
140003e87:     	jmp	0x140003ea3 <.text+0x2ea3>
140003e89:     	nopl	(%rax)
140003e90:     	movl	0x70(%rsp), %edi
140003e94:     	movl	0x64(%rsp), %eax
140003e98:     	incl	%edi
140003e9a:     	cmpl	$0xa, %edi
140003e9d:     	je	0x1400043d0 <.text+0x33d0>
140003ea3:     	vmovsd	0x24fd(%rip), %xmm1     # 0x1400063a8
140003eab:     	movl	%eax, %esi
140003ead:     	leal	(%rsi,%rsi), %eax
140003eb0:     	vcvtusi2sd	%eax, %xmm31, %xmm0
140003eb6:     	movl	%eax, 0x64(%rsp)
140003eba:     	vdivsd	%xmm0, %xmm1, %xmm13
140003ebe:     	vmovapd	%xmm13, %xmm0
140003ec2:     	vzeroupper
140003ec5:     	callq	0x140005006 <.text+0x4006>
140003eca:     	vmovapd	%xmm0, %xmm12
140003ece:     	vmulsd	0x24da(%rip), %xmm13, %xmm0 # 0x1400063b0
140003ed6:     	callq	0x140005006 <.text+0x4006>
140003edb:     	movl	%esi, %r9d
140003ede:     	leaq	(%r9,%r9), %rcx
140003ee2:     	movl	$0x3ff, %edx            # imm = 0x3FF
140003ee7:     	movq	%r9, 0x58(%rsp)
140003eec:     	movl	%edi, 0x70(%rsp)
140003ef0:     	tzcntq	%rcx, %rax
140003ef5:     	shrxq	%rax, %rdx, %rdx
140003efa:     	leaq	0x1(%rdx), %r10
140003efe:     	movq	%rdx, 0x50(%rsp)
140003f03:     	movq	%r10, 0x38(%rsp)
140003f08:     	cmpq	$0x7, %rdx
140003f0c:     	jae	0x140003f20 <.text+0x2f20>
140003f0e:     	xorl	%r9d, %r9d
140003f11:     	jmp	0x14000412a <.text+0x312a>
140003f16:     	nopw	%cs:(%rax,%rax)
140003f20:     	imulq	$0xe0, %r9, %rax
140003f27:     	movq	%r9, %rbp
140003f2a:     	shlq	$0x5, %rbp
140003f2e:     	imulq	$0xd0, %r9, %r8
140003f35:     	movq	0x48(%rsp), %r13
140003f3a:     	movq	%r9, %r12
140003f3d:     	shlq	$0x4, %r12
140003f41:     	movq	%r9, %r15
140003f44:     	andl	$0x3f8, %r10d           # imm = 0x3F8
140003f4b:     	shlq	$0x7, %r15
140003f4f:     	leaq	(%rbp,%rbp,4), %r11
140003f54:     	leaq	(%rbp,%rbp,2), %rsi
140003f59:     	leaq	(%r12,%r12,4), %rbx
140003f5d:     	leaq	(%r12,%r12,2), %r14
140003f61:     	movq	%rax, 0x40(%rsp)
140003f66:     	movq	%r9, %rax
140003f69:     	shlq	$0x8, %rax
140003f6d:     	movq	%r8, 0xb0(%rsp)
140003f75:     	movq	%r11, 0xa0(%rsp)
140003f7d:     	imulq	$0xb0, %r9, %r8
140003f84:     	imulq	$0x70, %r9, %r11
140003f88:     	movq	%rax, 0x30(%rsp)
140003f8d:     	imulq	$0xf0, %r9, %rax
140003f94:     	movq	%r8, 0x68(%rsp)
140003f99:     	movq	%rax, 0x80(%rsp)
140003fa1:     	movq	%r9, %rax
140003fa4:     	shlq	$0x6, %rax
140003fa8:     	xorl	%r9d, %r9d
140003fab:     	leaq	(%rax,%rax,2), %rdx
140003faf:     	movq	%rdx, 0x90(%rsp)
140003fb7:     	leaq	(%r12,%r12,8), %rdx
140003fbb:     	nopl	(%rax,%rax)
140003fc0:     	vmovupd	(%r13,%r12), %xmm1
140003fc7:     	vmovupd	(%r13), %xmm2
140003fcd:     	addq	%rcx, %r9
140003fd0:     	leaq	(%rcx,%rcx), %rdi
140003fd4:     	movq	0xa0(%rsp), %r8
140003fdc:     	addq	%rcx, %r9
140003fdf:     	addq	%rcx, %rdi
140003fe2:     	addq	%rdi, %r9
140003fe5:     	addq	%rdi, %r9
140003fe8:     	movq	0x68(%rsp), %rdi
140003fed:     	vsubpd	%xmm1, %xmm2, %xmm3
140003ff1:     	vaddpd	%xmm2, %xmm1, %xmm1
140003ff5:     	vmovupd	%xmm3, (%r13,%r12)
140003ffc:     	vmovupd	%xmm1, (%r13)
140004002:     	vmovupd	(%r13,%r14), %xmm1
140004009:     	vmovupd	(%r13,%rbp), %xmm2
140004010:     	vsubpd	%xmm1, %xmm2, %xmm3
140004014:     	vaddpd	%xmm2, %xmm1, %xmm1
140004018:     	vmovupd	%xmm3, (%r13,%r14)
14000401f:     	vmovupd	%xmm1, (%r13,%rbp)
140004026:     	vmovupd	(%r13,%rbx), %xmm1
14000402d:     	vmovupd	(%r13,%rax), %xmm2
140004034:     	vsubpd	%xmm1, %xmm2, %xmm3
140004038:     	vaddpd	%xmm2, %xmm1, %xmm1
14000403c:     	vmovupd	%xmm3, (%r13,%rbx)
140004043:     	vmovupd	%xmm1, (%r13,%rax)
14000404a:     	vmovupd	(%r13,%r11), %xmm1
140004051:     	vmovupd	(%r13,%rsi), %xmm2
140004058:     	vsubpd	%xmm1, %xmm2, %xmm3
14000405c:     	vaddpd	%xmm2, %xmm1, %xmm1
140004060:     	vmovupd	%xmm3, (%r13,%r11)
140004067:     	vmovupd	%xmm1, (%r13,%rsi)
14000406e:     	vmovupd	(%r13,%rdx), %xmm1
140004075:     	vmovupd	(%r13,%r15), %xmm2
14000407c:     	vsubpd	%xmm1, %xmm2, %xmm3
140004080:     	vaddpd	%xmm2, %xmm1, %xmm1
140004084:     	vmovupd	%xmm3, (%r13,%rdx)
14000408b:     	vmovupd	%xmm1, (%r13,%r15)
140004092:     	vmovupd	(%r13,%rdi), %xmm1
140004099:     	vmovupd	(%r13,%r8), %xmm2
1400040a0:     	vsubpd	%xmm1, %xmm2, %xmm3
1400040a4:     	vaddpd	%xmm2, %xmm1, %xmm1
1400040a8:     	vmovupd	%xmm3, (%r13,%rdi)
1400040af:     	vmovupd	%xmm1, (%r13,%r8)
1400040b6:     	movq	0xb0(%rsp), %rdi
1400040be:     	movq	0x90(%rsp), %r8
1400040c6:     	vmovupd	(%r13,%rdi), %xmm1
1400040cd:     	vmovupd	(%r13,%r8), %xmm2
1400040d4:     	vsubpd	%xmm1, %xmm2, %xmm3
1400040d8:     	vaddpd	%xmm2, %xmm1, %xmm1
1400040dc:     	vmovupd	%xmm3, (%r13,%rdi)
1400040e3:     	vmovupd	%xmm1, (%r13,%r8)
1400040ea:     	movq	0x80(%rsp), %r8
1400040f2:     	movq	0x40(%rsp), %rdi
1400040f7:     	vmovupd	(%r13,%r8), %xmm1
1400040fe:     	vmovupd	(%r13,%rdi), %xmm2
140004105:     	vsubpd	%xmm1, %xmm2, %xmm3
140004109:     	vaddpd	%xmm2, %xmm1, %xmm1
14000410d:     	vmovupd	%xmm3, (%r13,%r8)
140004114:     	vmovupd	%xmm1, (%r13,%rdi)
14000411b:     	addq	0x30(%rsp), %r13
140004120:     	addq	$-0x8, %r10
140004124:     	jne	0x140003fc0 <.text+0x2fc0>
14000412a:     	movq	0x58(%rsp), %rbx
14000412f:     	movq	0x38(%rsp), %rax
140004134:     	andl	$0x7, %eax
140004137:     	je	0x140004188 <.text+0x3188>
140004139:     	movq	0x48(%rsp), %r10
14000413e:     	movq	%rbx, %r8
140004141:     	shlq	$0x4, %r9
140004145:     	shlq	$0x4, %r8
140004149:     	movq	%rbx, %rdx
14000414c:     	shlq	$0x5, %rdx
140004150:     	addq	%r9, %r8
140004153:     	nopw	%cs:(%rax,%rax)
140004160:     	vmovupd	(%r10,%r8), %xmm1
140004166:     	vmovupd	(%r10,%r9), %xmm2
14000416c:     	vsubpd	%xmm1, %xmm2, %xmm3
140004170:     	vaddpd	%xmm2, %xmm1, %xmm1
140004174:     	vmovupd	%xmm3, (%r10,%r8)
14000417a:     	vmovupd	%xmm1, (%r10,%r9)
140004180:     	addq	%rdx, %r10
140004183:     	decq	%rax
140004186:     	jne	0x140004160 <.text+0x3160>
140004188:     	cmpl	$0x2, %ebx
14000418b:     	jb	0x140003e90 <.text+0x2e90>
140004191:     	movq	0xe8(%rsp), %r9
140004199:     	movq	0x38(%rsp), %rax
14000419e:     	vaddsd	%xmm0, %xmm0, %xmm1
1400041a2:     	vmovsd	0x21e6(%rip), %xmm2     # 0x140006390
1400041aa:     	movq	%rbx, %r8
1400041ad:     	shlq	$0x4, %r8
1400041b1:     	movq	%rbx, %r11
1400041b4:     	shlq	$0x5, %r11
1400041b8:     	movq	%rbx, %r10
1400041bb:     	shlq	$0x7, %r10
1400041bf:     	movl	$0x1, %r15d
1400041c5:     	leaq	(%r11,%r11,2), %rsi
1400041c9:     	leaq	(%r8,%r8,4), %rdi
1400041cd:     	vmulsd	%xmm1, %xmm0, %xmm1
1400041d1:     	vmovddup	%xmm12, %xmm0           # xmm0 = xmm12[0,0]
1400041d6:     	leaq	(%r9,%r8), %r14
1400041da:     	movq	0x48(%rsp), %r9
1400041df:     	movl	%eax, %edx
1400041e1:     	andl	$0x3fc, %eax            # imm = 0x3FC
1400041e6:     	andl	$0x3, %edx
1400041e9:     	movq	%rax, 0x38(%rsp)
1400041ee:     	imulq	$0x70, %rbx, %rax
1400041f2:     	movq	%rdx, 0x30(%rsp)
1400041f7:     	vmovddup	%xmm1, %xmm1            # xmm1 = xmm1[0,0]
1400041fb:     	leaq	(%r8,%r8,2), %rdx
1400041ff:     	shlq	$0x6, %rbx
140004203:     	jmp	0x14000422b <.text+0x322b>
140004205:     	nopw	%cs:(%rax,%rax)
140004210:     	movq	0x40(%rsp), %r15
140004215:     	addq	$0x10, %r9
140004219:     	addq	$0x10, %r14
14000421d:     	incq	%r15
140004220:     	cmpq	0x58(%rsp), %r15
140004225:     	je	0x140003e90 <.text+0x2e90>
14000422b:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140004230:     	vmulpd	%xmm2, %xmm1, %xmm4
140004234:     	cmpl	$0x3, 0x50(%rsp)
140004239:     	movq	%r15, 0x40(%rsp)
14000423e:     	vmulpd	%xmm3, %xmm0, %xmm3
140004242:     	vaddsubpd	%xmm3, %xmm2, %xmm2
140004246:     	vsubpd	%xmm4, %xmm2, %xmm2
14000424a:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
14000424f:     	jae	0x140004260 <.text+0x3260>
140004251:     	xorl	%r13d, %r13d
140004254:     	jmp	0x14000435c <.text+0x335c>
140004259:     	nopl	(%rax)
140004260:     	movq	0x38(%rsp), %rbp
140004265:     	movq	%r9, %r12
140004268:     	xorl	%r13d, %r13d
14000426b:     	nopl	(%rax,%rax)
140004270:     	vmulpd	0x18(%r12,%r8){1to2}, %xmm3, %xmm4
140004278:     	vmulpd	0x10(%r12,%r8){1to2}, %xmm2, %xmm5
140004280:     	addq	%rcx, %r13
140004283:     	addq	%rcx, %r13
140004286:     	addq	%rcx, %r13
140004289:     	addq	%rcx, %r13
14000428c:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004290:     	vmovupd	0x10(%r12), %xmm5
140004297:     	vsubpd	%xmm4, %xmm5, %xmm16
14000429d:     	vaddpd	%xmm4, %xmm5, %xmm4
1400042a1:     	vmovupd	%xmm16, 0x10(%r12,%r8)
1400042a9:     	vmovupd	%xmm4, 0x10(%r12)
1400042b0:     	vmulpd	0x18(%r12,%rdx){1to2}, %xmm3, %xmm4
1400042b8:     	vmulpd	0x10(%r12,%rdx){1to2}, %xmm2, %xmm5
1400042c0:     	vaddsubpd	%xmm4, %xmm5, %xmm4
1400042c4:     	vmovupd	0x10(%r12,%r11), %xmm5
1400042cb:     	vsubpd	%xmm4, %xmm5, %xmm16
1400042d1:     	vaddpd	%xmm4, %xmm5, %xmm4
1400042d5:     	vmovupd	%xmm16, 0x10(%r12,%rdx)
1400042dd:     	vmovupd	%xmm4, 0x10(%r12,%r11)
1400042e4:     	vmulpd	0x18(%r12,%rdi){1to2}, %xmm3, %xmm4
1400042ec:     	vmulpd	0x10(%r12,%rdi){1to2}, %xmm2, %xmm5
1400042f4:     	vaddsubpd	%xmm4, %xmm5, %xmm4
1400042f8:     	vmovupd	0x10(%r12,%rbx), %xmm5
1400042ff:     	vsubpd	%xmm4, %xmm5, %xmm16
140004305:     	vaddpd	%xmm4, %xmm5, %xmm4
140004309:     	vmovupd	%xmm16, 0x10(%r12,%rdi)
140004311:     	vmovupd	%xmm4, 0x10(%r12,%rbx)
140004318:     	vmulpd	0x18(%r12,%rax){1to2}, %xmm3, %xmm4
140004320:     	vmulpd	0x10(%r12,%rax){1to2}, %xmm2, %xmm5
140004328:     	vmovupd	0x10(%r12,%rsi), %xmm17
140004330:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004334:     	vsubpd	%xmm4, %xmm17, %xmm16
14000433a:     	vaddpd	%xmm4, %xmm17, %xmm4
140004340:     	vmovupd	%xmm16, 0x10(%r12,%rax)
140004348:     	vmovupd	%xmm4, 0x10(%r12,%rsi)
14000434f:     	addq	%r10, %r12
140004352:     	addq	$-0x4, %rbp
140004356:     	jne	0x140004270 <.text+0x3270>
14000435c:     	cmpq	$0x0, 0x30(%rsp)
140004362:     	je	0x140004210 <.text+0x3210>
140004368:     	movq	0x30(%rsp), %r12
14000436d:     	shlq	$0x4, %r13
140004371:     	nopw	%cs:(%rax,%rax)
140004380:     	vmulpd	0x8(%r14,%r13){1to2}, %xmm3, %xmm4
140004388:     	vmulpd	(%r14,%r13){1to2}, %xmm2, %xmm5
14000438f:     	vmovupd	0x10(%r9,%r13), %xmm17
140004397:     	vaddsubpd	%xmm4, %xmm5, %xmm4
14000439b:     	vsubpd	%xmm4, %xmm17, %xmm16
1400043a1:     	vaddpd	%xmm4, %xmm17, %xmm4
1400043a7:     	vmovupd	%xmm16, (%r14,%r13)
1400043ae:     	vmovupd	%xmm4, 0x10(%r9,%r13)
1400043b5:     	addq	%r11, %r13
1400043b8:     	decq	%r12
1400043bb:     	jne	0x140004380 <.text+0x3380>
1400043bd:     	jmp	0x140004210 <.text+0x3210>
1400043c2:     	nopw	%cs:(%rax,%rax)
1400043d0:     	movq	0x48(%rsp), %r9
1400043d5:     	xorl	%eax, %eax
1400043d7:     	xorl	%ecx, %ecx
1400043d9:     	jmp	0x1400043f3 <.text+0x33f3>
1400043db:     	nopl	(%rax,%rax)
1400043e0:     	addl	%r8d, %ecx
1400043e3:     	addq	$0x3, %rax
1400043e7:     	cmpq	$0x3ff, %rax            # imm = 0x3FF
1400043ed:     	je	0x140004520 <.text+0x3520>
1400043f3:     	movslq	%ecx, %rdx
1400043f6:     	cmpq	%rdx, %rax
1400043f9:     	jge	0x14000442e <.text+0x342e>
1400043fb:     	leal	(%rcx,%rcx), %edx
1400043fe:     	movq	%rax, %r8
140004401:     	shlq	$0x4, %r8
140004405:     	movslq	%edx, %rdx
140004408:     	vmovupd	(%r9,%r8), %xmm1
14000440e:     	vmovsd	(%r9,%rdx,8), %xmm0
140004414:     	vmovsd	%xmm0, (%r9,%r8)
14000441a:     	vmovsd	0x8(%r9,%rdx,8), %xmm0
140004421:     	vmovsd	%xmm0, 0x8(%r9,%r8)
140004428:     	vmovupd	%xmm1, (%r9,%rdx,8)
14000442e:     	movl	$0x200, %edx            # imm = 0x200
140004433:     	cmpl	$0x200, %ecx            # imm = 0x200
140004439:     	jl	0x140004448 <.text+0x3448>
14000443b:     	movl	$0x200, %edx            # imm = 0x200
140004440:     	subl	%edx, %ecx
140004442:     	shrl	%edx
140004444:     	cmpl	%ecx, %edx
140004446:     	jle	0x140004440 <.text+0x3440>
140004448:     	addl	%ecx, %edx
14000444a:     	leaq	0x1(%rax), %rcx
14000444e:     	movslq	%edx, %r8
140004451:     	cmpq	%r8, %rcx
140004454:     	jge	0x140004487 <.text+0x3487>
140004456:     	leal	(%rdx,%rdx), %r8d
14000445a:     	shlq	$0x4, %rcx
14000445e:     	movslq	%r8d, %r8
140004461:     	vmovupd	(%r9,%rcx), %xmm1
140004467:     	vmovsd	(%r9,%r8,8), %xmm0
14000446d:     	vmovsd	%xmm0, (%r9,%rcx)
140004473:     	vmovsd	0x8(%r9,%r8,8), %xmm0
14000447a:     	vmovsd	%xmm0, 0x8(%r9,%rcx)
140004481:     	vmovupd	%xmm1, (%r9,%r8,8)
140004487:     	movl	$0x200, %r8d            # imm = 0x200
14000448d:     	cmpl	$0x200, %edx            # imm = 0x200
140004493:     	jl	0x1400044ab <.text+0x34ab>
140004495:     	movl	$0x200, %r8d            # imm = 0x200
14000449b:     	nopl	(%rax,%rax)
1400044a0:     	subl	%r8d, %edx
1400044a3:     	shrl	%r8d
1400044a6:     	cmpl	%edx, %r8d
1400044a9:     	jle	0x1400044a0 <.text+0x34a0>
1400044ab:     	addl	%edx, %r8d
1400044ae:     	leaq	0x2(%rax), %rcx
1400044b2:     	movslq	%r8d, %rdx
1400044b5:     	cmpq	%rdx, %rcx
1400044b8:     	jge	0x1400044eb <.text+0x34eb>
1400044ba:     	leal	(%r8,%r8), %edx
1400044be:     	shlq	$0x4, %rcx
1400044c2:     	movslq	%edx, %rdx
1400044c5:     	vmovupd	(%r9,%rcx), %xmm1
1400044cb:     	vmovsd	(%r9,%rdx,8), %xmm0
1400044d1:     	vmovsd	%xmm0, (%r9,%rcx)
1400044d7:     	vmovsd	0x8(%r9,%rdx,8), %xmm0
1400044de:     	vmovsd	%xmm0, 0x8(%r9,%rcx)
1400044e5:     	vmovupd	%xmm1, (%r9,%rdx,8)
1400044eb:     	movl	$0x200, %ecx            # imm = 0x200
1400044f0:     	cmpl	$0x200, %r8d            # imm = 0x200
1400044f7:     	jl	0x1400043e0 <.text+0x33e0>
1400044fd:     	movl	$0x200, %ecx            # imm = 0x200
140004502:     	nopw	%cs:(%rax,%rax)
140004510:     	subl	%ecx, %r8d
140004513:     	shrl	%ecx
140004515:     	cmpl	%r8d, %ecx
140004518:     	jle	0x140004510 <.text+0x3510>
14000451a:     	jmp	0x1400043e0 <.text+0x33e0>
14000451f:     	nop
140004520:     	movl	$0x1, %eax
140004525:     	xorl	%edi, %edi
140004527:     	jmp	0x140004543 <.text+0x3543>
140004529:     	nopl	(%rax)
140004530:     	movl	0x70(%rsp), %edi
140004534:     	movl	0x64(%rsp), %eax
140004538:     	incl	%edi
14000453a:     	cmpl	$0xa, %edi
14000453d:     	je	0x140004a70 <.text+0x3a70>
140004543:     	vmovsd	0x1e6d(%rip), %xmm1     # 0x1400063b8
14000454b:     	movl	%eax, %esi
14000454d:     	leal	(%rsi,%rsi), %eax
140004550:     	vcvtusi2sd	%eax, %xmm31, %xmm0
140004556:     	movl	%eax, 0x64(%rsp)
14000455a:     	vdivsd	%xmm0, %xmm1, %xmm13
14000455e:     	vmovapd	%xmm13, %xmm0
140004562:     	callq	0x140005006 <.text+0x4006>
140004567:     	vmovapd	%xmm0, %xmm12
14000456b:     	vmulsd	0x1e3d(%rip), %xmm13, %xmm0 # 0x1400063b0
140004573:     	callq	0x140005006 <.text+0x4006>
140004578:     	movl	%esi, %r9d
14000457b:     	leaq	(%r9,%r9), %rcx
14000457f:     	movl	$0x3ff, %edx            # imm = 0x3FF
140004584:     	movq	%r9, 0x58(%rsp)
140004589:     	movl	%edi, 0x70(%rsp)
14000458d:     	tzcntq	%rcx, %rax
140004592:     	shrxq	%rax, %rdx, %rdx
140004597:     	leaq	0x1(%rdx), %r10
14000459b:     	movq	%rdx, 0x50(%rsp)
1400045a0:     	movq	%r10, 0x38(%rsp)
1400045a5:     	cmpq	$0x7, %rdx
1400045a9:     	jae	0x1400045c0 <.text+0x35c0>
1400045ab:     	xorl	%r9d, %r9d
1400045ae:     	jmp	0x1400047ca <.text+0x37ca>
1400045b3:     	nopw	%cs:(%rax,%rax)
1400045c0:     	imulq	$0xe0, %r9, %rax
1400045c7:     	movq	%r9, %rbp
1400045ca:     	shlq	$0x6, %rbp
1400045ce:     	movq	0x48(%rsp), %r13
1400045d3:     	movq	%r9, %r15
1400045d6:     	shlq	$0x4, %r15
1400045da:     	imulq	$0xb0, %r9, %r8
1400045e1:     	imulq	$0x70, %r9, %r11
1400045e5:     	movq	%r9, %r12
1400045e8:     	andl	$0x3f8, %r10d           # imm = 0x3F8
1400045ef:     	shlq	$0x7, %r12
1400045f3:     	leaq	(%r15,%r15,4), %rbx
1400045f7:     	leaq	(%r15,%r15,2), %r14
1400045fb:     	movq	%rax, 0x40(%rsp)
140004600:     	movq	%r9, %rax
140004603:     	shlq	$0x8, %rax
140004607:     	movq	%r8, 0x68(%rsp)
14000460c:     	movq	%rax, 0x30(%rsp)
140004611:     	imulq	$0xf0, %r9, %rax
140004618:     	movq	%rax, 0x80(%rsp)
140004620:     	leaq	(%rbp,%rbp,2), %rax
140004625:     	movq	%rax, 0x90(%rsp)
14000462d:     	imulq	$0xd0, %r9, %rax
140004634:     	movq	%rax, 0xb0(%rsp)
14000463c:     	movq	%r9, %rax
14000463f:     	shlq	$0x5, %rax
140004643:     	xorl	%r9d, %r9d
140004646:     	leaq	(%rax,%rax,4), %rdx
14000464a:     	leaq	(%rax,%rax,2), %rsi
14000464e:     	movq	%rdx, 0xa0(%rsp)
140004656:     	leaq	(%r15,%r15,8), %rdx
14000465a:     	nopw	(%rax,%rax)
140004660:     	vmovupd	(%r13,%r15), %xmm1
140004667:     	vmovupd	(%r13), %xmm2
14000466d:     	addq	%rcx, %r9
140004670:     	leaq	(%rcx,%rcx), %rdi
140004674:     	movq	0xa0(%rsp), %r8
14000467c:     	addq	%rcx, %r9
14000467f:     	addq	%rcx, %rdi
140004682:     	addq	%rdi, %r9
140004685:     	addq	%rdi, %r9
140004688:     	movq	0x68(%rsp), %rdi
14000468d:     	vsubpd	%xmm1, %xmm2, %xmm3
140004691:     	vaddpd	%xmm2, %xmm1, %xmm1
140004695:     	vmovupd	%xmm3, (%r13,%r15)
14000469c:     	vmovupd	%xmm1, (%r13)
1400046a2:     	vmovupd	(%r13,%r14), %xmm1
1400046a9:     	vmovupd	(%r13,%rax), %xmm2
1400046b0:     	vsubpd	%xmm1, %xmm2, %xmm3
1400046b4:     	vaddpd	%xmm2, %xmm1, %xmm1
1400046b8:     	vmovupd	%xmm3, (%r13,%r14)
1400046bf:     	vmovupd	%xmm1, (%r13,%rax)
1400046c6:     	vmovupd	(%r13,%rbx), %xmm1
1400046cd:     	vmovupd	(%r13,%rbp), %xmm2
1400046d4:     	vsubpd	%xmm1, %xmm2, %xmm3
1400046d8:     	vaddpd	%xmm2, %xmm1, %xmm1
1400046dc:     	vmovupd	%xmm3, (%r13,%rbx)
1400046e3:     	vmovupd	%xmm1, (%r13,%rbp)
1400046ea:     	vmovupd	(%r13,%r11), %xmm1
1400046f1:     	vmovupd	(%r13,%rsi), %xmm2
1400046f8:     	vsubpd	%xmm1, %xmm2, %xmm3
1400046fc:     	vaddpd	%xmm2, %xmm1, %xmm1
140004700:     	vmovupd	%xmm3, (%r13,%r11)
140004707:     	vmovupd	%xmm1, (%r13,%rsi)
14000470e:     	vmovupd	(%r13,%rdx), %xmm1
140004715:     	vmovupd	(%r13,%r12), %xmm2
14000471c:     	vsubpd	%xmm1, %xmm2, %xmm3
140004720:     	vaddpd	%xmm2, %xmm1, %xmm1
140004724:     	vmovupd	%xmm3, (%r13,%rdx)
14000472b:     	vmovupd	%xmm1, (%r13,%r12)
140004732:     	vmovupd	(%r13,%rdi), %xmm1
140004739:     	vmovupd	(%r13,%r8), %xmm2
140004740:     	vsubpd	%xmm1, %xmm2, %xmm3
140004744:     	vaddpd	%xmm2, %xmm1, %xmm1
140004748:     	vmovupd	%xmm3, (%r13,%rdi)
14000474f:     	vmovupd	%xmm1, (%r13,%r8)
140004756:     	movq	0xb0(%rsp), %rdi
14000475e:     	movq	0x90(%rsp), %r8
140004766:     	vmovupd	(%r13,%rdi), %xmm1
14000476d:     	vmovupd	(%r13,%r8), %xmm2
140004774:     	vsubpd	%xmm1, %xmm2, %xmm3
140004778:     	vaddpd	%xmm2, %xmm1, %xmm1
14000477c:     	vmovupd	%xmm3, (%r13,%rdi)
140004783:     	vmovupd	%xmm1, (%r13,%r8)
14000478a:     	movq	0x80(%rsp), %r8
140004792:     	movq	0x40(%rsp), %rdi
140004797:     	vmovupd	(%r13,%r8), %xmm1
14000479e:     	vmovupd	(%r13,%rdi), %xmm2
1400047a5:     	vsubpd	%xmm1, %xmm2, %xmm3
1400047a9:     	vaddpd	%xmm2, %xmm1, %xmm1
1400047ad:     	vmovupd	%xmm3, (%r13,%r8)
1400047b4:     	vmovupd	%xmm1, (%r13,%rdi)
1400047bb:     	addq	0x30(%rsp), %r13
1400047c0:     	addq	$-0x8, %r10
1400047c4:     	jne	0x140004660 <.text+0x3660>
1400047ca:     	vmovsd	0x1b8e(%rip), %xmm13    # 0x140006360
1400047d2:     	movq	0x58(%rsp), %rbx
1400047d7:     	movq	0x38(%rsp), %rax
1400047dc:     	andl	$0x7, %eax
1400047df:     	je	0x140004828 <.text+0x3828>
1400047e1:     	movq	0x48(%rsp), %r10
1400047e6:     	movq	%rbx, %r8
1400047e9:     	shlq	$0x4, %r9
1400047ed:     	shlq	$0x4, %r8
1400047f1:     	movq	%rbx, %rdx
1400047f4:     	shlq	$0x5, %rdx
1400047f8:     	addq	%r9, %r8
1400047fb:     	nopl	(%rax,%rax)
140004800:     	vmovupd	(%r10,%r8), %xmm1
140004806:     	vmovupd	(%r10,%r9), %xmm2
14000480c:     	vsubpd	%xmm1, %xmm2, %xmm3
140004810:     	vaddpd	%xmm2, %xmm1, %xmm1
140004814:     	vmovupd	%xmm3, (%r10,%r8)
14000481a:     	vmovupd	%xmm1, (%r10,%r9)
140004820:     	addq	%rdx, %r10
140004823:     	decq	%rax
140004826:     	jne	0x140004800 <.text+0x3800>
140004828:     	cmpl	$0x2, %ebx
14000482b:     	jb	0x140004530 <.text+0x3530>
140004831:     	movq	0xe8(%rsp), %r9
140004839:     	movq	0x38(%rsp), %rax
14000483e:     	vaddsd	%xmm0, %xmm0, %xmm1
140004842:     	vmovsd	0x1b46(%rip), %xmm2     # 0x140006390
14000484a:     	movq	%rbx, %r8
14000484d:     	shlq	$0x4, %r8
140004851:     	imulq	$0x70, %rbx, %r10
140004855:     	movq	%rbx, %r11
140004858:     	shlq	$0x7, %r11
14000485c:     	movl	$0x1, %r15d
140004862:     	leaq	(%r8,%r8,4), %rdi
140004866:     	vmulsd	%xmm1, %xmm0, %xmm1
14000486a:     	vmovddup	%xmm12, %xmm0           # xmm0 = xmm12[0,0]
14000486f:     	leaq	(%r9,%r8), %r14
140004873:     	movq	0x48(%rsp), %r9
140004878:     	movl	%eax, %edx
14000487a:     	andl	$0x3fc, %eax            # imm = 0x3FC
14000487f:     	andl	$0x3, %edx
140004882:     	movq	%rax, 0x38(%rsp)
140004887:     	movq	%rbx, %rax
14000488a:     	shlq	$0x5, %rax
14000488e:     	movq	%rdx, 0x30(%rsp)
140004893:     	vmovddup	%xmm1, %xmm1            # xmm1 = xmm1[0,0]
140004897:     	leaq	(%r8,%r8,2), %rdx
14000489b:     	shlq	$0x6, %rbx
14000489f:     	leaq	(%rax,%rax,2), %rsi
1400048a3:     	jmp	0x1400048cb <.text+0x38cb>
1400048a5:     	nopw	%cs:(%rax,%rax)
1400048b0:     	movq	0x40(%rsp), %r15
1400048b5:     	addq	$0x10, %r9
1400048b9:     	addq	$0x10, %r14
1400048bd:     	incq	%r15
1400048c0:     	cmpq	0x58(%rsp), %r15
1400048c5:     	je	0x140004530 <.text+0x3530>
1400048cb:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
1400048d0:     	vmulpd	%xmm2, %xmm1, %xmm4
1400048d4:     	cmpl	$0x3, 0x50(%rsp)
1400048d9:     	movq	%r15, 0x40(%rsp)
1400048de:     	vmulpd	%xmm3, %xmm0, %xmm3
1400048e2:     	vaddsubpd	%xmm3, %xmm2, %xmm2
1400048e6:     	vsubpd	%xmm4, %xmm2, %xmm2
1400048ea:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
1400048ef:     	jae	0x140004900 <.text+0x3900>
1400048f1:     	xorl	%r13d, %r13d
1400048f4:     	jmp	0x1400049fc <.text+0x39fc>
1400048f9:     	nopl	(%rax)
140004900:     	movq	0x38(%rsp), %rbp
140004905:     	movq	%r9, %r12
140004908:     	xorl	%r13d, %r13d
14000490b:     	nopl	(%rax,%rax)
140004910:     	vmulpd	0x18(%r12,%r8){1to2}, %xmm3, %xmm4
140004918:     	vmulpd	0x10(%r12,%r8){1to2}, %xmm2, %xmm5
140004920:     	addq	%rcx, %r13
140004923:     	addq	%rcx, %r13
140004926:     	addq	%rcx, %r13
140004929:     	addq	%rcx, %r13
14000492c:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004930:     	vmovupd	0x10(%r12), %xmm5
140004937:     	vsubpd	%xmm4, %xmm5, %xmm16
14000493d:     	vaddpd	%xmm4, %xmm5, %xmm4
140004941:     	vmovupd	%xmm16, 0x10(%r12,%r8)
140004949:     	vmovupd	%xmm4, 0x10(%r12)
140004950:     	vmulpd	0x18(%r12,%rdx){1to2}, %xmm3, %xmm4
140004958:     	vmulpd	0x10(%r12,%rdx){1to2}, %xmm2, %xmm5
140004960:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004964:     	vmovupd	0x10(%r12,%rax), %xmm5
14000496b:     	vsubpd	%xmm4, %xmm5, %xmm16
140004971:     	vaddpd	%xmm4, %xmm5, %xmm4
140004975:     	vmovupd	%xmm16, 0x10(%r12,%rdx)
14000497d:     	vmovupd	%xmm4, 0x10(%r12,%rax)
140004984:     	vmulpd	0x18(%r12,%rdi){1to2}, %xmm3, %xmm4
14000498c:     	vmulpd	0x10(%r12,%rdi){1to2}, %xmm2, %xmm5
140004994:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004998:     	vmovupd	0x10(%r12,%rbx), %xmm5
14000499f:     	vsubpd	%xmm4, %xmm5, %xmm16
1400049a5:     	vaddpd	%xmm4, %xmm5, %xmm4
1400049a9:     	vmovupd	%xmm16, 0x10(%r12,%rdi)
1400049b1:     	vmovupd	%xmm4, 0x10(%r12,%rbx)
1400049b8:     	vmulpd	0x18(%r12,%r10){1to2}, %xmm3, %xmm4
1400049c0:     	vmulpd	0x10(%r12,%r10){1to2}, %xmm2, %xmm5
1400049c8:     	vmovupd	0x10(%r12,%rsi), %xmm17
1400049d0:     	vaddsubpd	%xmm4, %xmm5, %xmm4
1400049d4:     	vsubpd	%xmm4, %xmm17, %xmm16
1400049da:     	vaddpd	%xmm4, %xmm17, %xmm4
1400049e0:     	vmovupd	%xmm16, 0x10(%r12,%r10)
1400049e8:     	vmovupd	%xmm4, 0x10(%r12,%rsi)
1400049ef:     	addq	%r11, %r12
1400049f2:     	addq	$-0x4, %rbp
1400049f6:     	jne	0x140004910 <.text+0x3910>
1400049fc:     	cmpq	$0x0, 0x30(%rsp)
140004a02:     	je	0x1400048b0 <.text+0x38b0>
140004a08:     	movq	0x30(%rsp), %r12
140004a0d:     	shlq	$0x4, %r13
140004a11:     	nopw	%cs:(%rax,%rax)
140004a20:     	vmulpd	0x8(%r14,%r13){1to2}, %xmm3, %xmm4
140004a28:     	vmulpd	(%r14,%r13){1to2}, %xmm2, %xmm5
140004a2f:     	vmovupd	0x10(%r9,%r13), %xmm17
140004a37:     	vaddsubpd	%xmm4, %xmm5, %xmm4
140004a3b:     	vsubpd	%xmm4, %xmm17, %xmm16
140004a41:     	vaddpd	%xmm4, %xmm17, %xmm4
140004a47:     	vmovupd	%xmm16, (%r14,%r13)
140004a4e:     	vmovupd	%xmm4, 0x10(%r9,%r13)
140004a55:     	addq	%rax, %r13
140004a58:     	decq	%r12
140004a5b:     	jne	0x140004a20 <.text+0x3a20>
140004a5d:     	jmp	0x1400048b0 <.text+0x38b0>
140004a62:     	nopw	%cs:(%rax,%rax)
140004a70:     	vbroadcastsd	0x1946(%rip), %zmm4 # 0x1400063c0
140004a7a:     	movq	0x48(%rsp), %rbx
140004a7f:     	movl	$0x78, %eax
140004a84:     	nopw	%cs:(%rax,%rax)
140004a90:     	vmulpd	-0x3c0(%rbx,%rax,8), %zmm4, %zmm0
140004a98:     	vmulpd	-0x380(%rbx,%rax,8), %zmm4, %zmm1
140004aa0:     	vmulpd	-0x340(%rbx,%rax,8), %zmm4, %zmm2
140004aa8:     	vmulpd	-0x300(%rbx,%rax,8), %zmm4, %zmm3
140004ab0:     	vmovupd	%zmm0, -0x3c0(%rbx,%rax,8)
140004ab8:     	vmovupd	%zmm1, -0x380(%rbx,%rax,8)
140004ac0:     	vmovupd	%zmm2, -0x340(%rbx,%rax,8)
140004ac8:     	vmovupd	%zmm3, -0x300(%rbx,%rax,8)
140004ad0:     	vmulpd	-0x2c0(%rbx,%rax,8), %zmm4, %zmm0
140004ad8:     	vmulpd	-0x280(%rbx,%rax,8), %zmm4, %zmm1
140004ae0:     	vmulpd	-0x240(%rbx,%rax,8), %zmm4, %zmm2
140004ae8:     	vmulpd	-0x200(%rbx,%rax,8), %zmm4, %zmm3
140004af0:     	vmovupd	%zmm0, -0x2c0(%rbx,%rax,8)
140004af8:     	vmovupd	%zmm1, -0x280(%rbx,%rax,8)
140004b00:     	vmovupd	%zmm2, -0x240(%rbx,%rax,8)
140004b08:     	vmovupd	%zmm3, -0x200(%rbx,%rax,8)
140004b10:     	vmulpd	-0x1c0(%rbx,%rax,8), %zmm4, %zmm0
140004b18:     	vmulpd	-0x180(%rbx,%rax,8), %zmm4, %zmm1
140004b20:     	vmulpd	-0x140(%rbx,%rax,8), %zmm4, %zmm2
140004b28:     	vmulpd	-0x100(%rbx,%rax,8), %zmm4, %zmm3
140004b30:     	vmovupd	%zmm0, -0x1c0(%rbx,%rax,8)
140004b38:     	vmovupd	%zmm1, -0x180(%rbx,%rax,8)
140004b40:     	vmovupd	%zmm2, -0x140(%rbx,%rax,8)
140004b48:     	vmovupd	%zmm3, -0x100(%rbx,%rax,8)
140004b50:     	vmulpd	-0xc0(%rbx,%rax,8), %zmm4, %zmm0
140004b58:     	vmulpd	-0x80(%rbx,%rax,8), %zmm4, %zmm1
140004b60:     	vmulpd	-0x40(%rbx,%rax,8), %zmm4, %zmm2
140004b68:     	vmulpd	(%rbx,%rax,8), %zmm4, %zmm3
140004b6f:     	vmovupd	%zmm0, -0xc0(%rbx,%rax,8)
140004b77:     	vmovupd	%zmm1, -0x80(%rbx,%rax,8)
140004b7f:     	vmovupd	%zmm2, -0x40(%rbx,%rax,8)
140004b87:     	vmovupd	%zmm3, (%rbx,%rax,8)
140004b8e:     	subq	$-0x80, %rax
140004b92:     	cmpq	$0x878, %rax            # imm = 0x878
140004b98:     	jne	0x140004a90 <.text+0x3a90>
140004b9e:     	movq	0x148(%rsp), %rax
140004ba6:     	movq	0x14db(%rip), %rdi      # 0x140006088
140004bad:     	incl	%eax
140004baf:     	cmpl	$0x32, %eax
140004bb2:     	jne	0x140003d40 <.text+0x2d40>
140004bb8:     	leaq	0xf0(%rsp), %rcx
140004bc0:     	movl	$0x1, %edx
140004bc5:     	vzeroupper
140004bc8:     	callq	*0x15ca(%rip)           # 0x140006198
140004bce:     	movq	0xf0(%rsp), %rcx
140004bd6:     	movl	0xf8(%rsp), %eax
140004bdd:     	movl	$0x1f, %edx
140004be2:     	vxorpd	%xmm12, %xmm12, %xmm12
140004be7:     	nopw	(%rax,%rax)
140004bf0:     	vaddsd	-0xf8(%rbx,%rdx,8), %xmm12, %xmm0
140004bf9:     	vaddsd	-0xf0(%rbx,%rdx,8), %xmm0, %xmm0
140004c02:     	vaddsd	-0xe8(%rbx,%rdx,8), %xmm0, %xmm0
140004c0b:     	vaddsd	-0xe0(%rbx,%rdx,8), %xmm0, %xmm0
140004c14:     	vaddsd	-0xd8(%rbx,%rdx,8), %xmm0, %xmm0
140004c1d:     	vaddsd	-0xd0(%rbx,%rdx,8), %xmm0, %xmm0
140004c26:     	vaddsd	-0xc8(%rbx,%rdx,8), %xmm0, %xmm0
140004c2f:     	vaddsd	-0xc0(%rbx,%rdx,8), %xmm0, %xmm0
140004c38:     	vaddsd	-0xb8(%rbx,%rdx,8), %xmm0, %xmm0
140004c41:     	vaddsd	-0xb0(%rbx,%rdx,8), %xmm0, %xmm0
140004c4a:     	vaddsd	-0xa8(%rbx,%rdx,8), %xmm0, %xmm0
140004c53:     	vaddsd	-0xa0(%rbx,%rdx,8), %xmm0, %xmm0
140004c5c:     	vaddsd	-0x98(%rbx,%rdx,8), %xmm0, %xmm0
140004c65:     	vaddsd	-0x90(%rbx,%rdx,8), %xmm0, %xmm0
140004c6e:     	vaddsd	-0x88(%rbx,%rdx,8), %xmm0, %xmm0
140004c77:     	vaddsd	-0x80(%rbx,%rdx,8), %xmm0, %xmm0
140004c7d:     	vaddsd	-0x78(%rbx,%rdx,8), %xmm0, %xmm0
140004c83:     	vaddsd	-0x70(%rbx,%rdx,8), %xmm0, %xmm0
140004c89:     	vaddsd	-0x68(%rbx,%rdx,8), %xmm0, %xmm0
140004c8f:     	vaddsd	-0x60(%rbx,%rdx,8), %xmm0, %xmm0
140004c95:     	vaddsd	-0x58(%rbx,%rdx,8), %xmm0, %xmm0
140004c9b:     	vaddsd	-0x50(%rbx,%rdx,8), %xmm0, %xmm0
140004ca1:     	vaddsd	-0x48(%rbx,%rdx,8), %xmm0, %xmm0
140004ca7:     	vaddsd	-0x40(%rbx,%rdx,8), %xmm0, %xmm0
140004cad:     	vaddsd	-0x38(%rbx,%rdx,8), %xmm0, %xmm0
140004cb3:     	vaddsd	-0x30(%rbx,%rdx,8), %xmm0, %xmm0
140004cb9:     	vaddsd	-0x28(%rbx,%rdx,8), %xmm0, %xmm0
140004cbf:     	vaddsd	-0x20(%rbx,%rdx,8), %xmm0, %xmm0
140004cc5:     	vaddsd	-0x18(%rbx,%rdx,8), %xmm0, %xmm0
140004ccb:     	vaddsd	-0x10(%rbx,%rdx,8), %xmm0, %xmm0
140004cd1:     	vaddsd	-0x8(%rbx,%rdx,8), %xmm0, %xmm0
140004cd7:     	vaddsd	(%rbx,%rdx,8), %xmm0, %xmm12
140004cdc:     	addq	$0x20, %rdx
140004ce0:     	cmpq	$0x81f, %rdx            # imm = 0x81F
140004ce7:     	jne	0x140004bf0 <.text+0x3bf0>
140004ced:     	vmovdqa	0x280(%rsp), %xmm0
140004cf6:     	vmovdqa	0x290(%rsp), %xmm1
140004cff:     	vmovapd	0x2a0(%rsp), %xmm4
140004d08:     	movq	0x1369(%rip), %rsi      # 0x140006078
140004d0f:     	vpinsrq	$0x1, %rcx, %xmm0, %xmm0
140004d15:     	vpinsrd	$0x1, %eax, %xmm1, %xmm1
140004d1b:     	movq	0x138(%rsp), %rcx
140004d23:     	vcvtqq2pd	%xmm0, %xmm0
140004d29:     	vcvtsi2sdl	0xdc(%rsp), %xmm31, %xmm3
140004d31:     	vcvtdq2pd	%xmm1, %xmm1
140004d35:     	vcvtsi2sdq	0x130(%rsp), %xmm31, %xmm2
140004d3d:     	vmulpd	0x150(%rsp), %xmm1, %xmm1
140004d46:     	vmulsd	0x15f2(%rip), %xmm3, %xmm3 # 0x140006340
140004d4e:     	vaddpd	%xmm0, %xmm1, %xmm0
140004d52:     	vmovapd	0x100(%rsp), %xmm1
140004d5b:     	vaddsd	%xmm2, %xmm3, %xmm2
140004d5f:     	vunpcklpd	%xmm2, %xmm4, %xmm2 # xmm2 = xmm4[0],xmm2[0]
140004d63:     	vsubpd	%xmm2, %xmm0, %xmm0
140004d67:     	vminpd	%xmm1, %xmm0, %xmm1
140004d6b:     	vmovapd	%xmm1, 0x100(%rsp)
140004d74:     	callq	*%rsi
140004d76:     	movq	%rbx, %rcx
140004d79:     	callq	*%rsi
140004d7b:     	movq	0x140(%rsp), %rax
140004d83:     	incl	%eax
140004d85:     	cmpl	0x7c(%rsp), %eax
140004d89:     	jne	0x140001110 <.text+0x110>
140004d8f:     	vcvtsi2sdl	0xd8(%rsp), %xmm5, %xmm0
140004d98:     	vmovapd	0x110(%rsp), %xmm9
140004da1:     	vmovaps	0x100(%rsp), %xmm6
140004daa:     	vmovsd	0xc8(%rsp), %xmm7
140004db3:     	vmovq	0x128(%rsp), %xmm2
140004dbc:     	movl	0xd4(%rsp), %edi
140004dc3:     	vdivsd	0x15fd(%rip), %xmm0, %xmm0 # 0x1400063c8
140004dcb:     	vshufpd	$0x1, %xmm9, %xmm9, %xmm8 # xmm8 = xmm9[1,0]
140004dd1:     	vmulsd	0x15f7(%rip), %xmm0, %xmm13 # 0x1400063d0
140004dd9:     	leaq	0x16b4(%rip), %rsi      # 0x140006494
140004de0:     	leaq	0x15f5(%rip), %rdx      # 0x1400063dc
140004de7:     	vmovq	%xmm2, %r8
140004dec:     	movq	%rsi, %rcx
140004def:     	callq	0x140004f90 <.text+0x3f90>
140004df4:     	vmovq	0xe0(%rsp), %xmm2
140004dfd:     	leaq	0x15e0(%rip), %rdx      # 0x1400063e4
140004e04:     	movq	%rsi, %rcx
140004e07:     	vmovq	%xmm2, %r8
140004e0c:     	callq	0x140004f90 <.text+0x3f90>
140004e11:     	leaq	0x15d7(%rip), %rdx      # 0x1400063ef
140004e18:     	vmovq	%xmm13, %r8
140004e1d:     	movq	%rsi, %rcx
140004e20:     	vmovapd	%xmm13, %xmm2
140004e24:     	callq	0x140004f90 <.text+0x3f90>
140004e29:     	leaq	0x15cb(%rip), %rdx      # 0x1400063fb
140004e30:     	vmovq	%xmm11, %r8
140004e35:     	movq	%rsi, %rcx
140004e38:     	vmovapd	%xmm11, %xmm2
140004e3c:     	callq	0x140004f90 <.text+0x3f90>
140004e41:     	leaq	0x15ba(%rip), %rcx      # 0x140006402
140004e48:     	movl	%edi, %edx
140004e4a:     	callq	0x140004f90 <.text+0x3f90>
140004e4f:     	leaq	0x15c1(%rip), %rdx      # 0x140006417
140004e56:     	vmovq	%xmm12, %r8
140004e5b:     	movq	%rsi, %rcx
140004e5e:     	vmovapd	%xmm12, %xmm2
140004e62:     	callq	0x140004f90 <.text+0x3f90>
140004e67:     	leaq	0x15b1(%rip), %rcx      # 0x14000641f
140004e6e:     	vmovq	%xmm8, %rdx
140004e73:     	vmovq	%xmm7, %r8
140004e78:     	vmovq	%xmm9, %r9
140004e7d:     	vmovups	%xmm6, 0x20(%rsp)
140004e83:     	vmovapd	%xmm8, %xmm1
140004e87:     	vmovapd	%xmm7, %xmm2
140004e8b:     	vmovapd	%xmm9, %xmm3
140004e8f:     	callq	0x140004f90 <.text+0x3f90>
140004e94:     	vmovaps	0x440(%rsp), %xmm6
140004e9d:     	vmovaps	0x450(%rsp), %xmm7
140004ea6:     	vmovaps	0x460(%rsp), %xmm8
140004eaf:     	vmovaps	0x470(%rsp), %xmm9
140004eb8:     	vmovaps	0x480(%rsp), %xmm10
140004ec1:     	vmovaps	0x490(%rsp), %xmm11
140004eca:     	vmovaps	0x4a0(%rsp), %xmm12
140004ed3:     	vmovaps	0x4b0(%rsp), %xmm13
140004edc:     	vmovaps	0x4c0(%rsp), %xmm14
140004ee5:     	vmovaps	0x4d0(%rsp), %xmm15
140004eee:     	xorl	%eax, %eax
140004ef0:     	addq	$0x4e8, %rsp            # imm = 0x4E8
140004ef7:     	popq	%rbx
140004ef8:     	popq	%rbp
140004ef9:     	popq	%rdi
140004efa:     	popq	%rsi
140004efb:     	popq	%r12
140004efd:     	popq	%r13
140004eff:     	popq	%r14
140004f01:     	popq	%r15
140004f03:     	retq
140004f04:     	vmovsd	0x1334(%rip), %xmm8     # 0x140006240
140004f0c:     	vmovddup	0x132c(%rip), %xmm6     # xmm6 = mem[0,0]
                                                # 0x140006240
140004f14:     	vxorpd	%xmm0, %xmm0, %xmm0
140004f18:     	vxorpd	%xmm12, %xmm12, %xmm12
140004f1d:     	xorl	%edi, %edi
140004f1f:     	vxorpd	%xmm11, %xmm11, %xmm11
140004f24:     	vxorpd	%xmm13, %xmm13, %xmm13
140004f29:     	vmovsd	%xmm0, 0xe0(%rsp)
140004f32:     	vpxor	%xmm2, %xmm2, %xmm2
140004f36:     	vmovapd	%xmm8, %xmm7
140004f3a:     	vmovapd	%xmm8, %xmm9
140004f3f:     	jmp	0x140004dd9 <.text+0x3dd9>
140004f44:     	vzeroupper
140004f47:     	callq	0x140004f50 <.text+0x3f50>
140004f4c:     	int3
140004f4d:     	nopl	(%rax)
140004f50:     	subq	$0x28, %rsp
140004f54:     	movl	$0x2, %ecx
140004f59:     	callq	*0x1211(%rip)           # 0x140006170
140004f5f:     	leaq	0x1522(%rip), %rcx      # 0x140006488
140004f66:     	movl	$0xb, %edx
140004f6b:     	movl	$0x1, %r8d
140004f71:     	movq	%rax, %r9
140004f74:     	callq	0x14000500c <.text+0x400c>
140004f79:     	movl	$0x1, %ecx
140004f7e:     	callq	*0x11b4(%rip)           # 0x140006138
140004f84:     	int3
140004f85:     	int3
140004f86:     	int3
140004f87:     	int3
140004f88:     	int3
140004f89:     	int3
140004f8a:     	int3
140004f8b:     	int3
140004f8c:     	int3
140004f8d:     	int3
140004f8e:     	int3
140004f8f:     	int3
140004f90:     	pushq	%rsi
140004f91:     	pushq	%rdi
140004f92:     	pushq	%rbx
140004f93:     	subq	$0x30, %rsp
140004f97:     	movq	%rcx, %rsi
140004f9a:     	leaq	0x58(%rsp), %rbx
140004f9f:     	movl	$0x1, %ecx
140004fa4:     	movq	%rdx, 0x58(%rsp)
140004fa9:     	movq	%r8, 0x60(%rsp)
140004fae:     	movq	%r9, 0x68(%rsp)
140004fb3:     	movq	%rbx, 0x28(%rsp)
140004fb8:     	callq	*0x11b2(%rip)           # 0x140006170
140004fbe:     	movq	%rax, %rdi
140004fc1:     	callq	0x140004ff0 <.text+0x3ff0>
140004fc6:     	movq	(%rax), %rcx
140004fc9:     	movq	%rbx, 0x20(%rsp)
140004fce:     	movq	%rdi, %rdx
140004fd1:     	movq	%rsi, %r8
140004fd4:     	xorl	%r9d, %r9d
140004fd7:     	callq	*0x119b(%rip)           # 0x140006178
140004fdd:     	nop
140004fde:     	addq	$0x30, %rsp
140004fe2:     	popq	%rbx
140004fe3:     	popq	%rdi
140004fe4:     	popq	%rsi
140004fe5:     	retq
140004fe6:     	int3
140004fe7:     	int3
140004fe8:     	int3
140004fe9:     	int3
140004fea:     	int3
140004feb:     	int3
140004fec:     	int3
140004fed:     	int3
140004fee:     	int3
140004fef:     	int3
140004ff0:     	leaq	0x30a9(%rip), %rax      # 0x1400080a0
140004ff7:     	retq
140004ff8:     	int3
140004ff9:     	int3
140004ffa:     	int3
140004ffb:     	int3
140004ffc:     	int3
140004ffd:     	int3
140004ffe:     	int3
140004fff:     	int3
140005000:     	jmpq	*0x10aa(%rip)           # 0x1400060b0
140005006:     	jmpq	*0x10ac(%rip)           # 0x1400060b8
14000500c:     	jmpq	*0x116e(%rip)           # 0x140006180
140005012:     	jmpq	*0x1120(%rip)           # 0x140006138
140005018:     	jmpq	*0x103a(%rip)           # 0x140006058
14000501e:     	int3
14000501f:     	int3
140005020:     	pushq	%rbx
140005022:     	subq	$0x20, %rsp
140005026:     	movl	$0x1, %ecx
14000502b:     	callq	0x1400059e6 <.text+0x49e6>
140005030:     	callq	0x140005590 <.text+0x4590>
140005035:     	movl	%eax, %ecx
140005037:     	callq	0x140005a16 <.text+0x4a16>
14000503c:     	callq	0x140005584 <.text+0x4584>
140005041:     	movl	%eax, %ebx
140005043:     	callq	0x140005a46 <.text+0x4a46>
140005048:     	movl	$0x1, %ecx
14000504d:     	movl	%ebx, (%rax)
14000504f:     	callq	0x14000530c <.text+0x430c>
140005054:     	testb	%al, %al
140005056:     	je	0x1400050cb <.text+0x40cb>
140005058:     	callq	0x1400056c0 <.text+0x46c0>
14000505d:     	leaq	0x698(%rip), %rcx       # 0x1400056fc <.text+0x46fc>
140005064:     	callq	0x1400054bc <.text+0x44bc>
140005069:     	callq	0x140005588 <.text+0x4588>
14000506e:     	movl	%eax, %ecx
140005070:     	callq	0x1400059f2 <.text+0x49f2>
140005075:     	testl	%eax, %eax
140005077:     	jne	0x1400050cb <.text+0x40cb>
140005079:     	callq	0x140005598 <.text+0x4598>
14000507e:     	callq	0x1400055d4 <.text+0x45d4>
140005083:     	testl	%eax, %eax
140005085:     	je	0x140005093 <.text+0x4093>
140005087:     	leaq	0x4f6(%rip), %rcx       # 0x140005584 <.text+0x4584>
14000508e:     	callq	0x1400059ec <.text+0x49ec>
140005093:     	callq	0x1400055ac <.text+0x45ac>
140005098:     	callq	0x1400055ac <.text+0x45ac>
14000509d:     	callq	0x140005584 <.text+0x4584>
1400050a2:     	movl	%eax, %ecx
1400050a4:     	callq	0x140005a3a <.text+0x4a3a>
1400050a9:     	callq	0x1400055a8 <.text+0x45a8>
1400050ae:     	testb	%al, %al
1400050b0:     	je	0x1400050b7 <.text+0x40b7>
1400050b2:     	callq	0x1400059f8 <.text+0x49f8>
1400050b7:     	callq	0x140005584 <.text+0x4584>
1400050bc:     	callq	0x1400055f8 <.text+0x45f8>
1400050c1:     	testl	%eax, %eax
1400050c3:     	jne	0x1400050cb <.text+0x40cb>
1400050c5:     	addq	$0x20, %rsp
1400050c9:     	popq	%rbx
1400050ca:     	retq
1400050cb:     	movl	$0x7, %ecx
1400050d0:     	callq	0x1400055f0 <.text+0x45f0>
1400050d5:     	int3
1400050d6:     	int3
1400050d7:     	int3
1400050d8:     	subq	$0x28, %rsp
1400050dc:     	callq	0x1400055b8 <.text+0x45b8>
1400050e1:     	xorl	%eax, %eax
1400050e3:     	addq	$0x28, %rsp
1400050e7:     	retq
1400050e8:     	subq	$0x28, %rsp
1400050ec:     	callq	0x140005654 <.text+0x4654>
1400050f1:     	callq	0x140005584 <.text+0x4584>
1400050f6:     	movl	%eax, %ecx
1400050f8:     	addq	$0x28, %rsp
1400050fc:     	jmp	0x140005a40 <.text+0x4a40>
140005101:     	int3
140005102:     	int3
140005103:     	int3
140005104:     	movq	%rbx, 0x8(%rsp)
140005109:     	movq	%rsi, 0x10(%rsp)
14000510e:     	pushq	%rdi
14000510f:     	subq	$0x30, %rsp
140005113:     	movl	$0x1, %ecx
140005118:     	callq	0x1400052d0 <.text+0x42d0>
14000511d:     	testb	%al, %al
14000511f:     	je	0x14000525b <.text+0x425b>
140005125:     	xorb	%sil, %sil
140005128:     	movb	%sil, 0x20(%rsp)
14000512d:     	callq	0x140005294 <.text+0x4294>
140005132:     	movb	%al, %bl
140005134:     	movl	0x2f76(%rip), %ecx      # 0x1400080b0
14000513a:     	cmpl	$0x1, %ecx
14000513d:     	je	0x140005266 <.text+0x4266>
140005143:     	testl	%ecx, %ecx
140005145:     	jne	0x140005191 <.text+0x4191>
140005147:     	movl	$0x1, 0x2f5f(%rip)      # 0x1400080b0
140005151:     	leaq	0x10b8(%rip), %rdx      # 0x140006210
140005158:     	leaq	0x1099(%rip), %rcx      # 0x1400061f8
14000515f:     	callq	0x140005a0a <.text+0x4a0a>
140005164:     	testl	%eax, %eax
140005166:     	je	0x140005172 <.text+0x4172>
140005168:     	movl	$0xff, %eax
14000516d:     	jmp	0x14000524b <.text+0x424b>
140005172:     	leaq	0x1077(%rip), %rdx      # 0x1400061f0
140005179:     	leaq	0x1060(%rip), %rcx      # 0x1400061e0
140005180:     	callq	0x140005a04 <.text+0x4a04>
140005185:     	movl	$0x2, 0x2f21(%rip)      # 0x1400080b0
14000518f:     	jmp	0x140005199 <.text+0x4199>
140005191:     	movb	$0x1, %sil
140005194:     	movb	%sil, 0x20(%rsp)
140005199:     	movb	%bl, %cl
14000519b:     	callq	0x140005430 <.text+0x4430>
1400051a0:     	callq	0x1400055e0 <.text+0x45e0>
1400051a5:     	movq	%rax, %rbx
1400051a8:     	cmpq	$0x0, (%rax)
1400051ac:     	je	0x1400051cc <.text+0x41cc>
1400051ae:     	movq	%rax, %rcx
1400051b1:     	callq	0x140005398 <.text+0x4398>
1400051b6:     	testb	%al, %al
1400051b8:     	je	0x1400051cc <.text+0x41cc>
1400051ba:     	xorl	%r8d, %r8d
1400051bd:     	leal	0x2(%r8), %edx
1400051c1:     	xorl	%ecx, %ecx
1400051c3:     	movq	(%rbx), %rax
1400051c6:     	callq	*0xfec(%rip)            # 0x1400061b8
1400051cc:     	callq	0x1400055e8 <.text+0x45e8>
1400051d1:     	movq	%rax, %rbx
1400051d4:     	cmpq	$0x0, (%rax)
1400051d8:     	je	0x1400051ee <.text+0x41ee>
1400051da:     	movq	%rax, %rcx
1400051dd:     	callq	0x140005398 <.text+0x4398>
1400051e2:     	testb	%al, %al
1400051e4:     	je	0x1400051ee <.text+0x41ee>
1400051e6:     	movq	(%rbx), %rcx
1400051e9:     	callq	0x140005a34 <.text+0x4a34>
1400051ee:     	callq	0x1400059fe <.text+0x49fe>
1400051f3:     	movq	%rax, %rdi
1400051f6:     	callq	0x140005a22 <.text+0x4a22>
1400051fb:     	movq	(%rax), %rbx
1400051fe:     	callq	0x140005a1c <.text+0x4a1c>
140005203:     	movq	%rdi, %r8
140005206:     	movq	%rbx, %rdx
140005209:     	movl	(%rax), %ecx
14000520b:     	callq	0x140001000 <.text>
140005210:     	movl	%eax, %ebx
140005212:     	callq	0x140005600 <.text+0x4600>
140005217:     	testb	%al, %al
140005219:     	je	0x140005270 <.text+0x4270>
14000521b:     	testb	%sil, %sil
14000521e:     	jne	0x140005225 <.text+0x4225>
140005220:     	callq	0x140005a28 <.text+0x4a28>
140005225:     	xorl	%edx, %edx
140005227:     	movb	$0x1, %cl
140005229:     	callq	0x140005454 <.text+0x4454>
14000522e:     	movl	%ebx, %eax
140005230:     	jmp	0x14000524b <.text+0x424b>
140005232:     	movl	%eax, %ebx
140005234:     	callq	0x140005600 <.text+0x4600>
140005239:     	testb	%al, %al
14000523b:     	je	0x140005278 <.text+0x4278>
14000523d:     	cmpb	$0x0, 0x20(%rsp)
140005242:     	jne	0x140005249 <.text+0x4249>
140005244:     	callq	0x140005a2e <.text+0x4a2e>
140005249:     	movl	%ebx, %eax
14000524b:     	movq	0x40(%rsp), %rbx
140005250:     	movq	0x48(%rsp), %rsi
140005255:     	addq	$0x30, %rsp
140005259:     	popq	%rdi
14000525a:     	retq
14000525b:     	movl	$0x7, %ecx
140005260:     	callq	0x1400055f0 <.text+0x45f0>
140005265:     	nop
140005266:     	movl	$0x7, %ecx
14000526b:     	callq	0x1400055f0 <.text+0x45f0>
140005270:     	movl	%ebx, %ecx
140005272:     	callq	0x140005012 <.text+0x4012>
140005277:     	nop
140005278:     	movl	%ebx, %ecx
14000527a:     	callq	0x140005a10 <.text+0x4a10>
14000527f:     	nop
140005280:     	subq	$0x28, %rsp
140005284:     	callq	0x1400054d4 <.text+0x44d4>
140005289:     	addq	$0x28, %rsp
14000528d:     	jmp	0x140005104 <.text+0x4104>
140005292:     	int3
140005293:     	int3
140005294:     	subq	$0x28, %rsp
140005298:     	callq	0x1400059d4 <.text+0x49d4>
14000529d:     	testl	%eax, %eax
14000529f:     	je	0x1400052c2 <.text+0x42c2>
1400052a1:     	movq	%gs:0x30, %rax
1400052aa:     	movq	0x8(%rax), %rcx
1400052ae:     	jmp	0x1400052b5 <.text+0x42b5>
1400052b0:     	cmpq	%rax, %rcx
1400052b3:     	je	0x1400052c9 <.text+0x42c9>
1400052b5:     	xorl	%eax, %eax
1400052b7:     	lock
1400052b8:     	cmpxchgq	%rcx, 0x2df8(%rip)      # 0x1400080b8
1400052c0:     	jne	0x1400052b0 <.text+0x42b0>
1400052c2:     	xorb	%al, %al
1400052c4:     	addq	$0x28, %rsp
1400052c8:     	retq
1400052c9:     	movb	$0x1, %al
1400052cb:     	jmp	0x1400052c4 <.text+0x42c4>
1400052cd:     	int3
1400052ce:     	int3
1400052cf:     	int3
1400052d0:     	subq	$0x28, %rsp
1400052d4:     	testl	%ecx, %ecx
1400052d6:     	jne	0x1400052df <.text+0x42df>
1400052d8:     	movb	$0x1, 0x2de1(%rip)      # 0x1400080c0
1400052df:     	callq	0x140005738 <.text+0x4738>
1400052e4:     	callq	0x1400055a8 <.text+0x45a8>
1400052e9:     	testb	%al, %al
1400052eb:     	jne	0x1400052f1 <.text+0x42f1>
1400052ed:     	xorb	%al, %al
1400052ef:     	jmp	0x140005305 <.text+0x4305>
1400052f1:     	callq	0x1400055a8 <.text+0x45a8>
1400052f6:     	testb	%al, %al
1400052f8:     	jne	0x140005303 <.text+0x4303>
1400052fa:     	xorl	%ecx, %ecx
1400052fc:     	callq	0x1400055a8 <.text+0x45a8>
140005301:     	jmp	0x1400052ed <.text+0x42ed>
140005303:     	movb	$0x1, %al
140005305:     	addq	$0x28, %rsp
140005309:     	retq
14000530a:     	int3
14000530b:     	int3
14000530c:     	pushq	%rbx
14000530e:     	subq	$0x20, %rsp
140005312:     	cmpb	$0x0, 0x2da8(%rip)      # 0x1400080c1
140005319:     	movl	%ecx, %ebx
14000531b:     	jne	0x140005384 <.text+0x4384>
14000531d:     	cmpl	$0x1, %ecx
140005320:     	ja	0x14000538c <.text+0x438c>
140005322:     	callq	0x1400059d4 <.text+0x49d4>
140005327:     	testl	%eax, %eax
140005329:     	je	0x140005353 <.text+0x4353>
14000532b:     	testl	%ebx, %ebx
14000532d:     	jne	0x140005353 <.text+0x4353>
14000532f:     	leaq	0x2d92(%rip), %rcx      # 0x1400080c8
140005336:     	callq	0x140005a4c <.text+0x4a4c>
14000533b:     	testl	%eax, %eax
14000533d:     	jne	0x14000534f <.text+0x434f>
14000533f:     	leaq	0x2d9a(%rip), %rcx      # 0x1400080e0
140005346:     	callq	0x140005a4c <.text+0x4a4c>
14000534b:     	testl	%eax, %eax
14000534d:     	je	0x14000537d <.text+0x437d>
14000534f:     	xorb	%al, %al
140005351:     	jmp	0x140005386 <.text+0x4386>
140005353:     	movdqa	0x1155(%rip), %xmm0     # 0x1400064b0
14000535b:     	orq	$-0x1, %rax
14000535f:     	movdqu	%xmm0, 0x2d61(%rip)     # 0x1400080c8
140005367:     	movq	%rax, 0x2d6a(%rip)      # 0x1400080d8
14000536e:     	movdqu	%xmm0, 0x2d6a(%rip)     # 0x1400080e0
140005376:     	movq	%rax, 0x2d73(%rip)      # 0x1400080f0
14000537d:     	movb	$0x1, 0x2d3d(%rip)      # 0x1400080c1
140005384:     	movb	$0x1, %al
140005386:     	addq	$0x20, %rsp
14000538a:     	popq	%rbx
14000538b:     	retq
14000538c:     	movl	$0x5, %ecx
140005391:     	callq	0x1400055f0 <.text+0x45f0>
140005396:     	int3
140005397:     	int3
140005398:     	subq	$0x18, %rsp
14000539c:     	movq	%rcx, %r8
14000539f:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
1400053a4:     	cmpw	%ax, -0x53ab(%rip)      # 0x140000000
1400053ab:     	jne	0x140005425 <.text+0x4425>
1400053ad:     	movslq	-0x5378(%rip), %rcx     # 0x14000003c
1400053b4:     	leaq	-0x53bb(%rip), %rdx     # 0x140000000
1400053bb:     	addq	%rdx, %rcx
1400053be:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
1400053c4:     	jne	0x140005425 <.text+0x4425>
1400053c6:     	movl	$0x20b, %eax            # imm = 0x20B
1400053cb:     	cmpw	%ax, 0x18(%rcx)
1400053cf:     	jne	0x140005425 <.text+0x4425>
1400053d1:     	subq	%rdx, %r8
1400053d4:     	movzwl	0x14(%rcx), %edx
1400053d8:     	addq	$0x18, %rdx
1400053dc:     	addq	%rcx, %rdx
1400053df:     	movzwl	0x6(%rcx), %eax
1400053e3:     	leaq	(%rax,%rax,4), %rcx
1400053e7:     	leaq	(%rdx,%rcx,8), %r9
1400053eb:     	movq	%rdx, (%rsp)
1400053ef:     	cmpq	%r9, %rdx
1400053f2:     	je	0x14000540c <.text+0x440c>
1400053f4:     	movl	0xc(%rdx), %ecx
1400053f7:     	cmpq	%rcx, %r8
1400053fa:     	jb	0x140005406 <.text+0x4406>
1400053fc:     	movl	0x8(%rdx), %eax
1400053ff:     	addl	%ecx, %eax
140005401:     	cmpq	%rax, %r8
140005404:     	jb	0x14000540e <.text+0x440e>
140005406:     	addq	$0x28, %rdx
14000540a:     	jmp	0x1400053eb <.text+0x43eb>
14000540c:     	xorl	%edx, %edx
14000540e:     	testq	%rdx, %rdx
140005411:     	jne	0x140005417 <.text+0x4417>
140005413:     	xorb	%al, %al
140005415:     	jmp	0x14000542b <.text+0x442b>
140005417:     	cmpl	$0x0, 0x24(%rdx)
14000541b:     	jge	0x140005421 <.text+0x4421>
14000541d:     	xorb	%al, %al
14000541f:     	jmp	0x14000542b <.text+0x442b>
140005421:     	movb	$0x1, %al
140005423:     	jmp	0x14000542b <.text+0x442b>
140005425:     	xorb	%al, %al
140005427:     	jmp	0x14000542b <.text+0x442b>
140005429:     	xorb	%al, %al
14000542b:     	addq	$0x18, %rsp
14000542f:     	retq
140005430:     	pushq	%rbx
140005432:     	subq	$0x20, %rsp
140005436:     	movb	%cl, %bl
140005438:     	callq	0x1400059d4 <.text+0x49d4>
14000543d:     	xorl	%edx, %edx
14000543f:     	testl	%eax, %eax
140005441:     	je	0x14000544e <.text+0x444e>
140005443:     	testb	%bl, %bl
140005445:     	jne	0x14000544e <.text+0x444e>
140005447:     	xchgq	%rdx, 0x2c6a(%rip)      # 0x1400080b8
14000544e:     	addq	$0x20, %rsp
140005452:     	popq	%rbx
140005453:     	retq
140005454:     	pushq	%rbx
140005456:     	subq	$0x20, %rsp
14000545a:     	cmpb	$0x0, 0x2c5f(%rip)      # 0x1400080c0
140005461:     	movb	%cl, %bl
140005463:     	je	0x140005469 <.text+0x4469>
140005465:     	testb	%dl, %dl
140005467:     	jne	0x140005475 <.text+0x4475>
140005469:     	callq	0x1400055a8 <.text+0x45a8>
14000546e:     	movb	%bl, %cl
140005470:     	callq	0x1400055a8 <.text+0x45a8>
140005475:     	movb	$0x1, %al
140005477:     	addq	$0x20, %rsp
14000547b:     	popq	%rbx
14000547c:     	retq
14000547d:     	int3
14000547e:     	int3
14000547f:     	int3
140005480:     	pushq	%rbx
140005482:     	subq	$0x20, %rsp
140005486:     	cmpq	$-0x1, 0x2c3a(%rip)     # 0x1400080c8
14000548e:     	movq	%rcx, %rbx
140005491:     	jne	0x14000549a <.text+0x449a>
140005493:     	callq	0x140005a58 <.text+0x4a58>
140005498:     	jmp	0x1400054a9 <.text+0x44a9>
14000549a:     	movq	%rbx, %rdx
14000549d:     	leaq	0x2c24(%rip), %rcx      # 0x1400080c8
1400054a4:     	callq	0x140005a52 <.text+0x4a52>
1400054a9:     	xorl	%edx, %edx
1400054ab:     	testl	%eax, %eax
1400054ad:     	cmoveq	%rbx, %rdx
1400054b1:     	movq	%rdx, %rax
1400054b4:     	addq	$0x20, %rsp
1400054b8:     	popq	%rbx
1400054b9:     	retq
1400054ba:     	int3
1400054bb:     	int3
1400054bc:     	subq	$0x28, %rsp
1400054c0:     	callq	0x140005480 <.text+0x4480>
1400054c5:     	negq	%rax
1400054c8:     	sbbl	%eax, %eax
1400054ca:     	negl	%eax
1400054cc:     	decl	%eax
1400054ce:     	addq	$0x28, %rsp
1400054d2:     	retq
1400054d3:     	int3
1400054d4:     	movq	%rbx, 0x18(%rsp)
1400054d9:     	pushq	%rbp
1400054da:     	movq	%rsp, %rbp
1400054dd:     	subq	$0x30, %rsp
1400054e1:     	movq	0x2b58(%rip), %rax      # 0x140008040
1400054e8:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1400054f2:     	cmpq	%rbx, %rax
1400054f5:     	jne	0x14000556e <.text+0x456e>
1400054f7:     	leaq	0x10(%rbp), %rcx
1400054fb:     	movq	$0x0, 0x10(%rbp)
140005503:     	callq	*0xaff(%rip)            # 0x140006008
140005509:     	movq	0x10(%rbp), %rax
14000550d:     	movq	%rax, -0x10(%rbp)
140005511:     	callq	*0xae9(%rip)            # 0x140006000
140005517:     	movl	%eax, %eax
140005519:     	xorq	%rax, -0x10(%rbp)
14000551d:     	callq	*0xb0d(%rip)            # 0x140006030
140005523:     	movl	%eax, %eax
140005525:     	leaq	0x18(%rbp), %rcx
140005529:     	xorq	%rax, -0x10(%rbp)
14000552d:     	callq	*0xaed(%rip)            # 0x140006020
140005533:     	movl	0x18(%rbp), %eax
140005536:     	leaq	-0x10(%rbp), %rcx
14000553a:     	shlq	$0x20, %rax
14000553e:     	xorq	0x18(%rbp), %rax
140005542:     	xorq	-0x10(%rbp), %rax
140005546:     	xorq	%rcx, %rax
140005549:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
140005553:     	andq	%rcx, %rax
140005556:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
140005560:     	cmpq	%rbx, %rax
140005563:     	cmoveq	%rcx, %rax
140005567:     	movq	%rax, 0x2ad2(%rip)      # 0x140008040
14000556e:     	movq	0x50(%rsp), %rbx
140005573:     	notq	%rax
140005576:     	movq	%rax, 0x2b03(%rip)      # 0x140008080
14000557d:     	addq	$0x30, %rsp
140005581:     	popq	%rbp
140005582:     	retq
140005583:     	int3
140005584:     	xorl	%eax, %eax
140005586:     	retq
140005587:     	int3
140005588:     	movl	$0x1, %eax
14000558d:     	retq
14000558e:     	int3
14000558f:     	int3
140005590:     	movl	$0x4000, %eax           # imm = 0x4000
140005595:     	retq
140005596:     	int3
140005597:     	int3
140005598:     	leaq	0x2b61(%rip), %rcx      # 0x140008100
14000559f:     	jmpq	*0xa6a(%rip)            # 0x140006010
1400055a6:     	int3
1400055a7:     	int3
1400055a8:     	movb	$0x1, %al
1400055aa:     	retq
1400055ab:     	int3
1400055ac:     	retq	$0x0
1400055af:     	int3
1400055b0:     	leaq	0x2b59(%rip), %rax      # 0x140008110
1400055b7:     	retq
1400055b8:     	subq	$0x28, %rsp
1400055bc:     	callq	0x140004ff0 <.text+0x3ff0>
1400055c1:     	orq	$0x24, (%rax)
1400055c5:     	callq	0x1400055b0 <.text+0x45b0>
1400055ca:     	orq	$0x2, (%rax)
1400055ce:     	addq	$0x28, %rsp
1400055d2:     	retq
1400055d3:     	int3
1400055d4:     	xorl	%eax, %eax
1400055d6:     	cmpl	%eax, 0x2a2c(%rip)      # 0x140008008
1400055dc:     	sete	%al
1400055df:     	retq
1400055e0:     	leaq	0x2b49(%rip), %rax      # 0x140008130
1400055e7:     	retq
1400055e8:     	leaq	0x2b39(%rip), %rax      # 0x140008128
1400055ef:     	retq
1400055f0:     	movl	%ecx, %ecx
1400055f2:     	int	$0x29
1400055f4:     	retq
1400055f5:     	int3
1400055f6:     	int3
1400055f7:     	int3
1400055f8:     	jmp	0x140005584 <.text+0x4584>
1400055fd:     	int3
1400055fe:     	int3
1400055ff:     	int3
140005600:     	subq	$0x28, %rsp
140005604:     	xorl	%ecx, %ecx
140005606:     	callq	*0xa1c(%rip)            # 0x140006028
14000560c:     	testq	%rax, %rax
14000560f:     	je	0x14000564b <.text+0x464b>
140005611:     	movl	$0x5a4d, %ecx           # imm = 0x5A4D
140005616:     	cmpw	%cx, (%rax)
140005619:     	jne	0x14000564b <.text+0x464b>
14000561b:     	movslq	0x3c(%rax), %rcx
14000561f:     	cmpl	$0x4550, (%rcx,%rax)    # imm = 0x4550
140005626:     	jne	0x14000564b <.text+0x464b>
140005628:     	movl	$0x20b, %edx            # imm = 0x20B
14000562d:     	cmpw	%dx, 0x18(%rcx,%rax)
140005632:     	jne	0x14000564b <.text+0x464b>
140005634:     	cmpl	$0xe, 0x84(%rcx,%rax)
14000563c:     	jbe	0x14000564b <.text+0x464b>
14000563e:     	cmpl	$0x0, 0xf8(%rcx,%rax)
140005646:     	setne	%al
140005649:     	jmp	0x14000564d <.text+0x464d>
14000564b:     	xorb	%al, %al
14000564d:     	addq	$0x28, %rsp
140005651:     	retq
140005652:     	int3
140005653:     	int3
140005654:     	leaq	0x9(%rip), %rcx         # 0x140005664 <.text+0x4664>
14000565b:     	jmpq	*0x9b6(%rip)            # 0x140006018
140005662:     	int3
140005663:     	int3
140005664:     	movq	%rbx, 0x8(%rsp)
140005669:     	pushq	%rdi
14000566a:     	subq	$0x20, %rsp
14000566e:     	movq	(%rcx), %rbx
140005671:     	movq	%rcx, %rdi
140005674:     	cmpl	$0xe06d7363, (%rbx)     # imm = 0xE06D7363
14000567a:     	jne	0x140005698 <.text+0x4698>
14000567c:     	cmpl	$0x4, 0x18(%rbx)
140005680:     	jne	0x140005698 <.text+0x4698>
140005682:     	movl	0x20(%rbx), %edx
140005685:     	leal	-0x19930520(%rdx), %eax
14000568b:     	cmpl	$0x2, %eax
14000568e:     	jbe	0x1400056a5 <.text+0x46a5>
140005690:     	cmpl	$0x1994000, %edx        # imm = 0x1994000
140005696:     	je	0x1400056a5 <.text+0x46a5>
140005698:     	movq	0x30(%rsp), %rbx
14000569d:     	xorl	%eax, %eax
14000569f:     	addq	$0x20, %rsp
1400056a3:     	popq	%rdi
1400056a4:     	retq
1400056a5:     	callq	0x140005a6a <.text+0x4a6a>
1400056aa:     	movq	%rbx, (%rax)
1400056ad:     	movq	0x8(%rdi), %rbx
1400056b1:     	callq	0x140005a70 <.text+0x4a70>
1400056b6:     	movq	%rbx, (%rax)
1400056b9:     	callq	0x140005a5e <.text+0x4a5e>
1400056be:     	int3
1400056bf:     	int3
1400056c0:     	movq	%rbx, 0x8(%rsp)
1400056c5:     	pushq	%rdi
1400056c6:     	subq	$0x20, %rsp
1400056ca:     	leaq	0x126f(%rip), %rbx      # 0x140006940
1400056d1:     	leaq	0x1268(%rip), %rdi      # 0x140006940
1400056d8:     	jmp	0x1400056ec <.text+0x46ec>
1400056da:     	movq	(%rbx), %rax
1400056dd:     	testq	%rax, %rax
1400056e0:     	je	0x1400056e8 <.text+0x46e8>
1400056e2:     	callq	*0xad0(%rip)            # 0x1400061b8
1400056e8:     	addq	$0x8, %rbx
1400056ec:     	cmpq	%rdi, %rbx
1400056ef:     	jb	0x1400056da <.text+0x46da>
1400056f1:     	movq	0x30(%rsp), %rbx
1400056f6:     	addq	$0x20, %rsp
1400056fa:     	popq	%rdi
1400056fb:     	retq
1400056fc:     	movq	%rbx, 0x8(%rsp)
140005701:     	pushq	%rdi
140005702:     	subq	$0x20, %rsp
140005706:     	leaq	0x1243(%rip), %rbx      # 0x140006950
14000570d:     	leaq	0x123c(%rip), %rdi      # 0x140006950
140005714:     	jmp	0x140005728 <.text+0x4728>
140005716:     	movq	(%rbx), %rax
140005719:     	testq	%rax, %rax
14000571c:     	je	0x140005724 <.text+0x4724>
14000571e:     	callq	*0xa94(%rip)            # 0x1400061b8
140005724:     	addq	$0x8, %rbx
140005728:     	cmpq	%rdi, %rbx
14000572b:     	jb	0x140005716 <.text+0x4716>
14000572d:     	movq	0x30(%rsp), %rbx
140005732:     	addq	$0x20, %rsp
140005736:     	popq	%rdi
140005737:     	retq
140005738:     	movq	%rbx, 0x10(%rsp)
14000573d:     	movq	%rbp, 0x18(%rsp)
140005742:     	movq	%rsi, 0x20(%rsp)
140005747:     	pushq	%rdi
140005748:     	subq	$0x10, %rsp
14000574c:     	xorl	%eax, %eax
14000574e:     	xorl	%ecx, %ecx
140005750:     	cpuid
140005752:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
140005758:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
14000575e:     	orl	%ecx, %edx
140005760:     	movl	%eax, %ebp
140005762:     	movl	$0x1, %eax
140005767:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
14000576d:     	orl	%ebx, %edx
14000576f:     	leal	-0x1(%rax), %ecx
140005772:     	cpuid
140005774:     	movl	%ecx, %edi
140005776:     	jne	0x1400057d6 <.text+0x47d6>
140005778:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
14000577d:     	movq	$0x8000, 0x2890(%rip)   # imm = 0x8000
                                                # 0x140008018
140005788:     	movq	$-0x1, 0x288d(%rip)     # 0x140008020
140005793:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
140005798:     	je	0x1400057c2 <.text+0x47c2>
14000579a:     	cmpl	$0x20660, %eax          # imm = 0x20660
14000579f:     	je	0x1400057c2 <.text+0x47c2>
1400057a1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1400057a6:     	je	0x1400057c2 <.text+0x47c2>
1400057a8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1400057ad:     	cmpl	$0x20, %eax
1400057b0:     	ja	0x1400057d6 <.text+0x47d6>
1400057b2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1400057bc:     	btq	%rax, %rcx
1400057c0:     	jae	0x1400057d6 <.text+0x47d6>
1400057c2:     	movl	0x2953(%rip), %r8d      # 0x14000811c
1400057c9:     	orl	$0x1, %r8d
1400057cd:     	movl	%r8d, 0x2948(%rip)      # 0x14000811c
1400057d4:     	jmp	0x1400057dd <.text+0x47dd>
1400057d6:     	movl	0x293f(%rip), %r8d      # 0x14000811c
1400057dd:     	xorl	%r9d, %r9d
1400057e0:     	movl	%r9d, %r11d
1400057e3:     	cmpl	$0x7, %ebp
1400057e6:     	jl	0x14000582a <.text+0x482a>
1400057e8:     	xorl	%ecx, %ecx
1400057ea:     	leal	0x7(%r9), %eax
1400057ee:     	cpuid
1400057f0:     	movl	%edx, %esi
1400057f2:     	movl	%ebx, %r10d
1400057f5:     	btl	$0x9, %ebx
1400057f9:     	jae	0x140005806 <.text+0x4806>
1400057fb:     	orl	$0x2, %r8d
1400057ff:     	movl	%r8d, 0x2916(%rip)      # 0x14000811c
140005806:     	cmpl	$0x1, %eax
140005809:     	jl	0x140005818 <.text+0x4818>
14000580b:     	movl	$0x7, %eax
140005810:     	leal	-0x6(%rax), %ecx
140005813:     	cpuid
140005815:     	movl	%edx, %r9d
140005818:     	movl	$0x24, %eax
14000581d:     	cmpl	%eax, %ebp
14000581f:     	jl	0x140005830 <.text+0x4830>
140005821:     	xorl	%ecx, %ecx
140005823:     	cpuid
140005825:     	movl	%ebx, %r11d
140005828:     	jmp	0x140005830 <.text+0x4830>
14000582a:     	movl	%r9d, %r10d
14000582d:     	movl	%r9d, %esi
140005830:     	movq	0x27f1(%rip), %rax      # 0x140008028
140005837:     	andq	$-0x2, %rax
14000583b:     	movl	$0x1, 0x27cb(%rip)      # 0x140008010
140005845:     	movl	$0x2, 0x27c5(%rip)      # 0x140008014
14000584f:     	movq	%rax, 0x27d2(%rip)      # 0x140008028
140005856:     	btl	$0x14, %edi
14000585a:     	jae	0x14000587b <.text+0x487b>
14000585c:     	andq	$-0x11, %rax
140005860:     	movl	$0x2, 0x27a6(%rip)      # 0x140008010
14000586a:     	movq	%rax, 0x27b7(%rip)      # 0x140008028
140005871:     	movl	$0x6, 0x2799(%rip)      # 0x140008014
14000587b:     	btl	$0x1b, %edi
14000587f:     	jae	0x1400059bc <.text+0x49bc>
140005885:     	xorl	%ecx, %ecx
140005887:     	xgetbv
14000588a:     	shlq	$0x20, %rdx
14000588e:     	orq	%rax, %rdx
140005891:     	movq	%rdx, 0x20(%rsp)
140005896:     	btl	$0x1c, %edi
14000589a:     	jae	0x1400059a0 <.text+0x49a0>
1400058a0:     	movq	0x20(%rsp), %rax
1400058a5:     	andb	$0x6, %al
1400058a7:     	cmpb	$0x6, %al
1400058a9:     	jne	0x1400059a0 <.text+0x49a0>
1400058af:     	movl	0x275f(%rip), %eax      # 0x140008014
1400058b5:     	movb	$-0x20, %dl
1400058b7:     	orl	$0x8, %eax
1400058ba:     	movl	$0x3, 0x274c(%rip)      # 0x140008010
1400058c4:     	movl	%eax, 0x274a(%rip)      # 0x140008014
1400058ca:     	testb	$0x20, %r10b
1400058ce:     	je	0x140005932 <.text+0x4932>
1400058d0:     	orl	$0x20, %eax
1400058d3:     	movl	$0x5, 0x2733(%rip)      # 0x140008010
1400058dd:     	movl	%eax, 0x2731(%rip)      # 0x140008014
1400058e3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1400058e8:     	movq	0x2739(%rip), %rax      # 0x140008028
1400058ef:     	andl	%ecx, %r10d
1400058f2:     	andq	$-0x3, %rax
1400058f6:     	movq	%rax, 0x272b(%rip)      # 0x140008028
1400058fd:     	cmpl	%ecx, %r10d
140005900:     	jne	0x140005939 <.text+0x4939>
140005902:     	movq	0x20(%rsp), %rax
140005907:     	andb	%dl, %al
140005909:     	cmpb	%dl, %al
14000590b:     	jne	0x140005932 <.text+0x4932>
14000590d:     	movq	0x2714(%rip), %rax      # 0x140008028
140005914:     	orl	$0x40, 0x26f9(%rip)     # 0x140008014
14000591b:     	andq	$-0x25, %rax
14000591f:     	movl	$0x6, 0x26e7(%rip)      # 0x140008010
140005929:     	movq	%rax, 0x26f8(%rip)      # 0x140008028
140005930:     	jmp	0x140005939 <.text+0x4939>
140005932:     	movq	0x26ef(%rip), %rax      # 0x140008028
140005939:     	btl	$0x17, %esi
14000593d:     	jae	0x14000594b <.text+0x494b>
14000593f:     	btrq	$0x18, %rax
140005944:     	movq	%rax, 0x26dd(%rip)      # 0x140008028
14000594b:     	btl	$0x13, %r9d
140005950:     	jae	0x1400059a0 <.text+0x49a0>
140005952:     	movq	0x20(%rsp), %rax
140005957:     	andb	%dl, %al
140005959:     	cmpb	%dl, %al
14000595b:     	jne	0x1400059a0 <.text+0x49a0>
14000595d:     	movq	0x26c4(%rip), %rdx      # 0x140008028
140005964:     	movl	%r11d, %eax
140005967:     	shrq	$0x10, %rax
14000596b:     	movl	%r11d, %ecx
14000596e:     	andl	$0x6, %eax
140005971:     	andl	$0x400ff, %ecx          # imm = 0x400FF
140005977:     	orq	$0x1000029, %rax        # imm = 0x1000029
14000597d:     	movl	%ecx, 0x279d(%rip)      # 0x140008120
140005983:     	notq	%rax
140005986:     	andq	%rax, %rdx
140005989:     	movq	%rdx, 0x2698(%rip)      # 0x140008028
140005990:     	cmpb	$0x1, %cl
140005993:     	jbe	0x1400059a0 <.text+0x49a0>
140005995:     	andq	$-0x41, %rdx
140005999:     	movq	%rdx, 0x2688(%rip)      # 0x140008028
1400059a0:     	btl	$0x15, %r9d
1400059a5:     	jae	0x1400059bc <.text+0x49bc>
1400059a7:     	movq	0x20(%rsp), %rax
1400059ac:     	btq	$0x13, %rax
1400059b1:     	jae	0x1400059bc <.text+0x49bc>
1400059b3:     	btrq	$0x7, 0x266c(%rip)      # 0x140008028
1400059bc:     	movq	0x28(%rsp), %rbx
1400059c1:     	xorl	%eax, %eax
1400059c3:     	movq	0x30(%rsp), %rbp
1400059c8:     	movq	0x38(%rsp), %rsi
1400059cd:     	addq	$0x10, %rsp
1400059d1:     	popq	%rdi
1400059d2:     	retq
1400059d3:     	int3
1400059d4:     	xorl	%eax, %eax
1400059d6:     	cmpl	%eax, 0x26b4(%rip)      # 0x140008090
1400059dc:     	setne	%al
1400059df:     	retq
1400059e0:     	jmpq	*0x6ea(%rip)            # 0x1400060d0
1400059e6:     	jmpq	*0x724(%rip)            # 0x140006110
1400059ec:     	jmpq	*0x6ce(%rip)            # 0x1400060c0
1400059f2:     	jmpq	*0x6e8(%rip)            # 0x1400060e0
1400059f8:     	jmpq	*0x6ea(%rip)            # 0x1400060e8
1400059fe:     	jmpq	*0x6ec(%rip)            # 0x1400060f0
140005a04:     	jmpq	*0x6ee(%rip)            # 0x1400060f8
140005a0a:     	jmpq	*0x6f0(%rip)            # 0x140006100
140005a10:     	jmpq	*0x6f2(%rip)            # 0x140006108
140005a16:     	jmpq	*0x74c(%rip)            # 0x140006168
140005a1c:     	jmpq	*0x71e(%rip)            # 0x140006140
140005a22:     	jmpq	*0x6f0(%rip)            # 0x140006118
140005a28:     	jmpq	*0x6f2(%rip)            # 0x140006120
140005a2e:     	jmpq	*0x6f4(%rip)            # 0x140006128
140005a34:     	jmpq	*0x6f6(%rip)            # 0x140006130
140005a3a:     	jmpq	*0x660(%rip)            # 0x1400060a0
140005a40:     	jmpq	*0x64a(%rip)            # 0x140006090
140005a46:     	jmpq	*0x73c(%rip)            # 0x140006188
140005a4c:     	jmpq	*0x6fe(%rip)            # 0x140006150
140005a52:     	jmpq	*0x700(%rip)            # 0x140006158
140005a58:     	jmpq	*0x6ea(%rip)            # 0x140006148
140005a5e:     	jmpq	*0x674(%rip)            # 0x1400060d8
140005a64:     	jmpq	*0x5e6(%rip)            # 0x140006050
140005a6a:     	jmpq	*0x5d0(%rip)            # 0x140006040
140005a70:     	jmpq	*0x5d2(%rip)            # 0x140006048
140005a76:     	int3
140005a77:     	int3
140005a78:     	int3
140005a79:     	int3
140005a7a:     	int3
140005a7b:     	int3
140005a7c:     	int3
140005a7d:     	int3
140005a7e:     	int3
140005a7f:     	int3
140005a80:     	int3
140005a81:     	int3
140005a82:     	int3
140005a83:     	int3
140005a84:     	int3
140005a85:     	int3
140005a86:     	nopw	(%rax,%rax)
140005a90:     	jmpq	*%rax
140005a92:     	int3
140005a93:     	int3
140005a94:     	int3
140005a95:     	int3
140005a96:     	int3
140005a97:     	int3
140005a98:     	int3
140005a99:     	int3
140005a9a:     	int3
140005a9b:     	int3
140005a9c:     	int3
140005a9d:     	int3
140005a9e:     	int3
140005a9f:     	int3
140005aa0:     	int3
140005aa1:     	int3
140005aa2:     	int3
140005aa3:     	int3
140005aa4:     	int3
140005aa5:     	int3
140005aa6:     	nopw	(%rax,%rax)
140005ab0:     	jmpq	*0x702(%rip)            # 0x1400061b8
140005ab6:     	pushq	%rbp
140005ab8:     	subq	$0x20, %rsp
140005abc:     	movq	%rdx, %rbp
140005abf:     	movq	%rcx, %rdx
140005ac2:     	movq	(%rcx), %rcx
140005ac5:     	movl	(%rcx), %ecx
140005ac7:     	callq	0x1400059e0 <.text+0x49e0>
140005acc:     	nop
140005acd:     	addq	$0x20, %rsp
140005ad1:     	popq	%rbp
140005ad2:     	retq
140005ad3:     	int3
140005ad4:     	pushq	%rbp
140005ad6:     	movq	%rdx, %rbp
140005ad9:     	movq	(%rcx), %rax
140005adc:     	xorl	%ecx, %ecx
140005ade:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
140005ae4:     	sete	%cl
140005ae7:     	movl	%ecx, %eax
140005ae9:     	popq	%rbp
140005aea:     	retq
140005aeb:     	int3
