.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	motto BYTE "War Eagle! ", 0
	promptMsg BYTE "Enter 0, 1, or 2: ", 0
	idblue BYTE 1h
	idred BYTE 4h
	idorange BYTE 6h

.code
	InputIntColor proc
		mov edx, OFFSET promptMsg		; Display promptMsg
		call WriteString
		call ReadInt					; Reads User Input
		mov bl, al						; Stores user input in BL register

	InputIntColor endp

	DisplayTiger proc
		cmp bl, 0
		je outputBlue

		cmp bl, 1
		je outputOrange

		cmp bl, 2
		je outputRed

		done:
			mov edx, OFFSET motto
			call WriteString
			ret

		outputBlue:
			mov edx, 0
			movzx eax, idblue
			Call SetTextColor
			jmp done

		outputOrange:
			mov edx, 0
			movzx eax, idorange
			Call SetTextColor
			jmp done

		outputRed:
			mov edx, 0
			movzx eax, idred
			Call SetTextColor
			jmp done


	DisplayTiger endp

	main proc

	call InputIntColor
	call DisplayTiger
	invoke ExitProcess, 0
	main endp
end main