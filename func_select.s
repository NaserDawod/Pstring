 // 323953893 Naser Dawod
    .section .rodata

# create the jump table that were gonna use for the switch case command
.align 8 # Align address to multiple of 8
choose:
    .quad   case_50 # Case 50: pstrlen
    .quad   default # Case 51: default
    .quad   case_52 # Case 52: replaceChar
    .quad   case_53 # Case 53: pstrijcpy
    .quad   case_54 # Case 54: swapCase
    .quad   case_55 # Case 55: pstrijcmp
    .quad   default # Case 56: default
    .quad   default # Case 57: default
    .quad   default # Case 58: default
    .quad   default # Case 59: default
    .quad   case_50 # Case 60: pstrlen

    .section .rodata
# these are all the strings that we were asked to print
case1_print:    .string "first pstring length: %d, second pstring length: %d\n"
case2_print:    .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
case3_print:    .string "length: %d, string: %s\n"
case5_print:    .string "compare result: %d\n"
inval:    .string "invalid option!\n"

# the fromats for the scanf
format:    .string "%d"
char:      .string " %c"
str:       .string "%s"
.text
    .globl run_func
    .type run_func, @function
run_func:
    pushq	%rbp		        #iniziaize the stack for new usage
	movq	%rsp, %rbp
    subq    $32, %rsp           # add 32 bytes in the stack
    movq    %rsi, -32(%rbp)     # save the pointer of pstr1 in the top of stack
    movq    %rdx, -24(%rbp)     # save the pointer of pstr2 in the stack
    movq    %rdi, %rbx          # move the option to rbx
    subq    $50, %rbx           # to compare the option do option = option - 50
    cmpq    $10,%rbx            # Compare xi:10
    ja      default             # if >, goto default-case
    jmp     *choose(,%rbx,8)    # go to the jump table then jump to the right case

case_50:              # case 50/60 print the lenght of the tow strings
    movq    %rsi, %rdi          # save the pointer if pstr1 in rdi (first argument)
    call    pstrlen             # call pstrlen function
    movzbl  %al, %esi           # the return value is in eax (the lenght) and save it in esi
    movq    %rdx, %rdi          # save the pointer if pstr2 in rdi (first argument)
    call    pstrlen             # call pstrlen function
    movzbl  %al, %ecx           # the return value is in eax (the lenght) and save it in ecx
    leaq    case1_print, %rdi   # save the print format
    movl    %ecx, %edx
    movl    $0, %eax
    call    printf              # call printf 
    jmp     end                 # jump to the end of the function

case_52:        # given old char and new char replace the old char with the new char in both strings
    leaq    char, %rdi          # prepare all the arguments to recive the lenght from the user
    leaq    -8(%rbp), %rsi
    xorq    %rax,%rax
    call    scanf               # scan the old char and save it in the stack -8(%rbp)
    leaq    char, %rdi
    leaq    -7(%rbp), %rsi
    xorq    %rax,%rax
    call    scanf               # scan the new char and save it in the stack -7(%rbp)
    movq    $0, %rsi
    movq    $0, %rdx
    movb    -8(%rbp), %sil      # save the old char in sil(rsi)
    movb    -7(%rbp), %dl       # save the new char in dl(rdi)
    movq    -32(%rbp), %rdi     # save th epointer of pstr1 in rdi
    call    replaceChar         # call replaceChar to replce the chars
    movq    -24(%rbp), %rdi     # save th epointer of pstr2 in rdi
    call    replaceChar         # call replaceChar to replce the chars
    leaq    case2_print, %rdi   #prepre the print format for the task
    movq    -32(%rbp), %rcx
    movq    -24(%rbp), %r8
    addq    $1, %rcx
    addq    $1, %r8
    call    printf
    jmp end                     # jump to the end of the function

case_53:          # given tow indxes i,j copy pstr2[i,j] to pstr1[i,j]
    leaq    format, %rdi        # save the format "%d" to  scan an integer
    leaq    -16(%rbp), %rsi     # the place to save the integer
    xorq    %rax,%rax
    call    scanf               # scan from the user
    movb    -16(%rbp), %bl
    movb    %bl, -8(%rbp)       # save the integer in the stack
    leaq    format, %rdi        # save the format "%d" to  scan an integer
    leaq    -16(%rbp), %rsi     # the place to save the integer
    xorq    %rax,%rax
    call    scanf               # scan from the user
    movb    -16(%rbp), %bl
    movb    %bl, -7(%rbp)       # save the integer in the stack
    movq    $0, %rcx
    movq    $0, %rdx
    movb    -8(%rbp), %dl       # save i in dl(rdx)
    movb    -7(%rbp), %cl       # save j in cl(rcx) 
    movq    -32(%rbp), %rdi     # save the pointer of pstr1 in rdi
    movq    -24(%rbp), %rsi     # save the pointer of pstr2 in rsi
    call    pstrijcpy           # call pstrijcpy to copy the strings
    leaq    case3_print, %rdi   # prepare the print format to print the result
    movq    -32(%rbp), %rdx        
    movzbl  (%rdx), %rsi
    addq    $1, %rdx
    movq    $0, %rax
    call    printf              # print the result
    leaq    case3_print, %rdi
    movq    -24(%rbp), %rdx
    movzbl  (%rdx), %rsi
    addq    $1, %rdx
    movq    $0, %rax
    call    printf              # print the result
    jmp end

case_54:           # swap the cases of the albetcal letters in the strings then print them
    movq    -32(%rbp), %rdi     # save the pointer of pstr1 in rdi
    call    swapCase            # call swapCase to swap the letters
    movq    -24(%rbp), %rdi     # save the pointer of pstr1 in rdi
    call    swapCase            # call swapCase to swap the letters
    leaq    case3_print, %rdi   # save the print format to print the result
    movq    -32(%rbp), %rdx     
    movzbl  (%rdx), %rsi
    addq    $1, %rdx
    movq    $0, %rax
    call    printf              # print the result
    leaq    case3_print, %rdi   # save the print format to print the result
    movq    -24(%rbp), %rdx
    movzbl  (%rdx), %rsi
    addq    $1, %rdx
    movq    $0, %rax
    call    printf              # print the result
    jmp end                     # jump to the end of the function

case_55:            # compare the tow strings in Lexicographic order in the given range i -> j
    leaq    format, %rdi        # save "%d" in rdi to recive an int (the i)  
    leaq    -16(%rbp), %rsi     # save the place to recive the int rsi
    xorq    %rax,%rax
    call    scanf               
    movb    -16(%rbp), %al
    movb    %al, -8(%rbp)       # save the i in stack
    leaq    format, %rdi        # save "%d" in rdi to recive an int (the j)
    leaq    -16(%rbp), %rsi     
    xorq    %rax,%rax
    call    scanf
    movb    -16(%rbp), %al      
    movb    %al, -7(%rbp)       # save the i in stack
    movq    $0, %rcx
    movq    $0, %rdx
    movb    -8(%rbp), %dl       # save i in dl(rdx)
    movb    -7(%rbp), %cl       # save j in cl(rcx) 
    movq    -32(%rbp), %rdi     # save the pointer of pstr1 in rdi
    movq    -24(%rbp), %rsi     # save the pointer of pstr2 in rsi
    call    pstrijcmp
    leaq    case5_print, %rdi
    movq    %rax, %rsi
    movq    $0, %rax
    call    printf
    jmp end                     # jump to the end of the function

default:        # the defaul case if we recive a wrong number.
    leaq    inval,%rdi
    movq    $0, %rax
    call    printf
    jmp end                     # jump to the end of the function

end:
    leave
    ret
