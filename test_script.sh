#!/bin/bash

# Compilar o analisador léxico
make clean
make

# Função para executar um teste
run_test() {
  local input="$1"
  local expected_output="$2"

  # Executar o lexer com a entrada fornecida
  local actual_output=$(echo -e "$input" | ./lexer)

  # Verificar se todas as linhas esperadas estão presentes na saída atual
  while IFS= read -r line; do
    if ! grep -q "$line" <<< "$actual_output"; then
      echo "Teste falhou"
      echo "Entrada: $input"
      echo "Saída esperada: $expected_output"
      echo "Saída atual: $actual_output"
      exit 1
    fi
  done <<< "$expected_output"

  echo "Teste passado"
}

# Teste 1: Atribuições e expressões aritméticas
run_test "x = 5; y = x + 3;" \
"IDENTIFIER(x)
ASSIGN
NUM_INTEGER(5)
SEMICOLON
IDENTIFIER(y)
ASSIGN
IDENTIFIER(x)
PLUS
NUM_INTEGER(3)
SEMICOLON"

# Teste 2: Estrutura if-else
run_test "if (x < y) { x = x + 1; } else { x = x - 1; }" \
"IF
L_PAREN
IDENTIFIER(x)
LESS_THAN
IDENTIFIER(y)
R_PAREN
L_CURLY_BRACKET
IDENTIFIER(x)
ASSIGN
IDENTIFIER(x)
PLUS
NUM_INTEGER(1)
SEMICOLON
R_CURLY_BRACKET
ELSE
L_CURLY_BRACKET
IDENTIFIER(x)
ASSIGN
IDENTIFIER(x)
MINUS
NUM_INTEGER(1)
SEMICOLON
R_CURLY_BRACKET"

# Teste 3: Operadores lógicos
run_test "if (x == y && x != y || x > y) { y = y + 1; }" \
"IF
L_PAREN
IDENTIFIER(x)
EQUAL
IDENTIFIER(y)
LOGICAL_AND
IDENTIFIER(x)
NOT_EQUAL
IDENTIFIER(y)
LOGICAL_OR
IDENTIFIER(x)
GREATER_THAN
IDENTIFIER(y)
R_PAREN
L_CURLY_BRACKET
IDENTIFIER(y)
ASSIGN
IDENTIFIER(y)
PLUS
NUM_INTEGER(1)
SEMICOLON
R_CURLY_BRACKET"


# Teste 3: Palavras reservadas e tipos
run_test "for (int i = 0; i < 10; i = i + 1) { return; }" \
"FOR
L_PAREN
INT
IDENTIFIER(i)
ASSIGN
NUM_INTEGER(0)
SEMICOLON
IDENTIFIER(i)
LESS_THAN
NUM_INTEGER(10)
SEMICOLON
IDENTIFIER(i)
ASSIGN
IDENTIFIER(i)
PLUS
NUM_INTEGER(1)
R_PAREN
L_CURLY_BRACKET
RETURN
SEMICOLON
R_CURLY_BRACKET"


echo "Todos os testes foram passados!"
