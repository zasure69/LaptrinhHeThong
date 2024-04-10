.section .data
	number_int:
		.int 0

.section .bss
	.lcomm number, 2
.section .text
	.globl _start
_start:
	movl $8, %edx 		#độ dài của chuỗi nhập vào
	movl $number, %ecx	#địa chỉ ô nhớ lưu chuỗi nhập vào
	movl $0, %ebx 		#stdin
	movl $3, %eax 		#sys_write
	int $0x80		#gọi kernel

	movl $number, %eax 	#gán địa chỉ của ô nhớ chứa chuỗi nhập vào thanh ghi eax
	mov (%eax), %bl		#gán ký tự đầu vào thanh ghi ebx
	sub $48, %ebx		#đổi ký tự về dạng số
	mov 1(%eax), %cl	#gán ký tự sau vào thanh ghi ecx 
	sub $48, %ecx		#đổi ký tự về dạng số
	imull $10, %ebx		#nhân số đầu với 10
	addl %ecx, %ebx		#cộng với số sau để được số ban đầu 
	andl $0x00000001, %ebx 	#lấy ra bit cuối cùng của thanh ghi
	xorl $1, %ebx		#kiểm tra xem bit cuối cùng là 0 (chẵn) hay 1 (lẻ)
	addl $48, %ebx		#chuyển về dạng kí tự ascii
	movl %ebx, (%eax)	#chuyển giá trị thanh ghi về lại địa chỉ ô nhớ ban đầu
	movl $1, %edx		#độ dài chuỗi in ra màn hình
	movl $number, %ecx 	#địa chỉ chuỗi in ra màn hình
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
