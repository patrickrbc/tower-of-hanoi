section .data
	hello: db 'Hi, this is a Tower of Hanoi solution! Tell me how many disks you have.', 10
	hellolen: equ $-hello

	mova: db 'move disk', 32
	de: db 32, 'from', 32
	para: db 32, 'to', 32

	diskA: db 65
	diskB: db 66
	diskC: db 67

section .text
    global _start


_print:
;	print 'move disk'
	mov eax, 4
	mov ebx, 0
	mov ecx, mova
	mov edx, 10
	int 80h

;	print disk number
	mov eax, 4
	mov ebx, 0
	mov ecx, nDisk
	mov edx, 10
	int 80h

;	print 'from'
	mov eax, 4
	mov ebx, 0
	mov ecx, de
	mov edx, 6
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, diskA
	mov edx, 1
	int 80h

;	print 'to'
	mov eax, 4
	mov ebx, 0
	mov ecx, para
	mov edx, 4
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, diskB
	mov edx, 1
	int 80h

	ret


_hanoi:
;	compare with one
	mov eax, dword[nDisk]
	cmp eax, 49

	je equal
;	not equal
;	call hanoi n-1, a, c, b
;	call _print
;	call hanoi n-1, c, b, a
	jmp done

	equal:
	call _print

	done:
	ret

_start:
;	welcome message
	mov eax, 4
	mov ebx, 0
	mov ecx, hello
	mov edx, hellolen
	int 80h

;	read input
	mov eax, 3
	mov ebx, 0
	mov ecx, nDisk
	mov edx, 1
	int 80h

	call _hanoi

;	exit
	mov eax, 1
    mov ebx, 0
    int 80h

section .bss
	nDisk resb 4
