import 'package:go_router/go_router.dart';
import 'app_shell.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/bets/presentation/screens/bets_list_screen.dart';
import '../features/bets/presentation/screens/bet_form_screen.dart';
import '../features/transactions/presentation/screens/movements_list_screen.dart';
import '../features/transactions/presentation/screens/movement_form_screen.dart';
import '../features/reports/presentation/screens/reports_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/accounts/presentation/screens/accounts_list_screen.dart';
import '../features/accounts/presentation/screens/account_form_screen.dart';
import '../features/accounts/presentation/screens/account_detail_screen.dart';
import '../features/cdb/presentation/screens/cdb_yields_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/bets',
            builder: (context, state) => const BetsListScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const BetFormScreen()),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    BetFormScreen(betId: int.parse(state.pathParameters['id']!)),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/movements',
            builder: (context, state) => const MovementsListScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const MovementFormScreen()),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    MovementFormScreen(movementId: int.parse(state.pathParameters['id']!)),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/reports', builder: (context, state) => const ReportsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'accounts',
                builder: (context, state) => const AccountsListScreen(),
                routes: [
                  GoRoute(path: 'new', builder: (context, state) => const AccountFormScreen()),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        AccountDetailScreen(accountId: int.parse(state.pathParameters['id']!)),
                  ),
                  GoRoute(
                    path: ':id/edit',
                    builder: (context, state) =>
                        AccountFormScreen(accountId: int.parse(state.pathParameters['id']!)),
                  ),
                  GoRoute(
                    path: ':id/cdb-yields',
                    builder: (context, state) =>
                        CdbYieldsScreen(accountId: int.parse(state.pathParameters['id']!)),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ],
    ),
  ],
);
