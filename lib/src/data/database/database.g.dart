// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountType>($AccountsTable.$convertertype);
  static const VerificationMeta _institutionMeta = const VerificationMeta(
    'institution',
  );
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
    'institution',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialBalanceCentsMeta =
      const VerificationMeta('initialBalanceCents');
  @override
  late final GeneratedColumn<int> initialBalanceCents = GeneratedColumn<int>(
    'initial_balance_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cdiPercentMeta = const VerificationMeta(
    'cdiPercent',
  );
  @override
  late final GeneratedColumn<double> cdiPercent = GeneratedColumn<double>(
    'cdi_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CdbAccountingType?, String>
  cdbAccountingType =
      GeneratedColumn<String>(
        'cdb_accounting_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<CdbAccountingType?>(
        $AccountsTable.$convertercdbAccountingTypen,
      );
  static const VerificationMeta _cdbTrackingStartDateMeta =
      const VerificationMeta('cdbTrackingStartDate');
  @override
  late final GeneratedColumn<DateTime> cdbTrackingStartDate =
      GeneratedColumn<DateTime>(
        'cdb_tracking_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cdbAccumulatedBeforeTrackingCentsMeta =
      const VerificationMeta('cdbAccumulatedBeforeTrackingCents');
  @override
  late final GeneratedColumn<int> cdbAccumulatedBeforeTrackingCents =
      GeneratedColumn<int>(
        'cdb_accumulated_before_tracking_cents',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  @override
  late final GeneratedColumnWithTypeConverter<BankAccountKind?, String>
  bankAccountKind = GeneratedColumn<String>(
    'bank_account_kind',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<BankAccountKind?>($AccountsTable.$converterbankAccountKindn);
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    institution,
    initialBalanceCents,
    createdAt,
    isArchived,
    cdiPercent,
    cdbAccountingType,
    cdbTrackingStartDate,
    cdbAccumulatedBeforeTrackingCents,
    bankAccountKind,
    colorValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('institution')) {
      context.handle(
        _institutionMeta,
        institution.isAcceptableOrUnknown(
          data['institution']!,
          _institutionMeta,
        ),
      );
    }
    if (data.containsKey('initial_balance_cents')) {
      context.handle(
        _initialBalanceCentsMeta,
        initialBalanceCents.isAcceptableOrUnknown(
          data['initial_balance_cents']!,
          _initialBalanceCentsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('cdi_percent')) {
      context.handle(
        _cdiPercentMeta,
        cdiPercent.isAcceptableOrUnknown(data['cdi_percent']!, _cdiPercentMeta),
      );
    }
    if (data.containsKey('cdb_tracking_start_date')) {
      context.handle(
        _cdbTrackingStartDateMeta,
        cdbTrackingStartDate.isAcceptableOrUnknown(
          data['cdb_tracking_start_date']!,
          _cdbTrackingStartDateMeta,
        ),
      );
    }
    if (data.containsKey('cdb_accumulated_before_tracking_cents')) {
      context.handle(
        _cdbAccumulatedBeforeTrackingCentsMeta,
        cdbAccumulatedBeforeTrackingCents.isAcceptableOrUnknown(
          data['cdb_accumulated_before_tracking_cents']!,
          _cdbAccumulatedBeforeTrackingCentsMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $AccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      institution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}institution'],
      ),
      initialBalanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_balance_cents'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      cdiPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cdi_percent'],
      ),
      cdbAccountingType: $AccountsTable.$convertercdbAccountingTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cdb_accounting_type'],
        ),
      ),
      cdbTrackingStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cdb_tracking_start_date'],
      ),
      cdbAccumulatedBeforeTrackingCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cdb_accumulated_before_tracking_cents'],
      )!,
      bankAccountKind: $AccountsTable.$converterbankAccountKindn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}bank_account_kind'],
        ),
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountType, String, String> $convertertype =
      const EnumNameConverter<AccountType>(AccountType.values);
  static JsonTypeConverter2<CdbAccountingType, String, String>
  $convertercdbAccountingType = const EnumNameConverter<CdbAccountingType>(
    CdbAccountingType.values,
  );
  static JsonTypeConverter2<CdbAccountingType?, String?, String?>
  $convertercdbAccountingTypen = JsonTypeConverter2.asNullable(
    $convertercdbAccountingType,
  );
  static JsonTypeConverter2<BankAccountKind, String, String>
  $converterbankAccountKind = const EnumNameConverter<BankAccountKind>(
    BankAccountKind.values,
  );
  static JsonTypeConverter2<BankAccountKind?, String?, String?>
  $converterbankAccountKindn = JsonTypeConverter2.asNullable(
    $converterbankAccountKind,
  );
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final int id;
  final String name;
  final AccountType type;
  final String? institution;
  final int initialBalanceCents;
  final DateTime createdAt;
  final bool isArchived;
  final double? cdiPercent;
  final CdbAccountingType? cdbAccountingType;
  final DateTime? cdbTrackingStartDate;
  final int cdbAccumulatedBeforeTrackingCents;

  /// Subtipo de conta bancária (corrente, poupança, dinheiro em espécie...)
  /// usado pelo módulo de gestão financeira pessoal. Nulo para contas
  /// criadas antes da existência desse módulo ou para casas de apostas.
  final BankAccountKind? bankAccountKind;

  /// Cor de identificação visual da conta (módulo financeiro).
  final int? colorValue;
  const AccountRow({
    required this.id,
    required this.name,
    required this.type,
    this.institution,
    required this.initialBalanceCents,
    required this.createdAt,
    required this.isArchived,
    this.cdiPercent,
    this.cdbAccountingType,
    this.cdbTrackingStartDate,
    required this.cdbAccumulatedBeforeTrackingCents,
    this.bankAccountKind,
    this.colorValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>($AccountsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || institution != null) {
      map['institution'] = Variable<String>(institution);
    }
    map['initial_balance_cents'] = Variable<int>(initialBalanceCents);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_archived'] = Variable<bool>(isArchived);
    if (!nullToAbsent || cdiPercent != null) {
      map['cdi_percent'] = Variable<double>(cdiPercent);
    }
    if (!nullToAbsent || cdbAccountingType != null) {
      map['cdb_accounting_type'] = Variable<String>(
        $AccountsTable.$convertercdbAccountingTypen.toSql(cdbAccountingType),
      );
    }
    if (!nullToAbsent || cdbTrackingStartDate != null) {
      map['cdb_tracking_start_date'] = Variable<DateTime>(cdbTrackingStartDate);
    }
    map['cdb_accumulated_before_tracking_cents'] = Variable<int>(
      cdbAccumulatedBeforeTrackingCents,
    );
    if (!nullToAbsent || bankAccountKind != null) {
      map['bank_account_kind'] = Variable<String>(
        $AccountsTable.$converterbankAccountKindn.toSql(bankAccountKind),
      );
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      institution: institution == null && nullToAbsent
          ? const Value.absent()
          : Value(institution),
      initialBalanceCents: Value(initialBalanceCents),
      createdAt: Value(createdAt),
      isArchived: Value(isArchived),
      cdiPercent: cdiPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(cdiPercent),
      cdbAccountingType: cdbAccountingType == null && nullToAbsent
          ? const Value.absent()
          : Value(cdbAccountingType),
      cdbTrackingStartDate: cdbTrackingStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(cdbTrackingStartDate),
      cdbAccumulatedBeforeTrackingCents: Value(
        cdbAccumulatedBeforeTrackingCents,
      ),
      bankAccountKind: bankAccountKind == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountKind),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: $AccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      institution: serializer.fromJson<String?>(json['institution']),
      initialBalanceCents: serializer.fromJson<int>(
        json['initialBalanceCents'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      cdiPercent: serializer.fromJson<double?>(json['cdiPercent']),
      cdbAccountingType: $AccountsTable.$convertercdbAccountingTypen.fromJson(
        serializer.fromJson<String?>(json['cdbAccountingType']),
      ),
      cdbTrackingStartDate: serializer.fromJson<DateTime?>(
        json['cdbTrackingStartDate'],
      ),
      cdbAccumulatedBeforeTrackingCents: serializer.fromJson<int>(
        json['cdbAccumulatedBeforeTrackingCents'],
      ),
      bankAccountKind: $AccountsTable.$converterbankAccountKindn.fromJson(
        serializer.fromJson<String?>(json['bankAccountKind']),
      ),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $AccountsTable.$convertertype.toJson(type),
      ),
      'institution': serializer.toJson<String?>(institution),
      'initialBalanceCents': serializer.toJson<int>(initialBalanceCents),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isArchived': serializer.toJson<bool>(isArchived),
      'cdiPercent': serializer.toJson<double?>(cdiPercent),
      'cdbAccountingType': serializer.toJson<String?>(
        $AccountsTable.$convertercdbAccountingTypen.toJson(cdbAccountingType),
      ),
      'cdbTrackingStartDate': serializer.toJson<DateTime?>(
        cdbTrackingStartDate,
      ),
      'cdbAccumulatedBeforeTrackingCents': serializer.toJson<int>(
        cdbAccumulatedBeforeTrackingCents,
      ),
      'bankAccountKind': serializer.toJson<String?>(
        $AccountsTable.$converterbankAccountKindn.toJson(bankAccountKind),
      ),
      'colorValue': serializer.toJson<int?>(colorValue),
    };
  }

  AccountRow copyWith({
    int? id,
    String? name,
    AccountType? type,
    Value<String?> institution = const Value.absent(),
    int? initialBalanceCents,
    DateTime? createdAt,
    bool? isArchived,
    Value<double?> cdiPercent = const Value.absent(),
    Value<CdbAccountingType?> cdbAccountingType = const Value.absent(),
    Value<DateTime?> cdbTrackingStartDate = const Value.absent(),
    int? cdbAccumulatedBeforeTrackingCents,
    Value<BankAccountKind?> bankAccountKind = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
  }) => AccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    institution: institution.present ? institution.value : this.institution,
    initialBalanceCents: initialBalanceCents ?? this.initialBalanceCents,
    createdAt: createdAt ?? this.createdAt,
    isArchived: isArchived ?? this.isArchived,
    cdiPercent: cdiPercent.present ? cdiPercent.value : this.cdiPercent,
    cdbAccountingType: cdbAccountingType.present
        ? cdbAccountingType.value
        : this.cdbAccountingType,
    cdbTrackingStartDate: cdbTrackingStartDate.present
        ? cdbTrackingStartDate.value
        : this.cdbTrackingStartDate,
    cdbAccumulatedBeforeTrackingCents:
        cdbAccumulatedBeforeTrackingCents ??
        this.cdbAccumulatedBeforeTrackingCents,
    bankAccountKind: bankAccountKind.present
        ? bankAccountKind.value
        : this.bankAccountKind,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      institution: data.institution.present
          ? data.institution.value
          : this.institution,
      initialBalanceCents: data.initialBalanceCents.present
          ? data.initialBalanceCents.value
          : this.initialBalanceCents,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      cdiPercent: data.cdiPercent.present
          ? data.cdiPercent.value
          : this.cdiPercent,
      cdbAccountingType: data.cdbAccountingType.present
          ? data.cdbAccountingType.value
          : this.cdbAccountingType,
      cdbTrackingStartDate: data.cdbTrackingStartDate.present
          ? data.cdbTrackingStartDate.value
          : this.cdbTrackingStartDate,
      cdbAccumulatedBeforeTrackingCents:
          data.cdbAccumulatedBeforeTrackingCents.present
          ? data.cdbAccumulatedBeforeTrackingCents.value
          : this.cdbAccumulatedBeforeTrackingCents,
      bankAccountKind: data.bankAccountKind.present
          ? data.bankAccountKind.value
          : this.bankAccountKind,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('institution: $institution, ')
          ..write('initialBalanceCents: $initialBalanceCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('cdiPercent: $cdiPercent, ')
          ..write('cdbAccountingType: $cdbAccountingType, ')
          ..write('cdbTrackingStartDate: $cdbTrackingStartDate, ')
          ..write(
            'cdbAccumulatedBeforeTrackingCents: $cdbAccumulatedBeforeTrackingCents, ',
          )
          ..write('bankAccountKind: $bankAccountKind, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    institution,
    initialBalanceCents,
    createdAt,
    isArchived,
    cdiPercent,
    cdbAccountingType,
    cdbTrackingStartDate,
    cdbAccumulatedBeforeTrackingCents,
    bankAccountKind,
    colorValue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.institution == this.institution &&
          other.initialBalanceCents == this.initialBalanceCents &&
          other.createdAt == this.createdAt &&
          other.isArchived == this.isArchived &&
          other.cdiPercent == this.cdiPercent &&
          other.cdbAccountingType == this.cdbAccountingType &&
          other.cdbTrackingStartDate == this.cdbTrackingStartDate &&
          other.cdbAccumulatedBeforeTrackingCents ==
              this.cdbAccumulatedBeforeTrackingCents &&
          other.bankAccountKind == this.bankAccountKind &&
          other.colorValue == this.colorValue);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<AccountType> type;
  final Value<String?> institution;
  final Value<int> initialBalanceCents;
  final Value<DateTime> createdAt;
  final Value<bool> isArchived;
  final Value<double?> cdiPercent;
  final Value<CdbAccountingType?> cdbAccountingType;
  final Value<DateTime?> cdbTrackingStartDate;
  final Value<int> cdbAccumulatedBeforeTrackingCents;
  final Value<BankAccountKind?> bankAccountKind;
  final Value<int?> colorValue;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.institution = const Value.absent(),
    this.initialBalanceCents = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.cdiPercent = const Value.absent(),
    this.cdbAccountingType = const Value.absent(),
    this.cdbTrackingStartDate = const Value.absent(),
    this.cdbAccumulatedBeforeTrackingCents = const Value.absent(),
    this.bankAccountKind = const Value.absent(),
    this.colorValue = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required AccountType type,
    this.institution = const Value.absent(),
    this.initialBalanceCents = const Value.absent(),
    required DateTime createdAt,
    this.isArchived = const Value.absent(),
    this.cdiPercent = const Value.absent(),
    this.cdbAccountingType = const Value.absent(),
    this.cdbTrackingStartDate = const Value.absent(),
    this.cdbAccumulatedBeforeTrackingCents = const Value.absent(),
    this.bankAccountKind = const Value.absent(),
    this.colorValue = const Value.absent(),
  }) : name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<AccountRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? institution,
    Expression<int>? initialBalanceCents,
    Expression<DateTime>? createdAt,
    Expression<bool>? isArchived,
    Expression<double>? cdiPercent,
    Expression<String>? cdbAccountingType,
    Expression<DateTime>? cdbTrackingStartDate,
    Expression<int>? cdbAccumulatedBeforeTrackingCents,
    Expression<String>? bankAccountKind,
    Expression<int>? colorValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (institution != null) 'institution': institution,
      if (initialBalanceCents != null)
        'initial_balance_cents': initialBalanceCents,
      if (createdAt != null) 'created_at': createdAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (cdiPercent != null) 'cdi_percent': cdiPercent,
      if (cdbAccountingType != null) 'cdb_accounting_type': cdbAccountingType,
      if (cdbTrackingStartDate != null)
        'cdb_tracking_start_date': cdbTrackingStartDate,
      if (cdbAccumulatedBeforeTrackingCents != null)
        'cdb_accumulated_before_tracking_cents':
            cdbAccumulatedBeforeTrackingCents,
      if (bankAccountKind != null) 'bank_account_kind': bankAccountKind,
      if (colorValue != null) 'color_value': colorValue,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<AccountType>? type,
    Value<String?>? institution,
    Value<int>? initialBalanceCents,
    Value<DateTime>? createdAt,
    Value<bool>? isArchived,
    Value<double?>? cdiPercent,
    Value<CdbAccountingType?>? cdbAccountingType,
    Value<DateTime?>? cdbTrackingStartDate,
    Value<int>? cdbAccumulatedBeforeTrackingCents,
    Value<BankAccountKind?>? bankAccountKind,
    Value<int?>? colorValue,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      institution: institution ?? this.institution,
      initialBalanceCents: initialBalanceCents ?? this.initialBalanceCents,
      createdAt: createdAt ?? this.createdAt,
      isArchived: isArchived ?? this.isArchived,
      cdiPercent: cdiPercent ?? this.cdiPercent,
      cdbAccountingType: cdbAccountingType ?? this.cdbAccountingType,
      cdbTrackingStartDate: cdbTrackingStartDate ?? this.cdbTrackingStartDate,
      cdbAccumulatedBeforeTrackingCents:
          cdbAccumulatedBeforeTrackingCents ??
          this.cdbAccumulatedBeforeTrackingCents,
      bankAccountKind: bankAccountKind ?? this.bankAccountKind,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $AccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (initialBalanceCents.present) {
      map['initial_balance_cents'] = Variable<int>(initialBalanceCents.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (cdiPercent.present) {
      map['cdi_percent'] = Variable<double>(cdiPercent.value);
    }
    if (cdbAccountingType.present) {
      map['cdb_accounting_type'] = Variable<String>(
        $AccountsTable.$convertercdbAccountingTypen.toSql(
          cdbAccountingType.value,
        ),
      );
    }
    if (cdbTrackingStartDate.present) {
      map['cdb_tracking_start_date'] = Variable<DateTime>(
        cdbTrackingStartDate.value,
      );
    }
    if (cdbAccumulatedBeforeTrackingCents.present) {
      map['cdb_accumulated_before_tracking_cents'] = Variable<int>(
        cdbAccumulatedBeforeTrackingCents.value,
      );
    }
    if (bankAccountKind.present) {
      map['bank_account_kind'] = Variable<String>(
        $AccountsTable.$converterbankAccountKindn.toSql(bankAccountKind.value),
      );
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('institution: $institution, ')
          ..write('initialBalanceCents: $initialBalanceCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('cdiPercent: $cdiPercent, ')
          ..write('cdbAccountingType: $cdbAccountingType, ')
          ..write('cdbTrackingStartDate: $cdbTrackingStartDate, ')
          ..write(
            'cdbAccumulatedBeforeTrackingCents: $cdbAccumulatedBeforeTrackingCents, ',
          )
          ..write('bankAccountKind: $bankAccountKind, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }
}

class $BetsTable extends Bets with TableInfo<$BetsTable, BetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _placedAtMeta = const VerificationMeta(
    'placedAt',
  );
  @override
  late final GeneratedColumn<DateTime> placedAt = GeneratedColumn<DateTime>(
    'placed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settledAtMeta = const VerificationMeta(
    'settledAt',
  );
  @override
  late final GeneratedColumn<DateTime> settledAt = GeneratedColumn<DateTime>(
    'settled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sportMeta = const VerificationMeta('sport');
  @override
  late final GeneratedColumn<String> sport = GeneratedColumn<String>(
    'sport',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectionMeta = const VerificationMeta(
    'selection',
  );
  @override
  late final GeneratedColumn<String> selection = GeneratedColumn<String>(
    'selection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stakeCentsMeta = const VerificationMeta(
    'stakeCents',
  );
  @override
  late final GeneratedColumn<int> stakeCents = GeneratedColumn<int>(
    'stake_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oddsScaledMeta = const VerificationMeta(
    'oddsScaled',
  );
  @override
  late final GeneratedColumn<int> oddsScaled = GeneratedColumn<int>(
    'odds_scaled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BetStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BetStatus>($BetsTable.$converterstatus);
  static const VerificationMeta _cashoutCentsMeta = const VerificationMeta(
    'cashoutCents',
  );
  @override
  late final GeneratedColumn<int> cashoutCents = GeneratedColumn<int>(
    'cashout_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualReturnCentsMeta = const VerificationMeta(
    'actualReturnCents',
  );
  @override
  late final GeneratedColumn<int> actualReturnCents = GeneratedColumn<int>(
    'actual_return_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultCentsMeta = const VerificationMeta(
    'resultCents',
  );
  @override
  late final GeneratedColumn<int> resultCents = GeneratedColumn<int>(
    'result_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BetType?, String> betType =
      GeneratedColumn<String>(
        'bet_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<BetType?>($BetsTable.$converterbetTypen);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    placedAt,
    settledAt,
    sport,
    event,
    market,
    selection,
    stakeCents,
    oddsScaled,
    status,
    cashoutCents,
    actualReturnCents,
    resultCents,
    notes,
    betType,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('placed_at')) {
      context.handle(
        _placedAtMeta,
        placedAt.isAcceptableOrUnknown(data['placed_at']!, _placedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_placedAtMeta);
    }
    if (data.containsKey('settled_at')) {
      context.handle(
        _settledAtMeta,
        settledAt.isAcceptableOrUnknown(data['settled_at']!, _settledAtMeta),
      );
    }
    if (data.containsKey('sport')) {
      context.handle(
        _sportMeta,
        sport.isAcceptableOrUnknown(data['sport']!, _sportMeta),
      );
    } else if (isInserting) {
      context.missing(_sportMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('selection')) {
      context.handle(
        _selectionMeta,
        selection.isAcceptableOrUnknown(data['selection']!, _selectionMeta),
      );
    } else if (isInserting) {
      context.missing(_selectionMeta);
    }
    if (data.containsKey('stake_cents')) {
      context.handle(
        _stakeCentsMeta,
        stakeCents.isAcceptableOrUnknown(data['stake_cents']!, _stakeCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_stakeCentsMeta);
    }
    if (data.containsKey('odds_scaled')) {
      context.handle(
        _oddsScaledMeta,
        oddsScaled.isAcceptableOrUnknown(data['odds_scaled']!, _oddsScaledMeta),
      );
    } else if (isInserting) {
      context.missing(_oddsScaledMeta);
    }
    if (data.containsKey('cashout_cents')) {
      context.handle(
        _cashoutCentsMeta,
        cashoutCents.isAcceptableOrUnknown(
          data['cashout_cents']!,
          _cashoutCentsMeta,
        ),
      );
    }
    if (data.containsKey('actual_return_cents')) {
      context.handle(
        _actualReturnCentsMeta,
        actualReturnCents.isAcceptableOrUnknown(
          data['actual_return_cents']!,
          _actualReturnCentsMeta,
        ),
      );
    }
    if (data.containsKey('result_cents')) {
      context.handle(
        _resultCentsMeta,
        resultCents.isAcceptableOrUnknown(
          data['result_cents']!,
          _resultCentsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      placedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}placed_at'],
      )!,
      settledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}settled_at'],
      ),
      sport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sport'],
      )!,
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      selection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selection'],
      )!,
      stakeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stake_cents'],
      )!,
      oddsScaled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odds_scaled'],
      )!,
      status: $BetsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      cashoutCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cashout_cents'],
      ),
      actualReturnCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_return_cents'],
      ),
      resultCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}result_cents'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      betType: $BetsTable.$converterbetTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}bet_type'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BetsTable createAlias(String alias) {
    return $BetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BetStatus, String, String> $converterstatus =
      const EnumNameConverter<BetStatus>(BetStatus.values);
  static JsonTypeConverter2<BetType, String, String> $converterbetType =
      const EnumNameConverter<BetType>(BetType.values);
  static JsonTypeConverter2<BetType?, String?, String?> $converterbetTypen =
      JsonTypeConverter2.asNullable($converterbetType);
}

class BetRow extends DataClass implements Insertable<BetRow> {
  final int id;
  final int accountId;
  final DateTime placedAt;
  final DateTime? settledAt;
  final String sport;
  final String event;
  final String market;
  final String selection;
  final int stakeCents;
  final int oddsScaled;
  final BetStatus status;

  /// Valor efetivamente recebido em caso de cashout (em centavos).
  final int? cashoutCents;

  /// Ajuste manual do valor total recebido numa aposta ganha, para quando
  /// o arredondamento da odd divulgada pela casa de apostas gera um valor
  /// de centavos diferente do calculado (stake × odd). Nulo = usa o valor
  /// calculado normalmente; só é lido quando o status é [BetStatus.won].
  final int? actualReturnCents;

  /// Resultado financeiro realizado (lucro/prejuízo) em centavos.
  /// Nulo enquanto a aposta estiver em aberto.
  final int? resultCents;
  final String? notes;

  /// Nulo para apostas gravadas antes do suporte a múltiplas — tratar como
  /// [BetType.single]. Para [BetType.multiple], os campos [sport]/[event]/
  /// [market]/[selection]/[oddsScaled] acima guardam um resumo combinado
  /// (odd = produto das odds de cada seleção em [BetLegs]); o detalhe de
  /// cada jogo fica nas linhas de [BetLegs] vinculadas a esta aposta.
  final BetType? betType;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BetRow({
    required this.id,
    required this.accountId,
    required this.placedAt,
    this.settledAt,
    required this.sport,
    required this.event,
    required this.market,
    required this.selection,
    required this.stakeCents,
    required this.oddsScaled,
    required this.status,
    this.cashoutCents,
    this.actualReturnCents,
    this.resultCents,
    this.notes,
    this.betType,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['placed_at'] = Variable<DateTime>(placedAt);
    if (!nullToAbsent || settledAt != null) {
      map['settled_at'] = Variable<DateTime>(settledAt);
    }
    map['sport'] = Variable<String>(sport);
    map['event'] = Variable<String>(event);
    map['market'] = Variable<String>(market);
    map['selection'] = Variable<String>(selection);
    map['stake_cents'] = Variable<int>(stakeCents);
    map['odds_scaled'] = Variable<int>(oddsScaled);
    {
      map['status'] = Variable<String>(
        $BetsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || cashoutCents != null) {
      map['cashout_cents'] = Variable<int>(cashoutCents);
    }
    if (!nullToAbsent || actualReturnCents != null) {
      map['actual_return_cents'] = Variable<int>(actualReturnCents);
    }
    if (!nullToAbsent || resultCents != null) {
      map['result_cents'] = Variable<int>(resultCents);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || betType != null) {
      map['bet_type'] = Variable<String>(
        $BetsTable.$converterbetTypen.toSql(betType),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BetsCompanion toCompanion(bool nullToAbsent) {
    return BetsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      placedAt: Value(placedAt),
      settledAt: settledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(settledAt),
      sport: Value(sport),
      event: Value(event),
      market: Value(market),
      selection: Value(selection),
      stakeCents: Value(stakeCents),
      oddsScaled: Value(oddsScaled),
      status: Value(status),
      cashoutCents: cashoutCents == null && nullToAbsent
          ? const Value.absent()
          : Value(cashoutCents),
      actualReturnCents: actualReturnCents == null && nullToAbsent
          ? const Value.absent()
          : Value(actualReturnCents),
      resultCents: resultCents == null && nullToAbsent
          ? const Value.absent()
          : Value(resultCents),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      betType: betType == null && nullToAbsent
          ? const Value.absent()
          : Value(betType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BetRow(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      placedAt: serializer.fromJson<DateTime>(json['placedAt']),
      settledAt: serializer.fromJson<DateTime?>(json['settledAt']),
      sport: serializer.fromJson<String>(json['sport']),
      event: serializer.fromJson<String>(json['event']),
      market: serializer.fromJson<String>(json['market']),
      selection: serializer.fromJson<String>(json['selection']),
      stakeCents: serializer.fromJson<int>(json['stakeCents']),
      oddsScaled: serializer.fromJson<int>(json['oddsScaled']),
      status: $BetsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      cashoutCents: serializer.fromJson<int?>(json['cashoutCents']),
      actualReturnCents: serializer.fromJson<int?>(json['actualReturnCents']),
      resultCents: serializer.fromJson<int?>(json['resultCents']),
      notes: serializer.fromJson<String?>(json['notes']),
      betType: $BetsTable.$converterbetTypen.fromJson(
        serializer.fromJson<String?>(json['betType']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'placedAt': serializer.toJson<DateTime>(placedAt),
      'settledAt': serializer.toJson<DateTime?>(settledAt),
      'sport': serializer.toJson<String>(sport),
      'event': serializer.toJson<String>(event),
      'market': serializer.toJson<String>(market),
      'selection': serializer.toJson<String>(selection),
      'stakeCents': serializer.toJson<int>(stakeCents),
      'oddsScaled': serializer.toJson<int>(oddsScaled),
      'status': serializer.toJson<String>(
        $BetsTable.$converterstatus.toJson(status),
      ),
      'cashoutCents': serializer.toJson<int?>(cashoutCents),
      'actualReturnCents': serializer.toJson<int?>(actualReturnCents),
      'resultCents': serializer.toJson<int?>(resultCents),
      'notes': serializer.toJson<String?>(notes),
      'betType': serializer.toJson<String?>(
        $BetsTable.$converterbetTypen.toJson(betType),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BetRow copyWith({
    int? id,
    int? accountId,
    DateTime? placedAt,
    Value<DateTime?> settledAt = const Value.absent(),
    String? sport,
    String? event,
    String? market,
    String? selection,
    int? stakeCents,
    int? oddsScaled,
    BetStatus? status,
    Value<int?> cashoutCents = const Value.absent(),
    Value<int?> actualReturnCents = const Value.absent(),
    Value<int?> resultCents = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<BetType?> betType = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BetRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    placedAt: placedAt ?? this.placedAt,
    settledAt: settledAt.present ? settledAt.value : this.settledAt,
    sport: sport ?? this.sport,
    event: event ?? this.event,
    market: market ?? this.market,
    selection: selection ?? this.selection,
    stakeCents: stakeCents ?? this.stakeCents,
    oddsScaled: oddsScaled ?? this.oddsScaled,
    status: status ?? this.status,
    cashoutCents: cashoutCents.present ? cashoutCents.value : this.cashoutCents,
    actualReturnCents: actualReturnCents.present
        ? actualReturnCents.value
        : this.actualReturnCents,
    resultCents: resultCents.present ? resultCents.value : this.resultCents,
    notes: notes.present ? notes.value : this.notes,
    betType: betType.present ? betType.value : this.betType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BetRow copyWithCompanion(BetsCompanion data) {
    return BetRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      placedAt: data.placedAt.present ? data.placedAt.value : this.placedAt,
      settledAt: data.settledAt.present ? data.settledAt.value : this.settledAt,
      sport: data.sport.present ? data.sport.value : this.sport,
      event: data.event.present ? data.event.value : this.event,
      market: data.market.present ? data.market.value : this.market,
      selection: data.selection.present ? data.selection.value : this.selection,
      stakeCents: data.stakeCents.present
          ? data.stakeCents.value
          : this.stakeCents,
      oddsScaled: data.oddsScaled.present
          ? data.oddsScaled.value
          : this.oddsScaled,
      status: data.status.present ? data.status.value : this.status,
      cashoutCents: data.cashoutCents.present
          ? data.cashoutCents.value
          : this.cashoutCents,
      actualReturnCents: data.actualReturnCents.present
          ? data.actualReturnCents.value
          : this.actualReturnCents,
      resultCents: data.resultCents.present
          ? data.resultCents.value
          : this.resultCents,
      notes: data.notes.present ? data.notes.value : this.notes,
      betType: data.betType.present ? data.betType.value : this.betType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BetRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('placedAt: $placedAt, ')
          ..write('settledAt: $settledAt, ')
          ..write('sport: $sport, ')
          ..write('event: $event, ')
          ..write('market: $market, ')
          ..write('selection: $selection, ')
          ..write('stakeCents: $stakeCents, ')
          ..write('oddsScaled: $oddsScaled, ')
          ..write('status: $status, ')
          ..write('cashoutCents: $cashoutCents, ')
          ..write('actualReturnCents: $actualReturnCents, ')
          ..write('resultCents: $resultCents, ')
          ..write('notes: $notes, ')
          ..write('betType: $betType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    placedAt,
    settledAt,
    sport,
    event,
    market,
    selection,
    stakeCents,
    oddsScaled,
    status,
    cashoutCents,
    actualReturnCents,
    resultCents,
    notes,
    betType,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BetRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.placedAt == this.placedAt &&
          other.settledAt == this.settledAt &&
          other.sport == this.sport &&
          other.event == this.event &&
          other.market == this.market &&
          other.selection == this.selection &&
          other.stakeCents == this.stakeCents &&
          other.oddsScaled == this.oddsScaled &&
          other.status == this.status &&
          other.cashoutCents == this.cashoutCents &&
          other.actualReturnCents == this.actualReturnCents &&
          other.resultCents == this.resultCents &&
          other.notes == this.notes &&
          other.betType == this.betType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BetsCompanion extends UpdateCompanion<BetRow> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<DateTime> placedAt;
  final Value<DateTime?> settledAt;
  final Value<String> sport;
  final Value<String> event;
  final Value<String> market;
  final Value<String> selection;
  final Value<int> stakeCents;
  final Value<int> oddsScaled;
  final Value<BetStatus> status;
  final Value<int?> cashoutCents;
  final Value<int?> actualReturnCents;
  final Value<int?> resultCents;
  final Value<String?> notes;
  final Value<BetType?> betType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BetsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.placedAt = const Value.absent(),
    this.settledAt = const Value.absent(),
    this.sport = const Value.absent(),
    this.event = const Value.absent(),
    this.market = const Value.absent(),
    this.selection = const Value.absent(),
    this.stakeCents = const Value.absent(),
    this.oddsScaled = const Value.absent(),
    this.status = const Value.absent(),
    this.cashoutCents = const Value.absent(),
    this.actualReturnCents = const Value.absent(),
    this.resultCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.betType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BetsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required DateTime placedAt,
    this.settledAt = const Value.absent(),
    required String sport,
    required String event,
    required String market,
    required String selection,
    required int stakeCents,
    required int oddsScaled,
    required BetStatus status,
    this.cashoutCents = const Value.absent(),
    this.actualReturnCents = const Value.absent(),
    this.resultCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.betType = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : accountId = Value(accountId),
       placedAt = Value(placedAt),
       sport = Value(sport),
       event = Value(event),
       market = Value(market),
       selection = Value(selection),
       stakeCents = Value(stakeCents),
       oddsScaled = Value(oddsScaled),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BetRow> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<DateTime>? placedAt,
    Expression<DateTime>? settledAt,
    Expression<String>? sport,
    Expression<String>? event,
    Expression<String>? market,
    Expression<String>? selection,
    Expression<int>? stakeCents,
    Expression<int>? oddsScaled,
    Expression<String>? status,
    Expression<int>? cashoutCents,
    Expression<int>? actualReturnCents,
    Expression<int>? resultCents,
    Expression<String>? notes,
    Expression<String>? betType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (placedAt != null) 'placed_at': placedAt,
      if (settledAt != null) 'settled_at': settledAt,
      if (sport != null) 'sport': sport,
      if (event != null) 'event': event,
      if (market != null) 'market': market,
      if (selection != null) 'selection': selection,
      if (stakeCents != null) 'stake_cents': stakeCents,
      if (oddsScaled != null) 'odds_scaled': oddsScaled,
      if (status != null) 'status': status,
      if (cashoutCents != null) 'cashout_cents': cashoutCents,
      if (actualReturnCents != null) 'actual_return_cents': actualReturnCents,
      if (resultCents != null) 'result_cents': resultCents,
      if (notes != null) 'notes': notes,
      if (betType != null) 'bet_type': betType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BetsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<DateTime>? placedAt,
    Value<DateTime?>? settledAt,
    Value<String>? sport,
    Value<String>? event,
    Value<String>? market,
    Value<String>? selection,
    Value<int>? stakeCents,
    Value<int>? oddsScaled,
    Value<BetStatus>? status,
    Value<int?>? cashoutCents,
    Value<int?>? actualReturnCents,
    Value<int?>? resultCents,
    Value<String?>? notes,
    Value<BetType?>? betType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BetsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      placedAt: placedAt ?? this.placedAt,
      settledAt: settledAt ?? this.settledAt,
      sport: sport ?? this.sport,
      event: event ?? this.event,
      market: market ?? this.market,
      selection: selection ?? this.selection,
      stakeCents: stakeCents ?? this.stakeCents,
      oddsScaled: oddsScaled ?? this.oddsScaled,
      status: status ?? this.status,
      cashoutCents: cashoutCents ?? this.cashoutCents,
      actualReturnCents: actualReturnCents ?? this.actualReturnCents,
      resultCents: resultCents ?? this.resultCents,
      notes: notes ?? this.notes,
      betType: betType ?? this.betType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (placedAt.present) {
      map['placed_at'] = Variable<DateTime>(placedAt.value);
    }
    if (settledAt.present) {
      map['settled_at'] = Variable<DateTime>(settledAt.value);
    }
    if (sport.present) {
      map['sport'] = Variable<String>(sport.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (selection.present) {
      map['selection'] = Variable<String>(selection.value);
    }
    if (stakeCents.present) {
      map['stake_cents'] = Variable<int>(stakeCents.value);
    }
    if (oddsScaled.present) {
      map['odds_scaled'] = Variable<int>(oddsScaled.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $BetsTable.$converterstatus.toSql(status.value),
      );
    }
    if (cashoutCents.present) {
      map['cashout_cents'] = Variable<int>(cashoutCents.value);
    }
    if (actualReturnCents.present) {
      map['actual_return_cents'] = Variable<int>(actualReturnCents.value);
    }
    if (resultCents.present) {
      map['result_cents'] = Variable<int>(resultCents.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (betType.present) {
      map['bet_type'] = Variable<String>(
        $BetsTable.$converterbetTypen.toSql(betType.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BetsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('placedAt: $placedAt, ')
          ..write('settledAt: $settledAt, ')
          ..write('sport: $sport, ')
          ..write('event: $event, ')
          ..write('market: $market, ')
          ..write('selection: $selection, ')
          ..write('stakeCents: $stakeCents, ')
          ..write('oddsScaled: $oddsScaled, ')
          ..write('status: $status, ')
          ..write('cashoutCents: $cashoutCents, ')
          ..write('actualReturnCents: $actualReturnCents, ')
          ..write('resultCents: $resultCents, ')
          ..write('notes: $notes, ')
          ..write('betType: $betType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BetLegsTable extends BetLegs with TableInfo<$BetLegsTable, BetLegRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BetLegsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _betIdMeta = const VerificationMeta('betId');
  @override
  late final GeneratedColumn<int> betId = GeneratedColumn<int>(
    'bet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bets (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sportMeta = const VerificationMeta('sport');
  @override
  late final GeneratedColumn<String> sport = GeneratedColumn<String>(
    'sport',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectionMeta = const VerificationMeta(
    'selection',
  );
  @override
  late final GeneratedColumn<String> selection = GeneratedColumn<String>(
    'selection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oddsScaledMeta = const VerificationMeta(
    'oddsScaled',
  );
  @override
  late final GeneratedColumn<int> oddsScaled = GeneratedColumn<int>(
    'odds_scaled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    betId,
    position,
    sport,
    event,
    market,
    selection,
    oddsScaled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bet_legs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BetLegRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bet_id')) {
      context.handle(
        _betIdMeta,
        betId.isAcceptableOrUnknown(data['bet_id']!, _betIdMeta),
      );
    } else if (isInserting) {
      context.missing(_betIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('sport')) {
      context.handle(
        _sportMeta,
        sport.isAcceptableOrUnknown(data['sport']!, _sportMeta),
      );
    } else if (isInserting) {
      context.missing(_sportMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('selection')) {
      context.handle(
        _selectionMeta,
        selection.isAcceptableOrUnknown(data['selection']!, _selectionMeta),
      );
    } else if (isInserting) {
      context.missing(_selectionMeta);
    }
    if (data.containsKey('odds_scaled')) {
      context.handle(
        _oddsScaledMeta,
        oddsScaled.isAcceptableOrUnknown(data['odds_scaled']!, _oddsScaledMeta),
      );
    } else if (isInserting) {
      context.missing(_oddsScaledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BetLegRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BetLegRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      betId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bet_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      sport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sport'],
      )!,
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      selection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selection'],
      )!,
      oddsScaled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odds_scaled'],
      )!,
    );
  }

  @override
  $BetLegsTable createAlias(String alias) {
    return $BetLegsTable(attachedDatabase, alias);
  }
}

class BetLegRow extends DataClass implements Insertable<BetLegRow> {
  final int id;
  final int betId;

  /// Ordem de exibição das seleções dentro da múltipla.
  final int position;
  final String sport;
  final String event;
  final String market;
  final String selection;
  final int oddsScaled;
  const BetLegRow({
    required this.id,
    required this.betId,
    required this.position,
    required this.sport,
    required this.event,
    required this.market,
    required this.selection,
    required this.oddsScaled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bet_id'] = Variable<int>(betId);
    map['position'] = Variable<int>(position);
    map['sport'] = Variable<String>(sport);
    map['event'] = Variable<String>(event);
    map['market'] = Variable<String>(market);
    map['selection'] = Variable<String>(selection);
    map['odds_scaled'] = Variable<int>(oddsScaled);
    return map;
  }

  BetLegsCompanion toCompanion(bool nullToAbsent) {
    return BetLegsCompanion(
      id: Value(id),
      betId: Value(betId),
      position: Value(position),
      sport: Value(sport),
      event: Value(event),
      market: Value(market),
      selection: Value(selection),
      oddsScaled: Value(oddsScaled),
    );
  }

  factory BetLegRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BetLegRow(
      id: serializer.fromJson<int>(json['id']),
      betId: serializer.fromJson<int>(json['betId']),
      position: serializer.fromJson<int>(json['position']),
      sport: serializer.fromJson<String>(json['sport']),
      event: serializer.fromJson<String>(json['event']),
      market: serializer.fromJson<String>(json['market']),
      selection: serializer.fromJson<String>(json['selection']),
      oddsScaled: serializer.fromJson<int>(json['oddsScaled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'betId': serializer.toJson<int>(betId),
      'position': serializer.toJson<int>(position),
      'sport': serializer.toJson<String>(sport),
      'event': serializer.toJson<String>(event),
      'market': serializer.toJson<String>(market),
      'selection': serializer.toJson<String>(selection),
      'oddsScaled': serializer.toJson<int>(oddsScaled),
    };
  }

  BetLegRow copyWith({
    int? id,
    int? betId,
    int? position,
    String? sport,
    String? event,
    String? market,
    String? selection,
    int? oddsScaled,
  }) => BetLegRow(
    id: id ?? this.id,
    betId: betId ?? this.betId,
    position: position ?? this.position,
    sport: sport ?? this.sport,
    event: event ?? this.event,
    market: market ?? this.market,
    selection: selection ?? this.selection,
    oddsScaled: oddsScaled ?? this.oddsScaled,
  );
  BetLegRow copyWithCompanion(BetLegsCompanion data) {
    return BetLegRow(
      id: data.id.present ? data.id.value : this.id,
      betId: data.betId.present ? data.betId.value : this.betId,
      position: data.position.present ? data.position.value : this.position,
      sport: data.sport.present ? data.sport.value : this.sport,
      event: data.event.present ? data.event.value : this.event,
      market: data.market.present ? data.market.value : this.market,
      selection: data.selection.present ? data.selection.value : this.selection,
      oddsScaled: data.oddsScaled.present
          ? data.oddsScaled.value
          : this.oddsScaled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BetLegRow(')
          ..write('id: $id, ')
          ..write('betId: $betId, ')
          ..write('position: $position, ')
          ..write('sport: $sport, ')
          ..write('event: $event, ')
          ..write('market: $market, ')
          ..write('selection: $selection, ')
          ..write('oddsScaled: $oddsScaled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    betId,
    position,
    sport,
    event,
    market,
    selection,
    oddsScaled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BetLegRow &&
          other.id == this.id &&
          other.betId == this.betId &&
          other.position == this.position &&
          other.sport == this.sport &&
          other.event == this.event &&
          other.market == this.market &&
          other.selection == this.selection &&
          other.oddsScaled == this.oddsScaled);
}

class BetLegsCompanion extends UpdateCompanion<BetLegRow> {
  final Value<int> id;
  final Value<int> betId;
  final Value<int> position;
  final Value<String> sport;
  final Value<String> event;
  final Value<String> market;
  final Value<String> selection;
  final Value<int> oddsScaled;
  const BetLegsCompanion({
    this.id = const Value.absent(),
    this.betId = const Value.absent(),
    this.position = const Value.absent(),
    this.sport = const Value.absent(),
    this.event = const Value.absent(),
    this.market = const Value.absent(),
    this.selection = const Value.absent(),
    this.oddsScaled = const Value.absent(),
  });
  BetLegsCompanion.insert({
    this.id = const Value.absent(),
    required int betId,
    required int position,
    required String sport,
    required String event,
    required String market,
    required String selection,
    required int oddsScaled,
  }) : betId = Value(betId),
       position = Value(position),
       sport = Value(sport),
       event = Value(event),
       market = Value(market),
       selection = Value(selection),
       oddsScaled = Value(oddsScaled);
  static Insertable<BetLegRow> custom({
    Expression<int>? id,
    Expression<int>? betId,
    Expression<int>? position,
    Expression<String>? sport,
    Expression<String>? event,
    Expression<String>? market,
    Expression<String>? selection,
    Expression<int>? oddsScaled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (betId != null) 'bet_id': betId,
      if (position != null) 'position': position,
      if (sport != null) 'sport': sport,
      if (event != null) 'event': event,
      if (market != null) 'market': market,
      if (selection != null) 'selection': selection,
      if (oddsScaled != null) 'odds_scaled': oddsScaled,
    });
  }

  BetLegsCompanion copyWith({
    Value<int>? id,
    Value<int>? betId,
    Value<int>? position,
    Value<String>? sport,
    Value<String>? event,
    Value<String>? market,
    Value<String>? selection,
    Value<int>? oddsScaled,
  }) {
    return BetLegsCompanion(
      id: id ?? this.id,
      betId: betId ?? this.betId,
      position: position ?? this.position,
      sport: sport ?? this.sport,
      event: event ?? this.event,
      market: market ?? this.market,
      selection: selection ?? this.selection,
      oddsScaled: oddsScaled ?? this.oddsScaled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (betId.present) {
      map['bet_id'] = Variable<int>(betId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (sport.present) {
      map['sport'] = Variable<String>(sport.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (selection.present) {
      map['selection'] = Variable<String>(selection.value);
    }
    if (oddsScaled.present) {
      map['odds_scaled'] = Variable<int>(oddsScaled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BetLegsCompanion(')
          ..write('id: $id, ')
          ..write('betId: $betId, ')
          ..write('position: $position, ')
          ..write('sport: $sport, ')
          ..write('event: $event, ')
          ..write('market: $market, ')
          ..write('selection: $selection, ')
          ..write('oddsScaled: $oddsScaled')
          ..write(')'))
        .toString();
  }
}

class $FinancialCategoriesTable extends FinancialCategories
    with TableInfo<$FinancialCategoriesTable, FinancialCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoryKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CategoryKind>($FinancialCategoriesTable.$converterkind);
  static const VerificationMeta _parentCategoryIdMeta = const VerificationMeta(
    'parentCategoryId',
  );
  @override
  late final GeneratedColumn<int> parentCategoryId = GeneratedColumn<int>(
    'parent_category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id)',
    ),
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xe8b8),
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2563EB),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    parentCategoryId,
    iconCodePoint,
    colorValue,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_category_id')) {
      context.handle(
        _parentCategoryIdMeta,
        parentCategoryId.isAcceptableOrUnknown(
          data['parent_category_id']!,
          _parentCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialCategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $FinancialCategoriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      parentCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_category_id'],
      ),
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FinancialCategoriesTable createAlias(String alias) {
    return $FinancialCategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryKind, String, String> $converterkind =
      const EnumNameConverter<CategoryKind>(CategoryKind.values);
}

class FinancialCategoryRow extends DataClass
    implements Insertable<FinancialCategoryRow> {
  final int id;
  final String name;
  final CategoryKind kind;

  /// Subcategoria: referencia a categoria "pai". Nulo para categorias de
  /// nível superior.
  final int? parentCategoryId;

  /// Código do ícone (Icons.*.codePoint) usado na UI.
  final int iconCodePoint;

  /// Cor ARGB de identificação.
  final int colorValue;
  final bool isArchived;
  final DateTime createdAt;
  const FinancialCategoryRow({
    required this.id,
    required this.name,
    required this.kind,
    this.parentCategoryId,
    required this.iconCodePoint,
    required this.colorValue,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>(
        $FinancialCategoriesTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || parentCategoryId != null) {
      map['parent_category_id'] = Variable<int>(parentCategoryId);
    }
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    map['color_value'] = Variable<int>(colorValue);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialCategoriesCompanion toCompanion(bool nullToAbsent) {
    return FinancialCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      parentCategoryId: parentCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCategoryId),
      iconCodePoint: Value(iconCodePoint),
      colorValue: Value(colorValue),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialCategoryRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $FinancialCategoriesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      parentCategoryId: serializer.fromJson<int?>(json['parentCategoryId']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(
        $FinancialCategoriesTable.$converterkind.toJson(kind),
      ),
      'parentCategoryId': serializer.toJson<int?>(parentCategoryId),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'colorValue': serializer.toJson<int>(colorValue),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialCategoryRow copyWith({
    int? id,
    String? name,
    CategoryKind? kind,
    Value<int?> parentCategoryId = const Value.absent(),
    int? iconCodePoint,
    int? colorValue,
    bool? isArchived,
    DateTime? createdAt,
  }) => FinancialCategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    parentCategoryId: parentCategoryId.present
        ? parentCategoryId.value
        : this.parentCategoryId,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    colorValue: colorValue ?? this.colorValue,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  FinancialCategoryRow copyWithCompanion(FinancialCategoriesCompanion data) {
    return FinancialCategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      parentCategoryId: data.parentCategoryId.present
          ? data.parentCategoryId.value
          : this.parentCategoryId,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialCategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    parentCategoryId,
    iconCodePoint,
    colorValue,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialCategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.parentCategoryId == this.parentCategoryId &&
          other.iconCodePoint == this.iconCodePoint &&
          other.colorValue == this.colorValue &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class FinancialCategoriesCompanion
    extends UpdateCompanion<FinancialCategoryRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<CategoryKind> kind;
  final Value<int?> parentCategoryId;
  final Value<int> iconCodePoint;
  final Value<int> colorValue;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const FinancialCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FinancialCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required CategoryKind kind,
    this.parentCategoryId = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       kind = Value(kind),
       createdAt = Value(createdAt);
  static Insertable<FinancialCategoryRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? parentCategoryId,
    Expression<int>? iconCodePoint,
    Expression<int>? colorValue,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (parentCategoryId != null) 'parent_category_id': parentCategoryId,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (colorValue != null) 'color_value': colorValue,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FinancialCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<CategoryKind>? kind,
    Value<int?>? parentCategoryId,
    Value<int>? iconCodePoint,
    Value<int>? colorValue,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return FinancialCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      colorValue: colorValue ?? this.colorValue,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $FinancialCategoriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (parentCategoryId.present) {
      map['parent_category_id'] = Variable<int>(parentCategoryId.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('colorValue: $colorValue, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BillsPayableTable extends BillsPayable
    with TableInfo<$BillsPayableTable, BillPayableRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsPayableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _competenceDateMeta = const VerificationMeta(
    'competenceDate',
  );
  @override
  late final GeneratedColumn<DateTime> competenceDate =
      GeneratedColumn<DateTime>(
        'competence_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledMeta = const VerificationMeta(
    'cancelled',
  );
  @override
  late final GeneratedColumn<bool> cancelled = GeneratedColumn<bool>(
    'cancelled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cancelled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecurrenceFrequency?, String>
  recurrenceFrequency =
      GeneratedColumn<String>(
        'recurrence_frequency',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RecurrenceFrequency?>(
        $BillsPayableTable.$converterrecurrenceFrequencyn,
      );
  static const VerificationMeta _recurrenceGroupIdMeta = const VerificationMeta(
    'recurrenceGroupId',
  );
  @override
  late final GeneratedColumn<String> recurrenceGroupId =
      GeneratedColumn<String>(
        'recurrence_group_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amountCents,
    categoryId,
    accountId,
    dueDate,
    competenceDate,
    notes,
    cancelled,
    recurrenceFrequency,
    recurrenceGroupId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills_payable';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillPayableRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('competence_date')) {
      context.handle(
        _competenceDateMeta,
        competenceDate.isAcceptableOrUnknown(
          data['competence_date']!,
          _competenceDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('cancelled')) {
      context.handle(
        _cancelledMeta,
        cancelled.isAcceptableOrUnknown(data['cancelled']!, _cancelledMeta),
      );
    }
    if (data.containsKey('recurrence_group_id')) {
      context.handle(
        _recurrenceGroupIdMeta,
        recurrenceGroupId.isAcceptableOrUnknown(
          data['recurrence_group_id']!,
          _recurrenceGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillPayableRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillPayableRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      competenceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}competence_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      cancelled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cancelled'],
      )!,
      recurrenceFrequency: $BillsPayableTable.$converterrecurrenceFrequencyn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}recurrence_frequency'],
            ),
          ),
      recurrenceGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_group_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BillsPayableTable createAlias(String alias) {
    return $BillsPayableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecurrenceFrequency, String, String>
  $converterrecurrenceFrequency = const EnumNameConverter<RecurrenceFrequency>(
    RecurrenceFrequency.values,
  );
  static JsonTypeConverter2<RecurrenceFrequency?, String?, String?>
  $converterrecurrenceFrequencyn = JsonTypeConverter2.asNullable(
    $converterrecurrenceFrequency,
  );
}

class BillPayableRow extends DataClass implements Insertable<BillPayableRow> {
  final int id;
  final String description;
  final int amountCents;
  final int? categoryId;
  final int? accountId;
  final DateTime dueDate;
  final DateTime? competenceDate;
  final String? notes;
  final bool cancelled;
  final RecurrenceFrequency? recurrenceFrequency;
  final String? recurrenceGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillPayableRow({
    required this.id,
    required this.description,
    required this.amountCents,
    this.categoryId,
    this.accountId,
    required this.dueDate,
    this.competenceDate,
    this.notes,
    required this.cancelled,
    this.recurrenceFrequency,
    this.recurrenceGroupId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || competenceDate != null) {
      map['competence_date'] = Variable<DateTime>(competenceDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['cancelled'] = Variable<bool>(cancelled);
    if (!nullToAbsent || recurrenceFrequency != null) {
      map['recurrence_frequency'] = Variable<String>(
        $BillsPayableTable.$converterrecurrenceFrequencyn.toSql(
          recurrenceFrequency,
        ),
      );
    }
    if (!nullToAbsent || recurrenceGroupId != null) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillsPayableCompanion toCompanion(bool nullToAbsent) {
    return BillsPayableCompanion(
      id: Value(id),
      description: Value(description),
      amountCents: Value(amountCents),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      dueDate: Value(dueDate),
      competenceDate: competenceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(competenceDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      cancelled: Value(cancelled),
      recurrenceFrequency: recurrenceFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceFrequency),
      recurrenceGroupId: recurrenceGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceGroupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillPayableRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillPayableRow(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      competenceDate: serializer.fromJson<DateTime?>(json['competenceDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      cancelled: serializer.fromJson<bool>(json['cancelled']),
      recurrenceFrequency: $BillsPayableTable.$converterrecurrenceFrequencyn
          .fromJson(serializer.fromJson<String?>(json['recurrenceFrequency'])),
      recurrenceGroupId: serializer.fromJson<String?>(
        json['recurrenceGroupId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'amountCents': serializer.toJson<int>(amountCents),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int?>(accountId),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'competenceDate': serializer.toJson<DateTime?>(competenceDate),
      'notes': serializer.toJson<String?>(notes),
      'cancelled': serializer.toJson<bool>(cancelled),
      'recurrenceFrequency': serializer.toJson<String?>(
        $BillsPayableTable.$converterrecurrenceFrequencyn.toJson(
          recurrenceFrequency,
        ),
      ),
      'recurrenceGroupId': serializer.toJson<String?>(recurrenceGroupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillPayableRow copyWith({
    int? id,
    String? description,
    int? amountCents,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> accountId = const Value.absent(),
    DateTime? dueDate,
    Value<DateTime?> competenceDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? cancelled,
    Value<RecurrenceFrequency?> recurrenceFrequency = const Value.absent(),
    Value<String?> recurrenceGroupId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillPayableRow(
    id: id ?? this.id,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId.present ? accountId.value : this.accountId,
    dueDate: dueDate ?? this.dueDate,
    competenceDate: competenceDate.present
        ? competenceDate.value
        : this.competenceDate,
    notes: notes.present ? notes.value : this.notes,
    cancelled: cancelled ?? this.cancelled,
    recurrenceFrequency: recurrenceFrequency.present
        ? recurrenceFrequency.value
        : this.recurrenceFrequency,
    recurrenceGroupId: recurrenceGroupId.present
        ? recurrenceGroupId.value
        : this.recurrenceGroupId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillPayableRow copyWithCompanion(BillsPayableCompanion data) {
    return BillPayableRow(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      competenceDate: data.competenceDate.present
          ? data.competenceDate.value
          : this.competenceDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      cancelled: data.cancelled.present ? data.cancelled.value : this.cancelled,
      recurrenceFrequency: data.recurrenceFrequency.present
          ? data.recurrenceFrequency.value
          : this.recurrenceFrequency,
      recurrenceGroupId: data.recurrenceGroupId.present
          ? data.recurrenceGroupId.value
          : this.recurrenceGroupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillPayableRow(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('dueDate: $dueDate, ')
          ..write('competenceDate: $competenceDate, ')
          ..write('notes: $notes, ')
          ..write('cancelled: $cancelled, ')
          ..write('recurrenceFrequency: $recurrenceFrequency, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    amountCents,
    categoryId,
    accountId,
    dueDate,
    competenceDate,
    notes,
    cancelled,
    recurrenceFrequency,
    recurrenceGroupId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillPayableRow &&
          other.id == this.id &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.dueDate == this.dueDate &&
          other.competenceDate == this.competenceDate &&
          other.notes == this.notes &&
          other.cancelled == this.cancelled &&
          other.recurrenceFrequency == this.recurrenceFrequency &&
          other.recurrenceGroupId == this.recurrenceGroupId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillsPayableCompanion extends UpdateCompanion<BillPayableRow> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<int?> categoryId;
  final Value<int?> accountId;
  final Value<DateTime> dueDate;
  final Value<DateTime?> competenceDate;
  final Value<String?> notes;
  final Value<bool> cancelled;
  final Value<RecurrenceFrequency?> recurrenceFrequency;
  final Value<String?> recurrenceGroupId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BillsPayableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.competenceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.recurrenceFrequency = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BillsPayableCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    required int amountCents,
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    required DateTime dueDate,
    this.competenceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.recurrenceFrequency = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : description = Value(description),
       amountCents = Value(amountCents),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BillPayableRow> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? competenceDate,
    Expression<String>? notes,
    Expression<bool>? cancelled,
    Expression<String>? recurrenceFrequency,
    Expression<String>? recurrenceGroupId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (dueDate != null) 'due_date': dueDate,
      if (competenceDate != null) 'competence_date': competenceDate,
      if (notes != null) 'notes': notes,
      if (cancelled != null) 'cancelled': cancelled,
      if (recurrenceFrequency != null)
        'recurrence_frequency': recurrenceFrequency,
      if (recurrenceGroupId != null) 'recurrence_group_id': recurrenceGroupId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BillsPayableCompanion copyWith({
    Value<int>? id,
    Value<String>? description,
    Value<int>? amountCents,
    Value<int?>? categoryId,
    Value<int?>? accountId,
    Value<DateTime>? dueDate,
    Value<DateTime?>? competenceDate,
    Value<String?>? notes,
    Value<bool>? cancelled,
    Value<RecurrenceFrequency?>? recurrenceFrequency,
    Value<String?>? recurrenceGroupId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BillsPayableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      dueDate: dueDate ?? this.dueDate,
      competenceDate: competenceDate ?? this.competenceDate,
      notes: notes ?? this.notes,
      cancelled: cancelled ?? this.cancelled,
      recurrenceFrequency: recurrenceFrequency ?? this.recurrenceFrequency,
      recurrenceGroupId: recurrenceGroupId ?? this.recurrenceGroupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (competenceDate.present) {
      map['competence_date'] = Variable<DateTime>(competenceDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (cancelled.present) {
      map['cancelled'] = Variable<bool>(cancelled.value);
    }
    if (recurrenceFrequency.present) {
      map['recurrence_frequency'] = Variable<String>(
        $BillsPayableTable.$converterrecurrenceFrequencyn.toSql(
          recurrenceFrequency.value,
        ),
      );
    }
    if (recurrenceGroupId.present) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsPayableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('dueDate: $dueDate, ')
          ..write('competenceDate: $competenceDate, ')
          ..write('notes: $notes, ')
          ..write('cancelled: $cancelled, ')
          ..write('recurrenceFrequency: $recurrenceFrequency, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BillsReceivableTable extends BillsReceivable
    with TableInfo<$BillsReceivableTable, BillReceivableRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsReceivableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledMeta = const VerificationMeta(
    'cancelled',
  );
  @override
  late final GeneratedColumn<bool> cancelled = GeneratedColumn<bool>(
    'cancelled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cancelled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecurrenceFrequency?, String>
  recurrenceFrequency =
      GeneratedColumn<String>(
        'recurrence_frequency',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RecurrenceFrequency?>(
        $BillsReceivableTable.$converterrecurrenceFrequencyn,
      );
  static const VerificationMeta _recurrenceGroupIdMeta = const VerificationMeta(
    'recurrenceGroupId',
  );
  @override
  late final GeneratedColumn<String> recurrenceGroupId =
      GeneratedColumn<String>(
        'recurrence_group_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amountCents,
    categoryId,
    accountId,
    dueDate,
    notes,
    cancelled,
    recurrenceFrequency,
    recurrenceGroupId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills_receivable';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillReceivableRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('cancelled')) {
      context.handle(
        _cancelledMeta,
        cancelled.isAcceptableOrUnknown(data['cancelled']!, _cancelledMeta),
      );
    }
    if (data.containsKey('recurrence_group_id')) {
      context.handle(
        _recurrenceGroupIdMeta,
        recurrenceGroupId.isAcceptableOrUnknown(
          data['recurrence_group_id']!,
          _recurrenceGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillReceivableRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillReceivableRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      cancelled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cancelled'],
      )!,
      recurrenceFrequency: $BillsReceivableTable.$converterrecurrenceFrequencyn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}recurrence_frequency'],
            ),
          ),
      recurrenceGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_group_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BillsReceivableTable createAlias(String alias) {
    return $BillsReceivableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecurrenceFrequency, String, String>
  $converterrecurrenceFrequency = const EnumNameConverter<RecurrenceFrequency>(
    RecurrenceFrequency.values,
  );
  static JsonTypeConverter2<RecurrenceFrequency?, String?, String?>
  $converterrecurrenceFrequencyn = JsonTypeConverter2.asNullable(
    $converterrecurrenceFrequency,
  );
}

class BillReceivableRow extends DataClass
    implements Insertable<BillReceivableRow> {
  final int id;
  final String description;
  final int amountCents;
  final int? categoryId;
  final int? accountId;
  final DateTime dueDate;
  final String? notes;
  final bool cancelled;
  final RecurrenceFrequency? recurrenceFrequency;
  final String? recurrenceGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillReceivableRow({
    required this.id,
    required this.description,
    required this.amountCents,
    this.categoryId,
    this.accountId,
    required this.dueDate,
    this.notes,
    required this.cancelled,
    this.recurrenceFrequency,
    this.recurrenceGroupId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['cancelled'] = Variable<bool>(cancelled);
    if (!nullToAbsent || recurrenceFrequency != null) {
      map['recurrence_frequency'] = Variable<String>(
        $BillsReceivableTable.$converterrecurrenceFrequencyn.toSql(
          recurrenceFrequency,
        ),
      );
    }
    if (!nullToAbsent || recurrenceGroupId != null) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillsReceivableCompanion toCompanion(bool nullToAbsent) {
    return BillsReceivableCompanion(
      id: Value(id),
      description: Value(description),
      amountCents: Value(amountCents),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      dueDate: Value(dueDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      cancelled: Value(cancelled),
      recurrenceFrequency: recurrenceFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceFrequency),
      recurrenceGroupId: recurrenceGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceGroupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillReceivableRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillReceivableRow(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      cancelled: serializer.fromJson<bool>(json['cancelled']),
      recurrenceFrequency: $BillsReceivableTable.$converterrecurrenceFrequencyn
          .fromJson(serializer.fromJson<String?>(json['recurrenceFrequency'])),
      recurrenceGroupId: serializer.fromJson<String?>(
        json['recurrenceGroupId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'amountCents': serializer.toJson<int>(amountCents),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int?>(accountId),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'notes': serializer.toJson<String?>(notes),
      'cancelled': serializer.toJson<bool>(cancelled),
      'recurrenceFrequency': serializer.toJson<String?>(
        $BillsReceivableTable.$converterrecurrenceFrequencyn.toJson(
          recurrenceFrequency,
        ),
      ),
      'recurrenceGroupId': serializer.toJson<String?>(recurrenceGroupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillReceivableRow copyWith({
    int? id,
    String? description,
    int? amountCents,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> accountId = const Value.absent(),
    DateTime? dueDate,
    Value<String?> notes = const Value.absent(),
    bool? cancelled,
    Value<RecurrenceFrequency?> recurrenceFrequency = const Value.absent(),
    Value<String?> recurrenceGroupId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillReceivableRow(
    id: id ?? this.id,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId.present ? accountId.value : this.accountId,
    dueDate: dueDate ?? this.dueDate,
    notes: notes.present ? notes.value : this.notes,
    cancelled: cancelled ?? this.cancelled,
    recurrenceFrequency: recurrenceFrequency.present
        ? recurrenceFrequency.value
        : this.recurrenceFrequency,
    recurrenceGroupId: recurrenceGroupId.present
        ? recurrenceGroupId.value
        : this.recurrenceGroupId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillReceivableRow copyWithCompanion(BillsReceivableCompanion data) {
    return BillReceivableRow(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      cancelled: data.cancelled.present ? data.cancelled.value : this.cancelled,
      recurrenceFrequency: data.recurrenceFrequency.present
          ? data.recurrenceFrequency.value
          : this.recurrenceFrequency,
      recurrenceGroupId: data.recurrenceGroupId.present
          ? data.recurrenceGroupId.value
          : this.recurrenceGroupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillReceivableRow(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('cancelled: $cancelled, ')
          ..write('recurrenceFrequency: $recurrenceFrequency, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    amountCents,
    categoryId,
    accountId,
    dueDate,
    notes,
    cancelled,
    recurrenceFrequency,
    recurrenceGroupId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillReceivableRow &&
          other.id == this.id &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.dueDate == this.dueDate &&
          other.notes == this.notes &&
          other.cancelled == this.cancelled &&
          other.recurrenceFrequency == this.recurrenceFrequency &&
          other.recurrenceGroupId == this.recurrenceGroupId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillsReceivableCompanion extends UpdateCompanion<BillReceivableRow> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<int?> categoryId;
  final Value<int?> accountId;
  final Value<DateTime> dueDate;
  final Value<String?> notes;
  final Value<bool> cancelled;
  final Value<RecurrenceFrequency?> recurrenceFrequency;
  final Value<String?> recurrenceGroupId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BillsReceivableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.recurrenceFrequency = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BillsReceivableCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    required int amountCents,
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    required DateTime dueDate,
    this.notes = const Value.absent(),
    this.cancelled = const Value.absent(),
    this.recurrenceFrequency = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : description = Value(description),
       amountCents = Value(amountCents),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BillReceivableRow> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<DateTime>? dueDate,
    Expression<String>? notes,
    Expression<bool>? cancelled,
    Expression<String>? recurrenceFrequency,
    Expression<String>? recurrenceGroupId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (dueDate != null) 'due_date': dueDate,
      if (notes != null) 'notes': notes,
      if (cancelled != null) 'cancelled': cancelled,
      if (recurrenceFrequency != null)
        'recurrence_frequency': recurrenceFrequency,
      if (recurrenceGroupId != null) 'recurrence_group_id': recurrenceGroupId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BillsReceivableCompanion copyWith({
    Value<int>? id,
    Value<String>? description,
    Value<int>? amountCents,
    Value<int?>? categoryId,
    Value<int?>? accountId,
    Value<DateTime>? dueDate,
    Value<String?>? notes,
    Value<bool>? cancelled,
    Value<RecurrenceFrequency?>? recurrenceFrequency,
    Value<String?>? recurrenceGroupId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BillsReceivableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      cancelled: cancelled ?? this.cancelled,
      recurrenceFrequency: recurrenceFrequency ?? this.recurrenceFrequency,
      recurrenceGroupId: recurrenceGroupId ?? this.recurrenceGroupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (cancelled.present) {
      map['cancelled'] = Variable<bool>(cancelled.value);
    }
    if (recurrenceFrequency.present) {
      map['recurrence_frequency'] = Variable<String>(
        $BillsReceivableTable.$converterrecurrenceFrequencyn.toSql(
          recurrenceFrequency.value,
        ),
      );
    }
    if (recurrenceGroupId.present) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsReceivableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('cancelled: $cancelled, ')
          ..write('recurrenceFrequency: $recurrenceFrequency, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MovementsTable extends Movements
    with TableInfo<$MovementsTable, MovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MovementType>($MovementsTable.$convertertype);
  static const VerificationMeta _sourceAccountIdMeta = const VerificationMeta(
    'sourceAccountId',
  );
  @override
  late final GeneratedColumn<int> sourceAccountId = GeneratedColumn<int>(
    'source_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _destinationAccountIdMeta =
      const VerificationMeta('destinationAccountId');
  @override
  late final GeneratedColumn<int> destinationAccountId = GeneratedColumn<int>(
    'destination_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feeCentsMeta = const VerificationMeta(
    'feeCents',
  );
  @override
  late final GeneratedColumn<int> feeCents = GeneratedColumn<int>(
    'fee_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adjustmentReasonMeta = const VerificationMeta(
    'adjustmentReason',
  );
  @override
  late final GeneratedColumn<String> adjustmentReason = GeneratedColumn<String>(
    'adjustment_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id)',
    ),
  );
  static const VerificationMeta _reconciledMeta = const VerificationMeta(
    'reconciled',
  );
  @override
  late final GeneratedColumn<bool> reconciled = GeneratedColumn<bool>(
    'reconciled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reconciled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _payableIdMeta = const VerificationMeta(
    'payableId',
  );
  @override
  late final GeneratedColumn<int> payableId = GeneratedColumn<int>(
    'payable_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bills_payable (id)',
    ),
  );
  static const VerificationMeta _receivableIdMeta = const VerificationMeta(
    'receivableId',
  );
  @override
  late final GeneratedColumn<int> receivableId = GeneratedColumn<int>(
    'receivable_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bills_receivable (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    sourceAccountId,
    destinationAccountId,
    amountCents,
    feeCents,
    occurredAt,
    description,
    adjustmentReason,
    categoryId,
    reconciled,
    payableId,
    receivableId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_account_id')) {
      context.handle(
        _sourceAccountIdMeta,
        sourceAccountId.isAcceptableOrUnknown(
          data['source_account_id']!,
          _sourceAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('destination_account_id')) {
      context.handle(
        _destinationAccountIdMeta,
        destinationAccountId.isAcceptableOrUnknown(
          data['destination_account_id']!,
          _destinationAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('fee_cents')) {
      context.handle(
        _feeCentsMeta,
        feeCents.isAcceptableOrUnknown(data['fee_cents']!, _feeCentsMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('adjustment_reason')) {
      context.handle(
        _adjustmentReasonMeta,
        adjustmentReason.isAcceptableOrUnknown(
          data['adjustment_reason']!,
          _adjustmentReasonMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('reconciled')) {
      context.handle(
        _reconciledMeta,
        reconciled.isAcceptableOrUnknown(data['reconciled']!, _reconciledMeta),
      );
    }
    if (data.containsKey('payable_id')) {
      context.handle(
        _payableIdMeta,
        payableId.isAcceptableOrUnknown(data['payable_id']!, _payableIdMeta),
      );
    }
    if (data.containsKey('receivable_id')) {
      context.handle(
        _receivableIdMeta,
        receivableId.isAcceptableOrUnknown(
          data['receivable_id']!,
          _receivableIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $MovementsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      sourceAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_account_id'],
      ),
      destinationAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}destination_account_id'],
      ),
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      feeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee_cents'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      adjustmentReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adjustment_reason'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      reconciled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reconciled'],
      )!,
      payableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payable_id'],
      ),
      receivableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receivable_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MovementsTable createAlias(String alias) {
    return $MovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementType, String, String> $convertertype =
      const EnumNameConverter<MovementType>(MovementType.values);
}

class MovementRow extends DataClass implements Insertable<MovementRow> {
  final int id;
  final MovementType type;
  final int? sourceAccountId;
  final int? destinationAccountId;

  /// Valor principal movimentado, em centavos (sem contar a taxa).
  final int amountCents;

  /// Taxa cobrada na operação (ex: taxa de transferência), em centavos.
  final int feeCents;
  final DateTime occurredAt;
  final String? description;

  /// Justificativa obrigatória para movimentações de ajuste.
  final String? adjustmentReason;
  final int? categoryId;
  final bool reconciled;

  /// Preenchido quando esta movimentação é a baixa (total ou parcial) de
  /// uma conta a pagar — o valor já pago de uma conta a pagar é sempre a
  /// soma de `amountCents` das movimentações com este vínculo.
  final int? payableId;

  /// Idem para contas a receber.
  final int? receivableId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MovementRow({
    required this.id,
    required this.type,
    this.sourceAccountId,
    this.destinationAccountId,
    required this.amountCents,
    required this.feeCents,
    required this.occurredAt,
    this.description,
    this.adjustmentReason,
    this.categoryId,
    required this.reconciled,
    this.payableId,
    this.receivableId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $MovementsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || sourceAccountId != null) {
      map['source_account_id'] = Variable<int>(sourceAccountId);
    }
    if (!nullToAbsent || destinationAccountId != null) {
      map['destination_account_id'] = Variable<int>(destinationAccountId);
    }
    map['amount_cents'] = Variable<int>(amountCents);
    map['fee_cents'] = Variable<int>(feeCents);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || adjustmentReason != null) {
      map['adjustment_reason'] = Variable<String>(adjustmentReason);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['reconciled'] = Variable<bool>(reconciled);
    if (!nullToAbsent || payableId != null) {
      map['payable_id'] = Variable<int>(payableId);
    }
    if (!nullToAbsent || receivableId != null) {
      map['receivable_id'] = Variable<int>(receivableId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MovementsCompanion toCompanion(bool nullToAbsent) {
    return MovementsCompanion(
      id: Value(id),
      type: Value(type),
      sourceAccountId: sourceAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceAccountId),
      destinationAccountId: destinationAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationAccountId),
      amountCents: Value(amountCents),
      feeCents: Value(feeCents),
      occurredAt: Value(occurredAt),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      adjustmentReason: adjustmentReason == null && nullToAbsent
          ? const Value.absent()
          : Value(adjustmentReason),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      reconciled: Value(reconciled),
      payableId: payableId == null && nullToAbsent
          ? const Value.absent()
          : Value(payableId),
      receivableId: receivableId == null && nullToAbsent
          ? const Value.absent()
          : Value(receivableId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MovementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovementRow(
      id: serializer.fromJson<int>(json['id']),
      type: $MovementsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      sourceAccountId: serializer.fromJson<int?>(json['sourceAccountId']),
      destinationAccountId: serializer.fromJson<int?>(
        json['destinationAccountId'],
      ),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      feeCents: serializer.fromJson<int>(json['feeCents']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      description: serializer.fromJson<String?>(json['description']),
      adjustmentReason: serializer.fromJson<String?>(json['adjustmentReason']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      reconciled: serializer.fromJson<bool>(json['reconciled']),
      payableId: serializer.fromJson<int?>(json['payableId']),
      receivableId: serializer.fromJson<int?>(json['receivableId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $MovementsTable.$convertertype.toJson(type),
      ),
      'sourceAccountId': serializer.toJson<int?>(sourceAccountId),
      'destinationAccountId': serializer.toJson<int?>(destinationAccountId),
      'amountCents': serializer.toJson<int>(amountCents),
      'feeCents': serializer.toJson<int>(feeCents),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'description': serializer.toJson<String?>(description),
      'adjustmentReason': serializer.toJson<String?>(adjustmentReason),
      'categoryId': serializer.toJson<int?>(categoryId),
      'reconciled': serializer.toJson<bool>(reconciled),
      'payableId': serializer.toJson<int?>(payableId),
      'receivableId': serializer.toJson<int?>(receivableId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MovementRow copyWith({
    int? id,
    MovementType? type,
    Value<int?> sourceAccountId = const Value.absent(),
    Value<int?> destinationAccountId = const Value.absent(),
    int? amountCents,
    int? feeCents,
    DateTime? occurredAt,
    Value<String?> description = const Value.absent(),
    Value<String?> adjustmentReason = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    bool? reconciled,
    Value<int?> payableId = const Value.absent(),
    Value<int?> receivableId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MovementRow(
    id: id ?? this.id,
    type: type ?? this.type,
    sourceAccountId: sourceAccountId.present
        ? sourceAccountId.value
        : this.sourceAccountId,
    destinationAccountId: destinationAccountId.present
        ? destinationAccountId.value
        : this.destinationAccountId,
    amountCents: amountCents ?? this.amountCents,
    feeCents: feeCents ?? this.feeCents,
    occurredAt: occurredAt ?? this.occurredAt,
    description: description.present ? description.value : this.description,
    adjustmentReason: adjustmentReason.present
        ? adjustmentReason.value
        : this.adjustmentReason,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    reconciled: reconciled ?? this.reconciled,
    payableId: payableId.present ? payableId.value : this.payableId,
    receivableId: receivableId.present ? receivableId.value : this.receivableId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MovementRow copyWithCompanion(MovementsCompanion data) {
    return MovementRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      sourceAccountId: data.sourceAccountId.present
          ? data.sourceAccountId.value
          : this.sourceAccountId,
      destinationAccountId: data.destinationAccountId.present
          ? data.destinationAccountId.value
          : this.destinationAccountId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      feeCents: data.feeCents.present ? data.feeCents.value : this.feeCents,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      description: data.description.present
          ? data.description.value
          : this.description,
      adjustmentReason: data.adjustmentReason.present
          ? data.adjustmentReason.value
          : this.adjustmentReason,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      reconciled: data.reconciled.present
          ? data.reconciled.value
          : this.reconciled,
      payableId: data.payableId.present ? data.payableId.value : this.payableId,
      receivableId: data.receivableId.present
          ? data.receivableId.value
          : this.receivableId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovementRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sourceAccountId: $sourceAccountId, ')
          ..write('destinationAccountId: $destinationAccountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('feeCents: $feeCents, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('adjustmentReason: $adjustmentReason, ')
          ..write('categoryId: $categoryId, ')
          ..write('reconciled: $reconciled, ')
          ..write('payableId: $payableId, ')
          ..write('receivableId: $receivableId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    sourceAccountId,
    destinationAccountId,
    amountCents,
    feeCents,
    occurredAt,
    description,
    adjustmentReason,
    categoryId,
    reconciled,
    payableId,
    receivableId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovementRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.sourceAccountId == this.sourceAccountId &&
          other.destinationAccountId == this.destinationAccountId &&
          other.amountCents == this.amountCents &&
          other.feeCents == this.feeCents &&
          other.occurredAt == this.occurredAt &&
          other.description == this.description &&
          other.adjustmentReason == this.adjustmentReason &&
          other.categoryId == this.categoryId &&
          other.reconciled == this.reconciled &&
          other.payableId == this.payableId &&
          other.receivableId == this.receivableId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MovementsCompanion extends UpdateCompanion<MovementRow> {
  final Value<int> id;
  final Value<MovementType> type;
  final Value<int?> sourceAccountId;
  final Value<int?> destinationAccountId;
  final Value<int> amountCents;
  final Value<int> feeCents;
  final Value<DateTime> occurredAt;
  final Value<String?> description;
  final Value<String?> adjustmentReason;
  final Value<int?> categoryId;
  final Value<bool> reconciled;
  final Value<int?> payableId;
  final Value<int?> receivableId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MovementsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.sourceAccountId = const Value.absent(),
    this.destinationAccountId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.feeCents = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.description = const Value.absent(),
    this.adjustmentReason = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.reconciled = const Value.absent(),
    this.payableId = const Value.absent(),
    this.receivableId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MovementsCompanion.insert({
    this.id = const Value.absent(),
    required MovementType type,
    this.sourceAccountId = const Value.absent(),
    this.destinationAccountId = const Value.absent(),
    required int amountCents,
    this.feeCents = const Value.absent(),
    required DateTime occurredAt,
    this.description = const Value.absent(),
    this.adjustmentReason = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.reconciled = const Value.absent(),
    this.payableId = const Value.absent(),
    this.receivableId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : type = Value(type),
       amountCents = Value(amountCents),
       occurredAt = Value(occurredAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MovementRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? sourceAccountId,
    Expression<int>? destinationAccountId,
    Expression<int>? amountCents,
    Expression<int>? feeCents,
    Expression<DateTime>? occurredAt,
    Expression<String>? description,
    Expression<String>? adjustmentReason,
    Expression<int>? categoryId,
    Expression<bool>? reconciled,
    Expression<int>? payableId,
    Expression<int>? receivableId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (sourceAccountId != null) 'source_account_id': sourceAccountId,
      if (destinationAccountId != null)
        'destination_account_id': destinationAccountId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (feeCents != null) 'fee_cents': feeCents,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (description != null) 'description': description,
      if (adjustmentReason != null) 'adjustment_reason': adjustmentReason,
      if (categoryId != null) 'category_id': categoryId,
      if (reconciled != null) 'reconciled': reconciled,
      if (payableId != null) 'payable_id': payableId,
      if (receivableId != null) 'receivable_id': receivableId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MovementsCompanion copyWith({
    Value<int>? id,
    Value<MovementType>? type,
    Value<int?>? sourceAccountId,
    Value<int?>? destinationAccountId,
    Value<int>? amountCents,
    Value<int>? feeCents,
    Value<DateTime>? occurredAt,
    Value<String?>? description,
    Value<String?>? adjustmentReason,
    Value<int?>? categoryId,
    Value<bool>? reconciled,
    Value<int?>? payableId,
    Value<int?>? receivableId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MovementsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      sourceAccountId: sourceAccountId ?? this.sourceAccountId,
      destinationAccountId: destinationAccountId ?? this.destinationAccountId,
      amountCents: amountCents ?? this.amountCents,
      feeCents: feeCents ?? this.feeCents,
      occurredAt: occurredAt ?? this.occurredAt,
      description: description ?? this.description,
      adjustmentReason: adjustmentReason ?? this.adjustmentReason,
      categoryId: categoryId ?? this.categoryId,
      reconciled: reconciled ?? this.reconciled,
      payableId: payableId ?? this.payableId,
      receivableId: receivableId ?? this.receivableId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $MovementsTable.$convertertype.toSql(type.value),
      );
    }
    if (sourceAccountId.present) {
      map['source_account_id'] = Variable<int>(sourceAccountId.value);
    }
    if (destinationAccountId.present) {
      map['destination_account_id'] = Variable<int>(destinationAccountId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (feeCents.present) {
      map['fee_cents'] = Variable<int>(feeCents.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (adjustmentReason.present) {
      map['adjustment_reason'] = Variable<String>(adjustmentReason.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (reconciled.present) {
      map['reconciled'] = Variable<bool>(reconciled.value);
    }
    if (payableId.present) {
      map['payable_id'] = Variable<int>(payableId.value);
    }
    if (receivableId.present) {
      map['receivable_id'] = Variable<int>(receivableId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sourceAccountId: $sourceAccountId, ')
          ..write('destinationAccountId: $destinationAccountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('feeCents: $feeCents, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('adjustmentReason: $adjustmentReason, ')
          ..write('categoryId: $categoryId, ')
          ..write('reconciled: $reconciled, ')
          ..write('payableId: $payableId, ')
          ..write('receivableId: $receivableId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CdbYieldsTable extends CdbYields
    with TableInfo<$CdbYieldsTable, CdbYieldRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CdbYieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    date,
    amountCents,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cdb_yields';
  @override
  VerificationContext validateIntegrity(
    Insertable<CdbYieldRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CdbYieldRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CdbYieldRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CdbYieldsTable createAlias(String alias) {
    return $CdbYieldsTable(attachedDatabase, alias);
  }
}

class CdbYieldRow extends DataClass implements Insertable<CdbYieldRow> {
  final int id;
  final int accountId;
  final DateTime date;
  final int amountCents;
  final String? description;
  final DateTime createdAt;
  const CdbYieldRow({
    required this.id,
    required this.accountId,
    required this.date,
    required this.amountCents,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['date'] = Variable<DateTime>(date);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CdbYieldsCompanion toCompanion(bool nullToAbsent) {
    return CdbYieldsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      date: Value(date),
      amountCents: Value(amountCents),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory CdbYieldRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CdbYieldRow(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      date: serializer.fromJson<DateTime>(json['date']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'date': serializer.toJson<DateTime>(date),
      'amountCents': serializer.toJson<int>(amountCents),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CdbYieldRow copyWith({
    int? id,
    int? accountId,
    DateTime? date,
    int? amountCents,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => CdbYieldRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    date: date ?? this.date,
    amountCents: amountCents ?? this.amountCents,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  CdbYieldRow copyWithCompanion(CdbYieldsCompanion data) {
    return CdbYieldRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      date: data.date.present ? data.date.value : this.date,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CdbYieldRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('date: $date, ')
          ..write('amountCents: $amountCents, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accountId, date, amountCents, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CdbYieldRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.date == this.date &&
          other.amountCents == this.amountCents &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class CdbYieldsCompanion extends UpdateCompanion<CdbYieldRow> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<DateTime> date;
  final Value<int> amountCents;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const CdbYieldsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.date = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CdbYieldsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required DateTime date,
    required int amountCents,
    this.description = const Value.absent(),
    required DateTime createdAt,
  }) : accountId = Value(accountId),
       date = Value(date),
       amountCents = Value(amountCents),
       createdAt = Value(createdAt);
  static Insertable<CdbYieldRow> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<DateTime>? date,
    Expression<int>? amountCents,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (date != null) 'date': date,
      if (amountCents != null) 'amount_cents': amountCents,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CdbYieldsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<DateTime>? date,
    Value<int>? amountCents,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return CdbYieldsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      date: date ?? this.date,
      amountCents: amountCents ?? this.amountCents,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CdbYieldsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('date: $date, ')
          ..write('amountCents: $amountCents, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardsTable extends CreditCards
    with TableInfo<$CreditCardsTable, CreditCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuerBankMeta = const VerificationMeta(
    'issuerBank',
  );
  @override
  late final GeneratedColumn<String> issuerBank = GeneratedColumn<String>(
    'issuer_bank',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditLimitCentsMeta = const VerificationMeta(
    'creditLimitCents',
  );
  @override
  late final GeneratedColumn<int> creditLimitCents = GeneratedColumn<int>(
    'credit_limit_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _closingDayMeta = const VerificationMeta(
    'closingDay',
  );
  @override
  late final GeneratedColumn<int> closingDay = GeneratedColumn<int>(
    'closing_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultPaymentAccountIdMeta =
      const VerificationMeta('defaultPaymentAccountId');
  @override
  late final GeneratedColumn<int> defaultPaymentAccountId =
      GeneratedColumn<int>(
        'default_payment_account_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id)',
        ),
      );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF7C3AED),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    issuerBank,
    creditLimitCents,
    closingDay,
    dueDay,
    defaultPaymentAccountId,
    colorValue,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('issuer_bank')) {
      context.handle(
        _issuerBankMeta,
        issuerBank.isAcceptableOrUnknown(data['issuer_bank']!, _issuerBankMeta),
      );
    }
    if (data.containsKey('credit_limit_cents')) {
      context.handle(
        _creditLimitCentsMeta,
        creditLimitCents.isAcceptableOrUnknown(
          data['credit_limit_cents']!,
          _creditLimitCentsMeta,
        ),
      );
    }
    if (data.containsKey('closing_day')) {
      context.handle(
        _closingDayMeta,
        closingDay.isAcceptableOrUnknown(data['closing_day']!, _closingDayMeta),
      );
    } else if (isInserting) {
      context.missing(_closingDayMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDayMeta);
    }
    if (data.containsKey('default_payment_account_id')) {
      context.handle(
        _defaultPaymentAccountIdMeta,
        defaultPaymentAccountId.isAcceptableOrUnknown(
          data['default_payment_account_id']!,
          _defaultPaymentAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      issuerBank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer_bank'],
      ),
      creditLimitCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit_cents'],
      )!,
      closingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}closing_day'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      )!,
      defaultPaymentAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_payment_account_id'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CreditCardsTable createAlias(String alias) {
    return $CreditCardsTable(attachedDatabase, alias);
  }
}

class CreditCardRow extends DataClass implements Insertable<CreditCardRow> {
  final int id;
  final String name;
  final String? issuerBank;
  final int creditLimitCents;

  /// Dia do mês em que a fatura fecha (1-31).
  final int closingDay;

  /// Dia do mês em que a fatura vence (1-31).
  final int dueDay;

  /// Conta bancária padrão sugerida para pagar a fatura.
  final int? defaultPaymentAccountId;
  final int colorValue;
  final bool isArchived;
  final DateTime createdAt;
  const CreditCardRow({
    required this.id,
    required this.name,
    this.issuerBank,
    required this.creditLimitCents,
    required this.closingDay,
    required this.dueDay,
    this.defaultPaymentAccountId,
    required this.colorValue,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || issuerBank != null) {
      map['issuer_bank'] = Variable<String>(issuerBank);
    }
    map['credit_limit_cents'] = Variable<int>(creditLimitCents);
    map['closing_day'] = Variable<int>(closingDay);
    map['due_day'] = Variable<int>(dueDay);
    if (!nullToAbsent || defaultPaymentAccountId != null) {
      map['default_payment_account_id'] = Variable<int>(
        defaultPaymentAccountId,
      );
    }
    map['color_value'] = Variable<int>(colorValue);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditCardsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCompanion(
      id: Value(id),
      name: Value(name),
      issuerBank: issuerBank == null && nullToAbsent
          ? const Value.absent()
          : Value(issuerBank),
      creditLimitCents: Value(creditLimitCents),
      closingDay: Value(closingDay),
      dueDay: Value(dueDay),
      defaultPaymentAccountId: defaultPaymentAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPaymentAccountId),
      colorValue: Value(colorValue),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory CreditCardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      issuerBank: serializer.fromJson<String?>(json['issuerBank']),
      creditLimitCents: serializer.fromJson<int>(json['creditLimitCents']),
      closingDay: serializer.fromJson<int>(json['closingDay']),
      dueDay: serializer.fromJson<int>(json['dueDay']),
      defaultPaymentAccountId: serializer.fromJson<int?>(
        json['defaultPaymentAccountId'],
      ),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'issuerBank': serializer.toJson<String?>(issuerBank),
      'creditLimitCents': serializer.toJson<int>(creditLimitCents),
      'closingDay': serializer.toJson<int>(closingDay),
      'dueDay': serializer.toJson<int>(dueDay),
      'defaultPaymentAccountId': serializer.toJson<int?>(
        defaultPaymentAccountId,
      ),
      'colorValue': serializer.toJson<int>(colorValue),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditCardRow copyWith({
    int? id,
    String? name,
    Value<String?> issuerBank = const Value.absent(),
    int? creditLimitCents,
    int? closingDay,
    int? dueDay,
    Value<int?> defaultPaymentAccountId = const Value.absent(),
    int? colorValue,
    bool? isArchived,
    DateTime? createdAt,
  }) => CreditCardRow(
    id: id ?? this.id,
    name: name ?? this.name,
    issuerBank: issuerBank.present ? issuerBank.value : this.issuerBank,
    creditLimitCents: creditLimitCents ?? this.creditLimitCents,
    closingDay: closingDay ?? this.closingDay,
    dueDay: dueDay ?? this.dueDay,
    defaultPaymentAccountId: defaultPaymentAccountId.present
        ? defaultPaymentAccountId.value
        : this.defaultPaymentAccountId,
    colorValue: colorValue ?? this.colorValue,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  CreditCardRow copyWithCompanion(CreditCardsCompanion data) {
    return CreditCardRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      issuerBank: data.issuerBank.present
          ? data.issuerBank.value
          : this.issuerBank,
      creditLimitCents: data.creditLimitCents.present
          ? data.creditLimitCents.value
          : this.creditLimitCents,
      closingDay: data.closingDay.present
          ? data.closingDay.value
          : this.closingDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      defaultPaymentAccountId: data.defaultPaymentAccountId.present
          ? data.defaultPaymentAccountId.value
          : this.defaultPaymentAccountId,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuerBank: $issuerBank, ')
          ..write('creditLimitCents: $creditLimitCents, ')
          ..write('closingDay: $closingDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('defaultPaymentAccountId: $defaultPaymentAccountId, ')
          ..write('colorValue: $colorValue, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    issuerBank,
    creditLimitCents,
    closingDay,
    dueDay,
    defaultPaymentAccountId,
    colorValue,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.issuerBank == this.issuerBank &&
          other.creditLimitCents == this.creditLimitCents &&
          other.closingDay == this.closingDay &&
          other.dueDay == this.dueDay &&
          other.defaultPaymentAccountId == this.defaultPaymentAccountId &&
          other.colorValue == this.colorValue &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class CreditCardsCompanion extends UpdateCompanion<CreditCardRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> issuerBank;
  final Value<int> creditLimitCents;
  final Value<int> closingDay;
  final Value<int> dueDay;
  final Value<int?> defaultPaymentAccountId;
  final Value<int> colorValue;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const CreditCardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.issuerBank = const Value.absent(),
    this.creditLimitCents = const Value.absent(),
    this.closingDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.defaultPaymentAccountId = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditCardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.issuerBank = const Value.absent(),
    this.creditLimitCents = const Value.absent(),
    required int closingDay,
    required int dueDay,
    this.defaultPaymentAccountId = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       closingDay = Value(closingDay),
       dueDay = Value(dueDay),
       createdAt = Value(createdAt);
  static Insertable<CreditCardRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? issuerBank,
    Expression<int>? creditLimitCents,
    Expression<int>? closingDay,
    Expression<int>? dueDay,
    Expression<int>? defaultPaymentAccountId,
    Expression<int>? colorValue,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (issuerBank != null) 'issuer_bank': issuerBank,
      if (creditLimitCents != null) 'credit_limit_cents': creditLimitCents,
      if (closingDay != null) 'closing_day': closingDay,
      if (dueDay != null) 'due_day': dueDay,
      if (defaultPaymentAccountId != null)
        'default_payment_account_id': defaultPaymentAccountId,
      if (colorValue != null) 'color_value': colorValue,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditCardsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? issuerBank,
    Value<int>? creditLimitCents,
    Value<int>? closingDay,
    Value<int>? dueDay,
    Value<int?>? defaultPaymentAccountId,
    Value<int>? colorValue,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return CreditCardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      issuerBank: issuerBank ?? this.issuerBank,
      creditLimitCents: creditLimitCents ?? this.creditLimitCents,
      closingDay: closingDay ?? this.closingDay,
      dueDay: dueDay ?? this.dueDay,
      defaultPaymentAccountId:
          defaultPaymentAccountId ?? this.defaultPaymentAccountId,
      colorValue: colorValue ?? this.colorValue,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (issuerBank.present) {
      map['issuer_bank'] = Variable<String>(issuerBank.value);
    }
    if (creditLimitCents.present) {
      map['credit_limit_cents'] = Variable<int>(creditLimitCents.value);
    }
    if (closingDay.present) {
      map['closing_day'] = Variable<int>(closingDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (defaultPaymentAccountId.present) {
      map['default_payment_account_id'] = Variable<int>(
        defaultPaymentAccountId.value,
      );
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuerBank: $issuerBank, ')
          ..write('creditLimitCents: $creditLimitCents, ')
          ..write('closingDay: $closingDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('defaultPaymentAccountId: $defaultPaymentAccountId, ')
          ..write('colorValue: $colorValue, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardBillsTable extends CreditCardBills
    with TableInfo<$CreditCardBillsTable, CreditCardBillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardBillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_cards (id)',
    ),
  );
  static const VerificationMeta _referenceYearMeta = const VerificationMeta(
    'referenceYear',
  );
  @override
  late final GeneratedColumn<int> referenceYear = GeneratedColumn<int>(
    'reference_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMonthMeta = const VerificationMeta(
    'referenceMonth',
  );
  @override
  late final GeneratedColumn<int> referenceMonth = GeneratedColumn<int>(
    'reference_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closingDateMeta = const VerificationMeta(
    'closingDate',
  );
  @override
  late final GeneratedColumn<DateTime> closingDate = GeneratedColumn<DateTime>(
    'closing_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    referenceYear,
    referenceMonth,
    closingDate,
    dueDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_card_bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardBillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('reference_year')) {
      context.handle(
        _referenceYearMeta,
        referenceYear.isAcceptableOrUnknown(
          data['reference_year']!,
          _referenceYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceYearMeta);
    }
    if (data.containsKey('reference_month')) {
      context.handle(
        _referenceMonthMeta,
        referenceMonth.isAcceptableOrUnknown(
          data['reference_month']!,
          _referenceMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceMonthMeta);
    }
    if (data.containsKey('closing_date')) {
      context.handle(
        _closingDateMeta,
        closingDate.isAcceptableOrUnknown(
          data['closing_date']!,
          _closingDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_closingDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardId, referenceYear, referenceMonth},
  ];
  @override
  CreditCardBillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardBillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_id'],
      )!,
      referenceYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_year'],
      )!,
      referenceMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_month'],
      )!,
      closingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closing_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CreditCardBillsTable createAlias(String alias) {
    return $CreditCardBillsTable(attachedDatabase, alias);
  }
}

class CreditCardBillRow extends DataClass
    implements Insertable<CreditCardBillRow> {
  final int id;
  final int cardId;
  final int referenceYear;
  final int referenceMonth;
  final DateTime closingDate;
  final DateTime dueDate;
  final DateTime createdAt;
  const CreditCardBillRow({
    required this.id,
    required this.cardId,
    required this.referenceYear,
    required this.referenceMonth,
    required this.closingDate,
    required this.dueDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['reference_year'] = Variable<int>(referenceYear);
    map['reference_month'] = Variable<int>(referenceMonth);
    map['closing_date'] = Variable<DateTime>(closingDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditCardBillsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardBillsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      referenceYear: Value(referenceYear),
      referenceMonth: Value(referenceMonth),
      closingDate: Value(closingDate),
      dueDate: Value(dueDate),
      createdAt: Value(createdAt),
    );
  }

  factory CreditCardBillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardBillRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      referenceYear: serializer.fromJson<int>(json['referenceYear']),
      referenceMonth: serializer.fromJson<int>(json['referenceMonth']),
      closingDate: serializer.fromJson<DateTime>(json['closingDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'referenceYear': serializer.toJson<int>(referenceYear),
      'referenceMonth': serializer.toJson<int>(referenceMonth),
      'closingDate': serializer.toJson<DateTime>(closingDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditCardBillRow copyWith({
    int? id,
    int? cardId,
    int? referenceYear,
    int? referenceMonth,
    DateTime? closingDate,
    DateTime? dueDate,
    DateTime? createdAt,
  }) => CreditCardBillRow(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    referenceYear: referenceYear ?? this.referenceYear,
    referenceMonth: referenceMonth ?? this.referenceMonth,
    closingDate: closingDate ?? this.closingDate,
    dueDate: dueDate ?? this.dueDate,
    createdAt: createdAt ?? this.createdAt,
  );
  CreditCardBillRow copyWithCompanion(CreditCardBillsCompanion data) {
    return CreditCardBillRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      referenceYear: data.referenceYear.present
          ? data.referenceYear.value
          : this.referenceYear,
      referenceMonth: data.referenceMonth.present
          ? data.referenceMonth.value
          : this.referenceMonth,
      closingDate: data.closingDate.present
          ? data.closingDate.value
          : this.closingDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('referenceYear: $referenceYear, ')
          ..write('referenceMonth: $referenceMonth, ')
          ..write('closingDate: $closingDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    referenceYear,
    referenceMonth,
    closingDate,
    dueDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardBillRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.referenceYear == this.referenceYear &&
          other.referenceMonth == this.referenceMonth &&
          other.closingDate == this.closingDate &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt);
}

class CreditCardBillsCompanion extends UpdateCompanion<CreditCardBillRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<int> referenceYear;
  final Value<int> referenceMonth;
  final Value<DateTime> closingDate;
  final Value<DateTime> dueDate;
  final Value<DateTime> createdAt;
  const CreditCardBillsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.referenceYear = const Value.absent(),
    this.referenceMonth = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditCardBillsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required int referenceYear,
    required int referenceMonth,
    required DateTime closingDate,
    required DateTime dueDate,
    required DateTime createdAt,
  }) : cardId = Value(cardId),
       referenceYear = Value(referenceYear),
       referenceMonth = Value(referenceMonth),
       closingDate = Value(closingDate),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt);
  static Insertable<CreditCardBillRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<int>? referenceYear,
    Expression<int>? referenceMonth,
    Expression<DateTime>? closingDate,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (referenceYear != null) 'reference_year': referenceYear,
      if (referenceMonth != null) 'reference_month': referenceMonth,
      if (closingDate != null) 'closing_date': closingDate,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditCardBillsCompanion copyWith({
    Value<int>? id,
    Value<int>? cardId,
    Value<int>? referenceYear,
    Value<int>? referenceMonth,
    Value<DateTime>? closingDate,
    Value<DateTime>? dueDate,
    Value<DateTime>? createdAt,
  }) {
    return CreditCardBillsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      referenceYear: referenceYear ?? this.referenceYear,
      referenceMonth: referenceMonth ?? this.referenceMonth,
      closingDate: closingDate ?? this.closingDate,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (referenceYear.present) {
      map['reference_year'] = Variable<int>(referenceYear.value);
    }
    if (referenceMonth.present) {
      map['reference_month'] = Variable<int>(referenceMonth.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<DateTime>(closingDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('referenceYear: $referenceYear, ')
          ..write('referenceMonth: $referenceMonth, ')
          ..write('closingDate: $closingDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardBillPaymentsTable extends CreditCardBillPayments
    with TableInfo<$CreditCardBillPaymentsTable, CreditCardBillPaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardBillPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_card_bills (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    accountId,
    amountCents,
    paidAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_card_bill_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardBillPaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardBillPaymentRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardBillPaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bill_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CreditCardBillPaymentsTable createAlias(String alias) {
    return $CreditCardBillPaymentsTable(attachedDatabase, alias);
  }
}

class CreditCardBillPaymentRow extends DataClass
    implements Insertable<CreditCardBillPaymentRow> {
  final int id;
  final int billId;
  final int accountId;
  final int amountCents;
  final DateTime paidAt;
  final DateTime createdAt;
  const CreditCardBillPaymentRow({
    required this.id,
    required this.billId,
    required this.accountId,
    required this.amountCents,
    required this.paidAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['account_id'] = Variable<int>(accountId);
    map['amount_cents'] = Variable<int>(amountCents);
    map['paid_at'] = Variable<DateTime>(paidAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditCardBillPaymentsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardBillPaymentsCompanion(
      id: Value(id),
      billId: Value(billId),
      accountId: Value(accountId),
      amountCents: Value(amountCents),
      paidAt: Value(paidAt),
      createdAt: Value(createdAt),
    );
  }

  factory CreditCardBillPaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardBillPaymentRow(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      accountId: serializer.fromJson<int>(json['accountId']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'accountId': serializer.toJson<int>(accountId),
      'amountCents': serializer.toJson<int>(amountCents),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditCardBillPaymentRow copyWith({
    int? id,
    int? billId,
    int? accountId,
    int? amountCents,
    DateTime? paidAt,
    DateTime? createdAt,
  }) => CreditCardBillPaymentRow(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    accountId: accountId ?? this.accountId,
    amountCents: amountCents ?? this.amountCents,
    paidAt: paidAt ?? this.paidAt,
    createdAt: createdAt ?? this.createdAt,
  );
  CreditCardBillPaymentRow copyWithCompanion(
    CreditCardBillPaymentsCompanion data,
  ) {
    return CreditCardBillPaymentRow(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillPaymentRow(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('accountId: $accountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, billId, accountId, amountCents, paidAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardBillPaymentRow &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.accountId == this.accountId &&
          other.amountCents == this.amountCents &&
          other.paidAt == this.paidAt &&
          other.createdAt == this.createdAt);
}

class CreditCardBillPaymentsCompanion
    extends UpdateCompanion<CreditCardBillPaymentRow> {
  final Value<int> id;
  final Value<int> billId;
  final Value<int> accountId;
  final Value<int> amountCents;
  final Value<DateTime> paidAt;
  final Value<DateTime> createdAt;
  const CreditCardBillPaymentsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditCardBillPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required int accountId,
    required int amountCents,
    required DateTime paidAt,
    required DateTime createdAt,
  }) : billId = Value(billId),
       accountId = Value(accountId),
       amountCents = Value(amountCents),
       paidAt = Value(paidAt),
       createdAt = Value(createdAt);
  static Insertable<CreditCardBillPaymentRow> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<int>? accountId,
    Expression<int>? amountCents,
    Expression<DateTime>? paidAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (accountId != null) 'account_id': accountId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (paidAt != null) 'paid_at': paidAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditCardBillPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? billId,
    Value<int>? accountId,
    Value<int>? amountCents,
    Value<DateTime>? paidAt,
    Value<DateTime>? createdAt,
  }) {
    return CreditCardBillPaymentsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      accountId: accountId ?? this.accountId,
      amountCents: amountCents ?? this.amountCents,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('accountId: $accountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LedgerEntryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LedgerEntryType>($LedgerEntriesTable.$convertertype);
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _betIdMeta = const VerificationMeta('betId');
  @override
  late final GeneratedColumn<int> betId = GeneratedColumn<int>(
    'bet_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bets (id)',
    ),
  );
  static const VerificationMeta _movementIdMeta = const VerificationMeta(
    'movementId',
  );
  @override
  late final GeneratedColumn<int> movementId = GeneratedColumn<int>(
    'movement_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES movements (id)',
    ),
  );
  static const VerificationMeta _cdbYieldIdMeta = const VerificationMeta(
    'cdbYieldId',
  );
  @override
  late final GeneratedColumn<int> cdbYieldId = GeneratedColumn<int>(
    'cdb_yield_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cdb_yields (id)',
    ),
  );
  static const VerificationMeta _creditCardBillPaymentIdMeta =
      const VerificationMeta('creditCardBillPaymentId');
  @override
  late final GeneratedColumn<int> creditCardBillPaymentId =
      GeneratedColumn<int>(
        'credit_card_bill_payment_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES credit_card_bill_payments (id)',
        ),
      );
  static const VerificationMeta _transferGroupIdMeta = const VerificationMeta(
    'transferGroupId',
  );
  @override
  late final GeneratedColumn<String> transferGroupId = GeneratedColumn<String>(
    'transfer_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    occurredAt,
    type,
    amountCents,
    betId,
    movementId,
    cdbYieldId,
    creditCardBillPaymentId,
    transferGroupId,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('bet_id')) {
      context.handle(
        _betIdMeta,
        betId.isAcceptableOrUnknown(data['bet_id']!, _betIdMeta),
      );
    }
    if (data.containsKey('movement_id')) {
      context.handle(
        _movementIdMeta,
        movementId.isAcceptableOrUnknown(data['movement_id']!, _movementIdMeta),
      );
    }
    if (data.containsKey('cdb_yield_id')) {
      context.handle(
        _cdbYieldIdMeta,
        cdbYieldId.isAcceptableOrUnknown(
          data['cdb_yield_id']!,
          _cdbYieldIdMeta,
        ),
      );
    }
    if (data.containsKey('credit_card_bill_payment_id')) {
      context.handle(
        _creditCardBillPaymentIdMeta,
        creditCardBillPaymentId.isAcceptableOrUnknown(
          data['credit_card_bill_payment_id']!,
          _creditCardBillPaymentIdMeta,
        ),
      );
    }
    if (data.containsKey('transfer_group_id')) {
      context.handle(
        _transferGroupIdMeta,
        transferGroupId.isAcceptableOrUnknown(
          data['transfer_group_id']!,
          _transferGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      type: $LedgerEntriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      betId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bet_id'],
      ),
      movementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}movement_id'],
      ),
      cdbYieldId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cdb_yield_id'],
      ),
      creditCardBillPaymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_card_bill_payment_id'],
      ),
      transferGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_group_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LedgerEntryType, String, String> $convertertype =
      const EnumNameConverter<LedgerEntryType>(LedgerEntryType.values);
}

class LedgerEntryRow extends DataClass implements Insertable<LedgerEntryRow> {
  final int id;
  final int accountId;
  final DateTime occurredAt;
  final LedgerEntryType type;

  /// Valor com sinal: positivo credita a conta, negativo debita.
  final int amountCents;
  final int? betId;
  final int? movementId;
  final int? cdbYieldId;
  final int? creditCardBillPaymentId;

  /// Agrupa as duas pontas (débito/crédito) de uma transferência.
  final String? transferGroupId;
  final String? description;
  final DateTime createdAt;
  const LedgerEntryRow({
    required this.id,
    required this.accountId,
    required this.occurredAt,
    required this.type,
    required this.amountCents,
    this.betId,
    this.movementId,
    this.cdbYieldId,
    this.creditCardBillPaymentId,
    this.transferGroupId,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    {
      map['type'] = Variable<String>(
        $LedgerEntriesTable.$convertertype.toSql(type),
      );
    }
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || betId != null) {
      map['bet_id'] = Variable<int>(betId);
    }
    if (!nullToAbsent || movementId != null) {
      map['movement_id'] = Variable<int>(movementId);
    }
    if (!nullToAbsent || cdbYieldId != null) {
      map['cdb_yield_id'] = Variable<int>(cdbYieldId);
    }
    if (!nullToAbsent || creditCardBillPaymentId != null) {
      map['credit_card_bill_payment_id'] = Variable<int>(
        creditCardBillPaymentId,
      );
    }
    if (!nullToAbsent || transferGroupId != null) {
      map['transfer_group_id'] = Variable<String>(transferGroupId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      occurredAt: Value(occurredAt),
      type: Value(type),
      amountCents: Value(amountCents),
      betId: betId == null && nullToAbsent
          ? const Value.absent()
          : Value(betId),
      movementId: movementId == null && nullToAbsent
          ? const Value.absent()
          : Value(movementId),
      cdbYieldId: cdbYieldId == null && nullToAbsent
          ? const Value.absent()
          : Value(cdbYieldId),
      creditCardBillPaymentId: creditCardBillPaymentId == null && nullToAbsent
          ? const Value.absent()
          : Value(creditCardBillPaymentId),
      transferGroupId: transferGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferGroupId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory LedgerEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerEntryRow(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      type: $LedgerEntriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      betId: serializer.fromJson<int?>(json['betId']),
      movementId: serializer.fromJson<int?>(json['movementId']),
      cdbYieldId: serializer.fromJson<int?>(json['cdbYieldId']),
      creditCardBillPaymentId: serializer.fromJson<int?>(
        json['creditCardBillPaymentId'],
      ),
      transferGroupId: serializer.fromJson<String?>(json['transferGroupId']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'type': serializer.toJson<String>(
        $LedgerEntriesTable.$convertertype.toJson(type),
      ),
      'amountCents': serializer.toJson<int>(amountCents),
      'betId': serializer.toJson<int?>(betId),
      'movementId': serializer.toJson<int?>(movementId),
      'cdbYieldId': serializer.toJson<int?>(cdbYieldId),
      'creditCardBillPaymentId': serializer.toJson<int?>(
        creditCardBillPaymentId,
      ),
      'transferGroupId': serializer.toJson<String?>(transferGroupId),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LedgerEntryRow copyWith({
    int? id,
    int? accountId,
    DateTime? occurredAt,
    LedgerEntryType? type,
    int? amountCents,
    Value<int?> betId = const Value.absent(),
    Value<int?> movementId = const Value.absent(),
    Value<int?> cdbYieldId = const Value.absent(),
    Value<int?> creditCardBillPaymentId = const Value.absent(),
    Value<String?> transferGroupId = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => LedgerEntryRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    occurredAt: occurredAt ?? this.occurredAt,
    type: type ?? this.type,
    amountCents: amountCents ?? this.amountCents,
    betId: betId.present ? betId.value : this.betId,
    movementId: movementId.present ? movementId.value : this.movementId,
    cdbYieldId: cdbYieldId.present ? cdbYieldId.value : this.cdbYieldId,
    creditCardBillPaymentId: creditCardBillPaymentId.present
        ? creditCardBillPaymentId.value
        : this.creditCardBillPaymentId,
    transferGroupId: transferGroupId.present
        ? transferGroupId.value
        : this.transferGroupId,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  LedgerEntryRow copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerEntryRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      type: data.type.present ? data.type.value : this.type,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      betId: data.betId.present ? data.betId.value : this.betId,
      movementId: data.movementId.present
          ? data.movementId.value
          : this.movementId,
      cdbYieldId: data.cdbYieldId.present
          ? data.cdbYieldId.value
          : this.cdbYieldId,
      creditCardBillPaymentId: data.creditCardBillPaymentId.present
          ? data.creditCardBillPaymentId.value
          : this.creditCardBillPaymentId,
      transferGroupId: data.transferGroupId.present
          ? data.transferGroupId.value
          : this.transferGroupId,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntryRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('type: $type, ')
          ..write('amountCents: $amountCents, ')
          ..write('betId: $betId, ')
          ..write('movementId: $movementId, ')
          ..write('cdbYieldId: $cdbYieldId, ')
          ..write('creditCardBillPaymentId: $creditCardBillPaymentId, ')
          ..write('transferGroupId: $transferGroupId, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    occurredAt,
    type,
    amountCents,
    betId,
    movementId,
    cdbYieldId,
    creditCardBillPaymentId,
    transferGroupId,
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerEntryRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.occurredAt == this.occurredAt &&
          other.type == this.type &&
          other.amountCents == this.amountCents &&
          other.betId == this.betId &&
          other.movementId == this.movementId &&
          other.cdbYieldId == this.cdbYieldId &&
          other.creditCardBillPaymentId == this.creditCardBillPaymentId &&
          other.transferGroupId == this.transferGroupId &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerEntryRow> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<DateTime> occurredAt;
  final Value<LedgerEntryType> type;
  final Value<int> amountCents;
  final Value<int?> betId;
  final Value<int?> movementId;
  final Value<int?> cdbYieldId;
  final Value<int?> creditCardBillPaymentId;
  final Value<String?> transferGroupId;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const LedgerEntriesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.type = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.betId = const Value.absent(),
    this.movementId = const Value.absent(),
    this.cdbYieldId = const Value.absent(),
    this.creditCardBillPaymentId = const Value.absent(),
    this.transferGroupId = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required DateTime occurredAt,
    required LedgerEntryType type,
    required int amountCents,
    this.betId = const Value.absent(),
    this.movementId = const Value.absent(),
    this.cdbYieldId = const Value.absent(),
    this.creditCardBillPaymentId = const Value.absent(),
    this.transferGroupId = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime createdAt,
  }) : accountId = Value(accountId),
       occurredAt = Value(occurredAt),
       type = Value(type),
       amountCents = Value(amountCents),
       createdAt = Value(createdAt);
  static Insertable<LedgerEntryRow> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<DateTime>? occurredAt,
    Expression<String>? type,
    Expression<int>? amountCents,
    Expression<int>? betId,
    Expression<int>? movementId,
    Expression<int>? cdbYieldId,
    Expression<int>? creditCardBillPaymentId,
    Expression<String>? transferGroupId,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (type != null) 'type': type,
      if (amountCents != null) 'amount_cents': amountCents,
      if (betId != null) 'bet_id': betId,
      if (movementId != null) 'movement_id': movementId,
      if (cdbYieldId != null) 'cdb_yield_id': cdbYieldId,
      if (creditCardBillPaymentId != null)
        'credit_card_bill_payment_id': creditCardBillPaymentId,
      if (transferGroupId != null) 'transfer_group_id': transferGroupId,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LedgerEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<DateTime>? occurredAt,
    Value<LedgerEntryType>? type,
    Value<int>? amountCents,
    Value<int?>? betId,
    Value<int?>? movementId,
    Value<int?>? cdbYieldId,
    Value<int?>? creditCardBillPaymentId,
    Value<String?>? transferGroupId,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return LedgerEntriesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      occurredAt: occurredAt ?? this.occurredAt,
      type: type ?? this.type,
      amountCents: amountCents ?? this.amountCents,
      betId: betId ?? this.betId,
      movementId: movementId ?? this.movementId,
      cdbYieldId: cdbYieldId ?? this.cdbYieldId,
      creditCardBillPaymentId:
          creditCardBillPaymentId ?? this.creditCardBillPaymentId,
      transferGroupId: transferGroupId ?? this.transferGroupId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $LedgerEntriesTable.$convertertype.toSql(type.value),
      );
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (betId.present) {
      map['bet_id'] = Variable<int>(betId.value);
    }
    if (movementId.present) {
      map['movement_id'] = Variable<int>(movementId.value);
    }
    if (cdbYieldId.present) {
      map['cdb_yield_id'] = Variable<int>(cdbYieldId.value);
    }
    if (creditCardBillPaymentId.present) {
      map['credit_card_bill_payment_id'] = Variable<int>(
        creditCardBillPaymentId.value,
      );
    }
    if (transferGroupId.present) {
      map['transfer_group_id'] = Variable<String>(transferGroupId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('type: $type, ')
          ..write('amountCents: $amountCents, ')
          ..write('betId: $betId, ')
          ..write('movementId: $movementId, ')
          ..write('cdbYieldId: $cdbYieldId, ')
          ..write('creditCardBillPaymentId: $creditCardBillPaymentId, ')
          ..write('transferGroupId: $transferGroupId, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardTransactionsTable extends CardTransactions
    with TableInfo<$CardTransactionsTable, CardTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_cards (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CardTransactionType, String>
  type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<CardTransactionType>($CardTransactionsTable.$convertertype);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountCentsMeta = const VerificationMeta(
    'totalAmountCents',
  );
  @override
  late final GeneratedColumn<int> totalAmountCents = GeneratedColumn<int>(
    'total_amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id)',
    ),
  );
  static const VerificationMeta _installmentsCountMeta = const VerificationMeta(
    'installmentsCount',
  );
  @override
  late final GeneratedColumn<int> installmentsCount = GeneratedColumn<int>(
    'installments_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    type,
    description,
    totalAmountCents,
    purchaseDate,
    categoryId,
    installmentsCount,
    isRecurring,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('total_amount_cents')) {
      context.handle(
        _totalAmountCentsMeta,
        totalAmountCents.isAcceptableOrUnknown(
          data['total_amount_cents']!,
          _totalAmountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountCentsMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('installments_count')) {
      context.handle(
        _installmentsCountMeta,
        installmentsCount.isAcceptableOrUnknown(
          data['installments_count']!,
          _installmentsCountMeta,
        ),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_id'],
      )!,
      type: $CardTransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      totalAmountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount_cents'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      installmentsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installments_count'],
      )!,
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CardTransactionsTable createAlias(String alias) {
    return $CardTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CardTransactionType, String, String>
  $convertertype = const EnumNameConverter<CardTransactionType>(
    CardTransactionType.values,
  );
}

class CardTransactionRow extends DataClass
    implements Insertable<CardTransactionRow> {
  final int id;
  final int cardId;
  final CardTransactionType type;
  final String description;
  final int totalAmountCents;
  final DateTime purchaseDate;
  final int? categoryId;
  final int installmentsCount;
  final bool isRecurring;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CardTransactionRow({
    required this.id,
    required this.cardId,
    required this.type,
    required this.description,
    required this.totalAmountCents,
    required this.purchaseDate,
    this.categoryId,
    required this.installmentsCount,
    required this.isRecurring,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    {
      map['type'] = Variable<String>(
        $CardTransactionsTable.$convertertype.toSql(type),
      );
    }
    map['description'] = Variable<String>(description);
    map['total_amount_cents'] = Variable<int>(totalAmountCents);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['installments_count'] = Variable<int>(installmentsCount);
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardTransactionsCompanion toCompanion(bool nullToAbsent) {
    return CardTransactionsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      type: Value(type),
      description: Value(description),
      totalAmountCents: Value(totalAmountCents),
      purchaseDate: Value(purchaseDate),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      installmentsCount: Value(installmentsCount),
      isRecurring: Value(isRecurring),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardTransactionRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      type: $CardTransactionsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      description: serializer.fromJson<String>(json['description']),
      totalAmountCents: serializer.fromJson<int>(json['totalAmountCents']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      installmentsCount: serializer.fromJson<int>(json['installmentsCount']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'type': serializer.toJson<String>(
        $CardTransactionsTable.$convertertype.toJson(type),
      ),
      'description': serializer.toJson<String>(description),
      'totalAmountCents': serializer.toJson<int>(totalAmountCents),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'categoryId': serializer.toJson<int?>(categoryId),
      'installmentsCount': serializer.toJson<int>(installmentsCount),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CardTransactionRow copyWith({
    int? id,
    int? cardId,
    CardTransactionType? type,
    String? description,
    int? totalAmountCents,
    DateTime? purchaseDate,
    Value<int?> categoryId = const Value.absent(),
    int? installmentsCount,
    bool? isRecurring,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CardTransactionRow(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    type: type ?? this.type,
    description: description ?? this.description,
    totalAmountCents: totalAmountCents ?? this.totalAmountCents,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    installmentsCount: installmentsCount ?? this.installmentsCount,
    isRecurring: isRecurring ?? this.isRecurring,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CardTransactionRow copyWithCompanion(CardTransactionsCompanion data) {
    return CardTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      totalAmountCents: data.totalAmountCents.present
          ? data.totalAmountCents.value
          : this.totalAmountCents,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      installmentsCount: data.installmentsCount.present
          ? data.installmentsCount.value
          : this.installmentsCount,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardTransactionRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('totalAmountCents: $totalAmountCents, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('installmentsCount: $installmentsCount, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    type,
    description,
    totalAmountCents,
    purchaseDate,
    categoryId,
    installmentsCount,
    isRecurring,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardTransactionRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.type == this.type &&
          other.description == this.description &&
          other.totalAmountCents == this.totalAmountCents &&
          other.purchaseDate == this.purchaseDate &&
          other.categoryId == this.categoryId &&
          other.installmentsCount == this.installmentsCount &&
          other.isRecurring == this.isRecurring &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardTransactionsCompanion extends UpdateCompanion<CardTransactionRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<CardTransactionType> type;
  final Value<String> description;
  final Value<int> totalAmountCents;
  final Value<DateTime> purchaseDate;
  final Value<int?> categoryId;
  final Value<int> installmentsCount;
  final Value<bool> isRecurring;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CardTransactionsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.totalAmountCents = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.installmentsCount = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required CardTransactionType type,
    required String description,
    required int totalAmountCents,
    required DateTime purchaseDate,
    this.categoryId = const Value.absent(),
    this.installmentsCount = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : cardId = Value(cardId),
       type = Value(type),
       description = Value(description),
       totalAmountCents = Value(totalAmountCents),
       purchaseDate = Value(purchaseDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CardTransactionRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? type,
    Expression<String>? description,
    Expression<int>? totalAmountCents,
    Expression<DateTime>? purchaseDate,
    Expression<int>? categoryId,
    Expression<int>? installmentsCount,
    Expression<bool>? isRecurring,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (totalAmountCents != null) 'total_amount_cents': totalAmountCents,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (categoryId != null) 'category_id': categoryId,
      if (installmentsCount != null) 'installments_count': installmentsCount,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? cardId,
    Value<CardTransactionType>? type,
    Value<String>? description,
    Value<int>? totalAmountCents,
    Value<DateTime>? purchaseDate,
    Value<int?>? categoryId,
    Value<int>? installmentsCount,
    Value<bool>? isRecurring,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CardTransactionsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      type: type ?? this.type,
      description: description ?? this.description,
      totalAmountCents: totalAmountCents ?? this.totalAmountCents,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      categoryId: categoryId ?? this.categoryId,
      installmentsCount: installmentsCount ?? this.installmentsCount,
      isRecurring: isRecurring ?? this.isRecurring,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CardTransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (totalAmountCents.present) {
      map['total_amount_cents'] = Variable<int>(totalAmountCents.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (installmentsCount.present) {
      map['installments_count'] = Variable<int>(installmentsCount.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('totalAmountCents: $totalAmountCents, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('installmentsCount: $installmentsCount, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CardInstallmentsTable extends CardInstallments
    with TableInfo<$CardInstallmentsTable, CardInstallmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardInstallmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cardTransactionIdMeta = const VerificationMeta(
    'cardTransactionId',
  );
  @override
  late final GeneratedColumn<int> cardTransactionId = GeneratedColumn<int>(
    'card_transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES card_transactions (id)',
    ),
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_card_bills (id)',
    ),
  );
  static const VerificationMeta _installmentNumberMeta = const VerificationMeta(
    'installmentNumber',
  );
  @override
  late final GeneratedColumn<int> installmentNumber = GeneratedColumn<int>(
    'installment_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalInstallmentsMeta = const VerificationMeta(
    'totalInstallments',
  );
  @override
  late final GeneratedColumn<int> totalInstallments = GeneratedColumn<int>(
    'total_installments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardTransactionId,
    billId,
    installmentNumber,
    totalInstallments,
    amountCents,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_installments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardInstallmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_transaction_id')) {
      context.handle(
        _cardTransactionIdMeta,
        cardTransactionId.isAcceptableOrUnknown(
          data['card_transaction_id']!,
          _cardTransactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cardTransactionIdMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('installment_number')) {
      context.handle(
        _installmentNumberMeta,
        installmentNumber.isAcceptableOrUnknown(
          data['installment_number']!,
          _installmentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentNumberMeta);
    }
    if (data.containsKey('total_installments')) {
      context.handle(
        _totalInstallmentsMeta,
        totalInstallments.isAcceptableOrUnknown(
          data['total_installments']!,
          _totalInstallmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalInstallmentsMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardInstallmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardInstallmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cardTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_transaction_id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bill_id'],
      )!,
      installmentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_number'],
      )!,
      totalInstallments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_installments'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CardInstallmentsTable createAlias(String alias) {
    return $CardInstallmentsTable(attachedDatabase, alias);
  }
}

class CardInstallmentRow extends DataClass
    implements Insertable<CardInstallmentRow> {
  final int id;
  final int cardTransactionId;
  final int billId;
  final int installmentNumber;
  final int totalInstallments;

  /// Valor desta parcela específica (a última parcela absorve o
  /// arredondamento para que a soma bata exatamente com o total da compra).
  final int amountCents;
  final DateTime createdAt;
  const CardInstallmentRow({
    required this.id,
    required this.cardTransactionId,
    required this.billId,
    required this.installmentNumber,
    required this.totalInstallments,
    required this.amountCents,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_transaction_id'] = Variable<int>(cardTransactionId);
    map['bill_id'] = Variable<int>(billId);
    map['installment_number'] = Variable<int>(installmentNumber);
    map['total_installments'] = Variable<int>(totalInstallments);
    map['amount_cents'] = Variable<int>(amountCents);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CardInstallmentsCompanion toCompanion(bool nullToAbsent) {
    return CardInstallmentsCompanion(
      id: Value(id),
      cardTransactionId: Value(cardTransactionId),
      billId: Value(billId),
      installmentNumber: Value(installmentNumber),
      totalInstallments: Value(totalInstallments),
      amountCents: Value(amountCents),
      createdAt: Value(createdAt),
    );
  }

  factory CardInstallmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardInstallmentRow(
      id: serializer.fromJson<int>(json['id']),
      cardTransactionId: serializer.fromJson<int>(json['cardTransactionId']),
      billId: serializer.fromJson<int>(json['billId']),
      installmentNumber: serializer.fromJson<int>(json['installmentNumber']),
      totalInstallments: serializer.fromJson<int>(json['totalInstallments']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardTransactionId': serializer.toJson<int>(cardTransactionId),
      'billId': serializer.toJson<int>(billId),
      'installmentNumber': serializer.toJson<int>(installmentNumber),
      'totalInstallments': serializer.toJson<int>(totalInstallments),
      'amountCents': serializer.toJson<int>(amountCents),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CardInstallmentRow copyWith({
    int? id,
    int? cardTransactionId,
    int? billId,
    int? installmentNumber,
    int? totalInstallments,
    int? amountCents,
    DateTime? createdAt,
  }) => CardInstallmentRow(
    id: id ?? this.id,
    cardTransactionId: cardTransactionId ?? this.cardTransactionId,
    billId: billId ?? this.billId,
    installmentNumber: installmentNumber ?? this.installmentNumber,
    totalInstallments: totalInstallments ?? this.totalInstallments,
    amountCents: amountCents ?? this.amountCents,
    createdAt: createdAt ?? this.createdAt,
  );
  CardInstallmentRow copyWithCompanion(CardInstallmentsCompanion data) {
    return CardInstallmentRow(
      id: data.id.present ? data.id.value : this.id,
      cardTransactionId: data.cardTransactionId.present
          ? data.cardTransactionId.value
          : this.cardTransactionId,
      billId: data.billId.present ? data.billId.value : this.billId,
      installmentNumber: data.installmentNumber.present
          ? data.installmentNumber.value
          : this.installmentNumber,
      totalInstallments: data.totalInstallments.present
          ? data.totalInstallments.value
          : this.totalInstallments,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardInstallmentRow(')
          ..write('id: $id, ')
          ..write('cardTransactionId: $cardTransactionId, ')
          ..write('billId: $billId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('totalInstallments: $totalInstallments, ')
          ..write('amountCents: $amountCents, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardTransactionId,
    billId,
    installmentNumber,
    totalInstallments,
    amountCents,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardInstallmentRow &&
          other.id == this.id &&
          other.cardTransactionId == this.cardTransactionId &&
          other.billId == this.billId &&
          other.installmentNumber == this.installmentNumber &&
          other.totalInstallments == this.totalInstallments &&
          other.amountCents == this.amountCents &&
          other.createdAt == this.createdAt);
}

class CardInstallmentsCompanion extends UpdateCompanion<CardInstallmentRow> {
  final Value<int> id;
  final Value<int> cardTransactionId;
  final Value<int> billId;
  final Value<int> installmentNumber;
  final Value<int> totalInstallments;
  final Value<int> amountCents;
  final Value<DateTime> createdAt;
  const CardInstallmentsCompanion({
    this.id = const Value.absent(),
    this.cardTransactionId = const Value.absent(),
    this.billId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.totalInstallments = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CardInstallmentsCompanion.insert({
    this.id = const Value.absent(),
    required int cardTransactionId,
    required int billId,
    required int installmentNumber,
    required int totalInstallments,
    required int amountCents,
    required DateTime createdAt,
  }) : cardTransactionId = Value(cardTransactionId),
       billId = Value(billId),
       installmentNumber = Value(installmentNumber),
       totalInstallments = Value(totalInstallments),
       amountCents = Value(amountCents),
       createdAt = Value(createdAt);
  static Insertable<CardInstallmentRow> custom({
    Expression<int>? id,
    Expression<int>? cardTransactionId,
    Expression<int>? billId,
    Expression<int>? installmentNumber,
    Expression<int>? totalInstallments,
    Expression<int>? amountCents,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardTransactionId != null) 'card_transaction_id': cardTransactionId,
      if (billId != null) 'bill_id': billId,
      if (installmentNumber != null) 'installment_number': installmentNumber,
      if (totalInstallments != null) 'total_installments': totalInstallments,
      if (amountCents != null) 'amount_cents': amountCents,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CardInstallmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? cardTransactionId,
    Value<int>? billId,
    Value<int>? installmentNumber,
    Value<int>? totalInstallments,
    Value<int>? amountCents,
    Value<DateTime>? createdAt,
  }) {
    return CardInstallmentsCompanion(
      id: id ?? this.id,
      cardTransactionId: cardTransactionId ?? this.cardTransactionId,
      billId: billId ?? this.billId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      totalInstallments: totalInstallments ?? this.totalInstallments,
      amountCents: amountCents ?? this.amountCents,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardTransactionId.present) {
      map['card_transaction_id'] = Variable<int>(cardTransactionId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (installmentNumber.present) {
      map['installment_number'] = Variable<int>(installmentNumber.value);
    }
    if (totalInstallments.present) {
      map['total_installments'] = Variable<int>(totalInstallments.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardInstallmentsCompanion(')
          ..write('id: $id, ')
          ..write('cardTransactionId: $cardTransactionId, ')
          ..write('billId: $billId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('totalInstallments: $totalInstallments, ')
          ..write('amountCents: $amountCents, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $BetsTable bets = $BetsTable(this);
  late final $BetLegsTable betLegs = $BetLegsTable(this);
  late final $FinancialCategoriesTable financialCategories =
      $FinancialCategoriesTable(this);
  late final $BillsPayableTable billsPayable = $BillsPayableTable(this);
  late final $BillsReceivableTable billsReceivable = $BillsReceivableTable(
    this,
  );
  late final $MovementsTable movements = $MovementsTable(this);
  late final $CdbYieldsTable cdbYields = $CdbYieldsTable(this);
  late final $CreditCardsTable creditCards = $CreditCardsTable(this);
  late final $CreditCardBillsTable creditCardBills = $CreditCardBillsTable(
    this,
  );
  late final $CreditCardBillPaymentsTable creditCardBillPayments =
      $CreditCardBillPaymentsTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $CardTransactionsTable cardTransactions = $CardTransactionsTable(
    this,
  );
  late final $CardInstallmentsTable cardInstallments = $CardInstallmentsTable(
    this,
  );
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final BetsDao betsDao = BetsDao(this as AppDatabase);
  late final BetLegsDao betLegsDao = BetLegsDao(this as AppDatabase);
  late final MovementsDao movementsDao = MovementsDao(this as AppDatabase);
  late final LedgerDao ledgerDao = LedgerDao(this as AppDatabase);
  late final CdbYieldsDao cdbYieldsDao = CdbYieldsDao(this as AppDatabase);
  late final FinancialCategoriesDao financialCategoriesDao =
      FinancialCategoriesDao(this as AppDatabase);
  late final CreditCardsDao creditCardsDao = CreditCardsDao(
    this as AppDatabase,
  );
  late final CreditCardBillsDao creditCardBillsDao = CreditCardBillsDao(
    this as AppDatabase,
  );
  late final CardTransactionsDao cardTransactionsDao = CardTransactionsDao(
    this as AppDatabase,
  );
  late final CardInstallmentsDao cardInstallmentsDao = CardInstallmentsDao(
    this as AppDatabase,
  );
  late final CreditCardBillPaymentsDao creditCardBillPaymentsDao =
      CreditCardBillPaymentsDao(this as AppDatabase);
  late final BillsPayableDao billsPayableDao = BillsPayableDao(
    this as AppDatabase,
  );
  late final BillsReceivableDao billsReceivableDao = BillsReceivableDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    bets,
    betLegs,
    financialCategories,
    billsPayable,
    billsReceivable,
    movements,
    cdbYields,
    creditCards,
    creditCardBills,
    creditCardBillPayments,
    ledgerEntries,
    cardTransactions,
    cardInstallments,
  ];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required String name,
  required AccountType type,
  Value<String?> institution,
  Value<int> initialBalanceCents,
  required DateTime createdAt,
  Value<bool> isArchived,
  Value<double?> cdiPercent,
  Value<CdbAccountingType?> cdbAccountingType,
  Value<DateTime?> cdbTrackingStartDate,
  Value<int> cdbAccumulatedBeforeTrackingCents,
  Value<BankAccountKind?> bankAccountKind,
  Value<int?> colorValue,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<AccountType> type,
  Value<String?> institution,
  Value<int> initialBalanceCents,
  Value<DateTime> createdAt,
  Value<bool> isArchived,
  Value<double?> cdiPercent,
  Value<CdbAccountingType?> cdbAccountingType,
  Value<DateTime?> cdbTrackingStartDate,
  Value<int> cdbAccumulatedBeforeTrackingCents,
  Value<BankAccountKind?> bankAccountKind,
  Value<int?> colorValue,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, AccountRow> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BetsTable, List<BetRow>> _betsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bets,
    aliasName: 'accounts__id__bets__account_id',
  );

  $$BetsTableProcessedTableManager get betsRefs {
    final manager = $$BetsTableTableManager(
      $_db,
      $_db.bets,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_betsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillsPayableTable, List<BillPayableRow>>
  _billsPayableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsPayable,
    aliasName: 'accounts__id__bills_payable__account_id',
  );

  $$BillsPayableTableProcessedTableManager get billsPayableRefs {
    final manager = $$BillsPayableTableTableManager(
      $_db,
      $_db.billsPayable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsPayableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillsReceivableTable, List<BillReceivableRow>>
  _billsReceivableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsReceivable,
    aliasName: 'accounts__id__bills_receivable__account_id',
  );

  $$BillsReceivableTableProcessedTableManager get billsReceivableRefs {
    final manager = $$BillsReceivableTableTableManager(
      $_db,
      $_db.billsReceivable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billsReceivableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CdbYieldsTable, List<CdbYieldRow>>
  _cdbYieldsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cdbYields,
    aliasName: 'accounts__id__cdb_yields__account_id',
  );

  $$CdbYieldsTableProcessedTableManager get cdbYieldsRefs {
    final manager = $$CdbYieldsTableTableManager(
      $_db,
      $_db.cdbYields,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cdbYieldsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CreditCardsTable, List<CreditCardRow>>
  _creditCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditCards,
    aliasName: 'accounts__id__credit_cards__default_payment_account_id',
  );

  $$CreditCardsTableProcessedTableManager get creditCardsRefs {
    final manager = $$CreditCardsTableTableManager($_db, $_db.creditCards)
        .filter(
          (f) =>
              f.defaultPaymentAccountId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_creditCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CreditCardBillPaymentsTable,
    List<CreditCardBillPaymentRow>
  >
  _creditCardBillPaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.creditCardBillPayments,
        aliasName: 'accounts__id__credit_card_bill_payments__account_id',
      );

  $$CreditCardBillPaymentsTableProcessedTableManager
  get creditCardBillPaymentsRefs {
    final manager = $$CreditCardBillPaymentsTableTableManager(
      $_db,
      $_db.creditCardBillPayments,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardBillPaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LedgerEntriesTable, List<LedgerEntryRow>>
  _ledgerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ledgerEntries,
    aliasName: 'accounts__id__ledger_entries__account_id',
  );

  $$LedgerEntriesTableProcessedTableManager get ledgerEntriesRefs {
    final manager = $$LedgerEntriesTableTableManager(
      $_db,
      $_db.ledgerEntries,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ledgerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountType, AccountType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialBalanceCents => $composableBuilder(
    column: $table.initialBalanceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cdiPercent => $composableBuilder(
    column: $table.cdiPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CdbAccountingType?, CdbAccountingType, String>
  get cdbAccountingType => $composableBuilder(
    column: $table.cdbAccountingType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get cdbTrackingStartDate => $composableBuilder(
    column: $table.cdbTrackingStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cdbAccumulatedBeforeTrackingCents =>
      $composableBuilder(
        column: $table.cdbAccumulatedBeforeTrackingCents,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<BankAccountKind?, BankAccountKind, String>
  get bankAccountKind => $composableBuilder(
    column: $table.bankAccountKind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> betsRefs(
    Expression<bool> Function($$BetsTableFilterComposer f) f,
  ) {
    final $$BetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableFilterComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> billsPayableRefs(
    Expression<bool> Function($$BillsPayableTableFilterComposer f) f,
  ) {
    final $$BillsPayableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableFilterComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> billsReceivableRefs(
    Expression<bool> Function($$BillsReceivableTableFilterComposer f) f,
  ) {
    final $$BillsReceivableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableFilterComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cdbYieldsRefs(
    Expression<bool> Function($$CdbYieldsTableFilterComposer f) f,
  ) {
    final $$CdbYieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cdbYields,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CdbYieldsTableFilterComposer(
            $db: $db,
            $table: $db.cdbYields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardsRefs(
    Expression<bool> Function($$CreditCardsTableFilterComposer f) f,
  ) {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.defaultPaymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardBillPaymentsRefs(
    Expression<bool> Function($$CreditCardBillPaymentsTableFilterComposer f) f,
  ) {
    final $$CreditCardBillPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> ledgerEntriesRefs(
    Expression<bool> Function($$LedgerEntriesTableFilterComposer f) f,
  ) {
    final $$LedgerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialBalanceCents => $composableBuilder(
    column: $table.initialBalanceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cdiPercent => $composableBuilder(
    column: $table.cdiPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cdbAccountingType => $composableBuilder(
    column: $table.cdbAccountingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cdbTrackingStartDate => $composableBuilder(
    column: $table.cdbTrackingStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cdbAccumulatedBeforeTrackingCents =>
      $composableBuilder(
        column: $table.cdbAccumulatedBeforeTrackingCents,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get bankAccountKind => $composableBuilder(
    column: $table.bankAccountKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialBalanceCents => $composableBuilder(
    column: $table.initialBalanceCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cdiPercent => $composableBuilder(
    column: $table.cdiPercent,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CdbAccountingType?, String>
  get cdbAccountingType => $composableBuilder(
    column: $table.cdbAccountingType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cdbTrackingStartDate => $composableBuilder(
    column: $table.cdbTrackingStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cdbAccumulatedBeforeTrackingCents =>
      $composableBuilder(
        column: $table.cdbAccumulatedBeforeTrackingCents,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<BankAccountKind?, String>
  get bankAccountKind => $composableBuilder(
    column: $table.bankAccountKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  Expression<T> betsRefs<T extends Object>(
    Expression<T> Function($$BetsTableAnnotationComposer a) f,
  ) {
    final $$BetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableAnnotationComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> billsPayableRefs<T extends Object>(
    Expression<T> Function($$BillsPayableTableAnnotationComposer a) f,
  ) {
    final $$BillsPayableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> billsReceivableRefs<T extends Object>(
    Expression<T> Function($$BillsReceivableTableAnnotationComposer a) f,
  ) {
    final $$BillsReceivableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cdbYieldsRefs<T extends Object>(
    Expression<T> Function($$CdbYieldsTableAnnotationComposer a) f,
  ) {
    final $$CdbYieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cdbYields,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CdbYieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.cdbYields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardsRefs<T extends Object>(
    Expression<T> Function($$CreditCardsTableAnnotationComposer a) f,
  ) {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.defaultPaymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardBillPaymentsRefs<T extends Object>(
    Expression<T> Function($$CreditCardBillPaymentsTableAnnotationComposer a) f,
  ) {
    final $$CreditCardBillPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> ledgerEntriesRefs<T extends Object>(
    Expression<T> Function($$LedgerEntriesTableAnnotationComposer a) f,
  ) {
    final $$LedgerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (AccountRow, $$AccountsTableReferences),
          AccountRow,
          PrefetchHooks Function({
            bool betsRefs,
            bool billsPayableRefs,
            bool billsReceivableRefs,
            bool cdbYieldsRefs,
            bool creditCardsRefs,
            bool creditCardBillPaymentsRefs,
            bool ledgerEntriesRefs,
          })
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<AccountType> type = const Value.absent(),
                Value<String?> institution = const Value.absent(),
                Value<int> initialBalanceCents = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<double?> cdiPercent = const Value.absent(),
                Value<CdbAccountingType?> cdbAccountingType =
                    const Value.absent(),
                Value<DateTime?> cdbTrackingStartDate = const Value.absent(),
                Value<int> cdbAccumulatedBeforeTrackingCents =
                    const Value.absent(),
                Value<BankAccountKind?> bankAccountKind = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                type: type,
                institution: institution,
                initialBalanceCents: initialBalanceCents,
                createdAt: createdAt,
                isArchived: isArchived,
                cdiPercent: cdiPercent,
                cdbAccountingType: cdbAccountingType,
                cdbTrackingStartDate: cdbTrackingStartDate,
                cdbAccumulatedBeforeTrackingCents:
                    cdbAccumulatedBeforeTrackingCents,
                bankAccountKind: bankAccountKind,
                colorValue: colorValue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required AccountType type,
                Value<String?> institution = const Value.absent(),
                Value<int> initialBalanceCents = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isArchived = const Value.absent(),
                Value<double?> cdiPercent = const Value.absent(),
                Value<CdbAccountingType?> cdbAccountingType =
                    const Value.absent(),
                Value<DateTime?> cdbTrackingStartDate = const Value.absent(),
                Value<int> cdbAccumulatedBeforeTrackingCents =
                    const Value.absent(),
                Value<BankAccountKind?> bankAccountKind = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                type: type,
                institution: institution,
                initialBalanceCents: initialBalanceCents,
                createdAt: createdAt,
                isArchived: isArchived,
                cdiPercent: cdiPercent,
                cdbAccountingType: cdbAccountingType,
                cdbTrackingStartDate: cdbTrackingStartDate,
                cdbAccumulatedBeforeTrackingCents:
                    cdbAccumulatedBeforeTrackingCents,
                bankAccountKind: bankAccountKind,
                colorValue: colorValue,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, AccountRow>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                betsRefs = false,
                billsPayableRefs = false,
                billsReceivableRefs = false,
                cdbYieldsRefs = false,
                creditCardsRefs = false,
                creditCardBillPaymentsRefs = false,
                ledgerEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (betsRefs) db.bets,
                    if (billsPayableRefs) db.billsPayable,
                    if (billsReceivableRefs) db.billsReceivable,
                    if (cdbYieldsRefs) db.cdbYields,
                    if (creditCardsRefs) db.creditCards,
                    if (creditCardBillPaymentsRefs) db.creditCardBillPayments,
                    if (ledgerEntriesRefs) db.ledgerEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (betsRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          BetRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._betsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(db, table, p0).betsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billsPayableRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          BillPayableRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._billsPayableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).billsPayableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billsReceivableRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          BillReceivableRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._billsReceivableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).billsReceivableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cdbYieldsRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          CdbYieldRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._cdbYieldsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).cdbYieldsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardsRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          CreditCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._creditCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultPaymentAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardBillPaymentsRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          CreditCardBillPaymentRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._creditCardBillPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardBillPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ledgerEntriesRefs)
                        await $_getPrefetchedData<
                          AccountRow,
                          $AccountsTable,
                          LedgerEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._ledgerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).ledgerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, $$AccountsTableReferences),
      AccountRow,
      PrefetchHooks Function({
        bool betsRefs,
        bool billsPayableRefs,
        bool billsReceivableRefs,
        bool cdbYieldsRefs,
        bool creditCardsRefs,
        bool creditCardBillPaymentsRefs,
        bool ledgerEntriesRefs,
      })
    >;
typedef $$BetsTableCreateCompanionBuilder = BetsCompanion Function({
  Value<int> id,
  required int accountId,
  required DateTime placedAt,
  Value<DateTime?> settledAt,
  required String sport,
  required String event,
  required String market,
  required String selection,
  required int stakeCents,
  required int oddsScaled,
  required BetStatus status,
  Value<int?> cashoutCents,
  Value<int?> actualReturnCents,
  Value<int?> resultCents,
  Value<String?> notes,
  Value<BetType?> betType,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$BetsTableUpdateCompanionBuilder = BetsCompanion Function({
  Value<int> id,
  Value<int> accountId,
  Value<DateTime> placedAt,
  Value<DateTime?> settledAt,
  Value<String> sport,
  Value<String> event,
  Value<String> market,
  Value<String> selection,
  Value<int> stakeCents,
  Value<int> oddsScaled,
  Value<BetStatus> status,
  Value<int?> cashoutCents,
  Value<int?> actualReturnCents,
  Value<int?> resultCents,
  Value<String?> notes,
  Value<BetType?> betType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$BetsTableReferences
    extends BaseReferences<_$AppDatabase, $BetsTable, BetRow> {
  $$BetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('bets__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BetLegsTable, List<BetLegRow>> _betLegsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.betLegs,
    aliasName: 'bets__id__bet_legs__bet_id',
  );

  $$BetLegsTableProcessedTableManager get betLegsRefs {
    final manager = $$BetLegsTableTableManager(
      $_db,
      $_db.betLegs,
    ).filter((f) => f.betId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_betLegsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LedgerEntriesTable, List<LedgerEntryRow>>
  _ledgerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ledgerEntries,
    aliasName: 'bets__id__ledger_entries__bet_id',
  );

  $$LedgerEntriesTableProcessedTableManager get ledgerEntriesRefs {
    final manager = $$LedgerEntriesTableTableManager(
      $_db,
      $_db.ledgerEntries,
    ).filter((f) => f.betId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ledgerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BetsTableFilterComposer extends Composer<_$AppDatabase, $BetsTable> {
  $$BetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get placedAt => $composableBuilder(
    column: $table.placedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sport => $composableBuilder(
    column: $table.sport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stakeCents => $composableBuilder(
    column: $table.stakeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BetStatus, BetStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get cashoutCents => $composableBuilder(
    column: $table.cashoutCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualReturnCents => $composableBuilder(
    column: $table.actualReturnCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BetType?, BetType, String> get betType =>
      $composableBuilder(
        column: $table.betType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> betLegsRefs(
    Expression<bool> Function($$BetLegsTableFilterComposer f) f,
  ) {
    final $$BetLegsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.betLegs,
      getReferencedColumn: (t) => t.betId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetLegsTableFilterComposer(
            $db: $db,
            $table: $db.betLegs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ledgerEntriesRefs(
    Expression<bool> Function($$LedgerEntriesTableFilterComposer f) f,
  ) {
    final $$LedgerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.betId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BetsTableOrderingComposer extends Composer<_$AppDatabase, $BetsTable> {
  $$BetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get placedAt => $composableBuilder(
    column: $table.placedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sport => $composableBuilder(
    column: $table.sport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stakeCents => $composableBuilder(
    column: $table.stakeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashoutCents => $composableBuilder(
    column: $table.cashoutCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualReturnCents => $composableBuilder(
    column: $table.actualReturnCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get betType => $composableBuilder(
    column: $table.betType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BetsTable> {
  $$BetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get placedAt =>
      $composableBuilder(column: $table.placedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get settledAt =>
      $composableBuilder(column: $table.settledAt, builder: (column) => column);

  GeneratedColumn<String> get sport =>
      $composableBuilder(column: $table.sport, builder: (column) => column);

  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<String> get selection =>
      $composableBuilder(column: $table.selection, builder: (column) => column);

  GeneratedColumn<int> get stakeCents => $composableBuilder(
    column: $table.stakeCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BetStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get cashoutCents => $composableBuilder(
    column: $table.cashoutCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualReturnCents => $composableBuilder(
    column: $table.actualReturnCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BetType?, String> get betType =>
      $composableBuilder(column: $table.betType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> betLegsRefs<T extends Object>(
    Expression<T> Function($$BetLegsTableAnnotationComposer a) f,
  ) {
    final $$BetLegsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.betLegs,
      getReferencedColumn: (t) => t.betId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetLegsTableAnnotationComposer(
            $db: $db,
            $table: $db.betLegs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ledgerEntriesRefs<T extends Object>(
    Expression<T> Function($$LedgerEntriesTableAnnotationComposer a) f,
  ) {
    final $$LedgerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.betId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BetsTable,
          BetRow,
          $$BetsTableFilterComposer,
          $$BetsTableOrderingComposer,
          $$BetsTableAnnotationComposer,
          $$BetsTableCreateCompanionBuilder,
          $$BetsTableUpdateCompanionBuilder,
          (BetRow, $$BetsTableReferences),
          BetRow,
          PrefetchHooks Function({
            bool accountId,
            bool betLegsRefs,
            bool ledgerEntriesRefs,
          })
        > {
  $$BetsTableTableManager(_$AppDatabase db, $BetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<DateTime> placedAt = const Value.absent(),
                Value<DateTime?> settledAt = const Value.absent(),
                Value<String> sport = const Value.absent(),
                Value<String> event = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<String> selection = const Value.absent(),
                Value<int> stakeCents = const Value.absent(),
                Value<int> oddsScaled = const Value.absent(),
                Value<BetStatus> status = const Value.absent(),
                Value<int?> cashoutCents = const Value.absent(),
                Value<int?> actualReturnCents = const Value.absent(),
                Value<int?> resultCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<BetType?> betType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BetsCompanion(
                id: id,
                accountId: accountId,
                placedAt: placedAt,
                settledAt: settledAt,
                sport: sport,
                event: event,
                market: market,
                selection: selection,
                stakeCents: stakeCents,
                oddsScaled: oddsScaled,
                status: status,
                cashoutCents: cashoutCents,
                actualReturnCents: actualReturnCents,
                resultCents: resultCents,
                notes: notes,
                betType: betType,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required DateTime placedAt,
                Value<DateTime?> settledAt = const Value.absent(),
                required String sport,
                required String event,
                required String market,
                required String selection,
                required int stakeCents,
                required int oddsScaled,
                required BetStatus status,
                Value<int?> cashoutCents = const Value.absent(),
                Value<int?> actualReturnCents = const Value.absent(),
                Value<int?> resultCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<BetType?> betType = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BetsCompanion.insert(
                id: id,
                accountId: accountId,
                placedAt: placedAt,
                settledAt: settledAt,
                sport: sport,
                event: event,
                market: market,
                selection: selection,
                stakeCents: stakeCents,
                oddsScaled: oddsScaled,
                status: status,
                cashoutCents: cashoutCents,
                actualReturnCents: actualReturnCents,
                resultCents: resultCents,
                notes: notes,
                betType: betType,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BetsTable, BetRow>(table),
                  $$BetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                betLegsRefs = false,
                ledgerEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (betLegsRefs) db.betLegs,
                    if (ledgerEntriesRefs) db.ledgerEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$BetsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$BetsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (betLegsRefs)
                        await $_getPrefetchedData<
                          BetRow,
                          $BetsTable,
                          BetLegRow
                        >(
                          currentTable: table,
                          referencedTable: $$BetsTableReferences
                              ._betLegsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BetsTableReferences(db, table, p0).betLegsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.betId == item.id),
                          typedResults: items,
                        ),
                      if (ledgerEntriesRefs)
                        await $_getPrefetchedData<
                          BetRow,
                          $BetsTable,
                          LedgerEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$BetsTableReferences
                              ._ledgerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $$BetsTableReferences(
                            db,
                            table,
                            p0,
                          ).ledgerEntriesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.betId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BetsTable,
      BetRow,
      $$BetsTableFilterComposer,
      $$BetsTableOrderingComposer,
      $$BetsTableAnnotationComposer,
      $$BetsTableCreateCompanionBuilder,
      $$BetsTableUpdateCompanionBuilder,
      (BetRow, $$BetsTableReferences),
      BetRow,
      PrefetchHooks Function({
        bool accountId,
        bool betLegsRefs,
        bool ledgerEntriesRefs,
      })
    >;
typedef $$BetLegsTableCreateCompanionBuilder = BetLegsCompanion Function({
  Value<int> id,
  required int betId,
  required int position,
  required String sport,
  required String event,
  required String market,
  required String selection,
  required int oddsScaled,
});
typedef $$BetLegsTableUpdateCompanionBuilder = BetLegsCompanion Function({
  Value<int> id,
  Value<int> betId,
  Value<int> position,
  Value<String> sport,
  Value<String> event,
  Value<String> market,
  Value<String> selection,
  Value<int> oddsScaled,
});

final class $$BetLegsTableReferences
    extends BaseReferences<_$AppDatabase, $BetLegsTable, BetLegRow> {
  $$BetLegsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BetsTable _betIdTable(_$AppDatabase db) =>
      db.bets.createAlias('bet_legs__bet_id__bets__id');

  $$BetsTableProcessedTableManager get betId {
    final $_column = $_itemColumn<int>('bet_id')!;

    final manager = $$BetsTableTableManager(
      $_db,
      $_db.bets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_betIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BetLegsTableFilterComposer
    extends Composer<_$AppDatabase, $BetLegsTable> {
  $$BetLegsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sport => $composableBuilder(
    column: $table.sport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => ColumnFilters(column),
  );

  $$BetsTableFilterComposer get betId {
    final $$BetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableFilterComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BetLegsTableOrderingComposer
    extends Composer<_$AppDatabase, $BetLegsTable> {
  $$BetLegsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sport => $composableBuilder(
    column: $table.sport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => ColumnOrderings(column),
  );

  $$BetsTableOrderingComposer get betId {
    final $$BetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableOrderingComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BetLegsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BetLegsTable> {
  $$BetLegsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get sport =>
      $composableBuilder(column: $table.sport, builder: (column) => column);

  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<String> get selection =>
      $composableBuilder(column: $table.selection, builder: (column) => column);

  GeneratedColumn<int> get oddsScaled => $composableBuilder(
    column: $table.oddsScaled,
    builder: (column) => column,
  );

  $$BetsTableAnnotationComposer get betId {
    final $$BetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableAnnotationComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BetLegsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BetLegsTable,
          BetLegRow,
          $$BetLegsTableFilterComposer,
          $$BetLegsTableOrderingComposer,
          $$BetLegsTableAnnotationComposer,
          $$BetLegsTableCreateCompanionBuilder,
          $$BetLegsTableUpdateCompanionBuilder,
          (BetLegRow, $$BetLegsTableReferences),
          BetLegRow,
          PrefetchHooks Function({bool betId})
        > {
  $$BetLegsTableTableManager(_$AppDatabase db, $BetLegsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BetLegsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BetLegsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BetLegsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> betId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> sport = const Value.absent(),
                Value<String> event = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<String> selection = const Value.absent(),
                Value<int> oddsScaled = const Value.absent(),
              }) => BetLegsCompanion(
                id: id,
                betId: betId,
                position: position,
                sport: sport,
                event: event,
                market: market,
                selection: selection,
                oddsScaled: oddsScaled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int betId,
                required int position,
                required String sport,
                required String event,
                required String market,
                required String selection,
                required int oddsScaled,
              }) => BetLegsCompanion.insert(
                id: id,
                betId: betId,
                position: position,
                sport: sport,
                event: event,
                market: market,
                selection: selection,
                oddsScaled: oddsScaled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BetLegsTable, BetLegRow>(table),
                  $$BetLegsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({betId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (betId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.betId,
                        referencedTable: $$BetLegsTableReferences._betIdTable(
                          db,
                        ),
                        referencedColumn: $$BetLegsTableReferences
                            ._betIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BetLegsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BetLegsTable,
      BetLegRow,
      $$BetLegsTableFilterComposer,
      $$BetLegsTableOrderingComposer,
      $$BetLegsTableAnnotationComposer,
      $$BetLegsTableCreateCompanionBuilder,
      $$BetLegsTableUpdateCompanionBuilder,
      (BetLegRow, $$BetLegsTableReferences),
      BetLegRow,
      PrefetchHooks Function({bool betId})
    >;
typedef $$FinancialCategoriesTableCreateCompanionBuilder =
    FinancialCategoriesCompanion Function({
      Value<int> id,
      required String name,
      required CategoryKind kind,
      Value<int?> parentCategoryId,
      Value<int> iconCodePoint,
      Value<int> colorValue,
      Value<bool> isArchived,
      required DateTime createdAt,
    });
typedef $$FinancialCategoriesTableUpdateCompanionBuilder =
    FinancialCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<CategoryKind> kind,
      Value<int?> parentCategoryId,
      Value<int> iconCodePoint,
      Value<int> colorValue,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

final class $$FinancialCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialCategoriesTable,
          FinancialCategoryRow
        > {
  $$FinancialCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FinancialCategoriesTable _parentCategoryIdTable(_$AppDatabase db) =>
      db.financialCategories.createAlias(
        'financial_categories__parent_category_id__financial_categories__id',
      );

  $$FinancialCategoriesTableProcessedTableManager? get parentCategoryId {
    final $_column = $_itemColumn<int>('parent_category_id');
    if ($_column == null) return null;
    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillsPayableTable, List<BillPayableRow>>
  _billsPayableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsPayable,
    aliasName: 'financial_categories__id__bills_payable__category_id',
  );

  $$BillsPayableTableProcessedTableManager get billsPayableRefs {
    final manager = $$BillsPayableTableTableManager(
      $_db,
      $_db.billsPayable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsPayableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillsReceivableTable, List<BillReceivableRow>>
  _billsReceivableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsReceivable,
    aliasName: 'financial_categories__id__bills_receivable__category_id',
  );

  $$BillsReceivableTableProcessedTableManager get billsReceivableRefs {
    final manager = $$BillsReceivableTableTableManager(
      $_db,
      $_db.billsReceivable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billsReceivableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'financial_categories__id__movements__category_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardTransactionsTable, List<CardTransactionRow>>
  _cardTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardTransactions,
    aliasName: 'financial_categories__id__card_transactions__category_id',
  );

  $$CardTransactionsTableProcessedTableManager get cardTransactionsRefs {
    final manager = $$CardTransactionsTableTableManager(
      $_db,
      $_db.cardTransactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cardTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FinancialCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoryKind, CategoryKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialCategoriesTableFilterComposer get parentCategoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentCategoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billsPayableRefs(
    Expression<bool> Function($$BillsPayableTableFilterComposer f) f,
  ) {
    final $$BillsPayableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableFilterComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> billsReceivableRefs(
    Expression<bool> Function($$BillsReceivableTableFilterComposer f) f,
  ) {
    final $$BillsReceivableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableFilterComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardTransactionsRefs(
    Expression<bool> Function($$CardTransactionsTableFilterComposer f) f,
  ) {
    final $$CardTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FinancialCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialCategoriesTableOrderingComposer get parentCategoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.parentCategoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$FinancialCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FinancialCategoriesTableAnnotationComposer get parentCategoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.parentCategoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> billsPayableRefs<T extends Object>(
    Expression<T> Function($$BillsPayableTableAnnotationComposer a) f,
  ) {
    final $$BillsPayableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> billsReceivableRefs<T extends Object>(
    Expression<T> Function($$BillsReceivableTableAnnotationComposer a) f,
  ) {
    final $$BillsReceivableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardTransactionsRefs<T extends Object>(
    Expression<T> Function($$CardTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CardTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FinancialCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialCategoriesTable,
          FinancialCategoryRow,
          $$FinancialCategoriesTableFilterComposer,
          $$FinancialCategoriesTableOrderingComposer,
          $$FinancialCategoriesTableAnnotationComposer,
          $$FinancialCategoriesTableCreateCompanionBuilder,
          $$FinancialCategoriesTableUpdateCompanionBuilder,
          (FinancialCategoryRow, $$FinancialCategoriesTableReferences),
          FinancialCategoryRow,
          PrefetchHooks Function({
            bool parentCategoryId,
            bool billsPayableRefs,
            bool billsReceivableRefs,
            bool movementsRefs,
            bool cardTransactionsRefs,
          })
        > {
  $$FinancialCategoriesTableTableManager(
    _$AppDatabase db,
    $FinancialCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialCategoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<CategoryKind> kind = const Value.absent(),
                Value<int?> parentCategoryId = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FinancialCategoriesCompanion(
                id: id,
                name: name,
                kind: kind,
                parentCategoryId: parentCategoryId,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required CategoryKind kind,
                Value<int?> parentCategoryId = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
              }) => FinancialCategoriesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                parentCategoryId: parentCategoryId,
                iconCodePoint: iconCodePoint,
                colorValue: colorValue,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FinancialCategoriesTable, FinancialCategoryRow>(
                    table,
                  ),
                  $$FinancialCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parentCategoryId = false,
                billsPayableRefs = false,
                billsReceivableRefs = false,
                movementsRefs = false,
                cardTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billsPayableRefs) db.billsPayable,
                    if (billsReceivableRefs) db.billsReceivable,
                    if (movementsRefs) db.movements,
                    if (cardTransactionsRefs) db.cardTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentCategoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentCategoryId,
                            referencedTable:
                                $$FinancialCategoriesTableReferences
                                    ._parentCategoryIdTable(db),
                            referencedColumn:
                                $$FinancialCategoriesTableReferences
                                    ._parentCategoryIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billsPayableRefs)
                        await $_getPrefetchedData<
                          FinancialCategoryRow,
                          $FinancialCategoriesTable,
                          BillPayableRow
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialCategoriesTableReferences
                              ._billsPayableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).billsPayableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billsReceivableRefs)
                        await $_getPrefetchedData<
                          FinancialCategoryRow,
                          $FinancialCategoriesTable,
                          BillReceivableRow
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialCategoriesTableReferences
                              ._billsReceivableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).billsReceivableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movementsRefs)
                        await $_getPrefetchedData<
                          FinancialCategoryRow,
                          $FinancialCategoriesTable,
                          MovementRow
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialCategoriesTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardTransactionsRefs)
                        await $_getPrefetchedData<
                          FinancialCategoryRow,
                          $FinancialCategoriesTable,
                          CardTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialCategoriesTableReferences
                              ._cardTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).cardTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FinancialCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialCategoriesTable,
      FinancialCategoryRow,
      $$FinancialCategoriesTableFilterComposer,
      $$FinancialCategoriesTableOrderingComposer,
      $$FinancialCategoriesTableAnnotationComposer,
      $$FinancialCategoriesTableCreateCompanionBuilder,
      $$FinancialCategoriesTableUpdateCompanionBuilder,
      (FinancialCategoryRow, $$FinancialCategoriesTableReferences),
      FinancialCategoryRow,
      PrefetchHooks Function({
        bool parentCategoryId,
        bool billsPayableRefs,
        bool billsReceivableRefs,
        bool movementsRefs,
        bool cardTransactionsRefs,
      })
    >;
typedef $$BillsPayableTableCreateCompanionBuilder =
    BillsPayableCompanion Function({
      Value<int> id,
      required String description,
      required int amountCents,
      Value<int?> categoryId,
      Value<int?> accountId,
      required DateTime dueDate,
      Value<DateTime?> competenceDate,
      Value<String?> notes,
      Value<bool> cancelled,
      Value<RecurrenceFrequency?> recurrenceFrequency,
      Value<String?> recurrenceGroupId,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$BillsPayableTableUpdateCompanionBuilder =
    BillsPayableCompanion Function({
      Value<int> id,
      Value<String> description,
      Value<int> amountCents,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<DateTime> dueDate,
      Value<DateTime?> competenceDate,
      Value<String?> notes,
      Value<bool> cancelled,
      Value<RecurrenceFrequency?> recurrenceFrequency,
      Value<String?> recurrenceGroupId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BillsPayableTableReferences
    extends BaseReferences<_$AppDatabase, $BillsPayableTable, BillPayableRow> {
  $$BillsPayableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FinancialCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .financialCategories
      .createAlias('bills_payable__category_id__financial_categories__id');

  $$FinancialCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('bills_payable__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'bills_payable__id__movements__payable_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.payableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BillsPayableTableFilterComposer
    extends Composer<_$AppDatabase, $BillsPayableTable> {
  $$BillsPayableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get competenceDate => $composableBuilder(
    column: $table.competenceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    RecurrenceFrequency?,
    RecurrenceFrequency,
    String
  >
  get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialCategoriesTableFilterComposer get categoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.payableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsPayableTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsPayableTable> {
  $$BillsPayableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get competenceDate => $composableBuilder(
    column: $table.competenceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialCategoriesTableOrderingComposer get categoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillsPayableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsPayableTable> {
  $$BillsPayableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get competenceDate => $composableBuilder(
    column: $table.competenceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get cancelled =>
      $composableBuilder(column: $table.cancelled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecurrenceFrequency?, String>
  get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FinancialCategoriesTableAnnotationComposer get categoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.payableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsPayableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsPayableTable,
          BillPayableRow,
          $$BillsPayableTableFilterComposer,
          $$BillsPayableTableOrderingComposer,
          $$BillsPayableTableAnnotationComposer,
          $$BillsPayableTableCreateCompanionBuilder,
          $$BillsPayableTableUpdateCompanionBuilder,
          (BillPayableRow, $$BillsPayableTableReferences),
          BillPayableRow,
          PrefetchHooks Function({
            bool categoryId,
            bool accountId,
            bool movementsRefs,
          })
        > {
  $$BillsPayableTableTableManager(_$AppDatabase db, $BillsPayableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsPayableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsPayableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsPayableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<DateTime?> competenceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<RecurrenceFrequency?> recurrenceFrequency =
                    const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BillsPayableCompanion(
                id: id,
                description: description,
                amountCents: amountCents,
                categoryId: categoryId,
                accountId: accountId,
                dueDate: dueDate,
                competenceDate: competenceDate,
                notes: notes,
                cancelled: cancelled,
                recurrenceFrequency: recurrenceFrequency,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String description,
                required int amountCents,
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                required DateTime dueDate,
                Value<DateTime?> competenceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<RecurrenceFrequency?> recurrenceFrequency =
                    const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BillsPayableCompanion.insert(
                id: id,
                description: description,
                amountCents: amountCents,
                categoryId: categoryId,
                accountId: accountId,
                dueDate: dueDate,
                competenceDate: competenceDate,
                notes: notes,
                cancelled: cancelled,
                recurrenceFrequency: recurrenceFrequency,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillsPayableTable, BillPayableRow>(table),
                  $$BillsPayableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, accountId = false, movementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (movementsRefs) db.movements],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$BillsPayableTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$BillsPayableTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$BillsPayableTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$BillsPayableTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movementsRefs)
                        await $_getPrefetchedData<
                          BillPayableRow,
                          $BillsPayableTable,
                          MovementRow
                        >(
                          currentTable: table,
                          referencedTable: $$BillsPayableTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BillsPayableTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.payableId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BillsPayableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsPayableTable,
      BillPayableRow,
      $$BillsPayableTableFilterComposer,
      $$BillsPayableTableOrderingComposer,
      $$BillsPayableTableAnnotationComposer,
      $$BillsPayableTableCreateCompanionBuilder,
      $$BillsPayableTableUpdateCompanionBuilder,
      (BillPayableRow, $$BillsPayableTableReferences),
      BillPayableRow,
      PrefetchHooks Function({
        bool categoryId,
        bool accountId,
        bool movementsRefs,
      })
    >;
typedef $$BillsReceivableTableCreateCompanionBuilder =
    BillsReceivableCompanion Function({
      Value<int> id,
      required String description,
      required int amountCents,
      Value<int?> categoryId,
      Value<int?> accountId,
      required DateTime dueDate,
      Value<String?> notes,
      Value<bool> cancelled,
      Value<RecurrenceFrequency?> recurrenceFrequency,
      Value<String?> recurrenceGroupId,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$BillsReceivableTableUpdateCompanionBuilder =
    BillsReceivableCompanion Function({
      Value<int> id,
      Value<String> description,
      Value<int> amountCents,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<DateTime> dueDate,
      Value<String?> notes,
      Value<bool> cancelled,
      Value<RecurrenceFrequency?> recurrenceFrequency,
      Value<String?> recurrenceGroupId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BillsReceivableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BillsReceivableTable,
          BillReceivableRow
        > {
  $$BillsReceivableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FinancialCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .financialCategories
      .createAlias('bills_receivable__category_id__financial_categories__id');

  $$FinancialCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('bills_receivable__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'bills_receivable__id__movements__receivable_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.receivableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BillsReceivableTableFilterComposer
    extends Composer<_$AppDatabase, $BillsReceivableTable> {
  $$BillsReceivableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    RecurrenceFrequency?,
    RecurrenceFrequency,
    String
  >
  get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialCategoriesTableFilterComposer get categoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.receivableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsReceivableTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsReceivableTable> {
  $$BillsReceivableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cancelled => $composableBuilder(
    column: $table.cancelled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialCategoriesTableOrderingComposer get categoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillsReceivableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsReceivableTable> {
  $$BillsReceivableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get cancelled =>
      $composableBuilder(column: $table.cancelled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecurrenceFrequency?, String>
  get recurrenceFrequency => $composableBuilder(
    column: $table.recurrenceFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FinancialCategoriesTableAnnotationComposer get categoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.receivableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsReceivableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsReceivableTable,
          BillReceivableRow,
          $$BillsReceivableTableFilterComposer,
          $$BillsReceivableTableOrderingComposer,
          $$BillsReceivableTableAnnotationComposer,
          $$BillsReceivableTableCreateCompanionBuilder,
          $$BillsReceivableTableUpdateCompanionBuilder,
          (BillReceivableRow, $$BillsReceivableTableReferences),
          BillReceivableRow,
          PrefetchHooks Function({
            bool categoryId,
            bool accountId,
            bool movementsRefs,
          })
        > {
  $$BillsReceivableTableTableManager(
    _$AppDatabase db,
    $BillsReceivableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsReceivableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsReceivableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsReceivableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<RecurrenceFrequency?> recurrenceFrequency =
                    const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BillsReceivableCompanion(
                id: id,
                description: description,
                amountCents: amountCents,
                categoryId: categoryId,
                accountId: accountId,
                dueDate: dueDate,
                notes: notes,
                cancelled: cancelled,
                recurrenceFrequency: recurrenceFrequency,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String description,
                required int amountCents,
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                required DateTime dueDate,
                Value<String?> notes = const Value.absent(),
                Value<bool> cancelled = const Value.absent(),
                Value<RecurrenceFrequency?> recurrenceFrequency =
                    const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BillsReceivableCompanion.insert(
                id: id,
                description: description,
                amountCents: amountCents,
                categoryId: categoryId,
                accountId: accountId,
                dueDate: dueDate,
                notes: notes,
                cancelled: cancelled,
                recurrenceFrequency: recurrenceFrequency,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillsReceivableTable, BillReceivableRow>(table),
                  $$BillsReceivableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, accountId = false, movementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (movementsRefs) db.movements],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$BillsReceivableTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$BillsReceivableTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$BillsReceivableTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$BillsReceivableTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movementsRefs)
                        await $_getPrefetchedData<
                          BillReceivableRow,
                          $BillsReceivableTable,
                          MovementRow
                        >(
                          currentTable: table,
                          referencedTable: $$BillsReceivableTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BillsReceivableTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.receivableId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BillsReceivableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsReceivableTable,
      BillReceivableRow,
      $$BillsReceivableTableFilterComposer,
      $$BillsReceivableTableOrderingComposer,
      $$BillsReceivableTableAnnotationComposer,
      $$BillsReceivableTableCreateCompanionBuilder,
      $$BillsReceivableTableUpdateCompanionBuilder,
      (BillReceivableRow, $$BillsReceivableTableReferences),
      BillReceivableRow,
      PrefetchHooks Function({
        bool categoryId,
        bool accountId,
        bool movementsRefs,
      })
    >;
typedef $$MovementsTableCreateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  required MovementType type,
  Value<int?> sourceAccountId,
  Value<int?> destinationAccountId,
  required int amountCents,
  Value<int> feeCents,
  required DateTime occurredAt,
  Value<String?> description,
  Value<String?> adjustmentReason,
  Value<int?> categoryId,
  Value<bool> reconciled,
  Value<int?> payableId,
  Value<int?> receivableId,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$MovementsTableUpdateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  Value<MovementType> type,
  Value<int?> sourceAccountId,
  Value<int?> destinationAccountId,
  Value<int> amountCents,
  Value<int> feeCents,
  Value<DateTime> occurredAt,
  Value<String?> description,
  Value<String?> adjustmentReason,
  Value<int?> categoryId,
  Value<bool> reconciled,
  Value<int?> payableId,
  Value<int?> receivableId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$MovementsTableReferences
    extends BaseReferences<_$AppDatabase, $MovementsTable, MovementRow> {
  $$MovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _sourceAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('movements__source_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get sourceAccountId {
    final $_column = $_itemColumn<int>('source_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _destinationAccountIdTable(_$AppDatabase db) => db
      .accounts
      .createAlias('movements__destination_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get destinationAccountId {
    final $_column = $_itemColumn<int>('destination_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _destinationAccountIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FinancialCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .financialCategories
      .createAlias('movements__category_id__financial_categories__id');

  $$FinancialCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BillsPayableTable _payableIdTable(_$AppDatabase db) =>
      db.billsPayable.createAlias('movements__payable_id__bills_payable__id');

  $$BillsPayableTableProcessedTableManager? get payableId {
    final $_column = $_itemColumn<int>('payable_id');
    if ($_column == null) return null;
    final manager = $$BillsPayableTableTableManager(
      $_db,
      $_db.billsPayable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BillsReceivableTable _receivableIdTable(_$AppDatabase db) => db
      .billsReceivable
      .createAlias('movements__receivable_id__bills_receivable__id');

  $$BillsReceivableTableProcessedTableManager? get receivableId {
    final $_column = $_itemColumn<int>('receivable_id');
    if ($_column == null) return null;
    final manager = $$BillsReceivableTableTableManager(
      $_db,
      $_db.billsReceivable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receivableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LedgerEntriesTable, List<LedgerEntryRow>>
  _ledgerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ledgerEntries,
    aliasName: 'movements__id__ledger_entries__movement_id',
  );

  $$LedgerEntriesTableProcessedTableManager get ledgerEntriesRefs {
    final manager = $$LedgerEntriesTableTableManager(
      $_db,
      $_db.ledgerEntries,
    ).filter((f) => f.movementId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ledgerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MovementsTableFilterComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MovementType, MovementType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feeCents => $composableBuilder(
    column: $table.feeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adjustmentReason => $composableBuilder(
    column: $table.adjustmentReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get sourceAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get destinationAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableFilterComposer get categoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BillsPayableTableFilterComposer get payableId {
    final $$BillsPayableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payableId,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableFilterComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BillsReceivableTableFilterComposer get receivableId {
    final $$BillsReceivableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receivableId,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableFilterComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ledgerEntriesRefs(
    Expression<bool> Function($$LedgerEntriesTableFilterComposer f) f,
  ) {
    final $$LedgerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.movementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feeCents => $composableBuilder(
    column: $table.feeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adjustmentReason => $composableBuilder(
    column: $table.adjustmentReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get sourceAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get destinationAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableOrderingComposer get categoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$BillsPayableTableOrderingComposer get payableId {
    final $$BillsPayableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payableId,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableOrderingComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BillsReceivableTableOrderingComposer get receivableId {
    final $$BillsReceivableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receivableId,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableOrderingComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get feeCents =>
      $composableBuilder(column: $table.feeCents, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get adjustmentReason => $composableBuilder(
    column: $table.adjustmentReason,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get sourceAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get destinationAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableAnnotationComposer get categoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$BillsPayableTableAnnotationComposer get payableId {
    final $$BillsPayableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payableId,
      referencedTable: $db.billsPayable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsPayableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsPayable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BillsReceivableTableAnnotationComposer get receivableId {
    final $$BillsReceivableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receivableId,
      referencedTable: $db.billsReceivable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsReceivableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsReceivable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ledgerEntriesRefs<T extends Object>(
    Expression<T> Function($$LedgerEntriesTableAnnotationComposer a) f,
  ) {
    final $$LedgerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.movementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovementsTable,
          MovementRow,
          $$MovementsTableFilterComposer,
          $$MovementsTableOrderingComposer,
          $$MovementsTableAnnotationComposer,
          $$MovementsTableCreateCompanionBuilder,
          $$MovementsTableUpdateCompanionBuilder,
          (MovementRow, $$MovementsTableReferences),
          MovementRow,
          PrefetchHooks Function({
            bool sourceAccountId,
            bool destinationAccountId,
            bool categoryId,
            bool payableId,
            bool receivableId,
            bool ledgerEntriesRefs,
          })
        > {
  $$MovementsTableTableManager(_$AppDatabase db, $MovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MovementType> type = const Value.absent(),
                Value<int?> sourceAccountId = const Value.absent(),
                Value<int?> destinationAccountId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> feeCents = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> adjustmentReason = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<bool> reconciled = const Value.absent(),
                Value<int?> payableId = const Value.absent(),
                Value<int?> receivableId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MovementsCompanion(
                id: id,
                type: type,
                sourceAccountId: sourceAccountId,
                destinationAccountId: destinationAccountId,
                amountCents: amountCents,
                feeCents: feeCents,
                occurredAt: occurredAt,
                description: description,
                adjustmentReason: adjustmentReason,
                categoryId: categoryId,
                reconciled: reconciled,
                payableId: payableId,
                receivableId: receivableId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MovementType type,
                Value<int?> sourceAccountId = const Value.absent(),
                Value<int?> destinationAccountId = const Value.absent(),
                required int amountCents,
                Value<int> feeCents = const Value.absent(),
                required DateTime occurredAt,
                Value<String?> description = const Value.absent(),
                Value<String?> adjustmentReason = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<bool> reconciled = const Value.absent(),
                Value<int?> payableId = const Value.absent(),
                Value<int?> receivableId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MovementsCompanion.insert(
                id: id,
                type: type,
                sourceAccountId: sourceAccountId,
                destinationAccountId: destinationAccountId,
                amountCents: amountCents,
                feeCents: feeCents,
                occurredAt: occurredAt,
                description: description,
                adjustmentReason: adjustmentReason,
                categoryId: categoryId,
                reconciled: reconciled,
                payableId: payableId,
                receivableId: receivableId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovementsTable, MovementRow>(table),
                  $$MovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sourceAccountId = false,
                destinationAccountId = false,
                categoryId = false,
                payableId = false,
                receivableId = false,
                ledgerEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ledgerEntriesRefs) db.ledgerEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sourceAccountId,
                            referencedTable: $$MovementsTableReferences
                                ._sourceAccountIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._sourceAccountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (destinationAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.destinationAccountId,
                            referencedTable: $$MovementsTableReferences
                                ._destinationAccountIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._destinationAccountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$MovementsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (payableId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payableId,
                            referencedTable: $$MovementsTableReferences
                                ._payableIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._payableIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (receivableId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.receivableId,
                            referencedTable: $$MovementsTableReferences
                                ._receivableIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._receivableIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ledgerEntriesRefs)
                        await $_getPrefetchedData<
                          MovementRow,
                          $MovementsTable,
                          LedgerEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$MovementsTableReferences
                              ._ledgerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MovementsTableReferences(
                                db,
                                table,
                                p0,
                              ).ledgerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.movementId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovementsTable,
      MovementRow,
      $$MovementsTableFilterComposer,
      $$MovementsTableOrderingComposer,
      $$MovementsTableAnnotationComposer,
      $$MovementsTableCreateCompanionBuilder,
      $$MovementsTableUpdateCompanionBuilder,
      (MovementRow, $$MovementsTableReferences),
      MovementRow,
      PrefetchHooks Function({
        bool sourceAccountId,
        bool destinationAccountId,
        bool categoryId,
        bool payableId,
        bool receivableId,
        bool ledgerEntriesRefs,
      })
    >;
typedef $$CdbYieldsTableCreateCompanionBuilder = CdbYieldsCompanion Function({
  Value<int> id,
  required int accountId,
  required DateTime date,
  required int amountCents,
  Value<String?> description,
  required DateTime createdAt,
});
typedef $$CdbYieldsTableUpdateCompanionBuilder = CdbYieldsCompanion Function({
  Value<int> id,
  Value<int> accountId,
  Value<DateTime> date,
  Value<int> amountCents,
  Value<String?> description,
  Value<DateTime> createdAt,
});

final class $$CdbYieldsTableReferences
    extends BaseReferences<_$AppDatabase, $CdbYieldsTable, CdbYieldRow> {
  $$CdbYieldsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('cdb_yields__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LedgerEntriesTable, List<LedgerEntryRow>>
  _ledgerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ledgerEntries,
    aliasName: 'cdb_yields__id__ledger_entries__cdb_yield_id',
  );

  $$LedgerEntriesTableProcessedTableManager get ledgerEntriesRefs {
    final manager = $$LedgerEntriesTableTableManager(
      $_db,
      $_db.ledgerEntries,
    ).filter((f) => f.cdbYieldId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ledgerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CdbYieldsTableFilterComposer
    extends Composer<_$AppDatabase, $CdbYieldsTable> {
  $$CdbYieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ledgerEntriesRefs(
    Expression<bool> Function($$LedgerEntriesTableFilterComposer f) f,
  ) {
    final $$LedgerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.cdbYieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CdbYieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $CdbYieldsTable> {
  $$CdbYieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CdbYieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CdbYieldsTable> {
  $$CdbYieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ledgerEntriesRefs<T extends Object>(
    Expression<T> Function($$LedgerEntriesTableAnnotationComposer a) f,
  ) {
    final $$LedgerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.cdbYieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CdbYieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CdbYieldsTable,
          CdbYieldRow,
          $$CdbYieldsTableFilterComposer,
          $$CdbYieldsTableOrderingComposer,
          $$CdbYieldsTableAnnotationComposer,
          $$CdbYieldsTableCreateCompanionBuilder,
          $$CdbYieldsTableUpdateCompanionBuilder,
          (CdbYieldRow, $$CdbYieldsTableReferences),
          CdbYieldRow,
          PrefetchHooks Function({bool accountId, bool ledgerEntriesRefs})
        > {
  $$CdbYieldsTableTableManager(_$AppDatabase db, $CdbYieldsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CdbYieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CdbYieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CdbYieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CdbYieldsCompanion(
                id: id,
                accountId: accountId,
                date: date,
                amountCents: amountCents,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required DateTime date,
                required int amountCents,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
              }) => CdbYieldsCompanion.insert(
                id: id,
                accountId: accountId,
                date: date,
                amountCents: amountCents,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CdbYieldsTable, CdbYieldRow>(table),
                  $$CdbYieldsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, ledgerEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ledgerEntriesRefs) db.ledgerEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$CdbYieldsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$CdbYieldsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ledgerEntriesRefs)
                        await $_getPrefetchedData<
                          CdbYieldRow,
                          $CdbYieldsTable,
                          LedgerEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$CdbYieldsTableReferences
                              ._ledgerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CdbYieldsTableReferences(
                                db,
                                table,
                                p0,
                              ).ledgerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cdbYieldId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CdbYieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CdbYieldsTable,
      CdbYieldRow,
      $$CdbYieldsTableFilterComposer,
      $$CdbYieldsTableOrderingComposer,
      $$CdbYieldsTableAnnotationComposer,
      $$CdbYieldsTableCreateCompanionBuilder,
      $$CdbYieldsTableUpdateCompanionBuilder,
      (CdbYieldRow, $$CdbYieldsTableReferences),
      CdbYieldRow,
      PrefetchHooks Function({bool accountId, bool ledgerEntriesRefs})
    >;
typedef $$CreditCardsTableCreateCompanionBuilder =
    CreditCardsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> issuerBank,
      Value<int> creditLimitCents,
      required int closingDay,
      required int dueDay,
      Value<int?> defaultPaymentAccountId,
      Value<int> colorValue,
      Value<bool> isArchived,
      required DateTime createdAt,
    });
typedef $$CreditCardsTableUpdateCompanionBuilder =
    CreditCardsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> issuerBank,
      Value<int> creditLimitCents,
      Value<int> closingDay,
      Value<int> dueDay,
      Value<int?> defaultPaymentAccountId,
      Value<int> colorValue,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

final class $$CreditCardsTableReferences
    extends BaseReferences<_$AppDatabase, $CreditCardsTable, CreditCardRow> {
  $$CreditCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _defaultPaymentAccountIdTable(_$AppDatabase db) => db
      .accounts
      .createAlias('credit_cards__default_payment_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get defaultPaymentAccountId {
    final $_column = $_itemColumn<int>('default_payment_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _defaultPaymentAccountIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CreditCardBillsTable, List<CreditCardBillRow>>
  _creditCardBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditCardBills,
    aliasName: 'credit_cards__id__credit_card_bills__card_id',
  );

  $$CreditCardBillsTableProcessedTableManager get creditCardBillsRefs {
    final manager = $$CreditCardBillsTableTableManager(
      $_db,
      $_db.creditCardBills,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardBillsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardTransactionsTable, List<CardTransactionRow>>
  _cardTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardTransactions,
    aliasName: 'credit_cards__id__card_transactions__card_id',
  );

  $$CardTransactionsTableProcessedTableManager get cardTransactionsRefs {
    final manager = $$CardTransactionsTableTableManager(
      $_db,
      $_db.cardTransactions,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cardTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuerBank => $composableBuilder(
    column: $table.issuerBank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimitCents => $composableBuilder(
    column: $table.creditLimitCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get defaultPaymentAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> creditCardBillsRefs(
    Expression<bool> Function($$CreditCardBillsTableFilterComposer f) f,
  ) {
    final $$CreditCardBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableFilterComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardTransactionsRefs(
    Expression<bool> Function($$CardTransactionsTableFilterComposer f) f,
  ) {
    final $$CardTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuerBank => $composableBuilder(
    column: $table.issuerBank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimitCents => $composableBuilder(
    column: $table.creditLimitCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get defaultPaymentAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get issuerBank => $composableBuilder(
    column: $table.issuerBank,
    builder: (column) => column,
  );

  GeneratedColumn<int> get creditLimitCents => $composableBuilder(
    column: $table.creditLimitCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get defaultPaymentAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> creditCardBillsRefs<T extends Object>(
    Expression<T> Function($$CreditCardBillsTableAnnotationComposer a) f,
  ) {
    final $$CreditCardBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardTransactionsRefs<T extends Object>(
    Expression<T> Function($$CardTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CardTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardsTable,
          CreditCardRow,
          $$CreditCardsTableFilterComposer,
          $$CreditCardsTableOrderingComposer,
          $$CreditCardsTableAnnotationComposer,
          $$CreditCardsTableCreateCompanionBuilder,
          $$CreditCardsTableUpdateCompanionBuilder,
          (CreditCardRow, $$CreditCardsTableReferences),
          CreditCardRow,
          PrefetchHooks Function({
            bool defaultPaymentAccountId,
            bool creditCardBillsRefs,
            bool cardTransactionsRefs,
          })
        > {
  $$CreditCardsTableTableManager(_$AppDatabase db, $CreditCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> issuerBank = const Value.absent(),
                Value<int> creditLimitCents = const Value.absent(),
                Value<int> closingDay = const Value.absent(),
                Value<int> dueDay = const Value.absent(),
                Value<int?> defaultPaymentAccountId = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditCardsCompanion(
                id: id,
                name: name,
                issuerBank: issuerBank,
                creditLimitCents: creditLimitCents,
                closingDay: closingDay,
                dueDay: dueDay,
                defaultPaymentAccountId: defaultPaymentAccountId,
                colorValue: colorValue,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> issuerBank = const Value.absent(),
                Value<int> creditLimitCents = const Value.absent(),
                required int closingDay,
                required int dueDay,
                Value<int?> defaultPaymentAccountId = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
              }) => CreditCardsCompanion.insert(
                id: id,
                name: name,
                issuerBank: issuerBank,
                creditLimitCents: creditLimitCents,
                closingDay: closingDay,
                dueDay: dueDay,
                defaultPaymentAccountId: defaultPaymentAccountId,
                colorValue: colorValue,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditCardsTable, CreditCardRow>(table),
                  $$CreditCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultPaymentAccountId = false,
                creditCardBillsRefs = false,
                cardTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (creditCardBillsRefs) db.creditCardBills,
                    if (cardTransactionsRefs) db.cardTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (defaultPaymentAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defaultPaymentAccountId,
                            referencedTable: $$CreditCardsTableReferences
                                ._defaultPaymentAccountIdTable(db),
                            referencedColumn: $$CreditCardsTableReferences
                                ._defaultPaymentAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (creditCardBillsRefs)
                        await $_getPrefetchedData<
                          CreditCardRow,
                          $CreditCardsTable,
                          CreditCardBillRow
                        >(
                          currentTable: table,
                          referencedTable: $$CreditCardsTableReferences
                              ._creditCardBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardBillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardTransactionsRefs)
                        await $_getPrefetchedData<
                          CreditCardRow,
                          $CreditCardsTable,
                          CardTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$CreditCardsTableReferences
                              ._cardTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).cardTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CreditCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardsTable,
      CreditCardRow,
      $$CreditCardsTableFilterComposer,
      $$CreditCardsTableOrderingComposer,
      $$CreditCardsTableAnnotationComposer,
      $$CreditCardsTableCreateCompanionBuilder,
      $$CreditCardsTableUpdateCompanionBuilder,
      (CreditCardRow, $$CreditCardsTableReferences),
      CreditCardRow,
      PrefetchHooks Function({
        bool defaultPaymentAccountId,
        bool creditCardBillsRefs,
        bool cardTransactionsRefs,
      })
    >;
typedef $$CreditCardBillsTableCreateCompanionBuilder =
    CreditCardBillsCompanion Function({
      Value<int> id,
      required int cardId,
      required int referenceYear,
      required int referenceMonth,
      required DateTime closingDate,
      required DateTime dueDate,
      required DateTime createdAt,
    });
typedef $$CreditCardBillsTableUpdateCompanionBuilder =
    CreditCardBillsCompanion Function({
      Value<int> id,
      Value<int> cardId,
      Value<int> referenceYear,
      Value<int> referenceMonth,
      Value<DateTime> closingDate,
      Value<DateTime> dueDate,
      Value<DateTime> createdAt,
    });

final class $$CreditCardBillsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CreditCardBillsTable,
          CreditCardBillRow
        > {
  $$CreditCardBillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditCardsTable _cardIdTable(_$AppDatabase db) => db.creditCards
      .createAlias('credit_card_bills__card_id__credit_cards__id');

  $$CreditCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CreditCardsTableTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CreditCardBillPaymentsTable,
    List<CreditCardBillPaymentRow>
  >
  _creditCardBillPaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.creditCardBillPayments,
        aliasName: 'credit_card_bills__id__credit_card_bill_payments__bill_id',
      );

  $$CreditCardBillPaymentsTableProcessedTableManager
  get creditCardBillPaymentsRefs {
    final manager = $$CreditCardBillPaymentsTableTableManager(
      $_db,
      $_db.creditCardBillPayments,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardBillPaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardInstallmentsTable, List<CardInstallmentRow>>
  _cardInstallmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardInstallments,
    aliasName: 'credit_card_bills__id__card_installments__bill_id',
  );

  $$CardInstallmentsTableProcessedTableManager get cardInstallmentsRefs {
    final manager = $$CardInstallmentsTableTableManager(
      $_db,
      $_db.cardInstallments,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cardInstallmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardBillsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardBillsTable> {
  $$CreditCardBillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceYear => $composableBuilder(
    column: $table.referenceYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceMonth => $composableBuilder(
    column: $table.referenceMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditCardsTableFilterComposer get cardId {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> creditCardBillPaymentsRefs(
    Expression<bool> Function($$CreditCardBillPaymentsTableFilterComposer f) f,
  ) {
    final $$CreditCardBillPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.billId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> cardInstallmentsRefs(
    Expression<bool> Function($$CardInstallmentsTableFilterComposer f) f,
  ) {
    final $$CardInstallmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardInstallments,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardInstallmentsTableFilterComposer(
            $db: $db,
            $table: $db.cardInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardBillsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardBillsTable> {
  $$CreditCardBillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceYear => $composableBuilder(
    column: $table.referenceYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceMonth => $composableBuilder(
    column: $table.referenceMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditCardsTableOrderingComposer get cardId {
    final $$CreditCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditCardBillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardBillsTable> {
  $$CreditCardBillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get referenceYear => $composableBuilder(
    column: $table.referenceYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get referenceMonth => $composableBuilder(
    column: $table.referenceMonth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CreditCardsTableAnnotationComposer get cardId {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> creditCardBillPaymentsRefs<T extends Object>(
    Expression<T> Function($$CreditCardBillPaymentsTableAnnotationComposer a) f,
  ) {
    final $$CreditCardBillPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.billId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cardInstallmentsRefs<T extends Object>(
    Expression<T> Function($$CardInstallmentsTableAnnotationComposer a) f,
  ) {
    final $$CardInstallmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardInstallments,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardInstallmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardBillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardBillsTable,
          CreditCardBillRow,
          $$CreditCardBillsTableFilterComposer,
          $$CreditCardBillsTableOrderingComposer,
          $$CreditCardBillsTableAnnotationComposer,
          $$CreditCardBillsTableCreateCompanionBuilder,
          $$CreditCardBillsTableUpdateCompanionBuilder,
          (CreditCardBillRow, $$CreditCardBillsTableReferences),
          CreditCardBillRow,
          PrefetchHooks Function({
            bool cardId,
            bool creditCardBillPaymentsRefs,
            bool cardInstallmentsRefs,
          })
        > {
  $$CreditCardBillsTableTableManager(
    _$AppDatabase db,
    $CreditCardBillsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardBillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardBillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardBillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardId = const Value.absent(),
                Value<int> referenceYear = const Value.absent(),
                Value<int> referenceMonth = const Value.absent(),
                Value<DateTime> closingDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditCardBillsCompanion(
                id: id,
                cardId: cardId,
                referenceYear: referenceYear,
                referenceMonth: referenceMonth,
                closingDate: closingDate,
                dueDate: dueDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardId,
                required int referenceYear,
                required int referenceMonth,
                required DateTime closingDate,
                required DateTime dueDate,
                required DateTime createdAt,
              }) => CreditCardBillsCompanion.insert(
                id: id,
                cardId: cardId,
                referenceYear: referenceYear,
                referenceMonth: referenceMonth,
                closingDate: closingDate,
                dueDate: dueDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditCardBillsTable, CreditCardBillRow>(table),
                  $$CreditCardBillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cardId = false,
                creditCardBillPaymentsRefs = false,
                cardInstallmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (creditCardBillPaymentsRefs) db.creditCardBillPayments,
                    if (cardInstallmentsRefs) db.cardInstallments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cardId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cardId,
                            referencedTable: $$CreditCardBillsTableReferences
                                ._cardIdTable(db),
                            referencedColumn: $$CreditCardBillsTableReferences
                                ._cardIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (creditCardBillPaymentsRefs)
                        await $_getPrefetchedData<
                          CreditCardBillRow,
                          $CreditCardBillsTable,
                          CreditCardBillPaymentRow
                        >(
                          currentTable: table,
                          referencedTable: $$CreditCardBillsTableReferences
                              ._creditCardBillPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardBillsTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardBillPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardInstallmentsRefs)
                        await $_getPrefetchedData<
                          CreditCardBillRow,
                          $CreditCardBillsTable,
                          CardInstallmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$CreditCardBillsTableReferences
                              ._cardInstallmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardBillsTableReferences(
                                db,
                                table,
                                p0,
                              ).cardInstallmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CreditCardBillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardBillsTable,
      CreditCardBillRow,
      $$CreditCardBillsTableFilterComposer,
      $$CreditCardBillsTableOrderingComposer,
      $$CreditCardBillsTableAnnotationComposer,
      $$CreditCardBillsTableCreateCompanionBuilder,
      $$CreditCardBillsTableUpdateCompanionBuilder,
      (CreditCardBillRow, $$CreditCardBillsTableReferences),
      CreditCardBillRow,
      PrefetchHooks Function({
        bool cardId,
        bool creditCardBillPaymentsRefs,
        bool cardInstallmentsRefs,
      })
    >;
typedef $$CreditCardBillPaymentsTableCreateCompanionBuilder =
    CreditCardBillPaymentsCompanion Function({
      Value<int> id,
      required int billId,
      required int accountId,
      required int amountCents,
      required DateTime paidAt,
      required DateTime createdAt,
    });
typedef $$CreditCardBillPaymentsTableUpdateCompanionBuilder =
    CreditCardBillPaymentsCompanion Function({
      Value<int> id,
      Value<int> billId,
      Value<int> accountId,
      Value<int> amountCents,
      Value<DateTime> paidAt,
      Value<DateTime> createdAt,
    });

final class $$CreditCardBillPaymentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CreditCardBillPaymentsTable,
          CreditCardBillPaymentRow
        > {
  $$CreditCardBillPaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditCardBillsTable _billIdTable(_$AppDatabase db) => db
      .creditCardBills
      .createAlias('credit_card_bill_payments__bill_id__credit_card_bills__id');

  $$CreditCardBillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<int>('bill_id')!;

    final manager = $$CreditCardBillsTableTableManager(
      $_db,
      $_db.creditCardBills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) => db.accounts
      .createAlias('credit_card_bill_payments__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LedgerEntriesTable, List<LedgerEntryRow>>
  _ledgerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ledgerEntries,
    aliasName: 'credit_card_bill_payments__id__ledger_entries__credit_card_bill_payment_id',
  );

  $$LedgerEntriesTableProcessedTableManager get ledgerEntriesRefs {
    final manager = $$LedgerEntriesTableTableManager($_db, $_db.ledgerEntries)
        .filter(
          (f) =>
              f.creditCardBillPaymentId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_ledgerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardBillPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardBillPaymentsTable> {
  $$CreditCardBillPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditCardBillsTableFilterComposer get billId {
    final $$CreditCardBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableFilterComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ledgerEntriesRefs(
    Expression<bool> Function($$LedgerEntriesTableFilterComposer f) f,
  ) {
    final $$LedgerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.creditCardBillPaymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardBillPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardBillPaymentsTable> {
  $$CreditCardBillPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditCardBillsTableOrderingComposer get billId {
    final $$CreditCardBillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditCardBillPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardBillPaymentsTable> {
  $$CreditCardBillPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CreditCardBillsTableAnnotationComposer get billId {
    final $$CreditCardBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ledgerEntriesRefs<T extends Object>(
    Expression<T> Function($$LedgerEntriesTableAnnotationComposer a) f,
  ) {
    final $$LedgerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerEntries,
      getReferencedColumn: (t) => t.creditCardBillPaymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardBillPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardBillPaymentsTable,
          CreditCardBillPaymentRow,
          $$CreditCardBillPaymentsTableFilterComposer,
          $$CreditCardBillPaymentsTableOrderingComposer,
          $$CreditCardBillPaymentsTableAnnotationComposer,
          $$CreditCardBillPaymentsTableCreateCompanionBuilder,
          $$CreditCardBillPaymentsTableUpdateCompanionBuilder,
          (CreditCardBillPaymentRow, $$CreditCardBillPaymentsTableReferences),
          CreditCardBillPaymentRow,
          PrefetchHooks Function({
            bool billId,
            bool accountId,
            bool ledgerEntriesRefs,
          })
        > {
  $$CreditCardBillPaymentsTableTableManager(
    _$AppDatabase db,
    $CreditCardBillPaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardBillPaymentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CreditCardBillPaymentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CreditCardBillPaymentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billId = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditCardBillPaymentsCompanion(
                id: id,
                billId: billId,
                accountId: accountId,
                amountCents: amountCents,
                paidAt: paidAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billId,
                required int accountId,
                required int amountCents,
                required DateTime paidAt,
                required DateTime createdAt,
              }) => CreditCardBillPaymentsCompanion.insert(
                id: id,
                billId: billId,
                accountId: accountId,
                amountCents: amountCents,
                paidAt: paidAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CreditCardBillPaymentsTable,
                    CreditCardBillPaymentRow
                  >(table),
                  $$CreditCardBillPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({billId = false, accountId = false, ledgerEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ledgerEntriesRefs) db.ledgerEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (billId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.billId,
                            referencedTable:
                                $$CreditCardBillPaymentsTableReferences
                                    ._billIdTable(db),
                            referencedColumn:
                                $$CreditCardBillPaymentsTableReferences
                                    ._billIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable:
                                $$CreditCardBillPaymentsTableReferences
                                    ._accountIdTable(db),
                            referencedColumn:
                                $$CreditCardBillPaymentsTableReferences
                                    ._accountIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ledgerEntriesRefs)
                        await $_getPrefetchedData<
                          CreditCardBillPaymentRow,
                          $CreditCardBillPaymentsTable,
                          LedgerEntryRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CreditCardBillPaymentsTableReferences
                                  ._ledgerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardBillPaymentsTableReferences(
                                db,
                                table,
                                p0,
                              ).ledgerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.creditCardBillPaymentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CreditCardBillPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardBillPaymentsTable,
      CreditCardBillPaymentRow,
      $$CreditCardBillPaymentsTableFilterComposer,
      $$CreditCardBillPaymentsTableOrderingComposer,
      $$CreditCardBillPaymentsTableAnnotationComposer,
      $$CreditCardBillPaymentsTableCreateCompanionBuilder,
      $$CreditCardBillPaymentsTableUpdateCompanionBuilder,
      (CreditCardBillPaymentRow, $$CreditCardBillPaymentsTableReferences),
      CreditCardBillPaymentRow,
      PrefetchHooks Function({
        bool billId,
        bool accountId,
        bool ledgerEntriesRefs,
      })
    >;
typedef $$LedgerEntriesTableCreateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      required int accountId,
      required DateTime occurredAt,
      required LedgerEntryType type,
      required int amountCents,
      Value<int?> betId,
      Value<int?> movementId,
      Value<int?> cdbYieldId,
      Value<int?> creditCardBillPaymentId,
      Value<String?> transferGroupId,
      Value<String?> description,
      required DateTime createdAt,
    });
typedef $$LedgerEntriesTableUpdateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<DateTime> occurredAt,
      Value<LedgerEntryType> type,
      Value<int> amountCents,
      Value<int?> betId,
      Value<int?> movementId,
      Value<int?> cdbYieldId,
      Value<int?> creditCardBillPaymentId,
      Value<String?> transferGroupId,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

final class $$LedgerEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerEntryRow> {
  $$LedgerEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('ledger_entries__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BetsTable _betIdTable(_$AppDatabase db) =>
      db.bets.createAlias('ledger_entries__bet_id__bets__id');

  $$BetsTableProcessedTableManager? get betId {
    final $_column = $_itemColumn<int>('bet_id');
    if ($_column == null) return null;
    final manager = $$BetsTableTableManager(
      $_db,
      $_db.bets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_betIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MovementsTable _movementIdTable(_$AppDatabase db) =>
      db.movements.createAlias('ledger_entries__movement_id__movements__id');

  $$MovementsTableProcessedTableManager? get movementId {
    final $_column = $_itemColumn<int>('movement_id');
    if ($_column == null) return null;
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_movementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CdbYieldsTable _cdbYieldIdTable(_$AppDatabase db) =>
      db.cdbYields.createAlias('ledger_entries__cdb_yield_id__cdb_yields__id');

  $$CdbYieldsTableProcessedTableManager? get cdbYieldId {
    final $_column = $_itemColumn<int>('cdb_yield_id');
    if ($_column == null) return null;
    final manager = $$CdbYieldsTableTableManager(
      $_db,
      $_db.cdbYields,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cdbYieldIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CreditCardBillPaymentsTable _creditCardBillPaymentIdTable(
    _$AppDatabase db,
  ) => db.creditCardBillPayments.createAlias(
    'ledger_entries__credit_card_bill_payment_id__credit_card_bill_payments__id',
  );

  $$CreditCardBillPaymentsTableProcessedTableManager?
  get creditCardBillPaymentId {
    final $_column = $_itemColumn<int>('credit_card_bill_payment_id');
    if ($_column == null) return null;
    final manager = $$CreditCardBillPaymentsTableTableManager(
      $_db,
      $_db.creditCardBillPayments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _creditCardBillPaymentIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LedgerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LedgerEntryType, LedgerEntryType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BetsTableFilterComposer get betId {
    final $$BetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableFilterComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovementsTableFilterComposer get movementId {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.movementId,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CdbYieldsTableFilterComposer get cdbYieldId {
    final $$CdbYieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cdbYieldId,
      referencedTable: $db.cdbYields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CdbYieldsTableFilterComposer(
            $db: $db,
            $table: $db.cdbYields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillPaymentsTableFilterComposer get creditCardBillPaymentId {
    final $$CreditCardBillPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.creditCardBillPaymentId,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LedgerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BetsTableOrderingComposer get betId {
    final $$BetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableOrderingComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovementsTableOrderingComposer get movementId {
    final $$MovementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.movementId,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableOrderingComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CdbYieldsTableOrderingComposer get cdbYieldId {
    final $$CdbYieldsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cdbYieldId,
      referencedTable: $db.cdbYields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CdbYieldsTableOrderingComposer(
            $db: $db,
            $table: $db.cdbYields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillPaymentsTableOrderingComposer get creditCardBillPaymentId {
    final $$CreditCardBillPaymentsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.creditCardBillPaymentId,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableOrderingComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LedgerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LedgerEntryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BetsTableAnnotationComposer get betId {
    final $$BetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.betId,
      referencedTable: $db.bets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BetsTableAnnotationComposer(
            $db: $db,
            $table: $db.bets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovementsTableAnnotationComposer get movementId {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.movementId,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CdbYieldsTableAnnotationComposer get cdbYieldId {
    final $$CdbYieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cdbYieldId,
      referencedTable: $db.cdbYields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CdbYieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.cdbYields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillPaymentsTableAnnotationComposer get creditCardBillPaymentId {
    final $$CreditCardBillPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.creditCardBillPaymentId,
          referencedTable: $db.creditCardBillPayments,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardBillPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LedgerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LedgerEntriesTable,
          LedgerEntryRow,
          $$LedgerEntriesTableFilterComposer,
          $$LedgerEntriesTableOrderingComposer,
          $$LedgerEntriesTableAnnotationComposer,
          $$LedgerEntriesTableCreateCompanionBuilder,
          $$LedgerEntriesTableUpdateCompanionBuilder,
          (LedgerEntryRow, $$LedgerEntriesTableReferences),
          LedgerEntryRow,
          PrefetchHooks Function({
            bool accountId,
            bool betId,
            bool movementId,
            bool cdbYieldId,
            bool creditCardBillPaymentId,
          })
        > {
  $$LedgerEntriesTableTableManager(_$AppDatabase db, $LedgerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<LedgerEntryType> type = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int?> betId = const Value.absent(),
                Value<int?> movementId = const Value.absent(),
                Value<int?> cdbYieldId = const Value.absent(),
                Value<int?> creditCardBillPaymentId = const Value.absent(),
                Value<String?> transferGroupId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LedgerEntriesCompanion(
                id: id,
                accountId: accountId,
                occurredAt: occurredAt,
                type: type,
                amountCents: amountCents,
                betId: betId,
                movementId: movementId,
                cdbYieldId: cdbYieldId,
                creditCardBillPaymentId: creditCardBillPaymentId,
                transferGroupId: transferGroupId,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required DateTime occurredAt,
                required LedgerEntryType type,
                required int amountCents,
                Value<int?> betId = const Value.absent(),
                Value<int?> movementId = const Value.absent(),
                Value<int?> cdbYieldId = const Value.absent(),
                Value<int?> creditCardBillPaymentId = const Value.absent(),
                Value<String?> transferGroupId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
              }) => LedgerEntriesCompanion.insert(
                id: id,
                accountId: accountId,
                occurredAt: occurredAt,
                type: type,
                amountCents: amountCents,
                betId: betId,
                movementId: movementId,
                cdbYieldId: cdbYieldId,
                creditCardBillPaymentId: creditCardBillPaymentId,
                transferGroupId: transferGroupId,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LedgerEntriesTable, LedgerEntryRow>(table),
                  $$LedgerEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                betId = false,
                movementId = false,
                cdbYieldId = false,
                creditCardBillPaymentId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$LedgerEntriesTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$LedgerEntriesTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (betId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.betId,
                            referencedTable: $$LedgerEntriesTableReferences
                                ._betIdTable(db),
                            referencedColumn: $$LedgerEntriesTableReferences
                                ._betIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (movementId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.movementId,
                            referencedTable: $$LedgerEntriesTableReferences
                                ._movementIdTable(db),
                            referencedColumn: $$LedgerEntriesTableReferences
                                ._movementIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (cdbYieldId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cdbYieldId,
                            referencedTable: $$LedgerEntriesTableReferences
                                ._cdbYieldIdTable(db),
                            referencedColumn: $$LedgerEntriesTableReferences
                                ._cdbYieldIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (creditCardBillPaymentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.creditCardBillPaymentId,
                            referencedTable: $$LedgerEntriesTableReferences
                                ._creditCardBillPaymentIdTable(db),
                            referencedColumn: $$LedgerEntriesTableReferences
                                ._creditCardBillPaymentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$LedgerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LedgerEntriesTable,
      LedgerEntryRow,
      $$LedgerEntriesTableFilterComposer,
      $$LedgerEntriesTableOrderingComposer,
      $$LedgerEntriesTableAnnotationComposer,
      $$LedgerEntriesTableCreateCompanionBuilder,
      $$LedgerEntriesTableUpdateCompanionBuilder,
      (LedgerEntryRow, $$LedgerEntriesTableReferences),
      LedgerEntryRow,
      PrefetchHooks Function({
        bool accountId,
        bool betId,
        bool movementId,
        bool cdbYieldId,
        bool creditCardBillPaymentId,
      })
    >;
typedef $$CardTransactionsTableCreateCompanionBuilder =
    CardTransactionsCompanion Function({
      Value<int> id,
      required int cardId,
      required CardTransactionType type,
      required String description,
      required int totalAmountCents,
      required DateTime purchaseDate,
      Value<int?> categoryId,
      Value<int> installmentsCount,
      Value<bool> isRecurring,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$CardTransactionsTableUpdateCompanionBuilder =
    CardTransactionsCompanion Function({
      Value<int> id,
      Value<int> cardId,
      Value<CardTransactionType> type,
      Value<String> description,
      Value<int> totalAmountCents,
      Value<DateTime> purchaseDate,
      Value<int?> categoryId,
      Value<int> installmentsCount,
      Value<bool> isRecurring,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CardTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CardTransactionsTable,
          CardTransactionRow
        > {
  $$CardTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditCardsTable _cardIdTable(_$AppDatabase db) => db.creditCards
      .createAlias('card_transactions__card_id__credit_cards__id');

  $$CreditCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CreditCardsTableTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FinancialCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .financialCategories
      .createAlias('card_transactions__category_id__financial_categories__id');

  $$FinancialCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CardInstallmentsTable, List<CardInstallmentRow>>
  _cardInstallmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardInstallments,
    aliasName: 'card_transactions__id__card_installments__card_transaction_id',
  );

  $$CardInstallmentsTableProcessedTableManager get cardInstallmentsRefs {
    final manager = $$CardInstallmentsTableTableManager(
      $_db,
      $_db.cardInstallments,
    ).filter((f) => f.cardTransactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cardInstallmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CardTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $CardTransactionsTable> {
  $$CardTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CardTransactionType,
    CardTransactionType,
    String
  >
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmountCents => $composableBuilder(
    column: $table.totalAmountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentsCount => $composableBuilder(
    column: $table.installmentsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditCardsTableFilterComposer get cardId {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableFilterComposer get categoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cardInstallmentsRefs(
    Expression<bool> Function($$CardInstallmentsTableFilterComposer f) f,
  ) {
    final $$CardInstallmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardInstallments,
      getReferencedColumn: (t) => t.cardTransactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardInstallmentsTableFilterComposer(
            $db: $db,
            $table: $db.cardInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardTransactionsTable> {
  $$CardTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmountCents => $composableBuilder(
    column: $table.totalAmountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentsCount => $composableBuilder(
    column: $table.installmentsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditCardsTableOrderingComposer get cardId {
    final $$CreditCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableOrderingComposer get categoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CardTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardTransactionsTable> {
  $$CardTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CardTransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAmountCents => $composableBuilder(
    column: $table.totalAmountCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installmentsCount => $composableBuilder(
    column: $table.installmentsCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CreditCardsTableAnnotationComposer get cardId {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialCategoriesTableAnnotationComposer get categoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> cardInstallmentsRefs<T extends Object>(
    Expression<T> Function($$CardInstallmentsTableAnnotationComposer a) f,
  ) {
    final $$CardInstallmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardInstallments,
      getReferencedColumn: (t) => t.cardTransactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardInstallmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardTransactionsTable,
          CardTransactionRow,
          $$CardTransactionsTableFilterComposer,
          $$CardTransactionsTableOrderingComposer,
          $$CardTransactionsTableAnnotationComposer,
          $$CardTransactionsTableCreateCompanionBuilder,
          $$CardTransactionsTableUpdateCompanionBuilder,
          (CardTransactionRow, $$CardTransactionsTableReferences),
          CardTransactionRow,
          PrefetchHooks Function({
            bool cardId,
            bool categoryId,
            bool cardInstallmentsRefs,
          })
        > {
  $$CardTransactionsTableTableManager(
    _$AppDatabase db,
    $CardTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardId = const Value.absent(),
                Value<CardTransactionType> type = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> totalAmountCents = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int> installmentsCount = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CardTransactionsCompanion(
                id: id,
                cardId: cardId,
                type: type,
                description: description,
                totalAmountCents: totalAmountCents,
                purchaseDate: purchaseDate,
                categoryId: categoryId,
                installmentsCount: installmentsCount,
                isRecurring: isRecurring,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardId,
                required CardTransactionType type,
                required String description,
                required int totalAmountCents,
                required DateTime purchaseDate,
                Value<int?> categoryId = const Value.absent(),
                Value<int> installmentsCount = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => CardTransactionsCompanion.insert(
                id: id,
                cardId: cardId,
                type: type,
                description: description,
                totalAmountCents: totalAmountCents,
                purchaseDate: purchaseDate,
                categoryId: categoryId,
                installmentsCount: installmentsCount,
                isRecurring: isRecurring,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CardTransactionsTable, CardTransactionRow>(
                    table,
                  ),
                  $$CardTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cardId = false,
                categoryId = false,
                cardInstallmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cardInstallmentsRefs) db.cardInstallments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cardId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cardId,
                            referencedTable: $$CardTransactionsTableReferences
                                ._cardIdTable(db),
                            referencedColumn: $$CardTransactionsTableReferences
                                ._cardIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$CardTransactionsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$CardTransactionsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cardInstallmentsRefs)
                        await $_getPrefetchedData<
                          CardTransactionRow,
                          $CardTransactionsTable,
                          CardInstallmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardTransactionsTableReferences
                              ._cardInstallmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardTransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).cardInstallmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardTransactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CardTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardTransactionsTable,
      CardTransactionRow,
      $$CardTransactionsTableFilterComposer,
      $$CardTransactionsTableOrderingComposer,
      $$CardTransactionsTableAnnotationComposer,
      $$CardTransactionsTableCreateCompanionBuilder,
      $$CardTransactionsTableUpdateCompanionBuilder,
      (CardTransactionRow, $$CardTransactionsTableReferences),
      CardTransactionRow,
      PrefetchHooks Function({
        bool cardId,
        bool categoryId,
        bool cardInstallmentsRefs,
      })
    >;
typedef $$CardInstallmentsTableCreateCompanionBuilder =
    CardInstallmentsCompanion Function({
      Value<int> id,
      required int cardTransactionId,
      required int billId,
      required int installmentNumber,
      required int totalInstallments,
      required int amountCents,
      required DateTime createdAt,
    });
typedef $$CardInstallmentsTableUpdateCompanionBuilder =
    CardInstallmentsCompanion Function({
      Value<int> id,
      Value<int> cardTransactionId,
      Value<int> billId,
      Value<int> installmentNumber,
      Value<int> totalInstallments,
      Value<int> amountCents,
      Value<DateTime> createdAt,
    });

final class $$CardInstallmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CardInstallmentsTable,
          CardInstallmentRow
        > {
  $$CardInstallmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardTransactionsTable _cardTransactionIdTable(_$AppDatabase db) =>
      db.cardTransactions.createAlias(
        'card_installments__card_transaction_id__card_transactions__id',
      );

  $$CardTransactionsTableProcessedTableManager get cardTransactionId {
    final $_column = $_itemColumn<int>('card_transaction_id')!;

    final manager = $$CardTransactionsTableTableManager(
      $_db,
      $_db.cardTransactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardTransactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CreditCardBillsTable _billIdTable(_$AppDatabase db) => db
      .creditCardBills
      .createAlias('card_installments__bill_id__credit_card_bills__id');

  $$CreditCardBillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<int>('bill_id')!;

    final manager = $$CreditCardBillsTableTableManager(
      $_db,
      $_db.creditCardBills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CardInstallmentsTableFilterComposer
    extends Composer<_$AppDatabase, $CardInstallmentsTable> {
  $$CardInstallmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalInstallments => $composableBuilder(
    column: $table.totalInstallments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CardTransactionsTableFilterComposer get cardTransactionId {
    final $$CardTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardTransactionId,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillsTableFilterComposer get billId {
    final $$CreditCardBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableFilterComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardInstallmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardInstallmentsTable> {
  $$CardInstallmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalInstallments => $composableBuilder(
    column: $table.totalInstallments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardTransactionsTableOrderingComposer get cardTransactionId {
    final $$CardTransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardTransactionId,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillsTableOrderingComposer get billId {
    final $$CreditCardBillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardInstallmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardInstallmentsTable> {
  $$CardInstallmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalInstallments => $composableBuilder(
    column: $table.totalInstallments,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CardTransactionsTableAnnotationComposer get cardTransactionId {
    final $$CardTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardTransactionId,
      referencedTable: $db.cardTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CreditCardBillsTableAnnotationComposer get billId {
    final $$CreditCardBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.creditCardBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCardBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardInstallmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardInstallmentsTable,
          CardInstallmentRow,
          $$CardInstallmentsTableFilterComposer,
          $$CardInstallmentsTableOrderingComposer,
          $$CardInstallmentsTableAnnotationComposer,
          $$CardInstallmentsTableCreateCompanionBuilder,
          $$CardInstallmentsTableUpdateCompanionBuilder,
          (CardInstallmentRow, $$CardInstallmentsTableReferences),
          CardInstallmentRow,
          PrefetchHooks Function({bool cardTransactionId, bool billId})
        > {
  $$CardInstallmentsTableTableManager(
    _$AppDatabase db,
    $CardInstallmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardInstallmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardInstallmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardInstallmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardTransactionId = const Value.absent(),
                Value<int> billId = const Value.absent(),
                Value<int> installmentNumber = const Value.absent(),
                Value<int> totalInstallments = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CardInstallmentsCompanion(
                id: id,
                cardTransactionId: cardTransactionId,
                billId: billId,
                installmentNumber: installmentNumber,
                totalInstallments: totalInstallments,
                amountCents: amountCents,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardTransactionId,
                required int billId,
                required int installmentNumber,
                required int totalInstallments,
                required int amountCents,
                required DateTime createdAt,
              }) => CardInstallmentsCompanion.insert(
                id: id,
                cardTransactionId: cardTransactionId,
                billId: billId,
                installmentNumber: installmentNumber,
                totalInstallments: totalInstallments,
                amountCents: amountCents,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CardInstallmentsTable, CardInstallmentRow>(
                    table,
                  ),
                  $$CardInstallmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardTransactionId = false, billId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardTransactionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardTransactionId,
                        referencedTable: $$CardInstallmentsTableReferences
                            ._cardTransactionIdTable(db),
                        referencedColumn: $$CardInstallmentsTableReferences
                            ._cardTransactionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (billId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.billId,
                        referencedTable: $$CardInstallmentsTableReferences
                            ._billIdTable(db),
                        referencedColumn: $$CardInstallmentsTableReferences
                            ._billIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CardInstallmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardInstallmentsTable,
      CardInstallmentRow,
      $$CardInstallmentsTableFilterComposer,
      $$CardInstallmentsTableOrderingComposer,
      $$CardInstallmentsTableAnnotationComposer,
      $$CardInstallmentsTableCreateCompanionBuilder,
      $$CardInstallmentsTableUpdateCompanionBuilder,
      (CardInstallmentRow, $$CardInstallmentsTableReferences),
      CardInstallmentRow,
      PrefetchHooks Function({bool cardTransactionId, bool billId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$BetsTableTableManager get bets => $$BetsTableTableManager(_db, _db.bets);
  $$BetLegsTableTableManager get betLegs =>
      $$BetLegsTableTableManager(_db, _db.betLegs);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(_db, _db.financialCategories);
  $$BillsPayableTableTableManager get billsPayable =>
      $$BillsPayableTableTableManager(_db, _db.billsPayable);
  $$BillsReceivableTableTableManager get billsReceivable =>
      $$BillsReceivableTableTableManager(_db, _db.billsReceivable);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db, _db.movements);
  $$CdbYieldsTableTableManager get cdbYields =>
      $$CdbYieldsTableTableManager(_db, _db.cdbYields);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db, _db.creditCards);
  $$CreditCardBillsTableTableManager get creditCardBills =>
      $$CreditCardBillsTableTableManager(_db, _db.creditCardBills);
  $$CreditCardBillPaymentsTableTableManager get creditCardBillPayments =>
      $$CreditCardBillPaymentsTableTableManager(
        _db,
        _db.creditCardBillPayments,
      );
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$CardTransactionsTableTableManager get cardTransactions =>
      $$CardTransactionsTableTableManager(_db, _db.cardTransactions);
  $$CardInstallmentsTableTableManager get cardInstallments =>
      $$CardInstallmentsTableTableManager(_db, _db.cardInstallments);
}
