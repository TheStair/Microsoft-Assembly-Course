INCLUDE Irvine32.inc

.data
    prompt      BYTE    "Enter a number (in decimal): ", 0
    resultMsg   BYTE    "Result: ", 0
    buffer      BYTE    16 DUP(0)

.code
main PROC
    ; Display the prompt and read the decimal input into EAX.
    mov     edx, OFFSET prompt
    call    WriteString
    call    ReadInt

    ; Calculate the result: (EAX*8) + (EAX*4) + (EAX*2) + (EAX*1).
    mov     ebx, eax      ; Copy the value of EAX to EBX.
    shl     ebx, 3        ; EAX * 8
    mov     ecx, eax      ; Copy the value of EAX to ECX.
    shl     ecx, 2        ; EAX * 4
    add     ebx, ecx      ; (EAX * 8) + (EAX * 4)
    mov     ecx, eax      ; Copy the value of EAX to ECX.
    shl     ecx, 1        ; EAX * 2
    add     ebx, ecx      ; (EAX * 8) + (EAX * 4) + (EAX * 2)
    add     ebx, eax      ; (EAX * 8) + (EAX * 4) + (EAX * 2) + (EAX * 1)

    ; Display the result.
    mov     edx, OFFSET resultMsg
    call    WriteString
    mov     eax, ebx
    call    WriteDec

    ; Exit the program.
    call    Crlf
    call    ExitProcess

main ENDP

END main