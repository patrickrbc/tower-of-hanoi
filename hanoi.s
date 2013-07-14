section .data
        hello: db 'Hi, this is a Tower of Hanoi solution! Tell me how many disks you have.', 10
        hellolen: equ $-hello

section .text
        global _start

_start:
        mov eax, 4 ; chamada: write
        mov ebx, 0 ; fd = 0 (stdout) ???
        mov ecx, hello ; string
        mov edx, hellolen ; comprimento da string
        int 80h ; chamada de sistema

	mov eax, 3 ; chamada read
	mov ebx, 0
	mov ecx, input
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx, 0
	mov ecx, input
	int 80h        

	mov eax, 1 ; chamada: exit
        mov ebx, 0 ; valor de retorno
        int 80h ; chamada de sistema

section .bss
	input resb 256
