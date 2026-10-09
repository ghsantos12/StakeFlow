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
}

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
