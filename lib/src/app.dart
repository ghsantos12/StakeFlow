import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'core/theme/app_theme.dart';
import 'providers/settings_providers.dart';
import 'routing/app_router.dart';

class StakeFlowApp extends ConsumerWidget {
  const StakeFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'StakeFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
      builder: (context, child) => _AppLockGate(child: child ?? const SizedBox.shrink()),
    );
  }
}

class _AppLockGate extends ConsumerStatefulWidget {
  const _AppLockGate({required this.child});
  final Widget child;

  @override
  ConsumerState<_AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<_AppLockGate> {
  bool _unlocked = false;
  bool _checked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_checked) {
      _checked = true;
      final enabled = ref.read(biometricEnabledProvider);
      if (!enabled) {
        _unlocked = true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
      }
    }
  }

  Future<void> _authenticate() async {
    final auth = LocalAuthentication();
    try {
      final success = await auth.authenticate(
        localizedReason: 'Desbloqueie o StakeFlow para continuar',
      );
      if (mounted) setState(() => _unlocked = success);
    } catch (_) {
      if (mounted) setState(() => _unlocked = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_unlocked) return widget.child;
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 48),
              const SizedBox(height: 16),
              const Text('StakeFlow bloqueado'),
              const SizedBox(height: 16),
              FilledButton(onPressed: _authenticate, child: const Text('Desbloquear')),
            ],
          ),
        ),
      ),
    );
  }
}
