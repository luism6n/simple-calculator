#include <stdio.h>
#include <stdlib.h>

extern int yyparse(void);

float *symbol_table;

void set_value(char id, float value) {
	symbol_table[id - 'a'] = value;
}

float get_value(char id) {
	return symbol_table[id - 'a'];
}

int main(int argc, char *argv[])
{
	symbol_table = calloc(26, sizeof(float));

	printf(">> ");
	while (yyparse() != 0);

	free(symbol_table);
	return 0;
}
