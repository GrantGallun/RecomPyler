# raytrace-current blue-index-store: [0x180002e4e, 0x180002ea4)
# Source/call-target-bound static range; counts include padding, never cycles.
180002e4e:     	movq	(%rbx,%r12,8), %rdx
180002e52:     	movq	%rdx, %r9
180002e55:     	sarq	$0x3f, %r9
180002e59:     	andq	0x260(%rsp), %r9
180002e61:     	testq	%rax, %rax
180002e64:     	leaq	(%rbx,%rdx,8), %rax
180002e68:     	movq	(%rax,%r9,8), %r9
180002e6c:     	jns	0x180002e73 <PyInit_rcaotr_61fae00d4878711302f71448+0x1503>
180002e6e:     	addq	%r9, %rcx
180002e71:     	js	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e73:     	cmpq	%r9, %rcx
180002e76:     	jge	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e78:     	cmpq	$-0x2, %rdx
180002e7c:     	movl	$0x0, %edx
180002e81:     	movq	0x260(%rsp), %r9
180002e89:     	cmovlq	%r9, %rdx
180002e8d:     	addq	0x10(%rax,%rdx,8), %rcx
180002e92:     	movq	%rcx, %rax
180002e95:     	sarq	$0x3f, %rax
180002e99:     	andq	%r9, %rax
180002e9c:     	leaq	(%rbx,%rcx,8), %rcx
180002ea0:     	movq	%r8, (%rcx,%rax,8)
