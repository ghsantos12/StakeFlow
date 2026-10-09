import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';

@DataClassName('FinancialCategoryRow')
class FinancialCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get kind => textEnum<CategoryKind>()();

  /// Subcategoria: referencia a categoria "pai". Nulo para categorias de
  /// nível superior.
  IntColumn get parentCategoryId => integer().nullable().references(FinancialCategories, #id)();

  /// Código do ícone (Icons.*.codePoint) usado na UI.
  IntColumn get iconCodePoint => integer().withDefault(const Constant(0xe8b8))();

  /// Cor ARGB de identificação.
  IntColumn get colorValue => integer().withDefault(const Constant(0xFF2563EB))();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
