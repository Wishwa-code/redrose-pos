import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/action_button.dart';
import '../../models/product.dart';
import '../../providers/last_entered_product_notifier.dart';
import '../widgets/enum_drop_down.dart';
import '../widgets/product_filter.dart';

class EditProductsPage extends ConsumerStatefulWidget {
  const EditProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends ConsumerState<EditProductsPage> {
  final _departmentKey = GlobalKey<FormBuilderFieldState>();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _productidController = TextEditingController();

  final _descriptionController = TextEditingController();
  final _tagOneController = TextEditingController();
  final _tagTwoController = TextEditingController();
  final _departmentController = TextEditingController();
  final _mainCategoryController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _rootController = TextEditingController();

  File? _selectedImage;
  String? _selectedImageName;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagOneController.dispose();
    _tagTwoController.dispose();
    _departmentController.dispose();
    _mainCategoryController.dispose();
    _subCategoryController.dispose();
    super.dispose();
  }

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate()) {
      final imageFile = File('C:/1wishmi/cw1/dev/v3/assets/rebel.jpg');
      print('manual image path ${imageFile.path} ');
      print('attached image path ${_selectedImage!.path}');

      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image.')),
        );
        return;
      }
      // final uploadResponse =
      //     await ref.read(lastProductProvider.notifier).uploadImage(imageFile);

      // Create dummy product
      final updatedProduct = Product(
        id: _productidController.text,
        title: _titleController.text,
        description: _descriptionController.text,
        tagOne: _tagOneController.text,
        tagTwo: _tagTwoController.text,
        imageUrl: 'will be updated after uploding image to cloud storage',
        department: _departmentController.text,
        mainCategory: _mainCategoryController.text,
        subCategory: _subCategoryController.text,
      );

      // Call the notifier to add product
      await ref.read(lastProductProvider.notifier).updateProduct(updatedProduct, _selectedImage!);

      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product submitted!')),
      );
    }
  }

  void _stateRebuild() {
    // Create one method to setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(lastProductProvider);
    _rootController.text = 'root';
    _subCategoryController.text = 'N/A';

    ref.listen<AsyncValue<Product?>>(
      lastProductProvider,
      (prev, next) {
        next.whenData((product) {
          if (product != null) {
            // debugPrint('Fetched product: ${product.displayTitle}');
            // Optionally update controllers with product data

            _descriptionController.text = product.description;
            _departmentController.text = product.department;
            _mainCategoryController.text = product.mainCategory;
            _subCategoryController.text = product.subCategory;

            // etc.
          }
        });
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final containerHeight = screenHeight < 700 ? 450.0 : 650.0;

        return Row(
          //!change here to define the add product page alignment
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final screenHeight = MediaQuery.of(context).size.height;
                            final containerHeight = screenHeight < 700 ? 500.0 : 700.0;

                            return Container(
                              width: 400,
                              height: containerHeight,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  left: 16,
                                  bottom: 4,
                                ),
                                child: ProductFilter(
                                  controller: _titleController,
                                  idController: _productidController,
                                  shouldGoOnClick: false,
                                  onProductSelected: (productId) {
                                    ref
                                        .read(lastProductProvider.notifier)
                                        .fetchProductById(productId);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      TextFormField(
                        controller: _titleController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryFixed,
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productidController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Category ID',
                          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryFixed,
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryFixed,
                              ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      EnumDropdownField(
                        key: ValueKey(_productidController.text),
                        name: 'department',
                        label: 'Department',
                        controller: _departmentController, // Pass controller
                        parentController: _rootController,
                        onParentStateChanged: _stateRebuild, // There is not parent
                        isattached: true,
                        level: 1,
                      ),
                      const SizedBox(height: 16),
                      EnumDropdownField(
                        name: 'main_categorie',
                        label: 'Main Category',
                        controller: _mainCategoryController,
                        parentController: _departmentController,
                        onParentStateChanged: _stateRebuild,
                        isattached: true, // main_categorie use department
                        level: 2,
                      ),
                      const SizedBox(height: 16),
                      EnumDropdownField(
                        name: 'sub_categorie',
                        label: 'Sub Category',
                        controller: _subCategoryController,
                        parentController: _mainCategoryController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: true,
                        level: 3,
                      ),
                      const SizedBox(height: 16),
                      EnumDropdownField(
                        name: 'tag_one',
                        label: 'Tag one',
                        controller: _tagOneController,
                        parentController: _tagOneController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: false,
                        level: -1,
                      ),
                      const SizedBox(height: 16),
                      EnumDropdownField(
                        name: 'tag_two',
                        label: 'Tag two',
                        controller: _tagTwoController,
                        parentController: _tagTwoController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: false,
                        level: -2,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.upload_file,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        label: Text(
                          'Choose Image',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimaryFixed, // Text and icon color
                          backgroundColor:
                              Theme.of(context).colorScheme.primary, // Button background
                          textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ), // Font style
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
                      if (_selectedImageName != null) ...[
                        const SizedBox(height: 8),
                        Text('Selected image: $_selectedImageName'),
                      ],
                      ActionButton(
                        onPressed: addProduct,
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
              ),
            ),
            ColoredBox(
              color: Theme.of(context).colorScheme.outline,
              child: SizedBox(
                width: 1,
                child: SizedBox(
                  height: screenHeight,
                  width: 0.5,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Last entered category',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                      ),
                    ),
                    switch (product) {
                      AsyncData(:final value) => SingleChildScrollView(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  value.imageUrl,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    color: Color.fromARGB(255, 119, 116, 116),
                                    size: 100,
                                    Icons.broken_image,
                                  ),
                                ),
                              ),
                              Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product               : ${value.title}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'ID                          : ${value.id}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'Description         : ${value.description}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'Tags                      : ${value.tagOne}, ${value.tagTwo}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'Department        : ${value.department}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'Main Category    : ${value.mainCategory}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                  Text(
                                    'Sub Category      : ${value.subCategory}',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                        ),
                                  ),
                                ],
                              ),
                            ],
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
            ),
          ],
        );
      },
    );
  }
}
