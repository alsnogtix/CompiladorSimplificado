%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER ADD SUB MUL DIV LPAREN RPAREN

%%
input: /* vazio */
    | input line
    ;

line: '\n'
    | exp '\n'   { printf("Resultado: %d\n", $1); }
    ;

exp: term
    | exp ADD term   { $$ = $1 + $3; }
    | exp SUB term   { $$ = $1 - $3; }
    ;

term: factor
    | term MUL factor { $$ = $1 * $3; }
    | term DIV factor { $$ = $1 / $3; }
    ;

factor: NUMBER
    | LPAREN exp RPAREN { $$ = $2; }
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(void) {
    return yyparse();
}
