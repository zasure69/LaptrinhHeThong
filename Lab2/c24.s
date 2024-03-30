.section .bss
	.lcomm input, 5		#khởi tạo biến
.section .text
	.globl _start
_start:
	movl $5, %edx 		#độ dài của chuỗi nhập
	movl $input, %ecx	#địa chỉ của biến lưu giá trị nhập
	movl $0, %ebx 		#stdin
	movl $3, %eax 		#sys_write
	int $0x80		#gọi kernel

	movl $input, %eax	#gán địa chỉ biến input vào thanh ghi eax
	mov (%eax), %bh		#gán ký tự thứ 1 vào thanh ghi bh
	mov 1(%eax), %bl 	#gán ký tự thứ 2 vào thanh ghi bl
	mov 3(%eax), %dh 	#gán ký tự thứ 4 vào thanh ghi dh
	mov 4(%eax), %dl	#gán ký tự thứ 5 vào thanh ghi dl
	mov %dl, (%eax)		#di chuyển ký tự thứ 5 sang vị trí thứ 1
	mov %dh, 1(%eax)	#di chuyển ký tự thứ 4 sang vị trí thứ 2
	mov %bl, 3(%eax)	#di chuyển ký tự thứ 2 sang vị trị thứ 4
	mov %bh, 4(%eax)	#di chuyển ký tự thứ 1 sang vị trí thứ 5
	
	movl $5, %edx		#độ dài của chuỗi in ra màn hình
	movl $input, %ecx	#địa chỉ của chuỗi in ra màn hình
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_read
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
