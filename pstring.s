// 323953893 Naser Dawod
.section .rodata
error:    .string "invalid input!\n"        # error message
.text
	.globl pstrlen
    .type pstrlen, @function
pstrlen:        # given an pstring return its length
    movq    $0, %rax
    movb    (%rdi), %al         # from the first byte extract the length and save it in rax 
    ret

    .globl replaceChar
    .type replaceChar, @function
                    # given old char and new char replace the old char with the new char in both strings 
replaceChar:        # pointer(pstr) in rdi, oldChar in rsi, newChar in rdx
    movq    $0, %rbx
    movb    (%rdi), %bl         # save the length of the pstr in bl(rbx)
    addq    $1, %rdi
    movq    $0, %rcx            #creat a counter in rcx
    cmpb    %bl, %cl            # if counter < len
    je     end_r
    while_r:                    # while counter < len
        cmpb    (%rdi), %sil    # check if the char in the string is equal to old char
        jne     else_r
        movb    %dl, (%rdi)     # if the char was equal then change it
        else_r:
        addb    $1, %cl         # counter++
        addq    $1, %rdi        # pstr++
    cmpb    %bl, %cl            # while counter < len
    jl      while_r 
    end_r:
    movq    $0, %rax
    movq    $0, %rcx
    movq    $0, %rbx 
    ret

    .globl pstrijcpy
    .type pstrijcpy, @function
                    # given tow indxes i,j copy pstr2[i,j] to pstr1[i,j]   
pstrijcpy:          # dst = %rdi, src = %rsi, i = %dl, j = %cl
    movq    %rdi, %rax
    cmpb    $0, %cl             # if i < 0 then invalid
    jl      invalid
    cmpb    $0, %dl             # if j < 0 then invalid
    jl      invalid
    cmpb    %dl, (%rdi)         # if i > len1 then invalid
    jle     invalid
    cmpb    (%rdi), %cl         # if j > len1 then invalid
    jge     invalid
    cmpb    %dl, (%rsi)         # if i > len2 then invalid
    jle     invalid
    cmpb    (%rsi), %cl         # if j > len2 then invalid
    jge     invalid
    addq    $1, %rdi            # move to the start of the string
    addq    $1, %rsi            # move to the start of the string
    addq    %rdx, %rdi          # move to place i in the pstr1
    addq    %rdx, %rsi          # move to place i in the pstr2
    cmpb    %cl, %dl            # if i < j 
    jg      end_p
    while_p:                    # while i < j
        movb    (%rsi), %r10b   # save the char from pstr2 to r15
        movb    %r10b, (%rdi)   # copy the char to pstr1
        addb    $1, %dl         # i++
        addq    $1, %rdi        # pstr1++
        addq    $1, %rsi        # pstr2++    
    cmpb    %cl, %dl            # if i < j
    jle      while_p
    end_p:                      # end of function
    ret


    .globl swapCase
    .type swapCase, @function
                    # swap the cases of the albetcal letters in the strings by checking what letter are they
                    # capital or small then adding/subing 32 from it A-Z = 65 - 90, a-z = 97-122
swapCase:           # pstr is in %rdi
    movzbl  (%rdi), %rbx        # save the lenght of the pstring in rbx
    addq    $1, %rdi            # go to the start on the string
    movq    $0, %rcx            # crate a counter i
    cmpb    %bl, %cl            # if i < len
    jg      end_s
    while_s:                    # while i < len
        cmpb    $90, (%rdi)     # if the letter value > 90 then it may be capital 
        jg      capital     
        cmpb    $65, (%rdi)     # if the letter value > 90 then its not a letter so skip
        jl      skip
        small:                  # the letter value is 65 - 90 so its capital add 32 to make it small
        addb    $32, (%rdi)     # add 32 
        jmp     skip
        capital:        
        cmpb    $122, (%rdi)    # if the letter value > 122 then its no a letter 
        jg      skip
        cmpb    $97, (%rdi)     # if the letter value < 97 then its no a letter
        jl      skip
        subb    $32, (%rdi)     # the letter value is 97 - 122 so its small sub 32 to make it small
        skip:
        addq    $1, %rdi        # pstr++
        addb    $1, %cl         # i++
    cmpb    %bl, %cl            # while i < len
    jle      while_s
    end_s:                      # end of function
    ret     



    .globl pstrijcmp
    .type pstrijcmp, @function
                    # given tow pstrings and indxes i,j compare the tow string in Lexicographic order
                    # in the sub string and return 1 if pstr1[i,j] > pstr2[i,j], 0 if equal, -1 else 
pstrijcmp:          # pstr1 = %rdi, pstr2 = %rsi, i = %dl, j = %cl
    cmpb    $0, %cl             # if i < 0 then invalid
    jl      invalid2
    cmpb    $0, %dl             # if j < 0 then invalid
    jl      invalid2
    cmpq    %rdx, (%rdi)        # if i > len1 then invalid
    jle      invalid2
    cmpb    (%rdi), %cl         # if j > len1 then invalid
    jge      invalid2
    cmpb    %dl, (%rsi)         # if i > len2 then invalid
    jle      invalid2
    cmpb    (%rsi), %cl         # if j > len2 then invalid
    jge      invalid2 
    addq    $1, %rdi            # move to the start of the string
    addq    $1, %rsi            # move to the start of the string
    addq    %rdx, %rdi          # move to place i in the pstr1
    addq    %rdx, %rsi          # move to place i in the pstr2
    cmpb    %cl, %dl            # if i < j
    jg      end_p2
    while_p2:                   # while i < j
        movq    $0, %rbx
        movq    $0, %r8
        movb    (%rdi), %bl     # save char from pstr1 in bl(%rbx)
        movb    (%rsi), %r8b    # save char from pstr2 in r8b(%r8)
        cmpb    %r8b, %bl       # if *pstr1 is smaller or equal the go check if its smaller
        jle     smaller
        movq    $1, %rax        # *pstr1 is bigger in Lexicographic order then retrun 1
        jmp     end_p2
        smaller:
        cmpb    %r8b, %bl       # if *pstr1 is smaller return -1
        je      skip2
        movq    $-1, %rax       # *pstr1 is smaller in Lexicographic order then retrun -1
        jmp     end_p2
        skip2:
        addb    $1, %dl         # i++
        addq    $1, %rdi        # pstr1++
        addq    $1, %rsi        # pstr2++
    cmpb    %cl, %dl            # while i < j 
    jle      while_p2
    movq    $0, %rax            # the tow sub strings are equal so return 0
    end_p2:                     # end of function
    ret


invalid:        # invalid message
    leaq    error, %rdi
    movq    $0, %rax
    call    printf
    ret

invalid2:       # invalid message
    leaq    error, %rdi
    movq    $0, %rax
    call    printf
    movq    $-2, %rax
    ret
