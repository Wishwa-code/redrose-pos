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

import '../features/navigation/models/navigation_destinations.dart';
import '../pages/admin_page.dart';
import '../pages/customers_page.dart';
import '../pages/guest_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';
import '../pages/orders_page.dart';
import '../pages/products/products_page.dart';
import '../pages/splash_page.dart';
import '../pages/user_page.dart';
import '../state/permissions.dart';
import '../widgets/logout_button.dart';
import '../widgets/logout_button_nolabel.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

const List<Destination> destinations = <Destination>[
  Destination('Home', Icon(Icons.home_outlined), Icon(Icons.home)),
  Destination(
    'Orders',
    Icon(Icons.shopping_cart_checkout_outlined),
    Icon(Icons.shopping_cart, fill: 1, weight: 700),
  ),
  Destination('Customers', Icon(Icons.three_p_outlined), Icon(Icons.three_p)),
  Destination('Products', Icon(Icons.inventory_2_outlined), Icon(Icons.inventory_2)),
  Destination('Analytics', Icon(Icons.multiline_chart_outlined), Icon(Icons.multiline_chart)),
  Destination('Register', Icon(Icons.app_registration_outlined), Icon(Icons.settings)),
  Destination('Staff', Icon(Icons.admin_panel_settings_outlined), Icon(Icons.admin_panel_settings)),
  Destination('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
  Destination('support', Icon(Icons.support_agent_outlined), Icon(Icons.support_agent)),
];

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
      user: (_) => const MainRoute().location,
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
    TypedGoRoute<MainRoute>(
      path: '/hello',
    ),
    TypedGoRoute<OrdersRoute>(
      path: '/orders',
    ),
    TypedGoRoute<CustomersRoute>(
      path: '/customers',
    ),
    TypedGoRoute<ProductsRoute>(
      path: '/products',
    ),
    TypedGoRoute<UserRoute>(
      path: '/users',
    ),
    TypedGoRoute<SupportRoute>(
      path: '/support',
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
    if (location.startsWith('/orders')) {
      return 1;
    }
    if (location.startsWith('/customers')) {
      return 2;
    }
    if (location.startsWith('/products')) {
      return 3;
    }
    if (location.startsWith('/support')) {
      return 8;
    }
    return 0;
  }

  void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        const MainRoute().go(context);
      case 1:
        const OrdersRoute().go(context);
      case 2:
        const CustomersRoute().go(context);
      case 3:
        const ProductsRoute().go(context);
      case 8:
        const SupportRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = getCurrentIndex(context);

    return Scaffold(
      key: scaffoldKey,
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Expanded(
                  child: NavigationRail(
                    minWidth: 80,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset(
                        'assets/icon.jpg',
                        width: 48,
                        height: 48,
                      ),
                    ),
                    destinations: destinations
                        .map(
                          (destination) => NavigationRailDestination(
                            icon: IconTheme(
                              data: const IconThemeData(size: 26), // Increase size here
                              child: destination.icon,
                            ),
                            selectedIcon: IconTheme(
                              data: const IconThemeData(size: 26), // Same size for selected state
                              child: destination.selectedIcon,
                            ),
                            label: Text(destination.label),
                            padding: const EdgeInsets.all(5),
                          ),
                        )
                        .toList(),
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index) => handleNavigation(context, index),
                  ),
                ),
                IconButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  icon: const Icon(Icons.arrow_right_alt_sharp),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: NormalLogoutButton(),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
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
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              'assets/icon.jpg',
              width: 38,
              height: 38,
            ),
          ),
          ...destinations.map((Destination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          const Padding(padding: EdgeInsets.fromLTRB(28, 6, 28, 0), child: Divider()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: 200,
              child: LogoutButton(),
            ),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState!.closeDrawer(),
            icon: const Icon(
              Icons.subdirectory_arrow_left_sharp,
            ),
          ),
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

@TypedGoRoute<MainRoute>(path: '/hello')
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HelloWorldPage();
  }
}

@TypedGoRoute<CustomersRoute>(path: '/customers')
class CustomersRoute extends GoRouteData {
  const CustomersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomersPage();
  }
}

@TypedGoRoute<SupportRoute>(path: '/support')
class SupportRoute extends GoRouteData {
  const SupportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPage();
  }
}

@TypedGoRoute<OrdersRoute>(path: '/orders')
class OrdersRoute extends GoRouteData {
  const OrdersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InventoryPage();
  }
}

@TypedGoRoute<ProductsRoute>(path: '/products')
class ProductsRoute extends GoRouteData {
  const ProductsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductsPage();
  }
}
