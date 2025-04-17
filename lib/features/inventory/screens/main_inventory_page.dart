import 'package:flutter/material.dart';

import 'add_products_page.dart';
import 'add_variances_page.dart';
import 'all_products_page.dart';
import 'filter_products_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Widget? _selectedContent;
  String _selectedTitle = 'Products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      appBar: AppBar(
        title: Text(
          _selectedTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0d0d0d),
      ),
      body: Row(
        children: [
          // Left side navigation
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildNavigationButton(
                    context,
                    'Add Variances',
                    Icons.add,
                    () => _updateContent('Add Variances', const AddVariancesPage()),
                  ),
                  _buildNavigationButton(
                    context,
                    'Add Products',
                    Icons.add_box,
                    () => _updateContent('Add Products', const AddProductsPage()),
                  ),
                  _buildNavigationButton(
                    context,
                    'All products',
                    Icons.collections,
                    () => _updateContent(
                      'Collections',
                      const AllProductsPage(),
                    ),
                  ),
                  _buildNavigationButton(
                    context,
                    'Filter Products',
                    Icons.inventory,
                    () => _updateContent('Inventory', const FilterProductsPage()),
                  ),
                  _buildNavigationButton(
                    context,
                    'Purchase Orders',
                    Icons.shopping_cart,
                    () => _updateContent(
                      'Purchase Orders',
                      const Center(child: Text('Purchase Orders Content')),
                    ),
                  ),
                  _buildNavigationButton(
                    context,
                    'Transfers',
                    Icons.swap_horiz,
                    () =>
                        _updateContent('Transfers', const Center(child: Text('Transfers Content'))),
                  ),
                  _buildNavigationButton(
                    context,
                    'Gift Cards',
                    Icons.card_giftcard,
                    () => _updateContent(
                      'Gift Cards',
                      const Center(child: Text('Gift Cards Content')),
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
        backgroundColor: const Color(0xFF2E72D2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xFF4db4f7)),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
