import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/product_provider.dart';

/// The homepage of our application
class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // Read the activityProvider. This will start the network request
        // if it wasn't already started.
        // By using ref.watch, this widget will rebuild whenever the
        // the activityProvider updates. This can happen when:
        // - The response goes from "loading" to "data/error"
        // - The request was refreshed
        // - The result was modified locally (such as when performing side-effects)
        // ...
        final activity = ref.watch(activityProvider);

        return Center(
          /// Since network-requests are asynchronous and can fail, we need to
          /// handle both error and loading states. We can use pattern matching for this.
          /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
          child: switch (activity) {
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
      },
    );
  }
}
