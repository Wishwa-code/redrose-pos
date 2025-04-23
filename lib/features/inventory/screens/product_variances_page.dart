import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/print_logger.dart';
import '../../inventory/providers/product_variances_list_provider.dart'; // Adjust import accordingly
import '../screens/widgets/product_card.dart';

class VarianceListPage extends ConsumerWidget {
  const VarianceListPage({required this.productId, super.key});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncVariances = ref.watch(productVariancesProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Variances')),
      body: SafeArea(
        child: asyncVariances.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) {
            logger.t('😖 Found error when looking for prodcuts may be theres no products $e');
            return Center(
              child: Image.asset(
                DateTime.now().second.isEven
                    ? 'assets/images/error_img.png'
                    : 'assets/images/error_img.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            );
          },
          data: (variances) {
            if (variances.isEmpty) {
              return const Center(child: Text('No variances found.'));
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: variances.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // You can make this responsive with MediaQuery
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final variance = variances[index];
                  return VarianceCard(variance: variance);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
