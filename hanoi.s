section .data
	hello: db 'Hi, this is a Tower of Hanoi solution! Tell me how many disks you have.', 10
	hellolen: equ $-hello
	message: db "move disk %d from %d to %d", 10, 0

section .text
	global main

extern printf

_print:
	push ebp
	mov  ebp, esp

	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	push message
	call printf

	mov esp, ebp
	pop ebp
	ret

_hanoi:
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]
	cmp eax, 0x0

	jle done
	push dword [ebp+16]
	push dword [ebp+20]
	push dword [ebp+12]
	dec eax
	push dword eax
	call _hanoi
	add esp,12

	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call _print
	add esp,12

	push dword [ebp+12]
	push dword [ebp+16]
	push dword [ebp+20]
	mov eax,[ebp+8]
	dec eax
	push dword eax
	call _hanoi
	add esp,12

	done:
		mov esp, ebp
		pop ebp
		ret

main:
	push ebp
	mov  ebp, esp

	mov eax, 4
	mov ebx, 0
	mov ecx, hello
	mov edx, hellolen
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, nDisk
	mov edx, 1
	int 80h

	push dword 0x3
	push dword 0x2
	push dword 0x1
	mov eax, dword[nDisk]
	sub eax, 30h
	push eax

	call _hanoi

	mov eax, 1
	mov ebx, 0
	int 80h

section .bss
	nDisk resb 1