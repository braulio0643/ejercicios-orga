#include "stdint.h"
#include "stdlib.h"
#include "stdio.h"

extern intercalar(char* a, char* b, char* res, int dimension);

main(){
    char aIntercalar_1[] = "BBBBBBBBBBBBBBB";
    char aIntercalar_2[] = "AAAAAAAAAAAAAAA";

    char* resultado= malloc(32);
    
    int dimension = sizeof(aIntercalar_1) + sizeof(aIntercalar_2); //-1 por el 0 al final
    intercalar(aIntercalar_1, aIntercalar_2, resultado, dimension);
    printf("%s\n", resultado);
}