.section .data
	output1:
		.string "Giam dan"
	output2:
		.string "Khong giam dan"
.section .bss
	.lcomm input, 5
.section .text
	.globl _start
_start:
	movl $5, %edx		#độ dài input nhập từ màn hình
	movl $input, %ecx	#địa chỉ ô nhớ lưu input
	movl $3, %eax		#sys_read
	movl $0, %ebx		#stdin
	int $0x80		#gọi kernel

	movl $0, %ebx 		# i = 0
	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax

.loop:
	cmpl $3, %ebx 		
	jg .exit_loop		#if i > 3 thoát vòng lặp
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov (%ebx, %eax), %cl	#lấy kí tự input[i] gán vào thanh ghi cl
	cmp %cl, 1(%ebx, %eax) 	
	jge .false		# if input[i+1] >= input[i] -> nhảy đến nhãn .false
	addl $1, %ebx 		#i++
	jmp .loop
.false:
	movl $output2, %ecx	#in output2 ra màn hình
	movl $14, %edx		#độ dài input2
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		gọi kernel
	jmp .exit

.exit_loop:
	movl $output1, %ecx	#in output1 ra màn hình
	movl $8, %edx		#độ dài output1
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

.exit:
	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
