%{
#include "parser.tab.h"
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"+"             { return ADD; }
"-"             { return SUB; }
"*"             { return MUL; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[ \t\n]+        { /* Ignorar espaços, tabulações e novas linhas */ }
.               { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
