import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/update_dialog.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/core_providers.dart';
import '../../../../providers/service_providers.dart';
import '../../../../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final blockInsufficient = ref.watch(blockInsufficientBalanceProvider);
    final annualCdi = ref.watch(annualCdiRateProvider);
    final biometricEnabled = ref.watch(biometricEnabledProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _SectionHeader('Contas'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_outlined),
              title: const Text('Gerenciar contas'),
              subtitle: const Text('Contas bancárias e casas de apostas'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/accounts'),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Aparência'),
          Card(
            child: RadioGroup<ThemeMode>(
              groupValue: themeMode,
              onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!),
              child: const Column(
                children: [
                  RadioListTile<ThemeMode>(title: Text('Automático (sistema)'), value: ThemeMode.system),
                  RadioListTile<ThemeMode>(title: Text('Claro'), value: ThemeMode.light),
                  RadioListTile<ThemeMode>(title: Text('Escuro'), value: ThemeMode.dark),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Segurança financeira'),
          Card(
            child: SwitchListTile(
              title: const Text('Bloquear saldo insuficiente'),
              subtitle: const Text('Impede apostas e movimentações que excedam o saldo disponível'),
              value: blockInsufficient,
              onChanged: (v) => ref.read(blockInsufficientBalanceProvider.notifier).setValue(v),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Rendimento de CDB'),
          Card(
            child: ListTile(
              title: const Text('Taxa anual do CDI (%)'),
              subtitle: Text('${annualCdi.toStringAsFixed(2)}% a.a. — usada apenas para estimativas'),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () => _editCdiRate(context, ref, annualCdi),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Bloqueio do aplicativo'),
          Card(
            child: SwitchListTile(
              title: const Text('Exigir biometria/PIN ao abrir'),
              value: biometricEnabled,
              onChanged: (v) => _toggleBiometric(context, ref, v),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Dados'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.table_chart_outlined),
                  title: const Text('Exportar apostas (CSV)'),
                  onTap: () => _exportCsv(context, ref, isBets: true),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.table_chart_outlined),
                  title: const Text('Exportar movimentações (CSV)'),
                  onTap: () => _exportCsv(context, ref, isBets: false),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.backup_outlined),
                  title: const Text('Exportar backup completo (JSON)'),
                  onTap: () => _exportBackup(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore_outlined),
                  title: const Text('Importar backup'),
                  onTap: () => _importBackup(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Sobre'),
          Card(
            child: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final version = snapshot.data?.version;
                return ListTile(
                  leading: const Icon(Icons.system_update_alt_outlined),
                  title: const Text('Verificar atualizações'),
                  subtitle: Text(version != null ? 'Versão instalada: $version' : 'Carregando versão...'),
                  onTap: () => _checkForUpdates(context, ref),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Zona de risco'),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete_forever_outlined, color: Theme.of(context).colorScheme.error),
              title: Text('Apagar todos os dados', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => _clearAllData(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editCdiRate(BuildContext context, WidgetRef ref, double current) async {
    final controller = TextEditingController(text: current.toStringAsFixed(2));
    final result = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Taxa anual do CDI'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(suffixText: '% a.a.'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(double.tryParse(controller.text.replaceAll(',', '.'))),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (result != null) {
      await ref.read(annualCdiRateProvider.notifier).setValue(result);
    }
  }

  Future<void> _checkForUpdates(BuildContext context, WidgetRef ref) async {
    final update = await ref.read(updateServiceProvider).checkForUpdate();
    if (!context.mounted) return;
    if (update != null) {
      await showUpdateDialog(context, update);
    } else {
      showAppSnackBar(context, 'Você já está na versão mais recente.');
    }
  }

  Future<void> _toggleBiometric(BuildContext context, WidgetRef ref, bool enable) async {
    if (enable) {
      final auth = LocalAuthentication();
      try {
        final canCheck = await auth.canCheckBiometrics || await auth.isDeviceSupported();
        if (!canCheck) {
          if (context.mounted) {
            showAppSnackBar(context, 'Biometria não disponível neste dispositivo.', isError: true);
          }
          return;
        }
      } catch (_) {
        if (context.mounted) {
          showAppSnackBar(context, 'Biometria não disponível neste dispositivo.', isError: true);
        }
        return;
      }
    }
    await ref.read(biometricEnabledProvider.notifier).setValue(enable);
  }

  Future<void> _exportCsv(BuildContext context, WidgetRef ref, {required bool isBets}) async {
    final backupService = ref.read(backupServiceProvider);
    final csv = isBets ? await backupService.exportBetsCsv() : await backupService.exportMovementsCsv();
    final dir = await getTemporaryDirectory();
    final fileName = isBets ? 'stakeflow_apostas.csv' : 'stakeflow_movimentacoes.csv';
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(csv);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    final backupService = ref.read(backupServiceProvider);
    final json = await backupService.exportBackupJson();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/stakeflow_backup.json');
    await file.writeAsString(json);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Importar backup',
      message: 'Isso substituirá TODOS os dados atuais pelos dados do arquivo selecionado. Continuar?',
      confirmLabel: 'Importar',
    );
    if (!confirmed) return;

    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null || result.path == null) return;

    try {
      final content = await File(result.path!).readAsString();
      await ref.read(backupServiceProvider).importBackupJson(content);
      if (context.mounted) showAppSnackBar(context, 'Backup importado com sucesso.');
    } on ValidationException catch (e) {
      if (context.mounted) showAppSnackBar(context, e.message, isError: true);
    } catch (e) {
      if (context.mounted) showAppSnackBar(context, 'Erro ao importar: $e', isError: true);
    }
  }

  Future<void> _clearAllData(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Apagar todos os dados',
      message: 'Esta ação é irreversível. Todas as contas, apostas e movimentações serão excluídas.',
      confirmLabel: 'Apagar tudo',
    );
    if (!confirmed) return;
    final db = ref.read(databaseProvider);
    await db.transaction(() async {
      await db.delete(db.ledgerEntries).go();
      await db.delete(db.cdbYields).go();
      await db.delete(db.movements).go();
      await db.delete(db.bets).go();
      await db.delete(db.accounts).go();
    });
    if (context.mounted) showAppSnackBar(context, 'Todos os dados foram apagados.');
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}
