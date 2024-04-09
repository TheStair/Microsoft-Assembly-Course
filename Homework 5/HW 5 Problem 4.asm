INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096

.data
FogArray SWORD -1, 87, 0CFh, 1234, -9, -256, 23, -11, 42, -7
n DWORD ?                   ; Variable to store user input
oddNumbers SWORD 10 DUP(?)  ; Array to store the first n odd numbers
oddCount DWORD 0            ; Variable to keep track of the count of odd numbers found

promptMsg BYTE "Enter the value of n: ",0

.code
main PROC
    mov edx, OFFSET promptMsg   ; Display prompt message
    call WriteString
    call ReadInt                ; Read user input into EAX
    mov n, eax                  ; Store the input value in the n variable

    mov esi, OFFSET FogArray    ; Load address of FogArray
    mov ecx, LENGTHOF FogArray  ; Set loop counter to length of FogArray
    mov edi, OFFSET oddNumbers ; Load address of oddNumbers
    mov oddCount, 0            ; Initialize oddCount to 0

find_odd_elements:
    mov ax, [esi]              ; Load a signed word from FogArray
    test ax, 1                 ; Check if it's odd (bit 0 set)
    jnz element_is_odd         ; Jump if odd
    add esi, TYPE FogArray     ; Move to the next element in FogArray
    loop find_odd_elements      ; Repeat for all elements
    jmp done

element_is_odd:
    mov [edi], ax              ; Store the odd element in oddNumbers
    add esi, TYPE FogArray     ; Move to the next element in FogArray
    add edi, TYPE oddNumbers   ; Move to the next element in oddNumbers
    inc oddCount               ; Increment oddCount
    loop find_odd_elements      ; Repeat for all elements

done:
    push oddCount              ; Push the count of odd elements for formatting
    pop ecx                    ; Restore the count from the stack
    call Crlf

    ; Display the first n odd numbers from oddNumbers array
    mov ecx, n                 ; Set loop counter to n
    mov edi, OFFSET oddNumbers ; Load address of oddNumbers array

display_odd_numbers:
    movsx eax, SWORD ptr [edi]              ; Load an odd number from oddNumbers array
    call WriteInt
    call Crlf
    add edi, TYPE oddNumbers   ; Move to the next element in oddNumbers
    loop display_odd_numbers

    invoke ExitProcess, 0      ; Exit the program

main ENDP
END main