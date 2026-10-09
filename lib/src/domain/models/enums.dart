/// Tipos de conta suportados pelo aplicativo.
enum AccountType {
  bank,
  bookmaker,
}

/// Forma de contabilização do rendimento do CDB.
enum CdbAccountingType {
  gross,
  net,
}

/// Status possíveis de uma aposta.
enum BetStatus {
  open,
  won,
  lost,
  voided,
  cashedOut,
}

extension BetStatusX on BetStatus {
  bool get isSettled => this != BetStatus.open;

  /// Se a aposta conta para a taxa de acerto tradicional (ganha/perdida).
  bool get countsForHitRate => this == BetStatus.won || this == BetStatus.lost;
}

/// Tipos de movimentação financeira registradas no extrato (ledger).
enum LedgerEntryType {
  externalDeposit,
  externalWithdrawal,
  depositToBookmaker,
  withdrawalFromBookmaker,
  transferBetweenAccounts,
  adjustment,
  betPlaced,
  betSettledWin,
  betSettledLoss,
  betSettledVoid,
  betSettledCashout,
  cdbYield,
  fee,
  income,
  expense,
  yield,
  creditCardBillPayment,
}

extension LedgerEntryTypeX on LedgerEntryType {
  /// Entradas que representam resultado operacional de apostas (não contam
  /// como transferência/depósito/saque para fins de patrimônio externo).
  bool get isBetRelated =>
      this == LedgerEntryType.betPlaced ||
      this == LedgerEntryType.betSettledWin ||
      this == LedgerEntryType.betSettledLoss ||
      this == LedgerEntryType.betSettledVoid ||
      this == LedgerEntryType.betSettledCashout;
}

/// Tipos de movimentação visíveis ao usuário na tela de movimentações.
enum MovementType {
  externalDeposit,
  externalWithdrawal,
  depositToBookmaker,
  withdrawalFromBookmaker,
  transferBetweenAccounts,
  adjustment,
  income,
  expense,
  yield,
}

/// Tipos de movimentação oferecidos na tela de movimentações do módulo de
/// apostas (o módulo financeiro tem sua própria tela/lista de tipos).
const List<MovementType> kBettingMovementTypes = [
  MovementType.externalDeposit,
  MovementType.externalWithdrawal,
  MovementType.depositToBookmaker,
  MovementType.withdrawalFromBookmaker,
  MovementType.transferBetweenAccounts,
  MovementType.adjustment,
];

/// Tipos de movimentação oferecidos no extrato do módulo financeiro.
const List<MovementType> kFinancialMovementTypes = [
  MovementType.income,
  MovementType.expense,
  MovementType.transferBetweenAccounts,
  MovementType.adjustment,
  MovementType.yield,
];

// ---------------------------------------------------------------------
// Módulo de gestão financeira pessoal
// ---------------------------------------------------------------------

/// Subtipo de conta bancária (apenas contas do tipo [AccountType.bank]).
enum BankAccountKind {
  checking,
  savings,
  digital,
  cash,
  other,
}

extension BankAccountKindX on BankAccountKind {
  String get label {
    switch (this) {
      case BankAccountKind.checking:
        return 'Conta corrente';
      case BankAccountKind.savings:
        return 'Conta poupança';
      case BankAccountKind.digital:
        return 'Conta digital';
      case BankAccountKind.cash:
        return 'Dinheiro em espécie';
      case BankAccountKind.other:
        return 'Outros';
    }
  }
}

enum CategoryKind { expense, income }

enum CardTransactionType { purchase, refund, adjustment, interestCharge }

extension CardTransactionTypeX on CardTransactionType {
  String get label {
    switch (this) {
      case CardTransactionType.purchase:
        return 'Compra';
      case CardTransactionType.refund:
        return 'Estorno';
      case CardTransactionType.adjustment:
        return 'Ajuste';
      case CardTransactionType.interestCharge:
        return 'Encargo/Juros';
    }
  }

  /// Se o valor deve reduzir (true) ou aumentar (false) o total da fatura.
  bool get isCredit => this == CardTransactionType.refund;
}

/// Status de uma fatura de cartão — sempre calculado, nunca armazenado.
enum CreditCardBillStatus { open, closed, partiallyPaid, paid, overdue }

extension CreditCardBillStatusX on CreditCardBillStatus {
  String get label {
    switch (this) {
      case CreditCardBillStatus.open:
        return 'Aberta';
      case CreditCardBillStatus.closed:
        return 'Fechada';
      case CreditCardBillStatus.partiallyPaid:
        return 'Parcialmente paga';
      case CreditCardBillStatus.paid:
        return 'Paga';
      case CreditCardBillStatus.overdue:
        return 'Vencida';
    }
  }
}

enum RecurrenceFrequency { weekly, biweekly, monthly, yearly }

extension RecurrenceFrequencyX on RecurrenceFrequency {
  String get label {
    switch (this) {
      case RecurrenceFrequency.weekly:
        return 'Semanal';
      case RecurrenceFrequency.biweekly:
        return 'Quinzenal';
      case RecurrenceFrequency.monthly:
        return 'Mensal';
      case RecurrenceFrequency.yearly:
        return 'Anual';
    }
  }
}

/// Status de uma conta a pagar/receber — calculado a partir de
/// [cancelled], do valor já baixado e da data de vencimento, nunca
/// armazenado diretamente.
enum BillStatus { pending, paid, partiallyPaid, overdue, cancelled }

extension BillStatusX on BillStatus {
  String get label {
    switch (this) {
      case BillStatus.pending:
        return 'Pendente';
      case BillStatus.paid:
        return 'Paga';
      case BillStatus.partiallyPaid:
        return 'Parcialmente paga';
      case BillStatus.overdue:
        return 'Vencida';
      case BillStatus.cancelled:
        return 'Cancelada';
    }
  }
}

const List<String> kDefaultExpenseCategories = [
  'Alimentação',
  'Mercado',
  'Transporte',
  'Moradia',
  'Saúde',
  'Educação',
  'Lazer',
  'Assinaturas',
  'Compras',
  'Contas domésticas',
  'Impostos',
  'Outros',
];

const List<String> kDefaultIncomeCategories = [
  'Salário',
  'Freelance',
  'Reembolsos',
  'Rendimentos',
  'Outras receitas',
];

/// Esportes pré-cadastrados (o usuário também pode digitar outro).
const List<String> kDefaultSports = [
  'Futebol',
  'Basquete',
  'Tênis',
  'Vôlei',
  'E-sports',
  'MMA/UFC',
  'Futebol Americano',
  'Baseball',
  'Hóquei',
  'Outro',
];
