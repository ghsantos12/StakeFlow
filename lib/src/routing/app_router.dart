import 'package:go_router/go_router.dart';
import 'app_shell.dart';
import 'finance_shell.dart';
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
import '../features/finance_dashboard/presentation/screens/financial_dashboard_screen.dart';
import '../features/finance_transactions/presentation/screens/financial_transactions_screen.dart';
import '../features/finance_transactions/presentation/screens/financial_transaction_form_screen.dart';
import '../features/finance_credit_cards/presentation/screens/credit_cards_list_screen.dart';
import '../features/finance_credit_cards/presentation/screens/credit_card_form_screen.dart';
import '../features/finance_credit_cards/presentation/screens/credit_card_detail_screen.dart';
import '../features/finance_credit_cards/presentation/screens/card_transaction_form_screen.dart';
import '../features/finance_credit_cards/presentation/screens/credit_card_bill_detail_screen.dart';
import '../features/finance_bills/presentation/screens/bills_hub_screen.dart';
import '../features/finance_bills/presentation/screens/bill_payable_form_screen.dart';
import '../features/finance_bills/presentation/screens/bill_receivable_form_screen.dart';
import '../features/finance_categories/presentation/screens/categories_screen.dart';
import '../features/finance_forecast/presentation/screens/forecast_screen.dart';
import '../features/finance_reports/presentation/screens/financial_reports_screen.dart';
import '../features/finance_more/presentation/screens/finance_more_screen.dart';

GoRouter createAppRouter({required String initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation,
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => FinanceShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/financas', builder: (context, state) => const FinancialDashboardScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/financas/extrato',
              builder: (context, state) => const FinancialTransactionsScreen(),
              routes: [
                GoRoute(
                  path: 'novo',
                  builder: (context, state) => const FinancialTransactionFormScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) => FinancialTransactionFormScreen(
                    movementId: int.parse(state.pathParameters['id']!),
                  ),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/financas/cartoes',
              builder: (context, state) => const CreditCardsListScreen(),
              routes: [
                GoRoute(path: 'novo', builder: (context, state) => const CreditCardFormScreen()),
                GoRoute(
                  path: ':id',
                  builder: (context, state) =>
                      CreditCardDetailScreen(cardId: int.parse(state.pathParameters['id']!)),
                  routes: [
                    GoRoute(
                      path: 'editar',
                      builder: (context, state) =>
                          CreditCardFormScreen(cardId: int.parse(state.pathParameters['id']!)),
                    ),
                    GoRoute(
                      path: 'nova-compra',
                      builder: (context, state) =>
                          CardTransactionFormScreen(cardId: int.parse(state.pathParameters['id']!)),
                    ),
                    GoRoute(
                      path: 'fatura/:billId',
                      builder: (context, state) => CreditCardBillDetailScreen(
                        cardId: int.parse(state.pathParameters['id']!),
                        billId: int.parse(state.pathParameters['billId']!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/financas/contas',
              builder: (context, state) => const BillsHubScreen(),
              routes: [
                GoRoute(
                  path: 'pagar/novo',
                  builder: (context, state) => const BillPayableFormScreen(),
                ),
                GoRoute(
                  path: 'pagar/:id',
                  builder: (context, state) =>
                      BillPayableFormScreen(billId: int.parse(state.pathParameters['id']!)),
                ),
                GoRoute(
                  path: 'receber/novo',
                  builder: (context, state) => const BillReceivableFormScreen(),
                ),
                GoRoute(
                  path: 'receber/:id',
                  builder: (context, state) =>
                      BillReceivableFormScreen(billId: int.parse(state.pathParameters['id']!)),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/financas/mais',
              builder: (context, state) => const FinanceMoreScreen(),
              routes: [
                GoRoute(path: 'categorias', builder: (context, state) => const CategoriesScreen()),
                GoRoute(path: 'previsao', builder: (context, state) => const ForecastScreen()),
                GoRoute(path: 'relatorios', builder: (context, state) => const FinancialReportsScreen()),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
}
