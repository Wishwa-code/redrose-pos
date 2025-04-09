import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../inventory/providers/product_search_provider.dart';

/// The homepage of our application
class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(questionsProvider);

    return Scaffold(  
      appBar: AppBar(title: const Text('Questions')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => ref.read(searchFieldProvider.notifier).state = value,
          ),
          Expanded(
            child: productsAsyncValue.when(
              data: (products) {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ListTile(
                      title: Text(product['title'].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description: ${product['description']}'),
                          Text('Tags: ${product['tag_one']}, ${product['tag_two']}'),
                          Image.network(product['imageurl'] as String),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../entities/product.dart';
// import '../state/product_provider.dart';

// /// A screen showing a product with the specific [id].
// class InventoryPage extends ConsumerWidget {
//   const InventoryPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final products = ref.watch(productProvider);

//     Future<void> onRefresh() => ref.refresh(productProvider.future);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: onRefresh,
//         child: products.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (_, __) => const Center(child: Text('An error occurred')),
//           data: (products) => ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (_, index) => _ProductListTile(products[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ProductListTile extends StatelessWidget {
//   const _ProductListTile(this.product);

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     void onTap() => context.go('/products/${product.id}');

//     return ListTile(
//       onTap: onTap,
//       title: Text(product.title),
//       subtitle: product.brand != null ? Text(product.brand) : null,
//     );
//   }
// }
