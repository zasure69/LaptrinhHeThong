.section .data
	flag:
		.int 0
	output1:
		.string "Giam dan"
	output2:
		.string "Khong giam dan"
.section .bss
	.lcomm input, 5
.section .text
	.globl _start
_start:
	movl $5, %edx
	movl $input, %ecx	#nhap input tu man hinh
	movl $3, %eax
	movl $0, %ebx
	int $0x80

	movl $0, %ebx # i = 0
	movl $input, %eax

.loop:
	cmpl $3, %ebx #if i > 3 thoat
	jg .exit_loop
	xorl %ecx, %ecx
	mov (%ebx, %eax), %cl
	cmp %cl, 1(%ebx, %eax) # if input[i+1] >= input[i]
	jge .false
	addl $1, %ebx #i++
	jmp .loop
.false:
	movl $output2, %ecx
	movl $14, %edx
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	jmp .exit

.exit_loop:
	movl $output1, %ecx
	movl $8, %edx
	movl $1, %ebx
	movl $4, %eax
	int $0x80

.exit:
	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
