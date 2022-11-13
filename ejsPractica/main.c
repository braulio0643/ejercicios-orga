#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	/*
	char* palabra1 = "Salamin";
    char* palabra2 = "Salame";
    node** l = malloc(200);
    node* nodo1 = malloc(24);
    node* nodo2 = malloc(24);
    node* nodo3 = malloc(24);
    node* nodo4 = malloc(24);
    node* nodo5 = malloc(24);

    nodo1->string = palabra2;
    nodo1->next = nodo2;

    
    nodo2->string = palabra1;
    nodo2->next = nodo3;
    nodo2->prev = nodo1;

    
    nodo3->string = palabra1;
    nodo3->next = nodo4;
    nodo3->prev = nodo2;
    
    nodo4->string = palabra2;
    nodo4->next = nodo5;
    nodo4->prev = nodo3;

    
    nodo5->string = palabra1;
    nodo5->prev = nodo4;

    l[0] = nodo1;
    l[1] = nodo2;
    l[2] = nodo3;
    l[3] = nodo4;
    l[4] = nodo5;
    borrarTerminadasEn(l, 'e', 5);
*/
    asd* arr = malloc(36);
    for (uint8_t i = 0; i < 24; i++)
    {
        asd tuvieja;
        tuvieja.x = i; 
        arr[i] = tuvieja;
        /* code */
    }
    bool res = ordena12bit(arr);


	return 0;
}


