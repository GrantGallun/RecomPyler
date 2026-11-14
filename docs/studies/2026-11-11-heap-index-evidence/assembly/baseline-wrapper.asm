# Existing measured PE, baseline wrapper: [0x180001d20, 0x180002540)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
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
