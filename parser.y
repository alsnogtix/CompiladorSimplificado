%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXVARS 100

int yylex(void);
extern void yyerror(const char *s);

// Tabela de símbolos
typedef struct {
    char *name;
    int value;
} variable;

variable symtable[MAXVARS];
int symtable_count = 0;

int get_var_value(const char *name);
void set_var_value(const char *name, int value);
void print_symtable();  // Declaração da função para imprimir a tabela de símbolos

%}

%token NUMBER IDENTIFIER ADD SUB MUL DIV ASSIGN LPAREN RPAREN IF ELSE LBRACE RBRACE

%%
input: /* vazio */
    | input line
    ;

line: '\n'
    | stmt '\n'
    ;

stmt: exp                         { printf("Resultado: %d\n", $1); }
    | IDENTIFIER ASSIGN exp       { set_var_value($1, $3); free($1); }
    | IF LPAREN exp RPAREN stmt   { if ($3) { $$ = $5; } else { $$ = 0; } }
    | IF LPAREN exp RPAREN stmt ELSE stmt  { if ($3) { $$ = $5; } else { $$ = $7; } }
    ;

exp: term
    | exp ADD term                { $$ = $1 + $3; }
    | exp SUB term                { $$ = $1 - $3; }
    ;

term: factor
    | term MUL factor             { $$ = $1 * $3; }
    | term DIV factor             { $$ = $1 / $3; }
    ;

factor: NUMBER
    | IDENTIFIER                  { $$ = get_var_value($1); free($1); }
    | LPAREN exp RPAREN           { $$ = $2; }
    ;

%%

int get_var_value(const char *name) {
    for (int i = 0; i < symtable_count; i++) {
        if (strcmp(symtable[i].name, name) == 0) {
            return symtable[i].value;
        }
    }
    yyerror("Variável não definida");
    return 0;
}

void set_var_value(const char *name, int value) {
    for (int i = 0; i < symtable_count; i++) {
        if (strcmp(symtable[i].name, name) == 0) {
            symtable[i].value = value;
            print_symtable();  // Adicione esta linha para depuração
            return;
        }
    }
    if (symtable_count < MAXVARS) {
        symtable[symtable_count].name = strdup(name);
        symtable[symtable_count].value = value;
        symtable_count++;
        print_symtable();  // Adicione esta linha para depuração
    } else {
        yyerror("Número máximo de variáveis atingido");
    }
}

void print_symtable() {
    printf("Tabela de Símbolos:\n");
    for (int i = 0; i < symtable_count; i++) {
        printf("  %s = %d\n", symtable[i].name, symtable[i].value);
    }
}
