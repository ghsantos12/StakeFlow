/// Lançada quando uma movimentação excederia o saldo disponível de uma
/// conta e o bloqueio por saldo insuficiente está ativo (padrão do app).
class InsufficientBalanceException implements Exception {
  InsufficientBalanceException(this.accountName, this.availableCents, this.requiredCents);

  final String accountName;
  final int availableCents;
  final int requiredCents;

  @override
  String toString() =>
      'Saldo insuficiente em "$accountName": disponível ${availableCents / 100}, necessário ${requiredCents / 100}';
}

class ValidationException implements Exception {
  ValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}
