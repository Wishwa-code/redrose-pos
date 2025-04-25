//! this is expantion about what is happening here  intial spashl screen route calles "/" home route
//! then it checks the permission of the curren user and if its a normal user he wiill be sent to
//! user route which is inside the shellroute if not he will sent to admin or guest route according gly
//! since curretnly all the values are hardcoded to make every user normalk user both router per guest user and admin user are bypassed to get to
//! user page
//

import 'dart:async';

import 'package:example/features/cute_rabbit/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/providers/permissions.dart';
import '../features/auth/screens/admin_page.dart';
import '../features/auth/screens/guest_page.dart';
import '../features/auth/screens/home_page.dart';
import '../features/auth/screens/login_page.dart';
import '../features/auth/screens/user_page.dart';
import '../features/customers/screens/customers_page.dart';
import '../features/inventory/screens/inventory_layout.dart';
import '../features/inventory/screens/product_screens/product_variances_page.dart';
import '../features/main/screens/main_page.dart';
import '../features/navigation/models/navigation_destinations.dart';
import '../features/orders/screens/orders_page.dart';
import '../features/settings/screens/settings_page.dart';
import '../features/splash_screen/screens/splash_page.dart';
import '../widgets/logo_box.dart';
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
  // Destination('Register', Icon(Icons.app_registration_outlined), Icon(Icons.settings)),
  Destination('Staff', Icon(Icons.admin_panel_settings_outlined), Icon(Icons.admin_panel_settings)),
  Destination('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
  Destination('support', Icon(Icons.support_agent_outlined), Icon(Icons.support_agent)),
];

// ────────────────────────────────
// 📱 Splash / Auth Routes
// ────────────────────────────────

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

// ────────────────────────────────
// 🏠 Home Route with Redirect Logic
// ────────────────────────────────

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
    TypedGoRoute<SettingsRoute>(
      path: '/settings',
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
    if (location.startsWith('/settings')) {
      return 6;
    }
    if (location.startsWith('/support')) {
      return 7;
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
      case 6:
        const SettingsRoute().go(context);
      case 7:
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
            child: ClipRect(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    Expanded(
                      child: NavigationRail(
                        minWidth: 80,
                        leading: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: LogoBox(),
                        ),
                        destinations: destinations
                            .map(
                              (destination) => NavigationRailDestination(
                                icon: Icon(
                                  (destination.icon as Icon).icon,
                                  size: 26,
                                  color: Theme.of(context).colorScheme.primary, // Unselected color
                                ),
                                selectedIcon: Icon(
                                  (destination.selectedIcon as Icon).icon,
                                  size: 26,
                                  color: Theme.of(context).colorScheme.primary, // Selected color
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
                      icon: Icon(
                        Icons.arrow_right_alt_sharp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: NormalLogoutButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const VerticalDivider(thickness: 1, width: 1),
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
          const Padding(
            padding: EdgeInsets.all(16),
            child: LogoBox(),
          ),
          ...destinations.map((Destination destination) {
            return NavigationDrawerDestination(
              label: Text(
                destination.label,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              icon: Icon(
                (destination.icon as Icon).icon,
                size: 26,
                color: Theme.of(context).colorScheme.primary, // Unselected color
              ),
              selectedIcon: Icon(
                (destination.selectedIcon as Icon).icon,
                size: 26,
                color: Theme.of(context).colorScheme.primary, // Selected color
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: 200,
              child: LogoutButton(),
            ),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState!.closeDrawer(),
            icon: Icon(
              Icons.subdirectory_arrow_left_sharp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

//? ────────────────────────────────
//? 👤 User Roles
//? ────────────────────────────────

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

// ────────────────────────────────
// 📄 Dynamic Page (with param)
// ────────────────────────────────

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

@TypedGoRoute<ProductVariancesRoute>(path: '/product/:id/variances')
class ProductVariancesRoute extends GoRouteData {
  const ProductVariancesRoute(this.id);
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VarianceListPage(
      productId: id,
    );
  }
}

// GoRoute(
//   path: '/product/:id/variances',
//   builder: (context, state) {
//     final productId = state.pathParameters['id']!;
//     return VarianceListPage(productId: productId);
//   },
// ),

// ────────────────────────────────
// 🧭 Main Shell Navigation Routes
// ────────────────────────────────

@TypedGoRoute<MainRoute>(path: '/hello')
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashBoardPage();
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

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
