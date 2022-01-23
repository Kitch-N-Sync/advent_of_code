#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int status = EXIT_SUCCESS;
	FILE *inputfile;
	if ((inputfile = fopen("../input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}
	
	//Variable Definitions
	const short int datalength = 12;
	unsigned int totalcodes = 1;
	unsigned short int byteval[datalength];
	unsigned int store[datalength];
	char bytestring[datalength];
	unsigned int gamma[datalength];
	unsigned int epsilon[datalength];
	unsigned int gtotal = 0;
	unsigned int etotal = 0;
	unsigned int mod = 1;

	//Zeroing Store
	for (int i=0; i<datalength; i++) {
		store[i] = 0;
	}

	printf("\n");
	//Reading through data lines
	while (fscanf(inputfile, "%s", bytestring) != EOF) {

		printf("%d:\t", totalcodes);

		//Convert from ASCII to int
		for (int i=0; i<datalength; i++) {
			byteval[i] = (int)bytestring[i] - 48;
			store[i] += byteval[i];
			printf("%d", byteval[i]);
		}

		//Print store[]
		printf("\t");
		for (int i=0; i<datalength; i++) {
			printf("%d ", store[i]);
		}
		printf("\n");
		totalcodes++;
	}
	
	//Find Gamma/Epsilon (Done in reverse because of binary calculation)
	//printf("\nMOD\tGAM\tGTOT\tEPS\tETOT\n");
	for ( int i=datalength-1; i>=0; i-- ) {
		if ( store[i] > (totalcodes / 2 )) {
			gamma[i] = 1;
			gtotal = gtotal + mod;
			epsilon[i] = 0;
		}
		else {
			gamma[i] = 0;
			epsilon[i] = 1;
			etotal =etotal + mod;
		}
		//printf("%d\t%d\t%d\t%d\t%d\n", mod, gamma[i], gtotal, epsilon[i], etotal);
		mod = mod * 2;
	}

	//Print Gamma
	printf("\nG:\t");
	for ( int i=0; i<datalength; i++ ) {
		printf("%d", gamma[i]);
	}
	printf("\t%d", gtotal);

	//Print Epsilon
	printf("\nE:\t");
	for ( int i=0; i<datalength; i++ ) {
		printf("%d", epsilon[i]);
	}
	printf("\t%d", etotal);

	printf("\nT:\t%d\t\n\n", (gtotal * etotal));
	fclose(inputfile);
	
	return status;
}
