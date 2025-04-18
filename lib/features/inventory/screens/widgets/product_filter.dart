import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/inventory/screens/widgets/filter_chips.dart';
import '../../../../utils/print_logger.dart';
import '../../../inventory/providers/product_search_provider.dart';
import '../../models/product.dart';
import './../../providers/filter_prodcut_state_providers.dart';

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

    _controller.addListener(() {
      final text = _controller.text;
      if (ref.read(searchFieldProvider) != text) {
        ref.read(searchFieldProvider.notifier).state = text;
        ref.read(currentPageProvider.notifier).state = 1;
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.idController == null) _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(productSearchProvider);
    final currentPage = ref.watch(currentPageProvider);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                FilterChipsBox(
                  name: 'Department',
                  provider: departmentFilterProvider,
                  parentProvider: rootProvider,
                  level: 1,
                  onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                ),
                FilterChipsBox(
                  name: 'Category',
                  provider: categoryFilterProvider,
                  parentProvider: departmentFilterProvider,
                  level: 2,
                  onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                ),
                // FilterChipsBox(
                //   name: 'Brand',
                //   provider: brandFilterProvider,
                //   level: 0,
                //   chipOrDropdown: false, // 👈 Dropdown
                //   onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                // ),
                // FilterChipsBox(
                //   name: 'Supplier',
                //   provider: supplierFilterProvider,
                //   level: 0,
                //   chipOrDropdown: false, // 👈 Dropdown
                //   onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                // ),
              ],
            ),
          ),
        ),

        /// Search + Results Column
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Search Products'),
              ),

              /// Sort Dropdowns
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: ref.watch(sortFieldProvider),
                      onChanged: (value) {
                        ref.read(sortFieldProvider.notifier).state = value!;
                        ref.read(currentPageProvider.notifier).state = 1;
                      },
                      items: ['title', 'department', 'main_catogory']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: ref.watch(sortOrderProvider),
                      onChanged: (value) {
                        ref.read(sortOrderProvider.notifier).state = value!;
                        ref.read(currentPageProvider.notifier).state = 1;
                      },
                      items: ['asc', 'desc']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                  ],
                ),
              ),

              /// Product List
              Expanded(
                child: productsAsyncValue.when(
                  data: (products) {
                    return Column(
                      children: [
                        Text('Results: ${products.length}', style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 4),
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = Product.fromJson(products[index]);

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                elevation: 3,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                  onTap: () async {
                                    _controller.text = product.title;
                                    logger.d('product.id--> $product');
                                    _idController.text = product.id?.toString() ?? '';
                                    ref.read(searchFieldProvider.notifier).state = product.title;
                                    final loadVariances = await ProductVariancesRoute(product.id!)
                                        .push<bool>(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Image
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            product.imageUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                          ),
                                        ),
                                        const SizedBox(width: 16),

                                        // Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.title,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(product.description),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 4,
                                                children: [
                                                  _buildtag('Department', product.department),
                                                  _buildtag('Main Category', product.mainCategory),
                                                  _buildtag('Sub Category', product.subCategory),
                                                  _buildtag('Tag 1', product.tagOne),
                                                  _buildtag('Tag 2', product.tagTwo),
                                                  _buildtag('id', product.id.toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        /// Pagination Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: currentPage > 1
                                  ? () => ref.read(currentPageProvider.notifier).state--
                                  : null,
                              child: const Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed: () => ref.read(currentPageProvider.notifier).state++,
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ],
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

Widget _buildtag(String label, String value) {
  return Chip(
    label: Text('$label: $value'),
    backgroundColor: Colors.grey[200],
    padding: const EdgeInsets.symmetric(horizontal: 8),
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../features/inventory/screens/widgets/filter_chips.dart';
// import '../../../inventory/providers/product_search_provider.dart';
// import './../../providers/filter_prodcut_state_providers.dart';

// //!prodcut search field provider has all the other providers related to it
// class ProductFilter extends ConsumerStatefulWidget {
//   const ProductFilter({super.key, this.controller, this.idController});
//   final TextEditingController? controller;
//   final TextEditingController? idController;

//   @override
//   ConsumerState<ProductFilter> createState() => _ProductFilterState();
// }

// class _ProductFilterState extends ConsumerState<ProductFilter> {
//   late final TextEditingController _controller;
//   late final TextEditingController _idController;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? TextEditingController();
//     _idController = widget.idController ?? TextEditingController();

//     // Sync controller with provider when it changes
//     _controller.addListener(() {
//       final text = _controller.text;
//       if (ref.read(searchFieldProvider) != text) {
//         ref.read(searchFieldProvider.notifier).state = text;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     if (widget.idController == null) {
//       _idController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Search Products'),
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
//                           onTap: () {
//                             final title = product['title'].toString();
//                             final id = product['id'].toString();
//                             _controller.text = title;
//                             _idController.text = id;
//                             ref.read(searchFieldProvider.notifier).state = title;
//                           },
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
