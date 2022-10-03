#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <argp.h>

#include "utils.h"
#include "ej2.h"


int main (int argc, char *argv[]) {
	/* Acá pueden realizar sus propias pruebas */
	printf("%d\n", sizeof(unsigned));
	int16_t* entrada = {1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2};
	int16_t* salida = filtro(entrada, 16);
	return 0;  
}

