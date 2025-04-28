import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/inventory/providers/brand_provider.dart';
import '../../../../../features/inventory/providers/supplier_provider.dart';
import '../../../../widgets/action_button.dart';
import '../../models/variance.dart';
import '../../providers/last_entered_variance_notifier.dart';
import '../widgets/dropdown_of_provider.dart';
import '../widgets/price_field.dart';
import '../widgets/product_filter.dart';

class AddVariancesPage extends ConsumerStatefulWidget {
  const AddVariancesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddVariancesPageState();
}

class _AddVariancesPageState extends ConsumerState<AddVariancesPage> {
  final _rootController = TextEditingController();

  final _varianceformKey = GlobalKey<FormState>();
  final _productnameController = TextEditingController();
  final _productidController = TextEditingController();
  final _displaytitleController = TextEditingController();
  final _variancedescriptionController = TextEditingController();
  final _variancetitleController = TextEditingController();
  String? selectedBrandId;
  String? selectedSupplier;
  final _supplierController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _retailPriceController = TextEditingController();
  final _wholesalePriceController = TextEditingController();

  final _departmentController = TextEditingController();
  final _mainCategoryController = TextEditingController();
  final _subCategoryController = TextEditingController();

  final _quantityController = TextEditingController();
  final _unitMeasureController = TextEditingController();
  final _leastSubUnitMeasureController = TextEditingController();

  final _barcodeController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  final FocusNode _displayTitlefNode = FocusNode();
  final FocusNode _aboutThisProdcutfNode = FocusNode();
  final FocusNode _productNamefNode = FocusNode();
  final FocusNode _brandfNode = FocusNode();
  final FocusNode _supplierfNode = FocusNode();
  final FocusNode _originalPricefNode = FocusNode();

  final FocusNode _retailPricefNode = FocusNode();
  final FocusNode _wholesalelPricefNode = FocusNode();
  final FocusNode _unitmetricfNode = FocusNode();
  final FocusNode _quantityefNode = FocusNode();
  final FocusNode _leastsubunitfNode = FocusNode();

  File? _selectedImage;
  String? _selectedImageName;

  @override
  void dispose() {
    _focusNode.dispose();
    _barcodeController.dispose();
    _productnameController.dispose();
    _productidController.dispose();
    _displaytitleController.dispose();
    _variancedescriptionController.dispose();
    _variancetitleController.dispose();
    _supplierController.dispose();
    _originalPriceController.dispose();
    _retailPriceController.dispose();
    _wholesalePriceController.dispose();
    _departmentController.dispose();
    _mainCategoryController.dispose();
    _subCategoryController.dispose();
    _quantityController.dispose();
    _unitMeasureController.dispose();
    _leastSubUnitMeasureController.dispose();
    _rootController.dispose();
    super.dispose();
  }

  void _focusTextField(string) {
    FocusScope.of(context).requestFocus(_focusNode);
    print(string);
  }

  Future<void> addVariance() async {
    try {
      if (_varianceformKey.currentState!.validate()) {
        // if (_selectedImage == null) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Please select an image.')),
        //   );
        //   return;
        // }
        // final uploadResponse =
        //     await ref.read(lastProductProvider.notifier).uploadImage(imageFile);

        // Create dummy product
        final newProduct = Variance(
          productName: _productnameController.text,
          displayTitle: _displaytitleController.text,
          varianceDescription: _variancedescriptionController.text,
          imageUrl: 'will be updated after uploading image to cloud storage',
          varianceTitle: _variancetitleController.text,
          brand: selectedBrandId!,
          supplier: _supplierController.text,
          originalPrice: double.tryParse(_originalPriceController.text) ?? 0.0,
          retailPrice: double.tryParse(_retailPriceController.text) ?? 0.0,
          wholesalePrice: double.tryParse(_wholesalePriceController.text) ?? 0.0,
          quantity: double.tryParse(_quantityController.text) ?? 0.0,
          unitMeasure: _unitMeasureController.text,
          leastSubUnitMeasure: double.tryParse(_leastSubUnitMeasureController.text) ?? 0.0,
          productId: _productidController.text,
        );

        // Call the notifier to add product
        await ref.read(lastVarianceProvider.notifier).addVariance(newProduct, _selectedImage!);

        // Show feedback
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product submitted!')),
          );
        });
      }
    } catch (e) {
      logger.f('Variance form key current state is invalid:  $e ');
    }
  }

  void _stateRebuild() {
    // Create one method to setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(lastVarianceProvider);
    _rootController.text = 'root';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Form(
                key: _varianceformKey,
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Select the category for the new product | අලුතින් එකතු කරන භාණ්ඩය සදහා වර්ගය/කාණ්ඩය තෝරගන්න',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context).colorScheme.onTertiaryContainer,
                              ),
                        ),
                      ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: const [4, 2],
                      radius: const Radius.circular(8),
                      color: Theme.of(context).colorScheme.outline,
                      // padding: const EdgeInsets.all(6),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenHeight = MediaQuery.of(context).size.height;
                              final containerHeight = screenHeight < 700 ? 500.0 : 700.0;

                              return SizedBox(
                                // width: 400,
                                height: containerHeight,
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     color: Theme.of(context).colorScheme.outline,
                                //     width: 1.5,
                                //   ),
                                //   borderRadius: BorderRadius.circular(8),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    left: 16,
                                    bottom: 4,
                                  ),
                                  child: ProductFilter(
                                    controller: _productnameController,
                                    idController: _productidController,
                                    shouldGoOnClick: false,
                                    onProductSelected: _focusTextField,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _productnameController,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Category of the new product | නව අයිතමයේ වර්ගය',
                              labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline.withAlpha(225),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _productidController,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Category ID | වර්ග අංකය',
                              labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            focusNode: _focusNode,
                            controller: _barcodeController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_displayTitlefNode);
                            },
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Product Barcode | වර්ග අංකය',
                              labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: DottedBorder(
                        dashPattern: const [6, 3], // dash length, gap
                        color: Theme.of(context).colorScheme.outline, // line color
                        padding: EdgeInsets.zero,
                        customPath: (size) {
                          return Path()
                            ..moveTo(0, 0)
                            ..lineTo(size.width, 0); // draw a horizontal line
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 1, // thickness of the line
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20,
                              children: [
                                TextFormField(
                                  focusNode: _displayTitlefNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_aboutThisProdcutfNode);
                                  },
                                  controller: _displaytitleController,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                                      ),
                                  decoration: InputDecoration(
                                    labelText: 'Display title | සිංහල නම',
                                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter display title';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  focusNode: _aboutThisProdcutfNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_productNamefNode);
                                  },
                                  controller: _variancedescriptionController,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                                      ),
                                  decoration: InputDecoration(
                                    labelText: 'About this product | අයිතමයේ විස්තරය',
                                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please complete about this product section';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  focusNode: _productNamefNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_brandfNode);
                                  },
                                  controller: _variancetitleController,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                                      ),
                                  decoration: InputDecoration(
                                    labelText: 'Product name | අයිතමයේ නම',
                                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter product name';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 16,
                                  ),
                                  child: DottedBorder(
                                    dashPattern: const [6, 3], // dash length, gap
                                    color: Theme.of(context).colorScheme.outline, // line color
                                    padding: EdgeInsets.zero,
                                    customPath: (size) {
                                      return Path()
                                        ..moveTo(0, 0)
                                        ..lineTo(size.width, 0); // draw a horizontal line
                                    },
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 1, // thickness of the line
                                    ),
                                  ),
                                ),
                                ProviderDropdownField(
                                  focusNode: _brandfNode,
                                  provider: brandNotifierProvider,
                                  selectedValue: selectedSupplier,
                                  labelText: 'Select brand | සන්නාමය',
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_supplierfNode);
                                      selectedSupplier = value;
                                    });
                                  },
                                ),
                                ProviderDropdownField(
                                  focusNode: _supplierfNode,
                                  provider: supplierNotifierProvider,
                                  selectedValue: selectedBrandId,
                                  labelText: 'Select supplier | සැපයුම්කරු',
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_originalPricefNode);

                                      selectedBrandId = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: DottedBorder(
                                dashPattern: const [6, 3], // Dash length and gap
                                color: Theme.of(context).colorScheme.outline, // Line color
                                padding: EdgeInsets.zero,
                                customPath: (size) {
                                  return Path()
                                    ..moveTo(0, 0) // Starting point of the vertical line
                                    ..lineTo(0, size.height); // Draw the line vertically
                                },
                                child: const SizedBox(
                                  width: 1, // Set the thickness of the divider (horizontal size)
                                  height: 337, // Set the height (vertical length) of the divider
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 34),
                                  child: Row(
                                    spacing: 20,
                                    children: [
                                      Expanded(
                                        child: PriceFormField(
                                          focusNode: _originalPricefNode,
                                          onFieldSubmitted: (_) {
                                            FocusScope.of(context).requestFocus(_retailPricefNode);
                                          },
                                          controller: _originalPriceController,
                                          label: 'Original price | මුල් මිල',
                                        ),
                                      ),
                                      Expanded(
                                        child: PriceFormField(
                                          focusNode: _retailPricefNode,
                                          onFieldSubmitted: (_) {
                                            FocusScope.of(context)
                                                .requestFocus(_wholesalelPricefNode);
                                          },
                                          controller: _retailPriceController,
                                          label: 'Retail price | සිල්ලර මිල',
                                        ),
                                      ),
                                      Expanded(
                                        child: PriceFormField(
                                          focusNode: _wholesalelPricefNode,
                                          onFieldSubmitted: (_) {
                                            FocusScope.of(context).requestFocus(_unitmetricfNode);
                                          },
                                          controller: _wholesalePriceController,
                                          label: 'Wholesale price | තොග මිල',
                                          isRequired: false, // Optional field
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: DottedBorder(
                                    dashPattern: const [6, 3], // dash length, gap
                                    color: Theme.of(context).colorScheme.outline, // line color
                                    padding: EdgeInsets.zero,
                                    customPath: (size) {
                                      return Path()
                                        ..moveTo(0, 0)
                                        ..lineTo(size.width, 0); // draw a horizontal line
                                    },
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 1, // thickness of the line
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 34),
                                TextFormField(
                                  focusNode: _unitmetricfNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_quantityefNode);
                                  },
                                  controller: _unitMeasureController,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                                      ),
                                  decoration: InputDecoration(
                                    labelText: 'Unit metric | ඒකකය',
                                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter supplier';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      child: PriceFormField(
                                        focusNode: _quantityefNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(_leastsubunitfNode);
                                        },
                                        controller: _quantityController,
                                        label: 'Quantity | පරිමාණය',
                                      ),
                                    ),
                                    Expanded(
                                      child: PriceFormField(
                                        focusNode: _leastsubunitfNode,
                                        controller: _leastSubUnitMeasureController,
                                        label:
                                            'Min.sub unit as fracture of unit | විකුණන අවම පරිමාණය ඒ්කකයේ භාගයක් වශයෙන් 1 ට වඩා අඩු දශම සංඛ්‍යාවක් ලෙස',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      label: (_selectedImageName != null)
                          ? Text(
                              'Selected image: $_selectedImageName',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                            )
                          : Text(
                              'Choose Image',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                      icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.onPrimary),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimaryFixed, // Text and icon color
                        backgroundColor: Theme.of(context).colorScheme.primary, // Button background
                        textStyle: Theme.of(context).textTheme.titleMedium, // Font style
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // Border color
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );

                        if (result != null && result.files.single.path != null) {
                          setState(() {
                            _selectedImage = File(result.files.single.path!);
                            _selectedImageName = result.files.single.name;
                          });
                        }
                      },
                    ),
                    ActionButton(
                      onPressed: addVariance,
                      icon: const SizedBox.shrink(),
                      label: Text(
                        'Save Product',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 30),
                child: Divider(),
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Last entered product',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                      ),
                    ),
                    switch (product) {
                      AsyncData(:final value) => SingleChildScrollView(
                          child: SizedBox(
                            height: 400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    value.imageUrl,
                                    width: 360,
                                    height: 360,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      color: Color.fromARGB(255, 119, 116, 116),
                                      size: 100,
                                      Icons.broken_image,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Display title       : ${value.displayTitle}',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      Text(
                                        'Category             : ${value.productName}',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ID                         : ${value.id}',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Description        : ${value.varianceDescription}',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Product name   : ${value.varianceTitle}',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'originalPrice      : ${value.originalPrice}',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'supplier                   : ${value.supplier}',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'brand                       : ${value.brand}',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      AsyncError(:final error, :final stackTrace) => Text(
                          'Oops, something unexpected happened: $error',
                        ),
                      _ => const CircularProgressIndicator(),
                    },
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';

// import '../../../widgets/action_button.dart';
// import '../models/variance.dart';
// import '../providers/last_entered_variance_notifier.dart';
// import '../screens/widgets/price_field.dart';

// Logger logger = Logger(
//   printer: PrettyPrinter(),
// );

// class AddVariancesPage extends ConsumerStatefulWidget {
//   const AddVariancesPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AddVariancesPageState();
// }

// class _AddVariancesPageState extends ConsumerState<AddVariancesPage> {
//   final _varianceformKey = GlobalKey<FormState>();
//   final _productnameController = TextEditingController();
//   final _displaytitleController = TextEditingController();
//   final _variancedescriptionController = TextEditingController();
//   final _variancetitleController = TextEditingController();
//   final _brandController = TextEditingController();
//   final _supplierController = TextEditingController();
//   final _originalPriceController = TextEditingController();
//   final _retailPriceController = TextEditingController();
//   final _wholesalePriceController = TextEditingController();

//   File? _selectedImage;
//   String? _selectedImageName;

//   @override
//   void dispose() {
//     _productnameController.dispose();
//     _displaytitleController.dispose();
//     _variancedescriptionController.dispose();
//     _variancetitleController.dispose();
//     _brandController.dispose();
//     _supplierController.dispose();
//     _originalPriceController.dispose();
//     _retailPriceController.dispose();
//     _wholesalePriceController.dispose();
//     super.dispose();
//   }

//   Future<void> addVariance() async {
//     try {
//       if (_varianceformKey.currentState!.validate()) {
//         // if (_selectedImage == null) {
//         //   ScaffoldMessenger.of(context).showSnackBar(
//         //     const SnackBar(content: Text('Please select an image.')),
//         //   );
//         //   return;
//         // }
//         // final uploadResponse =
//         //     await ref.read(lastProductProvider.notifier).uploadImage(imageFile);

//         // Create dummy product
//         final newProduct = Variance(
//           productName: _productnameController.text,
//           displayTitle: _displaytitleController.text,
//           varianceDescription: _variancedescriptionController.text,
//           imageUrl: 'will be updated after uploding image to cloud storage',
//           varianceTitle: _variancetitleController.text,
//           brand: _brandController.text,
//           supplier: _supplierController.text,
//           originalPrice: int.parse(_originalPriceController.text),
//           retailPrice: int.parse(_retailPriceController.text),
//           wholesalePrice: _originalPriceController.text,
//           productId: 'need to be updated with corresponding value to title',
//         );

//         // Call the notifier to add product
//         await ref.read(lastVarianceProvider.notifier).addVariance(newProduct, _selectedImage!);

//         // Show feedback
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product submitted!')),
//         );
//       }
//     } catch (e) {
//       logger.f('Variance form key current state is invalid:  $e ');
//     }
//   }

//   void _stateRebuild() {
//     // Create one method to setState
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = ref.watch(lastVarianceProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Variance'),
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back),
//         //   onPressed: () => Navigator.pop(context),
//         // ),
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _varianceformKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Text(
//                       'Each variance must have unique combinations of product, variance, brand, supplier to avoid dupplication',
//                     ),
//                     const SizedBox(height: 16),

//                     TextFormField(
//                       controller: _productnameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Product of the variance',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 8),

//                     TextFormField(
//                       controller: _displaytitleController,
//                       decoration: const InputDecoration(
//                         labelText: 'Display title',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 8),

//                     TextFormField(
//                       controller: _variancedescriptionController,
//                       decoration: const InputDecoration(
//                         labelText: 'About this variance',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 8),

//                     TextFormField(
//                       controller: _variancetitleController,
//                       decoration: const InputDecoration(
//                         labelText: 'Variance name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 8),

//                     TextFormField(
//                       controller: _brandController,
//                       decoration: const InputDecoration(
//                         labelText: 'Brand',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 8),

//                     TextFormField(
//                       controller: _supplierController,
//                       decoration: const InputDecoration(
//                         labelText: 'Supplier',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 8),

//                     PriceFormField(
//                       controller: _originalPriceController,
//                       label: 'Original price',
//                     ),
//                     const SizedBox(height: 8),
//                     PriceFormField(
//                       controller: _retailPriceController,
//                       label: 'Retail price',
//                     ),
//                     const SizedBox(height: 8),
//                     PriceFormField(
//                       controller: _wholesalePriceController,
//                       label: 'Wholesale price',
//                       isRequired: false, // Optional field
//                     ),

//                     // EnumDropdownField(
//                     //   name: 'department',
//                     //   label: 'Department',
//                     //   controller: _departmentController, // Pass controller
//                     //   parentController: _rootController,
//                     //   onParentStateChanged: _stateRebuild, // There is not parent
//                     //   isattached: true,
//                     //   level: 1,
//                     // ),
//                     // const SizedBox(height: 16),

//                     // EnumDropdownField(
//                     //   name: 'main_categorie',
//                     //   label: 'Main Category',
//                     //   controller: _mainCategoryController,
//                     //   parentController: _departmentController,
//                     //   onParentStateChanged: _stateRebuild,
//                     //   isattached: true, // main_categorie use department
//                     //   level: 2,
//                     // ),

//                     // const SizedBox(height: 16),

//                     // const SizedBox(height: 16),

//                     // EnumDropdownField(
//                     //   name: 'sub_categorie',
//                     //   label: 'Sub Category',
//                     //   controller: _subCategoryController,
//                     //   parentController: _mainCategoryController,
//                     //   onParentStateChanged: _stateRebuild, // main_categorie use department
//                     //   isattached: true,
//                     //   level: 3,
//                     // ),
//                     // EnumDropdownField(
//                     //   name: 'tag_one',
//                     //   label: 'Tag one',
//                     //   controller: _tagOneController,
//                     //   parentController: _tagOneController,
//                     //   onParentStateChanged: _stateRebuild, // main_categorie use department
//                     //   isattached: false,
//                     //   level: -1,
//                     // )
//                     // EnumDropdownField(
//                     //   name: 'tag_two',
//                     //   label: 'Tag two',
//                     //   controller: _tagTwoController,
//                     //   parentController: _tagTwoController,
//                     //   onParentStateChanged: _stateRebuild, // main_categorie use department
//                     //   isattached: false,
//                     //   level: -2,
//                     // ),

//                     const SizedBox(height: 24),
//                     // ElevatedButton.icon(
//                     //   icon: const Icon(Icons.upload_file),
//                     //   label: const Text('Choose Image'),
//                     //   onPressed: () async {
//                     //     final result = await FilePicker.platform.pickFiles(
//                     //       type: FileType.image,
//                     //     );

//                     //     if (result != null && result.files.single.path != null) {
//                     //       setState(() {
//                     //         _selectedImage = File(result.files.single.path!);
//                     //         _selectedImageName = result.files.single.name;
//                     //       });
//                     //     }
//                     //   },
//                     // ),
//                     // if (_selectedImageName != null) ...[
//                     //   const SizedBox(height: 8),
//                     //   Text('Selected image: $_selectedImageName'),
//                     // ],
//                     ActionButton(
//                       onPressed: addVariance,
//                       icon: const SizedBox.shrink(),
//                       label: const Text('Save Product'),
//                     ),
//                     // ElevatedButton(
//                     //   onPressed: ,
//                     //   child: const Padding(
//                     //     padding: EdgeInsets.all(16),
//                     //     child: Text('Save Product'),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Last entered product',
//                     style: TextStyle(
//                       backgroundColor: Colors.white,
//                       fontSize: 18, // You can increase this for larger text
//                       fontWeight: FontWeight.w600, // Try w600 or FontWeight.bold
//                     ),
//                   ),
//                   switch (product) {
//                     AsyncData(:final value) => SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Text('Product: ${value.productName}'),
//                             Text('ID: ${value.id}'),
//                             Text('Description: ${value.varianceDescription}'),
//                             Text('varianceTitle: ${value.varianceTitle}'),
//                             Text('originalPrice: ${value.originalPrice}'),
//                             Text('supplier: ${value.supplier}'),
//                             Text('brand: ${value.brand}'),
//                             // Image.network(value.imageUrl),
//                           ],
//                         ),
//                       ),
//                     AsyncError(:final error, :final stackTrace) => Text(
//                         'Oops, something unexpected happened: $error',
//                       ),
//                     _ => const CircularProgressIndicator(),
//                   },
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
