.section .data
	age1:
		.int 2000	
	age2:
		.int 1900
	str:
		.string "Nhap so CCCD: "
	len:
		.byte .-str-1 		#độ dài chuỗi str
	output1:
		.string "Chua den tuoi lao dong"
	len1:
		.byte .-output1-1	#độ dài chuỗi output1
	output2:
		.string "Trong do tuoi lao dong"
	len2:
		.byte .-output2-1	#độ dài chuỗi output2
	output3:
		.string "Het tuoi lao dong"
	len3:
		.byte  .-output3-1	#độ dài chuỗi output3
.section .bss
	.lcomm input, 12
.section .text
	.globl _start
_start:
	movb (len), %dl		#độ dài chuỗi str
	movl $str, %ecx		#địa chỉ ô nhớ lưu chuỗi str
	movl $4, %eax		#sys_write
	movl $1, %ebx		#stdout
	int $0x80		#gọi kernel

	movl $12, %edx		#độ dài chuỗi input
	movl $input, %ecx	#địa chỉ ô nhớ lưu chuỗi input
	movl $3, %eax		#sys_read
	movl $0, %ebx		#stdin
	int $0x80		#gọi kernel

	movl $input, %eax	#gán địa chỉ ô nhớ lưu input vào thanh ghi eax
	xorl %ebx, %ebx		#reset thanh ghi ebx
	xorl %ecx, %ecx		#reset thanh ghi ecx
	xorl %edx, %edx		#reset thanh ghi edx
	mov 3(%eax), %dl	#gán ký tự thứ 4 của CCCD vào thanh ghi dl
	mov 4(%eax), %bl	#gán ký tự thứ 5 của CCCD vào thanh ghi bl
	mov 5(%eax), %cl	#gán ký tự thứ 6 của CCCD vào thanh ghi cl	
	subl $48, %ebx		#chuyển ký tự thứ 5 của CCCD sang số
	subl $48, %ecx		#chuyển ký tự thứ 6 của CCCD sang số
	imull $10, %ebx		#nhân ký tự thứ 5 của CCCD với 10
	addl %ecx, %ebx		#cộng ký tự thứ 5 của CCCD -> 2 số cuối năm sinh
	cmp $48, %dl		
	je .nam_khong		#nếu ký tự thứ 4 của CCCD bằng 0 -> nhảy đến nhãn .nam_khong
	cmp $49, %dl		
	je .nu_khong		#nếu ký tự thứ 4 của CCCD bằng 1 -> nhảy đến nhãn .nu_khong
	cmp $50, %dl
	je .nam_mot		#nếu ký tự thứ 4 của CCCD bằng 2 -> nhảy đến nhãn .nam_mot
	movl $age1, %eax	#gán địa chỉ ô nhớ lưu age1 vào thanh ghi eax
	addl (%eax), %ebx	#cộng 2000 với 2 số trong CCCD để được năm sinh
	movl $2024, %ecx	#gán 2024 vào thanh ghi ecx
	subl %ebx, %ecx		#tính tuổi = 2024 - năm sinh
	cmpl $15, %ecx		
	jl .print_mot		#nếu tuổi < 15 -> nhảy đến nhãn .print_mot
	cmpl $55, %ecx		
	jle .print_hai		#nếu tuổi <= 55 -> nhảy đến nhãn .print_hai
	jmp .print_ba		#nhảy đến nhẵn .print_ba

.nam_khong:
	movl $age2, %eax	#gán địa chỉ ô nhớ lưu age2 vào thanh ghi eax
	addl (%eax), %ebx	#cộng 1900 với 2 số trong CCCD để được năm sinh
	movl $2024, %ecx	#gán 2024 vào thanh ghi ecx
	subl %ebx, %ecx		#tính tuổi = 2024 - năm sinh
	cmpl $15, %ecx
	jl .print_mot		#nếu tuổi < 15 -> nhảy đến nhãn .print_mot
	cmpl $60, %ecx
	jle .print_hai		#nếu tuổi <= 60 -> nhảy đến nhãn .print_hai
	jmp .print_ba		#nhảy đến nhẵn .print_ba

.nam_mot:
	movl $age1, %eax	#gán địa chỉ ô nhớ lưu age1 vào thanh ghi eax
	addl (%eax), %ebx	#cộng 2000 với 2 số trong CCCD để được năm sinh
	movl $2024, %ecx	#gán 2024 vào thanh ghi ecx
	subl %ebx, %ecx		#tính tuổi = 2024 - năm sinh
	cmpl $15, %ecx
	jl .print_mot		#nếu tuổi < 15 -> nhảy đến nhãn .print_mot
	cmpl $60, %ecx
	jle .print_hai		#nếu tuổi <= 60 -> nhảy đến nhãn .print_hai
	jmp .print_ba		#nhảy đến nhẵn .print_ba

.nu_khong:
	movl $age2, %eax	#gán địa chỉ ô nhớ lưu age2 vào thanh ghi eax
	addl (%eax), %ebx	#cộng 1900 với 2 số trong CCCD để được năm sinh
	movl $2024, %ecx	#gán 2024 vào thanh ghi ecx
	subl %ebx, %ecx		#tính tuổi = 2024 - năm sinh
	cmpl $15, %ecx		
	jl .print_mot		#nếu tuổi < 15 -> nhảy đến nhãn .print_mot
	cmpl $55, %ecx
	jle .print_hai		#nếu tuổi <= 55 -> nhảy đến nhãn .print_hai
	jmp .print_ba		#nhảy đến nhẵn .print_ba

.print_mot:
	movl $output1, %ecx	#gán địa chỉ ô nhớ lưu output1 vào thanh ghi ecx
	xorl %edx, %edx		#reset thanh ghi edx
	movb (len1), %dl	#độ dài output1
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel
	jmp .exit		#nhảy đến nhãn .exit

.print_hai:
	movl $output2, %ecx	#gán địa chỉ ô nhớ lưu output1 vào thanh ghi ecx
	xorl %edx, %edx		#reset thanh ghi edx
	movb (len2), %dl	#độ dài output2
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel
	jmp .exit		#nhảy đến nhãn .exit
	
.print_ba:
	movl $output3, %ecx	#gán địa chỉ ô nhớ lưu output3 vào thanh ghi ecx
	xorl %edx, %edx		#reset thanh ghi edx
	movb (len3), %dl	#độ dài output3
	movl $1, %ebx		#stdout
	movl $4, %eax		#sys_write
	int $0x80		#gọi kernel

.exit:
	movl $1, %eax		#sys_exit
	int $0x80		#gọi kernel
