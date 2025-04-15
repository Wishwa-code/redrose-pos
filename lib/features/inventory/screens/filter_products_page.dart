import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/widgets/product_filter.dart';

/// The homepage of our application
class FilterProductsPage extends ConsumerWidget {
  const FilterProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions')),
      body: const ProductFilter(),
    );
  }
}
