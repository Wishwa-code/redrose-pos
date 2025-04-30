import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/action_button.dart';
import '../../models/product.dart';
import '../../providers/last_entered_product_notifier.dart';
import '../widgets/enum_drop_down.dart';
import '../widgets/value_card.dart';

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
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final imageFile = File('C:/1wishmi/cw1/dev/v3/assets/rebel.jpg');
      print('manual image path ${imageFile.path} ');
      print('attached image path ${_selectedImage!.path}');

      // final uploadResponse =
      //     await ref.read(lastProductProvider.notifier).uploadImage(imageFile);

      // Create dummy product
      final newProduct = Product(
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
      await ref.read(lastProductProvider.notifier).addProduct(newProduct, _selectedImage!);

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final containerHeight = screenHeight < 700 ? 450.0 : 650.0;

        return Row(
          //!change here to define the add product page alignment
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Product Name | වර්ගයේ නම',
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
                      TextFormField(
                        controller: _descriptionController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Description | විස්තරය',
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
                        maxLines: 2,
                      ),
                      EnumDropdownField(
                        name: 'department',
                        label: 'Department',
                        controller: _departmentController, // Pass controller
                        parentController: _rootController,
                        onParentStateChanged: _stateRebuild, // There is not parent
                        isattached: true,
                        level: 1,
                      ),
                      EnumDropdownField(
                        name: 'main_categorie',
                        label: 'Main Category',
                        controller: _mainCategoryController,
                        parentController: _departmentController,
                        onParentStateChanged: _stateRebuild,
                        isattached: true, // main_categorie use department
                        level: 2,
                      ),
                      EnumDropdownField(
                        name: 'sub_categorie',
                        label: 'Sub Category',
                        controller: _subCategoryController,
                        parentController: _mainCategoryController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: true,
                        level: 3,
                      ),
                      EnumDropdownField(
                        name: 'tag_one',
                        label: 'Tag one',
                        controller: _tagOneController,
                        parentController: _tagOneController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: false,
                        level: -1,
                      ),
                      EnumDropdownField(
                        name: 'tag_two',
                        label: 'Tag two',
                        controller: _tagTwoController,
                        parentController: _tagTwoController,
                        onParentStateChanged: _stateRebuild, // main_categorie use department
                        isattached: false,
                        level: -2,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.upload_file,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        label: (_selectedImageName != null)
                            ? Text(
                                _selectedImageName!,
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
            // ColoredBox(
            //   color: Theme.of(context).colorScheme.outline,
            //   child: SizedBox(
            //     width: 1,
            //     child: SizedBox(
            //       height: screenHeight,
            //       width: 0.5,
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
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
                      AsyncData(:final value) => Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                value.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  color: Color.fromARGB(255, 119, 116, 116),
                                  size: 250,
                                  Icons.broken_image,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueCard(
                                    label: 'Product',
                                    value: value.title,
                                  ),
                                  ValueCard(
                                    label: 'ID',
                                    value: value.id!,
                                  ),
                                  ValueCard(
                                    label: 'Description',
                                    value: value.description,
                                  ),
                                  ValueCard(
                                    label: 'Tags',
                                    value: '${value.tagOne}, ${value.tagTwo}',
                                  ),
                                  ValueCard(
                                    label: 'Department',
                                    value: value.department,
                                  ),
                                  ValueCard(
                                    label: 'Main Category',
                                    value: value.mainCategory,
                                  ),
                                  ValueCard(
                                    label: 'Main Category',
                                    value: value.mainCategory,
                                  ),
                                  ValueCard(
                                    label: 'Sub Category',
                                    value: value.subCategory,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
