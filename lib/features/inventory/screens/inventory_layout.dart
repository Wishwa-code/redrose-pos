import 'package:example/features/inventory/screens/category_screens/category_manager.dart';
import 'package:example/features/inventory/screens/product_screens/product_manager.dart';
import 'package:flutter/material.dart';

import 'filter_screens/filter_products_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Widget? _selectedContent;
  String _selectedTitle = 'Categories & Products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side navigation
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    alignment: Alignment.center, // 👈 Vertically (and horizontally) centers child
                    child: Text(
                      _selectedTitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        _buildNavigationButton(
                          context,
                          'Find',
                          Icons.inventory,
                          () => _updateContent('Find', const FilterProductsPage()),
                        ),
                        _buildNavigationButton(
                          context,
                          'Manage Products',
                          Icons.add,
                          () => _updateContent('Manage Products', const ProductManagerPage()),
                        ),
                        _buildNavigationButton(
                          context,
                          'Manage Categories',
                          Icons.add_box,
                          () => _updateContent('Manage Categories', const CategoryManagerPage()),
                        ),
                        _buildNavigationButton(
                          context,
                          'Manage Brands',
                          Icons.shopping_cart,
                          () => _updateContent(
                            'Purchase Orders',
                            const Center(child: Text('Purchase Orders Content')),
                          ),
                        ),
                        _buildNavigationButton(
                          context,
                          'Manage Suppliers',
                          Icons.swap_horiz,
                          () => _updateContent(
                            'Transfers',
                            const Center(child: Text('Transfers Content')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Vertical divider between navigation and content
          const VerticalDivider(width: 1),
          // Right side content
          Expanded(
            child: _selectedContent ?? const Center(child: Text('Select an option')),
          ),
        ],
      ),
    );
  }

  void _updateContent(String title, Widget content) {
    setState(() {
      _selectedTitle = title;
      _selectedContent = content;
    });
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryFixed,
                ),
          ),
        ],
      ),
    );
  }
}
