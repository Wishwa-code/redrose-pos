import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../supplier_screens/add_supplier_page.dart';
// import 'add_products_page.dart';
// import 'edit_categories_page.dart';

class SupplierManagerPage extends ConsumerStatefulWidget {
  const SupplierManagerPage({super.key});

  @override
  ConsumerState<SupplierManagerPage> createState() => _SupplierManagerPageState();
}

class _SupplierManagerPageState extends ConsumerState<SupplierManagerPage>
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
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).colorScheme.tertiary,

            // onTap: (index) {
            //   _tabController.animateTo(index,
            //       duration: const Duration(milliseconds: 600),
            //       curve: Curves.fastLinearToSlowEaseIn); // <— smooth animation
            // },
            labelColor: Theme.of(context).colorScheme.tertiary,
            labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
            tabs: const [
              Tab(text: 'Add Supplier'),
              Tab(text: 'Edit Supplier'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AddSupplierPage(),
              AddSupplierPage(),
            ],
          ),
        ),
      ],
    );
  }
}
