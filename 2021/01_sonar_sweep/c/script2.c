#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	int status = EXIT_SUCCESS;
	int scancheck = 0;

	int a = 0, b = 0, c = 0;
	int sum1=0, sum2=0;
	int total = 0;

	FILE *inputfile;
	if ((inputfile = fopen("input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}

	do {
		scancheck = fscanf(inputfile,"%d",&c);
		sum2 = a + b + c;
		printf("%d + %d + %d = %d\n",a,b,c,sum2);
		total+=(sum2 > sum1);
		a = b;
		b = c;
		sum1 = sum2;
	} while (scancheck != EOF);
	
	fclose(inputfile);
	total = total - 4;
	printf("Total = %d\n",total);
	return status;
}
