import 'dart:async';

import 'package:ecom_flutter/features/authentication/presentation/pages/register_view.dart';
import 'package:ecom_flutter/features/authentication/presentation/pages/verify_email_view.dart';
import 'package:ecom_flutter/features/dashboard/presentation/pages/dashboard_view.dart';
import 'package:ecom_flutter/utils/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/manager/authentication_bloc.dart';
import '../../features/authentication/presentation/pages/login_view.dart';
import '../../main.dart';

extension StringExtensions on String {
  String get convertRoutePathToRouteName => replaceAll("/", "");
}

class GoRouterNavigationDelegate {
  static final GoRouterNavigationDelegate _singleton =
      GoRouterNavigationDelegate._internal();

  factory GoRouterNavigationDelegate() {
    return _singleton;
  }

  GoRouterNavigationDelegate._internal();

  List<String> routes = [
    NavigationRouteNames.authRoute,
    "${NavigationRouteNames.authRoute}${NavigationRouteNames.registerRoute}",
    "${NavigationRouteNames.authRoute}${NavigationRouteNames.registerRoute}${NavigationRouteNames.verifyAccountRoute}",
  ];

  final parentNavigationKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: parentNavigationKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authenticationBloc.stream),
    redirect: (ctx, state) async {
      final status = authenticationBloc.state;

      final loggedIn = status is AuthenticationAuthenticated;

      final logging = routes.contains(state.matchedLocation);

      if (!loggedIn && !logging) return NavigationRouteNames.authRoute;

      if (loggedIn && logging) return NavigationRouteNames.homeRoute;

      return null;
    },
    initialLocation: authenticationBloc.state is AuthenticationAuthenticated
        ? NavigationRouteNames.homeRoute
        : NavigationRouteNames.authRoute,
    routes: [
      GoRoute(
          parentNavigatorKey: parentNavigationKey,
          path: NavigationRouteNames.authRoute,
          name: NavigationRouteNames.authRoute.convertRoutePathToRouteName,
          builder: (BuildContext ctx, GoRouterState state) => const LoginView(),
          routes: [
            GoRoute(
                parentNavigatorKey: parentNavigationKey,
                path: NavigationRouteNames
                    .registerRoute.convertRoutePathToRouteName,
                name: NavigationRouteNames
                    .registerRoute.convertRoutePathToRouteName,
                builder: (BuildContext ctx, GoRouterState state) =>
                    const RegisterView(),
                routes: [
                  GoRoute(
                      parentNavigatorKey: parentNavigationKey,
                      path: NavigationRouteNames
                          .verifyAccountRoute.convertRoutePathToRouteName,
                      name: NavigationRouteNames
                          .verifyAccountRoute.convertRoutePathToRouteName,
                      builder: (BuildContext ctx, GoRouterState state) {
                        var userEmail = state.uri.queryParameters;

                        return VerifyEmailView(
                          userEmail: userEmail["email"] ?? "",
                        );
                      }),
                  //verifyAccountRoute
                ]),
          ]),

      GoRoute(
        path: NavigationRouteNames.homeRoute,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DashboardView()
        ),
      ),
      // StatefulShellRoute.indexedStack(
      //     builder: (context, state, navigationShell) {
      //       return DashboardPage(
      //         navigationShell: navigationShell,
      //       );
      //     },
      //     branches: [
      //       StatefulShellBranch(
      //         navigatorKey: _nestedNavigation1Key,
      //         routes: [
      //           GoRoute(
      //               path: NavigationRouteNames.homeRoute,
      //               parentNavigatorKey: _nestedNavigation1Key,
      //               pageBuilder: (context, state) => const NoTransitionPage(
      //                     child: HomeView(),
      //                   ),
      //               routes: const []),
      //         ],
      //       ),
      //       StatefulShellBranch(
      //         navigatorKey: _nestedNavigationUserKey,
      //         routes: [
      //           GoRoute(
      //             path: NavigationRouteNames.usersRoute,
      //             parentNavigatorKey: _nestedNavigationUserKey,
      //             pageBuilder: (context, state) => const NoTransitionPage(
      //               child: UsersView(),
      //             ),
      //             routes: [
      //               GoRoute(
      //                 path: NavigationRouteNames
      //                     .addUserRoute.convertRoutePathToRouteName,
      //                 name: NavigationRouteNames
      //                     .addUserRoute.convertRoutePathToRouteName,
      //                 pageBuilder: (context, state) => const MaterialPage(
      //                   fullscreenDialog: true,
      //                   child: AddUserView(),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ]),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
