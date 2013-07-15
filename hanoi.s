section .data
        hello: db 'Hi, this is a Tower of Hanoi solution! Tell me how many disks you have.', 10
        hellolen: equ $-hello
        step: db 'move disk N from A to B', 10
        steplen: equ $-step
        noteq: db 'not equal', 10
        eq: db 'equal', 10

section .text
        global _start

_hanoi:
;	print input
	mov eax, 4
	mov ebx, 0
	mov ecx, step
	mov edx, steplen
	int 80h

	mov ecx, 3
	mov edx, 4
	cmp ecx, edx

	je equal
	mov eax, 4
	mov ebx, 0
	mov ecx, noteq
	mov edx, 10
	int 80h
	jmp ae

	equal:
	mov eax, 4
	mov ebx, 0
	mov ecx, eq
	mov edx, 6
	int 80h

	ae:
	ret

_start:
;	welcome message
    mov eax, 4
    mov ebx, 0
    mov ecx, hello
    mov edx, hellolen
    int 80h

;	read input
;	mov eax, 3
;	mov ebx, 0
;	mov ecx, input
;	mov edx, 1
;	int 80h

	call _hanoi

;	exit
	mov eax, 1
    mov ebx, 0
    int 80h


section .bss
	input resb 256
