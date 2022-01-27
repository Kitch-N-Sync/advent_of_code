#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	int status = EXIT_SUCCESS;
	FILE *inputfile;
	if ((inputfile = fopen("../testinput.bin","rb")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}
	
	//Variable Definitions
	int byte;

	while (1) {
		byte = fgetc(inputfile);
		if (byte == EOF) {
			break;
		}
		printf("%x\n", byte);
	}

	printf("\n");

	fclose(inputfile);
	
	return status;
}
