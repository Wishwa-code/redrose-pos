// import '../widgets/price_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../widgets/price_field.dart';
import './count_values.dart';

class AddProductsForm extends StatelessWidget {
  const AddProductsForm({
    super.key,
    required TextEditingController productnameController,
    required TextEditingController productidController,
    required FocusNode focusNode,
    required TextEditingController barcodeController,
    required FocusNode displayTitlefNode,
    required FocusNode aboutThisProdcutfNode,
    required TextEditingController displaytitleController,
    required FocusNode productNamefNode,
    required TextEditingController variancedescriptionController,
    required FocusNode brandfNode,
    required TextEditingController variancetitleController,
    required FocusNode originalPricefNode,
    required FocusNode retailPricefNode,
    required TextEditingController originalPriceController,
    required FocusNode wholesalelPricefNode,
    required TextEditingController retailPriceController,
    required FocusNode unitmetricfNode,
    required TextEditingController wholesalePriceController,
    required FocusNode quantityefNode,
    required TextEditingController unitMeasureController,
    required FocusNode leastsubunitfNode,
    required TextEditingController quantityController,
    required TextEditingController leastSubUnitMeasureController,
  })  : _productnameController = productnameController,
        _productidController = productidController,
        _focusNode = focusNode,
        _barcodeController = barcodeController,
        _displayTitlefNode = displayTitlefNode,
        _aboutThisProdcutfNode = aboutThisProdcutfNode,
        _displaytitleController = displaytitleController,
        _productNamefNode = productNamefNode,
        _variancedescriptionController = variancedescriptionController,
        _brandfNode = brandfNode,
        _variancetitleController = variancetitleController,
        _originalPricefNode = originalPricefNode,
        _retailPricefNode = retailPricefNode,
        _originalPriceController = originalPriceController,
        _wholesalelPricefNode = wholesalelPricefNode,
        _retailPriceController = retailPriceController,
        _unitmetricfNode = unitmetricfNode,
        _wholesalePriceController = wholesalePriceController,
        _quantityefNode = quantityefNode,
        _unitMeasureController = unitMeasureController,
        _leastsubunitfNode = leastsubunitfNode,
        _quantityController = quantityController,
        _leastSubUnitMeasureController = leastSubUnitMeasureController;

  final TextEditingController _productnameController;
  final TextEditingController _productidController;
  final FocusNode _focusNode;
  final TextEditingController _barcodeController;
  final FocusNode _displayTitlefNode;
  final FocusNode _aboutThisProdcutfNode;
  final TextEditingController _displaytitleController;
  final FocusNode _productNamefNode;
  final TextEditingController _variancedescriptionController;
  final FocusNode _brandfNode;
  final TextEditingController _variancetitleController;
  final FocusNode _originalPricefNode;
  final FocusNode _retailPricefNode;
  final TextEditingController _originalPriceController;
  final FocusNode _wholesalelPricefNode;
  final TextEditingController _retailPriceController;
  final FocusNode _unitmetricfNode;
  final TextEditingController _wholesalePriceController;
  final FocusNode _quantityefNode;
  final TextEditingController _unitMeasureController;
  final FocusNode _leastsubunitfNode;
  final TextEditingController _quantityController;
  final TextEditingController _leastSubUnitMeasureController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  labelText: 'Product Barcode | බාර්කෝඩ් අංකය',
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
          padding: const EdgeInsets.only(top: 20),
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
                padding: const EdgeInsets.only(top: 20, bottom: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    TextFormField(
                      focusNode: _displayTitlefNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_productNamefNode);
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
                      focusNode: _productNamefNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_aboutThisProdcutfNode);
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
                    TextFormField(
                      maxLines: 4,
                      focusNode: _aboutThisProdcutfNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_originalPricefNode);
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
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: PriceFormField(
                              isHidden: true,
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
                                FocusScope.of(context).requestFocus(_wholesalelPricefNode);
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
                    const SizedBox(height: 20),
                    CountValues(
                      unitmetricfNode: _unitmetricfNode,
                      quantityefNode: _quantityefNode,
                      leastsubunitfNode: _leastsubunitfNode,
                      brandfNode: _brandfNode,
                      unitMeasureController: _unitMeasureController,
                      quantityController: _quantityController,
                      leastSubUnitMeasureController: _leastSubUnitMeasureController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
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
      ],
    );
  }
}
