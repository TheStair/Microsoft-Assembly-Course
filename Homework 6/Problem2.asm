.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	stackSize DWORD 5

	PromptUser BYTE "Please enter a value:", 0


.code
	main proc
		mov ecx, stackSize

	inputLoop:
		mov edx, OFFSET PromptUser
		call WriteString
		call ReadInt
		PUSH eax

		loop inputLoop
		
		mov ecx, stackSize

	outputLoop:
		POP EAX
		call WriteInt
		call Crlf
		loop outputLoop

		exit
	main endp
end main
