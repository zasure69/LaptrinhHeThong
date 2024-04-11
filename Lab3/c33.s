.section .data
	flag:
		.int 0
	str:
		.string "Nhap mot so nguyen a (0<= a <= 9):"
	str1:
		.string "So luong so lon hon hoac bang 5:"
	cnt:
		.int 5		#đếm số lần nhập
	cnt_number:
		.int 0		#đếm số lượng số >= 5
.section .bss
	.lcomm input, 2
.section .text
	.globl _start
_start:
	
.loop:
	movl $cnt, %eax		#gán địa chỉ ô nhớ lưu cnt vào thanh ghi eax
	cmpl $0, (%eax)		
	je .exit		#if cnt == 0 -> nhập đủ 5 lần -> thoát vòng lặp
	subl $1, (%eax)		#cnt-- 
	movl $str, %ecx		#in chuỗi str ra màn hình
	movl $34, %edx 		#độ dài chuỗi str
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $2, %edx		#độ dài input nhập từ màn hình
	movl $input, %ecx	#địa chỉ ô nhớ lưu input
	movl $3, %eax		#sys_read
	movl $0, %ebx		#stdin
	int $0x80		#gọi kernel

	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax
	xorl %ebx, %ebx		#reset thanh ghi ebx
	movb (%eax), %bl	#gán input thứ nhất vào thanh ghi bl
	cmp $53, %bl		
	jl .loop		#if input thứ nhất nhỏ hơn 5 -> nhảy đến nhãn .loop
	movl $cnt_number, %ecx	#gán địa chỉ ô nhớ lưu cnt_number vào thanh ghi ecx
	addl $1, (%ecx)		#cnt_number++
	jmp .loop

.exit:
	movl $str1, %ecx	#địa chỉ ô nhớ lưu str1
	movl $32, %edx 		#độ dài str1
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $cnt_number, %ecx	#gán địa chỉ ô nhớ lưu cnt_number vào thanh ghi ecx
	addl $48, (%ecx)	#chuyển số thành ký tự
	movl $1, %edx		#độ dài chuỗi in ra màn hình
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
