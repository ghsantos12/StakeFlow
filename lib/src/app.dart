import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'core/theme/app_theme.dart';
import 'providers/settings_providers.dart';
import 'routing/app_router.dart';

class StakeFlowApp extends ConsumerStatefulWidget {
  const StakeFlowApp({super.key, required this.initialLocation});

  final String initialLocation;

  @override
  ConsumerState<StakeFlowApp> createState() => _StakeFlowAppState();
}

class _StakeFlowAppState extends ConsumerState<StakeFlowApp> {
  late final GoRouter _router = createAppRouter(initialLocation: widget.initialLocation);

  @override
  Widget build(BuildContext context) {
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
      routerConfig: _router,
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
  bool _authenticating = false;
  String? _error;

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
    if (_authenticating) return;
    setState(() {
      _authenticating = true;
      _error = null;
    });
    final auth = LocalAuthentication();
    try {
      final success = await auth.authenticate(
        localizedReason: 'Desbloqueie o StakeFlow para continuar',
        options: const AuthenticationOptions(biometricOnly: false),
      );
      if (mounted) {
        setState(() {
          _unlocked = success;
          _authenticating = false;
          if (!success) _error = 'Não foi possível confirmar sua identidade. Tente novamente.';
        });
      }
    } on PlatformException catch (e) {
      if (mounted) {
        setState(() {
          _authenticating = false;
          _error = e.message ?? 'Não foi possível abrir a biometria/PIN do aparelho.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _authenticating = false;
          _error = 'Erro inesperado ao desbloquear: $e';
        });
      }
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
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _authenticating ? null : _authenticate,
                child: _authenticating
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Desbloquear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
