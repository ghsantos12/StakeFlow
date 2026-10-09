import 'package:drift/drift.dart';
import 'credit_cards_table.dart';

/// Uma fatura de um cartão, para um mês de referência específico.
/// O valor total e o valor pago são sempre calculados a partir de
/// [CardInstallments] e [CreditCardBillPayments] (nunca armazenados aqui),
/// seguindo o mesmo princípio do ledger: a verdade vem do histórico de
/// lançamentos, não de um campo em cache.
@DataClassName('CreditCardBillRow')
class CreditCardBills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(CreditCards, #id)();

  IntColumn get referenceYear => integer()();
  IntColumn get referenceMonth => integer()();

  DateTimeColumn get closingDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {cardId, referenceYear, referenceMonth},
      ];
}
