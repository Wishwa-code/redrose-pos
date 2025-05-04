import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../inventory/providers/products_provider.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  @override
  Widget build(BuildContext context) {
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
                      children: [
                        Column(
                          children: [
                            Text('Product: ${product.title}'),
                            Text('ID: ${product.id}'),
                            Text('Description: ${product.description}'),
                            Text('Tags: ${product.tagOne}, ${product.tagTwo}'),
                            Text('Department: ${product.department}'),
                            Text('Main Category: ${product.mainCategory}'),
                            Text('Sub Category: ${product.subCategory}'),
                            Image.network(product.imageUrl ?? 'no image'),
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
    );
  }
}
