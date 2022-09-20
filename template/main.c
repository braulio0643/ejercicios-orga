#include "func.h"

int main() {
    char string[4]= "CASA";
	uint32_t x = 3;
	const char* tuvieja= cesar2(string, x); 
	printf("%s", tuvieja);
    return 0;
}
