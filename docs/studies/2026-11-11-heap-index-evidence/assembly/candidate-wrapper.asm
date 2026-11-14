# Existing measured PE, candidate wrapper: [0x1800019e0, 0x180002200)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
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
