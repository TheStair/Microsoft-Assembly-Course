INCLUDE Irvine32.inc

.data
hexValue DWORD 0A73CD3E9h
Value1 Byte ?
Value2 Byte ?
Value3 Byte ?
Value4 Byte ?

.code
main PROC
    mov eax, hexValue        
    mov edx, 0

    ; Extract the specific digits
    shr eax, 16
    and ah, 0Fh             
    mov dh, ah           
    mov eax, 0             
    mov Value1, dh
    mov al, Value1
    Call WriteDec           
    Call Crlf
    mov eax, hexValue
    shr eax, 20
    shl dh, 4
    and al, 0Fh
    add dh, al
    mov Value2, al
    mov eax, 0
    mov al, Value2
    Call WriteDec
    Call Crlf

    mov eax, hexValue
    shr eax, 8
    and al, 0Fh             
    mov dl, al           
    mov eax, 0              
    mov Value3, dl
    mov al, Value3
    Call WriteDec           
    Call Crlf
    mov eax, hexValue
    shl dl, 4
    and al, 0Fh
    add dl, al
    mov Value4, al
    mov eax, 0
    mov al, Value4
    Call WriteDec
    Call Crlf

    mov ax, dx
    Call WriteHex

    exit
main ENDP

END main