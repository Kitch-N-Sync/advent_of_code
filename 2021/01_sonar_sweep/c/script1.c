#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	int status = EXIT_SUCCESS;
	int a = 0;
	int b = 0;
	int total = 0;
	int scancheck = 0;

	FILE *inputfile;
	if ((inputfile = fopen("input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}

	do {
		scancheck = fscanf(inputfile,"%d",&b);
		printf("%d\n",b);
		total+=(b > a);
		a = b;
	} while (scancheck != EOF);
	
	fclose(inputfile);
	total = total - 1;
	printf("Total = %d\n",total);
	return status;
}
