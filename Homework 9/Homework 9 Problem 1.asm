INCLUDE Irvine32.inc

.data
varX SDWORD ?   ;placeholder variables for output formatting
varA SDWORD ?
varB SDWORD ?
varC SDWORD ?
initPrompt BYTE "This program Calculates the formula X = A - B + C",0
promptA BYTE "Please enter a value for A: ",0
promptB BYTE "Please enter a value for B: ",0
promptC BYTE "Please enter a value for C: ",0
subPrompt BYTE " - ",0
addPrompt BYTE " + ",0
eqlPrompt BYTE " = ",0

.code
ArithmeticExpression PROC

    mov edx, OFFSET initPrompt
    call WriteString
    call Crlf

    mov edx, OFFSET promptA
    call WriteString
    call Readint
    push eax   ; Push A onto the stack
    mov varA, eax

    mov edx, OFFSET promptB
    call WriteString
    call Readint
    push eax    ; Push B onto the stack
    mov varB, eax
 

    mov edx, OFFSET promptC
    call WriteString
    call Readint
    push eax     ; Push C onto the stack
    mov varC, eax
    
    ; Retrieve the values of A, B, and C from the stack
    mov eax, 0
    pop eax  ; A
    pop ebx  ; B
    pop ecx  ; C

    ; Calculate X = A - B + C
    sub eax, ebx  ; X = A - B
    add eax, ecx  ; X = X + C

    mov varX, eax

    ret
ArithmeticExpression ENDP

main PROC

    call ArithmeticExpression

    ; Result (X) is now on top of the stack, and its address is in EDI
    mov eax, varA
    call WriteInt

    mov edx, OFFSET subPrompt
    call WriteString
    mov eax, varB
    call WriteInt

    mov edx, OFFSET addPrompt
    call WriteString
    mov eax, varC
    call WriteInt

    mov edx, OFFSET eqlPrompt
    call Writestring

    mov eax, varX
    push eax
    Call WriteInt

    exit
main ENDP

END main