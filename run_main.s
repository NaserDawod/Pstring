// 323953893 Naser Dawod
        .section .rodata
inputI:		.string "%d"
inputS:		.string "%s"
    .text
	.globl run_main
    .type run_main, @function
run_main:
	pushq	%rbp					
	movq	%rsp, %rbp
	subq	$528, %rsp				# inizialize 528 byte in the stack for the struct
	leaq	-256(%rbp), %rsi		# create an int in bytes -256 to -252 to recive the lenght
    leaq	inputI, %rdi			# save the format of the input
	movl	$0, %eax	
	call	scanf					# call scanf to recive the lenght
	movl	-256(%rbp), %eax		# now we need only to save one byte from the int so save the int a regster eax
	movl	$0, -256(%rbp)			# 
	movb    %al, -256(%rbp)			# save the len in the first byte of the struct
	movl	$0, %eax
	leaq	-255(%rbp), %rsi		# initiialize the place to save the string
    leaq	inputS, %rdi
	call	scanf					# call scanf to recive the string
	movq	$0, %rax
	movb	-256(%rbp), %al
	addb	$1, %al
	leaq	-255(%rbp, %rax), %rax
	movb	$0, (%rax)
	movq	$0, %rax
	
	leaq	-512(%rbp), %rsi		# create an int in bytes -512 to -58 to recive the lenght
    leaq	inputI, %rdi			# save the format of the input
	movl	$0, %eax
	call	scanf					# call scanf to recive the lenght
	movl	-512(%rbp), %eax		# now we need only to save one byte from the int so save the int a regster eax
	movl	$0, -512(%rbp)			
	movb    %al, -512(%rbp)			# save the len in the first byte of the struct
	movl	$0, %eax
	leaq	-511(%rbp), %rsi		# initiialize the place to save the string
    leaq	inputS, %rdi
	call	scanf					# call scanf to recive the string
	movq	$0, %rax
	movb	-512(%rbp), %al
	addb	$1, %al
	leaq	-511(%rbp, %rax), %rax
	movb	$0, (%rax)
	movq	$0, %rax

	movq	$0, -520(%rbp)			# create an integer in the stack
	leaq	inputI, %rdi
	leaq	-520(%rbp), %rsi		# send the place of the integer to the scanf
	call	scanf					# call scanf to recive the option
	movq	$0, %rax

	movl -520(%rbp), %edi			# save the option in rdi
	leaq -256(%rbp), %rsi			# save the pointer of the psring1 in rsi
	leaq -512(%rbp), %rdx			# save the pointer of the psring2 in rdx

	call run_func					# call run_func
	leave
	ret

