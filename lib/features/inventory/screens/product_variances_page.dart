import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../inventory/providers/product_variances_list_provider.dart'; // Adjust import accordingly

class VarianceListPage extends ConsumerWidget {
  const VarianceListPage({required this.productId, super.key});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncVariances = ref.watch(productVariancesProvider(productId));

    return Scaffold(
      appBar: AppBar(title: Text('Product Variances')),
      body: SafeArea(
        child: asyncVariances.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (variances) {
            if (variances.isEmpty) {
              return const Center(child: Text('No variances found.'));
            }

            return ListView.builder(
              itemCount: variances.length,
              itemBuilder: (context, index) {
                final variance = variances[index];
                return ListTile(
                  title: Text(variance.displayTitle), // or whatever fields you have
                  subtitle: Text('ID: ${variance.id}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
