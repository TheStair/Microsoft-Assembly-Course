.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.DATA
	key DWORD 56
	plainText	BYTE "Nelson", 0
	cipherText	BYTE 6 DUP(?)
	decodedText	BYTE 6 DUP(?)

.code
	main proc
		mov esi, OFFSET plainText
		mov edi, OFFSET cipherText
		mov ebx, key
		mov ecx, 6

	encryptLoop:
		lodsb
		xor al, byte ptr [key]
		stosb
		loop encryptLoop

		mov edx, OFFSET cipherText
		call WriteString
		call Crlf

		mov esi, OFFSET cipherText
		mov edi, OFFSET decodedText
		mov ecx, 6

	decryptLoop:
		lodsb
		xor al, byte ptr [key]
		stosb
		loop decryptLoop

		mov edx, OFFSET decodedText
		call WriteString

		exit
	main endp
end main
