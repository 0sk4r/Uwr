	.file	"zad14.c"
	.comm	array, 300000000, 5
	.text
	.globl	genInt32
	.def	genInt32;	.scl	2;	.type	32;	.endef
	.seh_proc	genInt32
genInt32:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	rand
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	cvttsd2siq	%xmm0, %rax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	sposobjeden
	.def	sposobjeden;	.scl	2;	.type	32;	.endef
	.seh_proc	sposobjeden
sposobjeden:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	16(%rbp), %eax
	notl	%eax
	movl	%eax, -4(%rbp)
	cmpl	$0, 16(%rbp)
	je	.L4
	movl	-4(%rbp), %eax
	subl	$1, %eax
	andl	-4(%rbp), %eax
	testl	%eax, %eax
	jne	.L4
	movl	$1, %eax
	jmp	.L5
.L4:
	movl	$0, %eax
.L5:
	movb	%al, -5(%rbp)
	andb	$1, -5(%rbp)
	movzbl	-5(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	sposobdwa
	.def	sposobdwa;	.scl	2;	.type	32;	.endef
	.seh_proc	sposobdwa
sposobdwa:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	$0, -4(%rbp)
	movl	16(%rbp), %eax
	notl	%eax
	movl	%eax, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L8
.L9:
	movl	-8(%rbp), %eax
	subl	$1, %eax
	andl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
.L8:
	cmpl	$0, -8(%rbp)
	jne	.L9
	cmpl	$1, -4(%rbp)
	jg	.L10
	movl	$1, %eax
	jmp	.L11
.L10:
	movl	$0, %eax
.L11:
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC3:
	.ascii "ilosc liczb: %i\12\0"
.LC4:
	.ascii "1. sposob potrzebowal %f ms\12\0"
.LC5:
	.ascii "2. sposob potrzebowal %f ms\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, %ecx
	call	time
	movl	%eax, %ecx
	call	srand
	movl	$0, -4(%rbp)
	jmp	.L13
.L14:
	call	genInt32
	movl	%eax, %ecx
	leaq	array(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	%ecx, (%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L13:
	cmpl	$74999999, -4(%rbp)
	jle	.L14
	call	clock
	movl	%eax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L15
.L17:
	leaq	array(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, %ecx
	call	sposobjeden
	xorl	$1, %eax
	testb	%al, %al
	je	.L16
	addl	$1, -12(%rbp)
.L16:
	addl	$1, -4(%rbp)
.L15:
	cmpl	$74999999, -4(%rbp)
	jle	.L17
	call	clock
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	-16(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC2(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	movsd	-32(%rbp), %xmm1
	movsd	-32(%rbp), %xmm0
	movq	%xmm0, %rdx
	leaq	.LC4(%rip), %rcx
	call	printf
	call	clock
	movl	%eax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L18
.L20:
	leaq	array(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, %ecx
	call	sposobdwa
	xorl	$1, %eax
	testb	%al, %al
	je	.L19
	addl	$1, -8(%rbp)
.L19:
	addl	$1, -4(%rbp)
.L18:
	cmpl	$74999999, -4(%rbp)
	jle	.L20
	call	clock
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	-16(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC2(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	movsd	-32(%rbp), %xmm1
	movsd	-32(%rbp), %xmm0
	movq	%xmm0, %rdx
	leaq	.LC5(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1088421824
	.align 8
.LC1:
	.long	-2097152
	.long	1106247679
	.align 8
.LC2:
	.long	0
	.long	1083129856
	.ident	"GCC: (x86_64-posix-seh-rev1, Built by MinGW-W64 project) 6.2.0"
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	time;	.scl	2;	.type	32;	.endef
	.def	srand;	.scl	2;	.type	32;	.endef
	.def	clock;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
