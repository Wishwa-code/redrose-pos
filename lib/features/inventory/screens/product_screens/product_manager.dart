import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../product_screens/add_products_page.dart';
import '../product_screens/edit_products_page.dart'; // Make sure this path is correct
// import 'add_products_page.dart';
// import 'edit_categories_page.dart';

class ProductManagerPage extends ConsumerStatefulWidget {
  const ProductManagerPage({super.key});

  @override
  ConsumerState<ProductManagerPage> createState() => _CategoryManagerPageState();
}

class _CategoryManagerPageState extends ConsumerState<ProductManagerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, animationDuration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom TabBar (outside AppBar)
        ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.tertiary,
            labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).colorScheme.tertiary,
            tabs: const [
              Tab(text: 'Add Product'),
              Tab(text: 'Edit Product'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AddVariancesPage(),
              EditVariancesPage(),
            ],
          ),
        ),
      ],
    );
  }
}
