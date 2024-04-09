.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

coordinate struct
	x sword ?
	y sword ?
	z sword ?
coordinate ends

.data
	prompt byte "Here are the z coordinates for a list of ten 3d coordinate pairs:",0
	coordinateSet coordinate 10 dup(<>)
	exampleZ sword -7,8,3,-5,1,-16,4,-3,9,6
.code
main proc
	mov edx, offset prompt
	call WriteString
	call crlf

	mov ecx, 10
	mov esi, 0
	mov edi, 0
	l1:
		mov bx, exampleZ[edi]
		mov coordinateSet[esi].z, bx
		add esi, sizeof coordinate
		add edi, 2
	loop l1

	mov ecx, 10
	mov ebx, offset coordinateSet
	mov esi, 4
	mov eax, 0

	l2:
		mov eax, 0
		mov ax, [ebx+esi]
		cwde
		call WriteInt
		call crlf
		add ebx, sizeof coordinate
	loop l2
	exit
main endp

end main