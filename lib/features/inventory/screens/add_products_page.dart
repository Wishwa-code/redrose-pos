import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/last_entered_product_notifier.dart';

class AddProductsPage extends ConsumerStatefulWidget {
  const AddProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends ConsumerState<AddProductsPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagOneController = TextEditingController();
  final _tagTwoController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _supplierController = TextEditingController();
  final _brandController = TextEditingController();
  final _departmentController = TextEditingController();
  final _mainCategoryController = TextEditingController();
  final _subCategoryController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagOneController.dispose();
    _tagTwoController.dispose();
    _imageUrlController.dispose();
    _supplierController.dispose();
    _brandController.dispose();
    _departmentController.dispose();
    _mainCategoryController.dispose();
    _subCategoryController.dispose();
    super.dispose();
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
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tagOneController,
                      decoration: const InputDecoration(
                        labelText: 'default: tagone1',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tagTwoController,
                      decoration: const InputDecoration(
                        labelText: 'deafault: tagtwo1',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Image (https://example.com/dummy.png)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _supplierController,
                      decoration: const InputDecoration(
                        labelText: 'supplier(default)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        labelText: 'brand(default)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _departmentController,
                      decoration: const InputDecoration(
                        labelText: 'department(mainBuilding)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _mainCategoryController,
                      decoration: const InputDecoration(
                        labelText: 'mainCategory(cement)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _subCategoryController,
                      decoration: const InputDecoration(
                        labelText: 'subCategory(portlandCement)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final imageFile = File('C:/1wishmi/cw1/dev/v3/assets/freeDelivery.jpg');

                          // final uploadResponse =
                          //     await ref.read(lastProductProvider.notifier).uploadImage(imageFile);

                          // Create dummy product
                          final newProduct = Product(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            tagOne: _tagOneController.text,
                            tagTwo: _tagTwoController.text,
                            imageUrl: _imageUrlController.text,
                            supplier: _supplierController.text,
                            brand: _brandController.text,
                            department: _departmentController.text,
                            mainCategory: _mainCategoryController.text,
                            subCategory: _subCategoryController.text,
                          );

                          // Call the notifier to add product
                          await ref
                              .read(lastProductProvider.notifier)
                              .addProduct(newProduct, imageFile);

                          // Show feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product submitted!')),
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Save Product'),
                      ),
                    ),
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
