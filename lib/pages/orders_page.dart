import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/product_provider.dart';

/// The homepage of our application
class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the activityProvider. This will start the network request
    // if it wasn't already started.
    // By using ref.watch, this widget will rebuild whenever the
    // the activityProvider updates. This can happen when:
    // - The response goes from "loading" to "data/error"
    // - The request was refreshed
    // - The result was modified locally (such as when performing side-effects)
    // ...
    final product = ref.watch(productProvider);

    return Center(
      /// Since network-requests are asynchronous and can fail, we need to
      /// handle both error and loading states. We can use pattern matching for this.
      /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
      child: switch (product) {
        AsyncData(:final value) => SingleChildScrollView(
            child: ListBody(
              children: value
                  .map(
                    (product) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Divider(), // To separate each activity visually
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
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
