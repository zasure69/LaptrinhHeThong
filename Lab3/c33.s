.section .data
	flag:
		.int 0
	str:
		.string "Nhap mot so nguyen a (0<= a <= 9):"
	str1:
		.string "So luong so lon hon hoac bang 5:"
	cnt:
		.int 5
	cnt_number:
		.int 0
.section .bss
	.lcomm input, 2
.section .text
	.globl _start
_start:
	
.loop:
	movl $cnt, %eax
	cmpl $0, (%eax)
	je .exit
	subl $1, (%eax)
	movl $str, %ecx
	movl $34, %edx #xuat duong dan tu man hinh
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $2, %edx
	movl $input, %ecx	#nhap input tu man hinh
	movl $3, %eax
	movl $0, %ebx
	int $0x80

	movl $input, %eax
	xorl %ebx, %ebx
	movb (%eax), %bl
	cmp $53, %bl
	jl .loop
	movl $cnt_number, %ecx
	addl $1, (%ecx)
	jmp .loop

.exit:
	movl $str1, %ecx
	movl $32, %edx #xuat duong dan tu man hinh
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $cnt_number, %ecx
	addl $48, (%ecx)
	movl $1, %edx #xuat duong dan tu man hinh
	movl $1, %ebx
	movl $4, %eax
	int $0x80

	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
