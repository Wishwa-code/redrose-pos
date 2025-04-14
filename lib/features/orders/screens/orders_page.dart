import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../inventory/providers/products_provider.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      body: Row(
        children: [
          // Left side - Scrollable list of cards with fixed width
          ColoredBox(
            color: Colors.white,
            child: SizedBox(
              width: 350,
              child: Expanded(
                child: Center(
                  /// Since network-requests are asynchronous and can fail, we need to
                  /// handle both error and loading states. We can use pattern matching for this.
                  /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
                  child: switch (product) {
                    AsyncData(:final value) => SingleChildScrollView(
                        child: ListBody(
                          children: value
                              .map(
                                (product) => Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text('Product: ${product.title}'),
                                        Text('ID: ${product.id}'),
                                        Text('Description: ${product.description}'),
                                        Text('Tags: ${product.tagOne}, ${product.tagTwo}'),
                                        Text('Supplier: ${product.supplier}'),
                                        Text('Brand: ${product.brand}'),
                                        Text('Department: ${product.department}'),
                                        Text('Main Category: ${product.mainCategory}'),
                                        Text('Sub Category: ${product.subCategory}'),
                                        Image.network(product.imageUrl),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 20,
                                    ), // To separate each activity visually
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    AsyncError() => const Text('Oops, something unexpected happened'),
                    _ => const CircularProgressIndicator(),
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                    ),
                  ),
                  // Rest of the right side content can go here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
