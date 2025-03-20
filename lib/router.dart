import 'package:city_keystones/components/navigation_shell.dart';
import 'package:city_keystones/pages/city_page.dart';
import 'package:city_keystones/pages/home_page.dart';
import 'package:city_keystones/pages/map_page.dart';
import 'package:city_keystones/pages/settings_page.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

final router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              BottomNavigationBar(navigationShell: navigationShell),
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
              ]
            ),
          ],
        ),        
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'map',
              path: '/map',
              builder: (context, state) {
                final lat = double.tryParse(state.uri.queryParameters['lat'] ?? '');
                final lng = double.tryParse(state.uri.queryParameters['lng'] ?? '');
                return MapPage(center: lat != null && lng != null ? LatLng(lat, lng) : null);
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
// Added missing closing parenthesis here// Added mi// Added missing closing parenthesis heressing closing parenthesis here