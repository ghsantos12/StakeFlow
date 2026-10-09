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
            'cdbAccumulatedBeforeTrackingCents: $cdbAccumulatedBeforeTrackingCents',
          )
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
              this.cdbAccumulatedBeforeTrackingCents);
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
            'cdbAccumulatedBeforeTrackingCents: $cdbAccumulatedBeforeTrackingCents',
          )
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
    resultCents,
    notes,
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
      resultCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}result_cents'],
      ),
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
  $BetsTable createAlias(String alias) {
    return $BetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BetStatus, String, String> $converterstatus =
      const EnumNameConverter<BetStatus>(BetStatus.values);
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

  /// Resultado financeiro realizado (lucro/prejuízo) em centavos.
  /// Nulo enquanto a aposta estiver em aberto.
  final int? resultCents;
  final String? notes;
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
    this.resultCents,
    this.notes,
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
    if (!nullToAbsent || resultCents != null) {
      map['result_cents'] = Variable<int>(resultCents);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
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
      resultCents: resultCents == null && nullToAbsent
          ? const Value.absent()
          : Value(resultCents),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
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
      resultCents: serializer.fromJson<int?>(json['resultCents']),
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
      'resultCents': serializer.toJson<int?>(resultCents),
      'notes': serializer.toJson<String?>(notes),
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
    Value<int?> resultCents = const Value.absent(),
    Value<String?> notes = const Value.absent(),
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
    resultCents: resultCents.present ? resultCents.value : this.resultCents,
    notes: notes.present ? notes.value : this.notes,
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
      resultCents: data.resultCents.present
          ? data.resultCents.value
          : this.resultCents,
      notes: data.notes.present ? data.notes.value : this.notes,
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
          ..write('resultCents: $resultCents, ')
          ..write('notes: $notes, ')
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
    resultCents,
    notes,
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
          other.resultCents == this.resultCents &&
          other.notes == this.notes &&
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
  final Value<int?> resultCents;
  final Value<String?> notes;
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
    this.resultCents = const Value.absent(),
    this.notes = const Value.absent(),
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
    this.resultCents = const Value.absent(),
    this.notes = const Value.absent(),
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
    Expression<int>? resultCents,
    Expression<String>? notes,
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
      if (resultCents != null) 'result_cents': resultCents,
      if (notes != null) 'notes': notes,
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
    Value<int?>? resultCents,
    Value<String?>? notes,
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
      resultCents: resultCents ?? this.resultCents,
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
    if (resultCents.present) {
      map['result_cents'] = Variable<int>(resultCents.value);
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
          ..write('resultCents: $resultCents, ')
          ..write('notes: $notes, ')
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
          ..write('transferGroupId: $transferGroupId, ')
          ..write('description: $description, ')
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
  late final $MovementsTable movements = $MovementsTable(this);
  late final $CdbYieldsTable cdbYields = $CdbYieldsTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final BetsDao betsDao = BetsDao(this as AppDatabase);
  late final MovementsDao movementsDao = MovementsDao(this as AppDatabase);
  late final LedgerDao ledgerDao = LedgerDao(this as AppDatabase);
  late final CdbYieldsDao cdbYieldsDao = CdbYieldsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    bets,
    movements,
    cdbYields,
    ledgerEntries,
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
            bool cdbYieldsRefs,
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
                cdbYieldsRefs = false,
                ledgerEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (betsRefs) db.bets,
                    if (cdbYieldsRefs) db.cdbYields,
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
        bool cdbYieldsRefs,
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
  Value<int?> resultCents,
  Value<String?> notes,
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
  Value<int?> resultCents,
  Value<String?> notes,
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

  ColumnFilters<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
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

  ColumnOrderings<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
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

  GeneratedColumn<int> get resultCents => $composableBuilder(
    column: $table.resultCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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
          PrefetchHooks Function({bool accountId, bool ledgerEntriesRefs})
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
                Value<int?> resultCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
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
                resultCents: resultCents,
                notes: notes,
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
                Value<int?> resultCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
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
                resultCents: resultCents,
                notes: notes,
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
      PrefetchHooks Function({bool accountId, bool ledgerEntriesRefs})
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
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$BetsTableTableManager get bets => $$BetsTableTableManager(_db, _db.bets);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db, _db.movements);
  $$CdbYieldsTableTableManager get cdbYields =>
      $$CdbYieldsTableTableManager(_db, _db.cdbYields);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
}
