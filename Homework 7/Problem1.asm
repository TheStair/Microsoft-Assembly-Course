.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	MyString	BYTE "Summer is pleasant in Auburn", 0
	prompt		BYTE "Enter a Letter to Search: ", 0
	charToFind	BYTE ?, 0
	Summary1	BYTE "Found the letter ",0
	Summary2	BYTE ", the index is ",0
	notFoundtxt BYTE "Character not Found.", 0
.code
	main proc
		mov esi, OFFSET MyString
		mov edx, OFFSET prompt
		Call WriteString
		Call ReadChar
		Call WriteChar
		Call Crlf
		mov charToFind, al
		mov al, charToFind
		mov ecx, 0


	searchLoop:
		mov ah, [esi]
		cmp ah, 0
		je notFound
		cmp ah, al
		je Found
		inc esi
		inc ecx
		jmp searchloop

	Found:
		
		mov edx, OFFSET Summary1
		Call WriteString
		movzx eax, BYTE ptr [charToFind]
		Call WriteChar
		mov edx, OFFSET Summary2
		Call WriteString
		mov edx, OFFSET MyString
		mov eax, ecx
		Call WriteDec
		exit

	notFound:
		mov edx, OFFSET notFoundtxt
		Call WriteString
		exit

	main endp
end main
