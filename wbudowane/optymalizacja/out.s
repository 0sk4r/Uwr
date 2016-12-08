	.file	"13.c"
	.text
	.globl	metoda1
	.def	metoda1;	.scl	2;	.type	32;	.endef
	.seh_proc	metoda1
metoda1:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	16(%rbp), %eax
	shrl	%eax
	andl	$1431655765, %eax
	movl	%eax, %edx
	movl	16(%rbp), %eax
	addl	%eax, %eax
	andl	$-1431655766, %eax
	orl	%edx, %eax
	movl	%eax, 16(%rbp)
	movl	16(%rbp), %eax
	shrl	$2, %eax
	andl	$858993459, %eax
	movl	%eax, %edx
	movl	16(%rbp), %eax
	sall	$2, %eax
	andl	$-858993460, %eax
	orl	%edx, %eax
	movl	%eax, 16(%rbp)
	movl	16(%rbp), %eax
	shrl	$4, %eax
	andl	$252645135, %eax
	movl	%eax, %edx
	movl	16(%rbp), %eax
	sall	$4, %eax
	andl	$-252645136, %eax
	orl	%edx, %eax
	movl	%eax, 16(%rbp)
	movl	16(%rbp), %eax
	shrl	$8, %eax
	andl	$16711935, %eax
	movl	%eax, %edx
	movl	16(%rbp), %eax
	sall	$8, %eax
	andl	$-16711936, %eax
	orl	%edx, %eax
	movl	%eax, 16(%rbp)
	movl	16(%rbp), %eax
	roll	$16, %eax
	popq	%rbp
	ret
	.seh_endproc
	.globl	reverseBits
	.def	reverseBits;	.scl	2;	.type	32;	.endef
	.seh_proc	reverseBits
reverseBits:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 16(%rbp)
	movzbl	16(%rbp), %edx
	movl	$2149582850, %eax
	imulq	%rax, %rdx
	movabsq	$36578664720, %rax
	andq	%rax, %rdx
	movabsq	$4311810305, %rax
	imulq	%rdx, %rax
	shrq	$32, %rax
	popq	%rbp
	ret
	.seh_endproc
	.globl	metoda2
	.def	metoda2;	.scl	2;	.type	32;	.endef
	.seh_proc	metoda2
metoda2:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, -48(%rbp)
	movl	-48(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, -84(%rbp)
	movl	-48(%rbp), %eax
	shrl	$8, %eax
	andl	$255, %eax
	movl	%eax, -88(%rbp)
	movl	-48(%rbp), %eax
	shrl	$16, %eax
	andl	$255, %eax
	movl	%eax, -92(%rbp)
	movl	-48(%rbp), %eax
	shrl	$24, %eax
	movl	%eax, -96(%rbp)
	movl	-84(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	reverseBits
	movzbl	%al, %eax
	sall	$24, %eax
	movl	%eax, %ebx
	movl	-88(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	reverseBits
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %ebx
	movl	-92(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	reverseBits
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%eax, %ebx
	movl	-96(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	reverseBits
	movzbl	%al, %eax
	orl	%ebx, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	metoda3
	.def	metoda3;	.scl	2;	.type	32;	.endef
	.seh_proc	metoda3
metoda3:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	16(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	$127, -8(%rbp)
	shrl	16(%rbp)
	jmp	.L8
.L9:
	sall	-4(%rbp)
	movl	16(%rbp), %eax
	andl	$1, %eax
	orl	%eax, -4(%rbp)
	subl	$1, -8(%rbp)
	shrl	16(%rbp)
.L8:
	cmpl	$0, 16(%rbp)
	jne	.L9
	movl	-8(%rbp), %eax
	movl	%eax, %ecx
	sall	%cl, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Liczba: %d\12\0"
.LC2:
	.ascii "1 metoda: %f ms\12\0"
.LC3:
	.ascii "2 metoda:  %f ms\12\0"
.LC4:
	.ascii "3. metoda: %f ms\12\0"
.LC5:
	.ascii "%d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	call	__main
	movl	$1234567890, -16(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$100000000, -20(%rbp)
	call	clock
	movl	%eax, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L12
.L13:
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda1
	addl	$1, -4(%rbp)
.L12:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L13
	call	clock
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	subl	-24(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC1(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-40(%rbp), %xmm1
	movsd	-40(%rbp), %xmm0
	movq	%xmm0, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	call	clock
	movl	%eax, -24(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L14
.L15:
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda2
	addl	$1, -8(%rbp)
.L14:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L15
	call	clock
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	subl	-24(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC1(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-40(%rbp), %xmm1
	movsd	-40(%rbp), %xmm0
	movq	%xmm0, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	call	clock
	movl	%eax, -24(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L16
.L17:
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda3
	addl	$1, -12(%rbp)
.L16:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L17
	call	clock
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	subl	-24(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movsd	.LC1(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-40(%rbp), %xmm1
	movsd	-40(%rbp), %xmm0
	movq	%xmm0, %rdx
	leaq	.LC4(%rip), %rcx
	call	printf
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda1
	movl	%eax, %edx
	leaq	.LC5(%rip), %rcx
	call	printf
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda2
	movl	%eax, %edx
	leaq	.LC5(%rip), %rcx
	call	printf
	movl	-16(%rbp), %eax
	movl	%eax, %ecx
	call	metoda3
	movl	%eax, %edx
	leaq	.LC5(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$80, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC1:
	.long	0
	.long	1083129856
	.ident	"GCC: (x86_64-posix-seh-rev1, Built by MinGW-W64 project) 6.2.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	clock;	.scl	2;	.type	32;	.endef
