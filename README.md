# StakeFlow

Aplicativo Flutter para controle financeiro pessoal de apostas esportivas. Acompanha o dinheiro nas casas de apostas e na conta bancária, registra apostas e movimentações, calcula indicadores financeiros (ROI, taxa de acerto, lucro líquido) e acompanha o rendimento de CDB da conta bancária. Funciona 100% offline, com persistência local em SQLite.

## Stack

- Flutter / Dart
- [Drift](https://drift.simonbinder.eu/) (SQLite) para persistência
- [Riverpod](https://riverpod.dev/) para gerenciamento de estado
- [go_router](https://pub.dev/packages/go_router) para navegação
- [fl_chart](https://pub.dev/packages/fl_chart) para gráficos

## Arquitetura

O núcleo financeiro do app é um *ledger* único (`lib/src/data/database/tables/ledger_entries_table.dart`): toda operação que afeta saldo (aposta registrada/liquidada, depósito, saque, transferência, ajuste, rendimento de CDB) grava um lançamento com valor assinado. O saldo de uma conta é sempre `saldo inicial + soma dos lançamentos` — nunca um campo armazenado e editado diretamente. Isso garante que:

- apostas em aberto nunca contam como prejuízo realizado;
- toda transferência tem débito e crédito correspondentes;
- liquidar/editar uma aposta é idempotente (os lançamentos antigos são removidos antes de recriar os novos);
- edições retroativas recalculam automaticamente os gráficos e relatórios, pois eles são reconstruídos a partir do histórico completo, não de um saldo em cache.

A lógica de negócio fica em `lib/src/domain/services/` (`BetService`, `MovementService`, `CdbYieldService`, `AnalyticsService`). Os cálculos de relatórios/indicadores (`analytics_calculations.dart`) são funções puras, sem dependência do banco, para serem testáveis isoladamente.

## Rodando o projeto

```bash
flutter pub get
flutter run
```

Suporte inicial apenas para Android.
