.section .data
	str:
		.string "Nhap chuoi (khong qua 255 ky tu va it hon 10 tu): "
	len_str:
		.byte .-str-1
	len:
		.int 0
.section .bss
	.lcomm input, 255
	.lcomm output, 255
.section .text
	.globl _start
_start:
	movl $str, %ecx
	movb (len_str), %dl
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $255, %edx
	movl $input, %ecx	#nhap input tu man hinh
	movl $3, %eax
	movl $0, %ebx
	int $0x80

	movl $1, %ebx # i = 1
	movl $input, %eax
	xorl %ecx, %ecx
	mov (%eax), %cl
	cmp $32, %cl
	je .loop
	subl $32, %ecx
	movl $output, %edx
	mov %cl, (%edx)
	addl $1, (len)

.loop:
	xorl %ecx, %ecx
	movl $input, %eax
	mov (%ebx, %eax), %cl
	cmp $10, %ecx #if i > 9 thoat
	je .exit
	cmp $32, %ecx # if input[i] == ' '
	je .space
	xorl %edx, %edx
	mov -1(%ebx, %eax), %dl #input[i-1]
	cmp $32, %edx # if input[i-1] == ' '
	je .cap
	cmp $90, %ecx
	jg .add_output
	cmp $65, %ecx
	jl .add_output
	addl $32, %ecx
	movl $output, %edx
	movl (len), %eax
	mov %cl, (%eax, %edx)
	addl $1, (len)
	jmp .end_loop

.cap:
	cmp $97, %ecx
	jl .add_output
	cmp $147, %ecx
	jg .add_output
	subl $32, %ecx
	movl $output, %edx
	movl (len), %eax
	mov %cl, (%eax, %edx)
	addl $1, (len)
	jmp .end_loop

.space:
	xorl %edx, %edx
	mov -1(%ebx, %eax), %dl
	cmp $32, %edx
	je .end_loop

.add_output:
	movl $output, %edx
	movl (len), %eax
	mov %cl, (%eax, %edx)
	addl $1, (len)

.end_loop:
	addl $1, %ebx
	jmp .loop

.exit:
	movl $output, %ecx
	movl (len), %edx
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
