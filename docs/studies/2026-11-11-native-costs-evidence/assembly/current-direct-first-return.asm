# current-direct first-return: [0x180004101, 0x180004170)
# Source/call-target inferred range; padding may be included. Static evidence, not cycles.
180004101:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
180004106:     	movzbl	0x198(%rsp), %ecx
18000410e:     	testb	%cl, %cl
180004110:     	setne	%r11b
180004114:     	cmpb	$0x0, (%rdi)
180004117:     	jne	0x180004345 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x785>
18000411d:     	movsd	0x1a0(%rsp), %xmm0
180004126:     	movzbl	0x1a8(%rsp), %eax
18000412e:     	movsd	0x190(%rsp), %xmm7
180004137:     	decq	0x8(%rsi)
18000413b:     	testb	%cl, %cl
18000413d:     	movq	%rbp, %rcx
180004140:     	je	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004146:     	movapd	0x9272(%rip), %xmm1     # 0x18000d3c0
18000414e:     	andpd	%xmm7, %xmm1
180004152:     	ucomisd	0x9276(%rip), %xmm1     # 0x18000d3d0
18000415a:     	jb	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004160:     	movb	$0x1, (%rdi)
180004163:     	movq	$0x3d0922, 0x18(%rsi)   # imm = 0x3D0922
18000416b:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
