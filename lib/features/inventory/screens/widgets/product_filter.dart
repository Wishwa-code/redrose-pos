import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/inventory/screens/widgets/filter_chips.dart';
import '../../../inventory/providers/product_search_provider.dart';

class ProductFilter extends ConsumerStatefulWidget {
  const ProductFilter({super.key, this.controller, this.idController});
  final TextEditingController? controller;
  final TextEditingController? idController;

  @override
  ConsumerState<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends ConsumerState<ProductFilter> {
  late final TextEditingController _controller;
  late final TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _idController = widget.idController ?? TextEditingController();

    // Sync controller with provider when it changes
    _controller.addListener(() {
      final text = _controller.text;
      if (ref.read(searchFieldProvider) != text) {
        ref.read(searchFieldProvider.notifier).state = text;
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.idController == null) {
      _idController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(questionsProvider);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Filters'),
                FilterChipsBox(
                  name: 'Department',
                  provider: departmentFilterProvider,
                  parentProvider: rootProvider,
                  level: 1,
                ),
                FilterChipsBox(
                  name: 'Category',
                  provider: categoryFilterProvider,
                  parentProvider: departmentFilterProvider,
                  level: 2,
                ),
                //! there is no point adding fileter for any level lower so we are now working on
                //! adding suppliers and branc thing
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              TextField(
                onChanged: (value) => ref.read(searchFieldProvider.notifier).state = value,
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Search Products'),
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
                          onTap: () {
                            final title = product['title'].toString();
                            final id = product['id'].toString();
                            _controller.text = title;
                            _idController.text = id;
                            ref.read(searchFieldProvider.notifier).state = title;
                          },
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
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../features/inventory/screens/widgets/filter_chips.dart';
// import '../../../inventory/providers/product_search_provider.dart';

// /// The homepage of our application
// class ProductFilter extends ConsumerWidget {
//   const ProductFilter({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productsAsyncValue = ref.watch(questionsProvider);

//     return Row(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const Text('Filters'),
//                 FilterChipsBox(
//                   name: 'Department',
//                   provider: departmentFilterProvider,
//                   parentProvider: rootProvider,
//                   level: 1,
//                 ),
//                 FilterChipsBox(
//                   name: 'Category',
//                   provider: categoryFilterProvider,
//                   parentProvider: departmentFilterProvider,
//                   level: 2,
//                 ),
//                 //! there is no point adding fileter for any level lower so we are now working on
//                 //! adding suppliers and branc thing
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) => ref.read(searchFieldProvider.notifier).state = value,
//               ),
//               Expanded(
//                 child: productsAsyncValue.when(
//                   data: (products) {
//                     return ListView.builder(
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];

//                         return ListTile(
//                           title: Text(product['title'].toString()),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Description: ${product['description']}'),
//                               Text('Tags: ${product['tag_one']}, ${product['tag_two']}'),
//                               Image.network(product['imageurl'] as String),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   loading: () => const Center(child: CircularProgressIndicator()),
//                   error: (error, stackTrace) => Center(child: Text('Error: $error')),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
