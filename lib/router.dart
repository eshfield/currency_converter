import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'presentation/common/route_placeholder.dart';
import 'presentation/screens/converter_screen/converter_screen.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'presentation/shell.dart';

enum Routes {
  home('/home'),
  converter('converter'),
  atms('/atms'),
  moneyBox('/money-box');

  final String path;

  const Routes(this.path);
}

final routerConfig = GoRouter(
  initialLocation: Routes.home.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final l10n = AppLocalizations.of(context);
        final currentRoute = Routes.values
            .where((route) => state.fullPath!.endsWith(route.path))
            .first;
        final label = switch (currentRoute) {
          Routes.home => l10n.homeRouteLabel,
          Routes.converter => l10n.converterRouteLabel,
          Routes.atms => l10n.atmsRouteLabel,
          Routes.moneyBox => l10n.moneyBoxRouteLabel,
        };
        return Shell(
          appBarTitle: label,
          isAppBarBackButtonVisible: !currentRoute.path.startsWith('/'),
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home.path,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: Routes.converter.path,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const ConverterScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.atms.path,
              builder: (context, state) {
                final l10n = AppLocalizations.of(context);
                return RoutePlaceholder(label: l10n.atmsRouteLabel);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.moneyBox.path,
              builder: (context, state) {
                final l10n = AppLocalizations.of(context);
                return RoutePlaceholder(label: l10n.moneyBoxRouteLabel);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
