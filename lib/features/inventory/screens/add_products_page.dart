import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/action_button.dart';
import '../models/product.dart';
import '../providers/last_entered_product_notifier.dart';
import '../screens/widgets/enum_drop_down.dart';

class AddProductsPage extends ConsumerStatefulWidget {
  const AddProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends ConsumerState<AddProductsPage> {
  final _departmentKey = GlobalKey<FormBuilderFieldState>();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagOneController = TextEditingController();
  final _tagTwoController = TextEditingController();
  final _supplierController = TextEditingController();
  final _brandController = TextEditingController();
  final _departmentController = TextEditingController();
  final _mainCategoryController = TextEditingController();
  final _subCategoryController = TextEditingController();

  File? _selectedImage;
  String? _selectedImageName;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagOneController.dispose();
    _tagTwoController.dispose();
    _supplierController.dispose();
    _brandController.dispose();
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
      final newProduct = Product(
        title: _titleController.text,
        description: _descriptionController.text,
        tagOne: _tagOneController.text,
        tagTwo: _tagTwoController.text,
        imageUrl: 'will be updated after uploding image to cloud storage',
        supplier: _supplierController.text,
        brand: _brandController.text,
        department: _departmentController.text,
        mainCategory: _mainCategoryController.text,
        subCategory: _subCategoryController.text,
      );

      // Call the notifier to add product
      await ref.read(lastProductProvider.notifier).addProduct(newProduct, _selectedImage!);

      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(lastProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        labelText: 'brand(default)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //                     TextFormField(
                    //   controller: _tagTwoController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'deafault: tagtwo1',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   maxLines: 3,
                    // ),
                    TextFormField(
                      controller: _supplierController,
                      decoration: const InputDecoration(
                        labelText: 'supplier(default)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // TextFormField(
                    //   controller: _tagOneController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'default: tagone1',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   maxLines: 3,
                    // ),

                    const SizedBox(height: 16),
                    EnumDropdownField(
                      name: 'department',
                      label: 'Department',
                      onChanged: (value) => _departmentController.text = value ?? '',
                    ),
                    const SizedBox(height: 16),

                    EnumDropdownField(
                      name: 'main_categorie',
                      label: 'Main Category',
                      onChanged: (value) => _mainCategoryController.text = value ?? '',
                    ),

                    const SizedBox(height: 16),
                    // TextFormField(
                    //   controller: _subCategoryController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'subCategory(portlandCement)',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   maxLines: 3,
                    // ),
                    EnumDropdownField(
                      name: 'sub_categorie',
                      label: 'Sub Category',
                      onChanged: (value) => _subCategoryController.text = value ?? '',
                    ),
                    const SizedBox(height: 16),
                    EnumDropdownField(
                      name: 'tag_one',
                      label: 'Tag One',
                      onChanged: (value) => _tagOneController.text = value ?? '',
                    ),
                    const SizedBox(height: 16),

                    EnumDropdownField(
                      name: 'tag_two',
                      label: 'Tag Two',
                      onChanged: (value) => _tagTwoController.text = value ?? '',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Choose Image'),
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
                      label: const Text('Save Product'),
                    ),
                    // ElevatedButton(
                    //   onPressed: ,
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(16),
                    //     child: Text('Save Product'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Last entered product',
                    style: TextStyle(
                      backgroundColor: Colors.white,
                      fontSize: 18, // You can increase this for larger text
                      fontWeight: FontWeight.w600, // Try w600 or FontWeight.bold
                    ),
                  ),
                  switch (product) {
                    AsyncData(:final value) => SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Product: ${value.title}'),
                            Text('ID: ${value.id}'),
                            Text('Description: ${value.description}'),
                            Text('Tags: ${value.tagOne}, ${value.tagTwo}'),
                            Text('Supplier: ${value.supplier}'),
                            Text('Brand: ${value.brand}'),
                            Text('Department: ${value.department}'),
                            Text('Main Category: ${value.mainCategory}'),
                            Text('Sub Category: ${value.subCategory}'),
                            Image.network(value.imageUrl),
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
      ),
    );
  }
}
