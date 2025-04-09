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
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
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
                      controller: _nameController,
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
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                        prefixText: r'$',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
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
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Create dummy product
                          final newProduct = Product(
                            title: _nameController.text,
                            description: _descriptionController.text,
                            tagOne: 'tagone1',
                            tagTwo: 'tagtwo1',
                            imageUrl: 'https://example.com/dummy.png',
                            supplier: 'default',
                            brand: 'default',
                            department: 'mainBuilding',
                            mainCategory: 'cement',
                            subCategory: 'portlandCement',
                          );

                          // Call the notifier to add product
                          await ref.read(lastProductProvider.notifier).addProduct(newProduct);

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
              // Handle the different states of the AsyncValue (loading, error, or data)
              child: switch (product) {
                // When the provider has successfully fetched the product
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

                // When an error occurs while fetching data
                AsyncError(:final error, :final stackTrace) => Text(
                    'Oops, something unexpected happened: $error',
                  ),

                // While the data is still loading
                _ => const CircularProgressIndicator(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
