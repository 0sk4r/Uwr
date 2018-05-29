	.file	"randwalk.c"
	.text
	.p2align 4,,15
	.globl	fill
	.type	fill, @function
fill:
.LFB63:
	.cfi_startproc
	imull	%esi, %esi
	testl	%esi, %esi
	je	.L9
	leal	-1(%rsi), %eax
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	leaq	1(%rdi,%rax), %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	addq	$1, %rbx
	movb	%al, -1(%rbx)
	cmpq	%rbp, %rbx
	jne	.L3
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	.cfi_restore 3
	.cfi_restore 6
	rep ret
	.cfi_endproc
.LFE63:
	.size	fill, .-fill
	.p2align 4,,15
	.globl	randwalk1
	.type	randwalk1, @function
randwalk1:
.LFB64:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	xorl	%eax, %eax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movslq	%esi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r14
	movl	%edx, %ebx
	movq	%r13, %r15
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	call	fast_random@PLT
	xorl	%edx, %edx
	divq	%r13
	xorl	%eax, %eax
	movl	%edx, %ebp
	call	fast_random@PLT
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	divq	%r13
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	movl	%edx, %r12d
	leal	-1(%r15), %edx
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L25:
	cmpq	$3, %r8
	je	.L17
	cmpq	$1, %r8
	je	.L18
	xorl	%esi, %esi
	testl	%ebp, %ebp
	setg	%sil
	subl	%esi, %ebp
.L19:
	subl	$1, %ebx
	je	.L23
.L20:
	subl	$2, %ecx
	js	.L24
.L14:
	movl	%ebp, %r8d
	imull	%r15d, %r8d
	addl	%r12d, %r8d
	movslq	%r8d, %r8
	movzbl	(%r14,%r8), %esi
	movq	%rax, %r8
	shrq	%cl, %r8
	andl	$3, %r8d
	addl	%esi, %r13d
	cmpq	$2, %r8
	jne	.L25
	xorl	%esi, %esi
	testl	%r12d, %r12d
	setg	%sil
	subl	%esi, %r12d
	subl	$1, %ebx
	jne	.L20
.L23:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r13d, %eax
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
	.p2align 4,,10
	.p2align 3
.L24:
	.cfi_restore_state
	xorl	%eax, %eax
	movl	%edx, 12(%rsp)
	call	fast_random@PLT
	movl	$62, %ecx
	movl	12(%rsp), %edx
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L18:
	xorl	%esi, %esi
	cmpl	%ebp, %edx
	setg	%sil
	addl	%esi, %ebp
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L17:
	xorl	%esi, %esi
	cmpl	%r12d, %edx
	setg	%sil
	addl	%esi, %r12d
	jmp	.L19
	.cfi_endproc
.LFE64:
	.size	randwalk1, .-randwalk1
	.p2align 4,,15
	.globl	randwalk2
	.type	randwalk2, @function
randwalk2:
.LFB65:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%esi, %r15d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r14
	movl	%edx, %r12d
	xorl	%r13d, %r13d
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	call	fast_random@PLT
	leal	-1(%r15), %edx
	movl	%eax, %ebx
	xorl	%eax, %eax
	andl	%edx, %ebx
	movl	%edx, 12(%rsp)
	call	fast_random@PLT
	movl	12(%rsp), %edx
	movl	%eax, %ebp
	xorl	%esi, %esi
	xorl	%ecx, %ecx
	andl	%edx, %ebp
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L27:
	movl	%ebx, %r8d
	imull	%r15d, %r8d
	addl	%ebp, %r8d
	movslq	%r8d, %r8
	movzbl	(%r14,%r8), %eax
	movq	%rsi, %r8
	shrq	%cl, %r8
	addl	%eax, %r13d
	andl	$3, %r8d
	sete	%dil
	xorl	%eax, %eax
	testl	%ebx, %ebx
	setg	%al
	andl	%edi, %eax
	subl	%eax, %ebx
	cmpl	$1, %r8d
	sete	%al
	xorl	%edi, %edi
	cmpl	%ebx, %edx
	setg	%dil
	andl	%eax, %edi
	addl	%edi, %ebx
	cmpl	$2, %r8d
	sete	%al
	xorl	%r8d, %r8d
	testl	%ebp, %ebp
	setg	%r8b
	andl	%eax, %r8d
	subl	%r8d, %ebp
	subl	$1, %r12d
	je	.L31
.L28:
	subl	$2, %ecx
	jns	.L27
	xorl	%eax, %eax
	movl	%edx, 12(%rsp)
	call	fast_random@PLT
	movl	$62, %ecx
	movq	%rax, %rsi
	movl	12(%rsp), %edx
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L31:
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	movl	%r13d, %eax
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
.LFE65:
	.size	randwalk2, .-randwalk2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"n:s:t:v:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Usage: %s -n log2(size) -l log2(length) -t log2(times) -v variant\n"
	.align 8
.LC2:
	.string	"Generate matrix %d x %d (%d KiB)\n"
	.align 8
.LC3:
	.string	"Performing %d random walks of %d steps.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB66:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r15d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	$-1, %ebp
	movl	%ebp, %r12d
	movl	%ebp, %r13d
	movl	%ebp, %ebx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movb	$0, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L33:
	leaq	.LC0(%rip), %rdx
	movq	%r14, %rsi
	movl	%r15d, %edi
	call	getopt@PLT
	cmpl	$-1, %eax
	je	.L60
	cmpl	$110, %eax
	je	.L61
	cmpl	$115, %eax
	je	.L62
	cmpl	$116, %eax
	je	.L63
	cmpl	$118, %eax
	je	.L64
	movb	$1, 8(%rsp)
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L61:
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$1, %ebx
	call	strtol@PLT
	movl	%eax, %ecx
	sall	%cl, %ebx
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L60:
	testl	%ebx, %ebx
	js	.L39
	cmpb	$0, 8(%rsp)
	jne	.L39
	testl	%r13d, %r13d
	js	.L39
	testl	%r12d, %r12d
	js	.L39
	cmpl	$1, %ebp
	ja	.L39
	movl	%ebx, %r15d
	imull	%ebx, %r15d
	call	getpagesize@PLT
	leaq	24(%rsp), %rdi
	movslq	%eax, %rsi
	movslq	%r15d, %rdx
	call	posix_memalign@PLT
	testl	%eax, %eax
	movq	$0, 8(%rsp)
	je	.L65
.L41:
	movl	%r15d, %r8d
	leaq	.LC2(%rip), %rsi
	xorl	%eax, %eax
	sarl	$10, %r8d
	movl	%ebx, %ecx
	movl	%ebx, %edx
	movl	$1, %edi
	call	__printf_chk@PLT
	testl	%r15d, %r15d
	je	.L42
	movq	8(%rsp), %rcx
	leal	-1(%r15), %eax
	leaq	1(%rcx,%rax), %r15
	movq	%rcx, %r14
	.p2align 4,,10
	.p2align 3
.L43:
	call	rand@PLT
	addq	$1, %r14
	movb	%al, -1(%r14)
	cmpq	%r15, %r14
	jne	.L43
.L42:
	xorl	%eax, %eax
	leaq	32(%rsp), %r14
	call	flush_cache@PLT
	leaq	.LC3(%rip), %rsi
	movl	%r13d, %ecx
	movl	%r12d, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r14, %rdi
	call	timer_reset@PLT
	movq	%r14, %rdi
	call	timer_start@PLT
	testl	%r12d, %r12d
	je	.L44
	xorl	%r15d, %r15d
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L66:
	addl	$1, %r15d
	call	randwalk1
	cmpl	%r15d, %r12d
	je	.L44
.L47:
	testl	%ebp, %ebp
	movl	%r13d, %edx
	movl	%ebx, %esi
	movq	8(%rsp), %rdi
	je	.L66
	addl	$1, %r15d
	call	randwalk2
	cmpl	%r15d, %r12d
	jne	.L47
.L44:
	movq	%r14, %rdi
	call	timer_stop@PLT
	movq	%r14, %rdi
	call	timer_print@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	xorl	%eax, %eax
	movq	72(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L67
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
	.p2align 4,,10
	.p2align 3
.L62:
	.cfi_restore_state
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$1, %r13d
	call	strtol@PLT
	movl	%eax, %ecx
	sall	%cl, %r13d
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L63:
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$1, %r12d
	call	strtol@PLT
	movl	%eax, %ecx
	sall	%cl, %r12d
	jmp	.L33
.L64:
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %ebp
	jmp	.L33
.L65:
	movq	24(%rsp), %rax
	movq	%rax, 8(%rsp)
	jmp	.L41
.L39:
	movq	stderr(%rip), %rdi
	movq	(%r14), %rcx
	leaq	.LC1(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L67:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE66:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-16ubuntu3) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
