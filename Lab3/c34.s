.section .data
	age1:
		.int 2000	
	age2:
		.int 1900
	str:
		.string "Nhap so CCCD: "
	len:
		.byte .-str-1
	output1:
		.string "Chua den tuoi lao dong"
	len1:
		.byte .-output1-1
	output2:
		.string "Trong do tuoi lao dong"
	len2:
		.byte .-output2-1
	output3:
		.string "Het tuoi lao dong"
	len3:
		.byte  .-output3-1
.section .bss
	.lcomm input, 12
.section .text
	.globl _start
_start:
	movb (len), %dl
	movl $str, %ecx	#nhap loi dan tu man hinh
	movl $4, %eax
	movl $1, %ebx
	int $0x80

	movl $12, %edx
	movl $input, %ecx	#nhap input tu man hinh
	movl $3, %eax
	movl $0, %ebx
	int $0x80

	movl $input, %eax
	xorl %ebx, %ebx
	xorl %ecx, %ecx
	xorl %edx, %edx
	mov 3(%eax), %dl
	mov 4(%eax), %bl
	mov 5(%eax), %cl
	subl $48, %edx
	subl $48, %ebx
	subl $48, %ecx
	imull $10, %ebx
	addl %ecx, %ebx
	cmp $0, %dl
	je .nam_khong
	cmp $1, %dl
	je .nu_khong
	cmp $2, %dl
	je .nam_mot
	movl $age1, %eax
	addl (%eax), %ebx
	movl $2024, %ecx
	subl %ebx, %ecx
	cmpl $15, %ecx
	jl .print_mot
	cmpl $55, %ecx
	jle .print_hai
	jmp .print_ba

.nam_khong:
	movl $age2, %eax
	addl (%eax), %ebx
	movl $2024, %ecx
	subl %ebx, %ecx
	cmpl $15, %ecx
	jl .print_mot
	cmpl $60, %ecx
	jle .print_hai
	jmp .print_ba

.nam_mot:
	movl $age1, %eax
	addl (%eax), %ebx
	movl $2024, %ecx
	subl %ebx, %ecx
	cmpl $15, %ecx
	jl .print_mot
	cmpl $60, %ecx
	jle .print_hai
	jmp .print_ba

.nu_khong:
	movl $age2, %eax
	addl (%eax), %ebx
	movl $2024, %ecx
	subl %ebx, %ecx
	cmpl $15, %ecx
	jl .print_mot
	cmpl $55, %ecx
	jle .print_hai
	jmp .print_ba

.print_mot:
	movl $output1, %ecx
	xorl %edx, %edx
	movb (len1), %dl
	movl $1, %ebx
	movl $4, %eax
	int $0x80
	jmp .exit

.print_hai:
	movl $output2, %ecx
	xorl %edx, %edx
	movb (len2), %dl
	movl $1, %ebx
	movl $4, %eax
	int $0x80
	jmp .exit

.print_ba:
	movl $output3, %ecx
	xorl %edx, %edx
	movb (len3), %dl
	movl $1, %ebx
	movl $4, %eax
	int $0x80

.exit:
	movl $1, %eax	#sys_exit
	int $0x80	#gọi kernel
