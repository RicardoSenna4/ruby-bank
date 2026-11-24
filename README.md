# RubyBank

O RubyBank é um projeto de aprendizado incremental para transferir conhecimentos de Java e Spring Boot para Ruby e Ruby on Rails. A ideia é construir um domínio bancário e evoluí-lo progressivamente para serviços, API, persistência, segurança, testes e infraestrutura.

A regra de trabalho é reaproveitar, refatorar e ampliar o que já existe, em vez de recomeçar o projeto a cada etapa. A Etapa 1 começa como uma biblioteca Ruby, sem Rails nem banco de dados. As etapas seguintes introduzem as tecnologias conforme a necessidade.

## Mapa de aprendizado por tarefa

Este roteiro antecipa os conceitos que serão praticados. Os detalhes funcionais e critérios de cada tarefa estão descritos nas etapas abaixo.

### Etapa 1 — Domínio bancário

- **1.1 — Customer:** módulos, `initialize`, `attr_reader`, keyword arguments, symbols, métodos `?` e `!`, `private`, validação e `raise`; diferenças em relação a uma entidade Java com JPA, annotations e getters explícitos.
- **1.2 — Account:** encapsulamento do saldo, `BigDecimal`, regras de domínio, estados e exceções; comparação com `AccountEntity`, `credit`, `debit` e `hasSufficientBalance` em Java.
- **1.3 — Transaction:** modelagem de eventos financeiros, tipos e estados com symbols, datas/horários e conversão de objetos para hashes.
- **1.4 — Exceções de domínio:** hierarquia de classes de erro, herança de `StandardError` e representação de falhas específicas.
- **1.5 — Integração do domínio:** carregamento de arquivos Ruby, composição de entidades, tratamento de exceções e separação entre domínio e apresentação no executável.

### Etapa 2 — Services e regras de negócio

- **2.1 — Serviços financeiros:** Service Objects, injeção de dependências pelo construtor e interface simples com `call`.
- **2.2 — Repositórios em memória:** encapsulamento de armazenamento, coleções Ruby e duck typing no lugar de interfaces formais obrigatórias.
- **2.3 — Transferências:** coordenação de múltiplas entidades, validação de regras, consistência contra alterações parciais e resultados previsíveis.
- **2.4 — Idempotência básica:** chaves de idempotência, comparação de requisições repetidas e tratamento de conflito.

### Etapa 3 — API REST com Rails

- **3.1 — Inicialização Rails API:** estrutura de uma aplicação Rails em modo API e configuração de banco para etapas futuras.
- **3.2 — Rotas:** verbos HTTP, URLs versionadas e correspondência entre endpoints e responsabilidades.
- **3.3 — Controllers:** ciclo de requisição/resposta, parâmetros, delegação aos services e separação da lógica financeira.
- **3.4 — Respostas e exceções:** códigos HTTP, JSON, `render`, `rescue_from` e carregamento automático com Zeitwerk.

### Etapa 4 — PostgreSQL e Active Record

- **4.1 — Migrations:** modelagem relacional, chaves, índices, nulabilidade e tipos decimais para dinheiro.
- **4.2 — Associações:** relacionamentos `has_many` e `belongs_to` e navegação entre entidades persistidas.
- **4.3 — Adaptação dos serviços:** integração entre regras de negócio e Active Record, avaliando quando repositórios próprios agregam valor.
- **4.4 — Extratos paginados:** filtros por tipo e período, paginação e consultas relacionais.

### Etapa 5 — Transações e concorrência

- **5.1 — Transações SQL:** atomicidade e rollback com `ActiveRecord::Base.transaction`.
- **5.2 — Locking:** locking pessimista e ordem consistente de aquisição para reduzir condições de corrida e deadlocks.
- **5.3 — Idempotência persistente:** armazenamento das chaves no PostgreSQL e restrições únicas.
- **5.4 — Teste de concorrência:** concorrência realista, integridade de saldo e validação de resultados simultâneos.

### Etapa 6 — Autenticação e autorização

- **6.1 — Usuários e credenciais:** entidade `User`, cadastro, login e hash de senha BCrypt.
- **6.2 — Tokens:** geração e validação JWT, refresh tokens persistidos e revogação.
- **6.3 — Papéis e ownership:** roles `USER`/`ADMIN` e autorização de acesso aos próprios clientes e contas.
- **6.4 — Proteção de endpoints e logout:** autenticação por requisição, proteção por padrão e encerramento/revogação de sessões.
- **Conceitos transversais:** `has_secure_password`, gem `jwt`, `before_action` e policies com Pundit, em comparação com Spring Security.

### Etapa 7 — Testes automatizados

- **7.1 — Testes unitários:** especificações para `Customer`, `Account` e `Transaction` com RSpec.
- **7.2 — Testes de services:** cenários financeiros de sucesso e falha.
- **7.3 — Factories:** geração de dados de teste com FactoryBot.
- **7.4 — Request specs:** validação dos endpoints HTTP e respostas da API.
- **7.5 — Segurança:** testes de autenticação e autorização.
- **7.6 — Idempotência:** repetição de requisições e conflitos de chave.
- **7.7 — Rollback e concorrência:** integridade transacional e operações simultâneas.
- **7.8 — Cobertura:** medição de cobertura com SimpleCov. Recomenda-se escrever testes desde a Etapa 1; esta etapa consolida e amplia a suíte.

### Etapa 8 — Redis e rate limiting

- **8.1 — Integração com Redis:** conexão da aplicação a um armazenamento compartilhado.
- **8.2 — Cache de clientes:** leitura em cache e estratégia de invalidação.
- **8.3 — Limite de login:** proteção contra tentativas abusivas de autenticação.
- **8.4 — Limite de transações:** restrição de operações financeiras por período.
- **8.5 — Escopo e resposta:** limites por usuário e, quando necessário, por origem; retorno HTTP 429.
- **8.6 — Testes:** expiração, invalidação e comportamento com armazenamento compartilhado.
- **Conceitos:** Rails Cache, Redis, Rack middleware, TTL e estratégias de invalidação.

### Etapa 9 — Jobs e processamento assíncrono

- **9.1 — Active Job persistente:** configuração de backend que preserve trabalhos pendentes.
- **9.2 — Jobs de notificação:** execução de trabalho fora do ciclo HTTP.
- **9.3 — Retry:** políticas para recuperação de falhas temporárias.
- **9.4 — Outbox:** persistência de eventos a publicar junto das operações de negócio.
- **9.5 — Publicação de eventos:** emissão após confirmação das operações financeiras.
- **9.6 — Idempotência dos consumidores:** prevenção de efeitos duplicados ao reprocessar mensagens.
- **9.7 — Registro de falhas:** observabilidade dos erros de processamento.
- **9.8 — Recuperação após reinicialização:** verificação de que trabalhos e eventos possam ser retomados.

### Etapa 10 — Infraestrutura e entrega profissional

- **10.1 — Dockerfile:** criação de uma imagem reproduzível da aplicação.
- **10.2 — Docker Compose:** execução conjunta de Rails, PostgreSQL e Redis.
- **10.3 — Variáveis de ambiente:** configuração sem segredos hard-coded.
- **10.4 — Health checks:** verificação de disponibilidade dos componentes.
- **10.5 — Logs estruturados:** registro útil para depuração e operação.
- **10.6 — OpenAPI:** documentação dos contratos HTTP.
- **10.7 — GitHub Actions:** automação de testes e verificações em CI.
- **10.8 — Qualidade e segurança:** integração de RuboCop e Brakeman.
- **10.9 — Testes de carga:** avaliação básica de desempenho.
- **10.10 — Documentação final:** atualização do README e da documentação arquitetural.

## Etapa 1 — Implementar o domínio bancário

**Objetivo:** transformar a estrutura inicial em uma biblioteca Ruby funcional, com entidades de domínio, validações e regras bancárias. Não utilizar Rails nem banco de dados nesta etapa.

### Tarefa 1.1 — Implementar Customer

**Arquivo:** `lib/rubybank/models/customer.rb`.

**Requisitos:**

1. Criar a classe `RubyBank::Customer`.
2. Definir os atributos `id`, `name`, `cpf`, `email` e `status`.
3. Utilizar keyword arguments no construtor.
4. Validar nome, CPF e e-mail obrigatórios.
5. Normalizar o CPF, removendo caracteres de formatação.
6. Permitir os estados `active`, `blocked` e `inactive`.
7. Criar os métodos `activate!`, `block!` e `active?`.
8. Impedir operações de clientes bloqueados.

**Aprendizado:** `module`, `initialize`, `attr_reader`, keyword arguments, symbols, métodos terminados em `?` e `!`, `private` e `raise`. Em comparação com Java, `Customer` assume parte das responsabilidades de `ClientEntity` sem JPA, annotations ou getters explícitos.

**Verificação sugerida:** instanciar `Customer` com dados nomeados, confirmar que o CPF formatado foi normalizado e que `active?` muda após `block!`. O CPF ilustrativo não precisa ter dígitos verificadores válidos nesta etapa.

### Tarefa 1.2 — Implementar Account

**Arquivo:** `lib/rubybank/models/account.rb`.

**Requisitos:**

1. Criar `RubyBank::Account`.
2. Implementar `number`, `customer`, `type`, `balance` e `status`.
3. Suportar contas `checking` e `savings`.
4. Utilizar `BigDecimal` para valores monetários.
5. Inicializar contas com saldo zero por padrão.
6. Implementar `credit!` e `debit!`.
7. Impedir débitos superiores ao saldo.
8. Impedir movimentações em contas bloqueadas ou encerradas.
9. Implementar `activate!`, `block!`, `close!` e `active?`.
10. Impedir encerramento de contas com saldo diferente de zero.

**Requisito arquitetural:** não permitir modificar o saldo por meio de um setter público.

**Aprendizado:** precisão decimal para valores financeiros, encapsulamento de estado, validações e métodos de domínio. Em comparação com Java, a tarefa corresponde a `AccountEntity` e às operações `credit`, `debit`, `hasSufficientBalance` e verificações de status.

### Tarefa 1.3 — Implementar Transaction

**Arquivo:** `lib/rubybank/models/transaction.rb`.

**Requisitos:**

1. Criar `RubyBank::Transaction`.
2. Implementar os atributos `id`, `type`, `amount`, `status` e `created_at`.
3. Registrar conta de origem e destino quando aplicável.
4. Suportar as operações `deposit`, `withdraw`, `transfer_in` e `transfer_out`.
5. Suportar os estados `approved`, `rejected` e `pending`.
6. Impedir valores monetários negativos ou nulos.
7. Utilizar `Time` ou `Time.now.utc` para registrar a criação.
8. Criar `to_h` para converter a transação em um hash.

**Aprendizado:** representação de eventos financeiros, símbolos para tipos/estados, datas e serialização simples de objetos.

### Tarefa 1.4 — Implementar exceções do domínio

**Arquivo:** `lib/rubybank/errors/domain_error.rb`.

Criar uma hierarquia em que `RubyBank::DomainError` herde de `StandardError` e contenha exceções específicas para `InvalidAmountError`, `InsufficientFundsError`, `InvalidAccountStateError` e `InvalidCustomerError`.

**Requisito:** todas as exceções devem herdar de `StandardError`, direta ou indiretamente, e representar falhas específicas do domínio.

**Aprendizado:** hierarquia de classes, herança e tratamento de erros expressivos em Ruby.

### Tarefa 1.5 — Integrar o domínio

**Arquivos:** `lib/rubybank.rb` e `bin/rubybank`.

Criar um cenário demonstrativo que instancie um cliente, crie uma conta vinculada, credite R$ 1.000,00, debite R$ 250,00, consulte o saldo e tente debitar R$ 2.000,00. Capturar a exceção de saldo insuficiente e preservar o saldo anterior.

**Resultado esperado:** cliente Ana Silva, conta 100001 do tipo `CHECKING`, depósito de R$ 1.000,00, saque de R$ 250,00, saldo de R$ 750,00, mensagem de saldo insuficiente ao tentar sacar R$ 2.000,00 e saldo final ainda em R$ 750,00.

**Critério para avançar:** as classes funcionam sem `gets`, `puts` ou código de apresentação dentro do domínio; a saída demonstrativa é produzida somente pelo executável.

**Aprendizado:** carregamento de arquivos Ruby, integração/composição de entidades, tratamento de exceções e separação entre domínio e interface de terminal.

## Etapa 2 — Services e regras de negócio

**Objetivo:** separar operações que envolvem múltiplas entidades da lógica interna dos modelos. Utilizar o diretório `services/` já criado.

### Tarefa 2.1 — Criar serviços financeiros

Criar `lib/rubybank/services/deposit_service.rb`, `withdraw_service.rb` e `transfer_service.rb`. Cada serviço recebe dependências pelo construtor e expõe `call`.

**Aprendizado:** Service Objects, injeção de dependências e composição de objetos.

### Tarefa 2.2 — Implementar repositórios em memória

Criar `lib/rubybank/repositories/customer_repository.rb`, `account_repository.rb` e `transaction_repository.rb`. Os repositórios devem permitir salvar, buscar e listar entidades, usando arrays ou hashes internamente.

**Aprendizado:** abstração de armazenamento e duck typing. Em Ruby, não é obrigatório criar interfaces formais como em Java para estabelecer contratos entre objetos.

### Tarefa 2.3 — Implementar transferências

**Requisitos funcionais:** validar origem e destino; impedir transferência para a própria conta; verificar saldo; debitar da origem e creditar no destino; criar registros de saída e entrada; não alterar contas se a transferência for rejeitada; e retornar um resultado consistente à camada chamadora.

Como o armazenamento ainda é em memória, coordenar a operação para evitar alterações parciais no fluxo sequencial. A atomicidade real com banco será tratada na Etapa 5.

**Aprendizado:** orquestração de casos de uso, regras que atravessam entidades e consistência de operações compostas.

### Tarefa 2.4 — Implementar idempotência básica

Cada transferência aceita `idempotency_key`. Uma repetição da mesma chave com os mesmos dados não repete a movimentação; reutilizar a chave com dados diferentes resulta em conflito.

**Critério para avançar:** operações bancárias são executadas pelos services, sem dependência da interface de terminal, e repositórios podem ser substituídos por outras implementações.

**Aprendizado:** idempotência, repetição segura de requisições e validação de conflitos.

## Etapa 3 — Criar API REST em Ruby on Rails

**Objetivo:** transformar o RubyBank em uma aplicação HTTP, reaproveitando o domínio Ruby em vez de duplicar regras. Configurar Rails em modo API e PostgreSQL como destino, embora a persistência seja integrada na etapa seguinte.

### Tarefa 3.1 — Inicializar Rails em modo API

Configurar a estrutura de aplicação Rails API e o banco PostgreSQL como destino.

**Aprendizado:** estrutura de projetos Rails, configuração de aplicação e diferenças entre uma biblioteca Ruby e uma aplicação web.

### Tarefa 3.2 — Implementar rotas

Implementar os endpoints:

| Método | Endpoint | Responsabilidade |
|---|---|---|
| POST | `/api/v1/customers` | Criar cliente |
| GET | `/api/v1/customers/:id` | Consultar cliente |
| POST | `/api/v1/accounts` | Criar conta |
| GET | `/api/v1/accounts/:number` | Consultar conta |
| POST | `/api/v1/transactions/deposit` | Depositar |
| POST | `/api/v1/transactions/withdraw` | Sacar |
| POST | `/api/v1/transactions/transfer` | Transferir |
| GET | `/api/v1/accounts/:number/statement` | Consultar extrato |

**Aprendizado:** verbos HTTP, versionamento de API, rotas e desenho de recursos.

### Tarefa 3.3 — Implementar controllers

Criar `CustomersController`, `AccountsController` e `TransactionsController`. Controllers recebem requisições, validam parâmetros, chamam services e constroem respostas HTTP; não devem conter lógica financeira.

**Aprendizado:** `ActionController::API`, parâmetros e responsabilidades de controllers finos.

### Tarefa 3.4 — Padronizar respostas e exceções

Tratar erros HTTP `400`, `404`, `409` e `422` conforme a falha. Usar rotas em `routes.rb`, `render`, `params`, `rescue_from` e carregamento automático do Zeitwerk.

**Critério para avançar:** todos os endpoints funcionam no Insomnia com repositórios em memória, sem autenticação nesta fase.

**Aprendizado:** ciclo de requisição/resposta, JSON e tradução de erros de domínio para respostas HTTP.

## Etapa 4 — PostgreSQL e Active Record

**Objetivo:** substituir o armazenamento em memória por persistência relacional.

### Tarefa 4.1 — Criar migrations

Criar tabelas `Customers`, `Accounts` e `Transactions`, com chaves primárias e estrangeiras, índices únicos, restrições de nulidade e tipos decimais apropriados para dinheiro.

**Aprendizado:** migrations, schema relacional, integridade referencial e modelagem de dados financeiros.

### Tarefa 4.2 — Implementar associações

Representar relacionamentos entre clientes, contas e movimentações utilizando `has_many` e `belongs_to`.

**Aprendizado:** associações Active Record e navegação entre registros relacionados.

### Tarefa 4.3 — Adaptar os serviços

Integrar os services existentes ao Active Record. Avaliar se manter interfaces de repositório traz benefício suficiente: Rails permite consultas pelos modelos, sem reproduzir automaticamente o padrão Spring Data JPA sem justificativa técnica.

**Aprendizado:** integração entre camada de negócio e persistência e avaliação de abstrações adequadas ao ecossistema Rails.

### Tarefa 4.4 — Implementar extratos paginados

Permitir filtrar extratos por tipo, data inicial, data final e página.

**Critério para avançar:** clientes, contas e transações permanecem disponíveis após reiniciar a aplicação.

**Aprendizado:** consultas, filtros, paginação e persistência durável.

## Etapa 5 — Transações e concorrência

**Objetivo:** garantir a integridade das operações financeiras diante de falhas e requisições simultâneas.

### Tarefa 5.1 — Implementar transações SQL

Utilizar `ActiveRecord::Base.transaction` nas operações que modificam várias entidades.

**Aprendizado:** atomicidade e rollback de mudanças relacionadas.

### Tarefa 5.2 — Implementar locking

Proteger as contas de transferências com locking pessimista e ordem consistente de aquisição de locks.

**Aprendizado:** condições de corrida, exclusão mútua e prevenção de deadlocks.

### Tarefa 5.3 — Implementar idempotência persistente

Substituir as chaves temporárias por persistência no PostgreSQL com restrições únicas.

**Aprendizado:** idempotência durável e garantias de unicidade no banco.

### Tarefa 5.4 — Testar concorrência

Simular duas transferências simultâneas de R$ 800,00 a partir de uma conta com R$ 1.000,00.

**Critério para avançar:** somente uma transferência é aprovada e os saldos permanecem consistentes.

**Aprendizado:** testes concorrentes e validação de invariantes financeiros sob carga simultânea.

## Etapa 6 — Autenticação e autorização

**Objetivo:** proteger a API com mecanismos equivalentes aos conhecidos do Spring Security.

### Tarefa 6.1 — Criar usuário e credenciais

Criar a entidade `User` e implementar cadastro e login com BCrypt.

**Aprendizado:** armazenamento seguro de senhas e autenticação de usuários; `has_secure_password`.

### Tarefa 6.2 — Implementar tokens

Gerar e validar JWT; implementar refresh tokens persistidos e revogáveis.

**Aprendizado:** autenticação stateless, ciclo de vida de tokens e gem `jwt`.

### Tarefa 6.3 — Implementar papéis e ownership

Criar roles `USER` e `ADMIN` e garantir ownership de clientes e contas.

**Aprendizado:** autorização baseada em papéis e controle de acesso a recursos próprios; policies com Pundit.

### Tarefa 6.4 — Proteger endpoints e sessões

Proteger endpoints por padrão e implementar logout e revogação de sessões, usando mecanismos de autenticação por requisição e `before_action`.

**Critério para avançar:** usuários não conseguem consultar ou movimentar contas de outros clientes sem autorização.

**Aprendizado:** autorização no fluxo web e comparação entre controles Rails e Spring Security.

## Etapa 7 — Testes automatizados

**Objetivo:** construir uma suíte capaz de detectar regressões. O diretório `spec/` e o RSpec já fazem parte da estrutura; recomenda-se começar os testes durante a Etapa 1.

### Tarefa 7.1 — Testar entidades

Implementar testes unitários de `Customer`, `Account` e `Transaction`.

**Aprendizado:** testes unitários, expectativas e isolamento de regras de domínio com RSpec.

### Tarefa 7.2 — Testar services financeiros

Testar serviços financeiros, incluindo cenários bem-sucedidos e falhas.

**Aprendizado:** teste de casos de uso e colaboração entre dependências.

### Tarefa 7.3 — Criar factories

Criar factories com FactoryBot.

**Aprendizado:** geração reutilizável de dados de teste.

### Tarefa 7.4 — Criar request specs

Implementar request specs para endpoints.

**Aprendizado:** teste de integração HTTP e validação de respostas da API.

### Tarefa 7.5 — Testar autenticação e autorização

Cobrir acessos permitidos e negados.

**Aprendizado:** verificação de controles de segurança em testes.

### Tarefa 7.6 — Testar idempotência

Verificar repetição de chaves, resultados duplicados e conflitos.

**Aprendizado:** testes de comportamento idempotente.

### Tarefa 7.7 — Testar rollback e concorrência

Validar reversão após falhas e integridade em operações simultâneas.

**Aprendizado:** testes de transações e cenários de concorrência.

### Tarefa 7.8 — Adicionar cobertura

Adicionar cobertura com SimpleCov.

**Critério para avançar:** fluxos financeiros e de segurança críticos têm testes automatizados de sucesso e falha.

**Aprendizado:** cobertura de código e identificação de áreas sem proteção contra regressões.

## Etapa 8 — Redis e rate limiting

**Objetivo:** introduzir cache e proteção contra requisições abusivas.

### Tarefa 8.1 — Integrar Redis

Configurar Redis como serviço compartilhado da aplicação.

**Aprendizado:** conexão com armazenamento em memória externo e configuração de serviços.

### Tarefa 8.2 — Implementar cache de clientes

Adicionar cache para consultas de clientes.

**Aprendizado:** Rails Cache, estratégias de leitura e TTL.

### Tarefa 8.3 — Criar invalidação de cache

Invalidar entradas quando os dados correspondentes forem alterados.

**Aprendizado:** consistência entre cache e fonte persistente e estratégias de invalidação.

### Tarefa 8.4 — Limitar tentativas de login

Implementar rate limiting para login.

**Aprendizado:** mitigação de tentativas abusivas de autenticação.

### Tarefa 8.5 — Limitar operações financeiras

Implementar rate limiting de transações.

**Aprendizado:** proteção de endpoints sensíveis e limites operacionais.

### Tarefa 8.6 — Definir escopos e respostas

Configurar limites por usuário e, quando necessário, por origem; retornar HTTP 429 ao exceder o limite.

**Aprendizado:** Rack middleware, identificação de origem e semântica HTTP de rate limiting.

### Tarefa 8.7 — Testar expiração e invalidação

Testar expiração do cache e invalidação dos dados.

**Critério para avançar:** rate limiting funciona em múltiplas instâncias quando utiliza armazenamento compartilhado.

**Aprendizado:** testes de TTL, cache distribuído e comportamento consistente entre instâncias.

## Etapa 9 — Jobs e processamento assíncrono

**Objetivo:** executar operações fora do ciclo HTTP e permitir recuperação de falhas.

### Tarefa 9.1 — Configurar Active Job persistente

Configurar Active Job com backend persistente.

**Aprendizado:** filas, adaptadores e persistência de trabalhos pendentes.

### Tarefa 9.2 — Criar jobs de notificação

Criar jobs para processar notificações.

**Aprendizado:** execução em segundo plano e desacoplamento de respostas HTTP.

### Tarefa 9.3 — Implementar retry

Definir políticas de retry para falhas.

**Aprendizado:** recuperação de erros transitórios e limites de retentativa.

### Tarefa 9.4 — Adicionar tabela outbox

Persistir eventos a publicar em uma tabela outbox.

**Aprendizado:** padrão outbox e coordenação entre transação de negócio e publicação de eventos.

### Tarefa 9.5 — Publicar eventos financeiros

Publicar eventos após confirmação das operações financeiras.

**Aprendizado:** eventos de domínio e momento correto de publicação.

### Tarefa 9.6 — Garantir idempotência dos consumidores

Impedir efeitos duplicados quando eventos forem reprocessados.

**Aprendizado:** processamento pelo menos uma vez e consumidores idempotentes.

### Tarefa 9.7 — Registrar falhas

Registrar falhas de processamento.

**Aprendizado:** rastreabilidade e diagnóstico de jobs assíncronos.

### Tarefa 9.8 — Testar recuperação

Testar recuperação do processamento após reinicialização.

**Critério para avançar:** falhas em notificações não comprometem transferências aprovadas.

**Aprendizado:** resiliência e recuperação de trabalhos persistidos.

## Etapa 10 — Infraestrutura e entrega profissional

**Objetivo:** preparar execução reproduzível, testes automatizados e avaliação técnica.

### Tarefa 10.1 — Criar Dockerfile

Criar uma imagem Docker para a aplicação.

**Aprendizado:** empacotamento e ambientes reproduzíveis.

### Tarefa 10.2 — Configurar Docker Compose

Orquestrar Rails, PostgreSQL e Redis com Docker Compose.

**Aprendizado:** serviços, redes e dependências locais da aplicação.

### Tarefa 10.3 — Configurar variáveis de ambiente

Externalizar configurações para variáveis de ambiente.

**Aprendizado:** configuração por ambiente e separação de segredos do código.

### Tarefa 10.4 — Adicionar health checks

Configurar verificações de saúde dos componentes.

**Aprendizado:** diagnóstico de disponibilidade e prontidão.

### Tarefa 10.5 — Implementar logs estruturados

Emitir logs estruturados para a aplicação.

**Aprendizado:** observabilidade e registros adequados para análise operacional.

### Tarefa 10.6 — Documentar a API com OpenAPI

Adicionar documentação OpenAPI dos endpoints.

**Aprendizado:** descrição formal de contratos e integração com consumidores.

### Tarefa 10.7 — Configurar GitHub Actions

Automatizar verificações e testes em CI.

**Aprendizado:** integração contínua e feedback automatizado.

### Tarefa 10.8 — Integrar RuboCop e Brakeman

Adicionar ferramentas de análise de estilo e segurança.

**Aprendizado:** qualidade estática de código e identificação de riscos de segurança.

### Tarefa 10.9 — Criar testes básicos de carga

Avaliar a aplicação com testes básicos de carga.

**Aprendizado:** comportamento sob carga e identificação de gargalos iniciais.

### Tarefa 10.10 — Atualizar documentação

Atualizar o README e a documentação arquitetural.

**Critério de conclusão:** aplicação inicia com Docker, executa migrations, disponibiliza endpoints documentados e passa pela pipeline de CI.

**Aprendizado:** consolidar documentação, arquitetura e processo de entrega.

## Progresso atual

O projeto está no início da **Etapa 1 — Domínio bancário**. As tarefas 1.1 (`Customer`) e 1.2 (`Account`) estão representadas no código atual; as próximas tarefas são transação, exceções de domínio e integração demonstrativa.

## Como executar

Com Ruby e Bundler instalados:

```sh
bundle install
ruby bin/rubybank
```

## Testes

```sh
bundle exec rspec
```

> Projeto educacional: não deve ser usado para movimentar dinheiro real.
