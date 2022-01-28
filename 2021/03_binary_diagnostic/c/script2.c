#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEBUG 1
#define INPUTFILE "../testinput.bin"


int main(void) {
	
	FILE *inputfile;
	if ((inputfile = fopen(INPUTFILE,"rb")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return 1;
	}
	
	//Variable Definitions
	int byte[1000];
	int i = 0;
	int byte_length;
	
	if (DEBUG) printf("Reading File in While Loop\n");
	while ((byte[i] = fgetc(inputfile)) != EOF) {
		if (DEBUG) printf("i= %d\tbyte=%x\t\n", i, byte[i]);
		i++;
	}
	byte_length = i;
	if (DEBUG) printf("\nOutside of While Loop\n");
	if (DEBUG) printf("i= %d\tbyte=%x\tbyte_len=%d\n", i, byte[i], byte_length);
	i = 0;
	if (DEBUG) printf("\nInside of Index While Loop\n");
	while (i < byte_length) {
		if (DEBUG) printf("i= %d\tbyte=%x\tbyte_len=%d\n", i, byte[i], byte_length);
		i++;
	}

	fclose(inputfile);
	
	return 0;
}
