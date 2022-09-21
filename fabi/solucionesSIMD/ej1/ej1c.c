#include "stdint.h"
#include "stdlib.h"
#include "stdio.h"

extern void sumarVectores(char* a, char* b, char* res, int dimension);

main(){
    char* resultado;
    char sumar_3[] = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    char sumar_4[] = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";
    // A = 65
    // B = 66
    int size = sizeof(sumar_3) - 1; //-1 por el 0 al final
    sumarVectores(sumar_3, sumar_4, resultado, size);
    printf("Res: %d\n", *(resultado);
    //free (resultado);
}