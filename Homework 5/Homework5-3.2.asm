TITLE Homework 5 Problem 4

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
CloudArray	SWORD	01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
MistArray   SWORD	01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
FogArray	SWORD	12 DUP(?)

.code
main PROC
	;Display CloudArray
	mov esi, OFFSET CloudArray		;Loads the address of CloudArray
	mov ecx, LENGTHOF CloudArray	;Finds the number of elements in CloudArray

Display_cloud_array_loop:
	movzx eax, SWORD ptr [esi]
	call WriteHex
	add esi, TYPE CloudArray		; Move to the next element
	loop Display_cloud_array_loop
	call Crlf

	;Display MistArray
	mov	edi, OFFSET MistArray
	mov ecx, LENGTHOF MistArray

Display_mist_array_loop:
	movzx eax, SWORD ptr [edi]
	call WriteHex
	add edi, TYPE MistArray		; Move to the next element
	loop Display_mist_array_loop
	call Crlf

	; Add CloudArray and MistArray, into FogArray
	mov esi, OFFSET CloudArray
	mov edi, OFFSET MistArray
	mov ebx, OFFSET FogArray
	mov ecx, LENGTHOF FogArray

Calculate_sum:
	movsx eax, SWORD ptr [esi]
	add eax, [edi]
	mov [ebx], ax
	add esi, TYPE CloudArray      ; Move to the next element in CloudArray
    add edi, TYPE MistArray       ; Move to the next element in MistArray
    add ebx, TYPE FogArray        ; Move to the next element in FogArray
    loop calculate_sum             ; Repeat for all elements

	; Display FogArray
	mov esi, OFFSET FogArray
	mov ecx, LENGTHOF FogArray

Display_fog_array_loop:
	movzx eax, SWORD ptr [esi]
	call WriteHex
	add esi, TYPE CloudArray		; Move to the next element
	loop Display_fog_array_loop

	invoke ExitProcess, 0		; Exit the program

main ENDP
END MAIN