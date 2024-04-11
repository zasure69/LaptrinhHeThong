.section .data
	str:
		.string "Nhap chuoi (khong qua 255 ky tu va it hon 10 tu): "
	len_str:
		.byte .-str-1 	#độ dài đường dẫn
	len:	
		.int 0		#độ dài chuỗi output
.section .bss
	.lcomm input, 255
	.lcomm output, 255
.section .text
	.globl _start
_start:
	movl $str, %ecx		#in chuỗi str ra màn hình
	movb (len_str), %dl	#độ dài chuỗi str
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_read
	int $0x80		#gọi kernel

	movl $255, %edx		#độ dài tối đa chuỗi input có thể nhập
	movl $input, %ecx	#địa chỉ lưu chuỗi input
	movl $3, %eax		#sys_write
	movl $0, %ebx		#stdin
	int $0x80		#gọi kernel

	movl $1, %ebx 		# i = 1
	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax
	xorl %ecx, %ecx		#reset thanh ghi ecx
	mov (%eax), %cl		#gán input[0] vào than ghi cl
	cmp $32, %cl		
	je .loop		#if input[0] == ' ' -> nhảy đến nhãn .loop
	subl $32, %ecx		#chuyển chữ thường thành chữ hoa
	movl $output, %edx	#gán địa chỉ ô nhớ lưu output vào thanh ghi edx
	mov %cl, (%edx)		#gán output[0] bằng giá trị thanh ghi cl
	addl $1, (len)		#tăng độ dài output lên 1

.loop:
	xorl %ecx, %ecx		#reset thanh ghi ecx
	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax
	mov (%ebx, %eax), %cl	#gán input[i] vào than ghi cl
	cmp $10, %ecx 		
	je .exit		#if input[i] == '\n' thoát vòng lặp
	cmp $32, %ecx 		
	je .space		#if input[i] == ' ' -> nhảy đến nhãn .space
	xorl %edx, %edx		#reset thanh ghi edx
	mov -1(%ebx, %eax), %dl #gán input[i-1] vào thanh ghi dl
	cmp $32, %edx 		
	je .cap			#if input[i-1] == ' ' -> nhảy đến nhãn .cap
	cmp $90, %ecx		
	jg .add_output		#if input[i-1] > 'Z' -> nhảy đến nhãn .add_output
	cmp $65, %ecx		
	jl .add_output		#if input[i-1] < 'A' -> nhảy đến nhãn .add_output

	addl $32, %ecx		#chuyển chữ hoa thành chữ thường
	movl $output, %edx	#gán địa chỉ ô nhớ lưu output vào thanh ghi eax
	movl (len), %eax	#gán chỉ số của ký tự tiếp theo trong chuỗi output vào thanh ghi eax
	mov %cl, (%eax, %edx)	#gán ký tự tiếp theo trong chuỗi output bằng giá trị thanh ghi cl
	addl $1, (len)		#tăng độ dài output lên 1
	jmp .end_loop

.cap:
	cmp $97, %ecx		
	jl .add_output		#if input[i] < 'a' -> nhảy đến nhãn .add_output
	cmp $122, %ecx		
	jg .add_output		#if input[i] > 'z' -> nhảy đến nhãn .add_output
	subl $32, %ecx		#chuyển chữ thường thành chữ hoa
	movl $output, %edx	#gán địa chỉ ô nhớ lưu output vào thanh ghi edx
	movl (len), %eax	#gán chỉ số của ký tự tiếp theo trong chuỗi
	mov %cl, (%eax, %edx)	#gán ký tự tiếp theo trong chuỗi output bằng giá trị thanh ghi cl
	addl $1, (len)		#tăng độ dài output lên 1
	jmp .end_loop

.space:
	xorl %edx, %edx		#reset thanh ghi edx
	mov -1(%ebx, %eax), %dl #gán input[i-1] vào thanh ghi dl
	cmp $32, %edx		
	je .end_loop		#if input[i-1] == ' ' -> nhảy đến nhãn .end_loop

.add_output:
	movl $output, %edx	#gán địa chỉ ô nhớ lưu output vào thanh ghi edx
	movl (len), %eax	#gán chỉ số của ký tự tiếp theo trong chuỗi
	mov %cl, (%eax, %edx)	#gán ký tự tiếp theo trong chuỗi output bằng giá trị thanh ghi cl
	addl $1, (len)		#tăng độ dài output lên 1

.end_loop:
	addl $1, %ebx		#i++
	jmp .loop

.exit:
	movl $output, %ecx	#in chuỗi output ra màn hình
	movl (len), %edx	#độ dài chuỗi input
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
