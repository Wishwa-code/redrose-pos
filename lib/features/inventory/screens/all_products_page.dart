import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../inventory/providers/products_provider.dart';
import '../../inventory/screens/widgets/product_list.dart';

class AllProductsPage extends ConsumerStatefulWidget {
  const AllProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<AllProductsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);

    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Row(
        children: [
          // Left side - Scrollable list of cards with fixed width
          Expanded(child: ProductList()),
        ],
      ),
    );
  }
}
