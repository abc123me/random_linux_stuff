#include "stdio.h"
int main(){
	printf("Style\tForeground\t\t\tBackground\n");
	for(int j = 0; j < 10; j++){
		printf("[%i]\t", j);
		for(int i = 30; i < 38; i++)
			printf("\033[%i;%im%i\033[0m ", j, i, i);
		putchar('\t');
		for(int i = 40; i < 48; i++)
			printf("\033[%i;%im%i\033[0m ", j, i, i);
		putchar('\n');
	}
	return 0;
}
