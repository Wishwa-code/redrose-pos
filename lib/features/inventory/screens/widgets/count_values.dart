import 'package:flutter/material.dart';

import '../widgets/price_field.dart';
import './fractional_unit_form_field.dart';
import './metric_dropdown.dart';

class CountValues extends StatelessWidget {
  const CountValues({
    super.key,
    required FocusNode unitmetricfNode,
    required FocusNode quantityefNode,
    required FocusNode leastsubunitfNode,
    required FocusNode brandfNode,
    required TextEditingController unitMeasureController,
    required TextEditingController quantityController,
    required TextEditingController leastSubUnitMeasureController,
  })  : _brandfNode = brandfNode,
        _unitmetricfNode = unitmetricfNode,
        _quantityefNode = quantityefNode,
        _unitMeasureController = unitMeasureController,
        _leastsubunitfNode = leastsubunitfNode,
        _quantityController = quantityController,
        _leastSubUnitMeasureController = leastSubUnitMeasureController;

  final FocusNode _unitmetricfNode;
  final FocusNode _quantityefNode;
  final TextEditingController _unitMeasureController;
  final FocusNode _leastsubunitfNode;
  final TextEditingController _quantityController;
  final TextEditingController _leastSubUnitMeasureController;
  final FocusNode _brandfNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownPriceFormField(
          controller: _unitMeasureController,
          label: 'Unit metric | ඒකකය',
          focusNode: _unitmetricfNode,
          focusNodetoCall: _quantityefNode,
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
              child: SubUnitPriceFormField(
                unitController: _unitMeasureController,
                controller: _leastSubUnitMeasureController,
                focusNode: _leastsubunitfNode,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_brandfNode),
                label: 'Min.sub unit as fraction of unit',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

        // TextFormField(
        //   focusNode: _unitmetricfNode,
        //   textInputAction: TextInputAction.next,
        //   onFieldSubmitted: (_) {
        //     FocusScope.of(context).requestFocus(_quantityefNode);
        //   },
        //   controller: _unitMeasureController,
        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //         color: Theme.of(context).colorScheme.onPrimaryFixed,
        //       ),
        //   decoration: InputDecoration(
        //     labelText: 'Unit metric | ඒකකය',
        //     labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        //           color: Theme.of(context).colorScheme.primary,
        //         ),
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: Theme.of(context).colorScheme.outline,
        //       ),
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please enter supplier';
        //     }
        //     return null;
        //   },
        // ),