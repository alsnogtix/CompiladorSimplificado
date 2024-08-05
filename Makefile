# Nome do executável
EXEC = compiler

# Arquivos fonte
LEX_SRC = lexer.l
YACC_SRC = parser.y
MAIN_SRC = main.c

# Arquivos gerados pelo Flex e Bison
LEX_GEN = lex.yy.c
YACC_GEN = parser.tab.c parser.tab.h

# Compilador e flags
CC = gcc
CFLAGS = -Wall -Wextra

# Regras
all: $(EXEC)

$(EXEC): $(LEX_GEN) $(YACC_GEN) $(MAIN_SRC)
	$(CC) $(CFLAGS) -o $@ $(LEX_GEN) $(YACC_GEN) $(MAIN_SRC) -lfl

$(LEX_GEN): $(LEX_SRC)
	flex $(LEX_SRC)

$(YACC_GEN): $(YACC_SRC)
	bison -d $(YACC_SRC)

clean:
	rm -f $(EXEC) $(LEX_GEN) $(YACC_GEN)

.PHONY: all clean
