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
	push ebp
    mov  ebp, esp
;	compare with one
	mov eax, dword[nDisk]
	cmp eax, 49

	je equal
;	not equal
;	call hanoi n-1, a, c, b
;	call _print
;	call hanoi n-1, c, b, a
	dec eax
    push dword [ebp+12] ; stack for first recursive invocation
    push dword [ebp+16]
    push dword [ebp+20]
    push dword eax
	add esp, 16
	jmp done
	
	equal:
	call _print

	done:
	add esp, 16
	ret

_start:
	push ebp
    mov  ebp, esp
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

	push dword 0x2
	push dword 0x1
	push dword 0x3
	push dword eax
	;call _hanoi
	add esp, 16


;	exit
	mov eax, 1
    mov ebx, 0
    int 80h

section .bss
	nDisk resb 4
