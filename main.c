#include <stdio.h>

int yyparse(void);

int main(void) {
    printf("Digite o código fonte:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
