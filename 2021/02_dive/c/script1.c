#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	int status = EXIT_SUCCESS;
	FILE *inputfile;
	if ((inputfile = fopen("../input","r")) == NULL ) {
		fputs("Error reading input file\n",stderr);
		return EXIT_FAILURE;
	}
	
	//Variable Definitions
	char dir[10];
	int amt;
	int x=0, y=0;
	int i=1;

	while (fscanf(inputfile, "%s %d",dir,&amt) != EOF) {

		if (strcmp(dir,"forward") == 0) {
			x+=amt;
		}
		else if (strcmp(dir,"up") == 0) {
			y-=amt;
		}
		else if (strcmp(dir,"down") == 0) {
			y+=amt;
		}
		else {
			fputs("Error parsing directions\n",stderr);
			return EXIT_FAILURE;
		}
		
		printf("%c %d (%d,%d)\t",dir[0],amt,x,y);
		if (i % 4 == 0) {
			printf("\n");
		}
		i++;
	}

	fclose(inputfile);
	int final=x*y;
	
	printf("\nFINAL COORDINATES\n%d, %d\n",x,y);
	printf("Total: %d\n\n",final);

	return status;
}
