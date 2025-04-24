import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_categories_page.dart';
import 'edit_categories_page.dart'; // Make sure this path is correct
// import 'add_products_page.dart';
// import 'edit_categories_page.dart';

class CategoryManagerPage extends ConsumerStatefulWidget {
  const CategoryManagerPage({super.key});

  @override
  ConsumerState<CategoryManagerPage> createState() => _CategoryManagerPageState();
}

class _CategoryManagerPageState extends ConsumerState<CategoryManagerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            labelColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(text: 'Add Category'),
              Tab(text: 'Edit Category'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AddProductsPage(),
              EditProductsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
