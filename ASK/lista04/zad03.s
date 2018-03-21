	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_ChangeEndianness
	.p2align	4, 0x90
_ChangeEndianness:                      ## @ChangeEndianness
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi0:
	.cfi_def_cfa_offset 16
Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi2:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	-4(%rbp), %edi
	andl	$255, %edi
	shll	$24, %edi
	orl	-8(%rbp), %edi
	movl	%edi, -8(%rbp)
	movl	-4(%rbp), %edi
	andl	$65280, %edi            ## imm = 0xFF00
	shll	$8, %edi
	orl	-8(%rbp), %edi
	movl	%edi, -8(%rbp)
	movl	-4(%rbp), %edi
	andl	$16711680, %edi         ## imm = 0xFF0000
	shrl	$8, %edi
	orl	-8(%rbp), %edi
	movl	%edi, -8(%rbp)
	movl	-4(%rbp), %edi
	andl	$-16777216, %edi        ## imm = 0xFF000000
	shrl	$24, %edi
	orl	-8(%rbp), %edi
	movl	%edi, -8(%rbp)
	movl	-8(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi3:
	.cfi_def_cfa_offset 16
Lcfi4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi5:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$12345, -8(%rbp)        ## imm = 0x3039
	movl	-8(%rbp), %edi
	callq	_ChangeEndianness
	xorl	%edi, %edi
	movl	%eax, -12(%rbp)
	movl	%edi, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc


.subsections_via_symbols
