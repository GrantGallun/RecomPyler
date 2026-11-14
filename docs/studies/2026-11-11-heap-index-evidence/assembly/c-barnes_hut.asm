
D:/Code/Datathon/recompyler-codex-20261111/wave5-study/results/bin/barnes_hut.exe:	file format coff-x86-64

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
14000100c:     	subq	$0x118, %rsp            # imm = 0x118
140001013:     	vmovapd	%xmm15, 0x100(%rsp)
14000101c:     	vmovapd	%xmm14, 0xf0(%rsp)
140001025:     	vmovapd	%xmm13, 0xe0(%rsp)
14000102e:     	vmovapd	%xmm12, 0xd0(%rsp)
140001037:     	vmovapd	%xmm11, 0xc0(%rsp)
140001040:     	vmovaps	%xmm10, 0xb0(%rsp)
140001049:     	vmovapd	%xmm9, 0xa0(%rsp)
140001052:     	vmovapd	%xmm8, 0x90(%rsp)
14000105b:     	vmovapd	%xmm7, 0x80(%rsp)
140001064:     	vmovaps	%xmm6, 0x70(%rsp)
14000106a:     	cmpl	$0x1, %ecx
14000106d:     	jle	0x1400010b0 <.text+0xb0>
14000106f:     	movq	0x8(%rdx), %rcx
140001073:     	callq	*0x2fef(%rip)           # 0x140004068
140001079:     	movl	$0x2bc0, %ecx           # imm = 0x2BC0
14000107e:     	movl	%eax, %esi
140001080:     	callq	*0x2ff2(%rip)           # 0x140004078
140001086:     	movq	%rax, 0x4013(%rip)      # 0x1400050a0
14000108d:     	movl	%esi, 0x2c(%rsp)
140001091:     	testl	%esi, %esi
140001093:     	jg	0x1400010ca <.text+0xca>
140001095:     	vmovsd	0x31a3(%rip), %xmm10    # 0x140004240
14000109d:     	vxorpd	%xmm8, %xmm8, %xmm8
1400010a2:     	vxorpd	%xmm9, %xmm9, %xmm9
1400010a7:     	vxorpd	%xmm7, %xmm7, %xmm7
1400010ab:     	jmp	0x140002357 <.text+0x1357>
1400010b0:     	movl	$0x2bc0, %ecx           # imm = 0x2BC0
1400010b5:     	callq	*0x2fbd(%rip)           # 0x140004078
1400010bb:     	movq	%rax, 0x3fde(%rip)      # 0x1400050a0
1400010c2:     	movl	$0xa, 0x2c(%rsp)
1400010ca:     	vmovsd	0x316e(%rip), %xmm10    # 0x140004240
1400010d2:     	vmovsd	0x318e(%rip), %xmm15    # 0x140004268
1400010da:     	vmovddup	0x31be(%rip), %xmm12    # xmm12 = mem[0,0]
                                                # 0x1400042a0
1400010e2:     	movq	0x30af(%rip), %r15      # 0x140004198
1400010e9:     	movq	0x2f90(%rip), %r13      # 0x140004080
1400010f0:     	leaq	0x48(%rsp), %rdi
1400010f5:     	leaq	0x68(%rsp), %rbx
1400010fa:     	xorl	%eax, %eax
1400010fc:     	vxorps	%xmm6, %xmm6, %xmm6
140001100:     	movq	%rax, 0x58(%rsp)
140001105:     	vmovsd	%xmm10, 0x60(%rsp)
14000110b:     	xorl	%esi, %esi
14000110d:     	xorl	%r14d, %r14d
140001110:     	vmovsd	0x3130(%rip), %xmm11    # 0x140004248
140001118:     	vmovsd	0x3130(%rip), %xmm10    # 0x140004250
140001120:     	vcvtsi2sd	%r14d, %xmm5, %xmm0
140001125:     	vmovsd	0x312b(%rip), %xmm14    # 0x140004258
14000112d:     	vdivsd	%xmm11, %xmm0, %xmm9
140001132:     	vmulsd	%xmm0, %xmm10, %xmm0
140001136:     	vdivsd	%xmm11, %xmm0, %xmm0
14000113b:     	vmulsd	%xmm11, %xmm9, %xmm1
140001140:     	vmulsd	%xmm0, %xmm14, %xmm7
140001144:     	vmovapd	%xmm1, 0x30(%rsp)
14000114a:     	vmovapd	%xmm7, %xmm0
14000114e:     	vzeroupper
140001151:     	callq	0x1400029b0 <.text+0x19b0>
140001156:     	vmovapd	%xmm0, %xmm8
14000115a:     	vmovapd	%xmm7, %xmm0
14000115e:     	callq	0x1400029b6 <.text+0x19b6>
140001163:     	vmovddup	0x30(%rsp), %xmm2       # xmm2 = mem[0,0]
140001169:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
14000116d:     	movq	0x3f2c(%rip), %rax      # 0x1400050a0
140001174:     	vmovsd	0x30e4(%rip), %xmm13    # 0x140004260
14000117c:     	movl	%r14d, %ecx
14000117f:     	orl	$0x1, %ecx
140001182:     	vmulpd	%xmm2, %xmm0, %xmm0
140001186:     	vaddpd	0x30e2(%rip), %xmm0, %xmm0 # 0x140004270
14000118e:     	vsubsd	%xmm9, %xmm13, %xmm1
140001193:     	vmulsd	%xmm1, %xmm15, %xmm1
140001197:     	vaddsd	%xmm1, %xmm15, %xmm1
14000119b:     	vmovupd	%xmm0, (%rax,%rsi)
1400011a0:     	vxorpd	%xmm0, %xmm0, %xmm0
1400011a4:     	vmovupd	%ymm0, 0x10(%rax,%rsi)
1400011aa:     	vcvtsi2sd	%ecx, %xmm5, %xmm0
1400011ae:     	vmovsd	%xmm1, 0x30(%rax,%rsi)
1400011b4:     	vdivsd	%xmm11, %xmm0, %xmm9
1400011b9:     	vmulsd	%xmm0, %xmm10, %xmm0
1400011bd:     	vdivsd	%xmm11, %xmm0, %xmm0
1400011c2:     	vmulsd	%xmm11, %xmm9, %xmm1
1400011c7:     	vmulsd	%xmm0, %xmm14, %xmm7
1400011cb:     	vmovapd	%xmm1, 0x30(%rsp)
1400011d1:     	vmovapd	%xmm7, %xmm0
1400011d5:     	vzeroupper
1400011d8:     	callq	0x1400029b0 <.text+0x19b0>
1400011dd:     	vmovapd	%xmm0, %xmm8
1400011e1:     	vmovapd	%xmm7, %xmm0
1400011e5:     	callq	0x1400029b6 <.text+0x19b6>
1400011ea:     	vmovddup	0x30(%rsp), %xmm2       # xmm2 = mem[0,0]
1400011f0:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
1400011f4:     	movq	0x3ea5(%rip), %rax      # 0x1400050a0
1400011fb:     	movl	%r14d, %ecx
1400011fe:     	orl	$0x2, %ecx
140001201:     	vsubsd	%xmm9, %xmm13, %xmm1
140001206:     	vmulsd	%xmm1, %xmm15, %xmm1
14000120a:     	vaddsd	%xmm1, %xmm15, %xmm1
14000120e:     	vmulpd	%xmm2, %xmm0, %xmm0
140001212:     	vaddpd	0x3056(%rip), %xmm0, %xmm0 # 0x140004270
14000121a:     	vmovupd	%xmm0, 0x38(%rax,%rsi)
140001220:     	vxorpd	%xmm0, %xmm0, %xmm0
140001224:     	vmovupd	%ymm0, 0x48(%rax,%rsi)
14000122a:     	vcvtsi2sd	%ecx, %xmm5, %xmm0
14000122e:     	vmovsd	%xmm1, 0x68(%rax,%rsi)
140001234:     	vdivsd	%xmm11, %xmm0, %xmm9
140001239:     	vmulsd	%xmm0, %xmm10, %xmm0
14000123d:     	vdivsd	%xmm11, %xmm0, %xmm0
140001242:     	vmulsd	%xmm11, %xmm9, %xmm1
140001247:     	vmulsd	%xmm0, %xmm14, %xmm7
14000124b:     	vmovapd	%xmm1, 0x30(%rsp)
140001251:     	vmovapd	%xmm7, %xmm0
140001255:     	vzeroupper
140001258:     	callq	0x1400029b0 <.text+0x19b0>
14000125d:     	vmovapd	%xmm0, %xmm8
140001261:     	vmovapd	%xmm7, %xmm0
140001265:     	callq	0x1400029b6 <.text+0x19b6>
14000126a:     	vmovddup	0x30(%rsp), %xmm2       # xmm2 = mem[0,0]
140001270:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
140001274:     	movq	0x3e25(%rip), %rax      # 0x1400050a0
14000127b:     	movl	%r14d, %ecx
14000127e:     	orl	$0x3, %ecx
140001281:     	vsubsd	%xmm9, %xmm13, %xmm1
140001286:     	vmulsd	%xmm1, %xmm15, %xmm1
14000128a:     	vaddsd	%xmm1, %xmm15, %xmm1
14000128e:     	vmulpd	%xmm2, %xmm0, %xmm0
140001292:     	vaddpd	0x2fd6(%rip), %xmm0, %xmm0 # 0x140004270
14000129a:     	vmovupd	%xmm0, 0x70(%rax,%rsi)
1400012a0:     	vxorpd	%xmm0, %xmm0, %xmm0
1400012a4:     	vmovupd	%ymm0, 0x80(%rax,%rsi)
1400012ad:     	vcvtsi2sd	%ecx, %xmm5, %xmm0
1400012b1:     	vmovsd	%xmm1, 0xa0(%rax,%rsi)
1400012ba:     	vdivsd	%xmm11, %xmm0, %xmm9
1400012bf:     	vmulsd	%xmm0, %xmm10, %xmm0
1400012c3:     	vdivsd	%xmm11, %xmm0, %xmm0
1400012c8:     	vmulsd	%xmm11, %xmm9, %xmm1
1400012cd:     	vmulsd	%xmm0, %xmm14, %xmm7
1400012d1:     	vmovapd	%xmm1, 0x30(%rsp)
1400012d7:     	vmovapd	%xmm7, %xmm0
1400012db:     	vzeroupper
1400012de:     	callq	0x1400029b0 <.text+0x19b0>
1400012e3:     	vmovapd	%xmm0, %xmm8
1400012e7:     	vmovapd	%xmm7, %xmm0
1400012eb:     	callq	0x1400029b6 <.text+0x19b6>
1400012f0:     	vmovddup	0x30(%rsp), %xmm2       # xmm2 = mem[0,0]
1400012f6:     	vmovapd	0x2f72(%rip), %xmm3     # 0x140004270
1400012fe:     	vsubsd	%xmm9, %xmm13, %xmm1
140001303:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
140001307:     	movq	0x3d92(%rip), %rax      # 0x1400050a0
14000130e:     	addq	$0x4, %r14
140001312:     	vmulsd	%xmm1, %xmm15, %xmm1
140001316:     	vaddsd	%xmm1, %xmm15, %xmm1
14000131a:     	vmulpd	%xmm2, %xmm0, %xmm0
14000131e:     	vxorpd	%xmm2, %xmm2, %xmm2
140001322:     	vaddpd	%xmm3, %xmm0, %xmm0
140001326:     	vmovupd	%xmm0, 0xa8(%rax,%rsi)
14000132f:     	vmovupd	%ymm2, 0xb8(%rax,%rsi)
140001338:     	vmovsd	%xmm1, 0xd8(%rax,%rsi)
140001341:     	addq	$0xe0, %rsi
140001348:     	cmpq	$0x3c, %r14
14000134c:     	jne	0x140001110 <.text+0x110>
140001352:     	vmovsd	0x2f06(%rip), %xmm14    # 0x140004260
14000135a:     	vmovsd	0x2f1e(%rip), %xmm1     # 0x140004280
140001362:     	vmovsd	0x2f1e(%rip), %xmm2     # 0x140004288
14000136a:     	vmovsd	0x2f1e(%rip), %xmm4     # 0x140004290
140001372:     	vmovsd	0x2f1e(%rip), %xmm3     # 0x140004298
14000137a:     	vmovsd	0x2f1e(%rip), %xmm13    # 0x1400042a0
140001382:     	movl	$0x1, %esi
140001387:     	vxorpd	%xmm9, %xmm9, %xmm9
14000138c:     	xorl	%r14d, %r14d
14000138f:     	nop
140001390:     	vdivsd	%xmm1, %xmm9, %xmm10
140001394:     	vxorpd	%xmm1, %xmm1, %xmm1
140001398:     	vmovapd	%xmm4, %xmm15
14000139c:     	vmulsd	%xmm2, %xmm10, %xmm0
1400013a0:     	vaddsd	%xmm4, %xmm0, %xmm0
1400013a4:     	vmulsd	%xmm3, %xmm0, %xmm11
1400013a8:     	vmulsd	%xmm13, %xmm11, %xmm0
1400013ad:     	vaddsd	%xmm1, %xmm0, %xmm7
1400013b1:     	vmulsd	%xmm13, %xmm9, %xmm0
1400013b6:     	vzeroupper
1400013b9:     	callq	0x1400029b6 <.text+0x19b6>
1400013be:     	vmulsd	%xmm0, %xmm15, %xmm0
1400013c2:     	vaddsd	%xmm7, %xmm0, %xmm7
1400013c6:     	vmovapd	%xmm7, %xmm0
1400013ca:     	callq	0x1400029b0 <.text+0x19b0>
1400013cf:     	vmovapd	%xmm0, %xmm8
1400013d3:     	vmovapd	%xmm7, %xmm0
1400013d7:     	callq	0x1400029b6 <.text+0x19b6>
1400013dc:     	vmovddup	%xmm11, %xmm2           # xmm2 = xmm11[0,0]
1400013e1:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
1400013e5:     	movq	0x3cb4(%rip), %rax      # 0x1400050a0
1400013ec:     	vsubsd	%xmm10, %xmm14, %xmm1
1400013f1:     	vmulsd	0x2eaf(%rip), %xmm1, %xmm1 # 0x1400042a8
1400013f9:     	vmulpd	%xmm2, %xmm0, %xmm0
1400013fd:     	vaddpd	0x2e6b(%rip), %xmm0, %xmm0 # 0x140004270
140001405:     	vxorpd	%xmm2, %xmm2, %xmm2
140001409:     	vaddsd	%xmm1, %xmm14, %xmm1
14000140d:     	vmovupd	%xmm0, 0xd20(%rax,%r14)
140001417:     	vxorpd	%xmm0, %xmm0, %xmm0
14000141b:     	vmovupd	%ymm0, 0xd30(%rax,%r14)
140001425:     	vcvtsi2sd	%esi, %xmm31, %xmm0
14000142b:     	vdivsd	0x2e4d(%rip), %xmm0, %xmm10 # 0x140004280
140001433:     	vmovsd	%xmm1, 0xd50(%rax,%r14)
14000143d:     	vmulsd	%xmm0, %xmm13, %xmm0
140001441:     	vmulsd	0x2e3f(%rip), %xmm10, %xmm1 # 0x140004288
140001449:     	vaddsd	%xmm1, %xmm15, %xmm1
14000144d:     	vmulsd	0x2e43(%rip), %xmm1, %xmm11 # 0x140004298
140001455:     	vmulsd	%xmm13, %xmm11, %xmm1
14000145a:     	vaddsd	%xmm2, %xmm1, %xmm7
14000145e:     	vzeroupper
140001461:     	callq	0x1400029b6 <.text+0x19b6>
140001466:     	vmulsd	%xmm0, %xmm15, %xmm0
14000146a:     	vaddsd	%xmm7, %xmm0, %xmm7
14000146e:     	vmovapd	%xmm7, %xmm0
140001472:     	callq	0x1400029b0 <.text+0x19b0>
140001477:     	vmovapd	%xmm0, %xmm8
14000147b:     	vmovapd	%xmm7, %xmm0
14000147f:     	callq	0x1400029b6 <.text+0x19b6>
140001484:     	vmovsd	0x2e1c(%rip), %xmm2     # 0x1400042a8
14000148c:     	vsubsd	%xmm10, %xmm14, %xmm1
140001491:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
140001495:     	movq	0x3c04(%rip), %rax      # 0x1400050a0
14000149c:     	vmovsd	0x2e0c(%rip), %xmm5     # 0x1400042b0
1400014a4:     	vxorpd	%xmm3, %xmm3, %xmm3
1400014a8:     	addl	$0x2, %esi
1400014ab:     	vmovapd	%xmm15, %xmm4
1400014af:     	vmulsd	%xmm2, %xmm1, %xmm1
1400014b3:     	vmovddup	%xmm11, %xmm2           # xmm2 = xmm11[0,0]
1400014b8:     	vaddsd	%xmm5, %xmm9, %xmm9
1400014bc:     	vmulpd	%xmm2, %xmm0, %xmm0
1400014c0:     	vaddpd	0x2da8(%rip), %xmm0, %xmm0 # 0x140004270
1400014c8:     	vmovsd	0x2db8(%rip), %xmm2     # 0x140004288
1400014d0:     	vaddsd	%xmm1, %xmm14, %xmm1
1400014d4:     	vmovupd	%xmm0, 0xd58(%rax,%r14)
1400014de:     	vmovupd	%ymm3, 0xd68(%rax,%r14)
1400014e8:     	vmovsd	%xmm1, 0xd88(%rax,%r14)
1400014f2:     	vmovsd	0x2d9e(%rip), %xmm3     # 0x140004298
1400014fa:     	vmovsd	0x2d7e(%rip), %xmm1     # 0x140004280
140001502:     	addq	$0x70, %r14
140001506:     	cmpl	$0x47, %esi
140001509:     	jne	0x140001390 <.text+0x390>
14000150f:     	movl	$0x1, %esi
140001514:     	vxorpd	%xmm9, %xmm9, %xmm9
140001519:     	xorl	%r14d, %r14d
14000151c:     	nopl	(%rax)
140001520:     	vdivsd	%xmm1, %xmm9, %xmm11
140001524:     	vmovsd	0x2d8c(%rip), %xmm1     # 0x1400042b8
14000152c:     	vmulsd	%xmm2, %xmm11, %xmm0
140001530:     	vaddsd	%xmm4, %xmm0, %xmm0
140001534:     	vmulsd	%xmm3, %xmm0, %xmm10
140001538:     	vmulsd	%xmm13, %xmm10, %xmm0
14000153d:     	vaddsd	%xmm1, %xmm0, %xmm7
140001541:     	vmulsd	%xmm13, %xmm9, %xmm0
140001546:     	vzeroupper
140001549:     	callq	0x1400029b6 <.text+0x19b6>
14000154e:     	vmulsd	%xmm0, %xmm15, %xmm0
140001552:     	vaddsd	%xmm7, %xmm0, %xmm7
140001556:     	vmovapd	%xmm7, %xmm0
14000155a:     	callq	0x1400029b0 <.text+0x19b0>
14000155f:     	vmovapd	%xmm0, %xmm8
140001563:     	vmovapd	%xmm7, %xmm0
140001567:     	callq	0x1400029b6 <.text+0x19b6>
14000156c:     	vmovddup	%xmm10, %xmm2           # xmm2 = xmm10[0,0]
140001571:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
140001575:     	movq	0x3b24(%rip), %rax      # 0x1400050a0
14000157c:     	vsubsd	%xmm11, %xmm14, %xmm1
140001581:     	vmulsd	0x2d1f(%rip), %xmm1, %xmm1 # 0x1400042a8
140001589:     	vmulpd	%xmm2, %xmm0, %xmm0
14000158d:     	vaddpd	0x2cdb(%rip), %xmm0, %xmm0 # 0x140004270
140001595:     	vaddsd	%xmm1, %xmm14, %xmm1
140001599:     	vmovupd	%xmm0, 0x1c70(%rax,%r14)
1400015a3:     	vxorpd	%xmm0, %xmm0, %xmm0
1400015a7:     	vmovupd	%ymm0, 0x1c80(%rax,%r14)
1400015b1:     	vcvtsi2sd	%esi, %xmm31, %xmm0
1400015b7:     	vdivsd	0x2cc1(%rip), %xmm0, %xmm10 # 0x140004280
1400015bf:     	vmovsd	%xmm1, 0x1ca0(%rax,%r14)
1400015c9:     	vmulsd	%xmm0, %xmm13, %xmm0
1400015cd:     	vmulsd	0x2cb3(%rip), %xmm10, %xmm1 # 0x140004288
1400015d5:     	vaddsd	%xmm1, %xmm15, %xmm1
1400015d9:     	vmulsd	0x2cb7(%rip), %xmm1, %xmm11 # 0x140004298
1400015e1:     	vmulsd	%xmm13, %xmm11, %xmm1
1400015e6:     	vaddsd	0x2cca(%rip), %xmm1, %xmm7 # 0x1400042b8
1400015ee:     	vzeroupper
1400015f1:     	callq	0x1400029b6 <.text+0x19b6>
1400015f6:     	vmulsd	%xmm0, %xmm15, %xmm0
1400015fa:     	vaddsd	%xmm7, %xmm0, %xmm7
1400015fe:     	vmovapd	%xmm7, %xmm0
140001602:     	callq	0x1400029b0 <.text+0x19b0>
140001607:     	vmovapd	%xmm0, %xmm8
14000160b:     	vmovapd	%xmm7, %xmm0
14000160f:     	callq	0x1400029b6 <.text+0x19b6>
140001614:     	vsubsd	%xmm10, %xmm14, %xmm1
140001619:     	vmulsd	0x2c87(%rip), %xmm1, %xmm1 # 0x1400042a8
140001621:     	vmovddup	%xmm11, %xmm2           # xmm2 = xmm11[0,0]
140001626:     	vunpcklpd	%xmm0, %xmm8, %xmm0 # xmm0 = xmm8[0],xmm0[0]
14000162a:     	movq	0x3a6f(%rip), %rax      # 0x1400050a0
140001631:     	vaddsd	0x2c77(%rip), %xmm9, %xmm9 # 0x1400042b0
140001639:     	vxorpd	%xmm3, %xmm3, %xmm3
14000163d:     	addl	$0x2, %esi
140001640:     	vmovapd	%xmm15, %xmm4
140001644:     	vmulpd	%xmm2, %xmm0, %xmm0
140001648:     	vaddpd	0x2c20(%rip), %xmm0, %xmm0 # 0x140004270
140001650:     	vmovsd	0x2c30(%rip), %xmm2     # 0x140004288
140001658:     	vaddsd	%xmm1, %xmm14, %xmm1
14000165c:     	vmovupd	%xmm0, 0x1ca8(%rax,%r14)
140001666:     	vmovupd	%ymm3, 0x1cb8(%rax,%r14)
140001670:     	vmovsd	0x2c20(%rip), %xmm3     # 0x140004298
140001678:     	vmovsd	%xmm1, 0x1cd8(%rax,%r14)
140001682:     	vmovsd	0x2bf6(%rip), %xmm1     # 0x140004280
14000168a:     	addq	$0x70, %r14
14000168e:     	cmpl	$0x47, %esi
140001691:     	jne	0x140001520 <.text+0x520>
140001697:     	vmovapd	0x2c21(%rip), %xmm10    # 0x1400042c0
14000169f:     	vmovddup	0x2c29(%rip), %xmm14    # xmm14 = mem[0,0]
                                                # 0x1400042d0
1400016a7:     	vmovsd	0x2c29(%rip), %xmm15    # 0x1400042d8
1400016af:     	xorl	%esi, %esi
1400016b1:     	vxorpd	%xmm9, %xmm9, %xmm9
1400016b6:     	jmp	0x140001712 <.text+0x712>
1400016b8:     	nopl	(%rax,%rax)
1400016c0:     	vzeroupper
1400016c3:     	callq	0x1400029bc <.text+0x19bc>
1400016c8:     	vshufpd	$0x1, %xmm7, %xmm7, %xmm1 # xmm1 = xmm7[1,0]
1400016cd:     	vmovddup	%xmm8, %xmm2            # xmm2 = xmm8[0,0]
1400016d2:     	vmulsd	0x2c06(%rip), %xmm0, %xmm0 # 0x1400042e0
1400016da:     	movq	0x39bf(%rip), %rax      # 0x1400050a0
1400016e1:     	vxorpd	%xmm1, %xmm14, %xmm1
1400016e5:     	vunpcklpd	%xmm7, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm7[0]
1400016e9:     	vdivpd	%xmm2, %xmm1, %xmm1
1400016ed:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
1400016f1:     	vmulpd	%xmm0, %xmm1, %xmm0
1400016f5:     	vmovupd	%xmm0, 0xb8(%rax,%rsi)
1400016fe:     	addq	$0xe0, %rsi
140001705:     	cmpq	$0x2bc0, %rsi           # imm = 0x2BC0
14000170c:     	je	0x1400018b0 <.text+0x8b0>
140001712:     	vaddpd	(%rax,%rsi), %xmm10, %xmm7
140001717:     	vmulpd	%xmm7, %xmm7, %xmm0
14000171b:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
140001720:     	vaddsd	%xmm1, %xmm0, %xmm0
140001724:     	vucomisd	%xmm9, %xmm0
140001729:     	jbe	0x14000178b <.text+0x78b>
14000172b:     	vsqrtsd	%xmm0, %xmm0, %xmm8
14000172f:     	vaddsd	%xmm15, %xmm8, %xmm0
140001734:     	vmulsd	%xmm0, %xmm13, %xmm0
140001738:     	vucomisd	%xmm9, %xmm0
14000173d:     	jb	0x140001750 <.text+0x750>
14000173f:     	vsqrtsd	%xmm0, %xmm0, %xmm0
140001743:     	jmp	0x140001758 <.text+0x758>
140001745:     	nopw	%cs:(%rax,%rax)
140001750:     	vzeroupper
140001753:     	callq	0x1400029bc <.text+0x19bc>
140001758:     	vshufpd	$0x1, %xmm7, %xmm7, %xmm1 # xmm1 = xmm7[1,0]
14000175d:     	vmovddup	%xmm8, %xmm2            # xmm2 = xmm8[0,0]
140001762:     	vmulsd	0x2b76(%rip), %xmm0, %xmm0 # 0x1400042e0
14000176a:     	movq	0x392f(%rip), %rax      # 0x1400050a0
140001771:     	vxorpd	%xmm1, %xmm14, %xmm1
140001775:     	vunpcklpd	%xmm7, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm7[0]
140001779:     	vdivpd	%xmm2, %xmm1, %xmm1
14000177d:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
140001781:     	vmulpd	%xmm0, %xmm1, %xmm0
140001785:     	vmovupd	%xmm0, 0x10(%rax,%rsi)
14000178b:     	vaddpd	0x38(%rax,%rsi), %xmm10, %xmm7
140001791:     	vmulpd	%xmm7, %xmm7, %xmm0
140001795:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
14000179a:     	vaddsd	%xmm1, %xmm0, %xmm0
14000179e:     	vucomisd	%xmm9, %xmm0
1400017a3:     	jbe	0x1400017fb <.text+0x7fb>
1400017a5:     	vsqrtsd	%xmm0, %xmm0, %xmm8
1400017a9:     	vaddsd	%xmm15, %xmm8, %xmm0
1400017ae:     	vmulsd	%xmm0, %xmm13, %xmm0
1400017b2:     	vucomisd	%xmm9, %xmm0
1400017b7:     	jb	0x1400017c0 <.text+0x7c0>
1400017b9:     	vsqrtsd	%xmm0, %xmm0, %xmm0
1400017bd:     	jmp	0x1400017c8 <.text+0x7c8>
1400017bf:     	nop
1400017c0:     	vzeroupper
1400017c3:     	callq	0x1400029bc <.text+0x19bc>
1400017c8:     	vshufpd	$0x1, %xmm7, %xmm7, %xmm1 # xmm1 = xmm7[1,0]
1400017cd:     	vmovddup	%xmm8, %xmm2            # xmm2 = xmm8[0,0]
1400017d2:     	vmulsd	0x2b06(%rip), %xmm0, %xmm0 # 0x1400042e0
1400017da:     	movq	0x38bf(%rip), %rax      # 0x1400050a0
1400017e1:     	vxorpd	%xmm1, %xmm14, %xmm1
1400017e5:     	vunpcklpd	%xmm7, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm7[0]
1400017e9:     	vdivpd	%xmm2, %xmm1, %xmm1
1400017ed:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
1400017f1:     	vmulpd	%xmm0, %xmm1, %xmm0
1400017f5:     	vmovupd	%xmm0, 0x48(%rax,%rsi)
1400017fb:     	vaddpd	0x70(%rax,%rsi), %xmm10, %xmm7
140001801:     	vmulpd	%xmm7, %xmm7, %xmm0
140001805:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
14000180a:     	vaddsd	%xmm1, %xmm0, %xmm0
14000180e:     	vucomisd	%xmm9, %xmm0
140001813:     	jbe	0x14000186e <.text+0x86e>
140001815:     	vsqrtsd	%xmm0, %xmm0, %xmm8
140001819:     	vaddsd	%xmm15, %xmm8, %xmm0
14000181e:     	vmulsd	%xmm0, %xmm13, %xmm0
140001822:     	vucomisd	%xmm9, %xmm0
140001827:     	jb	0x140001830 <.text+0x830>
140001829:     	vsqrtsd	%xmm0, %xmm0, %xmm0
14000182d:     	jmp	0x140001838 <.text+0x838>
14000182f:     	nop
140001830:     	vzeroupper
140001833:     	callq	0x1400029bc <.text+0x19bc>
140001838:     	vshufpd	$0x1, %xmm7, %xmm7, %xmm1 # xmm1 = xmm7[1,0]
14000183d:     	vmovddup	%xmm8, %xmm2            # xmm2 = xmm8[0,0]
140001842:     	vmulsd	0x2a96(%rip), %xmm0, %xmm0 # 0x1400042e0
14000184a:     	movq	0x384f(%rip), %rax      # 0x1400050a0
140001851:     	vxorpd	%xmm1, %xmm14, %xmm1
140001855:     	vunpcklpd	%xmm7, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm7[0]
140001859:     	vdivpd	%xmm2, %xmm1, %xmm1
14000185d:     	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
140001861:     	vmulpd	%xmm0, %xmm1, %xmm0
140001865:     	vmovupd	%xmm0, 0x80(%rax,%rsi)
14000186e:     	vaddpd	0xa8(%rax,%rsi), %xmm10, %xmm7
140001877:     	vmulpd	%xmm7, %xmm7, %xmm0
14000187b:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
140001880:     	vaddsd	%xmm1, %xmm0, %xmm0
140001884:     	vucomisd	%xmm9, %xmm0
140001889:     	jbe	0x1400016fe <.text+0x6fe>
14000188f:     	vsqrtsd	%xmm0, %xmm0, %xmm8
140001893:     	vaddsd	%xmm15, %xmm8, %xmm0
140001898:     	vmulsd	%xmm0, %xmm13, %xmm0
14000189c:     	vucomisd	%xmm9, %xmm0
1400018a1:     	jb	0x1400016c0 <.text+0x6c0>
1400018a7:     	vsqrtsd	%xmm0, %xmm0, %xmm0
1400018ab:     	jmp	0x1400016c8 <.text+0x6c8>
1400018b0:     	vmovsd	0x60(%rsp), %xmm10
1400018b6:     	vmovsd	0x2a32(%rip), %xmm9     # 0x1400042f0
1400018be:     	vmovsd	0x2a22(%rip), %xmm13    # 0x1400042e8
1400018c6:     	vmovsd	0x2a2a(%rip), %xmm14    # 0x1400042f8
1400018ce:     	leaq	0x68(%rax), %rcx
1400018d2:     	movl	$0x1, %edx
1400018d7:     	vxorpd	%xmm7, %xmm7, %xmm7
1400018db:     	xorl	%r8d, %r8d
1400018de:     	jmp	0x1400018f7 <.text+0x8f7>
1400018e0:     	incq	%r8
1400018e3:     	incq	%rdx
1400018e6:     	addq	$0x38, %rcx
1400018ea:     	cmpq	$0xc8, %r8
1400018f1:     	je	0x140001a70 <.text+0xa70>
1400018f7:     	cmpq	$0xc6, %r8
1400018fe:     	ja	0x1400018e0 <.text+0x8e0>
140001900:     	imulq	$0x38, %r8, %r9
140001904:     	movl	%r8d, %r10d
140001907:     	andl	$0x3, %r10d
14000190b:     	vmulsd	0x30(%rax,%r9), %xmm13, %xmm1
140001912:     	vmovupd	(%rax,%r9), %xmm0
140001918:     	cmpq	$0x3, %r10
14000191c:     	jne	0x140001930 <.text+0x930>
14000191e:     	movq	%rdx, %r9
140001921:     	leaq	-0xc4(%r8), %r10
140001928:     	cmpq	$0x3, %r10
14000192c:     	jb	0x1400018e0 <.text+0x8e0>
14000192e:     	jmp	0x14000198f <.text+0x98f>
140001930:     	movl	$0x1, %r9d
140001936:     	movq	%rcx, %r11
140001939:     	nopl	(%rax)
140001940:     	vsubpd	-0x30(%r11), %xmm0, %xmm2
140001946:     	movq	%r10, %rsi
140001949:     	xorq	%r9, %rsi
14000194c:     	incq	%r9
14000194f:     	vmulpd	%xmm2, %xmm2, %xmm2
140001953:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140001958:     	vaddsd	%xmm3, %xmm2, %xmm2
14000195c:     	vmulsd	(%r11), %xmm1, %xmm3
140001961:     	addq	$0x38, %r11
140001965:     	vsqrtsd	%xmm2, %xmm2, %xmm2
140001969:     	vmaxsd	%xmm2, %xmm9, %xmm2
14000196d:     	vdivsd	%xmm2, %xmm3, %xmm2
140001971:     	vsubsd	%xmm2, %xmm7, %xmm7
140001975:     	cmpq	$0x3, %rsi
140001979:     	jne	0x140001940 <.text+0x940>
14000197b:     	addq	%r8, %r9
14000197e:     	leaq	-0xc4(%r8), %r10
140001985:     	cmpq	$0x3, %r10
140001989:     	jb	0x1400018e0 <.text+0x8e0>
14000198f:     	imulq	$0x38, %r9, %r10
140001993:     	addq	$-0xc8, %r9
14000199a:     	addq	%rax, %r10
14000199d:     	nopl	(%rax)
1400019a0:     	vsubpd	(%r10), %xmm0, %xmm2
1400019a5:     	vmulpd	%xmm2, %xmm2, %xmm2
1400019a9:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
1400019ae:     	vaddsd	%xmm3, %xmm2, %xmm2
1400019b2:     	vmulsd	0x30(%r10), %xmm1, %xmm3
1400019b8:     	vsqrtsd	%xmm2, %xmm2, %xmm2
1400019bc:     	vmaxsd	%xmm2, %xmm9, %xmm2
1400019c0:     	vdivsd	%xmm2, %xmm3, %xmm2
1400019c4:     	vsubpd	0x38(%r10), %xmm0, %xmm3
1400019ca:     	vmulpd	%xmm3, %xmm3, %xmm3
1400019ce:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
1400019d3:     	vsubsd	%xmm2, %xmm7, %xmm2
1400019d7:     	vaddsd	%xmm4, %xmm3, %xmm3
1400019db:     	vmulsd	0x68(%r10), %xmm1, %xmm4
1400019e1:     	vsqrtsd	%xmm3, %xmm3, %xmm3
1400019e5:     	vmaxsd	%xmm3, %xmm9, %xmm3
1400019e9:     	vdivsd	%xmm3, %xmm4, %xmm3
1400019ed:     	vsubsd	%xmm3, %xmm2, %xmm2
1400019f1:     	vsubpd	0x70(%r10), %xmm0, %xmm3
1400019f7:     	vmulpd	%xmm3, %xmm3, %xmm3
1400019fb:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
140001a00:     	vaddsd	%xmm4, %xmm3, %xmm3
140001a04:     	vmulsd	0xa0(%r10), %xmm1, %xmm4
140001a0d:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140001a11:     	vmaxsd	%xmm3, %xmm9, %xmm3
140001a15:     	vdivsd	%xmm3, %xmm4, %xmm3
140001a19:     	vsubsd	%xmm3, %xmm2, %xmm2
140001a1d:     	vsubpd	0xa8(%r10), %xmm0, %xmm3
140001a26:     	vmulpd	%xmm3, %xmm3, %xmm3
140001a2a:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
140001a2f:     	vaddsd	%xmm4, %xmm3, %xmm3
140001a33:     	vmulsd	0xd8(%r10), %xmm1, %xmm4
140001a3c:     	addq	$0xe0, %r10
140001a43:     	addq	$0x4, %r9
140001a47:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140001a4b:     	vmaxsd	%xmm3, %xmm9, %xmm3
140001a4f:     	vdivsd	%xmm3, %xmm4, %xmm3
140001a53:     	vsubsd	%xmm3, %xmm2, %xmm7
140001a57:     	jne	0x1400019a0 <.text+0x9a0>
140001a5d:     	jmp	0x1400018e0 <.text+0x8e0>
140001a62:     	nopw	%cs:(%rax,%rax)
140001a70:     	movl	$0x228, %ecx            # imm = 0x228
140001a75:     	nopw	%cs:(%rax,%rax)
140001a80:     	vmovupd	-0x218(%rax,%rcx), %xmm0
140001a89:     	vmovupd	-0x1e0(%rax,%rcx), %xmm1
140001a92:     	vmulsd	-0x1c0(%rax,%rcx), %xmm14, %xmm5
140001a9b:     	vmovupd	-0x1a8(%rax,%rcx), %xmm2
140001aa4:     	vmovupd	-0x170(%rax,%rcx), %xmm3
140001aad:     	vmulpd	%xmm0, %xmm0, %xmm0
140001ab1:     	vmulpd	%xmm1, %xmm1, %xmm1
140001ab5:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
140001aba:     	vaddsd	%xmm4, %xmm0, %xmm0
140001abe:     	vmulsd	-0x1f8(%rax,%rcx), %xmm14, %xmm4
140001ac7:     	vmulsd	%xmm0, %xmm4, %xmm0
140001acb:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm4 # xmm4 = xmm1[1,0]
140001ad0:     	vaddsd	%xmm4, %xmm1, %xmm1
140001ad4:     	vaddsd	%xmm0, %xmm7, %xmm0
140001ad8:     	vmulsd	%xmm1, %xmm5, %xmm1
140001adc:     	vaddsd	%xmm1, %xmm0, %xmm0
140001ae0:     	vmulpd	%xmm2, %xmm2, %xmm1
140001ae4:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001ae9:     	vaddsd	%xmm2, %xmm1, %xmm1
140001aed:     	vmulsd	-0x188(%rax,%rcx), %xmm14, %xmm2
140001af6:     	vmulsd	%xmm1, %xmm2, %xmm1
140001afa:     	vaddsd	%xmm1, %xmm0, %xmm0
140001afe:     	vmulpd	%xmm3, %xmm3, %xmm1
140001b02:     	vmulsd	(%rax,%rcx), %xmm14, %xmm3
140001b07:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001b0c:     	vaddsd	%xmm2, %xmm1, %xmm1
140001b10:     	vmulsd	-0x150(%rax,%rcx), %xmm14, %xmm2
140001b19:     	vmulsd	%xmm1, %xmm2, %xmm1
140001b1d:     	vaddsd	%xmm1, %xmm0, %xmm0
140001b21:     	vmovupd	-0x138(%rax,%rcx), %xmm1
140001b2a:     	vmulpd	%xmm1, %xmm1, %xmm1
140001b2e:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001b33:     	vaddsd	%xmm2, %xmm1, %xmm1
140001b37:     	vmulsd	-0x118(%rax,%rcx), %xmm14, %xmm2
140001b40:     	vmulsd	%xmm1, %xmm2, %xmm1
140001b44:     	vaddsd	%xmm1, %xmm0, %xmm0
140001b48:     	vmovupd	-0x100(%rax,%rcx), %xmm1
140001b51:     	vmulpd	%xmm1, %xmm1, %xmm1
140001b55:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001b5a:     	vaddsd	%xmm2, %xmm1, %xmm1
140001b5e:     	vmulsd	-0xe0(%rax,%rcx), %xmm14, %xmm2
140001b67:     	vmulsd	%xmm1, %xmm2, %xmm1
140001b6b:     	vaddsd	%xmm1, %xmm0, %xmm0
140001b6f:     	vmovupd	-0xc8(%rax,%rcx), %xmm1
140001b78:     	vmulpd	%xmm1, %xmm1, %xmm1
140001b7c:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001b81:     	vaddsd	%xmm2, %xmm1, %xmm1
140001b85:     	vmulsd	-0xa8(%rax,%rcx), %xmm14, %xmm2
140001b8e:     	vmulsd	%xmm1, %xmm2, %xmm1
140001b92:     	vaddsd	%xmm1, %xmm0, %xmm0
140001b96:     	vmovupd	-0x90(%rax,%rcx), %xmm1
140001b9f:     	vmulpd	%xmm1, %xmm1, %xmm1
140001ba3:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001ba8:     	vaddsd	%xmm2, %xmm1, %xmm1
140001bac:     	vmulsd	-0x70(%rax,%rcx), %xmm14, %xmm2
140001bb2:     	vmulsd	%xmm1, %xmm2, %xmm1
140001bb6:     	vaddsd	%xmm1, %xmm0, %xmm0
140001bba:     	vmovupd	-0x58(%rax,%rcx), %xmm1
140001bc0:     	vmulpd	%xmm1, %xmm1, %xmm1
140001bc4:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001bc9:     	vaddsd	%xmm2, %xmm1, %xmm1
140001bcd:     	vmulsd	-0x38(%rax,%rcx), %xmm14, %xmm2
140001bd3:     	vmulsd	%xmm1, %xmm2, %xmm1
140001bd7:     	vaddsd	%xmm1, %xmm0, %xmm0
140001bdb:     	vmovupd	-0x20(%rax,%rcx), %xmm1
140001be1:     	addq	$0x230, %rcx            # imm = 0x230
140001be8:     	vmulpd	%xmm1, %xmm1, %xmm1
140001bec:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140001bf1:     	vaddsd	%xmm2, %xmm1, %xmm1
140001bf5:     	vmulsd	%xmm1, %xmm3, %xmm1
140001bf9:     	vaddsd	%xmm1, %xmm0, %xmm7
140001bfd:     	cmpq	$0x2de8, %rcx           # imm = 0x2DE8
140001c04:     	jne	0x140001a80 <.text+0xa80>
140001c0a:     	movl	$0x1, %edx
140001c0f:     	movq	%rdi, %rcx
140001c12:     	vzeroupper
140001c15:     	callq	*%r15
140001c18:     	movq	0x48(%rsp), %rax
140001c1d:     	movl	0x50(%rsp), %ecx
140001c21:     	xorl	%esi, %esi
140001c23:     	movq	%rax, 0x30(%rsp)
140001c28:     	movl	%ecx, 0x44(%rsp)
140001c2c:     	nopl	(%rax)
140001c30:     	movl	$0x1, %ecx
140001c35:     	movl	$0x70, %edx
140001c3a:     	callq	*%r13
140001c3d:     	vbroadcastf128	0x262a(%rip), %ymm0 # ymm0 = mem[0,1,0,1]
                                                # 0x140004270
140001c46:     	movq	%rax, %r14
140001c49:     	xorl	%ebp, %ebp
140001c4b:     	vmovupd	%ymm0, (%rax)
140001c4f:     	nop
140001c50:     	movq	%r14, %rcx
140001c53:     	movl	%ebp, %edx
140001c55:     	vzeroupper
140001c58:     	callq	0x140002440 <.text+0x1440>
140001c5d:     	incl	%ebp
140001c5f:     	cmpl	$0xc8, %ebp
140001c65:     	jne	0x140001c50 <.text+0xc50>
140001c67:     	movq	0x3432(%rip), %rbp      # 0x1400050a0
140001c6e:     	xorl	%r15d, %r15d
140001c71:     	leaq	0x20(%rbp), %r12
140001c75:     	nopw	%cs:(%rax,%rax)
140001c80:     	movq	%r14, %rcx
140001c83:     	movl	%r15d, %edx
140001c86:     	movq	%rdi, %r8
140001c89:     	movq	%rbx, %r9
140001c8c:     	callq	0x140002710 <.text+0x1710>
140001c91:     	vmovsd	0x48(%rsp), %xmm0
140001c97:     	incq	%r15
140001c9a:     	vmovhpd	0x68(%rsp), %xmm0, %xmm0 # xmm0 = xmm0[0],mem[0]
140001ca0:     	vdivpd	0x10(%r12){1to2}, %xmm0, %xmm0
140001ca8:     	vaddpd	(%r12), %xmm0, %xmm0
140001cae:     	vmovupd	%xmm0, (%r12)
140001cb4:     	addq	$0x38, %r12
140001cb8:     	cmpq	$0xc8, %r15
140001cbf:     	jne	0x140001c80 <.text+0xc80>
140001cc1:     	movl	$0x1a8, %eax            # imm = 0x1A8
140001cc6:     	nopw	%cs:(%rax,%rax)
140001cd0:     	vmulpd	-0x188(%rbp,%rax), %xmm12, %xmm0
140001cd9:     	vaddpd	-0x198(%rbp,%rax), %xmm0, %xmm0
140001ce2:     	vmovupd	%xmm0, -0x198(%rbp,%rax)
140001ceb:     	vmulpd	%xmm0, %xmm12, %xmm0
140001cef:     	vaddpd	-0x1a8(%rbp,%rax), %xmm0, %xmm0
140001cf8:     	vmovupd	%xmm0, -0x1a8(%rbp,%rax)
140001d01:     	vmovups	%xmm6, -0x188(%rbp,%rax)
140001d0a:     	vmulpd	-0x150(%rbp,%rax), %xmm12, %xmm0
140001d13:     	vaddpd	-0x160(%rbp,%rax), %xmm0, %xmm0
140001d1c:     	vmovupd	%xmm0, -0x160(%rbp,%rax)
140001d25:     	vmulpd	%xmm0, %xmm12, %xmm0
140001d29:     	vaddpd	-0x170(%rbp,%rax), %xmm0, %xmm0
140001d32:     	vmovupd	%xmm0, -0x170(%rbp,%rax)
140001d3b:     	vmovups	%xmm6, -0x150(%rbp,%rax)
140001d44:     	vmulpd	-0x118(%rbp,%rax), %xmm12, %xmm0
140001d4d:     	vaddpd	-0x128(%rbp,%rax), %xmm0, %xmm0
140001d56:     	vmovupd	%xmm0, -0x128(%rbp,%rax)
140001d5f:     	vmulpd	%xmm0, %xmm12, %xmm0
140001d63:     	vaddpd	-0x138(%rbp,%rax), %xmm0, %xmm0
140001d6c:     	vmovupd	%xmm0, -0x138(%rbp,%rax)
140001d75:     	vmovups	%xmm6, -0x118(%rbp,%rax)
140001d7e:     	vmulpd	-0xe0(%rbp,%rax), %xmm12, %xmm0
140001d87:     	vaddpd	-0xf0(%rbp,%rax), %xmm0, %xmm0
140001d90:     	vmovupd	%xmm0, -0xf0(%rbp,%rax)
140001d99:     	vmulpd	%xmm0, %xmm12, %xmm0
140001d9d:     	vaddpd	-0x100(%rbp,%rax), %xmm0, %xmm0
140001da6:     	vmovupd	%xmm0, -0x100(%rbp,%rax)
140001daf:     	vmovups	%xmm6, -0xe0(%rbp,%rax)
140001db8:     	vmulpd	-0xa8(%rbp,%rax), %xmm12, %xmm0
140001dc1:     	vaddpd	-0xb8(%rbp,%rax), %xmm0, %xmm0
140001dca:     	vmovupd	%xmm0, -0xb8(%rbp,%rax)
140001dd3:     	vmulpd	%xmm0, %xmm12, %xmm0
140001dd7:     	vaddpd	-0xc8(%rbp,%rax), %xmm0, %xmm0
140001de0:     	vmovupd	%xmm0, -0xc8(%rbp,%rax)
140001de9:     	vmovups	%xmm6, -0xa8(%rbp,%rax)
140001df2:     	vmulpd	-0x70(%rbp,%rax), %xmm12, %xmm0
140001df8:     	vaddpd	-0x80(%rbp,%rax), %xmm0, %xmm0
140001dfe:     	vmovupd	%xmm0, -0x80(%rbp,%rax)
140001e04:     	vmulpd	%xmm0, %xmm12, %xmm0
140001e08:     	vaddpd	-0x90(%rbp,%rax), %xmm0, %xmm0
140001e11:     	vmovupd	%xmm0, -0x90(%rbp,%rax)
140001e1a:     	vmovups	%xmm6, -0x70(%rbp,%rax)
140001e20:     	vmulpd	-0x38(%rbp,%rax), %xmm12, %xmm0
140001e26:     	vaddpd	-0x48(%rbp,%rax), %xmm0, %xmm0
140001e2c:     	vmovupd	%xmm0, -0x48(%rbp,%rax)
140001e32:     	vmulpd	%xmm0, %xmm12, %xmm0
140001e36:     	vaddpd	-0x58(%rbp,%rax), %xmm0, %xmm0
140001e3c:     	vmovupd	%xmm0, -0x58(%rbp,%rax)
140001e42:     	vmovups	%xmm6, -0x38(%rbp,%rax)
140001e48:     	vmulpd	(%rbp,%rax), %xmm12, %xmm0
140001e4e:     	vaddpd	-0x10(%rbp,%rax), %xmm0, %xmm0
140001e54:     	vmovupd	%xmm0, -0x10(%rbp,%rax)
140001e5a:     	vmulpd	%xmm0, %xmm12, %xmm0
140001e5e:     	vaddpd	-0x20(%rbp,%rax), %xmm0, %xmm0
140001e64:     	vmovupd	%xmm0, -0x20(%rbp,%rax)
140001e6a:     	vmovups	%xmm6, (%rbp,%rax)
140001e70:     	addq	$0x1c0, %rax            # imm = 0x1C0
140001e76:     	cmpq	$0x2d68, %rax           # imm = 0x2D68
140001e7c:     	jne	0x140001cd0 <.text+0xcd0>
140001e82:     	movq	%r14, %rcx
140001e85:     	callq	0x1400028f0 <.text+0x18f0>
140001e8a:     	incl	%esi
140001e8c:     	cmpl	$0x64, %esi
140001e8f:     	jne	0x140001c30 <.text+0xc30>
140001e95:     	movq	0x3204(%rip), %rax      # 0x1400050a0
140001e9c:     	movq	0x22f5(%rip), %r15      # 0x140004198
140001ea3:     	movl	$0x1, %edx
140001ea8:     	vxorpd	%xmm8, %xmm8, %xmm8
140001ead:     	xorl	%r8d, %r8d
140001eb0:     	leaq	0x68(%rax), %rcx
140001eb4:     	jmp	0x140001ed7 <.text+0xed7>
140001eb6:     	nopw	%cs:(%rax,%rax)
140001ec0:     	incq	%r8
140001ec3:     	incq	%rdx
140001ec6:     	addq	$0x38, %rcx
140001eca:     	cmpq	$0xc8, %r8
140001ed1:     	je	0x140002050 <.text+0x1050>
140001ed7:     	cmpq	$0xc6, %r8
140001ede:     	ja	0x140001ec0 <.text+0xec0>
140001ee0:     	imulq	$0x38, %r8, %r9
140001ee4:     	movl	%r8d, %r10d
140001ee7:     	andl	$0x3, %r10d
140001eeb:     	vmulsd	0x30(%rax,%r9), %xmm13, %xmm1
140001ef2:     	vmovupd	(%rax,%r9), %xmm0
140001ef8:     	cmpq	$0x3, %r10
140001efc:     	jne	0x140001f10 <.text+0xf10>
140001efe:     	movq	%rdx, %r9
140001f01:     	leaq	-0xc4(%r8), %r10
140001f08:     	cmpq	$0x3, %r10
140001f0c:     	jb	0x140001ec0 <.text+0xec0>
140001f0e:     	jmp	0x140001f6f <.text+0xf6f>
140001f10:     	movl	$0x1, %r9d
140001f16:     	movq	%rcx, %r11
140001f19:     	nopl	(%rax)
140001f20:     	vsubpd	-0x30(%r11), %xmm0, %xmm2
140001f26:     	movq	%r10, %rsi
140001f29:     	xorq	%r9, %rsi
140001f2c:     	incq	%r9
140001f2f:     	vmulpd	%xmm2, %xmm2, %xmm2
140001f33:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140001f38:     	vaddsd	%xmm3, %xmm2, %xmm2
140001f3c:     	vmulsd	(%r11), %xmm1, %xmm3
140001f41:     	addq	$0x38, %r11
140001f45:     	vsqrtsd	%xmm2, %xmm2, %xmm2
140001f49:     	vmaxsd	%xmm2, %xmm9, %xmm2
140001f4d:     	vdivsd	%xmm2, %xmm3, %xmm2
140001f51:     	vsubsd	%xmm2, %xmm8, %xmm8
140001f55:     	cmpq	$0x3, %rsi
140001f59:     	jne	0x140001f20 <.text+0xf20>
140001f5b:     	addq	%r8, %r9
140001f5e:     	leaq	-0xc4(%r8), %r10
140001f65:     	cmpq	$0x3, %r10
140001f69:     	jb	0x140001ec0 <.text+0xec0>
140001f6f:     	imulq	$0x38, %r9, %r10
140001f73:     	addq	$-0xc8, %r9
140001f7a:     	addq	%rax, %r10
140001f7d:     	nopl	(%rax)
140001f80:     	vsubpd	(%r10), %xmm0, %xmm2
140001f85:     	vmulpd	%xmm2, %xmm2, %xmm2
140001f89:     	vshufpd	$0x1, %xmm2, %xmm2, %xmm3 # xmm3 = xmm2[1,0]
140001f8e:     	vaddsd	%xmm3, %xmm2, %xmm2
140001f92:     	vmulsd	0x30(%r10), %xmm1, %xmm3
140001f98:     	vsqrtsd	%xmm2, %xmm2, %xmm2
140001f9c:     	vmaxsd	%xmm2, %xmm9, %xmm2
140001fa0:     	vdivsd	%xmm2, %xmm3, %xmm2
140001fa4:     	vsubpd	0x38(%r10), %xmm0, %xmm3
140001faa:     	vmulpd	%xmm3, %xmm3, %xmm3
140001fae:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
140001fb3:     	vsubsd	%xmm2, %xmm8, %xmm2
140001fb7:     	vaddsd	%xmm4, %xmm3, %xmm3
140001fbb:     	vmulsd	0x68(%r10), %xmm1, %xmm4
140001fc1:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140001fc5:     	vmaxsd	%xmm3, %xmm9, %xmm3
140001fc9:     	vdivsd	%xmm3, %xmm4, %xmm3
140001fcd:     	vsubsd	%xmm3, %xmm2, %xmm2
140001fd1:     	vsubpd	0x70(%r10), %xmm0, %xmm3
140001fd7:     	vmulpd	%xmm3, %xmm3, %xmm3
140001fdb:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
140001fe0:     	vaddsd	%xmm4, %xmm3, %xmm3
140001fe4:     	vmulsd	0xa0(%r10), %xmm1, %xmm4
140001fed:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140001ff1:     	vmaxsd	%xmm3, %xmm9, %xmm3
140001ff5:     	vdivsd	%xmm3, %xmm4, %xmm3
140001ff9:     	vsubsd	%xmm3, %xmm2, %xmm2
140001ffd:     	vsubpd	0xa8(%r10), %xmm0, %xmm3
140002006:     	vmulpd	%xmm3, %xmm3, %xmm3
14000200a:     	vshufpd	$0x1, %xmm3, %xmm3, %xmm4 # xmm4 = xmm3[1,0]
14000200f:     	vaddsd	%xmm4, %xmm3, %xmm3
140002013:     	vmulsd	0xd8(%r10), %xmm1, %xmm4
14000201c:     	addq	$0xe0, %r10
140002023:     	addq	$0x4, %r9
140002027:     	vsqrtsd	%xmm3, %xmm3, %xmm3
14000202b:     	vmaxsd	%xmm3, %xmm9, %xmm3
14000202f:     	vdivsd	%xmm3, %xmm4, %xmm3
140002033:     	vsubsd	%xmm3, %xmm2, %xmm8
140002037:     	jne	0x140001f80 <.text+0xf80>
14000203d:     	jmp	0x140001ec0 <.text+0xec0>
140002042:     	nopw	%cs:(%rax,%rax)
140002050:     	movl	$0x228, %ecx            # imm = 0x228
140002055:     	nopw	%cs:(%rax,%rax)
140002060:     	vmovupd	-0x218(%rax,%rcx), %xmm0
140002069:     	vmovupd	-0x1e0(%rax,%rcx), %xmm1
140002072:     	vmulsd	-0x1c0(%rax,%rcx), %xmm14, %xmm5
14000207b:     	vmovupd	-0x1a8(%rax,%rcx), %xmm2
140002084:     	vmovupd	-0x170(%rax,%rcx), %xmm3
14000208d:     	vmulpd	%xmm0, %xmm0, %xmm0
140002091:     	vmulpd	%xmm1, %xmm1, %xmm1
140002095:     	vshufpd	$0x1, %xmm0, %xmm0, %xmm4 # xmm4 = xmm0[1,0]
14000209a:     	vaddsd	%xmm4, %xmm0, %xmm0
14000209e:     	vmulsd	-0x1f8(%rax,%rcx), %xmm14, %xmm4
1400020a7:     	vmulsd	%xmm0, %xmm4, %xmm0
1400020ab:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm4 # xmm4 = xmm1[1,0]
1400020b0:     	vaddsd	%xmm4, %xmm1, %xmm1
1400020b4:     	vaddsd	%xmm0, %xmm8, %xmm0
1400020b8:     	vmulsd	%xmm1, %xmm5, %xmm1
1400020bc:     	vaddsd	%xmm1, %xmm0, %xmm0
1400020c0:     	vmulpd	%xmm2, %xmm2, %xmm1
1400020c4:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
1400020c9:     	vaddsd	%xmm2, %xmm1, %xmm1
1400020cd:     	vmulsd	-0x188(%rax,%rcx), %xmm14, %xmm2
1400020d6:     	vmulsd	%xmm1, %xmm2, %xmm1
1400020da:     	vaddsd	%xmm1, %xmm0, %xmm0
1400020de:     	vmulpd	%xmm3, %xmm3, %xmm1
1400020e2:     	vmulsd	(%rax,%rcx), %xmm14, %xmm3
1400020e7:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
1400020ec:     	vaddsd	%xmm2, %xmm1, %xmm1
1400020f0:     	vmulsd	-0x150(%rax,%rcx), %xmm14, %xmm2
1400020f9:     	vmulsd	%xmm1, %xmm2, %xmm1
1400020fd:     	vaddsd	%xmm1, %xmm0, %xmm0
140002101:     	vmovupd	-0x138(%rax,%rcx), %xmm1
14000210a:     	vmulpd	%xmm1, %xmm1, %xmm1
14000210e:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140002113:     	vaddsd	%xmm2, %xmm1, %xmm1
140002117:     	vmulsd	-0x118(%rax,%rcx), %xmm14, %xmm2
140002120:     	vmulsd	%xmm1, %xmm2, %xmm1
140002124:     	vaddsd	%xmm1, %xmm0, %xmm0
140002128:     	vmovupd	-0x100(%rax,%rcx), %xmm1
140002131:     	vmulpd	%xmm1, %xmm1, %xmm1
140002135:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
14000213a:     	vaddsd	%xmm2, %xmm1, %xmm1
14000213e:     	vmulsd	-0xe0(%rax,%rcx), %xmm14, %xmm2
140002147:     	vmulsd	%xmm1, %xmm2, %xmm1
14000214b:     	vaddsd	%xmm1, %xmm0, %xmm0
14000214f:     	vmovupd	-0xc8(%rax,%rcx), %xmm1
140002158:     	vmulpd	%xmm1, %xmm1, %xmm1
14000215c:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140002161:     	vaddsd	%xmm2, %xmm1, %xmm1
140002165:     	vmulsd	-0xa8(%rax,%rcx), %xmm14, %xmm2
14000216e:     	vmulsd	%xmm1, %xmm2, %xmm1
140002172:     	vaddsd	%xmm1, %xmm0, %xmm0
140002176:     	vmovupd	-0x90(%rax,%rcx), %xmm1
14000217f:     	vmulpd	%xmm1, %xmm1, %xmm1
140002183:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
140002188:     	vaddsd	%xmm2, %xmm1, %xmm1
14000218c:     	vmulsd	-0x70(%rax,%rcx), %xmm14, %xmm2
140002192:     	vmulsd	%xmm1, %xmm2, %xmm1
140002196:     	vaddsd	%xmm1, %xmm0, %xmm0
14000219a:     	vmovupd	-0x58(%rax,%rcx), %xmm1
1400021a0:     	vmulpd	%xmm1, %xmm1, %xmm1
1400021a4:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
1400021a9:     	vaddsd	%xmm2, %xmm1, %xmm1
1400021ad:     	vmulsd	-0x38(%rax,%rcx), %xmm14, %xmm2
1400021b3:     	vmulsd	%xmm1, %xmm2, %xmm1
1400021b7:     	vaddsd	%xmm1, %xmm0, %xmm0
1400021bb:     	vmovupd	-0x20(%rax,%rcx), %xmm1
1400021c1:     	addq	$0x230, %rcx            # imm = 0x230
1400021c8:     	vmulpd	%xmm1, %xmm1, %xmm1
1400021cc:     	vshufpd	$0x1, %xmm1, %xmm1, %xmm2 # xmm2 = xmm1[1,0]
1400021d1:     	vaddsd	%xmm2, %xmm1, %xmm1
1400021d5:     	vmulsd	%xmm1, %xmm3, %xmm1
1400021d9:     	vaddsd	%xmm1, %xmm0, %xmm8
1400021dd:     	cmpq	$0x2de8, %rcx           # imm = 0x2DE8
1400021e4:     	jne	0x140002060 <.text+0x1060>
1400021ea:     	movl	$0x1, %edx
1400021ef:     	movq	%rdi, %rcx
1400021f2:     	callq	*%r15
1400021f5:     	movq	0x48(%rsp), %rax
1400021fa:     	movl	0x50(%rsp), %ecx
1400021fe:     	movq	0x2e9b(%rip), %r8       # 0x1400050a0
140002205:     	movl	$0x200, %edx            # imm = 0x200
14000220a:     	vxorpd	%xmm9, %xmm9, %xmm9
14000220f:     	nop
140002210:     	vmovsd	-0x200(%r8,%rdx), %xmm0
14000221a:     	vmovsd	-0x1c8(%r8,%rdx), %xmm1
140002224:     	vaddsd	-0x1f8(%r8,%rdx), %xmm0, %xmm0
14000222e:     	vaddsd	-0x1c0(%r8,%rdx), %xmm1, %xmm1
140002238:     	vaddsd	%xmm0, %xmm9, %xmm0
14000223c:     	vaddsd	%xmm1, %xmm0, %xmm0
140002240:     	vmovsd	-0x190(%r8,%rdx), %xmm1
14000224a:     	vaddsd	-0x188(%r8,%rdx), %xmm1, %xmm1
140002254:     	vaddsd	%xmm1, %xmm0, %xmm0
140002258:     	vmovsd	-0x158(%r8,%rdx), %xmm1
140002262:     	vaddsd	-0x150(%r8,%rdx), %xmm1, %xmm1
14000226c:     	vaddsd	%xmm1, %xmm0, %xmm0
140002270:     	vmovsd	-0x120(%r8,%rdx), %xmm1
14000227a:     	vaddsd	-0x118(%r8,%rdx), %xmm1, %xmm1
140002284:     	vaddsd	%xmm1, %xmm0, %xmm0
140002288:     	vmovsd	-0xe8(%r8,%rdx), %xmm1
140002292:     	vaddsd	-0xe0(%r8,%rdx), %xmm1, %xmm1
14000229c:     	vaddsd	%xmm1, %xmm0, %xmm0
1400022a0:     	vmovsd	-0xb0(%r8,%rdx), %xmm1
1400022aa:     	vaddsd	-0xa8(%r8,%rdx), %xmm1, %xmm1
1400022b4:     	vaddsd	%xmm1, %xmm0, %xmm0
1400022b8:     	vmovsd	-0x78(%r8,%rdx), %xmm1
1400022bf:     	vaddsd	-0x70(%r8,%rdx), %xmm1, %xmm1
1400022c6:     	vaddsd	%xmm1, %xmm0, %xmm0
1400022ca:     	vmovsd	-0x40(%r8,%rdx), %xmm1
1400022d1:     	vaddsd	-0x38(%r8,%rdx), %xmm1, %xmm1
1400022d8:     	vaddsd	%xmm1, %xmm0, %xmm0
1400022dc:     	vmovsd	-0x8(%r8,%rdx), %xmm1
1400022e3:     	vaddsd	(%r8,%rdx), %xmm1, %xmm1
1400022e9:     	addq	$0x230, %rdx            # imm = 0x230
1400022f0:     	vaddsd	%xmm1, %xmm0, %xmm9
1400022f4:     	cmpq	$0x2dc0, %rdx           # imm = 0x2DC0
1400022fb:     	jne	0x140002210 <.text+0x1210>
140002301:     	vcvtsi2sdq	0x30(%rsp), %xmm31, %xmm0
140002309:     	vmovsd	0x1fef(%rip), %xmm3     # 0x140004300
140002311:     	vmovsd	0x1f4f(%rip), %xmm15    # 0x140004268
140002319:     	vcvtsi2sdl	0x44(%rsp), %xmm31, %xmm1
140002321:     	vmulsd	%xmm3, %xmm1, %xmm1
140002325:     	vaddsd	%xmm0, %xmm1, %xmm0
140002329:     	vcvtsi2sd	%ecx, %xmm31, %xmm2
14000232f:     	vcvtsi2sd	%rax, %xmm31, %xmm1
140002335:     	movq	0x58(%rsp), %rax
14000233a:     	vmulsd	%xmm3, %xmm2, %xmm2
14000233e:     	incl	%eax
140002340:     	vaddsd	%xmm1, %xmm2, %xmm1
140002344:     	vsubsd	%xmm0, %xmm1, %xmm0
140002348:     	vminsd	%xmm10, %xmm0, %xmm10
14000234d:     	cmpl	0x2c(%rsp), %eax
140002351:     	jne	0x140001100 <.text+0x100>
140002357:     	leaq	0x1fe1(%rip), %rsi      # 0x14000433f
14000235e:     	leaq	0x1fa3(%rip), %rdx      # 0x140004308
140002365:     	vmovq	%xmm7, %r8
14000236a:     	vmovapd	%xmm7, %xmm2
14000236e:     	movq	%rsi, %rcx
140002371:     	callq	0x140002940 <.text+0x1940>
140002376:     	leaq	0x1f9a(%rip), %rdx      # 0x140004317
14000237d:     	vmovq	%xmm8, %r8
140002382:     	movq	%rsi, %rcx
140002385:     	vmovapd	%xmm8, %xmm2
140002389:     	callq	0x140002940 <.text+0x1940>
14000238e:     	leaq	0x1f8f(%rip), %rdx      # 0x140004324
140002395:     	vmovq	%xmm9, %r8
14000239a:     	movq	%rsi, %rcx
14000239d:     	vmovapd	%xmm9, %xmm2
1400023a1:     	callq	0x140002940 <.text+0x1940>
1400023a6:     	leaq	0x1f84(%rip), %rcx      # 0x140004331
1400023ad:     	vmovq	%xmm10, %rdx
1400023b2:     	vmovapd	%xmm10, %xmm1
1400023b6:     	callq	0x140002940 <.text+0x1940>
1400023bb:     	movq	0x2cde(%rip), %rcx      # 0x1400050a0
1400023c2:     	callq	*0x1cc8(%rip)           # 0x140004090
1400023c8:     	vmovaps	0x70(%rsp), %xmm6
1400023ce:     	vmovaps	0x80(%rsp), %xmm7
1400023d7:     	vmovaps	0x90(%rsp), %xmm8
1400023e0:     	vmovaps	0xa0(%rsp), %xmm9
1400023e9:     	vmovaps	0xb0(%rsp), %xmm10
1400023f2:     	vmovaps	0xc0(%rsp), %xmm11
1400023fb:     	vmovaps	0xd0(%rsp), %xmm12
140002404:     	vmovaps	0xe0(%rsp), %xmm13
14000240d:     	vmovaps	0xf0(%rsp), %xmm14
140002416:     	vmovaps	0x100(%rsp), %xmm15
14000241f:     	xorl	%eax, %eax
140002421:     	addq	$0x118, %rsp            # imm = 0x118
140002428:     	popq	%rbx
140002429:     	popq	%rbp
14000242a:     	popq	%rdi
14000242b:     	popq	%rsi
14000242c:     	popq	%r12
14000242e:     	popq	%r13
140002430:     	popq	%r14
140002432:     	popq	%r15
140002434:     	retq
140002435:     	nopw	%cs:(%rax,%rax)
140002440:     	pushq	%r15
140002442:     	pushq	%r14
140002444:     	pushq	%rsi
140002445:     	pushq	%rdi
140002446:     	pushq	%rbx
140002447:     	subq	$0x90, %rsp
14000244e:     	vmovapd	%xmm12, 0x80(%rsp)
140002457:     	vmovapd	%xmm11, 0x70(%rsp)
14000245d:     	vmovapd	%xmm10, 0x60(%rsp)
140002463:     	vmovapd	%xmm9, 0x50(%rsp)
140002469:     	vmovapd	%xmm8, 0x40(%rsp)
14000246f:     	vmovapd	%xmm7, 0x30(%rsp)
140002475:     	vmovaps	%xmm6, 0x20(%rsp)
14000247b:     	vmovsd	0x1e75(%rip), %xmm6     # 0x1400042f8
140002483:     	movq	0x1bf6(%rip), %r15      # 0x140004080
14000248a:     	movslq	%edx, %rax
14000248d:     	movl	%edx, %edi
14000248f:     	movq	%rcx, %rsi
140002492:     	imulq	$0x38, %rax, %r14
140002496:     	nopw	%cs:(%rax,%rax)
1400024a0:     	movq	0x2bf9(%rip), %rax      # 0x1400050a0
1400024a7:     	vmovsd	(%rsi), %xmm7
1400024ab:     	vmovsd	0x10(%rsi), %xmm0
1400024b0:     	vmovsd	(%rax,%r14), %xmm1
1400024b6:     	vsubsd	%xmm0, %xmm7, %xmm2
1400024ba:     	vucomisd	%xmm2, %xmm1
1400024be:     	jb	0x14000266b <.text+0x166b>
1400024c4:     	vaddsd	%xmm0, %xmm7, %xmm2
1400024c8:     	vucomisd	%xmm1, %xmm2
1400024cc:     	jbe	0x14000266b <.text+0x166b>
1400024d2:     	vmovsd	0x8(%rsi), %xmm8
1400024d7:     	vmovsd	0x18(%rsi), %xmm1
1400024dc:     	addq	%r14, %rax
1400024df:     	vmovsd	0x8(%rax), %xmm2
1400024e4:     	vsubsd	%xmm1, %xmm8, %xmm3
1400024e8:     	vucomisd	%xmm3, %xmm2
1400024ec:     	jb	0x14000266b <.text+0x166b>
1400024f2:     	vaddsd	%xmm1, %xmm8, %xmm3
1400024f6:     	vucomisd	%xmm2, %xmm3
1400024fa:     	jbe	0x14000266b <.text+0x166b>
140002500:     	movslq	0x20(%rsi), %rcx
140002504:     	movl	0x34(%rsi), %edx
140002507:     	cmpq	$0x3, %rcx
14000250b:     	jg	0x140002520 <.text+0x1520>
14000250d:     	testl	%edx, %edx
14000250f:     	jne	0x140002630 <.text+0x1630>
140002515:     	jmp	0x1400026ab <.text+0x16ab>
14000251a:     	nopw	(%rax,%rax)
140002520:     	testl	%edx, %edx
140002522:     	jne	0x140002630 <.text+0x1630>
140002528:     	vmulsd	%xmm6, %xmm0, %xmm9
14000252c:     	vmulsd	%xmm6, %xmm1, %xmm10
140002530:     	movl	$0x1, %ecx
140002535:     	movl	$0x70, %edx
14000253a:     	vsubsd	%xmm10, %xmm8, %xmm11
14000253f:     	vaddsd	%xmm7, %xmm9, %xmm12
140002543:     	callq	*%r15
140002546:     	movl	$0x1, %ecx
14000254b:     	movl	$0x70, %edx
140002550:     	vmovsd	%xmm12, (%rax)
140002554:     	vmovsd	%xmm11, 0x8(%rax)
140002559:     	vmovsd	%xmm9, 0x10(%rax)
14000255e:     	vmovsd	%xmm10, 0x18(%rax)
140002563:     	movq	%rax, 0x50(%rsi)
140002567:     	vsubsd	%xmm9, %xmm7, %xmm7
14000256c:     	callq	*%r15
14000256f:     	movl	$0x1, %ecx
140002574:     	movl	$0x70, %edx
140002579:     	vmovsd	%xmm7, (%rax)
14000257d:     	vmovsd	%xmm11, 0x8(%rax)
140002582:     	vmovsd	%xmm9, 0x10(%rax)
140002587:     	vmovsd	%xmm10, 0x18(%rax)
14000258c:     	movq	%rax, 0x58(%rsi)
140002590:     	vaddsd	%xmm10, %xmm8, %xmm8
140002595:     	callq	*%r15
140002598:     	movl	$0x1, %ecx
14000259d:     	movl	$0x70, %edx
1400025a2:     	vmovsd	%xmm12, (%rax)
1400025a6:     	vmovsd	%xmm8, 0x8(%rax)
1400025ab:     	vmovsd	%xmm9, 0x10(%rax)
1400025b0:     	vmovsd	%xmm10, 0x18(%rax)
1400025b5:     	movq	%rax, 0x60(%rsi)
1400025b9:     	callq	*%r15
1400025bc:     	vmovsd	%xmm7, (%rax)
1400025c0:     	vmovsd	%xmm8, 0x8(%rax)
1400025c5:     	vmovsd	%xmm9, 0x10(%rax)
1400025ca:     	vmovsd	%xmm10, 0x18(%rax)
1400025cf:     	movq	%rax, 0x68(%rsi)
1400025d3:     	xorl	%ebx, %ebx
1400025d5:     	movl	$0x1, 0x34(%rsi)
1400025dc:     	nopl	(%rax)
1400025e0:     	movl	0x24(%rsi,%rbx,4), %edx
1400025e4:     	movq	0x50(%rsi), %rcx
1400025e8:     	callq	0x140002440 <.text+0x1440>
1400025ed:     	movl	0x24(%rsi,%rbx,4), %edx
1400025f1:     	movq	0x58(%rsi), %rcx
1400025f5:     	callq	0x140002440 <.text+0x1440>
1400025fa:     	movl	0x24(%rsi,%rbx,4), %edx
1400025fe:     	movq	0x60(%rsi), %rcx
140002602:     	callq	0x140002440 <.text+0x1440>
140002607:     	movl	0x24(%rsi,%rbx,4), %edx
14000260b:     	movq	0x68(%rsi), %rcx
14000260f:     	callq	0x140002440 <.text+0x1440>
140002614:     	movslq	0x20(%rsi), %rax
140002618:     	incq	%rbx
14000261b:     	cmpq	%rax, %rbx
14000261e:     	jl	0x1400025e0 <.text+0x15e0>
140002620:     	movl	$0x0, 0x20(%rsi)
140002627:     	nopw	(%rax,%rax)
140002630:     	movq	0x50(%rsi), %rcx
140002634:     	movl	%edi, %edx
140002636:     	callq	0x140002440 <.text+0x1440>
14000263b:     	movl	$0x1, %ebx
140002640:     	testl	%eax, %eax
140002642:     	jne	0x14000266d <.text+0x166d>
140002644:     	movq	0x58(%rsi), %rcx
140002648:     	movl	%edi, %edx
14000264a:     	callq	0x140002440 <.text+0x1440>
14000264f:     	testl	%eax, %eax
140002651:     	jne	0x14000266d <.text+0x166d>
140002653:     	movq	0x60(%rsi), %rcx
140002657:     	movl	%edi, %edx
140002659:     	callq	0x140002440 <.text+0x1440>
14000265e:     	testl	%eax, %eax
140002660:     	jne	0x14000266d <.text+0x166d>
140002662:     	movq	0x68(%rsi), %rsi
140002666:     	jmp	0x1400024a0 <.text+0x14a0>
14000266b:     	xorl	%ebx, %ebx
14000266d:     	vmovaps	0x20(%rsp), %xmm6
140002673:     	vmovaps	0x30(%rsp), %xmm7
140002679:     	vmovaps	0x40(%rsp), %xmm8
14000267f:     	vmovaps	0x50(%rsp), %xmm9
140002685:     	vmovaps	0x60(%rsp), %xmm10
14000268b:     	vmovaps	0x70(%rsp), %xmm11
140002691:     	vmovaps	0x80(%rsp), %xmm12
14000269a:     	movl	%ebx, %eax
14000269c:     	addq	$0x90, %rsp
1400026a3:     	popq	%rbx
1400026a4:     	popq	%rdi
1400026a5:     	popq	%rsi
1400026a6:     	popq	%r14
1400026a8:     	popq	%r15
1400026aa:     	retq
1400026ab:     	leal	0x1(%rcx), %edx
1400026ae:     	vxorpd	%xmm3, %xmm3, %xmm3
1400026b2:     	movl	%edx, 0x20(%rsi)
1400026b5:     	movl	%edi, 0x24(%rsi,%rcx,4)
1400026b9:     	vmovsd	0x48(%rsi), %xmm1
1400026be:     	vmovsd	0x30(%rax), %xmm2
1400026c3:     	vaddsd	%xmm2, %xmm1, %xmm0
1400026c7:     	vucomisd	%xmm3, %xmm0
1400026cb:     	jbe	0x1400026ff <.text+0x16ff>
1400026cd:     	vmulsd	0x38(%rsi), %xmm1, %xmm3
1400026d2:     	vmulsd	(%rax), %xmm2, %xmm2
1400026d6:     	vaddsd	%xmm2, %xmm3, %xmm2
1400026da:     	vdivsd	%xmm0, %xmm2, %xmm2
1400026de:     	vmovsd	%xmm2, 0x38(%rsi)
1400026e3:     	vmovsd	0x8(%rax), %xmm2
1400026e8:     	vmulsd	0x40(%rsi), %xmm1, %xmm1
1400026ed:     	vmulsd	0x30(%rax), %xmm2, %xmm2
1400026f2:     	vaddsd	%xmm2, %xmm1, %xmm1
1400026f6:     	vdivsd	%xmm0, %xmm1, %xmm1
1400026fa:     	vmovsd	%xmm1, 0x40(%rsi)
1400026ff:     	movl	$0x1, %ebx
140002704:     	vmovsd	%xmm0, 0x48(%rsi)
140002709:     	jmp	0x14000266d <.text+0x166d>
14000270e:     	nop
140002710:     	pushq	%r14
140002712:     	pushq	%rsi
140002713:     	pushq	%rdi
140002714:     	pushq	%rbx
140002715:     	subq	$0x58, %rsp
140002719:     	vmovapd	%xmm7, 0x40(%rsp)
14000271f:     	vmovapd	%xmm6, 0x30(%rsp)
140002725:     	movq	$0x0, (%r8)
14000272c:     	movq	$0x0, (%r9)
140002733:     	vxorpd	%xmm1, %xmm1, %xmm1
140002737:     	vmovsd	0x48(%rcx), %xmm0
14000273c:     	vucomisd	%xmm1, %xmm0
140002740:     	jne	0x140002748 <.text+0x1748>
140002742:     	jnp	0x1400028b6 <.text+0x18b6>
140002748:     	cmpl	$0x1, 0x20(%rcx)
14000274c:     	jne	0x140002757 <.text+0x1757>
14000274e:     	cmpl	%edx, 0x24(%rcx)
140002751:     	je	0x1400028b6 <.text+0x18b6>
140002757:     	movq	0x2942(%rip), %rax      # 0x1400050a0
14000275e:     	movslq	%edx, %r10
140002761:     	vmovsd	0x38(%rcx), %xmm1
140002766:     	vmovsd	0x40(%rcx), %xmm3
14000276b:     	imulq	$0x38, %r10, %r10
14000276f:     	cmpl	$0x0, 0x34(%rcx)
140002773:     	vsubsd	(%rax,%r10), %xmm1, %xmm2
140002779:     	vsubsd	0x8(%rax,%r10), %xmm3, %xmm1
140002780:     	vmulsd	%xmm2, %xmm2, %xmm3
140002784:     	vmulsd	%xmm1, %xmm1, %xmm4
140002788:     	vaddsd	%xmm4, %xmm3, %xmm3
14000278c:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140002790:     	je	0x1400027ad <.text+0x17ad>
140002792:     	vmovsd	0x10(%rcx), %xmm4
140002797:     	vmovsd	0x1b59(%rip), %xmm5     # 0x1400042f8
14000279f:     	vaddsd	%xmm4, %xmm4, %xmm4
1400027a3:     	vdivsd	%xmm3, %xmm4, %xmm4
1400027a7:     	vucomisd	%xmm4, %xmm5
1400027ab:     	jbe	0x1400027ef <.text+0x17ef>
1400027ad:     	vmovsd	0x1b3b(%rip), %xmm4     # 0x1400042f0
1400027b5:     	addq	%r10, %rax
1400027b8:     	vmaxsd	%xmm3, %xmm4, %xmm3
1400027bc:     	vmovsd	0x30(%rax), %xmm4
1400027c1:     	vmulsd	0x1b1f(%rip), %xmm4, %xmm4 # 0x1400042e8
1400027c9:     	vmulsd	%xmm3, %xmm3, %xmm5
1400027cd:     	vmulsd	%xmm0, %xmm4, %xmm0
1400027d1:     	vdivsd	%xmm5, %xmm0, %xmm0
1400027d5:     	vmulsd	%xmm0, %xmm2, %xmm2
1400027d9:     	vmulsd	%xmm0, %xmm1, %xmm0
1400027dd:     	vdivsd	%xmm3, %xmm2, %xmm2
1400027e1:     	vdivsd	%xmm3, %xmm0, %xmm6
1400027e5:     	vmovsd	%xmm2, (%r8)
1400027ea:     	jmp	0x1400028b1 <.text+0x18b1>
1400027ef:     	movq	0x50(%rcx), %rax
1400027f3:     	movq	%r8, %rdi
1400027f6:     	movq	%r9, %rbx
1400027f9:     	movq	%rcx, %r14
1400027fc:     	testq	%rax, %rax
1400027ff:     	je	0x1400028cc <.text+0x18cc>
140002805:     	leaq	0x28(%rsp), %r8
14000280a:     	leaq	0x20(%rsp), %r9
14000280f:     	movq	%rax, %rcx
140002812:     	movl	%edx, %esi
140002814:     	callq	0x140002710 <.text+0x1710>
140002819:     	vxorpd	%xmm0, %xmm0, %xmm0
14000281d:     	vaddsd	0x28(%rsp), %xmm0, %xmm7
140002823:     	vaddsd	0x20(%rsp), %xmm0, %xmm6
140002829:     	movq	%r14, %rcx
14000282c:     	movq	0x58(%rcx), %rax
140002830:     	testq	%rax, %rax
140002833:     	je	0x140002858 <.text+0x1858>
140002835:     	leaq	0x28(%rsp), %r8
14000283a:     	leaq	0x20(%rsp), %r9
14000283f:     	movq	%rax, %rcx
140002842:     	movl	%esi, %edx
140002844:     	callq	0x140002710 <.text+0x1710>
140002849:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
14000284f:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
140002855:     	movq	%r14, %rcx
140002858:     	movq	0x60(%rcx), %rax
14000285c:     	testq	%rax, %rax
14000285f:     	je	0x140002884 <.text+0x1884>
140002861:     	leaq	0x28(%rsp), %r8
140002866:     	leaq	0x20(%rsp), %r9
14000286b:     	movq	%rax, %rcx
14000286e:     	movl	%esi, %edx
140002870:     	callq	0x140002710 <.text+0x1710>
140002875:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
14000287b:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
140002881:     	movq	%r14, %rcx
140002884:     	movq	0x68(%rcx), %rcx
140002888:     	testq	%rcx, %rcx
14000288b:     	je	0x1400028aa <.text+0x18aa>
14000288d:     	leaq	0x28(%rsp), %r8
140002892:     	leaq	0x20(%rsp), %r9
140002897:     	movl	%esi, %edx
140002899:     	callq	0x140002710 <.text+0x1710>
14000289e:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
1400028a4:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
1400028aa:     	movq	%rbx, %r9
1400028ad:     	vmovsd	%xmm7, (%rdi)
1400028b1:     	vmovsd	%xmm6, (%r9)
1400028b6:     	vmovaps	0x30(%rsp), %xmm6
1400028bc:     	vmovaps	0x40(%rsp), %xmm7
1400028c2:     	addq	$0x58, %rsp
1400028c6:     	popq	%rbx
1400028c7:     	popq	%rdi
1400028c8:     	popq	%rsi
1400028c9:     	popq	%r14
1400028cb:     	retq
1400028cc:     	movl	%edx, %esi
1400028ce:     	vxorpd	%xmm7, %xmm7, %xmm7
1400028d2:     	vxorpd	%xmm6, %xmm6, %xmm6
1400028d6:     	movq	0x58(%rcx), %rax
1400028da:     	testq	%rax, %rax
1400028dd:     	jne	0x140002835 <.text+0x1835>
1400028e3:     	jmp	0x140002858 <.text+0x1858>
1400028e8:     	nopl	(%rax,%rax)
1400028f0:     	pushq	%rsi
1400028f1:     	subq	$0x20, %rsp
1400028f5:     	testq	%rcx, %rcx
1400028f8:     	je	0x140002933 <.text+0x1933>
1400028fa:     	movq	0x50(%rcx), %rax
1400028fe:     	movq	%rcx, %rsi
140002901:     	movq	%rax, %rcx
140002904:     	callq	0x1400028f0 <.text+0x18f0>
140002909:     	movq	0x58(%rsi), %rcx
14000290d:     	callq	0x1400028f0 <.text+0x18f0>
140002912:     	movq	0x60(%rsi), %rcx
140002916:     	callq	0x1400028f0 <.text+0x18f0>
14000291b:     	movq	0x68(%rsi), %rcx
14000291f:     	callq	0x1400028f0 <.text+0x18f0>
140002924:     	movq	%rsi, %rcx
140002927:     	addq	$0x20, %rsp
14000292b:     	popq	%rsi
14000292c:     	jmpq	*0x175d(%rip)           # 0x140004090
140002933:     	nop
140002934:     	addq	$0x20, %rsp
140002938:     	popq	%rsi
140002939:     	retq
14000293a:     	int3
14000293b:     	int3
14000293c:     	int3
14000293d:     	int3
14000293e:     	int3
14000293f:     	int3
140002940:     	pushq	%rsi
140002941:     	pushq	%rdi
140002942:     	pushq	%rbx
140002943:     	subq	$0x30, %rsp
140002947:     	movq	%rcx, %rsi
14000294a:     	leaq	0x58(%rsp), %rbx
14000294f:     	movl	$0x1, %ecx
140002954:     	movq	%rdx, 0x58(%rsp)
140002959:     	movq	%r8, 0x60(%rsp)
14000295e:     	movq	%r9, 0x68(%rsp)
140002963:     	movq	%rbx, 0x28(%rsp)
140002968:     	callq	*0x180a(%rip)           # 0x140004178
14000296e:     	movq	%rax, %rdi
140002971:     	callq	0x1400029a0 <.text+0x19a0>
140002976:     	movq	(%rax), %rcx
140002979:     	movq	%rbx, 0x20(%rsp)
14000297e:     	movq	%rdi, %rdx
140002981:     	movq	%rsi, %r8
140002984:     	xorl	%r9d, %r9d
140002987:     	callq	*0x17f3(%rip)           # 0x140004180
14000298d:     	nop
14000298e:     	addq	$0x30, %rsp
140002992:     	popq	%rbx
140002993:     	popq	%rdi
140002994:     	popq	%rsi
140002995:     	retq
140002996:     	int3
140002997:     	int3
140002998:     	int3
140002999:     	int3
14000299a:     	int3
14000299b:     	int3
14000299c:     	int3
14000299d:     	int3
14000299e:     	int3
14000299f:     	int3
1400029a0:     	leaq	0x2701(%rip), %rax      # 0x1400050a8
1400029a7:     	retq
1400029a8:     	int3
1400029a9:     	int3
1400029aa:     	int3
1400029ab:     	int3
1400029ac:     	int3
1400029ad:     	int3
1400029ae:     	int3
1400029af:     	int3
1400029b0:     	jmpq	*0x170a(%rip)           # 0x1400040c0
1400029b6:     	jmpq	*0x16fc(%rip)           # 0x1400040b8
1400029bc:     	jmpq	*0x1706(%rip)           # 0x1400040c8
1400029c2:     	int3
1400029c3:     	int3
1400029c4:     	pushq	%rbx
1400029c6:     	subq	$0x20, %rsp
1400029ca:     	movl	$0x1, %ecx
1400029cf:     	callq	0x140003396 <.text+0x2396>
1400029d4:     	callq	0x140002f34 <.text+0x1f34>
1400029d9:     	movl	%eax, %ecx
1400029db:     	callq	0x1400033cc <.text+0x23cc>
1400029e0:     	callq	0x140002f28 <.text+0x1f28>
1400029e5:     	movl	%eax, %ebx
1400029e7:     	callq	0x1400033fc <.text+0x23fc>
1400029ec:     	movl	$0x1, %ecx
1400029f1:     	movl	%ebx, (%rax)
1400029f3:     	callq	0x140002cb0 <.text+0x1cb0>
1400029f8:     	testb	%al, %al
1400029fa:     	je	0x140002a6f <.text+0x1a6f>
1400029fc:     	callq	0x140003064 <.text+0x2064>
140002a01:     	leaq	0x698(%rip), %rcx       # 0x1400030a0 <.text+0x20a0>
140002a08:     	callq	0x140002e60 <.text+0x1e60>
140002a0d:     	callq	0x140002f2c <.text+0x1f2c>
140002a12:     	movl	%eax, %ecx
140002a14:     	callq	0x1400033a2 <.text+0x23a2>
140002a19:     	testl	%eax, %eax
140002a1b:     	jne	0x140002a6f <.text+0x1a6f>
140002a1d:     	callq	0x140002f3c <.text+0x1f3c>
140002a22:     	callq	0x140002f78 <.text+0x1f78>
140002a27:     	testl	%eax, %eax
140002a29:     	je	0x140002a37 <.text+0x1a37>
140002a2b:     	leaq	0x4f6(%rip), %rcx       # 0x140002f28 <.text+0x1f28>
140002a32:     	callq	0x14000339c <.text+0x239c>
140002a37:     	callq	0x140002f50 <.text+0x1f50>
140002a3c:     	callq	0x140002f50 <.text+0x1f50>
140002a41:     	callq	0x140002f28 <.text+0x1f28>
140002a46:     	movl	%eax, %ecx
140002a48:     	callq	0x1400033f0 <.text+0x23f0>
140002a4d:     	callq	0x140002f4c <.text+0x1f4c>
140002a52:     	testb	%al, %al
140002a54:     	je	0x140002a5b <.text+0x1a5b>
140002a56:     	callq	0x1400033a8 <.text+0x23a8>
140002a5b:     	callq	0x140002f28 <.text+0x1f28>
140002a60:     	callq	0x140002f9c <.text+0x1f9c>
140002a65:     	testl	%eax, %eax
140002a67:     	jne	0x140002a6f <.text+0x1a6f>
140002a69:     	addq	$0x20, %rsp
140002a6d:     	popq	%rbx
140002a6e:     	retq
140002a6f:     	movl	$0x7, %ecx
140002a74:     	callq	0x140002f94 <.text+0x1f94>
140002a79:     	int3
140002a7a:     	int3
140002a7b:     	int3
140002a7c:     	subq	$0x28, %rsp
140002a80:     	callq	0x140002f5c <.text+0x1f5c>
140002a85:     	xorl	%eax, %eax
140002a87:     	addq	$0x28, %rsp
140002a8b:     	retq
140002a8c:     	subq	$0x28, %rsp
140002a90:     	callq	0x140002ff8 <.text+0x1ff8>
140002a95:     	callq	0x140002f28 <.text+0x1f28>
140002a9a:     	movl	%eax, %ecx
140002a9c:     	addq	$0x28, %rsp
140002aa0:     	jmp	0x1400033f6 <.text+0x23f6>
140002aa5:     	int3
140002aa6:     	int3
140002aa7:     	int3
140002aa8:     	movq	%rbx, 0x8(%rsp)
140002aad:     	movq	%rsi, 0x10(%rsp)
140002ab2:     	pushq	%rdi
140002ab3:     	subq	$0x30, %rsp
140002ab7:     	movl	$0x1, %ecx
140002abc:     	callq	0x140002c74 <.text+0x1c74>
140002ac1:     	testb	%al, %al
140002ac3:     	je	0x140002bff <.text+0x1bff>
140002ac9:     	xorb	%sil, %sil
140002acc:     	movb	%sil, 0x20(%rsp)
140002ad1:     	callq	0x140002c38 <.text+0x1c38>
140002ad6:     	movb	%al, %bl
140002ad8:     	movl	0x25d2(%rip), %ecx      # 0x1400050b0
140002ade:     	cmpl	$0x1, %ecx
140002ae1:     	je	0x140002c0a <.text+0x1c0a>
140002ae7:     	testl	%ecx, %ecx
140002ae9:     	jne	0x140002b35 <.text+0x1b35>
140002aeb:     	movl	$0x1, 0x25bb(%rip)      # 0x1400050b0
140002af5:     	leaq	0x1714(%rip), %rdx      # 0x140004210
140002afc:     	leaq	0x16f5(%rip), %rcx      # 0x1400041f8
140002b03:     	callq	0x1400033ba <.text+0x23ba>
140002b08:     	testl	%eax, %eax
140002b0a:     	je	0x140002b16 <.text+0x1b16>
140002b0c:     	movl	$0xff, %eax
140002b11:     	jmp	0x140002bef <.text+0x1bef>
140002b16:     	leaq	0x16d3(%rip), %rdx      # 0x1400041f0
140002b1d:     	leaq	0x16bc(%rip), %rcx      # 0x1400041e0
140002b24:     	callq	0x1400033b4 <.text+0x23b4>
140002b29:     	movl	$0x2, 0x257d(%rip)      # 0x1400050b0
140002b33:     	jmp	0x140002b3d <.text+0x1b3d>
140002b35:     	movb	$0x1, %sil
140002b38:     	movb	%sil, 0x20(%rsp)
140002b3d:     	movb	%bl, %cl
140002b3f:     	callq	0x140002dd4 <.text+0x1dd4>
140002b44:     	callq	0x140002f84 <.text+0x1f84>
140002b49:     	movq	%rax, %rbx
140002b4c:     	cmpq	$0x0, (%rax)
140002b50:     	je	0x140002b70 <.text+0x1b70>
140002b52:     	movq	%rax, %rcx
140002b55:     	callq	0x140002d3c <.text+0x1d3c>
140002b5a:     	testb	%al, %al
140002b5c:     	je	0x140002b70 <.text+0x1b70>
140002b5e:     	xorl	%r8d, %r8d
140002b61:     	leal	0x2(%r8), %edx
140002b65:     	xorl	%ecx, %ecx
140002b67:     	movq	(%rbx), %rax
140002b6a:     	callq	*0x1648(%rip)           # 0x1400041b8
140002b70:     	callq	0x140002f8c <.text+0x1f8c>
140002b75:     	movq	%rax, %rbx
140002b78:     	cmpq	$0x0, (%rax)
140002b7c:     	je	0x140002b92 <.text+0x1b92>
140002b7e:     	movq	%rax, %rcx
140002b81:     	callq	0x140002d3c <.text+0x1d3c>
140002b86:     	testb	%al, %al
140002b88:     	je	0x140002b92 <.text+0x1b92>
140002b8a:     	movq	(%rbx), %rcx
140002b8d:     	callq	0x1400033ea <.text+0x23ea>
140002b92:     	callq	0x1400033ae <.text+0x23ae>
140002b97:     	movq	%rax, %rdi
140002b9a:     	callq	0x1400033d8 <.text+0x23d8>
140002b9f:     	movq	(%rax), %rbx
140002ba2:     	callq	0x1400033d2 <.text+0x23d2>
140002ba7:     	movq	%rdi, %r8
140002baa:     	movq	%rbx, %rdx
140002bad:     	movl	(%rax), %ecx
140002baf:     	callq	0x140001000 <.text>
140002bb4:     	movl	%eax, %ebx
140002bb6:     	callq	0x140002fa4 <.text+0x1fa4>
140002bbb:     	testb	%al, %al
140002bbd:     	je	0x140002c14 <.text+0x1c14>
140002bbf:     	testb	%sil, %sil
140002bc2:     	jne	0x140002bc9 <.text+0x1bc9>
140002bc4:     	callq	0x1400033de <.text+0x23de>
140002bc9:     	xorl	%edx, %edx
140002bcb:     	movb	$0x1, %cl
140002bcd:     	callq	0x140002df8 <.text+0x1df8>
140002bd2:     	movl	%ebx, %eax
140002bd4:     	jmp	0x140002bef <.text+0x1bef>
140002bd6:     	movl	%eax, %ebx
140002bd8:     	callq	0x140002fa4 <.text+0x1fa4>
140002bdd:     	testb	%al, %al
140002bdf:     	je	0x140002c1c <.text+0x1c1c>
140002be1:     	cmpb	$0x0, 0x20(%rsp)
140002be6:     	jne	0x140002bed <.text+0x1bed>
140002be8:     	callq	0x1400033e4 <.text+0x23e4>
140002bed:     	movl	%ebx, %eax
140002bef:     	movq	0x40(%rsp), %rbx
140002bf4:     	movq	0x48(%rsp), %rsi
140002bf9:     	addq	$0x30, %rsp
140002bfd:     	popq	%rdi
140002bfe:     	retq
140002bff:     	movl	$0x7, %ecx
140002c04:     	callq	0x140002f94 <.text+0x1f94>
140002c09:     	nop
140002c0a:     	movl	$0x7, %ecx
140002c0f:     	callq	0x140002f94 <.text+0x1f94>
140002c14:     	movl	%ebx, %ecx
140002c16:     	callq	0x1400033c0 <.text+0x23c0>
140002c1b:     	nop
140002c1c:     	movl	%ebx, %ecx
140002c1e:     	callq	0x1400033c6 <.text+0x23c6>
140002c23:     	nop
140002c24:     	subq	$0x28, %rsp
140002c28:     	callq	0x140002e78 <.text+0x1e78>
140002c2d:     	addq	$0x28, %rsp
140002c31:     	jmp	0x140002aa8 <.text+0x1aa8>
140002c36:     	int3
140002c37:     	int3
140002c38:     	subq	$0x28, %rsp
140002c3c:     	callq	0x140003378 <.text+0x2378>
140002c41:     	testl	%eax, %eax
140002c43:     	je	0x140002c66 <.text+0x1c66>
140002c45:     	movq	%gs:0x30, %rax
140002c4e:     	movq	0x8(%rax), %rcx
140002c52:     	jmp	0x140002c59 <.text+0x1c59>
140002c54:     	cmpq	%rax, %rcx
140002c57:     	je	0x140002c6d <.text+0x1c6d>
140002c59:     	xorl	%eax, %eax
140002c5b:     	lock
140002c5c:     	cmpxchgq	%rcx, 0x2454(%rip)      # 0x1400050b8
140002c64:     	jne	0x140002c54 <.text+0x1c54>
140002c66:     	xorb	%al, %al
140002c68:     	addq	$0x28, %rsp
140002c6c:     	retq
140002c6d:     	movb	$0x1, %al
140002c6f:     	jmp	0x140002c68 <.text+0x1c68>
140002c71:     	int3
140002c72:     	int3
140002c73:     	int3
140002c74:     	subq	$0x28, %rsp
140002c78:     	testl	%ecx, %ecx
140002c7a:     	jne	0x140002c83 <.text+0x1c83>
140002c7c:     	movb	$0x1, 0x243d(%rip)      # 0x1400050c0
140002c83:     	callq	0x1400030dc <.text+0x20dc>
140002c88:     	callq	0x140002f4c <.text+0x1f4c>
140002c8d:     	testb	%al, %al
140002c8f:     	jne	0x140002c95 <.text+0x1c95>
140002c91:     	xorb	%al, %al
140002c93:     	jmp	0x140002ca9 <.text+0x1ca9>
140002c95:     	callq	0x140002f4c <.text+0x1f4c>
140002c9a:     	testb	%al, %al
140002c9c:     	jne	0x140002ca7 <.text+0x1ca7>
140002c9e:     	xorl	%ecx, %ecx
140002ca0:     	callq	0x140002f4c <.text+0x1f4c>
140002ca5:     	jmp	0x140002c91 <.text+0x1c91>
140002ca7:     	movb	$0x1, %al
140002ca9:     	addq	$0x28, %rsp
140002cad:     	retq
140002cae:     	int3
140002caf:     	int3
140002cb0:     	pushq	%rbx
140002cb2:     	subq	$0x20, %rsp
140002cb6:     	cmpb	$0x0, 0x2404(%rip)      # 0x1400050c1
140002cbd:     	movl	%ecx, %ebx
140002cbf:     	jne	0x140002d28 <.text+0x1d28>
140002cc1:     	cmpl	$0x1, %ecx
140002cc4:     	ja	0x140002d30 <.text+0x1d30>
140002cc6:     	callq	0x140003378 <.text+0x2378>
140002ccb:     	testl	%eax, %eax
140002ccd:     	je	0x140002cf7 <.text+0x1cf7>
140002ccf:     	testl	%ebx, %ebx
140002cd1:     	jne	0x140002cf7 <.text+0x1cf7>
140002cd3:     	leaq	0x23ee(%rip), %rcx      # 0x1400050c8
140002cda:     	callq	0x140003402 <.text+0x2402>
140002cdf:     	testl	%eax, %eax
140002ce1:     	jne	0x140002cf3 <.text+0x1cf3>
140002ce3:     	leaq	0x23f6(%rip), %rcx      # 0x1400050e0
140002cea:     	callq	0x140003402 <.text+0x2402>
140002cef:     	testl	%eax, %eax
140002cf1:     	je	0x140002d21 <.text+0x1d21>
140002cf3:     	xorb	%al, %al
140002cf5:     	jmp	0x140002d2a <.text+0x1d2a>
140002cf7:     	movdqa	0x1651(%rip), %xmm0     # 0x140004350
140002cff:     	orq	$-0x1, %rax
140002d03:     	movdqu	%xmm0, 0x23bd(%rip)     # 0x1400050c8
140002d0b:     	movq	%rax, 0x23c6(%rip)      # 0x1400050d8
140002d12:     	movdqu	%xmm0, 0x23c6(%rip)     # 0x1400050e0
140002d1a:     	movq	%rax, 0x23cf(%rip)      # 0x1400050f0
140002d21:     	movb	$0x1, 0x2399(%rip)      # 0x1400050c1
140002d28:     	movb	$0x1, %al
140002d2a:     	addq	$0x20, %rsp
140002d2e:     	popq	%rbx
140002d2f:     	retq
140002d30:     	movl	$0x5, %ecx
140002d35:     	callq	0x140002f94 <.text+0x1f94>
140002d3a:     	int3
140002d3b:     	int3
140002d3c:     	subq	$0x18, %rsp
140002d40:     	movq	%rcx, %r8
140002d43:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
140002d48:     	cmpw	%ax, -0x2d4f(%rip)      # 0x140000000
140002d4f:     	jne	0x140002dc9 <.text+0x1dc9>
140002d51:     	movslq	-0x2d1c(%rip), %rcx     # 0x14000003c
140002d58:     	leaq	-0x2d5f(%rip), %rdx     # 0x140000000
140002d5f:     	addq	%rdx, %rcx
140002d62:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
140002d68:     	jne	0x140002dc9 <.text+0x1dc9>
140002d6a:     	movl	$0x20b, %eax            # imm = 0x20B
140002d6f:     	cmpw	%ax, 0x18(%rcx)
140002d73:     	jne	0x140002dc9 <.text+0x1dc9>
140002d75:     	subq	%rdx, %r8
140002d78:     	movzwl	0x14(%rcx), %edx
140002d7c:     	addq	$0x18, %rdx
140002d80:     	addq	%rcx, %rdx
140002d83:     	movzwl	0x6(%rcx), %eax
140002d87:     	leaq	(%rax,%rax,4), %rcx
140002d8b:     	leaq	(%rdx,%rcx,8), %r9
140002d8f:     	movq	%rdx, (%rsp)
140002d93:     	cmpq	%r9, %rdx
140002d96:     	je	0x140002db0 <.text+0x1db0>
140002d98:     	movl	0xc(%rdx), %ecx
140002d9b:     	cmpq	%rcx, %r8
140002d9e:     	jb	0x140002daa <.text+0x1daa>
140002da0:     	movl	0x8(%rdx), %eax
140002da3:     	addl	%ecx, %eax
140002da5:     	cmpq	%rax, %r8
140002da8:     	jb	0x140002db2 <.text+0x1db2>
140002daa:     	addq	$0x28, %rdx
140002dae:     	jmp	0x140002d8f <.text+0x1d8f>
140002db0:     	xorl	%edx, %edx
140002db2:     	testq	%rdx, %rdx
140002db5:     	jne	0x140002dbb <.text+0x1dbb>
140002db7:     	xorb	%al, %al
140002db9:     	jmp	0x140002dcf <.text+0x1dcf>
140002dbb:     	cmpl	$0x0, 0x24(%rdx)
140002dbf:     	jge	0x140002dc5 <.text+0x1dc5>
140002dc1:     	xorb	%al, %al
140002dc3:     	jmp	0x140002dcf <.text+0x1dcf>
140002dc5:     	movb	$0x1, %al
140002dc7:     	jmp	0x140002dcf <.text+0x1dcf>
140002dc9:     	xorb	%al, %al
140002dcb:     	jmp	0x140002dcf <.text+0x1dcf>
140002dcd:     	xorb	%al, %al
140002dcf:     	addq	$0x18, %rsp
140002dd3:     	retq
140002dd4:     	pushq	%rbx
140002dd6:     	subq	$0x20, %rsp
140002dda:     	movb	%cl, %bl
140002ddc:     	callq	0x140003378 <.text+0x2378>
140002de1:     	xorl	%edx, %edx
140002de3:     	testl	%eax, %eax
140002de5:     	je	0x140002df2 <.text+0x1df2>
140002de7:     	testb	%bl, %bl
140002de9:     	jne	0x140002df2 <.text+0x1df2>
140002deb:     	xchgq	%rdx, 0x22c6(%rip)      # 0x1400050b8
140002df2:     	addq	$0x20, %rsp
140002df6:     	popq	%rbx
140002df7:     	retq
140002df8:     	pushq	%rbx
140002dfa:     	subq	$0x20, %rsp
140002dfe:     	cmpb	$0x0, 0x22bb(%rip)      # 0x1400050c0
140002e05:     	movb	%cl, %bl
140002e07:     	je	0x140002e0d <.text+0x1e0d>
140002e09:     	testb	%dl, %dl
140002e0b:     	jne	0x140002e19 <.text+0x1e19>
140002e0d:     	callq	0x140002f4c <.text+0x1f4c>
140002e12:     	movb	%bl, %cl
140002e14:     	callq	0x140002f4c <.text+0x1f4c>
140002e19:     	movb	$0x1, %al
140002e1b:     	addq	$0x20, %rsp
140002e1f:     	popq	%rbx
140002e20:     	retq
140002e21:     	int3
140002e22:     	int3
140002e23:     	int3
140002e24:     	pushq	%rbx
140002e26:     	subq	$0x20, %rsp
140002e2a:     	cmpq	$-0x1, 0x2296(%rip)     # 0x1400050c8
140002e32:     	movq	%rcx, %rbx
140002e35:     	jne	0x140002e3e <.text+0x1e3e>
140002e37:     	callq	0x14000340e <.text+0x240e>
140002e3c:     	jmp	0x140002e4d <.text+0x1e4d>
140002e3e:     	movq	%rbx, %rdx
140002e41:     	leaq	0x2280(%rip), %rcx      # 0x1400050c8
140002e48:     	callq	0x140003408 <.text+0x2408>
140002e4d:     	xorl	%edx, %edx
140002e4f:     	testl	%eax, %eax
140002e51:     	cmoveq	%rbx, %rdx
140002e55:     	movq	%rdx, %rax
140002e58:     	addq	$0x20, %rsp
140002e5c:     	popq	%rbx
140002e5d:     	retq
140002e5e:     	int3
140002e5f:     	int3
140002e60:     	subq	$0x28, %rsp
140002e64:     	callq	0x140002e24 <.text+0x1e24>
140002e69:     	negq	%rax
140002e6c:     	sbbl	%eax, %eax
140002e6e:     	negl	%eax
140002e70:     	decl	%eax
140002e72:     	addq	$0x28, %rsp
140002e76:     	retq
140002e77:     	int3
140002e78:     	movq	%rbx, 0x18(%rsp)
140002e7d:     	pushq	%rbp
140002e7e:     	movq	%rsp, %rbp
140002e81:     	subq	$0x30, %rsp
140002e85:     	movq	0x21b4(%rip), %rax      # 0x140005040
140002e8c:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
140002e96:     	cmpq	%rbx, %rax
140002e99:     	jne	0x140002f12 <.text+0x1f12>
140002e9b:     	leaq	0x10(%rbp), %rcx
140002e9f:     	movq	$0x0, 0x10(%rbp)
140002ea7:     	callq	*0x1163(%rip)           # 0x140004010
140002ead:     	movq	0x10(%rbp), %rax
140002eb1:     	movq	%rax, -0x10(%rbp)
140002eb5:     	callq	*0x114d(%rip)           # 0x140004008
140002ebb:     	movl	%eax, %eax
140002ebd:     	xorq	%rax, -0x10(%rbp)
140002ec1:     	callq	*0x1169(%rip)           # 0x140004030
140002ec7:     	movl	%eax, %eax
140002ec9:     	leaq	0x18(%rbp), %rcx
140002ecd:     	xorq	%rax, -0x10(%rbp)
140002ed1:     	callq	*0x1129(%rip)           # 0x140004000
140002ed7:     	movl	0x18(%rbp), %eax
140002eda:     	leaq	-0x10(%rbp), %rcx
140002ede:     	shlq	$0x20, %rax
140002ee2:     	xorq	0x18(%rbp), %rax
140002ee6:     	xorq	-0x10(%rbp), %rax
140002eea:     	xorq	%rcx, %rax
140002eed:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
140002ef7:     	andq	%rcx, %rax
140002efa:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
140002f04:     	cmpq	%rbx, %rax
140002f07:     	cmoveq	%rcx, %rax
140002f0b:     	movq	%rax, 0x212e(%rip)      # 0x140005040
140002f12:     	movq	0x50(%rsp), %rbx
140002f17:     	notq	%rax
140002f1a:     	movq	%rax, 0x215f(%rip)      # 0x140005080
140002f21:     	addq	$0x30, %rsp
140002f25:     	popq	%rbp
140002f26:     	retq
140002f27:     	int3
140002f28:     	xorl	%eax, %eax
140002f2a:     	retq
140002f2b:     	int3
140002f2c:     	movl	$0x1, %eax
140002f31:     	retq
140002f32:     	int3
140002f33:     	int3
140002f34:     	movl	$0x4000, %eax           # imm = 0x4000
140002f39:     	retq
140002f3a:     	int3
140002f3b:     	int3
140002f3c:     	leaq	0x21bd(%rip), %rcx      # 0x140005100
140002f43:     	jmpq	*0x10ce(%rip)           # 0x140004018
140002f4a:     	int3
140002f4b:     	int3
140002f4c:     	movb	$0x1, %al
140002f4e:     	retq
140002f4f:     	int3
140002f50:     	retq	$0x0
140002f53:     	int3
140002f54:     	leaq	0x21b5(%rip), %rax      # 0x140005110
140002f5b:     	retq
140002f5c:     	subq	$0x28, %rsp
140002f60:     	callq	0x1400029a0 <.text+0x19a0>
140002f65:     	orq	$0x24, (%rax)
140002f69:     	callq	0x140002f54 <.text+0x1f54>
140002f6e:     	orq	$0x2, (%rax)
140002f72:     	addq	$0x28, %rsp
140002f76:     	retq
140002f77:     	int3
140002f78:     	xorl	%eax, %eax
140002f7a:     	cmpl	%eax, 0x2088(%rip)      # 0x140005008
140002f80:     	sete	%al
140002f83:     	retq
140002f84:     	leaq	0x21a5(%rip), %rax      # 0x140005130
140002f8b:     	retq
140002f8c:     	leaq	0x2195(%rip), %rax      # 0x140005128
140002f93:     	retq
140002f94:     	movl	%ecx, %ecx
140002f96:     	int	$0x29
140002f98:     	retq
140002f99:     	int3
140002f9a:     	int3
140002f9b:     	int3
140002f9c:     	jmp	0x140002f28 <.text+0x1f28>
140002fa1:     	int3
140002fa2:     	int3
140002fa3:     	int3
140002fa4:     	subq	$0x28, %rsp
140002fa8:     	xorl	%ecx, %ecx
140002faa:     	callq	*0x1078(%rip)           # 0x140004028
140002fb0:     	testq	%rax, %rax
140002fb3:     	je	0x140002fef <.text+0x1fef>
140002fb5:     	movl	$0x5a4d, %ecx           # imm = 0x5A4D
140002fba:     	cmpw	%cx, (%rax)
140002fbd:     	jne	0x140002fef <.text+0x1fef>
140002fbf:     	movslq	0x3c(%rax), %rcx
140002fc3:     	cmpl	$0x4550, (%rcx,%rax)    # imm = 0x4550
140002fca:     	jne	0x140002fef <.text+0x1fef>
140002fcc:     	movl	$0x20b, %edx            # imm = 0x20B
140002fd1:     	cmpw	%dx, 0x18(%rcx,%rax)
140002fd6:     	jne	0x140002fef <.text+0x1fef>
140002fd8:     	cmpl	$0xe, 0x84(%rcx,%rax)
140002fe0:     	jbe	0x140002fef <.text+0x1fef>
140002fe2:     	cmpl	$0x0, 0xf8(%rcx,%rax)
140002fea:     	setne	%al
140002fed:     	jmp	0x140002ff1 <.text+0x1ff1>
140002fef:     	xorb	%al, %al
140002ff1:     	addq	$0x28, %rsp
140002ff5:     	retq
140002ff6:     	int3
140002ff7:     	int3
140002ff8:     	leaq	0x9(%rip), %rcx         # 0x140003008 <.text+0x2008>
140002fff:     	jmpq	*0x101a(%rip)           # 0x140004020
140003006:     	int3
140003007:     	int3
140003008:     	movq	%rbx, 0x8(%rsp)
14000300d:     	pushq	%rdi
14000300e:     	subq	$0x20, %rsp
140003012:     	movq	(%rcx), %rbx
140003015:     	movq	%rcx, %rdi
140003018:     	cmpl	$0xe06d7363, (%rbx)     # imm = 0xE06D7363
14000301e:     	jne	0x14000303c <.text+0x203c>
140003020:     	cmpl	$0x4, 0x18(%rbx)
140003024:     	jne	0x14000303c <.text+0x203c>
140003026:     	movl	0x20(%rbx), %edx
140003029:     	leal	-0x19930520(%rdx), %eax
14000302f:     	cmpl	$0x2, %eax
140003032:     	jbe	0x140003049 <.text+0x2049>
140003034:     	cmpl	$0x1994000, %edx        # imm = 0x1994000
14000303a:     	je	0x140003049 <.text+0x2049>
14000303c:     	movq	0x30(%rsp), %rbx
140003041:     	xorl	%eax, %eax
140003043:     	addq	$0x20, %rsp
140003047:     	popq	%rdi
140003048:     	retq
140003049:     	callq	0x140003420 <.text+0x2420>
14000304e:     	movq	%rbx, (%rax)
140003051:     	movq	0x8(%rdi), %rbx
140003055:     	callq	0x140003426 <.text+0x2426>
14000305a:     	movq	%rbx, (%rax)
14000305d:     	callq	0x140003414 <.text+0x2414>
140003062:     	int3
140003063:     	int3
140003064:     	movq	%rbx, 0x8(%rsp)
140003069:     	pushq	%rdi
14000306a:     	subq	$0x20, %rsp
14000306e:     	leaq	0x174b(%rip), %rbx      # 0x1400047c0
140003075:     	leaq	0x1744(%rip), %rdi      # 0x1400047c0
14000307c:     	jmp	0x140003090 <.text+0x2090>
14000307e:     	movq	(%rbx), %rax
140003081:     	testq	%rax, %rax
140003084:     	je	0x14000308c <.text+0x208c>
140003086:     	callq	*0x112c(%rip)           # 0x1400041b8
14000308c:     	addq	$0x8, %rbx
140003090:     	cmpq	%rdi, %rbx
140003093:     	jb	0x14000307e <.text+0x207e>
140003095:     	movq	0x30(%rsp), %rbx
14000309a:     	addq	$0x20, %rsp
14000309e:     	popq	%rdi
14000309f:     	retq
1400030a0:     	movq	%rbx, 0x8(%rsp)
1400030a5:     	pushq	%rdi
1400030a6:     	subq	$0x20, %rsp
1400030aa:     	leaq	0x171f(%rip), %rbx      # 0x1400047d0
1400030b1:     	leaq	0x1718(%rip), %rdi      # 0x1400047d0
1400030b8:     	jmp	0x1400030cc <.text+0x20cc>
1400030ba:     	movq	(%rbx), %rax
1400030bd:     	testq	%rax, %rax
1400030c0:     	je	0x1400030c8 <.text+0x20c8>
1400030c2:     	callq	*0x10f0(%rip)           # 0x1400041b8
1400030c8:     	addq	$0x8, %rbx
1400030cc:     	cmpq	%rdi, %rbx
1400030cf:     	jb	0x1400030ba <.text+0x20ba>
1400030d1:     	movq	0x30(%rsp), %rbx
1400030d6:     	addq	$0x20, %rsp
1400030da:     	popq	%rdi
1400030db:     	retq
1400030dc:     	movq	%rbx, 0x10(%rsp)
1400030e1:     	movq	%rbp, 0x18(%rsp)
1400030e6:     	movq	%rsi, 0x20(%rsp)
1400030eb:     	pushq	%rdi
1400030ec:     	subq	$0x10, %rsp
1400030f0:     	xorl	%eax, %eax
1400030f2:     	xorl	%ecx, %ecx
1400030f4:     	cpuid
1400030f6:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
1400030fc:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
140003102:     	orl	%ecx, %edx
140003104:     	movl	%eax, %ebp
140003106:     	movl	$0x1, %eax
14000310b:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
140003111:     	orl	%ebx, %edx
140003113:     	leal	-0x1(%rax), %ecx
140003116:     	cpuid
140003118:     	movl	%ecx, %edi
14000311a:     	jne	0x14000317a <.text+0x217a>
14000311c:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
140003121:     	movq	$0x8000, 0x1eec(%rip)   # imm = 0x8000
                                                # 0x140005018
14000312c:     	movq	$-0x1, 0x1ee9(%rip)     # 0x140005020
140003137:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
14000313c:     	je	0x140003166 <.text+0x2166>
14000313e:     	cmpl	$0x20660, %eax          # imm = 0x20660
140003143:     	je	0x140003166 <.text+0x2166>
140003145:     	cmpl	$0x20670, %eax          # imm = 0x20670
14000314a:     	je	0x140003166 <.text+0x2166>
14000314c:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
140003151:     	cmpl	$0x20, %eax
140003154:     	ja	0x14000317a <.text+0x217a>
140003156:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
140003160:     	btq	%rax, %rcx
140003164:     	jae	0x14000317a <.text+0x217a>
140003166:     	movl	0x1faf(%rip), %r8d      # 0x14000511c
14000316d:     	orl	$0x1, %r8d
140003171:     	movl	%r8d, 0x1fa4(%rip)      # 0x14000511c
140003178:     	jmp	0x140003181 <.text+0x2181>
14000317a:     	movl	0x1f9b(%rip), %r8d      # 0x14000511c
140003181:     	xorl	%r9d, %r9d
140003184:     	movl	%r9d, %r11d
140003187:     	cmpl	$0x7, %ebp
14000318a:     	jl	0x1400031ce <.text+0x21ce>
14000318c:     	xorl	%ecx, %ecx
14000318e:     	leal	0x7(%r9), %eax
140003192:     	cpuid
140003194:     	movl	%edx, %esi
140003196:     	movl	%ebx, %r10d
140003199:     	btl	$0x9, %ebx
14000319d:     	jae	0x1400031aa <.text+0x21aa>
14000319f:     	orl	$0x2, %r8d
1400031a3:     	movl	%r8d, 0x1f72(%rip)      # 0x14000511c
1400031aa:     	cmpl	$0x1, %eax
1400031ad:     	jl	0x1400031bc <.text+0x21bc>
1400031af:     	movl	$0x7, %eax
1400031b4:     	leal	-0x6(%rax), %ecx
1400031b7:     	cpuid
1400031b9:     	movl	%edx, %r9d
1400031bc:     	movl	$0x24, %eax
1400031c1:     	cmpl	%eax, %ebp
1400031c3:     	jl	0x1400031d4 <.text+0x21d4>
1400031c5:     	xorl	%ecx, %ecx
1400031c7:     	cpuid
1400031c9:     	movl	%ebx, %r11d
1400031cc:     	jmp	0x1400031d4 <.text+0x21d4>
1400031ce:     	movl	%r9d, %r10d
1400031d1:     	movl	%r9d, %esi
1400031d4:     	movq	0x1e4d(%rip), %rax      # 0x140005028
1400031db:     	andq	$-0x2, %rax
1400031df:     	movl	$0x1, 0x1e27(%rip)      # 0x140005010
1400031e9:     	movl	$0x2, 0x1e21(%rip)      # 0x140005014
1400031f3:     	movq	%rax, 0x1e2e(%rip)      # 0x140005028
1400031fa:     	btl	$0x14, %edi
1400031fe:     	jae	0x14000321f <.text+0x221f>
140003200:     	andq	$-0x11, %rax
140003204:     	movl	$0x2, 0x1e02(%rip)      # 0x140005010
14000320e:     	movq	%rax, 0x1e13(%rip)      # 0x140005028
140003215:     	movl	$0x6, 0x1df5(%rip)      # 0x140005014
14000321f:     	btl	$0x1b, %edi
140003223:     	jae	0x140003360 <.text+0x2360>
140003229:     	xorl	%ecx, %ecx
14000322b:     	xgetbv
14000322e:     	shlq	$0x20, %rdx
140003232:     	orq	%rax, %rdx
140003235:     	movq	%rdx, 0x20(%rsp)
14000323a:     	btl	$0x1c, %edi
14000323e:     	jae	0x140003344 <.text+0x2344>
140003244:     	movq	0x20(%rsp), %rax
140003249:     	andb	$0x6, %al
14000324b:     	cmpb	$0x6, %al
14000324d:     	jne	0x140003344 <.text+0x2344>
140003253:     	movl	0x1dbb(%rip), %eax      # 0x140005014
140003259:     	movb	$-0x20, %dl
14000325b:     	orl	$0x8, %eax
14000325e:     	movl	$0x3, 0x1da8(%rip)      # 0x140005010
140003268:     	movl	%eax, 0x1da6(%rip)      # 0x140005014
14000326e:     	testb	$0x20, %r10b
140003272:     	je	0x1400032d6 <.text+0x22d6>
140003274:     	orl	$0x20, %eax
140003277:     	movl	$0x5, 0x1d8f(%rip)      # 0x140005010
140003281:     	movl	%eax, 0x1d8d(%rip)      # 0x140005014
140003287:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
14000328c:     	movq	0x1d95(%rip), %rax      # 0x140005028
140003293:     	andl	%ecx, %r10d
140003296:     	andq	$-0x3, %rax
14000329a:     	movq	%rax, 0x1d87(%rip)      # 0x140005028
1400032a1:     	cmpl	%ecx, %r10d
1400032a4:     	jne	0x1400032dd <.text+0x22dd>
1400032a6:     	movq	0x20(%rsp), %rax
1400032ab:     	andb	%dl, %al
1400032ad:     	cmpb	%dl, %al
1400032af:     	jne	0x1400032d6 <.text+0x22d6>
1400032b1:     	movq	0x1d70(%rip), %rax      # 0x140005028
1400032b8:     	orl	$0x40, 0x1d55(%rip)     # 0x140005014
1400032bf:     	andq	$-0x25, %rax
1400032c3:     	movl	$0x6, 0x1d43(%rip)      # 0x140005010
1400032cd:     	movq	%rax, 0x1d54(%rip)      # 0x140005028
1400032d4:     	jmp	0x1400032dd <.text+0x22dd>
1400032d6:     	movq	0x1d4b(%rip), %rax      # 0x140005028
1400032dd:     	btl	$0x17, %esi
1400032e1:     	jae	0x1400032ef <.text+0x22ef>
1400032e3:     	btrq	$0x18, %rax
1400032e8:     	movq	%rax, 0x1d39(%rip)      # 0x140005028
1400032ef:     	btl	$0x13, %r9d
1400032f4:     	jae	0x140003344 <.text+0x2344>
1400032f6:     	movq	0x20(%rsp), %rax
1400032fb:     	andb	%dl, %al
1400032fd:     	cmpb	%dl, %al
1400032ff:     	jne	0x140003344 <.text+0x2344>
140003301:     	movq	0x1d20(%rip), %rdx      # 0x140005028
140003308:     	movl	%r11d, %eax
14000330b:     	shrq	$0x10, %rax
14000330f:     	movl	%r11d, %ecx
140003312:     	andl	$0x6, %eax
140003315:     	andl	$0x400ff, %ecx          # imm = 0x400FF
14000331b:     	orq	$0x1000029, %rax        # imm = 0x1000029
140003321:     	movl	%ecx, 0x1df9(%rip)      # 0x140005120
140003327:     	notq	%rax
14000332a:     	andq	%rax, %rdx
14000332d:     	movq	%rdx, 0x1cf4(%rip)      # 0x140005028
140003334:     	cmpb	$0x1, %cl
140003337:     	jbe	0x140003344 <.text+0x2344>
140003339:     	andq	$-0x41, %rdx
14000333d:     	movq	%rdx, 0x1ce4(%rip)      # 0x140005028
140003344:     	btl	$0x15, %r9d
140003349:     	jae	0x140003360 <.text+0x2360>
14000334b:     	movq	0x20(%rsp), %rax
140003350:     	btq	$0x13, %rax
140003355:     	jae	0x140003360 <.text+0x2360>
140003357:     	btrq	$0x7, 0x1cc8(%rip)      # 0x140005028
140003360:     	movq	0x28(%rsp), %rbx
140003365:     	xorl	%eax, %eax
140003367:     	movq	0x30(%rsp), %rbp
14000336c:     	movq	0x38(%rsp), %rsi
140003371:     	addq	$0x10, %rsp
140003375:     	popq	%rdi
140003376:     	retq
140003377:     	int3
140003378:     	xorl	%eax, %eax
14000337a:     	cmpl	%eax, 0x1d10(%rip)      # 0x140005090
140003380:     	setne	%al
140003383:     	retq
140003384:     	int3
140003385:     	int3
140003386:     	int3
140003387:     	int3
140003388:     	int3
140003389:     	int3
14000338a:     	int3
14000338b:     	int3
14000338c:     	int3
14000338d:     	int3
14000338e:     	int3
14000338f:     	int3
140003390:     	jmpq	*0xd9a(%rip)            # 0x140004130
140003396:     	jmpq	*0xd8c(%rip)            # 0x140004128
14000339c:     	jmpq	*0xd0e(%rip)            # 0x1400040b0
1400033a2:     	jmpq	*0xd50(%rip)            # 0x1400040f8
1400033a8:     	jmpq	*0xd8a(%rip)            # 0x140004138
1400033ae:     	jmpq	*0xd64(%rip)            # 0x140004118
1400033b4:     	jmpq	*0xd1e(%rip)            # 0x1400040d8
1400033ba:     	jmpq	*0xd20(%rip)            # 0x1400040e0
1400033c0:     	jmpq	*0xd22(%rip)            # 0x1400040e8
1400033c6:     	jmpq	*0xd24(%rip)            # 0x1400040f0
1400033cc:     	jmpq	*0xd9e(%rip)            # 0x140004170
1400033d2:     	jmpq	*0xd28(%rip)            # 0x140004100
1400033d8:     	jmpq	*0xd2a(%rip)            # 0x140004108
1400033de:     	jmpq	*0xd2c(%rip)            # 0x140004110
1400033e4:     	jmpq	*0xd76(%rip)            # 0x140004160
1400033ea:     	jmpq	*0xd30(%rip)            # 0x140004120
1400033f0:     	jmpq	*0xcaa(%rip)            # 0x1400040a0
1400033f6:     	jmpq	*0xc8c(%rip)            # 0x140004088
1400033fc:     	jmpq	*0xd86(%rip)            # 0x140004188
140003402:     	jmpq	*0xd38(%rip)            # 0x140004140
140003408:     	jmpq	*0xd3a(%rip)            # 0x140004148
14000340e:     	jmpq	*0xd3c(%rip)            # 0x140004150
140003414:     	jmpq	*0xd3e(%rip)            # 0x140004158
14000341a:     	jmpq	*0xc20(%rip)            # 0x140004040
140003420:     	jmpq	*0xc22(%rip)            # 0x140004048
140003426:     	jmpq	*0xc24(%rip)            # 0x140004050
14000342c:     	jmpq	*0xc26(%rip)            # 0x140004058
140003432:     	int3
140003433:     	int3
140003434:     	int3
140003435:     	int3
140003436:     	int3
140003437:     	int3
140003438:     	int3
140003439:     	int3
14000343a:     	int3
14000343b:     	int3
14000343c:     	int3
14000343d:     	int3
14000343e:     	int3
14000343f:     	int3
140003440:     	int3
140003441:     	int3
140003442:     	int3
140003443:     	int3
140003444:     	int3
140003445:     	int3
140003446:     	nopw	(%rax,%rax)
140003450:     	jmpq	*%rax
140003452:     	int3
140003453:     	int3
140003454:     	int3
140003455:     	int3
140003456:     	int3
140003457:     	int3
140003458:     	int3
140003459:     	int3
14000345a:     	int3
14000345b:     	int3
14000345c:     	int3
14000345d:     	int3
14000345e:     	int3
14000345f:     	int3
140003460:     	int3
140003461:     	int3
140003462:     	int3
140003463:     	int3
140003464:     	int3
140003465:     	int3
140003466:     	nopw	(%rax,%rax)
140003470:     	jmpq	*0xd42(%rip)            # 0x1400041b8
140003476:     	pushq	%rbp
140003478:     	subq	$0x20, %rsp
14000347c:     	movq	%rdx, %rbp
14000347f:     	movq	%rcx, %rdx
140003482:     	movq	(%rcx), %rcx
140003485:     	movl	(%rcx), %ecx
140003487:     	callq	0x140003390 <.text+0x2390>
14000348c:     	nop
14000348d:     	addq	$0x20, %rsp
140003491:     	popq	%rbp
140003492:     	retq
140003493:     	int3
140003494:     	pushq	%rbp
140003496:     	movq	%rdx, %rbp
140003499:     	movq	(%rcx), %rax
14000349c:     	xorl	%ecx, %ecx
14000349e:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
1400034a4:     	sete	%cl
1400034a7:     	movl	%ecx, %eax
1400034a9:     	popq	%rbp
1400034aa:     	retq
1400034ab:     	int3
