// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../widgets/action_button.dart';
// import '../../models/brand.dart';
// import '../../providers/brand_provider.dart';
// import '../widgets/brand_form.dart';

// class AddBrandPage extends ConsumerStatefulWidget {
//   const AddBrandPage({super.key});

//   @override
//   ConsumerState<AddBrandPage> createState() => _AddBrandPageState();
// }

// class _AddBrandPageState extends ConsumerState<AddBrandPage> {
//   final _nameController = TextEditingController();
//   bool _isAdding = false;

//   final GlobalKey<_BrandFormCardState> brandFormKey = GlobalKey<_BrandFormCardState>();

//   Brand _brand = Brand(
//     name: '',
//     description: '',
//     logourl: '',
//     countryOfOrigin: '',
//     socialMediaLinks: '',
//     contactEmail: '',
//     phoneNumber: '',
//     bannerUrl: '',
//     website: '',
//   );

//   Future<void> _addProduct(Brand newbrand) async {
//     setState(() {
//       _isAdding = true;
//     });

//     try {
//       await ref.read(brandNotifierProvider.notifier).addBrand(newbrand);
//       ref.invalidate(brandNotifierProvider);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error adding product: $e')),
//       );
//     } finally {
//       setState(() {
//         _isAdding = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final brnadsAsync = ref.watch(brandNotifierProvider);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenwidth = MediaQuery.of(context).size.width;

//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(40),
//             child: Column(
//               children: [
//                 brnadsAsync.when(
//                   data: (brands) => Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Wrap(
//                       spacing: 12,
//                       runSpacing: 8,
//                       children: brands.map((p) {
//                         return Chip(
//                           label: Text(
//                             p.name,
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   loading: () => const CircularProgressIndicator(),
//                   error: (e, _) => Text('Error: $e'),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: screenwidth / 2.9,
//                   child: BrandFormCard(
//                     newBrand: _brand,
//                     key: brandFormKey,
//                     onBrandChanged: (updated) {
//                       setState(() {
//                         _brand = updated;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // ElevatedButton(
//                 //   onPressed: _addProduct,
//                 //   child: _isAdding ? const CircularProgressIndicator() : const Text('Add Product'),
//                 // ),
//                 ActionButton(
//                   onPressed: () async {
//                     await _addProduct(_brand);
//                     brandFormKey.currentState?.clearFields(); // clears the form after submit
//                   },
//                   icon: const SizedBox.shrink(),
//                   label: Text(
//                     'add Brand',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           color: Theme.of(context).colorScheme.onPrimary,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/action_button.dart';
import '../../models/brand.dart';
import '../../providers/brand_provider.dart';
import '../widgets/brand_form.dart';

class AddBrandPage extends ConsumerStatefulWidget {
  const AddBrandPage({super.key});

  @override
  ConsumerState<AddBrandPage> createState() => _AddBrandPageState();
}

class _AddBrandPageState extends ConsumerState<AddBrandPage> {
  bool _isAdding = false;

  // ✅ Added GlobalKey to access clearFields()
  final GlobalKey<BrandFormCardState> brandFormKey = GlobalKey<BrandFormCardState>();

  Brand _brand = Brand(
    name: '',
    description: '',
    logourl: '',
    countryOfOrigin: '',
    socialMediaLinks: '',
    contactEmail: '',
    phoneNumber: '',
    bannerUrl: '',
    website: '',
  );

  Future<void> _addProduct(Brand newbrand) async {
    setState(() {
      _isAdding = true;
    });

    try {
      await ref.read(brandNotifierProvider.notifier).addBrand(newbrand);
      ref.invalidate(brandNotifierProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding product: $e')),
      );
    } finally {
      setState(() {
        _isAdding = false;
      });
      brandFormKey.currentState?.clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandsAsync = ref.watch(brandNotifierProvider);
    final screenwidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                brandsAsync.when(
                  data: (brands) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: brands.map((p) {
                        return Chip(
                          label: Text(
                            p.name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),
                const SizedBox(height: 50),

                // ✅ Assign key to BrandFormCard
                SizedBox(
                  width: screenwidth / 2.9,
                  child: BrandFormCard(
                    key: brandFormKey,
                    newBrand: _brand,
                    onBrandChanged: (updated) {
                      setState(() {
                        _brand = updated;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // ✅ ActionButton clears form after adding
                ActionButton(
                  onPressed: () async {
                    await _addProduct(_brand);
                  },
                  icon: const SizedBox.shrink(),
                  label: Text(
                    'Add Brand',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
