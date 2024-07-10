#include <stdio.h>

extern int yylex(void);

int main(void) {
    printf("Digite o código fonte:\n");
    yylex();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
