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
	int aim=0;
	int x=0, y=0;

	while (fscanf(inputfile, "%s %d",dir,&amt) != EOF) {

		if (strcmp(dir,"forward") == 0) {
			x+=amt;
			y+=(aim*amt);
		}
		else if (strcmp(dir,"up") == 0) {
			aim-=amt;
		}
		else if (strcmp(dir,"down") == 0) {
			aim+=amt;
		}
		else {
			fputs("Error parsing directions\n",stderr);
			return EXIT_FAILURE;
		}
	}

	fclose(inputfile);
	
	printf("\nFINAL COORDINATES\n%d, %d\n",x,y);
	printf("Total: %d\n\n",(x*y));

	return status;
}
