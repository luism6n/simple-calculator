%{
#include <stdio.h>
#include "y.tab.h"

extern YYSTYPE yylval;
%}

%%

"print" {return KW_PRINT;}
"exit"  {return KW_EXIT;}
[a-z]   {yylval.id = yytext[0]; return ID;}
[-+]?(\.[0-9]+|[0-9]+\.?([0-9]+)?)([eE][-+]?[0-9]+)? {
         yylval.num = atof(yytext); return NUM;}
[-=+*/]  {return yytext[0];}
"\n"    {return EOL;}
[ \t\r] {;}

%%

int yywrap() {
	return 1;
}
