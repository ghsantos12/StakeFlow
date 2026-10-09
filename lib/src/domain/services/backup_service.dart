import 'dart:convert';
import 'package:drift/drift.dart';
import '../../core/utils/money.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

/// Exportação/importação de dados.
///
/// Decisão de projeto: a importação de backup **substitui** integralmente
/// os dados locais (apaga e recarrega dentro de uma única transação),
/// preservando os IDs originais para manter a integridade referencial
/// entre apostas, movimentações e lançamentos do extrato. Essa é a forma
/// mais simples e robusta de garantir "nenhum registro duplicado" sem
/// precisar de um algoritmo de reconciliação/merge, que seria mais
/// complexo e propenso a inconsistências num app 100% offline.
class BackupService {
  BackupService(this._db);
  final AppDatabase _db;

  static const int backupFormatVersion = 1;

  Future<String> exportBackupJson() async {
    final accounts = await _db.accountsDao.getAll(includeArchived: true);
    final bets = await _db.betsDao.getAll();
    final movements = await _db.movementsDao.getAll();
    final cdbYields = await _db.cdbYieldsDao.getAll();
    final ledger = await _db.ledgerDao.getAllOrderedByDate();

    final map = {
      'formatVersion': backupFormatVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'accounts': accounts.map(_accountToJson).toList(),
      'bets': bets.map(_betToJson).toList(),
      'movements': movements.map(_movementToJson).toList(),
      'cdbYields': cdbYields.map(_cdbYieldToJson).toList(),
      'ledgerEntries': ledger.map(_ledgerToJson).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(map);
  }

  Future<void> importBackupJson(String jsonString) async {
    late Map<String, dynamic> map;
    try {
      map = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      throw ValidationException('Arquivo de backup inválido (JSON malformado).');
    }

    if (map['formatVersion'] != backupFormatVersion) {
      throw ValidationException('Versão de backup incompatível.');
    }

    final accountsJson = (map['accounts'] as List?) ?? [];
    final betsJson = (map['bets'] as List?) ?? [];
    final movementsJson = (map['movements'] as List?) ?? [];
    final cdbYieldsJson = (map['cdbYields'] as List?) ?? [];
    final ledgerJson = (map['ledgerEntries'] as List?) ?? [];

    try {
      await _db.transaction(() async {
        await _db.delete(_db.ledgerEntries).go();
        await _db.delete(_db.cdbYields).go();
        await _db.delete(_db.movements).go();
        await _db.delete(_db.bets).go();
        await _db.delete(_db.accounts).go();

        for (final raw in accountsJson) {
          await _db.into(_db.accounts).insert(_accountFromJson(raw as Map<String, dynamic>),
              mode: InsertMode.insertOrReplace);
        }
        for (final raw in betsJson) {
          await _db.into(_db.bets).insert(_betFromJson(raw as Map<String, dynamic>),
              mode: InsertMode.insertOrReplace);
        }
        for (final raw in movementsJson) {
          await _db.into(_db.movements).insert(_movementFromJson(raw as Map<String, dynamic>),
              mode: InsertMode.insertOrReplace);
        }
        for (final raw in cdbYieldsJson) {
          await _db.into(_db.cdbYields).insert(_cdbYieldFromJson(raw as Map<String, dynamic>),
              mode: InsertMode.insertOrReplace);
        }
        for (final raw in ledgerJson) {
          await _db.into(_db.ledgerEntries).insert(_ledgerFromJson(raw as Map<String, dynamic>),
              mode: InsertMode.insertOrReplace);
        }
      });
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ValidationException('Falha ao importar backup: $e');
    }
  }

  Future<String> exportBetsCsv() async {
    final bets = await _db.betsDao.getAll();
    final accounts = await _db.accountsDao.getAll(includeArchived: true);
    final namesById = {for (final a in accounts) a.id: a.name};

    final rows = <List<String>>[
      [
        'id',
        'casa_de_apostas',
        'data_aposta',
        'data_liquidacao',
        'esporte',
        'evento',
        'mercado',
        'selecao',
        'stake',
        'odd',
        'status',
        'cashout',
        'resultado',
        'observacoes',
      ],
      for (final b in bets)
        [
          b.id.toString(),
          namesById[b.accountId] ?? '',
          b.placedAt.toIso8601String(),
          b.settledAt?.toIso8601String() ?? '',
          b.sport,
          b.event,
          b.market,
          b.selection,
          (b.stakeCents / 100).toStringAsFixed(2),
          DecimalOdds.format(b.oddsScaled),
          b.status.name,
          b.cashoutCents != null ? (b.cashoutCents! / 100).toStringAsFixed(2) : '',
          b.resultCents != null ? (b.resultCents! / 100).toStringAsFixed(2) : '',
          b.notes ?? '',
        ],
    ];
    return _toCsv(rows);
  }

  Future<String> exportMovementsCsv() async {
    final movements = await _db.movementsDao.getAll();
    final accounts = await _db.accountsDao.getAll(includeArchived: true);
    final namesById = {for (final a in accounts) a.id: a.name};

    final rows = <List<String>>[
      [
        'id',
        'tipo',
        'conta_origem',
        'conta_destino',
        'valor',
        'taxa',
        'data',
        'descricao',
        'justificativa_ajuste',
      ],
      for (final m in movements)
        [
          m.id.toString(),
          m.type.name,
          m.sourceAccountId != null ? (namesById[m.sourceAccountId!] ?? '') : '',
          m.destinationAccountId != null ? (namesById[m.destinationAccountId!] ?? '') : '',
          (m.amountCents / 100).toStringAsFixed(2),
          (m.feeCents / 100).toStringAsFixed(2),
          m.occurredAt.toIso8601String(),
          m.description ?? '',
          m.adjustmentReason ?? '',
        ],
    ];
    return _toCsv(rows);
  }

  String _toCsv(List<List<String>> rows) {
    final buffer = StringBuffer();
    for (final row in rows) {
      buffer.writeln(row.map(_csvEscape).join(','));
    }
    return buffer.toString();
  }

  String _csvEscape(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  // ---- (de)serialização ----

  Map<String, dynamic> _accountToJson(AccountRow a) => {
        'id': a.id,
        'name': a.name,
        'type': a.type.name,
        'institution': a.institution,
        'initialBalanceCents': a.initialBalanceCents,
        'createdAt': a.createdAt.toIso8601String(),
        'isArchived': a.isArchived,
        'cdiPercent': a.cdiPercent,
        'cdbAccountingType': a.cdbAccountingType?.name,
        'cdbTrackingStartDate': a.cdbTrackingStartDate?.toIso8601String(),
        'cdbAccumulatedBeforeTrackingCents': a.cdbAccumulatedBeforeTrackingCents,
      };

  AccountsCompanion _accountFromJson(Map<String, dynamic> j) => AccountsCompanion.insert(
        id: Value(j['id'] as int),
        name: j['name'] as String,
        type: AccountType.values.byName(j['type'] as String),
        institution: Value(j['institution'] as String?),
        initialBalanceCents: Value(j['initialBalanceCents'] as int),
        createdAt: DateTime.parse(j['createdAt'] as String),
        isArchived: Value(j['isArchived'] as bool? ?? false),
        cdiPercent: Value((j['cdiPercent'] as num?)?.toDouble()),
        cdbAccountingType: Value(j['cdbAccountingType'] != null
            ? CdbAccountingType.values.byName(j['cdbAccountingType'] as String)
            : null),
        cdbTrackingStartDate: Value(j['cdbTrackingStartDate'] != null
            ? DateTime.parse(j['cdbTrackingStartDate'] as String)
            : null),
        cdbAccumulatedBeforeTrackingCents: Value(j['cdbAccumulatedBeforeTrackingCents'] as int? ?? 0),
      );

  Map<String, dynamic> _betToJson(BetRow b) => {
        'id': b.id,
        'accountId': b.accountId,
        'placedAt': b.placedAt.toIso8601String(),
        'settledAt': b.settledAt?.toIso8601String(),
        'sport': b.sport,
        'event': b.event,
        'market': b.market,
        'selection': b.selection,
        'stakeCents': b.stakeCents,
        'oddsScaled': b.oddsScaled,
        'status': b.status.name,
        'cashoutCents': b.cashoutCents,
        'resultCents': b.resultCents,
        'notes': b.notes,
        'createdAt': b.createdAt.toIso8601String(),
        'updatedAt': b.updatedAt.toIso8601String(),
      };

  BetsCompanion _betFromJson(Map<String, dynamic> j) => BetsCompanion.insert(
        id: Value(j['id'] as int),
        accountId: j['accountId'] as int,
        placedAt: DateTime.parse(j['placedAt'] as String),
        settledAt: Value(j['settledAt'] != null ? DateTime.parse(j['settledAt'] as String) : null),
        sport: j['sport'] as String,
        event: j['event'] as String,
        market: j['market'] as String,
        selection: j['selection'] as String,
        stakeCents: j['stakeCents'] as int,
        oddsScaled: j['oddsScaled'] as int,
        status: BetStatus.values.byName(j['status'] as String),
        cashoutCents: Value(j['cashoutCents'] as int?),
        resultCents: Value(j['resultCents'] as int?),
        notes: Value(j['notes'] as String?),
        createdAt: DateTime.parse(j['createdAt'] as String),
        updatedAt: DateTime.parse(j['updatedAt'] as String),
      );

  Map<String, dynamic> _movementToJson(MovementRow m) => {
        'id': m.id,
        'type': m.type.name,
        'sourceAccountId': m.sourceAccountId,
        'destinationAccountId': m.destinationAccountId,
        'amountCents': m.amountCents,
        'feeCents': m.feeCents,
        'occurredAt': m.occurredAt.toIso8601String(),
        'description': m.description,
        'adjustmentReason': m.adjustmentReason,
        'createdAt': m.createdAt.toIso8601String(),
        'updatedAt': m.updatedAt.toIso8601String(),
      };

  MovementsCompanion _movementFromJson(Map<String, dynamic> j) => MovementsCompanion.insert(
        id: Value(j['id'] as int),
        type: MovementType.values.byName(j['type'] as String),
        sourceAccountId: Value(j['sourceAccountId'] as int?),
        destinationAccountId: Value(j['destinationAccountId'] as int?),
        amountCents: j['amountCents'] as int,
        feeCents: Value(j['feeCents'] as int? ?? 0),
        occurredAt: DateTime.parse(j['occurredAt'] as String),
        description: Value(j['description'] as String?),
        adjustmentReason: Value(j['adjustmentReason'] as String?),
        createdAt: DateTime.parse(j['createdAt'] as String),
        updatedAt: DateTime.parse(j['updatedAt'] as String),
      );

  Map<String, dynamic> _cdbYieldToJson(CdbYieldRow y) => {
        'id': y.id,
        'accountId': y.accountId,
        'date': y.date.toIso8601String(),
        'amountCents': y.amountCents,
        'description': y.description,
        'createdAt': y.createdAt.toIso8601String(),
      };

  CdbYieldsCompanion _cdbYieldFromJson(Map<String, dynamic> j) => CdbYieldsCompanion.insert(
        id: Value(j['id'] as int),
        accountId: j['accountId'] as int,
        date: DateTime.parse(j['date'] as String),
        amountCents: j['amountCents'] as int,
        description: Value(j['description'] as String?),
        createdAt: DateTime.parse(j['createdAt'] as String),
      );

  Map<String, dynamic> _ledgerToJson(LedgerEntryRow l) => {
        'id': l.id,
        'accountId': l.accountId,
        'occurredAt': l.occurredAt.toIso8601String(),
        'type': l.type.name,
        'amountCents': l.amountCents,
        'betId': l.betId,
        'movementId': l.movementId,
        'cdbYieldId': l.cdbYieldId,
        'transferGroupId': l.transferGroupId,
        'description': l.description,
        'createdAt': l.createdAt.toIso8601String(),
      };

  LedgerEntriesCompanion _ledgerFromJson(Map<String, dynamic> j) => LedgerEntriesCompanion.insert(
        id: Value(j['id'] as int),
        accountId: j['accountId'] as int,
        occurredAt: DateTime.parse(j['occurredAt'] as String),
        type: LedgerEntryType.values.byName(j['type'] as String),
        amountCents: j['amountCents'] as int,
        betId: Value(j['betId'] as int?),
        movementId: Value(j['movementId'] as int?),
        cdbYieldId: Value(j['cdbYieldId'] as int?),
        transferGroupId: Value(j['transferGroupId'] as String?),
        description: Value(j['description'] as String?),
        createdAt: DateTime.parse(j['createdAt'] as String),
      );
}
