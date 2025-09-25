# Controle de Contas Correntes

## Descrição do Projeto
Este projeto simula o núcleo de um sistema bancário, focado na **gestão da integridade dos dados e na lógica transacional**. 

Ele foi desenvolvido para demonstrar o domínio sobre **Modelagem de Dados Relacional** e a implementação de regras de negócio essenciais diretamente no banco de dados.

## Funcionalidades e Regras de Negócio Implementadas

O projeto garante a segurança e a coerência dos dados através de:

* **Integridade Referencial:** Uso de `PRIMARY KEY` (Chave Primária) e `FOREIGN KEY` (Chave Estrangeira) para garantir que cada transação de movimentação esteja vinculada a uma conta existente.
* **Lógica Transacional:** Criação de `Stored Procedures` para automatizar lançamentos (Depósito e Saque).
* **Validação de Negócio (Crucial):** Implementação de uma checagem de **saldo disponível** antes de permitir um saque (`IF/ELSE`). Isso evita que o cliente saque um valor maior do que o saldo em conta.
