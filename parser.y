%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void yyerror(const char *s);
int yylex(void);

%}

%token VOID INT CHAR RETURN BREAK DEFAULT FOR IF ELSE REMAINDER ASSIGN
%token PLUS MINUS MULTIPLY DIV INC DEC BITWISE_AND NOT LOGICAL_AND LOGICAL_OR 
%token EQUAL NOT_EQUAL LESS_THAN GREATHER_THAN LESS_EQUAL GREATHER_EQUAL  
%token ADD_ASSIGN MINUS_ASSIGN SEMICOLON COMMA COLON L_PAREN R_PAREN L_CURLY_BRACKET 
%token R_CURLY_BRACKET L_SQUARE_BRACKET R_SQUARE_BRACKET NUMBER_ASSIGN PRINTF SCANF
%token NUM_INTEGER CHARACTER STRING IDENTIFIER

%%
program: 
        | program stmt
        ;

stmt: declaration SEMICOLON
    | assignment SEMICOLON
    | if_stmt
    | for_stmt
    | return_stmt SEMICOLON
    ;

declaration: type IDENTIFIER
           ;

assignment: IDENTIFIER ASSIGN expr
          ;

if_stmt: IF L_PAREN expr R_PAREN stmt
       | IF L_PAREN expr R_PAREN stmt ELSE stmt
       ;

for_stmt: FOR L_PAREN assignment SEMICOLON expr SEMICOLON assignment R_PAREN stmt
        ;

return_stmt: RETURN expr
           ;

type: NUM_INTEGER
    | CHARACTER
    ;

expr: term
    | expr PLUS term
    | expr MINUS term
    | expr MULTIPLY term
    | expr DIV term
    | expr EQUAL term
    | expr NOT_EQUAL term
    | expr GREATHER_EQUAL term
    | expr LESS_EQUAL term
    | expr GREATHER_THAN term
    | expr LESS_THAN term
    | expr LOGICAL_AND term
    | expr LOGICAL_OR term
    ;

term: NUM_INTEGER
    | IDENTIFIER
    | L_PAREN expr R_PAREN
    ;

%%

