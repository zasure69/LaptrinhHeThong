.section .data
	number_int:
		.int 0
.section .bss
	.lcomm number, 2
	.lcomm output, 5	#tạo biến chứa chuỗi output
.section .text
	.globl _start
_start:
	movl $8, %edx 		#độ dài của chuỗi nhập vào
	movl $number, %ecx	#địa chỉ ô nhớ lưu chuỗi nhập vào
	movl $0, %ebx 		#stdin
	movl $3, %eax 		#sys_write
	int $0x80		#gọi kernel

	movl $number, %eax 	#gán địa chỉ của ô nhớ chứa chuỗi nhập vào thanh ghi eax
	movl $output, %edx	#gán địa chỉ của ô nhớ chứa chuỗi output vào thanh ghi edx
	mov (%eax), %bl		#gán ký tự đầu vào thanh ghi ebx
	mov %bl, (%edx) 	#chuyển kí tự đầu của input vào vị trí thứ nhất của output
	sub $48, %ebx		#đổi ký tự về dạng số
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov 1(%eax), %cl	#gán ký tự sau vào thanh ghi ecx 
	mov %cl, 1(%edx)	#chuyển kí tự sau của số input vào vị trí thứ 2 của output
	sub $48, %ecx		#đổi ký tự về dạng số
	imull $10, %ebx		#nhân số đầu với 10
	addl %ecx, %ebx		#cộng với số sau để được số ban đầu 
	addl $1, %ebx		#cộng 1 để được số kế tiếp
	movl $0, %edx		#reset thanh ghi edx
	movl %ebx, %eax		#chuyển số bị chia vào thanh ghi eax
	movl $10, %ecx		#chuyển số chia (10) vào thanh ghi ecx
	div %ecx		#chia eax cho ecx
	addl $48, %eax		#chuyển thương (ký tự đầu của số kế tiếp) lưu ở eax thành ký tự
	addl $48, %edx		#chuyển số dư (ký tự sau của số kế tiếp) lưu ở edx thành ký tự
	movl $output, %ecx	#chuyển địa chỉ ô nhớ của chuỗi output vào thanh ghi ecx
	movl $32, 2(%ecx)	#chuyển ký tự ' ' vào chuỗi output
	mov %al, 3(%ecx)	#chuyển ký tự đầu của số kế tiếp vào output
	mov %dl, 4(%ecx) 	#chuyển ký tự sau của số kế tiếp vào output
	movl $5, %edx		#độ dài chuỗi output
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
