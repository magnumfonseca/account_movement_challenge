## Desafio de Movimentação de Contas

-   Simples sistema para calculo de transações em ruby


## Instalação
```bash
git https://github.com/magnumfonseca/account_movement_challenge.git
cd account_movement_challenge
chmod +x bin/account_movement.rb
```

## Conteúdo dos arquivos

### Contas:

-   Número da conta (inteiro)
-   Saldo inicial da conta, em centavos de real (inteiro) Exemplo:  **123,13052**  (Conta: 123, Saldo Inicial: R$ 130,52)

### Transações:

-   Número da conta (inteiro)
-   Valor da transação, em centavos de real (inteiro) Uma transação com valor negativo é um débito na conta e uma transação com valor positivo é um depósito na conta. Exemplo:  **123,-5300**  (Débito de R$ 53,00 na conta 123) Exemplo:  **123,350000**  (Depósito de R$ 3.500,00 na conta 123)

## Execução
```bash
./bin/account_movement.rb <path_to/arquivo_de_contas.csv> <path_to/arquivo_de_transacoes.csv>
```
O projeto contém dois arquivos de exemplo para execução
```bash
./bin/account_movement.rb spec/fixtures/contas.csv spec/fixtures/transacoes.csv
```
