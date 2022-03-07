.global power

power:
	push	%rbp
	mov	$1, %rax	#move 1 into rax
	mov	%edi, %edx	#edx is the number to multiply by
	mov	%esi, %ecx	#power to raise to
loop:
	imul	%edx, %eax	#multiply
	dec	%ecx		#decrement loop iterator
	cmp	$0, %ecx	#compare iterator with 0
	jne	loop		#loop if not at 0

	popq	%rbp
	ret
