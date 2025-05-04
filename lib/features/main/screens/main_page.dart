import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/router/routes.dart';
import '../../../widgets/home_button.dart';
import '../../inventory/models/dashboardbuttons.dart';
import '../../inventory/providers/filter_prodcut_state_providers.dart';
import '../../inventory/providers/product_search_provider.dart';

final List<NavButtonData> dashBoardButtons = [
  NavButtonData(
    label: 'Add Customer',
    icon: Icons.add,
    color: const Color(0xFF006FE9),
    onPressed: () {
      // Handle add products
    },
  ),
  NavButtonData(
    label: 'Loyalty Points',
    icon: Icons.add_box,
    color: const Color(0xFF545F73),
    onPressed: () {
      // Handle add categories
    },
  ),
  NavButtonData(
    label: 'Apply discount',
    icon: Icons.inventory,
    color: const Color(0xFF7998BA),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'AURUDU25',
    subtitle: '50% off 4 main categories',
    icon: Icons.inventory,
    color: const Color(0xFF545F73),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'TOOLS10',
    subtitle: '50% off on  all tools',
    icon: Icons.inventory,
    color: const Color(0xFF545F73),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'Add gift card',
    icon: Icons.inventory,
    color: const Color(0xFF006FE9),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'Open drawer',
    icon: Icons.inventory,
    color: const Color(0xFF006FE9),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'Add custom sale',
    icon: Icons.inventory,
    color: const Color(0xFF006FE9),
    onPressed: () {
      // Handle search
    },
  ),
  NavButtonData(
    label: 'Create credit order',
    icon: Icons.inventory,
    color: const Color(0xFF309B8F),
    onPressed: () {
      // Handle search
    },
  ),
  // Add more...
];

class DashBoardPage extends ConsumerWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productSearchProvider);
    final currentPage = ref.watch(currentPageProvider);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(
                    height: 50, // Reduced height
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Search is coming soon'),
                            ),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Color(0xFFD3D3D3)),
                        filled: true,
                        fillColor: const Color(0xFF303030), // ash gray background
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        mainAxisExtent: 137,
                      ),
                      itemCount: dashBoardButtons.length,
                      itemBuilder: (context, index) {
                        final button = dashBoardButtons[index];
                        return HomeButton(
                          icon: Icon(button.icon, color: Colors.white),
                          text: button.label,
                          onPressed: button.onPressed,
                          color: button.color,
                          subtitle: button.subtitle,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            color: Color(0xFF303030),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => ref.read(searchFieldProvider.notifier).state = value,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFFD3D3D3)),
                      filled: true,
                      fillColor: Color(0xFF303030), // ash gray background
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
                              child: ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];

                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        ref.read(searchFieldProvider.notifier).state =
                                            product.title;
                                        final loadVariances =
                                            await ProductVariancesRoute(product.id!)
                                                .push<bool>(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Image
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                product.imageUrl ?? 'no image',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    const Icon(
                                                  color: Color.fromARGB(255, 119, 116, 116),
                                                  size: 100,
                                                  Icons.broken_image,
                                                ),
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
                                                      _buildtag(
                                                        'Main Category',
                                                        product.mainCategory,
                                                      ),
                                                      _buildtag(
                                                        'Sub Category',
                                                        product.subCategory,
                                                      ),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: currentPage > 1
                                        ? () => ref.read(currentPageProvider.notifier).state--
                                        : null,
                                    child: const Text('Previous'),
                                  ),
                                  if (!isLastPage)
                                    ElevatedButton(
                                      onPressed: () =>
                                          ref.read(currentPageProvider.notifier).state++,
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
          ),
        ],
      ),
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
