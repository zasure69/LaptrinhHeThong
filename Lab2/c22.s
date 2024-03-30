.section .bss
	.lcomm date, 8 		#biến lưu chuỗi nhập vào
.section .text
	.globl _start
_start:
	movl $8, %edx 		#độ dài của chuỗi nhập vào
	movl $date, %ecx	#địa chỉ của biến lưu chuỗi nhập vào
	movl $0, %ebx 		#stdin
	movl $3, %eax 		#sys_write
	int $0x80		#gọi kernel

	movl $date, %eax	#gán địa chỉ ô nhớ chứa chuỗi nhập vào thanh ghi eax
	movl 4(%eax), %edx	#gán 4 ký tự cuối vào thanh ghi edx
	movl (%eax), %ebx 	#gán 4 ký tự đầu vào thanh ghi ebx
	movl %ebx, 4(%eax)	#chuyển 4 ký tự đầu thành 4 ký tự cuối
	movl %edx, (%eax) 	#chuyển 4 ký tự cuối thành 4 ký tự đầu
	movl %eax, %ecx		#địa chỉ chuỗi in ra màn hình
	movl $8, %edx		#độ dài chuỗi in ra màn hình
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_read
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
