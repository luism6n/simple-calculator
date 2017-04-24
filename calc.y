%{
#include <stdio.h>
#include <stdlib.h>

extern void set_value(char id, float value);
extern float get_value(char id);
extern int yylex(void);
void yyerror(char const *msg);
%}

%union {
	char id;
	float num;
}

%start prog
%left '+' '-'
%left '*' '/'
%token<num> ID
%token<num> NUM
%token OP
%token EOL
%token KW_PRINT
%token KW_EXIT

%type<num> expr

%%

prog: prog line EOL {printf(">> ");}
	|

line: expr {printf("%f\n", $1);}
	| cmd

expr: expr '+' expr {$$ = $1 + $3;}
	| expr '-' expr {$$ = $1 - $3;}
	| expr '*' expr {$$ = $1*$3;}
	| expr '/' expr {$$ = $1/$3;}
	| '(' expr ')' {$$ = ($2);}
	| NUM {$$ = $1;}
	| ID {$$ = get_value(yyval.id);}

cmd: ID '=' expr {set_value(yyval.id, $3);}
   | KW_PRINT expr {printf("%f\n", $2);}
   | KW_EXIT {exit(0);}

%%

void yyerror(char const *msg) {
	printf("%s\n", msg);
}
