.section .bss
	.lcomm input, 10
.section .text
	.globl _start
_start:
	movl $10, %edx
	movl $input, %ecx	#nhap input tu man hinh
	movl $3, %eax
	movl $0, %ebx
	int $0x80

	movl $1, %ebx # i = 1
	movl $input, %eax
	xorl %ecx, %ecx
	mov (%eax), %cl
	cmp $97, %cl
	jl .loop
	cmp $122, %cl
	jg .loop
	subl $32, %ecx
	movb %cl, (%eax)

.loop:
	cmpl $9, %ebx #if i > 9 thoat
	jg .exit
	xorl %ecx, %ecx
	mov (%ebx, %eax), %cl
	cmp $32, %ecx # if input[i] == ' '
	jne .ne
	addl $1, %ebx
	xorl %ecx, %ecx
	mov (%ebx, %eax), %cl
	cmp $97, %ecx
	jl .end_loop
	cmp $122, %cl
	jg .end_loop
	subl $32, %ecx
	mov %cl, (%ebx, %eax)
	jmp .end_loop
.ne:
	cmp $65, %ecx
	jl .end_loop
	cmp $90, %ecx
	jg .end_loop
	addl $32, %ecx
	mov %cl, (%ebx, %eax)

.end_loop:
	addl $1, %ebx
	jmp .loop

.exit:
	movl $input, %ecx
	movl $10, %edx
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
