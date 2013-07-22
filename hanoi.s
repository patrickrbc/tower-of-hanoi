section .data
	hello: db 'Hi, this is a Tower of Hanoi solution! Tell me how many disks you have.', 10
	hellolen: equ $-hello

	mova: db 10,'move disk', 32
	de: db 32, 'from', 32
	para: db 32, 'to', 32

	diskA: db 65
	diskB: db 66
	diskC: db 67

section .text
    global _start


_print:
	push ebp
    mov  ebp, esp

;	print 'move disk'
	mov eax, 4
	mov ebx, 0
	mov ecx, mova
	mov edx, 10
	int 80h

;	print disk number
	mov eax, 4
	mov ebx, 0
	mov ecx, [esp+16] ;  nDisk
	mov edx, 1
	int 80h

;	print 'from'
	mov eax, 4
	mov ebx, 0
	mov ecx, de
	mov edx, 6
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, dword[esp+20] ;  A
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
	mov ecx, dword[esp+24] ;  B
	mov edx, 1
	int 80h

	mov esp, ebp
	pop ebp
	ret


_hanoi:
	push ebp
    mov  ebp, esp

;	compare with one
	mov eax, [esp+8]
	cmp eax, 49

	je equal
;	not equal
;	call hanoi n-1, a, c, b
;	call _print
;	call hanoi n-1, c, b, a
    mov edx, [esp+8] ; N
	dec edx
    mov eax, [esp+12] ; A
    mov ebx, [esp+16] ; B
    mov ecx, [esp+20] ; C
    push ebx ; B
    push ecx ; C
    push eax ; A
    push edx ; n-1
    call _hanoi

    call _print
    jmp done

	equal:
	call _print

	done:
	mov esp, ebp
	pop ebp
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
	mov edx, 2
	int 80h

	push diskA
	push diskB
	push diskC
	push dword[nDisk]
	call _hanoi

;	exit
	mov eax, 1
    mov ebx, 0
    int 80h

section .bss
	nDisk resb 8
