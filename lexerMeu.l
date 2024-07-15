%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void yyerror(const char *s);
%}

%%
[0-9]+              { printf("NUMBER(%s)\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* {
                        if (strcmp(yytext, "if") == 0) { printf("IF\n"); }
                        else if (strcmp(yytext, "else") == 0) { printf("ELSE\n"); }
                        else if (strcmp(yytext, "for") == 0) { printf("FOR\n"); }
                        else if (strcmp(yytext, "return") == 0) { printf("RETURN\n"); }
                        else if (strcmp(yytext, "int") == 0) { printf("TYPE(INT)\n"); }
                        else if (strcmp(yytext, "char") == 0) { printf("TYPE(CHAR)\n"); }
                        else { printf("IDENTIFIER(%s)\n", yytext); }
                    }
"=="                { printf("EQ\n"); }
"!="                { printf("NEQ\n"); }
">="                { printf("GE\n"); }
"<="                { printf("LE\n"); }
">"                 { printf("GT\n"); }
"<"                 { printf("LT\n"); }
"&&"                { printf("AND\n"); }
"||"                { printf("OR\n"); }
"+"                 { printf("ADD\n"); }
"-"                 { printf("SUB\n"); }
"*"                 { printf("MUL\n"); }
"/"                 { printf("DIV\n"); }
"="                 { printf("ASSIGN\n"); }
"("                 { printf("LPAREN\n"); }
")"                 { printf("RPAREN\n"); }
"{"                 { printf("LBRACE\n"); }
"}"                 { printf("RBRACE\n"); }
";"                 { printf("SEMI\n"); }
[ \t\n]+            { /* Ignorar espaços, tabulações e novas linhas */ }
.                   { printf("UNKNOWN(%s)\n", yytext); }
%%

int yywrap() {
    return 1;
}
