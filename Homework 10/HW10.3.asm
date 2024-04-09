.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

;Write a program that computes 
;the number of characters in any string.

INCLUDE Irvine32.inc

.DATA
	outputText1 BYTE "The string (", 0
	outputText2 BYTE ") contains ", 0
	outputText3 BYTE " characters.", 0
	testString BYTE "I Love Assembly Language" ,0
	bufLength DWORD ?

.code
	lengthLoop PROC
        ; Input: edi points to the string
        ; Output: eax contains the length of the string

        xor eax, eax  ; Clear eax to store the length

        repeat_loop:
            cmp byte ptr [edi], 0  ; Check if the current byte is the null terminator
            je done  ; If it is, we are done
            inc eax  ; Increment the length
            inc edi  ; Move to the next byte
            jmp repeat_loop  ; Repeat the loop

        done:
            ret
    lengthLoop ENDP

	output proc
		mov edx, OFFSET outputText1
		call WriteString
		mov edx, OFFSET testString
		call WriteString
		mov edx, OFFSET outputText2
		call WriteString
		mov eax, bufLength
		call WriteDec
		mov edx, OFFSET outputText3
		call WriteString
		exit
	output endp

	main proc
		mov eax, 0
		mov edi, OFFSET testString
		call lengthLoop
		mov bufLength, eax
		call output
		exit
	main endp
end main
