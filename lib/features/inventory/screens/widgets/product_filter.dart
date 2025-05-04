import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/inventory/screens/widgets/filter_chips.dart';
import '../../../../router/routes.dart';
import '../../../../utils/print_logger.dart';
import '../../../inventory/providers/product_search_provider.dart';
import './../../providers/filter_prodcut_state_providers.dart';

class ProductFilter extends ConsumerStatefulWidget {
  const ProductFilter({
    super.key,
    this.controller,
    this.idController,
    this.shouldGoOnClick,
    this.onProductSelected,
  });
  final TextEditingController? controller;
  final TextEditingController? idController;
  final bool? shouldGoOnClick;
  final void Function(String productId)? onProductSelected;

  @override
  ConsumerState<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends ConsumerState<ProductFilter> {
  late final TextEditingController _controller;
  late final TextEditingController _idController;
  late final TextEditingController _productTitleController;
  late final bool _shouldGoOnClick;
  bool isSinhala = true;

  @override
  void initState() {
    super.initState();
    _idController = widget.idController ?? TextEditingController();
    _productTitleController = widget.controller ?? TextEditingController();
    _controller = TextEditingController();
    _shouldGoOnClick = widget.shouldGoOnClick ?? true;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu tree',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          isSinhala ? 'En' : 'සිං',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryFixed,
                              ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Switch(
                          value: isSinhala,
                          onChanged: (value) {
                            setState(() {
                              isSinhala = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.tertiary,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilterChipsBox(
                  name: 'Department',
                  provider: departmentFilterProvider,
                  parentProvider: rootProvider,
                  level: 1,
                  onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                  isSinhala: isSinhala,
                ),
                const SizedBox(height: 26),
                FilterChipsBox(
                  name: 'Category',
                  provider: categoryFilterProvider,
                  parentProvider: departmentFilterProvider,
                  level: 2,
                  onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                  isSinhala: isSinhala,
                ),
                const SizedBox(height: 26),
                FilterChipsBox(
                  name: 'Sub Category',
                  provider: subCategoryFilterProvider,
                  parentProvider: categoryFilterProvider,
                  level: 3,
                  onChanged: () => ref.read(currentPageProvider.notifier).state = 1,
                  isSinhala: isSinhala,
                ),
              ],
            ),
          ),
        ),

        /// Search + Results Column
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.secondaryContainer, // ash gray background
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFF454545), // light gray border
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Search is coming soon....'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isSinhala ? 'විස්තරයේත් සොයන්න' : 'Search in Description',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Switch(
                      value: ref.watch(lookinDescriptionProvider),
                      onChanged: (value) {
                        ref.read(lookinDescriptionProvider.notifier).state = value;
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: productsAsyncValue.when(
                  data: (products) {
                    final isLastPage = products.length < 10;

                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              DateTime.now().second.isEven
                                  ? 'assets/images/nothing_found0.png'
                                  : 'assets/images/nothing_found.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              DateTime.now().second.isEven
                                  ? 'Theres no prodcut with that name or i have shown you all the products!'
                                  : 'yeah the list is over or else there is no proucts with that name',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: [
                        if (isLastPage)
                          const Text(
                            'This is the last page',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: GridView.builder(
                            itemCount: products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // 4 cards per row
                              childAspectRatio: 0.75, // Adjust to your content ratio
                            ),
                            itemBuilder: (context, index) {
                              final product = products[index];

                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      logger.d('product.id--> $product');

                                      _productTitleController.text = product.title;

                                      _idController.text = product.id?.toString() ?? '';
                                      // ref.read(searchFieldProvider.notifier).state = product.title;

                                      widget.onProductSelected?.call(product.id!);

                                      if (_shouldGoOnClick) {
                                        final loadVariances =
                                            await ProductVariancesRoute(product.id!)
                                                .push<bool>(context);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Image
                                          Expanded(
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  product.imageUrl ?? 'no image',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) =>
                                                      const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color: Color.fromARGB(255, 119, 116, 116),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),

                                          // Info
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.title,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Divider(height: 1),
                                                  const SizedBox(height: 4),
                                                  Expanded(
                                                    child: Text(
                                                      product.description,
                                                      maxLines: 4,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        /// Pagination Controls
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: currentPage > 1
                                    ? () => ref.read(currentPageProvider.notifier).state--
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                  foregroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
                                ),
                                child: const Text('Previous'),
                              ),
                              Row(
                                children: [
                                  Text(currentPage.toString()),
                                  if (isLastPage) const Text(' (last page)') else const SizedBox(),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: !isLastPage
                                    ? () => ref.read(currentPageProvider.notifier).state++
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                  foregroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
                                ),
                                child: const Text('Next'),
                              ),
                            ],
                          ),
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
    padding: const EdgeInsets.symmetric(horizontal: 8),
    side: const BorderSide(
      width: 0.5, // 👈 thinner border
    ),
  );
}


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

