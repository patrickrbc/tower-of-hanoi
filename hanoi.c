#include <stdio.h>
#include <stdlib.h>

void hanoi(int n, char a, char b, char c)
{
	if (n == 1)
		printf("mova disco %d de %c para %c\n", n, a, b);
	else
	{
		hanoi(n - 1, a, c, b);
		printf("mova disco %d de %c para %c\n", n, a, b);
		hanoi(n - 1, c, b, a);
	}
}

int main(void)
{
	int numDiscos;
	scanf("%d", &numDiscos);
	hanoi(numDiscos, 'A', 'B', 'C');
	return 0;
}
// x/99 0x8048080
