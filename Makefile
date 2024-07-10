# Nome do executável
EXEC = lexer

# Arquivos fonte
LEX_SRC = lexer.l
MAIN_SRC = main.c

# Arquivos gerados pelo Flex
LEX_GEN = lex.yy.c

# Compilador e flags
CC = gcc
CFLAGS = -Wall -Wextra

# Regras
all: $(EXEC)

$(EXEC): $(LEX_GEN) $(MAIN_SRC)
	$(CC) $(CFLAGS) -o $@ $(LEX_GEN) $(MAIN_SRC) -lfl

$(LEX_GEN): $(LEX_SRC)
	flex $(LEX_SRC)

clean:
	rm -f $(EXEC) $(LEX_GEN)

.PHONY: all clean
