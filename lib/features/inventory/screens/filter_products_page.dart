import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/widgets/product_filter.dart';

/// The homepage of our application
class FilterProductsPage extends ConsumerWidget {
  const FilterProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ColoredBox(
          //   color: Color(0xFF0d0d0d),
          //   child: Padding(
          //     padding: EdgeInsets.all(16),
          //     child: SizedBox(
          //       width: double.infinity,
          //       child: Text(
          //         'Select the scope and click on category to view products',
          //         style: TextStyle(
          //           fontSize: 14,
          //           color: Colors.white,
          //           fontStyle: FontStyle.italic,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: ProductFilter(),
            ),
          ),
        ],
      ),
    );
  }
}
