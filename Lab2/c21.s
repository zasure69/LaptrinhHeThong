.section .data
msg:
	.string "UIT"
len:
	.byte . - msg
.section .text
	.globl _start
_start:
	addl $47, len	#đổi số thành dạng ký tự
	movl $1, %edx 	#độ dài của chuỗi in ra màn hình
	movl $len, %ecx	#địa chỉ của chuỗi in ra màn hình
	movl $1, %ebx 	#stdout
	movl $4, %eax 	#sys_write
	int $0x80	#gọi  kernel

	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
