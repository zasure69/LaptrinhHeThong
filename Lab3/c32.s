.section .bss
	.lcomm input, 10
.section .text
	.globl _start
_start:
	movl $10, %edx		#độ dài chuỗi input nhập từ màn hình
	movl $input, %ecx	#địa chỉ ô nhớ lưu input
	movl $3, %eax		#sys_write
	movl $0, %ebx		#stdin
	int $0x80		#gọi kernel

	movl $1, %ebx 		# i = 1
	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov (%eax), %cl		#lấy input[0] gán vào thanh ghi cl
	cmp $97, %cl		
	jl .loop		#if input[0] < 'a' -> nhảy vào loop
	cmp $122, %cl		
	jg .loop		#if input[0] > 'z' -> nhảy vào loop
	subl $32, %ecx		#chuyển chữ thường thành chữ in hoa
	movb %cl, (%eax)	#gán giá chữ in hoa trở lại ô nhớ ban đầu

.loop:
	cmpl $9, %ebx 		
	jg .exit		#if i > 9 thoát vòng lặp
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov (%ebx, %eax), %cl	#gán input[i] vào thanh ghi cl
	cmp $32, %ecx 
	jne .ne			# if input[i] != ' ' -> nhảy đến nhãn .ne
	addl $1, %ebx		#i++
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov (%ebx, %eax), %cl	#gán input[i] vào thanh ghi cl
	cmp $97, %ecx		
	jl .end_loop		#if input[i] < 'a' -> nhảy đến nhãn .end_loop
	cmp $122, %ecx		
	jg .end_loop		#if input[i] > 'z' -> nhảy đến nhãn .end_loop
	subl $32, %ecx		#chuyển chữ thường thành chữ hoa
	mov %cl, (%ebx, %eax)	#gán lại ký tự vào ô nhớ ban đầu
	jmp .end_loop		
.ne:
	cmp $65, %ecx
	jl .end_loop		#if input[i] < 'A' -> nhảy đến nhãn .end_loop
	cmp $90, %ecx		
	jg .end_loop		#if input[i] > 'Z' -> nhảy đến nhãn .end_loop
	addl $32, %ecx		#chuyển chữ hoa thành chữ thường
	mov %cl, (%ebx, %eax)	#chuyển lại ký tự vào ô nhớ ban đầu

.end_loop:
	addl $1, %ebx		#i++
	jmp .loop

.exit:
	movl $input, %ecx	#in input sau khi chuẩn hóa ra màn hình
	movl $10, %edx		#độ dài input
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
