# barnes-final particle-check: [0x180002cc6, 0x180002cf1)
# Source/call-target-bound static range; counts include padding, never cycles.
180002cc6:     	movq	0x30(%r9,%r15,8), %rdx
180002ccb:     	leaq	(%r9,%rdx,8), %rax
180002ccf:     	sarq	$0x3f, %rdx
180002cd3:     	andq	%r14, %rdx
180002cd6:     	cmpq	$0x1, (%rax,%rdx,8)
180002cdb:     	jne	0x180002cf1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x781>
180002cdd:     	cmpq	$0x0, (%rax)
180002ce1:     	jle	0x180002dea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x87a>
180002ce7:     	movq	0x10(%rax), %rax
180002ceb:     	cmpq	%rbx, (%r9,%rax,8)
180002cef:     	je	0x180002c91 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x721>
