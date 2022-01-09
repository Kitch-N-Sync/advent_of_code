#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	int status = EXIT_SUCCESS;
	FILE *inputfile;

	if ((inputfile = fopen("input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}
	
	//Variable Definitions


	while (fscanf(inputfile, "%s %d",var1,&var2) != EOF) {


	}
	fclose(inputfile);
	

	return status;
}
