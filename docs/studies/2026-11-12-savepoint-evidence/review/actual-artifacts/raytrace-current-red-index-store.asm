# raytrace-current red-index-store: [0x180002c7a, 0x180002cdf)
# Source/call-target-bound static range; counts include padding, never cycles.
180002c7a:     	movq	(%rbx,%r12,8), %r9
180002c7e:     	movq	%r9, %r8
180002c81:     	sarq	$0x3f, %r8
180002c85:     	andq	0x260(%rsp), %r8
180002c8d:     	leaq	(%rbx,%r9,8), %r10
180002c91:     	movq	(%r10,%r8,8), %r11
180002c95:     	testq	%rax, %rax
180002c98:     	movq	%rcx, %r8
180002c9b:     	jns	0x180002ca9 <PyInit_rcaotr_61fae00d4878711302f71448+0x1339>
180002c9d:     	movq	%r11, %r8
180002ca0:     	addq	%rcx, %r8
180002ca3:     	js	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002ca9:     	cmpq	%r11, %r8
180002cac:     	jge	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002cb2:     	cmpq	$-0x2, %r9
180002cb6:     	movl	$0x0, %r9d
180002cbc:     	movq	0x260(%rsp), %r11
180002cc4:     	cmovlq	%r11, %r9
180002cc8:     	addq	0x10(%r10,%r9,8), %r8
180002ccd:     	movq	%r8, %r9
180002cd0:     	sarq	$0x3f, %r9
180002cd4:     	andq	%r11, %r9
180002cd7:     	leaq	(%rbx,%r8,8), %r8
180002cdb:     	movq	%rdx, (%r8,%r9,8)
