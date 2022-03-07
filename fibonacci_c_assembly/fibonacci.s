.global fibonacci
fibonacci:
	push %rbp

	mov $0, %edx
	mov $1, %eax
	mov %edi, %ecx 	#ecx is the nth variable collected from the c user input
	mov $0, %esi 	#holding variable
add:
	add %edx, %eax 	#eax becomes edx+eax
	mov %esi, %edx 	#edx now holds the holding value
	mov %eax, %esi 	#holding variable now becomes the sum
	dec %ecx 	#decrement the n value by 1
	cmp $0, %ecx 	#check if it's 0
	jne add		#if it's not 0 keep the loop going
print:
	pop %rbp
	ret		#return
