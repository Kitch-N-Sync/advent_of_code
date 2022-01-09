#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bint5todec(char value[6]) {
	int mult = 1;
	int total = value[4];
	total+=value[3]*2;
	total+=value[2]*4;
	total+=value[1]*8;
	total+=value[0]*16;
	return total;
}
	
int main(void) {
	int status = EXIT_SUCCESS;
	FILE *inputfile;

	if ((inputfile = fopen("input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}
	
	//Variable Definitions
	int sixteens = 0;
	int eights = 0;
	int fours = 0;
	int twos = 0;
	int ones = 0;
	int total = 0;
	char data[6];
	char gamma[6], epsilon[6];

	while (fscanf(inputfile, "%s",data) != EOF) {
		sixteens+=(int)data[0];
		eights+=(int)data[1];
		fours+=(int)data[2];
		twos+=(int)data[3];
		ones+=(int)data[4];
		total+=1;
	}
	fclose(inputfile);
	
	gamma[0] = (sixteens > total/2);
	gamma[1] = (eights > total/2);
	gamma[2] = (fours > total/2);
	gamma[3] = (twos > total/2);
	gamma[4] = (ones > total/2);

	epsilon[0] = (sixteens < total/2);
	epsilon[1] = (eights < total/2);
	epsilon[2] = (fours < total/2);
	epsilon[3] = (twos < total/2);
	epsilon[4] = (ones < total/2);

	int gammaint = bint5todec(gamma);
	int epsilonint = bint5todec(epsilon);
	int final = gammaint*epsilonint;

	printf("Gamma: %s = %d\nEpsilon: %s = %d\nFinal: %s\n",gamma,gammaint,epsilon,epsilonint,final);

	return status;
}
