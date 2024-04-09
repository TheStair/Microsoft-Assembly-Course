.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	stackPrompt BYTE "How many numbers in your stack? ", 0
	prompt      BYTE "Please input a value: ", 0
	targetPrompt BYTE "Please input a target Value: ", 0
	spacing     BYTE ", ",0;
	String1     BYTE "The target value is, ", 0
	String2     BYTE " and is located at index: ",0
	String3     BYTE "Value not found", 0
	targetValue SDWORD ?
	stackSize   DWORD ?

.code
	Search proc

		mov ecx, 0

		searchLoop:
			cmp ecx, stackSize
			jae NotFound

			pop eax
			cmp eax, targetValue
			je Found

			add ebp, 4
			inc ecx
			jmp searchLoop

		Found:
			mov edx, OFFSET String1
			call WriteString
			mov eax, targetValue
			call WriteInt
			mov edx, OFFSET String2
			call WriteString
			mov eax, stackSize
			sub eax, ecx
			call WriteDec
			jmp Done

		NotFound:
			mov edx, OFFSET String3
			call WriteString
			jmp Done

		Done:
			ret
	Search endp


	main proc
		mov edx, OFFSET stackPrompt
		call WriteString
		call ReadInt
		mov stackSize, eax
		mov ecx, stackSize

	inputLoop:
		mov edx, OFFSET prompt
		call WriteString
		call ReadInt
		PUSH eax

		loop inputLoop
		
		mov ecx, stackSize
		mov edx, OFFSET targetPrompt
		call WriteString
		call ReadInt
		mov targetValue, eax
		call Search

		invoke ExitProcess, 0
	main endp
end main
