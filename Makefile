default:
	nasm -f elf -g hanoi.s
	gcc -m32 hanoi.o -o hanoi
