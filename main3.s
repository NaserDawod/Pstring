	.file	"main3.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d"
format:
	.string	"%s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$288, %rsp
	movl	$0, %eax
	leaq	-276(%rbp), %rsi
	leaq	format, %rdi
	movl	$0, %eax
	call	scanf
	movl	-276(%rbp), %eax
	movb	%al, -272(%rbp)
	leaq	-272(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	format, %rdi
	movl	$0, %eax
	call	scanf
	movl	$0, %eax
	leave
	ret

