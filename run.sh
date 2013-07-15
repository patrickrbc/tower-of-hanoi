nasm -f elf hanoi.s
ld -s -o hanoi hanoi.o
./hanoi