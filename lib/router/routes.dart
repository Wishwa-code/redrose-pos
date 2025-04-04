//! this is expantion about what is happening here  intial spashl screen route calles "/" home route
//! then it checks the permission of the curren user and if its a normal user he wiill be sent to
//! user route which is inside the shellroute if not he will sent to admin or guest route according gly
//! since curretnly all the values are hardcoded to make every user normalk user both router per guest user and admin user are bypassed to get to
//! user page
//

import 'dart:async';

import 'package:example/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../entities/navigation_destinations.dart';

import '../pages/admin_page.dart';
import '../pages/cashier_page.dart';
import '../pages/guest_page.dart';
import '../pages/hello_world_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/splash_page.dart';
import '../pages/user_page.dart';

import '../state/permissions.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<AdminRoute>(path: 'admin'),
    TypedGoRoute<GuestRoute>(path: 'guest'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  /// Important note on this redirect function: this isn't reactive.
  /// No redirect will be triggered on a user role change.
  ///
  /// This is currently unsupported.
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final userRole = await ProviderScope.containerOf(context).read(
      permissionsProvider.future,
    );

    return userRole.map(
      admin: (_) => const AdminRoute().location,
      user: (_) => const UserRoute().location,
      guest: (_) => const GuestRoute().location,
      none: (_) => null,
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedShellRoute<MyShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<UserRoute>(
      path: '/users',
    ),
    TypedGoRoute<HelloWorldRoute>(
      path: '/hello',
    ),
    TypedGoRoute<CashierRoute>(
      path: '/cashier',
    ),
  ],
)
class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MyShellRouteScreen(child: navigator);
  }
}

const List<Destination> destinations = <Destination>[
  Destination('Messages', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  Destination('Profile', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  Destination('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];

class MyShellRouteScreen extends StatefulWidget {
  const MyShellRouteScreen({required this.child, super.key});

  final Widget child;

  @override
  State<MyShellRouteScreen> createState() => _MyShellRouteScreenState();
}

class _MyShellRouteScreenState extends State<MyShellRouteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/hello')) {
      return 0;
    }
    if (location.startsWith('/users')) {
      return 1;
    }
    if (location.startsWith('/cashier')) {
      return 2;
    }
    return 0;
  }

  void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        const HelloWorldRoute().go(context);
      case 1:
        const UserRoute().go(context);
      case 2:
        const CashierRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = getCurrentIndex(context);

    return Scaffold(
      key: scaffoldKey,
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 100,
            destinations: destinations
                .map(
                  (destination) => NavigationRailDestination(
                    icon: destination.icon,
                    selectedIcon: destination.selectedIcon,
                    label: Text(destination.label),
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => handleNavigation(context, index),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  child: const Text('Open Drawer'),
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: (index) => handleNavigation(context, index),
        selectedIndex: selectedIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Header', style: Theme.of(context).textTheme.titleSmall),
          ),
          ...destinations.map((Destination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
        ],
      ),
    );
  }
}

class AdminRoute extends GoRouteData {
  const AdminRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminPage();
  }
}

class UserRoute extends GoRouteData {
  const UserRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPage();
  }
}

class GuestRoute extends GoRouteData {
  const GuestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GuestPage();
  }
}

/// This route shows how to parametrize a simple page and how to pass a simple query parameter.
@TypedGoRoute<DetailsRoute>(path: '/details/:id')
class DetailsRoute extends GoRouteData {
  const DetailsRoute(this.id, {this.isNuke = false});
  final int id;
  final bool isNuke;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailsPage(
      id,
      isNuclearCode: isNuke,
    );
  }
}

@TypedGoRoute<HelloWorldRoute>(path: '/hello')
class HelloWorldRoute extends GoRouteData {
  const HelloWorldRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HelloWorldPage();
  }
}

@TypedGoRoute<CashierRoute>(path: '/cashier')
class CashierRoute extends GoRouteData {
  const CashierRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CashierPage();
  }
}
