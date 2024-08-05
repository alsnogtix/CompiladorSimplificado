#!/bin/bash

# Compilar o analisador léxico e sintático
make clean
make

# Verificar se a compilação foi bem-sucedida
if [ $? -ne 0 ]; then
    echo "Erro na compilação"
    exit 1
fi

# Executar o analisador sintático com os casos de teste
echo "Executando casos de teste..."
./compiler < test_cases.txt
