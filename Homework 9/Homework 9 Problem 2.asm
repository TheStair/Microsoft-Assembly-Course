INCLUDE Irvine32.inc

.data
num1    BYTE    1, 2, 3, 1, 1, 1, 1, 1    ; First 8-digit BCD number
num2    BYTE    1, 1, 4, 1, 1, 0, 0, 0    ; Second 8-digit BCD number
result  BYTE    8 DUP(?)                  ; Result buffer for 8-digit BCD result
subSign BYTE    "-"
.code
main PROC
    ; Display the first input number
    mov edx, OFFSET num1
    call DisplayBCD
    call Crlf

    ; Display the subtraction sign
    mov edx, OFFSET subSign
    call WriteString

    ; Display the second input number
    mov edx, OFFSET num2
    call DisplayBCD
    call Crlf

    ; Subtract the two BCD numbers
    mov esi, 7       ; Start from the least significant digit
    mov ecx, 8       ; Total number of digits
    mov edi, OFFSET result
    mov edx, 0

subtractLoop:
    cmp esi, 0
    jl Display
    mov al, [num1 + esi]     ; Get the BCD digit from num1
    mov bl, [num2 + esi]     ; Get the BCD digit from num2
    cmp al, bl              ; Compare the digits
    jl borrowOccured        ; If al < bl, there will be a borrow

    cmp edx, 0
    jne carryOccurred
    jmp subtractDigit
  

borrowOccured:
    add al, 10
    mov edx, 1
    jmp subtractDigit

subtractDigit:
    sub al, bl              ; Subtract the corresponding BCD digit from num2
    das                     ; Adjust for BCD subtraction
    ; Store the result digit in the result buffer
    mov [edi + esi], al
    dec esi
    loop subtractLoop

carryOccurred:
    sub al, 01h
    das
    cmp al, bl
    jl borrowOccured
    sub al, bl
    das
    mov edx, 0
    mov [edi + esi], al
    dec esi
    loop subtractLoop

Display:
    ; Display the result
    mov edx, OFFSET result
    call DisplayBCD
    call Crlf
    ; Exit the program
    call WaitMsg
    exit
main ENDP

; Procedure to display an 8-digit BCD number in decimal
DisplayBCD PROC
    mov eax, 0
    mov ecx, 8
    mov edi, edx
displayLoop:
    mov eax, 0
    mov al, [edi]
    call WriteDec
    inc edi
    loop displayLoop
    ret
DisplayBCD ENDP

END main
