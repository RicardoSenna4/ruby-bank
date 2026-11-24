# Etapa 1 — Domínio bancário

Objetivo: desenvolver uma biblioteca Ruby com entidades de domínio e regras bancárias, sem Rails ou banco de dados nesta etapa. O exercício também serve para comparar a modelagem conhecida em Java/Spring Boot com Ruby idiomático.

## Tarefa 1.1 — Customer

Arquivo: `lib/rubybank/models/customer.rb`.

- Criar `RubyBank::Customer` com `id`, `name`, `cpf`, `email` e `status`.
- Usar keyword arguments no construtor e validar nome, CPF e e-mail obrigatórios.
- Normalizar o CPF, removendo caracteres de formatação.
- Suportar os estados `active`, `blocked` e `inactive`.
- Implementar `activate!`, `block!` e `active?`.
- Impedir operações de clientes bloqueados.

Conceitos: módulos, `initialize`, `attr_reader`, keyword arguments, symbols, métodos `?` e `!`, visibilidade `private` e exceções.

## Tarefa 1.2 — Account

Arquivo: `lib/rubybank/models/account.rb`.

- Criar `RubyBank::Account` com `number`, `customer`, `type`, `balance` e `status`.
- Suportar contas `checking` e `savings` e usar `BigDecimal` para valores monetários.
- Iniciar com saldo zero por padrão e não expor setter público para o saldo.
- Implementar `credit!` e `debit!`, impedindo débitos superiores ao saldo.
- Impedir movimentações em contas bloqueadas ou encerradas.
- Implementar `activate!`, `block!`, `close!` e `active?`.
- Impedir o encerramento de contas cujo saldo não seja zero.

## Próximas tarefas

A etapa continua com a implementação de transações e de exceções específicas do domínio. A evolução completa do projeto inclui serviços financeiros, API, persistência, concorrência, autenticação, testes e infraestrutura.
