import 'package:flutter/material.dart';

import '/features/inventory/screens/brand_screens/brand_manager.dart';
import '/features/inventory/screens/category_screens/category_manager.dart';
import '/features/inventory/screens/product_screens/product_manager.dart';
import '/features/inventory/screens/supplier_screens/supplier_manager.dart';
import 'filter_screens/filter_products_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    FilterProductsPage(),
    ProductManagerPage(),
    CategoryManagerPage(),
    BrandManagerPage(),
    SupplierManagerPage(),
  ];

  final List<String> _titles = [
    'Find',
    'Manage Products',
    'Manage Categories',
    'Manage Brands',
    'Manage Suppliers',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Navigation
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: Text(
                      _titles[_selectedIndex],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: List.generate(_titles.length, (index) {
                        return NavigationButton(
                          title: _titles[index],
                          icon: _getIcon(index),
                          isSelected: index == _selectedIndex,
                          onTap: () {
                            setState(() => _selectedIndex = index);
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Right Content
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.search;
      case 1:
        return Icons.shelves;
      case 2:
        return Icons.category;
      case 3:
        return Icons.branding_watermark;
      case 4:
        return Icons.fire_truck;
      default:
        return Icons.circle;
    }
  }
}

class NavigationButton extends StatefulWidget {
  const NavigationButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = widget.isSelected;

    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor:
            isSelected ? theme.colorScheme.tertiary : theme.colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 32,
            color: isSelected ? theme.colorScheme.secondaryContainer : theme.colorScheme.tertiary,
          ),
          const SizedBox(height: 4),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: isSelected
                  ? theme.colorScheme.secondaryContainer
                  : theme.colorScheme.onSecondaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:example/features/inventory/screens/category_screens/category_manager.dart';
// import 'package:example/features/inventory/screens/product_screens/product_manager.dart';
// import 'package:flutter/material.dart';

// import 'filter_screens/filter_products_page.dart';

// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});

//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }

// class _ProductsPageState extends State<ProductsPage> {
//   Widget? _selectedContent;
//   String _selectedTitle = 'Categories & Products';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Left side navigation
//           SizedBox(
//             width: 150,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 70,
//                     alignment: Alignment.center, // 👈 Vertically (and horizontally) centers child
//                     child: Text(
//                       _selectedTitle,
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             color: Theme.of(context).colorScheme.onPrimaryFixed,
//                           ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Expanded(
//                     child: GridView.count(
//                       crossAxisCount: 1,
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 16,
//                       children: [
//                         NavigationButton(
//                           title: 'Find',
//                           icon: Icons.shelves,
//                           onPressed: () => _updateContent(
//                             'Find',
//                             const FilterProductsPage(),
//                           ),
//                           isIcon: true,
//                           selectedTitle: _selectedTitle,
//                         ),
//                         NavigationButton(
//                           title: 'Manage Products',
//                           icon: Icons.shelves,
//                           onPressed: () => _updateContent(
//                             'Manage Products',
//                             const ProductManagerPage(),
//                           ),
//                           isIcon: true,
//                           selectedTitle: _selectedTitle,
//                         ),
//                         NavigationButton(
//                           title: 'Manage Categories',
//                           icon: Icons.shelves,
//                           onPressed: () => _updateContent(
//                             'Manage Categories',
//                             const CategoryManagerPage(),
//                           ),
//                           isIcon: true,
//                           selectedTitle: _selectedTitle,
//                         ),
//                         NavigationButton(
//                           title: 'Manage Brands',
//                           icon: Icons.branding_watermark,
//                           onPressed: () => _updateContent(
//                             'Manage Brands',
//                             const Center(child: Text('Manage Brands')),
//                           ),
//                           isIcon: true,
//                           selectedTitle: _selectedTitle,
//                         ),
//                         NavigationButton(
//                           title: 'Manage Suppliers',
//                           icon: Icons.fire_truck,
//                           onPressed: () => _updateContent(
//                             'Transfers',
//                             const Center(child: Text('Manage Suppliers')),
//                           ),
//                           isIcon: true,
//                           selectedTitle: _selectedTitle,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Vertical divider between navigation and content
//           const VerticalDivider(width: 1),
//           // Right side content
//           Expanded(
//             child: _selectedContent ?? const FilterProductsPage(),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updateContent(String title, Widget content) {
//     setState(() {
//       _selectedTitle = title;
//       _selectedContent = content;
//     });
//   }
// }

// class NavigationButton extends StatelessWidget {
//   const NavigationButton({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.onPressed,
//     required this.isIcon,
//     this.imageUrl,
//     required this.selectedTitle,
//   });
//   final String title;
//   final IconData icon;
//   final VoidCallback onPressed;
//   final bool isIcon;
//   final String? imageUrl;
//   final String selectedTitle;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.all(8),
//         backgroundColor: (selectedTitle == title)
//             ? Theme.of(context).colorScheme.tertiary
//             : Theme.of(context).colorScheme.secondaryContainer,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (isIcon)
//             Icon(
//               icon,
//               size: 32,
//               color: (selectedTitle == title)
//                   ? Theme.of(context).colorScheme.secondaryContainer
//                   : Theme.of(context).colorScheme.tertiary,
//             )
//           else
//             imageUrl != null
//                 ? Image.asset(
//                     imageUrl!,
//                     width: 32,
//                     height: 32,
//                     color: (selectedTitle == title)
//                         ? Theme.of(context).colorScheme.secondaryContainer
//                         : Theme.of(context).colorScheme.tertiary,
//                   )
//                 : const SizedBox(),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: (selectedTitle == title)
//                 ? Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.secondaryContainer,
//                     )
//                 : Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onSecondaryFixed,
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }
