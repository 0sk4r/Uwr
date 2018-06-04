	.file	"randwalk.c"
	.text
	.type	fill, @function
fill:
.LFB70:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %r12
	movl	%esi, %ebp
	movl	$0, %ebx
	jmp	.L2
.L3:
	movl	$0, %eax
	call	fast_random@PLT
	movslq	%ebx, %rdx
	movb	%al, (%r12,%rdx)
	addl	$1, %ebx
.L2:
	movl	%ebp, %eax
	imull	%ebp, %eax
	cmpl	%ebx, %eax
	jg	.L3
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE70:
	.size	fill, .-fill
	.type	randwalk1, @function
randwalk1:
.LFB71:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %r15
	movl	%esi, %r14d
	movl	%edx, %ebx
	movl	%esi, %ebp
	shrl	$31, %ebp
	addl	%esi, %ebp
	sarl	%ebp
	movl	%ebp, %r12d
	movl	$0, %eax
	movl	$0, %ecx
	movl	$0, %r13d
	jmp	.L11
.L16:
	movl	$0, %eax
	call	fast_random@PLT
	movl	$62, %ecx
	jmp	.L6
.L7:
	cmpl	$1, %esi
	je	.L13
	cmpl	$2, %esi
	je	.L14
	leal	-1(%r14), %edx
	cmpl	%ebp, %edx
	jle	.L8
	addl	$1, %ebp
.L8:
	subl	$1, %ebx
	je	.L15
.L11:
	subl	$2, %ecx
	js	.L16
.L6:
	movq	%rax, %rsi
	shrq	%cl, %rsi
	movl	%r12d, %edx
	imull	%r14d, %edx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	movzbl	(%r15,%rdx), %edx
	addl	%edx, %r13d
	andl	$3, %esi
	jne	.L7
	testl	%r12d, %r12d
	jle	.L8
	subl	$1, %r12d
	jmp	.L8
.L13:
	leal	-1(%r14), %edx
	cmpl	%r12d, %edx
	jle	.L8
	addl	$1, %r12d
	jmp	.L8
.L14:
	testl	%ebp, %ebp
	jle	.L8
	subl	$1, %ebp
	jmp	.L8
.L15:
	movl	%r13d, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE71:
	.size	randwalk1, .-randwalk1
	.type	test_randwalk1, @function
test_randwalk1:
.LFB73:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %r15
	movl	%esi, %r14d
	movl	%edx, %r13d
	movl	%ecx, %r12d
	movl	$0, %ebx
	movl	$0, %ebp
	jmp	.L18
.L19:
	movl	%r13d, %edx
	movl	%r14d, %esi
	movq	%r15, %rdi
	call	randwalk1
	addl	%eax, %ebp
	addl	$1, %ebx
.L18:
	cmpl	%r12d, %ebx
	jl	.L19
	movl	%ebp, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE73:
	.size	test_randwalk1, .-test_randwalk1
	.type	randwalk2, @function
randwalk2:
.LFB72:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %r15
	movl	%esi, %r13d
	movl	%edx, %r12d
	movl	%esi, %ebx
	shrl	$31, %ebx
	addl	%esi, %ebx
	sarl	%ebx
	movl	%ebx, %ebp
	movl	$0, %eax
	movl	$0, %ecx
	movl	$0, %r14d
	jmp	.L23
.L22:
	movq	%rax, %rsi
	shrq	%cl, %rsi
	movl	%ebp, %edx
	imull	%r13d, %edx
	addl	%ebx, %edx
	movslq	%edx, %rdx
	movzbl	(%r15,%rdx), %edx
	addl	%edx, %r14d
	andl	$3, %esi
	sete	%dl
	testl	%ebp, %ebp
	setg	%dil
	andl	%edi, %edx
	movzbl	%dl, %edx
	subl	%edx, %ebp
	leal	-1(%r13), %edi
	cmpl	$1, %esi
	sete	%dl
	cmpl	%ebp, %edi
	setg	%r8b
	andl	%r8d, %edx
	movzbl	%dl, %edx
	addl	%edx, %ebp
	cmpl	$2, %esi
	sete	%dl
	testl	%ebx, %ebx
	setg	%r8b
	andl	%r8d, %edx
	movzbl	%dl, %edx
	subl	%edx, %ebx
	cmpl	$1, %esi
	seta	%dl
	cmpl	$2, %esi
	setne	%r8b
	cmpl	%ebx, %edi
	setg	%sil
	andl	%r8d, %edx
	andl	%esi, %edx
	movzbl	%dl, %edx
	addl	%edx, %ebx
	subl	$1, %r12d
	je	.L25
.L23:
	subl	$2, %ecx
	jns	.L22
	movl	$0, %eax
	call	fast_random@PLT
	movl	$62, %ecx
	jmp	.L22
.L25:
	movl	%r14d, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE72:
	.size	randwalk2, .-randwalk2
	.type	test_randwalk2, @function
test_randwalk2:
.LFB74:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %r15
	movl	%esi, %r14d
	movl	%edx, %r13d
	movl	%ecx, %r12d
	movl	$0, %ebx
	movl	$0, %ebp
	jmp	.L27
.L28:
	movl	%r13d, %edx
	movl	%r14d, %esi
	movq	%r15, %rdi
	call	randwalk2
	addl	%eax, %ebp
	addl	$1, %ebx
.L27:
	cmpl	%r12d, %ebx
	jl	.L28
	movl	%ebp, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE74:
	.size	test_randwalk2, .-test_randwalk2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"n:s:t:v:S:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Usage: %s -S hex_seed-n log2(size) -s log2(steps) -t log2(times) -v variant\n"
	.section	.rodata.str1.1
.LC2:
	.string	"/dev/urandom"
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"Random number generator seed is 0x%lx\n"
	.align 8
.LC4:
	.string	"Generate matrix %d x %d (%d KiB)\n"
	.align 8
.LC5:
	.string	"Performing %d random walks of %d steps.\n"
	.align 8
.LC6:
	.string	"Walks accrued elements worth: %u\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB75:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movl	%edi, %r13d
	movq	%rsi, %r12
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movb	$0, 15(%rsp)
	movb	$0, 14(%rsp)
	movl	$-1, %ebp
	movl	%ebp, %r15d
	movl	%ebp, %r14d
	movl	%ebp, %ebx
	jmp	.L31
.L48:
	movl	$10, %edx
	movl	$0, %esi
	movq	optarg(%rip), %rdi
	call	strtol@PLT
	movl	$1, %ebx
	movl	%eax, %ecx
	sall	%cl, %ebx
.L31:
	leaq	.LC0(%rip), %rdx
	movq	%r12, %rsi
	movl	%r13d, %edi
	call	getopt@PLT
	cmpl	$-1, %eax
	je	.L47
	cmpl	$110, %eax
	je	.L48
	cmpl	$115, %eax
	je	.L49
	cmpl	$116, %eax
	je	.L50
	cmpl	$118, %eax
	je	.L51
	cmpl	$83, %eax
	je	.L52
	movb	$1, 14(%rsp)
	jmp	.L31
.L49:
	movl	$10, %edx
	movl	$0, %esi
	movq	optarg(%rip), %rdi
	call	strtol@PLT
	movl	$1, %r14d
	movl	%eax, %ecx
	sall	%cl, %r14d
	jmp	.L31
.L50:
	movl	$10, %edx
	movl	$0, %esi
	movq	optarg(%rip), %rdi
	call	strtol@PLT
	movl	$1, %r15d
	movl	%eax, %ecx
	sall	%cl, %r15d
	jmp	.L31
.L51:
	movl	$10, %edx
	movl	$0, %esi
	movq	optarg(%rip), %rdi
	call	strtol@PLT
	movl	%eax, %ebp
	jmp	.L31
.L52:
	movl	$16, %edx
	movl	$0, %esi
	movq	optarg(%rip), %rdi
	call	strtoul@PLT
	movq	%rax, 24(%rsp)
	movb	$1, 15(%rsp)
	jmp	.L31
.L47:
	movl	%ebx, %eax
	shrl	$31, %eax
	movzbl	14(%rsp), %ecx
	orb	%al, %cl
	jne	.L38
	movl	%r15d, %eax
	shrl	$31, %eax
	testl	%r14d, %r14d
	js	.L38
	testb	%al, %al
	jne	.L38
	cmpl	$1, %ebp
	ja	.L38
	cmpb	$0, 15(%rsp)
	je	.L53
.L40:
	movq	24(%rsp), %rdi
	call	fast_srandom@PLT
	movq	24(%rsp), %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	%ebx, %r13d
	imull	%ebx, %r13d
	movslq	%r13d, %rdi
	call	malloc_page_aligned@PLT
	movq	%rax, %r12
	movl	%r13d, %r8d
	sarl	$10, %r8d
	movl	%ebx, %ecx
	movl	%ebx, %edx
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	%ebx, %esi
	movq	%r12, %rdi
	call	fill
	movl	$0, %eax
	call	flush_cache@PLT
	movl	%r14d, %ecx
	movl	%r15d, %edx
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	32(%rsp), %r13
	movq	%r13, %rdi
	call	timer_reset@PLT
	movq	%r13, %rdi
	call	timer_start@PLT
	testl	%ebp, %ebp
	je	.L54
	movl	$0, %r13d
.L41:
	cmpl	$1, %ebp
	je	.L55
.L42:
	leaq	32(%rsp), %rbx
	movq	%rbx, %rdi
	call	timer_stop@PLT
	movq	%rbx, %rdi
	call	timer_print@PLT
	movl	%r13d, %edx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movl	$0, %eax
	movq	72(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L56
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L38:
	.cfi_restore_state
	movq	(%r12), %rcx
	leaq	.LC1(%rip), %rdx
	movl	$1, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L53:
	leaq	24(%rsp), %rsi
	movl	$8, %edx
	leaq	.LC2(%rip), %rdi
	call	read_bytes@PLT
	jmp	.L40
.L54:
	movl	%r15d, %ecx
	movl	%r14d, %edx
	movl	%ebx, %esi
	movq	%r12, %rdi
	call	test_randwalk1
	movl	%eax, %r13d
	jmp	.L41
.L55:
	movl	%r15d, %ecx
	movl	%r14d, %edx
	movl	%ebx, %esi
	movq	%r12, %rdi
	call	test_randwalk2
	movl	%eax, %r13d
	jmp	.L42
.L56:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE75:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-16ubuntu3) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
