
D:\Code\Datathon\recompyler-codex-20261111\wave5-study\results\bin\raytrace.exe:	file format coff-x86-64

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
14000100c:     	subq	$0x6f8, %rsp            # imm = 0x6F8
140001013:     	vmovapd	%xmm15, 0x6e0(%rsp)
14000101c:     	vmovapd	%xmm14, 0x6d0(%rsp)
140001025:     	vmovapd	%xmm13, 0x6c0(%rsp)
14000102e:     	vmovapd	%xmm12, 0x6b0(%rsp)
140001037:     	vmovapd	%xmm11, 0x6a0(%rsp)
140001040:     	vmovapd	%xmm10, 0x690(%rsp)
140001049:     	vmovapd	%xmm9, 0x680(%rsp)
140001052:     	vmovapd	%xmm8, 0x670(%rsp)
14000105b:     	vmovapd	%xmm7, 0x660(%rsp)
140001064:     	vmovaps	%xmm6, 0x650(%rsp)
14000106d:     	cmpl	$0x1, %ecx
140001070:     	jle	0x1400010a1 <.text+0xa1>
140001072:     	movq	0x8(%rdx), %rcx
140001076:     	callq	*0x2fec(%rip)           # 0x140004068
14000107c:     	movl	$0x7530, %ecx           # imm = 0x7530
140001081:     	movl	%eax, %edi
140001083:     	callq	*0x2fef(%rip)           # 0x140004078
140001089:     	movq	%rax, %rsi
14000108c:     	movl	%edi, 0x20(%rsp)
140001090:     	testl	%edi, %edi
140001092:     	jg	0x1400010b7 <.text+0xb7>
140001094:     	vmovsd	0x31a4(%rip), %xmm6     # 0x140004240
14000109c:     	jmp	0x140001ad2 <.text+0xad2>
1400010a1:     	movl	$0x7530, %ecx           # imm = 0x7530
1400010a6:     	callq	*0x2fcc(%rip)           # 0x140004078
1400010ac:     	movq	%rax, %rsi
1400010af:     	movl	$0xa, 0x20(%rsp)
1400010b7:     	vmovddup	0x3521(%rip), %xmm0     # xmm0 = mem[0,0]
                                                # 0x1400045e0
1400010bf:     	vmovddup	0x3639(%rip), %xmm1     # xmm1 = mem[0,0]
                                                # 0x140004700
1400010c7:     	vmovsd	0x3171(%rip), %xmm6     # 0x140004240
1400010cf:     	vmovsd	0x3509(%rip), %xmm7     # 0x1400045e0
1400010d7:     	movq	0x30aa(%rip), %rdi      # 0x140004188
1400010de:     	leaq	0x7406(%rsi), %rax
1400010e5:     	leaq	0x110(%rsp), %rbx
1400010ed:     	leaq	0xa8(%rsp), %r14
1400010f5:     	leaq	0xe0(%rsp), %r15
1400010fd:     	movl	$0xff, %r13d
140001103:     	movq	%rsi, 0x30(%rsp)
140001108:     	movq	%rax, 0x28(%rsp)
14000110d:     	xorl	%eax, %eax
14000110f:     	vmovapd	%xmm0, 0xd0(%rsp)
140001118:     	vmovapd	%xmm1, 0xc0(%rsp)
140001121:     	nopw	%cs:(%rax,%rax)
140001130:     	movl	$0x1, %edx
140001135:     	movq	%rbx, %rcx
140001138:     	movq	%rax, 0x40(%rsp)
14000113d:     	vmovsd	%xmm6, 0x48(%rsp)
140001143:     	callq	*%rdi
140001145:     	vmovdqa64	0x3171(%rip), %zmm0 # 0x1400042c0
14000114f:     	vmovdqa64	0x3127(%rip), %zmm1 # 0x140004280
140001159:     	vbroadcasti32x4	0x365d(%rip), %zmm5 # zmm5 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x1400047c0
140001163:     	vbroadcasti32x4	0x3663(%rip), %zmm16 # zmm16 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x1400047d0
14000116d:     	vbroadcasti32x4	0x3669(%rip), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x1400047e0
140001177:     	vbroadcasti32x4	0x366f(%rip), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x1400047f0
140001181:     	vbroadcasti32x4	0x3675(%rip), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x140004800
14000118b:     	vbroadcasti32x4	0x367b(%rip), %zmm20 # zmm20 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x140004810
140001195:     	vbroadcasti32x4	0x3681(%rip), %zmm21 # zmm21 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x140004820
14000119f:     	vbroadcasti32x4	0x3687(%rip), %zmm22 # zmm22 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x140004830
1400011a9:     	vbroadcasti32x4	0x368d(%rip), %zmm23 # zmm23 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
                                                # 0x140004840
1400011b3:     	movq	0x110(%rsp), %rax
1400011bb:     	movl	0x118(%rsp), %ecx
1400011c2:     	movq	%rax, 0x38(%rsp)
1400011c7:     	movl	$0x140, %eax            # imm = 0x140
1400011cc:     	movl	%ecx, 0x24(%rsp)
1400011d0:     	vpsubw	%zmm5, %zmm0, %zmm2
1400011d6:     	vpsubw	%zmm5, %zmm1, %zmm3
1400011dc:     	vpmullw	%zmm16, %zmm1, %zmm26
1400011e2:     	vpmullw	%zmm16, %zmm0, %zmm27
1400011e8:     	vpaddw	%zmm23, %zmm0, %zmm0
1400011ee:     	vpaddw	%zmm23, %zmm1, %zmm1
1400011f4:     	vpmullw	%zmm16, %zmm2, %zmm2
1400011fa:     	vpaddw	%zmm18, %zmm26, %zmm4
140001200:     	vpaddw	%zmm19, %zmm27, %zmm25
140001206:     	vpaddw	%zmm19, %zmm26, %zmm24
14000120c:     	vpcmpleuw	%zmm17, %zmm2, %k0
140001213:     	vpmullw	%zmm16, %zmm3, %zmm2
140001219:     	vpaddw	%zmm18, %zmm27, %zmm3
14000121f:     	vpcmpleuw	%zmm17, %zmm2, %k1
140001226:     	kunpckdq	%k0, %k1, %k0
14000122b:     	vpcmpleuw	%zmm17, %zmm4, %k1
140001232:     	vpmovm2b	%k0, %zmm2
140001238:     	vpcmpleuw	%zmm17, %zmm3, %k0
14000123f:     	vmovdqu64	%zmm2, -0x140(%rsi,%rax)
140001247:     	vpaddw	%zmm22, %zmm27, %zmm2
14000124d:     	vpaddw	%zmm22, %zmm26, %zmm3
140001253:     	kunpckdq	%k0, %k1, %k0
140001258:     	vpcmpleuw	%zmm17, %zmm24, %k1
14000125f:     	vpaddw	%zmm20, %zmm26, %zmm24
140001265:     	vpmovm2b	%k0, %zmm4
14000126b:     	vpcmpleuw	%zmm17, %zmm25, %k0
140001272:     	vpaddw	%zmm20, %zmm27, %zmm25
140001278:     	vmovdqu64	%zmm4, -0x100(%rsi,%rax)
140001280:     	kunpckdq	%k0, %k1, %k0
140001285:     	vpcmpleuw	%zmm17, %zmm24, %k1
14000128c:     	vpaddw	%zmm21, %zmm26, %zmm24
140001292:     	vpmovm2b	%k0, %zmm4
140001298:     	vpcmpleuw	%zmm17, %zmm25, %k0
14000129f:     	vpaddw	%zmm21, %zmm27, %zmm25
1400012a5:     	vmovdqu64	%zmm4, -0xc0(%rsi,%rax)
1400012ad:     	kunpckdq	%k0, %k1, %k0
1400012b2:     	vpcmpleuw	%zmm17, %zmm24, %k1
1400012b9:     	vpmovm2b	%k0, %zmm4
1400012bf:     	vpcmpleuw	%zmm17, %zmm25, %k0
1400012c6:     	vmovdqu64	%zmm4, -0x80(%rsi,%rax)
1400012ce:     	kunpckdq	%k0, %k1, %k0
1400012d3:     	vpcmpleuw	%zmm17, %zmm3, %k1
1400012da:     	vpmovm2b	%k0, %zmm4
1400012e0:     	vpcmpleuw	%zmm17, %zmm2, %k0
1400012e7:     	vmovdqu64	%zmm4, -0x40(%rsi,%rax)
1400012ef:     	kunpckdq	%k0, %k1, %k0
1400012f4:     	vpmovm2b	%k0, %zmm2
1400012fa:     	vmovdqu64	%zmm2, (%rsi,%rax)
140001301:     	addq	$0x180, %rax            # imm = 0x180
140001307:     	cmpq	$0x7640, %rax           # imm = 0x7640
14000130d:     	jne	0x1400011d0 <.text+0x1d0>
140001313:     	vmovaps	0x3225(%rip), %xmm0     # 0x140004540
14000131b:     	vmovaps	0x322d(%rip), %xmm2     # 0x140004550
140001323:     	vmovaps	0x3235(%rip), %xmm1     # 0x140004560
14000132b:     	movabsq	$0x4046800000000000, %rax # imm = 0x4046800000000000
140001335:     	vmovaps	0x32c3(%rip), %ymm3     # 0x140004600
14000133d:     	vmovaps	0x32db(%rip), %ymm4     # 0x140004620
140001345:     	vmovaps	0x32f1(%rip), %xmm17    # 0x140004640
14000134f:     	vmovaps	0x3307(%rip), %ymm16    # 0x140004660
140001359:     	vmovaps	0x331f(%rip), %xmm5     # 0x140004680
140001361:     	vmovaps	0x3335(%rip), %ymm18    # 0x1400046a0
14000136b:     	vmovups	%xmm0, 0x7500(%rsi)
140001373:     	vmovups	%xmm2, 0x7510(%rsi)
14000137b:     	vmovups	%xmm1, 0x7520(%rsi)
140001383:     	leaq	0x610(%rsp), %rsi
14000138b:     	vxorps	%xmm1, %xmm1, %xmm0
14000138f:     	vmovaps	0x3229(%rip), %ymm1     # 0x1400045c0
140001397:     	vmovaps	0xd0(%rsp), %xmm2
1400013a0:     	vmovups	%zmm0, (%rsi)
1400013a6:     	vmovups	%zmm0, -0x30(%rsi)
1400013b0:     	vmovups	%zmm0, -0x70(%rsi)
1400013ba:     	vmovups	%zmm0, -0xb0(%rsi)
1400013c4:     	vmovups	%zmm0, -0xf0(%rsi)
1400013ce:     	vmovups	%zmm0, -0x130(%rsi)
1400013d8:     	vmovups	%zmm0, -0x170(%rsi)
1400013e2:     	vmovups	%zmm0, -0x1b0(%rsi)
1400013ec:     	vmovups	%zmm0, -0x1f0(%rsi)
1400013f6:     	vmovaps	0x3172(%rip), %xmm0     # 0x140004570
1400013fe:     	vmovups	%xmm0, 0x618(%rsp)
140001407:     	vmovaps	0x3171(%rip), %ymm0     # 0x140004580
14000140f:     	movq	%rax, 0x640(%rsp)
140001417:     	movl	$0x2, 0x608(%rsp)
140001422:     	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
14000142c:     	vmovups	%ymm0, 0x5d8(%rsp)
140001435:     	vmovaps	0x3163(%rip), %xmm0     # 0x1400045a0
14000143d:     	vmovups	%xmm0, 0x5f8(%rsp)
140001446:     	movq	%rax, 0x630(%rsp)
14000144e:     	vxorps	%xmm0, %xmm0, %xmm0
140001452:     	vmovups	%xmm0, -0x4a0(%rsi)
14000145a:     	movq	$0x0, -0x490(%rsi)
140001465:     	movq	$0x0, 0x110(%rsp)
140001471:     	vmovups	%ymm1, 0x118(%rsp)
14000147a:     	vxorps	%xmm1, %xmm1, %xmm1
14000147e:     	vmovups	%ymm1, -0x4d8(%rsi)
140001486:     	vmovups	%xmm2, 0x158(%rsp)
14000148f:     	movq	$0x0, 0x168(%rsp)
14000149b:     	vmovups	%ymm3, 0x188(%rsp)
1400014a4:     	movq	$0x0, 0x1a8(%rsp)
1400014b0:     	vmovups	%ymm4, 0x1b0(%rsp)
1400014b9:     	vmovups	%ymm1, -0x440(%rsi)
1400014c1:     	movq	$0x0, -0x420(%rsi)
1400014cc:     	vmovups	%xmm17, 0x1f8(%rsp)
1400014d7:     	vmovups	%xmm0, -0x408(%rsi)
1400014df:     	movq	$0x0, -0x3f8(%rsi)
1400014ea:     	vmovups	%ymm3, 0x220(%rsp)
1400014f3:     	movq	$0x0, 0x240(%rsp)
1400014ff:     	vmovups	%ymm16, 0x248(%rsp)
14000150a:     	vmovups	%ymm1, -0x3a8(%rsi)
140001512:     	vmovups	%xmm5, 0x288(%rsp)
14000151b:     	vmovaps	0x319b(%rip), %xmm17    # 0x1400046c0
140001525:     	vmovaps	0x31b1(%rip), %ymm16    # 0x1400046e0
14000152f:     	vmovaps	0xc0(%rsp), %xmm5
140001538:     	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
140001542:     	movq	%rax, 0x298(%rsp)
14000154a:     	vmovups	%xmm0, -0x370(%rsi)
140001552:     	movq	$0x0, -0x360(%rsi)
14000155d:     	vmovups	%ymm3, 0x2b8(%rsp)
140001566:     	movq	$0x0, 0x2d8(%rsp)
140001572:     	vmovups	%ymm18, 0x2e0(%rsp)
14000157a:     	vmovups	%ymm1, -0x310(%rsi)
140001582:     	vmovdqa64	0x3194(%rip), %ymm18 # 0x140004720
14000158c:     	vmovups	%xmm17, 0x320(%rsp)
140001594:     	movq	%rax, 0x330(%rsp)
14000159c:     	vmovups	%xmm0, -0x2d8(%rsi)
1400015a4:     	movq	$0x0, -0x2c8(%rsi)
1400015af:     	vmovups	%ymm3, 0x350(%rsp)
1400015b8:     	movq	$0x0, 0x370(%rsp)
1400015c4:     	vmovups	%ymm16, 0x378(%rsp)
1400015cf:     	vmovups	%ymm1, -0x278(%rsi)
1400015d7:     	vmovups	%xmm5, 0x3b8(%rsp)
1400015e0:     	vmovdqa64	0x3156(%rip), %xmm17 # 0x140004740
1400015ea:     	vmovdqa64	0x316c(%rip), %ymm16 # 0x140004760
1400015f4:     	vmovaps	0x3184(%rip), %xmm5     # 0x140004780
1400015fc:     	movq	%rax, 0x3c8(%rsp)
140001604:     	vmovups	%xmm0, -0x240(%rsi)
14000160c:     	movq	$0x0, -0x230(%rsi)
140001617:     	vmovups	%ymm3, 0x3e8(%rsp)
140001620:     	movq	$0x0, 0x408(%rsp)
14000162c:     	vmovdqu64	%ymm18, 0x410(%rsp)
140001637:     	vmovups	%ymm1, -0x1e0(%rsi)
14000163f:     	vmovdqu64	%xmm17, 0x450(%rsp)
140001647:     	movq	%rax, 0x460(%rsp)
14000164f:     	vmovups	%xmm0, -0x1a8(%rsi)
140001657:     	movq	$0x0, -0x198(%rsi)
140001662:     	vmovups	%ymm3, 0x480(%rsp)
14000166b:     	movq	$0x0, 0x4a0(%rsp)
140001677:     	vmovdqu64	%ymm16, 0x4a8(%rsp)
140001682:     	vmovups	%ymm1, -0x148(%rsi)
14000168a:     	vmovups	%xmm5, 0x4e8(%rsp)
140001693:     	movq	%rax, 0x4f8(%rsp)
14000169b:     	vmovups	%xmm0, -0x110(%rsi)
1400016a3:     	movq	$0x0, -0x100(%rsi)
1400016ae:     	vmovups	%ymm3, 0x518(%rsp)
1400016b7:     	vmovups	%xmm0, -0x78(%rsi)
1400016bc:     	vmovsd	0x2f1c(%rip), %xmm0     # 0x1400045e0
1400016c4:     	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
1400016ce:     	movq	$0x0, -0x68(%rsi)
1400016d6:     	movl	$0x8, 0x5d0(%rsp)
1400016e1:     	movl	$0x1, 0x538(%rsp)
1400016ec:     	vmovups	%ymm1, -0xc8(%rsi)
1400016f4:     	vmovups	%ymm1, -0xd4(%rsi)
1400016fc:     	vmovups	%xmm0, 0x568(%rsp)
140001705:     	movq	$0x1, 0x578(%rsp)
140001711:     	vmovups	%xmm2, 0x580(%rsp)
14000171a:     	movq	%rax, 0x590(%rsp)
140001722:     	vmovups	%ymm3, 0x5b0(%rsp)
14000172b:     	vmovsd	0x2fcd(%rip), %xmm0     # 0x140004700
140001733:     	vmulsd	0x640(%rsp), %xmm0, %xmm0
14000173c:     	vmulsd	0x304c(%rip), %xmm0, %xmm0 # 0x140004790
140001744:     	vdivsd	0x304c(%rip), %xmm0, %xmm0 # 0x140004798
14000174c:     	vzeroupper
14000174f:     	callq	0x140002a70 <.text+0x1a70>
140001754:     	vmulsd	0x3044(%rip), %xmm0, %xmm1 # 0x1400047a0
14000175c:     	vmovsd	0x3044(%rip), %xmm2     # 0x1400047a8
140001764:     	vmovapd	%xmm0, %xmm14
140001768:     	vaddsd	%xmm0, %xmm0, %xmm0
14000176c:     	vmovups	(%rsi), %xmm3
140001770:     	movq	0x10(%rsi), %rax
140001774:     	movq	0x28(%rsp), %r12
140001779:     	xorl	%ebp, %ebp
14000177b:     	movq	%rax, 0xa0(%rsp)
140001783:     	vdivsd	%xmm2, %xmm0, %xmm6
140001787:     	vmovaps	%xmm3, 0x90(%rsp)
140001790:     	vmovsd	%xmm1, 0x70(%rsp)
140001796:     	vaddsd	%xmm1, %xmm1, %xmm1
14000179a:     	vdivsd	%xmm2, %xmm1, %xmm0
14000179e:     	vmovsd	0x630(%rsp), %xmm1
1400017a7:     	vmovsd	0x638(%rsp), %xmm2
1400017b0:     	vsubsd	0x618(%rsp), %xmm1, %xmm1
1400017b9:     	vsubsd	0x620(%rsp), %xmm2, %xmm2
1400017c2:     	vmulsd	%xmm1, %xmm1, %xmm4
1400017c6:     	vmovsd	%xmm0, 0x68(%rsp)
1400017cc:     	vmovsd	0x628(%rsp), %xmm0
1400017d5:     	vsubsd	0x610(%rsp), %xmm0, %xmm0
1400017de:     	vmulsd	%xmm0, %xmm0, %xmm3
1400017e2:     	vaddsd	%xmm4, %xmm3, %xmm3
1400017e6:     	vmulsd	%xmm2, %xmm2, %xmm4
1400017ea:     	vaddsd	%xmm4, %xmm3, %xmm3
1400017ee:     	vsqrtsd	%xmm3, %xmm3, %xmm3
1400017f2:     	vdivsd	%xmm3, %xmm7, %xmm3
1400017f6:     	vmulsd	%xmm3, %xmm2, %xmm13
1400017fa:     	vmulsd	%xmm3, %xmm1, %xmm12
1400017fe:     	vmulsd	%xmm3, %xmm0, %xmm10
140001802:     	vxorpd	%xmm3, %xmm3, %xmm3
140001806:     	vmulsd	%xmm3, %xmm12, %xmm0
14000180a:     	vmulsd	%xmm3, %xmm13, %xmm2
14000180e:     	vmulsd	%xmm3, %xmm10, %xmm3
140001812:     	vsubsd	%xmm0, %xmm10, %xmm1
140001816:     	vsubsd	%xmm3, %xmm2, %xmm2
14000181a:     	vsubsd	%xmm13, %xmm0, %xmm0
14000181f:     	vmulsd	%xmm0, %xmm0, %xmm3
140001823:     	vmulsd	%xmm2, %xmm2, %xmm4
140001827:     	vaddsd	%xmm4, %xmm3, %xmm3
14000182b:     	vmulsd	%xmm1, %xmm1, %xmm4
14000182f:     	vaddsd	%xmm3, %xmm4, %xmm3
140001833:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140001837:     	vdivsd	%xmm3, %xmm7, %xmm3
14000183b:     	vmulsd	%xmm3, %xmm0, %xmm22
140001841:     	vmulsd	%xmm3, %xmm2, %xmm11
140001845:     	vmulsd	%xmm3, %xmm1, %xmm8
140001849:     	vmulsd	%xmm22, %xmm12, %xmm0
14000184f:     	vmulsd	%xmm11, %xmm10, %xmm1
140001854:     	vmulsd	%xmm22, %xmm13, %xmm2
14000185a:     	vmulsd	%xmm8, %xmm12, %xmm3
14000185f:     	vsubsd	%xmm1, %xmm0, %xmm0
140001863:     	vmulsd	%xmm8, %xmm10, %xmm1
140001868:     	vsubsd	%xmm2, %xmm1, %xmm1
14000186c:     	vmulsd	%xmm11, %xmm13, %xmm2
140001871:     	vsubsd	%xmm3, %xmm2, %xmm2
140001875:     	vmulsd	%xmm1, %xmm1, %xmm4
140001879:     	vmulsd	%xmm2, %xmm2, %xmm3
14000187d:     	vaddsd	%xmm4, %xmm3, %xmm3
140001881:     	vmulsd	%xmm0, %xmm0, %xmm4
140001885:     	vaddsd	%xmm3, %xmm4, %xmm3
140001889:     	vsqrtsd	%xmm3, %xmm3, %xmm3
14000188d:     	vdivsd	%xmm3, %xmm7, %xmm3
140001891:     	vmulsd	%xmm3, %xmm1, %xmm4
140001895:     	vmulsd	%xmm3, %xmm0, %xmm0
140001899:     	vmulsd	%xmm3, %xmm2, %xmm1
14000189d:     	vmovsd	%xmm0, 0x60(%rsp)
1400018a3:     	vmovsd	%xmm4, 0x58(%rsp)
1400018a9:     	vmovsd	%xmm1, 0x50(%rsp)
1400018af:     	nop
1400018b0:     	vcvtsi2sd	%ebp, %xmm31, %xmm0
1400018b6:     	vmulsd	0x68(%rsp), %xmm0, %xmm0
1400018bc:     	vmovsd	0x2d1c(%rip), %xmm15    # 0x1400045e0
1400018c4:     	vmovsd	0x2ee4(%rip), %xmm9     # 0x1400047b0
1400018cc:     	movq	%r12, %rdi
1400018cf:     	xorl	%esi, %esi
1400018d1:     	vsubsd	0x70(%rsp), %xmm0, %xmm0
1400018d7:     	vmulsd	0x60(%rsp), %xmm0, %xmm1
1400018dd:     	vmulsd	0x58(%rsp), %xmm0, %xmm2
1400018e3:     	vmulsd	0x50(%rsp), %xmm0, %xmm0
1400018e9:     	vmovsd	%xmm1, 0x88(%rsp)
1400018f2:     	vmovsd	%xmm2, 0x80(%rsp)
1400018fb:     	vmovsd	%xmm0, 0x78(%rsp)
140001901:     	nopw	%cs:(%rax,%rax)
140001910:     	vcvtsi2sd	%esi, %xmm31, %xmm0
140001916:     	vmovaps	0x90(%rsp), %xmm3
14000191f:     	movq	0xa0(%rsp), %rax
140001927:     	movq	%r14, %rcx
14000192a:     	movq	%rbx, %rdx
14000192d:     	movq	%r15, %r8
140001930:     	vmovapd	%xmm22, %xmm7
140001936:     	vmulsd	%xmm0, %xmm6, %xmm0
14000193a:     	movq	%rax, 0xf0(%rsp)
140001942:     	vsubsd	%xmm14, %xmm0, %xmm0
140001947:     	vmovaps	%xmm3, 0xe0(%rsp)
140001950:     	vmulsd	%xmm0, %xmm8, %xmm1
140001954:     	vmulsd	%xmm0, %xmm11, %xmm2
140001958:     	vmulsd	%xmm0, %xmm22, %xmm0
14000195e:     	vaddsd	%xmm2, %xmm12, %xmm2
140001962:     	vaddsd	%xmm0, %xmm10, %xmm0
140001966:     	vaddsd	0x80(%rsp), %xmm2, %xmm2
14000196f:     	vaddsd	0x78(%rsp), %xmm0, %xmm0
140001975:     	vaddsd	%xmm1, %xmm13, %xmm1
140001979:     	vaddsd	0x88(%rsp), %xmm1, %xmm1
140001982:     	vmulsd	%xmm0, %xmm0, %xmm3
140001986:     	vmulsd	%xmm2, %xmm2, %xmm4
14000198a:     	vmulsd	%xmm1, %xmm1, %xmm5
14000198e:     	vaddsd	%xmm4, %xmm3, %xmm3
140001992:     	vaddsd	%xmm3, %xmm5, %xmm3
140001996:     	vsqrtsd	%xmm3, %xmm3, %xmm3
14000199a:     	vdivsd	%xmm3, %xmm15, %xmm3
14000199e:     	vmulsd	%xmm3, %xmm0, %xmm0
1400019a2:     	vmulsd	%xmm3, %xmm1, %xmm1
1400019a6:     	vmulsd	%xmm3, %xmm2, %xmm2
1400019aa:     	vmovsd	%xmm0, 0xf8(%rsp)
1400019b3:     	vmovsd	%xmm2, 0x100(%rsp)
1400019bc:     	vmovsd	%xmm1, 0x108(%rsp)
1400019c5:     	callq	0x140001f50 <.text+0xf50>
1400019ca:     	vmulsd	0xa8(%rsp), %xmm9, %xmm0
1400019d3:     	vmulsd	0xb0(%rsp), %xmm9, %xmm2
1400019dc:     	vmulsd	0xb8(%rsp), %xmm9, %xmm1
1400019e5:     	vmovapd	%xmm7, %xmm22
1400019eb:     	vcvttsd2si	%xmm0, %eax
1400019ef:     	movl	%eax, %ecx
1400019f1:     	sarl	$0x1f, %ecx
1400019f4:     	andnl	%eax, %ecx, %eax
1400019f9:     	cmpl	$0xff, %eax
1400019fe:     	cmovgel	%r13d, %eax
140001a02:     	movb	%al, -0x2(%rdi)
140001a05:     	vcvttsd2si	%xmm2, %eax
140001a09:     	movl	%eax, %ecx
140001a0b:     	sarl	$0x1f, %ecx
140001a0e:     	andnl	%eax, %ecx, %eax
140001a13:     	cmpl	$0xff, %eax
140001a18:     	cmovgel	%r13d, %eax
140001a1c:     	movb	%al, -0x1(%rdi)
140001a1f:     	vcvttsd2si	%xmm1, %eax
140001a23:     	movl	%eax, %ecx
140001a25:     	sarl	$0x1f, %ecx
140001a28:     	andnl	%eax, %ecx, %eax
140001a2d:     	cmpl	$0xff, %eax
140001a32:     	cmovgel	%r13d, %eax
140001a36:     	incq	%rsi
140001a39:     	movb	%al, (%rdi)
140001a3b:     	addq	$0x3, %rdi
140001a3f:     	cmpq	$0x64, %rsi
140001a43:     	jne	0x140001910 <.text+0x910>
140001a49:     	incq	%rbp
140001a4c:     	addq	$-0x12c, %r12           # imm = 0xFED4
140001a53:     	cmpq	$0x64, %rbp
140001a57:     	jne	0x1400018b0 <.text+0x8b0>
140001a5d:     	vcvtsi2sdq	0x38(%rsp), %xmm31, %xmm0
140001a65:     	vmovsd	0x2d4b(%rip), %xmm7     # 0x1400047b8
140001a6d:     	movq	0x2714(%rip), %rdi      # 0x140004188
140001a74:     	movl	$0x1, %edx
140001a79:     	movq	%rbx, %rcx
140001a7c:     	vcvtsi2sdl	0x24(%rsp), %xmm31, %xmm1
140001a84:     	vmulsd	%xmm7, %xmm1, %xmm1
140001a88:     	vaddsd	%xmm0, %xmm1, %xmm6
140001a8c:     	callq	*%rdi
140001a8e:     	vcvtsi2sdq	0x110(%rsp), %xmm31, %xmm0
140001a96:     	movq	0x40(%rsp), %rax
140001a9b:     	movq	0x30(%rsp), %rsi
140001aa0:     	vcvtsi2sdl	0x118(%rsp), %xmm31, %xmm1
140001aa8:     	incl	%eax
140001aaa:     	vmulsd	%xmm7, %xmm1, %xmm1
140001aae:     	vmovsd	0x2b2a(%rip), %xmm7     # 0x1400045e0
140001ab6:     	vaddsd	%xmm0, %xmm1, %xmm0
140001aba:     	vsubsd	%xmm6, %xmm0, %xmm0
140001abe:     	vmovsd	0x48(%rsp), %xmm6
140001ac4:     	vminsd	%xmm6, %xmm0, %xmm6
140001ac8:     	cmpl	0x20(%rsp), %eax
140001acc:     	jne	0x140001130 <.text+0x130>
140001ad2:     	movl	$0xf8, %eax
140001ad7:     	vxorpd	%xmm0, %xmm0, %xmm0
140001adb:     	vxorpd	%xmm1, %xmm1, %xmm1
140001adf:     	vxorpd	%xmm2, %xmm2, %xmm2
140001ae3:     	vxorpd	%xmm3, %xmm3, %xmm3
140001ae7:     	nopw	(%rax,%rax)
140001af0:     	vpmovzxbq	-0xf0(%rsi,%rax), %zmm5
140001af8:     	vpmovzxbq	-0xf8(%rsi,%rax), %zmm4
140001b00:     	vpmovzxbq	-0xe8(%rsi,%rax), %zmm16
140001b08:     	vpaddq	%zmm5, %zmm1, %zmm1
140001b0e:     	vpmovzxbq	-0xe0(%rsi,%rax), %zmm5
140001b16:     	vpaddq	%zmm4, %zmm0, %zmm0
140001b1c:     	vpaddq	%zmm16, %zmm2, %zmm2
140001b22:     	vpaddq	%zmm5, %zmm3, %zmm3
140001b28:     	cmpq	$0x75f8, %rax           # imm = 0x75F8
140001b2e:     	je	0x140001cc6 <.text+0xcc6>
140001b34:     	vpmovzxbq	-0xd8(%rsi,%rax), %zmm4
140001b3c:     	vpmovzxbq	-0xb8(%rsi,%rax), %zmm18
140001b44:     	vpmovzxbq	-0xc8(%rsi,%rax), %zmm16
140001b4c:     	vpmovzxbq	-0xa8(%rsi,%rax), %zmm19
140001b54:     	vpmovzxbq	-0xd0(%rsi,%rax), %zmm5
140001b5c:     	vpmovzxbq	-0xb0(%rsi,%rax), %zmm20
140001b64:     	vpmovzxbq	-0xc0(%rsi,%rax), %zmm17
140001b6c:     	vpaddq	%zmm18, %zmm4, %zmm4
140001b72:     	vpaddq	%zmm19, %zmm16, %zmm16
140001b78:     	vpmovzxbq	-0x78(%rsi,%rax), %zmm19
140001b80:     	vpaddq	%zmm20, %zmm5, %zmm5
140001b86:     	vpmovzxbq	-0xa0(%rsi,%rax), %zmm20
140001b8e:     	vpmovzxbq	-0x48(%rsi,%rax), %zmm18
140001b96:     	vpaddq	%zmm4, %zmm0, %zmm0
140001b9c:     	vpmovzxbq	-0x98(%rsi,%rax), %zmm4
140001ba4:     	vpaddq	%zmm16, %zmm2, %zmm2
140001baa:     	vpmovzxbq	-0x88(%rsi,%rax), %zmm16
140001bb2:     	vpaddq	%zmm5, %zmm1, %zmm1
140001bb8:     	vpmovzxbq	-0x90(%rsi,%rax), %zmm5
140001bc0:     	vpaddq	%zmm20, %zmm17, %zmm17
140001bc6:     	vpmovzxbq	-0x70(%rsi,%rax), %zmm20
140001bce:     	vpaddq	%zmm19, %zmm4, %zmm4
140001bd4:     	vpmovzxbq	-0x68(%rsi,%rax), %zmm19
140001bdc:     	vpaddq	%zmm17, %zmm3, %zmm3
140001be2:     	vpmovzxbq	-0x80(%rsi,%rax), %zmm17
140001bea:     	vpaddq	%zmm20, %zmm5, %zmm5
140001bf0:     	vpmovzxbq	-0x60(%rsi,%rax), %zmm20
140001bf8:     	vpaddq	%zmm19, %zmm16, %zmm16
140001bfe:     	vpmovzxbq	-0x58(%rsi,%rax), %zmm19
140001c06:     	vpaddq	%zmm20, %zmm17, %zmm17
140001c0c:     	vpmovzxbq	-0x38(%rsi,%rax), %zmm20
140001c14:     	vpaddq	%zmm19, %zmm4, %zmm4
140001c1a:     	vpmovzxbq	-0x50(%rsi,%rax), %zmm19
140001c22:     	vpaddq	%zmm4, %zmm0, %zmm0
140001c28:     	vpaddq	%zmm19, %zmm5, %zmm4
140001c2e:     	vpmovzxbq	-0x40(%rsi,%rax), %zmm5
140001c36:     	vpmovzxbq	-0x10(%rsi,%rax), %zmm19
140001c3e:     	vpaddq	%zmm4, %zmm1, %zmm1
140001c44:     	vpaddq	%zmm18, %zmm16, %zmm4
140001c4a:     	vpmovzxbq	-0x18(%rsi,%rax), %zmm18
140001c52:     	vpmovzxbq	-0x28(%rsi,%rax), %zmm16
140001c5a:     	vpaddq	%zmm4, %zmm2, %zmm2
140001c60:     	vpaddq	%zmm5, %zmm17, %zmm4
140001c66:     	vpmovzxbq	-0x30(%rsi,%rax), %zmm5
140001c6e:     	vpmovzxbq	-0x20(%rsi,%rax), %zmm17
140001c76:     	vpaddq	%zmm4, %zmm3, %zmm3
140001c7c:     	vpaddq	%zmm18, %zmm20, %zmm4
140001c82:     	vpmovzxbq	-0x8(%rsi,%rax), %zmm18
140001c8a:     	vpaddq	%zmm4, %zmm0, %zmm0
140001c90:     	vpaddq	%zmm19, %zmm5, %zmm4
140001c96:     	vpmovzxbq	(%rsi,%rax), %zmm5
140001c9d:     	addq	$0x100, %rax            # imm = 0x100
140001ca3:     	vpaddq	%zmm4, %zmm1, %zmm1
140001ca9:     	vpaddq	%zmm18, %zmm16, %zmm4
140001caf:     	vpaddq	%zmm4, %zmm2, %zmm2
140001cb5:     	vpaddq	%zmm5, %zmm17, %zmm4
140001cbb:     	vpaddq	%zmm4, %zmm3, %zmm3
140001cc1:     	jmp	0x140001af0 <.text+0xaf0>
140001cc6:     	vpaddq	%zmm0, %zmm1, %zmm0
140001ccc:     	leaq	0x2b9d(%rip), %rcx      # 0x140004870
140001cd3:     	movabsq	$0x100000001b3, %rdi    # imm = 0x100000001B3
140001cdd:     	vpaddq	%zmm0, %zmm2, %zmm0
140001ce3:     	vpmovzxbq	0x7528(%rsi), %zmm2
140001ced:     	vpaddq	%zmm0, %zmm3, %zmm0
140001cf3:     	vpmovzxbq	0x7520(%rsi), %zmm3
140001cfd:     	vextracti64x4	$0x1, %zmm0, %ymm1
140001d04:     	vpaddq	%zmm1, %zmm0, %zmm0
140001d0a:     	vextracti128	$0x1, %ymm0, %xmm1
140001d10:     	vpaddq	%zmm1, %zmm0, %zmm0
140001d16:     	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
140001d1b:     	vpaddq	%zmm1, %zmm0, %zmm0
140001d21:     	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
140001d25:     	vpaddq	%zmm2, %zmm3, %zmm1
140001d2b:     	vpaddq	%zmm1, %zmm0, %zmm0
140001d31:     	vextracti64x4	$0x1, %zmm0, %ymm1
140001d38:     	vpaddq	%zmm1, %zmm0, %zmm0
140001d3e:     	vextracti128	$0x1, %ymm0, %xmm1
140001d44:     	vpaddq	%xmm1, %xmm0, %xmm0
140001d48:     	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
140001d4d:     	vpaddq	%xmm1, %xmm0, %xmm0
140001d51:     	vmovq	%xmm0, %rdx
140001d56:     	vzeroupper
140001d59:     	callq	0x140002a00 <.text+0x1a00>
140001d5e:     	movabsq	$0x14650fb0739d0383, %rdx # imm = 0x14650FB0739D0383
140001d68:     	movl	$0x18, %eax
140001d6d:     	nopl	(%rax)
140001d70:     	movzbl	-0x18(%rsi,%rax), %ecx
140001d75:     	movzbl	-0x1(%rsi,%rax), %r8d
140001d7b:     	xorq	%rdx, %rcx
140001d7e:     	movzbl	-0x17(%rsi,%rax), %edx
140001d83:     	imulq	%rdi, %rcx
140001d87:     	xorq	%rcx, %rdx
140001d8a:     	movzbl	-0x16(%rsi,%rax), %ecx
140001d8f:     	imulq	%rdi, %rdx
140001d93:     	xorq	%rdx, %rcx
140001d96:     	movzbl	-0x15(%rsi,%rax), %edx
140001d9b:     	imulq	%rdi, %rcx
140001d9f:     	xorq	%rcx, %rdx
140001da2:     	movzbl	-0x14(%rsi,%rax), %ecx
140001da7:     	imulq	%rdi, %rdx
140001dab:     	xorq	%rdx, %rcx
140001dae:     	movzbl	-0x13(%rsi,%rax), %edx
140001db3:     	imulq	%rdi, %rcx
140001db7:     	xorq	%rcx, %rdx
140001dba:     	movzbl	-0x12(%rsi,%rax), %ecx
140001dbf:     	imulq	%rdi, %rdx
140001dc3:     	xorq	%rdx, %rcx
140001dc6:     	movzbl	-0x11(%rsi,%rax), %edx
140001dcb:     	imulq	%rdi, %rcx
140001dcf:     	xorq	%rcx, %rdx
140001dd2:     	movzbl	-0x10(%rsi,%rax), %ecx
140001dd7:     	imulq	%rdi, %rdx
140001ddb:     	xorq	%rdx, %rcx
140001dde:     	movzbl	-0xf(%rsi,%rax), %edx
140001de3:     	imulq	%rdi, %rcx
140001de7:     	xorq	%rcx, %rdx
140001dea:     	movzbl	-0xe(%rsi,%rax), %ecx
140001def:     	imulq	%rdi, %rdx
140001df3:     	xorq	%rdx, %rcx
140001df6:     	movzbl	-0xd(%rsi,%rax), %edx
140001dfb:     	imulq	%rdi, %rcx
140001dff:     	xorq	%rcx, %rdx
140001e02:     	movzbl	-0xc(%rsi,%rax), %ecx
140001e07:     	imulq	%rdi, %rdx
140001e0b:     	xorq	%rdx, %rcx
140001e0e:     	movzbl	-0xb(%rsi,%rax), %edx
140001e13:     	imulq	%rdi, %rcx
140001e17:     	xorq	%rcx, %rdx
140001e1a:     	movzbl	-0xa(%rsi,%rax), %ecx
140001e1f:     	imulq	%rdi, %rdx
140001e23:     	xorq	%rdx, %rcx
140001e26:     	movzbl	-0x9(%rsi,%rax), %edx
140001e2b:     	imulq	%rdi, %rcx
140001e2f:     	xorq	%rcx, %rdx
140001e32:     	movzbl	-0x8(%rsi,%rax), %ecx
140001e37:     	imulq	%rdi, %rdx
140001e3b:     	xorq	%rdx, %rcx
140001e3e:     	movzbl	-0x7(%rsi,%rax), %edx
140001e43:     	imulq	%rdi, %rcx
140001e47:     	xorq	%rcx, %rdx
140001e4a:     	movzbl	-0x6(%rsi,%rax), %ecx
140001e4f:     	imulq	%rdi, %rdx
140001e53:     	xorq	%rdx, %rcx
140001e56:     	movzbl	-0x5(%rsi,%rax), %edx
140001e5b:     	imulq	%rdi, %rcx
140001e5f:     	xorq	%rcx, %rdx
140001e62:     	movzbl	-0x4(%rsi,%rax), %ecx
140001e67:     	imulq	%rdi, %rdx
140001e6b:     	xorq	%rdx, %rcx
140001e6e:     	movzbl	-0x3(%rsi,%rax), %edx
140001e73:     	imulq	%rdi, %rcx
140001e77:     	xorq	%rcx, %rdx
140001e7a:     	movzbl	-0x2(%rsi,%rax), %ecx
140001e7f:     	imulq	%rdi, %rdx
140001e83:     	xorq	%rdx, %rcx
140001e86:     	movzbl	(%rsi,%rax), %edx
140001e8a:     	addq	$0x19, %rax
140001e8e:     	imulq	%rdi, %rcx
140001e92:     	xorq	%rcx, %r8
140001e95:     	imulq	%rdi, %r8
140001e99:     	xorq	%r8, %rdx
140001e9c:     	imulq	%rdi, %rdx
140001ea0:     	cmpq	$0x7548, %rax           # imm = 0x7548
140001ea6:     	jne	0x140001d70 <.text+0xd70>
140001eac:     	leaq	0x29d2(%rip), %rcx      # 0x140004885
140001eb3:     	callq	0x140002a00 <.text+0x1a00>
140001eb8:     	leaq	0x29d6(%rip), %rcx      # 0x140004895
140001ebf:     	vmovq	%xmm6, %rdx
140001ec4:     	vmovapd	%xmm6, %xmm1
140001ec8:     	callq	0x140002a00 <.text+0x1a00>
140001ecd:     	movq	%rsi, %rcx
140001ed0:     	callq	*0x21b2(%rip)           # 0x140004088
140001ed6:     	vmovaps	0x650(%rsp), %xmm6
140001edf:     	vmovaps	0x660(%rsp), %xmm7
140001ee8:     	vmovaps	0x670(%rsp), %xmm8
140001ef1:     	vmovaps	0x680(%rsp), %xmm9
140001efa:     	vmovaps	0x690(%rsp), %xmm10
140001f03:     	vmovaps	0x6a0(%rsp), %xmm11
140001f0c:     	vmovaps	0x6b0(%rsp), %xmm12
140001f15:     	vmovaps	0x6c0(%rsp), %xmm13
140001f1e:     	vmovaps	0x6d0(%rsp), %xmm14
140001f27:     	vmovaps	0x6e0(%rsp), %xmm15
140001f30:     	xorl	%eax, %eax
140001f32:     	addq	$0x6f8, %rsp            # imm = 0x6F8
140001f39:     	popq	%rbx
140001f3a:     	popq	%rbp
140001f3b:     	popq	%rdi
140001f3c:     	popq	%rsi
140001f3d:     	popq	%r12
140001f3f:     	popq	%r13
140001f41:     	popq	%r14
140001f43:     	popq	%r15
140001f45:     	retq
140001f46:     	nopw	%cs:(%rax,%rax)
140001f50:     	pushq	%r15
140001f52:     	pushq	%r14
140001f54:     	pushq	%r13
140001f56:     	pushq	%r12
140001f58:     	pushq	%rsi
140001f59:     	pushq	%rdi
140001f5a:     	pushq	%rbp
140001f5b:     	pushq	%rbx
140001f5c:     	subq	$0x168, %rsp            # imm = 0x168
140001f63:     	vmovapd	%xmm15, 0x150(%rsp)
140001f6c:     	vmovapd	%xmm14, 0x140(%rsp)
140001f75:     	vmovapd	%xmm13, 0x130(%rsp)
140001f7e:     	vmovapd	%xmm12, 0x120(%rsp)
140001f87:     	vmovapd	%xmm11, 0x110(%rsp)
140001f90:     	vmovapd	%xmm10, 0x100(%rsp)
140001f99:     	vmovapd	%xmm9, 0xf0(%rsp)
140001fa2:     	vmovapd	%xmm8, 0xe0(%rsp)
140001fab:     	vmovapd	%xmm7, 0xd0(%rsp)
140001fb4:     	vmovapd	%xmm6, 0xc0(%rsp)
140001fbd:     	movl	0x538(%rdx), %eax
140001fc3:     	movq	%rcx, %rdi
140001fc6:     	cmpl	$0x4, %eax
140001fc9:     	jl	0x140001fe0 <.text+0xfe0>
140001fcb:     	vxorpd	%xmm0, %xmm0, %xmm0
140001fcf:     	vmovupd	%xmm0, (%rdi)
140001fd3:     	movq	$0x0, 0x10(%rdi)
140001fdb:     	jmp	0x14000227b <.text+0x127b>
140001fe0:     	incl	%eax
140001fe2:     	movq	%rdx, %rsi
140001fe5:     	movl	%eax, 0x538(%rdx)
140001feb:     	cmpl	$0x0, 0x4c0(%rdx)
140001ff2:     	jle	0x140002265 <.text+0x1265>
140001ff8:     	vmovsd	0x2858(%rip), %xmm8     # 0x140004858
140002000:     	vmovsd	0x2846(%rip), %xmm16    # 0x140004850
14000200a:     	leaq	0x30(%rsi), %r14
14000200e:     	movl	$0xffffffff, %ebp       # imm = 0xFFFFFFFF
140002013:     	movq	%r8, %rbx
140002016:     	vxorpd	%xmm7, %xmm7, %xmm7
14000201a:     	xorl	%r15d, %r15d
14000201d:     	vxorpd	%xmm6, %xmm6, %xmm6
140002021:     	jmp	0x14000204a <.text+0x104a>
140002023:     	nopw	%cs:(%rax,%rax)
140002030:     	movslq	0x4c0(%rsi), %rax
140002037:     	incq	%r15
14000203a:     	addq	$0x98, %r14
140002041:     	cmpq	%rax, %r15
140002044:     	jge	0x140002140 <.text+0x1140>
14000204a:     	vmovupd	0x18(%rbx), %xmm1
14000204f:     	vmovupd	0x20(%rbx), %xmm0
140002054:     	cmpl	$0x0, -0x30(%r14)
140002059:     	je	0x1400020b0 <.text+0x10b0>
14000205b:     	vmulsd	-0x8(%r14), %xmm1, %xmm1
140002061:     	vmulpd	(%r14), %xmm0, %xmm0
140002066:     	vaddsd	%xmm0, %xmm1, %xmm1
14000206a:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
14000206f:     	vaddsd	%xmm0, %xmm1, %xmm0
140002073:     	vucomisd	%xmm7, %xmm0
140002077:     	jne	0x14000207b <.text+0x107b>
140002079:     	jnp	0x140002030 <.text+0x1030>
14000207b:     	vdivsd	%xmm0, %xmm16, %xmm0
140002081:     	vucomisd	%xmm8, %xmm0
140002086:     	jbe	0x140002030 <.text+0x1030>
140002088:     	testl	%ebp, %ebp
14000208a:     	sets	%al
14000208d:     	vucomisd	%xmm0, %xmm6
140002091:     	seta	%cl
140002094:     	orb	%al, %cl
140002096:     	kmovd	%ecx, %k1
14000209a:     	cmovnel	%r15d, %ebp
14000209e:     	vmovsd	%xmm0, %xmm6, %xmm6 {%k1}
1400020a4:     	jmp	0x140002030 <.text+0x1030>
1400020a6:     	nopw	%cs:(%rax,%rax)
1400020b0:     	vmovupd	-0x28(%r14), %xmm4
1400020b6:     	vmovsd	-0x18(%r14), %xmm2
1400020bc:     	vmovsd	-0x10(%r14), %xmm3
1400020c2:     	vsubpd	(%rbx), %xmm4, %xmm4
1400020c6:     	vsubsd	0x10(%rbx), %xmm2, %xmm2
1400020cb:     	vmulsd	%xmm3, %xmm3, %xmm3
1400020cf:     	vmovsd	%xmm4, %xmm1, %xmm5     # xmm5 = xmm4[0],xmm1[1]
1400020d3:     	vshufpd	$0x1, %xmm1, %xmm4, %xmm1 # xmm1 = xmm4[1],xmm1[0]
1400020d8:     	vmovddup	%xmm2, %xmm2            # xmm2 = xmm2[0,0]
1400020dc:     	vmulpd	%xmm4, %xmm5, %xmm5
1400020e0:     	vshufpd	$0x1, %xmm4, %xmm4, %xmm4 # xmm4 = xmm4[1,0]
1400020e5:     	vmulpd	%xmm4, %xmm1, %xmm1
1400020e9:     	vmovsd	%xmm2, %xmm0, %xmm0     # xmm0 = xmm2[0],xmm0[1]
1400020ed:     	vmulpd	%xmm2, %xmm0, %xmm0
1400020f1:     	vaddpd	%xmm1, %xmm5, %xmm1
1400020f5:     	vaddpd	%xmm0, %xmm1, %xmm0
1400020f9:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm9 # xmm9 = xmm0[1,0]
1400020fe:     	vmulsd	%xmm9, %xmm9, %xmm1
140002103:     	vsubsd	%xmm0, %xmm1, %xmm0
140002107:     	vaddsd	%xmm0, %xmm3, %xmm0
14000210b:     	vucomisd	%xmm0, %xmm7
14000210f:     	ja	0x140002030 <.text+0x1030>
140002115:     	vucomisd	%xmm7, %xmm0
140002119:     	jb	0x140002128 <.text+0x1128>
14000211b:     	vsqrtsd	%xmm0, %xmm0, %xmm0
14000211f:     	vsubsd	%xmm0, %xmm9, %xmm0
140002123:     	jmp	0x140002081 <.text+0x1081>
140002128:     	callq	0x140002a76 <.text+0x1a76>
14000212d:     	vmovsd	0x2719(%rip), %xmm16    # 0x140004850
140002137:     	vsubsd	%xmm0, %xmm9, %xmm0
14000213b:     	jmp	0x140002081 <.text+0x1081>
140002140:     	vxorpd	%xmm0, %xmm0, %xmm0
140002144:     	vmovupd	%xmm0, (%rdi)
140002148:     	movq	$0x0, 0x10(%rdi)
140002150:     	testl	%ebp, %ebp
140002152:     	js	0x140002275 <.text+0x1275>
140002158:     	vmovsd	0x28(%rbx), %xmm1
14000215d:     	vmovupd	0x18(%rbx), %xmm0
140002162:     	vmovddup	%xmm6, %xmm3            # xmm3 = xmm6[0,0]
140002166:     	movl	%ebp, %eax
140002168:     	imulq	$0x98, %rax, %rax
14000216f:     	cmpl	$0x0, (%rsi,%rax)
140002173:     	vmulsd	%xmm1, %xmm6, %xmm2
140002177:     	vmulpd	%xmm0, %xmm3, %xmm3
14000217b:     	vaddsd	0x10(%rbx), %xmm2, %xmm6
140002180:     	vaddpd	(%rbx), %xmm3, %xmm7
140002184:     	leaq	(%rsi,%rax), %rbx
140002188:     	je	0x140002649 <.text+0x1649>
14000218e:     	vmovupd	0x28(%rbx), %xmm11
140002193:     	vmovsd	0x38(%rbx), %xmm13
140002198:     	cmpl	$0x1, 0x40(%rbx)
14000219c:     	movl	$0x48, %eax
1400021a1:     	jne	0x1400021ed <.text+0x11ed>
1400021a3:     	vmovddup	0x26b5(%rip), %xmm2     # xmm2 = mem[0,0]
                                                # 0x140004860
1400021ab:     	vandpd	%xmm2, %xmm7, %xmm3
1400021af:     	vaddpd	0x2547(%rip){1to2}, %xmm3, %xmm3 # 0x140004700
1400021b9:     	vandpd	%xmm2, %xmm6, %xmm2
1400021bd:     	vaddsd	0x253b(%rip), %xmm2, %xmm2 # 0x140004700
1400021c5:     	vcvttpd2dq	%xmm3, %xmm3
1400021c9:     	vcvttsd2si	%xmm2, %ecx
1400021cd:     	vpshufd	$0x55, %xmm3, %xmm4     # xmm4 = xmm3[1,1,1,1]
1400021d2:     	vpaddd	%xmm3, %xmm4, %xmm3
1400021d6:     	vmovd	%xmm3, %eax
1400021da:     	addl	%eax, %ecx
1400021dc:     	movl	$0x60, %eax
1400021e1:     	testb	$0x1, %cl
1400021e4:     	movl	$0x48, %ecx
1400021e9:     	cmoveq	%rcx, %rax
1400021ed:     	vmovsd	0x78(%rbx), %xmm2
1400021f2:     	vmovupd	(%rbx,%rax), %xmm9
1400021f7:     	vmovsd	0x10(%rbx,%rax), %xmm10
1400021fd:     	vxorpd	%xmm8, %xmm8, %xmm8
140002202:     	vxorpd	%xmm21, %xmm21, %xmm21
140002208:     	vxorpd	%xmm20, %xmm20, %xmm20
14000220e:     	vucomisd	%xmm8, %xmm2
140002213:     	ja	0x1400022e9 <.text+0x12e9>
140002219:     	vmovsd	0x80(%rbx), %xmm0
140002221:     	vucomisd	%xmm8, %xmm0
140002226:     	ja	0x1400023c9 <.text+0x13c9>
14000222c:     	vmovsd	0x88(%rbx), %xmm0
140002234:     	vxorpd	%xmm1, %xmm1, %xmm1
140002238:     	vucomisd	%xmm1, %xmm0
14000223c:     	jbe	0x140002256 <.text+0x1256>
14000223e:     	vmulsd	%xmm0, %xmm10, %xmm1
140002242:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
140002246:     	vmulpd	%xmm0, %xmm9, %xmm0
14000224a:     	vaddsd	%xmm1, %xmm20, %xmm20
140002250:     	vaddpd	%xmm0, %xmm21, %xmm21
140002256:     	vmovupd	%xmm21, (%rdi)
14000225c:     	vmovsd	%xmm20, 0x10(%rdi)
140002263:     	jmp	0x140002275 <.text+0x1275>
140002265:     	vxorpd	%xmm0, %xmm0, %xmm0
140002269:     	vmovupd	%xmm0, (%rdi)
14000226d:     	movq	$0x0, 0x10(%rdi)
140002275:     	decl	0x538(%rsi)
14000227b:     	vmovaps	0xc0(%rsp), %xmm6
140002284:     	vmovaps	0xd0(%rsp), %xmm7
14000228d:     	vmovaps	0xe0(%rsp), %xmm8
140002296:     	vmovaps	0xf0(%rsp), %xmm9
14000229f:     	vmovaps	0x100(%rsp), %xmm10
1400022a8:     	vmovaps	0x110(%rsp), %xmm11
1400022b1:     	vmovaps	0x120(%rsp), %xmm12
1400022ba:     	vmovaps	0x130(%rsp), %xmm13
1400022c3:     	vmovaps	0x140(%rsp), %xmm14
1400022cc:     	vmovaps	0x150(%rsp), %xmm15
1400022d5:     	addq	$0x168, %rsp            # imm = 0x168
1400022dc:     	popq	%rbx
1400022dd:     	popq	%rbp
1400022de:     	popq	%rdi
1400022df:     	popq	%rsi
1400022e0:     	popq	%r12
1400022e2:     	popq	%r13
1400022e4:     	popq	%r14
1400022e6:     	popq	%r15
1400022e8:     	retq
1400022e9:     	vmulpd	%xmm0, %xmm11, %xmm2
1400022ed:     	leaq	0x70(%rsp), %rcx
1400022f2:     	leaq	0x90(%rsp), %r8
1400022fa:     	vmovapd	%xmm7, 0x90(%rsp)
140002303:     	movq	%rsi, %rdx
140002306:     	vmovsd	%xmm6, 0xa0(%rsp)
14000230f:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140002314:     	vaddsd	%xmm2, %xmm3, %xmm2
140002318:     	vmulsd	%xmm1, %xmm13, %xmm3
14000231c:     	vaddsd	%xmm2, %xmm3, %xmm2
140002320:     	vmulsd	%xmm2, %xmm13, %xmm3
140002324:     	vmovddup	%xmm2, %xmm2            # xmm2 = xmm2[0,0]
140002328:     	vmulpd	%xmm2, %xmm11, %xmm2
14000232c:     	vaddsd	%xmm3, %xmm3, %xmm3
140002330:     	vaddpd	%xmm2, %xmm2, %xmm2
140002334:     	vsubsd	%xmm3, %xmm1, %xmm1
140002338:     	vsubpd	%xmm2, %xmm0, %xmm0
14000233c:     	vmulsd	%xmm1, %xmm1, %xmm3
140002340:     	vmulpd	%xmm0, %xmm0, %xmm2
140002344:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm4 # xmm4 = xmm2[1,0]
140002349:     	vaddsd	%xmm4, %xmm2, %xmm2
14000234d:     	vaddsd	%xmm2, %xmm3, %xmm2
140002351:     	vmovsd	0x2287(%rip), %xmm3     # 0x1400045e0
140002359:     	vsqrtsd	%xmm2, %xmm2, %xmm2
14000235d:     	vdivsd	%xmm2, %xmm3, %xmm2
140002361:     	vmulsd	%xmm2, %xmm1, %xmm1
140002365:     	vmovddup	%xmm2, %xmm2            # xmm2 = xmm2[0,0]
140002369:     	vmulpd	%xmm2, %xmm0, %xmm0
14000236d:     	vmovupd	%xmm0, 0xa8(%rsp)
140002376:     	vmovsd	%xmm1, 0xb8(%rsp)
14000237f:     	callq	0x140001f50 <.text+0xf50>
140002384:     	vmovddup	0x78(%rbx), %xmm0       # xmm0 = mem[0,0]
140002389:     	vmovsd	0x24bd(%rip), %xmm16    # 0x140004850
140002393:     	vxorpd	%xmm2, %xmm2, %xmm2
140002397:     	vmulsd	0x80(%rsp), %xmm0, %xmm1
1400023a0:     	vmulpd	0x70(%rsp), %xmm0, %xmm0
1400023a6:     	vaddsd	%xmm2, %xmm1, %xmm20
1400023ac:     	vxorpd	%xmm1, %xmm1, %xmm1
1400023b0:     	vaddpd	%xmm1, %xmm0, %xmm21
1400023b6:     	vmovsd	0x80(%rbx), %xmm0
1400023be:     	vucomisd	%xmm8, %xmm0
1400023c3:     	jbe	0x14000222c <.text+0x122c>
1400023c9:     	movl	0x4f8(%rsi), %ecx
1400023cf:     	testl	%ecx, %ecx
1400023d1:     	jle	0x1400026c6 <.text+0x16c6>
1400023d7:     	movl	0x4c0(%rsi), %eax
1400023dd:     	testl	%eax, %eax
1400023df:     	jle	0x1400026d0 <.text+0x16d0>
1400023e5:     	vmovsd	0x21f3(%rip), %xmm5     # 0x1400045e0
1400023ed:     	vmovsd	0x2473(%rip), %xmm12    # 0x140004868
1400023f5:     	vmovapd	%xmm21, 0x50(%rsp)
1400023fd:     	vmovsd	%xmm20, 0x28(%rsp)
140002405:     	vmovsd	%xmm10, 0x30(%rsp)
14000240b:     	vmovapd	%xmm9, 0x60(%rsp)
140002411:     	movq	%rbx, 0x38(%rsp)
140002416:     	leaq	0x4c8(%rsi), %r14
14000241d:     	leaq	0x38(%rsi), %r15
140002421:     	vxorpd	%xmm8, %xmm8, %xmm8
140002426:     	xorl	%r12d, %r12d
140002429:     	vxorpd	%xmm15, %xmm15, %xmm15
14000242e:     	vmovapd	%xmm11, 0x40(%rsp)
140002434:     	nopw	%cs:(%rax,%rax)
140002440:     	leaq	(%r12,%r12,2), %rcx
140002444:     	vmovupd	(%r14,%rcx,8), %xmm0
14000244a:     	vmovsd	0x10(%r14,%rcx,8), %xmm1
140002451:     	testl	%eax, %eax
140002453:     	jle	0x1400025ab <.text+0x15ab>
140002459:     	vsubpd	%xmm7, %xmm0, %xmm0
14000245d:     	vsubsd	%xmm6, %xmm1, %xmm1
140002461:     	vmovapd	%xmm13, %xmm11
140002466:     	leaq	(%r14,%rcx,8), %r13
14000246a:     	vmovapd	%xmm5, %xmm14
14000246e:     	movq	%r15, %rbp
140002471:     	xorl	%ebx, %ebx
140002473:     	vmulpd	%xmm0, %xmm0, %xmm2
140002477:     	vmulsd	%xmm1, %xmm1, %xmm4
14000247b:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140002480:     	vaddsd	%xmm3, %xmm2, %xmm2
140002484:     	vaddsd	%xmm4, %xmm2, %xmm2
140002488:     	vsqrtsd	%xmm2, %xmm2, %xmm2
14000248c:     	vdivsd	%xmm2, %xmm5, %xmm2
140002490:     	vmulsd	%xmm2, %xmm1, %xmm13
140002494:     	vmovddup	%xmm2, %xmm2            # xmm2 = xmm2[0,0]
140002498:     	vmulpd	%xmm2, %xmm0, %xmm9
14000249c:     	jmp	0x1400024b6 <.text+0x14b6>
14000249e:     	nop
1400024a0:     	incq	%rbx
1400024a3:     	movslq	%eax, %rcx
1400024a6:     	addq	$0x98, %rbp
1400024ad:     	cmpq	%rcx, %rbx
1400024b0:     	jge	0x140002590 <.text+0x1590>
1400024b6:     	cmpl	$0x0, -0x38(%rbp)
1400024ba:     	je	0x140002500 <.text+0x1500>
1400024bc:     	vmulpd	-0x10(%rbp), %xmm9, %xmm0
1400024c1:     	vmulsd	(%rbp), %xmm13, %xmm2
1400024c6:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
1400024cb:     	vaddsd	%xmm1, %xmm0, %xmm0
1400024cf:     	vaddsd	%xmm2, %xmm0, %xmm0
1400024d3:     	vucomisd	%xmm8, %xmm0
1400024d8:     	jne	0x1400024dc <.text+0x14dc>
1400024da:     	jnp	0x1400024a0 <.text+0x14a0>
1400024dc:     	vdivsd	%xmm0, %xmm16, %xmm0
1400024e2:     	vucomisd	%xmm12, %xmm0
1400024e7:     	ja	0x140002620 <.text+0x1620>
1400024ed:     	movl	0x4c0(%rsi), %eax
1400024f3:     	jmp	0x1400024a0 <.text+0x14a0>
1400024f5:     	nopw	%cs:(%rax,%rax)
140002500:     	vmovupd	-0x30(%rbp), %xmm2
140002505:     	vmovsd	-0x20(%rbp), %xmm0
14000250a:     	vmovsd	-0x18(%rbp), %xmm1
14000250f:     	vsubpd	%xmm7, %xmm2, %xmm2
140002513:     	vsubsd	%xmm6, %xmm0, %xmm0
140002517:     	vmulsd	%xmm1, %xmm1, %xmm1
14000251b:     	vmovsd	%xmm2, %xmm9, %xmm3     # xmm3 = xmm2[0],xmm9[1]
14000251f:     	vshufpd	$0x1, %xmm9, %xmm2, %xmm4 # xmm4 = xmm2[1],xmm9[0]
140002525:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
140002529:     	vmulpd	%xmm2, %xmm3, %xmm3
14000252d:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
140002532:     	vmulpd	%xmm2, %xmm4, %xmm2
140002536:     	vunpcklpd	%xmm13, %xmm0, %xmm4 # xmm4 = xmm0[0],xmm13[0]
14000253b:     	vmulpd	%xmm0, %xmm4, %xmm0
14000253f:     	vaddpd	%xmm2, %xmm3, %xmm2
140002543:     	vaddpd	%xmm0, %xmm2, %xmm0
140002547:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm10 # xmm10 = xmm0[1,0]
14000254c:     	vmulsd	%xmm10, %xmm10, %xmm2
140002551:     	vsubsd	%xmm0, %xmm2, %xmm0
140002555:     	vaddsd	%xmm0, %xmm1, %xmm0
140002559:     	vucomisd	%xmm0, %xmm8
14000255d:     	ja	0x1400024a0 <.text+0x14a0>
140002563:     	vucomisd	%xmm8, %xmm0
140002568:     	jb	0x140002577 <.text+0x1577>
14000256a:     	vsqrtsd	%xmm0, %xmm0, %xmm0
14000256e:     	vsubsd	%xmm0, %xmm10, %xmm0
140002572:     	jmp	0x1400024e2 <.text+0x14e2>
140002577:     	callq	0x140002a76 <.text+0x1a76>
14000257c:     	vmovsd	0x22ca(%rip), %xmm16    # 0x140004850
140002586:     	vsubsd	%xmm0, %xmm10, %xmm0
14000258a:     	jmp	0x1400024e2 <.text+0x14e2>
14000258f:     	nop
140002590:     	vmovapd	%xmm11, %xmm13
140002595:     	vmovupd	(%r13), %xmm0
14000259b:     	vmovsd	0x10(%r13), %xmm1
1400025a1:     	vmovapd	0x40(%rsp), %xmm11
1400025a7:     	vmovapd	%xmm14, %xmm5
1400025ab:     	vsubpd	%xmm7, %xmm0, %xmm0
1400025af:     	vsubsd	%xmm6, %xmm1, %xmm1
1400025b3:     	vmulpd	%xmm0, %xmm0, %xmm3
1400025b7:     	vmulsd	%xmm1, %xmm1, %xmm2
1400025bb:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
1400025c0:     	vaddsd	%xmm4, %xmm3, %xmm3
1400025c4:     	vaddsd	%xmm2, %xmm3, %xmm2
1400025c8:     	vsqrtsd	%xmm2, %xmm2, %xmm2
1400025cc:     	vdivsd	%xmm2, %xmm5, %xmm2
1400025d0:     	vmulsd	%xmm2, %xmm1, %xmm1
1400025d4:     	vmovddup	%xmm2, %xmm2            # xmm2 = xmm2[0,0]
1400025d8:     	vmulpd	%xmm2, %xmm0, %xmm0
1400025dc:     	vmulsd	%xmm1, %xmm13, %xmm1
1400025e0:     	vmulpd	%xmm0, %xmm11, %xmm0
1400025e4:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
1400025e9:     	vaddsd	%xmm2, %xmm0, %xmm0
1400025ed:     	vaddsd	%xmm0, %xmm1, %xmm0
1400025f1:     	vaddsd	%xmm0, %xmm15, %xmm1
1400025f5:     	vcmpltsd	%xmm0, %xmm8, %k1
1400025fc:     	vmovsd	%xmm1, %xmm15, %xmm15 {%k1}
140002602:     	movslq	0x4f8(%rsi), %rax
140002609:     	incq	%r12
14000260c:     	cmpq	%rax, %r12
14000260f:     	jl	0x14000263e <.text+0x163e>
140002611:     	jmp	0x140002698 <.text+0x1698>
140002616:     	nopw	%cs:(%rax,%rax)
140002620:     	vmovapd	%xmm11, %xmm13
140002625:     	vmovapd	0x40(%rsp), %xmm11
14000262b:     	vmovapd	%xmm14, %xmm5
14000262f:     	movslq	0x4f8(%rsi), %rax
140002636:     	incq	%r12
140002639:     	cmpq	%rax, %r12
14000263c:     	jge	0x140002698 <.text+0x1698>
14000263e:     	movl	0x4c0(%rsi), %eax
140002644:     	jmp	0x140002440 <.text+0x1440>
140002649:     	vsubpd	0x8(%rbx), %xmm7, %xmm3
14000264e:     	vsubsd	0x18(%rbx), %xmm6, %xmm2
140002653:     	vmulpd	%xmm3, %xmm3, %xmm4
140002657:     	vshufpd	$0x1, %xmm4, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
14000265c:     	vaddsd	%xmm5, %xmm4, %xmm4
140002660:     	vmulsd	%xmm2, %xmm2, %xmm5
140002664:     	vaddsd	%xmm5, %xmm4, %xmm4
140002668:     	vmovsd	0x1f70(%rip), %xmm5     # 0x1400045e0
140002670:     	vsqrtsd	%xmm4, %xmm4, %xmm4
140002674:     	vdivsd	%xmm4, %xmm5, %xmm4
140002678:     	vmulsd	%xmm4, %xmm2, %xmm13
14000267c:     	vmovddup	%xmm4, %xmm4            # xmm4 = xmm4[0,0]
140002680:     	vmulpd	%xmm4, %xmm3, %xmm11
140002684:     	cmpl	$0x1, 0x40(%rbx)
140002688:     	movl	$0x48, %eax
14000268d:     	je	0x1400021a3 <.text+0x11a3>
140002693:     	jmp	0x1400021ed <.text+0x11ed>
140002698:     	movq	0x38(%rsp), %rbx
14000269d:     	vmovaps	0x60(%rsp), %xmm9
1400026a3:     	vmovsd	0x30(%rsp), %xmm10
1400026a9:     	vmovsd	0x28(%rsp), %xmm20
1400026b1:     	vmovaps	0x50(%rsp), %xmm21
1400026b9:     	vmovsd	0x80(%rbx), %xmm0
1400026c1:     	jmp	0x1400029b3 <.text+0x19b3>
1400026c6:     	vxorpd	%xmm15, %xmm15, %xmm15
1400026cb:     	jmp	0x1400029b3 <.text+0x19b3>
1400026d0:     	movl	%ecx, %eax
1400026d2:     	andl	$0x3, %eax
1400026d5:     	cmpl	$0x4, %ecx
1400026d8:     	jae	0x1400026e6 <.text+0x16e6>
1400026da:     	vxorpd	%xmm15, %xmm15, %xmm15
1400026df:     	xorl	%edx, %edx
1400026e1:     	jmp	0x140002910 <.text+0x1910>
1400026e6:     	vmovsd	0x1ef2(%rip), %xmm2     # 0x1400045e0
1400026ee:     	andl	$0x7ffffffc, %ecx       # imm = 0x7FFFFFFC
1400026f4:     	leaq	0x520(%rsi), %r8
1400026fb:     	vxorpd	%xmm1, %xmm1, %xmm1
1400026ff:     	xorl	%edx, %edx
140002701:     	vxorpd	%xmm15, %xmm15, %xmm15
140002706:     	nopw	%cs:(%rax,%rax)
140002710:     	vmovupd	-0x58(%r8), %xmm5
140002716:     	vmovsd	-0x48(%r8), %xmm3
14000271c:     	addq	$0x4, %rdx
140002720:     	vsubpd	%xmm7, %xmm5, %xmm5
140002724:     	vsubsd	%xmm6, %xmm3, %xmm3
140002728:     	vmulpd	%xmm5, %xmm5, %xmm16
14000272e:     	vmulsd	%xmm3, %xmm3, %xmm4
140002732:     	vshufpd	$0x1, %xmm16, %xmm16, %xmm17 # xmm17 = xmm16[1,0]
140002739:     	vaddsd	%xmm17, %xmm16, %xmm16
14000273f:     	vmovupd	-0x40(%r8), %xmm17
140002746:     	vaddsd	%xmm4, %xmm16, %xmm4
14000274c:     	vsqrtsd	%xmm4, %xmm4, %xmm4
140002750:     	vsubpd	%xmm7, %xmm17, %xmm17
140002756:     	vmulpd	%xmm17, %xmm17, %xmm18
14000275c:     	vshufpd	$0x1, %xmm18, %xmm18, %xmm19 # xmm19 = xmm18[1,0]
140002763:     	vaddsd	%xmm19, %xmm18, %xmm18
140002769:     	vdivsd	%xmm4, %xmm2, %xmm4
14000276d:     	vmulsd	%xmm4, %xmm3, %xmm3
140002771:     	vmovddup	%xmm4, %xmm4            # xmm4 = xmm4[0,0]
140002775:     	vmulpd	%xmm4, %xmm5, %xmm4
140002779:     	vmovsd	-0x30(%r8), %xmm5
14000277f:     	vmulsd	%xmm3, %xmm13, %xmm3
140002783:     	vmulpd	%xmm4, %xmm11, %xmm4
140002787:     	vshufpd	$0x1, %xmm4, %xmm4, %xmm19 # xmm19 = xmm4[1,0]
14000278e:     	vaddsd	%xmm19, %xmm4, %xmm4
140002794:     	vsubsd	%xmm6, %xmm5, %xmm5
140002798:     	vaddsd	%xmm4, %xmm3, %xmm3
14000279c:     	vmulsd	%xmm5, %xmm5, %xmm16
1400027a2:     	vcmpltsd	%xmm3, %xmm1, %k1
1400027a9:     	vaddsd	%xmm16, %xmm18, %xmm16
1400027af:     	vmovupd	-0x28(%r8), %xmm18
1400027b9:     	vsqrtsd	%xmm16, %xmm16, %xmm16
1400027bf:     	vsubpd	%xmm7, %xmm18, %xmm18
1400027c5:     	vdivsd	%xmm16, %xmm2, %xmm16
1400027cb:     	vmulsd	%xmm16, %xmm5, %xmm5
1400027d1:     	vmovddup	%xmm16, %xmm16          # xmm16 = xmm16[0,0]
1400027d7:     	vmulpd	%xmm16, %xmm17, %xmm16
1400027dd:     	vmulsd	%xmm5, %xmm13, %xmm5
1400027e1:     	vmulpd	%xmm16, %xmm11, %xmm16
1400027e7:     	vshufpd	$0x1, %xmm16, %xmm16, %xmm17 # xmm17 = xmm16[1,0]
1400027ee:     	vaddsd	%xmm17, %xmm16, %xmm16
1400027f4:     	vmulpd	%xmm18, %xmm18, %xmm17
1400027fa:     	vshufpd	$0x1, %xmm17, %xmm17, %xmm19 # xmm19 = xmm17[1,0]
140002801:     	vaddsd	%xmm16, %xmm5, %xmm5
140002807:     	vaddsd	%xmm19, %xmm17, %xmm17
14000280d:     	vmovsd	-0x18(%r8), %xmm19
140002814:     	vsubsd	%xmm6, %xmm19, %xmm19
14000281a:     	vmulsd	%xmm19, %xmm19, %xmm4
140002820:     	vaddsd	%xmm4, %xmm17, %xmm4
140002826:     	vsqrtsd	%xmm4, %xmm4, %xmm4
14000282a:     	vdivsd	%xmm4, %xmm2, %xmm4
14000282e:     	vmulsd	%xmm4, %xmm19, %xmm16
140002834:     	vmovddup	%xmm4, %xmm4            # xmm4 = xmm4[0,0]
140002838:     	vmulpd	%xmm4, %xmm18, %xmm4
14000283e:     	vaddsd	%xmm3, %xmm15, %xmm18
140002844:     	vmulsd	%xmm16, %xmm13, %xmm16
14000284a:     	vmulpd	%xmm4, %xmm11, %xmm4
14000284e:     	vmovsd	%xmm18, %xmm15, %xmm15 {%k1}
140002854:     	vcmpltsd	%xmm5, %xmm1, %k1
14000285b:     	vaddsd	%xmm5, %xmm15, %xmm5
14000285f:     	vshufpd	$0x1, %xmm4, %xmm4, %xmm17 # xmm17 = xmm4[1,0]
140002866:     	vaddsd	%xmm17, %xmm4, %xmm4
14000286c:     	vmovsd	%xmm5, %xmm15, %xmm15 {%k1}
140002872:     	vaddsd	%xmm4, %xmm16, %xmm4
140002878:     	vmovupd	-0x10(%r8), %xmm16
14000287f:     	vcmpltsd	%xmm4, %xmm1, %k2
140002886:     	vaddsd	%xmm4, %xmm15, %xmm4
14000288a:     	vmovsd	%xmm4, %xmm15, %xmm15 {%k2}
140002890:     	vsubpd	%xmm7, %xmm16, %xmm16
140002896:     	vmulpd	%xmm16, %xmm16, %xmm3
14000289c:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm17 # xmm17 = xmm3[1,0]
1400028a3:     	vaddsd	%xmm17, %xmm3, %xmm3
1400028a9:     	vmovsd	(%r8), %xmm17
1400028af:     	addq	$0x60, %r8
1400028b3:     	vsubsd	%xmm6, %xmm17, %xmm17
1400028b9:     	vmulsd	%xmm17, %xmm17, %xmm18
1400028bf:     	vaddsd	%xmm18, %xmm3, %xmm3
1400028c5:     	vsqrtsd	%xmm3, %xmm3, %xmm3
1400028c9:     	vdivsd	%xmm3, %xmm2, %xmm3
1400028cd:     	vmulsd	%xmm3, %xmm17, %xmm5
1400028d3:     	vmovddup	%xmm3, %xmm3            # xmm3 = xmm3[0,0]
1400028d7:     	vmulpd	%xmm3, %xmm16, %xmm3
1400028dd:     	vmulsd	%xmm5, %xmm13, %xmm5
1400028e1:     	vmulpd	%xmm3, %xmm11, %xmm3
1400028e5:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm16 # xmm16 = xmm3[1,0]
1400028ec:     	vaddsd	%xmm16, %xmm3, %xmm3
1400028f2:     	vaddsd	%xmm3, %xmm5, %xmm3
1400028f6:     	vaddsd	%xmm3, %xmm15, %xmm4
1400028fa:     	vcmpltsd	%xmm3, %xmm1, %k1
140002901:     	vmovsd	%xmm4, %xmm15, %xmm15 {%k1}
140002907:     	cmpq	%rdx, %rcx
14000290a:     	jne	0x140002710 <.text+0x1710>
140002910:     	testq	%rax, %rax
140002913:     	je	0x1400029b3 <.text+0x19b3>
140002919:     	vmovsd	0x1cbf(%rip), %xmm1     # 0x1400045e0
140002921:     	leaq	(%rdx,%rdx,2), %rcx
140002925:     	shll	$0x3, %eax
140002928:     	xorl	%edx, %edx
14000292a:     	vxorpd	%xmm2, %xmm2, %xmm2
14000292e:     	leaq	(%rax,%rax,2), %rax
140002932:     	leaq	0x4d8(%rsi,%rcx,8), %rcx
14000293a:     	nopw	(%rax,%rax)
140002940:     	vmovupd	-0x10(%rcx,%rdx), %xmm4
140002946:     	vmovsd	(%rcx,%rdx), %xmm3
14000294b:     	addq	$0x18, %rdx
14000294f:     	vsubpd	%xmm7, %xmm4, %xmm4
140002953:     	vsubsd	%xmm6, %xmm3, %xmm3
140002957:     	vmulpd	%xmm4, %xmm4, %xmm5
14000295b:     	vmulsd	%xmm3, %xmm3, %xmm16
140002961:     	vshufpd	$0x1, %xmm5, %xmm5, %xmm17 # xmm17 = xmm5[1,0]
140002968:     	vaddsd	%xmm17, %xmm5, %xmm5
14000296e:     	vaddsd	%xmm16, %xmm5, %xmm5
140002974:     	vsqrtsd	%xmm5, %xmm5, %xmm5
140002978:     	vdivsd	%xmm5, %xmm1, %xmm5
14000297c:     	vmulsd	%xmm5, %xmm3, %xmm3
140002980:     	vmovddup	%xmm5, %xmm5            # xmm5 = xmm5[0,0]
140002984:     	vmulpd	%xmm5, %xmm4, %xmm4
140002988:     	vmulsd	%xmm3, %xmm13, %xmm3
14000298c:     	vmulpd	%xmm4, %xmm11, %xmm4
140002990:     	vshufpd	$0x1, %xmm4, %xmm4, %xmm5 # xmm5 = xmm4[1,0]
140002995:     	vaddsd	%xmm5, %xmm4, %xmm4
140002999:     	vaddsd	%xmm4, %xmm3, %xmm3
14000299d:     	vaddsd	%xmm3, %xmm15, %xmm4
1400029a1:     	vcmpltsd	%xmm3, %xmm2, %k1
1400029a8:     	vmovsd	%xmm4, %xmm15, %xmm15 {%k1}
1400029ae:     	cmpq	%rdx, %rax
1400029b1:     	jne	0x140002940 <.text+0x1940>
1400029b3:     	vminsd	0x1c25(%rip), %xmm15, %xmm1 # 0x1400045e0
1400029bb:     	vmulsd	%xmm0, %xmm1, %xmm0
1400029bf:     	vmulsd	%xmm0, %xmm10, %xmm1
1400029c3:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
1400029c7:     	vmulpd	%xmm0, %xmm9, %xmm0
1400029cb:     	vaddsd	%xmm1, %xmm20, %xmm20
1400029d1:     	vaddpd	%xmm0, %xmm21, %xmm21
1400029d7:     	vmovsd	0x88(%rbx), %xmm0
1400029df:     	vxorpd	%xmm1, %xmm1, %xmm1
1400029e3:     	vucomisd	%xmm1, %xmm0
1400029e7:     	ja	0x14000223e <.text+0x123e>
1400029ed:     	jmp	0x140002256 <.text+0x1256>
1400029f2:     	int3
1400029f3:     	int3
1400029f4:     	int3
1400029f5:     	int3
1400029f6:     	int3
1400029f7:     	int3
1400029f8:     	int3
1400029f9:     	int3
1400029fa:     	int3
1400029fb:     	int3
1400029fc:     	int3
1400029fd:     	int3
1400029fe:     	int3
1400029ff:     	int3
140002a00:     	pushq	%rsi
140002a01:     	pushq	%rdi
140002a02:     	pushq	%rbx
140002a03:     	subq	$0x30, %rsp
140002a07:     	movq	%rcx, %rsi
140002a0a:     	leaq	0x58(%rsp), %rbx
140002a0f:     	movl	$0x1, %ecx
140002a14:     	movq	%rdx, 0x58(%rsp)
140002a19:     	movq	%r8, 0x60(%rsp)
140002a1e:     	movq	%r9, 0x68(%rsp)
140002a23:     	movq	%rbx, 0x28(%rsp)
140002a28:     	callq	*0x1732(%rip)           # 0x140004160
140002a2e:     	movq	%rax, %rdi
140002a31:     	callq	0x140002a60 <.text+0x1a60>
140002a36:     	movq	(%rax), %rcx
140002a39:     	movq	%rbx, 0x20(%rsp)
140002a3e:     	movq	%rdi, %rdx
140002a41:     	movq	%rsi, %r8
140002a44:     	xorl	%r9d, %r9d
140002a47:     	callq	*0x172b(%rip)           # 0x140004178
140002a4d:     	nop
140002a4e:     	addq	$0x30, %rsp
140002a52:     	popq	%rbx
140002a53:     	popq	%rdi
140002a54:     	popq	%rsi
140002a55:     	retq
140002a56:     	int3
140002a57:     	int3
140002a58:     	int3
140002a59:     	int3
140002a5a:     	int3
140002a5b:     	int3
140002a5c:     	int3
140002a5d:     	int3
140002a5e:     	int3
140002a5f:     	int3
140002a60:     	leaq	0x3639(%rip), %rax      # 0x1400060a0
140002a67:     	retq
140002a68:     	int3
140002a69:     	int3
140002a6a:     	int3
140002a6b:     	int3
140002a6c:     	int3
140002a6d:     	int3
140002a6e:     	int3
140002a6f:     	int3
140002a70:     	jmpq	*0x163a(%rip)           # 0x1400040b0
140002a76:     	jmpq	*0x163c(%rip)           # 0x1400040b8
140002a7c:     	pushq	%rbx
140002a7e:     	subq	$0x20, %rsp
140002a82:     	movl	$0x1, %ecx
140002a87:     	callq	0x140003446 <.text+0x2446>
140002a8c:     	callq	0x140002fec <.text+0x1fec>
140002a91:     	movl	%eax, %ecx
140002a93:     	callq	0x14000347c <.text+0x247c>
140002a98:     	callq	0x140002fe0 <.text+0x1fe0>
140002a9d:     	movl	%eax, %ebx
140002a9f:     	callq	0x1400034ac <.text+0x24ac>
140002aa4:     	movl	$0x1, %ecx
140002aa9:     	movl	%ebx, (%rax)
140002aab:     	callq	0x140002d68 <.text+0x1d68>
140002ab0:     	testb	%al, %al
140002ab2:     	je	0x140002b27 <.text+0x1b27>
140002ab4:     	callq	0x14000311c <.text+0x211c>
140002ab9:     	leaq	0x698(%rip), %rcx       # 0x140003158 <.text+0x2158>
140002ac0:     	callq	0x140002f18 <.text+0x1f18>
140002ac5:     	callq	0x140002fe4 <.text+0x1fe4>
140002aca:     	movl	%eax, %ecx
140002acc:     	callq	0x140003452 <.text+0x2452>
140002ad1:     	testl	%eax, %eax
140002ad3:     	jne	0x140002b27 <.text+0x1b27>
140002ad5:     	callq	0x140002ff4 <.text+0x1ff4>
140002ada:     	callq	0x140003030 <.text+0x2030>
140002adf:     	testl	%eax, %eax
140002ae1:     	je	0x140002aef <.text+0x1aef>
140002ae3:     	leaq	0x4f6(%rip), %rcx       # 0x140002fe0 <.text+0x1fe0>
140002aea:     	callq	0x14000344c <.text+0x244c>
140002aef:     	callq	0x140003008 <.text+0x2008>
140002af4:     	callq	0x140003008 <.text+0x2008>
140002af9:     	callq	0x140002fe0 <.text+0x1fe0>
140002afe:     	movl	%eax, %ecx
140002b00:     	callq	0x1400034a0 <.text+0x24a0>
140002b05:     	callq	0x140003004 <.text+0x2004>
140002b0a:     	testb	%al, %al
140002b0c:     	je	0x140002b13 <.text+0x1b13>
140002b0e:     	callq	0x140003458 <.text+0x2458>
140002b13:     	callq	0x140002fe0 <.text+0x1fe0>
140002b18:     	callq	0x140003054 <.text+0x2054>
140002b1d:     	testl	%eax, %eax
140002b1f:     	jne	0x140002b27 <.text+0x1b27>
140002b21:     	addq	$0x20, %rsp
140002b25:     	popq	%rbx
140002b26:     	retq
140002b27:     	movl	$0x7, %ecx
140002b2c:     	callq	0x14000304c <.text+0x204c>
140002b31:     	int3
140002b32:     	int3
140002b33:     	int3
140002b34:     	subq	$0x28, %rsp
140002b38:     	callq	0x140003014 <.text+0x2014>
140002b3d:     	xorl	%eax, %eax
140002b3f:     	addq	$0x28, %rsp
140002b43:     	retq
140002b44:     	subq	$0x28, %rsp
140002b48:     	callq	0x1400030b0 <.text+0x20b0>
140002b4d:     	callq	0x140002fe0 <.text+0x1fe0>
140002b52:     	movl	%eax, %ecx
140002b54:     	addq	$0x28, %rsp
140002b58:     	jmp	0x1400034a6 <.text+0x24a6>
140002b5d:     	int3
140002b5e:     	int3
140002b5f:     	int3
140002b60:     	movq	%rbx, 0x8(%rsp)
140002b65:     	movq	%rsi, 0x10(%rsp)
140002b6a:     	pushq	%rdi
140002b6b:     	subq	$0x30, %rsp
140002b6f:     	movl	$0x1, %ecx
140002b74:     	callq	0x140002d2c <.text+0x1d2c>
140002b79:     	testb	%al, %al
140002b7b:     	je	0x140002cb7 <.text+0x1cb7>
140002b81:     	xorb	%sil, %sil
140002b84:     	movb	%sil, 0x20(%rsp)
140002b89:     	callq	0x140002cf0 <.text+0x1cf0>
140002b8e:     	movb	%al, %bl
140002b90:     	movl	0x3512(%rip), %ecx      # 0x1400060a8
140002b96:     	cmpl	$0x1, %ecx
140002b99:     	je	0x140002cc2 <.text+0x1cc2>
140002b9f:     	testl	%ecx, %ecx
140002ba1:     	jne	0x140002bed <.text+0x1bed>
140002ba3:     	movl	$0x1, 0x34fb(%rip)      # 0x1400060a8
140002bad:     	leaq	0x164c(%rip), %rdx      # 0x140004200
140002bb4:     	leaq	0x162d(%rip), %rcx      # 0x1400041e8
140002bbb:     	callq	0x14000346a <.text+0x246a>
140002bc0:     	testl	%eax, %eax
140002bc2:     	je	0x140002bce <.text+0x1bce>
140002bc4:     	movl	$0xff, %eax
140002bc9:     	jmp	0x140002ca7 <.text+0x1ca7>
140002bce:     	leaq	0x160b(%rip), %rdx      # 0x1400041e0
140002bd5:     	leaq	0x15f4(%rip), %rcx      # 0x1400041d0
140002bdc:     	callq	0x140003464 <.text+0x2464>
140002be1:     	movl	$0x2, 0x34bd(%rip)      # 0x1400060a8
140002beb:     	jmp	0x140002bf5 <.text+0x1bf5>
140002bed:     	movb	$0x1, %sil
140002bf0:     	movb	%sil, 0x20(%rsp)
140002bf5:     	movb	%bl, %cl
140002bf7:     	callq	0x140002e8c <.text+0x1e8c>
140002bfc:     	callq	0x14000303c <.text+0x203c>
140002c01:     	movq	%rax, %rbx
140002c04:     	cmpq	$0x0, (%rax)
140002c08:     	je	0x140002c28 <.text+0x1c28>
140002c0a:     	movq	%rax, %rcx
140002c0d:     	callq	0x140002df4 <.text+0x1df4>
140002c12:     	testb	%al, %al
140002c14:     	je	0x140002c28 <.text+0x1c28>
140002c16:     	xorl	%r8d, %r8d
140002c19:     	leal	0x2(%r8), %edx
140002c1d:     	xorl	%ecx, %ecx
140002c1f:     	movq	(%rbx), %rax
140002c22:     	callq	*0x1580(%rip)           # 0x1400041a8
140002c28:     	callq	0x140003044 <.text+0x2044>
140002c2d:     	movq	%rax, %rbx
140002c30:     	cmpq	$0x0, (%rax)
140002c34:     	je	0x140002c4a <.text+0x1c4a>
140002c36:     	movq	%rax, %rcx
140002c39:     	callq	0x140002df4 <.text+0x1df4>
140002c3e:     	testb	%al, %al
140002c40:     	je	0x140002c4a <.text+0x1c4a>
140002c42:     	movq	(%rbx), %rcx
140002c45:     	callq	0x14000349a <.text+0x249a>
140002c4a:     	callq	0x14000345e <.text+0x245e>
140002c4f:     	movq	%rax, %rdi
140002c52:     	callq	0x140003488 <.text+0x2488>
140002c57:     	movq	(%rax), %rbx
140002c5a:     	callq	0x140003482 <.text+0x2482>
140002c5f:     	movq	%rdi, %r8
140002c62:     	movq	%rbx, %rdx
140002c65:     	movl	(%rax), %ecx
140002c67:     	callq	0x140001000 <.text>
140002c6c:     	movl	%eax, %ebx
140002c6e:     	callq	0x14000305c <.text+0x205c>
140002c73:     	testb	%al, %al
140002c75:     	je	0x140002ccc <.text+0x1ccc>
140002c77:     	testb	%sil, %sil
140002c7a:     	jne	0x140002c81 <.text+0x1c81>
140002c7c:     	callq	0x14000348e <.text+0x248e>
140002c81:     	xorl	%edx, %edx
140002c83:     	movb	$0x1, %cl
140002c85:     	callq	0x140002eb0 <.text+0x1eb0>
140002c8a:     	movl	%ebx, %eax
140002c8c:     	jmp	0x140002ca7 <.text+0x1ca7>
140002c8e:     	movl	%eax, %ebx
140002c90:     	callq	0x14000305c <.text+0x205c>
140002c95:     	testb	%al, %al
140002c97:     	je	0x140002cd4 <.text+0x1cd4>
140002c99:     	cmpb	$0x0, 0x20(%rsp)
140002c9e:     	jne	0x140002ca5 <.text+0x1ca5>
140002ca0:     	callq	0x140003494 <.text+0x2494>
140002ca5:     	movl	%ebx, %eax
140002ca7:     	movq	0x40(%rsp), %rbx
140002cac:     	movq	0x48(%rsp), %rsi
140002cb1:     	addq	$0x30, %rsp
140002cb5:     	popq	%rdi
140002cb6:     	retq
140002cb7:     	movl	$0x7, %ecx
140002cbc:     	callq	0x14000304c <.text+0x204c>
140002cc1:     	nop
140002cc2:     	movl	$0x7, %ecx
140002cc7:     	callq	0x14000304c <.text+0x204c>
140002ccc:     	movl	%ebx, %ecx
140002cce:     	callq	0x140003470 <.text+0x2470>
140002cd3:     	nop
140002cd4:     	movl	%ebx, %ecx
140002cd6:     	callq	0x140003476 <.text+0x2476>
140002cdb:     	nop
140002cdc:     	subq	$0x28, %rsp
140002ce0:     	callq	0x140002f30 <.text+0x1f30>
140002ce5:     	addq	$0x28, %rsp
140002ce9:     	jmp	0x140002b60 <.text+0x1b60>
140002cee:     	int3
140002cef:     	int3
140002cf0:     	subq	$0x28, %rsp
140002cf4:     	callq	0x140003430 <.text+0x2430>
140002cf9:     	testl	%eax, %eax
140002cfb:     	je	0x140002d1e <.text+0x1d1e>
140002cfd:     	movq	%gs:0x30, %rax
140002d06:     	movq	0x8(%rax), %rcx
140002d0a:     	jmp	0x140002d11 <.text+0x1d11>
140002d0c:     	cmpq	%rax, %rcx
140002d0f:     	je	0x140002d25 <.text+0x1d25>
140002d11:     	xorl	%eax, %eax
140002d13:     	lock
140002d14:     	cmpxchgq	%rcx, 0x3394(%rip)      # 0x1400060b0
140002d1c:     	jne	0x140002d0c <.text+0x1d0c>
140002d1e:     	xorb	%al, %al
140002d20:     	addq	$0x28, %rsp
140002d24:     	retq
140002d25:     	movb	$0x1, %al
140002d27:     	jmp	0x140002d20 <.text+0x1d20>
140002d29:     	int3
140002d2a:     	int3
140002d2b:     	int3
140002d2c:     	subq	$0x28, %rsp
140002d30:     	testl	%ecx, %ecx
140002d32:     	jne	0x140002d3b <.text+0x1d3b>
140002d34:     	movb	$0x1, 0x337d(%rip)      # 0x1400060b8
140002d3b:     	callq	0x140003194 <.text+0x2194>
140002d40:     	callq	0x140003004 <.text+0x2004>
140002d45:     	testb	%al, %al
140002d47:     	jne	0x140002d4d <.text+0x1d4d>
140002d49:     	xorb	%al, %al
140002d4b:     	jmp	0x140002d61 <.text+0x1d61>
140002d4d:     	callq	0x140003004 <.text+0x2004>
140002d52:     	testb	%al, %al
140002d54:     	jne	0x140002d5f <.text+0x1d5f>
140002d56:     	xorl	%ecx, %ecx
140002d58:     	callq	0x140003004 <.text+0x2004>
140002d5d:     	jmp	0x140002d49 <.text+0x1d49>
140002d5f:     	movb	$0x1, %al
140002d61:     	addq	$0x28, %rsp
140002d65:     	retq
140002d66:     	int3
140002d67:     	int3
140002d68:     	pushq	%rbx
140002d6a:     	subq	$0x20, %rsp
140002d6e:     	cmpb	$0x0, 0x3344(%rip)      # 0x1400060b9
140002d75:     	movl	%ecx, %ebx
140002d77:     	jne	0x140002de0 <.text+0x1de0>
140002d79:     	cmpl	$0x1, %ecx
140002d7c:     	ja	0x140002de8 <.text+0x1de8>
140002d7e:     	callq	0x140003430 <.text+0x2430>
140002d83:     	testl	%eax, %eax
140002d85:     	je	0x140002daf <.text+0x1daf>
140002d87:     	testl	%ebx, %ebx
140002d89:     	jne	0x140002daf <.text+0x1daf>
140002d8b:     	leaq	0x332e(%rip), %rcx      # 0x1400060c0
140002d92:     	callq	0x1400034b2 <.text+0x24b2>
140002d97:     	testl	%eax, %eax
140002d99:     	jne	0x140002dab <.text+0x1dab>
140002d9b:     	leaq	0x3336(%rip), %rcx      # 0x1400060d8
140002da2:     	callq	0x1400034b2 <.text+0x24b2>
140002da7:     	testl	%eax, %eax
140002da9:     	je	0x140002dd9 <.text+0x1dd9>
140002dab:     	xorb	%al, %al
140002dad:     	jmp	0x140002de2 <.text+0x1de2>
140002daf:     	movdqa	0x1af9(%rip), %xmm0     # 0x1400048b0
140002db7:     	orq	$-0x1, %rax
140002dbb:     	movdqu	%xmm0, 0x32fd(%rip)     # 0x1400060c0
140002dc3:     	movq	%rax, 0x3306(%rip)      # 0x1400060d0
140002dca:     	movdqu	%xmm0, 0x3306(%rip)     # 0x1400060d8
140002dd2:     	movq	%rax, 0x330f(%rip)      # 0x1400060e8
140002dd9:     	movb	$0x1, 0x32d9(%rip)      # 0x1400060b9
140002de0:     	movb	$0x1, %al
140002de2:     	addq	$0x20, %rsp
140002de6:     	popq	%rbx
140002de7:     	retq
140002de8:     	movl	$0x5, %ecx
140002ded:     	callq	0x14000304c <.text+0x204c>
140002df2:     	int3
140002df3:     	int3
140002df4:     	subq	$0x18, %rsp
140002df8:     	movq	%rcx, %r8
140002dfb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
140002e00:     	cmpw	%ax, -0x2e07(%rip)      # 0x140000000
140002e07:     	jne	0x140002e81 <.text+0x1e81>
140002e09:     	movslq	-0x2dd4(%rip), %rcx     # 0x14000003c
140002e10:     	leaq	-0x2e17(%rip), %rdx     # 0x140000000
140002e17:     	addq	%rdx, %rcx
140002e1a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
140002e20:     	jne	0x140002e81 <.text+0x1e81>
140002e22:     	movl	$0x20b, %eax            # imm = 0x20B
140002e27:     	cmpw	%ax, 0x18(%rcx)
140002e2b:     	jne	0x140002e81 <.text+0x1e81>
140002e2d:     	subq	%rdx, %r8
140002e30:     	movzwl	0x14(%rcx), %edx
140002e34:     	addq	$0x18, %rdx
140002e38:     	addq	%rcx, %rdx
140002e3b:     	movzwl	0x6(%rcx), %eax
140002e3f:     	leaq	(%rax,%rax,4), %rcx
140002e43:     	leaq	(%rdx,%rcx,8), %r9
140002e47:     	movq	%rdx, (%rsp)
140002e4b:     	cmpq	%r9, %rdx
140002e4e:     	je	0x140002e68 <.text+0x1e68>
140002e50:     	movl	0xc(%rdx), %ecx
140002e53:     	cmpq	%rcx, %r8
140002e56:     	jb	0x140002e62 <.text+0x1e62>
140002e58:     	movl	0x8(%rdx), %eax
140002e5b:     	addl	%ecx, %eax
140002e5d:     	cmpq	%rax, %r8
140002e60:     	jb	0x140002e6a <.text+0x1e6a>
140002e62:     	addq	$0x28, %rdx
140002e66:     	jmp	0x140002e47 <.text+0x1e47>
140002e68:     	xorl	%edx, %edx
140002e6a:     	testq	%rdx, %rdx
140002e6d:     	jne	0x140002e73 <.text+0x1e73>
140002e6f:     	xorb	%al, %al
140002e71:     	jmp	0x140002e87 <.text+0x1e87>
140002e73:     	cmpl	$0x0, 0x24(%rdx)
140002e77:     	jge	0x140002e7d <.text+0x1e7d>
140002e79:     	xorb	%al, %al
140002e7b:     	jmp	0x140002e87 <.text+0x1e87>
140002e7d:     	movb	$0x1, %al
140002e7f:     	jmp	0x140002e87 <.text+0x1e87>
140002e81:     	xorb	%al, %al
140002e83:     	jmp	0x140002e87 <.text+0x1e87>
140002e85:     	xorb	%al, %al
140002e87:     	addq	$0x18, %rsp
140002e8b:     	retq
140002e8c:     	pushq	%rbx
140002e8e:     	subq	$0x20, %rsp
140002e92:     	movb	%cl, %bl
140002e94:     	callq	0x140003430 <.text+0x2430>
140002e99:     	xorl	%edx, %edx
140002e9b:     	testl	%eax, %eax
140002e9d:     	je	0x140002eaa <.text+0x1eaa>
140002e9f:     	testb	%bl, %bl
140002ea1:     	jne	0x140002eaa <.text+0x1eaa>
140002ea3:     	xchgq	%rdx, 0x3206(%rip)      # 0x1400060b0
140002eaa:     	addq	$0x20, %rsp
140002eae:     	popq	%rbx
140002eaf:     	retq
140002eb0:     	pushq	%rbx
140002eb2:     	subq	$0x20, %rsp
140002eb6:     	cmpb	$0x0, 0x31fb(%rip)      # 0x1400060b8
140002ebd:     	movb	%cl, %bl
140002ebf:     	je	0x140002ec5 <.text+0x1ec5>
140002ec1:     	testb	%dl, %dl
140002ec3:     	jne	0x140002ed1 <.text+0x1ed1>
140002ec5:     	callq	0x140003004 <.text+0x2004>
140002eca:     	movb	%bl, %cl
140002ecc:     	callq	0x140003004 <.text+0x2004>
140002ed1:     	movb	$0x1, %al
140002ed3:     	addq	$0x20, %rsp
140002ed7:     	popq	%rbx
140002ed8:     	retq
140002ed9:     	int3
140002eda:     	int3
140002edb:     	int3
140002edc:     	pushq	%rbx
140002ede:     	subq	$0x20, %rsp
140002ee2:     	cmpq	$-0x1, 0x31d6(%rip)     # 0x1400060c0
140002eea:     	movq	%rcx, %rbx
140002eed:     	jne	0x140002ef6 <.text+0x1ef6>
140002eef:     	callq	0x1400034be <.text+0x24be>
140002ef4:     	jmp	0x140002f05 <.text+0x1f05>
140002ef6:     	movq	%rbx, %rdx
140002ef9:     	leaq	0x31c0(%rip), %rcx      # 0x1400060c0
140002f00:     	callq	0x1400034b8 <.text+0x24b8>
140002f05:     	xorl	%edx, %edx
140002f07:     	testl	%eax, %eax
140002f09:     	cmoveq	%rbx, %rdx
140002f0d:     	movq	%rdx, %rax
140002f10:     	addq	$0x20, %rsp
140002f14:     	popq	%rbx
140002f15:     	retq
140002f16:     	int3
140002f17:     	int3
140002f18:     	subq	$0x28, %rsp
140002f1c:     	callq	0x140002edc <.text+0x1edc>
140002f21:     	negq	%rax
140002f24:     	sbbl	%eax, %eax
140002f26:     	negl	%eax
140002f28:     	decl	%eax
140002f2a:     	addq	$0x28, %rsp
140002f2e:     	retq
140002f2f:     	int3
140002f30:     	movq	%rbx, 0x18(%rsp)
140002f35:     	pushq	%rbp
140002f36:     	movq	%rsp, %rbp
140002f39:     	subq	$0x30, %rsp
140002f3d:     	movq	0x30fc(%rip), %rax      # 0x140006040
140002f44:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
140002f4e:     	cmpq	%rbx, %rax
140002f51:     	jne	0x140002fca <.text+0x1fca>
140002f53:     	leaq	0x10(%rbp), %rcx
140002f57:     	movq	$0x0, 0x10(%rbp)
140002f5f:     	callq	*0x10cb(%rip)           # 0x140004030
140002f65:     	movq	0x10(%rbp), %rax
140002f69:     	movq	%rax, -0x10(%rbp)
140002f6d:     	callq	*0x108d(%rip)           # 0x140004000
140002f73:     	movl	%eax, %eax
140002f75:     	xorq	%rax, -0x10(%rbp)
140002f79:     	callq	*0x1089(%rip)           # 0x140004008
140002f7f:     	movl	%eax, %eax
140002f81:     	leaq	0x18(%rbp), %rcx
140002f85:     	xorq	%rax, -0x10(%rbp)
140002f89:     	callq	*0x1081(%rip)           # 0x140004010
140002f8f:     	movl	0x18(%rbp), %eax
140002f92:     	leaq	-0x10(%rbp), %rcx
140002f96:     	shlq	$0x20, %rax
140002f9a:     	xorq	0x18(%rbp), %rax
140002f9e:     	xorq	-0x10(%rbp), %rax
140002fa2:     	xorq	%rcx, %rax
140002fa5:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
140002faf:     	andq	%rcx, %rax
140002fb2:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
140002fbc:     	cmpq	%rbx, %rax
140002fbf:     	cmoveq	%rcx, %rax
140002fc3:     	movq	%rax, 0x3076(%rip)      # 0x140006040
140002fca:     	movq	0x50(%rsp), %rbx
140002fcf:     	notq	%rax
140002fd2:     	movq	%rax, 0x30a7(%rip)      # 0x140006080
140002fd9:     	addq	$0x30, %rsp
140002fdd:     	popq	%rbp
140002fde:     	retq
140002fdf:     	int3
140002fe0:     	xorl	%eax, %eax
140002fe2:     	retq
140002fe3:     	int3
140002fe4:     	movl	$0x1, %eax
140002fe9:     	retq
140002fea:     	int3
140002feb:     	int3
140002fec:     	movl	$0x4000, %eax           # imm = 0x4000
140002ff1:     	retq
140002ff2:     	int3
140002ff3:     	int3
140002ff4:     	leaq	0x30f5(%rip), %rcx      # 0x1400060f0
140002ffb:     	jmpq	*0x1016(%rip)           # 0x140004018
140003002:     	int3
140003003:     	int3
140003004:     	movb	$0x1, %al
140003006:     	retq
140003007:     	int3
140003008:     	retq	$0x0
14000300b:     	int3
14000300c:     	leaq	0x30ed(%rip), %rax      # 0x140006100
140003013:     	retq
140003014:     	subq	$0x28, %rsp
140003018:     	callq	0x140002a60 <.text+0x1a60>
14000301d:     	orq	$0x24, (%rax)
140003021:     	callq	0x14000300c <.text+0x200c>
140003026:     	orq	$0x2, (%rax)
14000302a:     	addq	$0x28, %rsp
14000302e:     	retq
14000302f:     	int3
140003030:     	xorl	%eax, %eax
140003032:     	cmpl	%eax, 0x2fd0(%rip)      # 0x140006008
140003038:     	sete	%al
14000303b:     	retq
14000303c:     	leaq	0x30dd(%rip), %rax      # 0x140006120
140003043:     	retq
140003044:     	leaq	0x30cd(%rip), %rax      # 0x140006118
14000304b:     	retq
14000304c:     	movl	%ecx, %ecx
14000304e:     	int	$0x29
140003050:     	retq
140003051:     	int3
140003052:     	int3
140003053:     	int3
140003054:     	jmp	0x140002fe0 <.text+0x1fe0>
140003059:     	int3
14000305a:     	int3
14000305b:     	int3
14000305c:     	subq	$0x28, %rsp
140003060:     	xorl	%ecx, %ecx
140003062:     	callq	*0xfc0(%rip)            # 0x140004028
140003068:     	testq	%rax, %rax
14000306b:     	je	0x1400030a7 <.text+0x20a7>
14000306d:     	movl	$0x5a4d, %ecx           # imm = 0x5A4D
140003072:     	cmpw	%cx, (%rax)
140003075:     	jne	0x1400030a7 <.text+0x20a7>
140003077:     	movslq	0x3c(%rax), %rcx
14000307b:     	cmpl	$0x4550, (%rcx,%rax)    # imm = 0x4550
140003082:     	jne	0x1400030a7 <.text+0x20a7>
140003084:     	movl	$0x20b, %edx            # imm = 0x20B
140003089:     	cmpw	%dx, 0x18(%rcx,%rax)
14000308e:     	jne	0x1400030a7 <.text+0x20a7>
140003090:     	cmpl	$0xe, 0x84(%rcx,%rax)
140003098:     	jbe	0x1400030a7 <.text+0x20a7>
14000309a:     	cmpl	$0x0, 0xf8(%rcx,%rax)
1400030a2:     	setne	%al
1400030a5:     	jmp	0x1400030a9 <.text+0x20a9>
1400030a7:     	xorb	%al, %al
1400030a9:     	addq	$0x28, %rsp
1400030ad:     	retq
1400030ae:     	int3
1400030af:     	int3
1400030b0:     	leaq	0x9(%rip), %rcx         # 0x1400030c0 <.text+0x20c0>
1400030b7:     	jmpq	*0xf62(%rip)            # 0x140004020
1400030be:     	int3
1400030bf:     	int3
1400030c0:     	movq	%rbx, 0x8(%rsp)
1400030c5:     	pushq	%rdi
1400030c6:     	subq	$0x20, %rsp
1400030ca:     	movq	(%rcx), %rbx
1400030cd:     	movq	%rcx, %rdi
1400030d0:     	cmpl	$0xe06d7363, (%rbx)     # imm = 0xE06D7363
1400030d6:     	jne	0x1400030f4 <.text+0x20f4>
1400030d8:     	cmpl	$0x4, 0x18(%rbx)
1400030dc:     	jne	0x1400030f4 <.text+0x20f4>
1400030de:     	movl	0x20(%rbx), %edx
1400030e1:     	leal	-0x19930520(%rdx), %eax
1400030e7:     	cmpl	$0x2, %eax
1400030ea:     	jbe	0x140003101 <.text+0x2101>
1400030ec:     	cmpl	$0x1994000, %edx        # imm = 0x1994000
1400030f2:     	je	0x140003101 <.text+0x2101>
1400030f4:     	movq	0x30(%rsp), %rbx
1400030f9:     	xorl	%eax, %eax
1400030fb:     	addq	$0x20, %rsp
1400030ff:     	popq	%rdi
140003100:     	retq
140003101:     	callq	0x1400034d0 <.text+0x24d0>
140003106:     	movq	%rbx, (%rax)
140003109:     	movq	0x8(%rdi), %rbx
14000310d:     	callq	0x1400034d6 <.text+0x24d6>
140003112:     	movq	%rbx, (%rax)
140003115:     	callq	0x1400034c4 <.text+0x24c4>
14000311a:     	int3
14000311b:     	int3
14000311c:     	movq	%rbx, 0x8(%rsp)
140003121:     	pushq	%rdi
140003122:     	subq	$0x20, %rsp
140003126:     	leaq	0x1c13(%rip), %rbx      # 0x140004d40
14000312d:     	leaq	0x1c0c(%rip), %rdi      # 0x140004d40
140003134:     	jmp	0x140003148 <.text+0x2148>
140003136:     	movq	(%rbx), %rax
140003139:     	testq	%rax, %rax
14000313c:     	je	0x140003144 <.text+0x2144>
14000313e:     	callq	*0x1064(%rip)           # 0x1400041a8
140003144:     	addq	$0x8, %rbx
140003148:     	cmpq	%rdi, %rbx
14000314b:     	jb	0x140003136 <.text+0x2136>
14000314d:     	movq	0x30(%rsp), %rbx
140003152:     	addq	$0x20, %rsp
140003156:     	popq	%rdi
140003157:     	retq
140003158:     	movq	%rbx, 0x8(%rsp)
14000315d:     	pushq	%rdi
14000315e:     	subq	$0x20, %rsp
140003162:     	leaq	0x1be7(%rip), %rbx      # 0x140004d50
140003169:     	leaq	0x1be0(%rip), %rdi      # 0x140004d50
140003170:     	jmp	0x140003184 <.text+0x2184>
140003172:     	movq	(%rbx), %rax
140003175:     	testq	%rax, %rax
140003178:     	je	0x140003180 <.text+0x2180>
14000317a:     	callq	*0x1028(%rip)           # 0x1400041a8
140003180:     	addq	$0x8, %rbx
140003184:     	cmpq	%rdi, %rbx
140003187:     	jb	0x140003172 <.text+0x2172>
140003189:     	movq	0x30(%rsp), %rbx
14000318e:     	addq	$0x20, %rsp
140003192:     	popq	%rdi
140003193:     	retq
140003194:     	movq	%rbx, 0x10(%rsp)
140003199:     	movq	%rbp, 0x18(%rsp)
14000319e:     	movq	%rsi, 0x20(%rsp)
1400031a3:     	pushq	%rdi
1400031a4:     	subq	$0x10, %rsp
1400031a8:     	xorl	%eax, %eax
1400031aa:     	xorl	%ecx, %ecx
1400031ac:     	cpuid
1400031ae:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
1400031b4:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
1400031ba:     	orl	%ecx, %edx
1400031bc:     	movl	%eax, %ebp
1400031be:     	movl	$0x1, %eax
1400031c3:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
1400031c9:     	orl	%ebx, %edx
1400031cb:     	leal	-0x1(%rax), %ecx
1400031ce:     	cpuid
1400031d0:     	movl	%ecx, %edi
1400031d2:     	jne	0x140003232 <.text+0x2232>
1400031d4:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
1400031d9:     	movq	$0x8000, 0x2e34(%rip)   # imm = 0x8000
                                                # 0x140006018
1400031e4:     	movq	$-0x1, 0x2e31(%rip)     # 0x140006020
1400031ef:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
1400031f4:     	je	0x14000321e <.text+0x221e>
1400031f6:     	cmpl	$0x20660, %eax          # imm = 0x20660
1400031fb:     	je	0x14000321e <.text+0x221e>
1400031fd:     	cmpl	$0x20670, %eax          # imm = 0x20670
140003202:     	je	0x14000321e <.text+0x221e>
140003204:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
140003209:     	cmpl	$0x20, %eax
14000320c:     	ja	0x140003232 <.text+0x2232>
14000320e:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
140003218:     	btq	%rax, %rcx
14000321c:     	jae	0x140003232 <.text+0x2232>
14000321e:     	movl	0x2ee7(%rip), %r8d      # 0x14000610c
140003225:     	orl	$0x1, %r8d
140003229:     	movl	%r8d, 0x2edc(%rip)      # 0x14000610c
140003230:     	jmp	0x140003239 <.text+0x2239>
140003232:     	movl	0x2ed3(%rip), %r8d      # 0x14000610c
140003239:     	xorl	%r9d, %r9d
14000323c:     	movl	%r9d, %r11d
14000323f:     	cmpl	$0x7, %ebp
140003242:     	jl	0x140003286 <.text+0x2286>
140003244:     	xorl	%ecx, %ecx
140003246:     	leal	0x7(%r9), %eax
14000324a:     	cpuid
14000324c:     	movl	%edx, %esi
14000324e:     	movl	%ebx, %r10d
140003251:     	btl	$0x9, %ebx
140003255:     	jae	0x140003262 <.text+0x2262>
140003257:     	orl	$0x2, %r8d
14000325b:     	movl	%r8d, 0x2eaa(%rip)      # 0x14000610c
140003262:     	cmpl	$0x1, %eax
140003265:     	jl	0x140003274 <.text+0x2274>
140003267:     	movl	$0x7, %eax
14000326c:     	leal	-0x6(%rax), %ecx
14000326f:     	cpuid
140003271:     	movl	%edx, %r9d
140003274:     	movl	$0x24, %eax
140003279:     	cmpl	%eax, %ebp
14000327b:     	jl	0x14000328c <.text+0x228c>
14000327d:     	xorl	%ecx, %ecx
14000327f:     	cpuid
140003281:     	movl	%ebx, %r11d
140003284:     	jmp	0x14000328c <.text+0x228c>
140003286:     	movl	%r9d, %r10d
140003289:     	movl	%r9d, %esi
14000328c:     	movq	0x2d95(%rip), %rax      # 0x140006028
140003293:     	andq	$-0x2, %rax
140003297:     	movl	$0x1, 0x2d6f(%rip)      # 0x140006010
1400032a1:     	movl	$0x2, 0x2d69(%rip)      # 0x140006014
1400032ab:     	movq	%rax, 0x2d76(%rip)      # 0x140006028
1400032b2:     	btl	$0x14, %edi
1400032b6:     	jae	0x1400032d7 <.text+0x22d7>
1400032b8:     	andq	$-0x11, %rax
1400032bc:     	movl	$0x2, 0x2d4a(%rip)      # 0x140006010
1400032c6:     	movq	%rax, 0x2d5b(%rip)      # 0x140006028
1400032cd:     	movl	$0x6, 0x2d3d(%rip)      # 0x140006014
1400032d7:     	btl	$0x1b, %edi
1400032db:     	jae	0x140003418 <.text+0x2418>
1400032e1:     	xorl	%ecx, %ecx
1400032e3:     	xgetbv
1400032e6:     	shlq	$0x20, %rdx
1400032ea:     	orq	%rax, %rdx
1400032ed:     	movq	%rdx, 0x20(%rsp)
1400032f2:     	btl	$0x1c, %edi
1400032f6:     	jae	0x1400033fc <.text+0x23fc>
1400032fc:     	movq	0x20(%rsp), %rax
140003301:     	andb	$0x6, %al
140003303:     	cmpb	$0x6, %al
140003305:     	jne	0x1400033fc <.text+0x23fc>
14000330b:     	movl	0x2d03(%rip), %eax      # 0x140006014
140003311:     	movb	$-0x20, %dl
140003313:     	orl	$0x8, %eax
140003316:     	movl	$0x3, 0x2cf0(%rip)      # 0x140006010
140003320:     	movl	%eax, 0x2cee(%rip)      # 0x140006014
140003326:     	testb	$0x20, %r10b
14000332a:     	je	0x14000338e <.text+0x238e>
14000332c:     	orl	$0x20, %eax
14000332f:     	movl	$0x5, 0x2cd7(%rip)      # 0x140006010
140003339:     	movl	%eax, 0x2cd5(%rip)      # 0x140006014
14000333f:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
140003344:     	movq	0x2cdd(%rip), %rax      # 0x140006028
14000334b:     	andl	%ecx, %r10d
14000334e:     	andq	$-0x3, %rax
140003352:     	movq	%rax, 0x2ccf(%rip)      # 0x140006028
140003359:     	cmpl	%ecx, %r10d
14000335c:     	jne	0x140003395 <.text+0x2395>
14000335e:     	movq	0x20(%rsp), %rax
140003363:     	andb	%dl, %al
140003365:     	cmpb	%dl, %al
140003367:     	jne	0x14000338e <.text+0x238e>
140003369:     	movq	0x2cb8(%rip), %rax      # 0x140006028
140003370:     	orl	$0x40, 0x2c9d(%rip)     # 0x140006014
140003377:     	andq	$-0x25, %rax
14000337b:     	movl	$0x6, 0x2c8b(%rip)      # 0x140006010
140003385:     	movq	%rax, 0x2c9c(%rip)      # 0x140006028
14000338c:     	jmp	0x140003395 <.text+0x2395>
14000338e:     	movq	0x2c93(%rip), %rax      # 0x140006028
140003395:     	btl	$0x17, %esi
140003399:     	jae	0x1400033a7 <.text+0x23a7>
14000339b:     	btrq	$0x18, %rax
1400033a0:     	movq	%rax, 0x2c81(%rip)      # 0x140006028
1400033a7:     	btl	$0x13, %r9d
1400033ac:     	jae	0x1400033fc <.text+0x23fc>
1400033ae:     	movq	0x20(%rsp), %rax
1400033b3:     	andb	%dl, %al
1400033b5:     	cmpb	%dl, %al
1400033b7:     	jne	0x1400033fc <.text+0x23fc>
1400033b9:     	movq	0x2c68(%rip), %rdx      # 0x140006028
1400033c0:     	movl	%r11d, %eax
1400033c3:     	shrq	$0x10, %rax
1400033c7:     	movl	%r11d, %ecx
1400033ca:     	andl	$0x6, %eax
1400033cd:     	andl	$0x400ff, %ecx          # imm = 0x400FF
1400033d3:     	orq	$0x1000029, %rax        # imm = 0x1000029
1400033d9:     	movl	%ecx, 0x2d31(%rip)      # 0x140006110
1400033df:     	notq	%rax
1400033e2:     	andq	%rax, %rdx
1400033e5:     	movq	%rdx, 0x2c3c(%rip)      # 0x140006028
1400033ec:     	cmpb	$0x1, %cl
1400033ef:     	jbe	0x1400033fc <.text+0x23fc>
1400033f1:     	andq	$-0x41, %rdx
1400033f5:     	movq	%rdx, 0x2c2c(%rip)      # 0x140006028
1400033fc:     	btl	$0x15, %r9d
140003401:     	jae	0x140003418 <.text+0x2418>
140003403:     	movq	0x20(%rsp), %rax
140003408:     	btq	$0x13, %rax
14000340d:     	jae	0x140003418 <.text+0x2418>
14000340f:     	btrq	$0x7, 0x2c10(%rip)      # 0x140006028
140003418:     	movq	0x28(%rsp), %rbx
14000341d:     	xorl	%eax, %eax
14000341f:     	movq	0x30(%rsp), %rbp
140003424:     	movq	0x38(%rsp), %rsi
140003429:     	addq	$0x10, %rsp
14000342d:     	popq	%rdi
14000342e:     	retq
14000342f:     	int3
140003430:     	xorl	%eax, %eax
140003432:     	cmpl	%eax, 0x2c58(%rip)      # 0x140006090
140003438:     	setne	%al
14000343b:     	retq
14000343c:     	int3
14000343d:     	int3
14000343e:     	int3
14000343f:     	int3
140003440:     	jmpq	*0xcd2(%rip)            # 0x140004118
140003446:     	jmpq	*0xc84(%rip)            # 0x1400040d0
14000344c:     	jmpq	*0xc56(%rip)            # 0x1400040a8
140003452:     	jmpq	*0xc90(%rip)            # 0x1400040e8
140003458:     	jmpq	*0xc6a(%rip)            # 0x1400040c8
14000345e:     	jmpq	*0xcbc(%rip)            # 0x140004120
140003464:     	jmpq	*0xca6(%rip)            # 0x140004110
14000346a:     	jmpq	*0xcb8(%rip)            # 0x140004128
140003470:     	jmpq	*0xc62(%rip)            # 0x1400040d8
140003476:     	jmpq	*0xc64(%rip)            # 0x1400040e0
14000347c:     	jmpq	*0xcee(%rip)            # 0x140004170
140003482:     	jmpq	*0xc68(%rip)            # 0x1400040f0
140003488:     	jmpq	*0xc6a(%rip)            # 0x1400040f8
14000348e:     	jmpq	*0xc6c(%rip)            # 0x140004100
140003494:     	jmpq	*0xc6e(%rip)            # 0x140004108
14000349a:     	jmpq	*0xcb0(%rip)            # 0x140004150
1400034a0:     	jmpq	*0xbf2(%rip)            # 0x140004098
1400034a6:     	jmpq	*0xbd4(%rip)            # 0x140004080
1400034ac:     	jmpq	*0xcb6(%rip)            # 0x140004168
1400034b2:     	jmpq	*0xc78(%rip)            # 0x140004130
1400034b8:     	jmpq	*0xc7a(%rip)            # 0x140004138
1400034be:     	jmpq	*0xc7c(%rip)            # 0x140004140
1400034c4:     	jmpq	*0xc7e(%rip)            # 0x140004148
1400034ca:     	jmpq	*0xb70(%rip)            # 0x140004040
1400034d0:     	jmpq	*0xb72(%rip)            # 0x140004048
1400034d6:     	jmpq	*0xb74(%rip)            # 0x140004050
1400034dc:     	jmpq	*0xb76(%rip)            # 0x140004058
1400034e2:     	int3
1400034e3:     	int3
1400034e4:     	int3
1400034e5:     	int3
1400034e6:     	int3
1400034e7:     	int3
1400034e8:     	int3
1400034e9:     	int3
1400034ea:     	int3
1400034eb:     	int3
1400034ec:     	int3
1400034ed:     	int3
1400034ee:     	int3
1400034ef:     	int3
1400034f0:     	int3
1400034f1:     	int3
1400034f2:     	int3
1400034f3:     	int3
1400034f4:     	int3
1400034f5:     	int3
1400034f6:     	nopw	(%rax,%rax)
140003500:     	jmpq	*%rax
140003502:     	int3
140003503:     	int3
140003504:     	int3
140003505:     	int3
140003506:     	int3
140003507:     	int3
140003508:     	int3
140003509:     	int3
14000350a:     	int3
14000350b:     	int3
14000350c:     	int3
14000350d:     	int3
14000350e:     	int3
14000350f:     	int3
140003510:     	int3
140003511:     	int3
140003512:     	int3
140003513:     	int3
140003514:     	int3
140003515:     	int3
140003516:     	nopw	(%rax,%rax)
140003520:     	jmpq	*0xc82(%rip)            # 0x1400041a8
140003526:     	pushq	%rbp
140003528:     	subq	$0x20, %rsp
14000352c:     	movq	%rdx, %rbp
14000352f:     	movq	%rcx, %rdx
140003532:     	movq	(%rcx), %rcx
140003535:     	movl	(%rcx), %ecx
140003537:     	callq	0x140003440 <.text+0x2440>
14000353c:     	nop
14000353d:     	addq	$0x20, %rsp
140003541:     	popq	%rbp
140003542:     	retq
140003543:     	int3
140003544:     	pushq	%rbp
140003546:     	movq	%rdx, %rbp
140003549:     	movq	(%rcx), %rax
14000354c:     	xorl	%ecx, %ecx
14000354e:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
140003554:     	sete	%cl
140003557:     	movl	%ecx, %eax
140003559:     	popq	%rbp
14000355a:     	retq
14000355b:     	int3
