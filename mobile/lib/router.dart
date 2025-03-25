import 'package:city_keystones/components/navigation_shell.dart';
import 'package:city_keystones/pages/city_page.dart';
import 'package:city_keystones/pages/home_page.dart';
import 'package:city_keystones/pages/login_page.dart';
import 'package:city_keystones/pages/map_page.dart';
import 'package:city_keystones/pages/settings_page.dart';
import 'package:city_keystones/state/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final navigatoreKey = GlobalKey<NavigatorState>();
Uri? initUrl = Uri.base;

@riverpod
GoRouter router(Ref ref) {
  final apiState = ref.watch(apiProvider);

  return GoRouter(
    initialLocation: initUrl?.path,
    navigatorKey: navigatoreKey,
    redirect: (context, state) async {
      return apiState.when(
        data: (api) {
          // build initial path
          String? path = initUrl?.path;
          final queryString = initUrl?.query.trim() ?? "";
          if (queryString.isNotEmpty && path != null) {
            path += "?$queryString";
          }
          // If user is not authenticated, direct to login screen
          if (!api.isAuthorized() && initUrl?.path != '/login') {
            return '/login';
          }
          // If user is authenticated and trying to access login or loading, direct to home
          if (api.isAuthorized() &&
              (initUrl?.path == '/login' || initUrl?.path == '/loading')) {
            return "/";
          }
          // After handling initial redirection, clear initUrl to prevent repeated redirections
          initUrl = null;
          return path;
        },
        error: (_, _) => '/loading',
        loading: () => '/login',
      );
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(
        name: 'loading',
        path: '/loading',
        builder: (context, state) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, GoRouterState state, navigationShell) {
          return BottomNavigationShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'cities',
                path: '/',
                builder: (context, state) => HomePage(),
                routes: [
                  GoRoute(
                    name: 'city',
                    path: '/cities/:cityId',
                    builder: (context, state) {
                      final cityId = state.pathParameters['cityId'] ?? '1';
                      return CityPage(cityId: cityId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'map',
                path: '/map',
                builder: (context, state) {
                  final lat = double.tryParse(
                    state.uri.queryParameters['lat'] ?? '',
                  );
                  final lng = double.tryParse(
                    state.uri.queryParameters['lng'] ?? '',
                  );
                  return MapPage(
                    center:
                        lat != null && lng != null ? LatLng(lat, lng) : null,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'settings',
                path: '/settings',
                builder: (context, state) => SettingsPage(),
              ),
            ],
          ),
        ],
      ), // Added missing closing parenthesis here
    ],
  );
}

// Added missing closing parenthesis here// Added mi// Added missing closing parenthesis heressing closing parenthesis here
