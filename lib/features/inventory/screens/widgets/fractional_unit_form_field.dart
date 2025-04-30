import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'subunit_config.dart';

class SubUnitPriceFormField extends StatelessWidget {
  const SubUnitPriceFormField({
    super.key,
    required this.unitController,
    required this.controller,
    required this.label,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 34, horizontal: 10),
  });

  final TextEditingController unitController;
  final TextEditingController controller;
  final String label;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final unit = unitController.text.toLowerCase().trim();
    final subunitConfig = unitSubunitMap[unit];

    final suffixText = subunitConfig?.$1 ?? '';
    final maxValue = subunitConfig?.$2;

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryFixed,
          ),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        labelText: label,
        suffixText: suffixText,
        labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,10}')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label'.toLowerCase();
        }

        final parsed = double.tryParse(value);
        if (parsed == null) {
          return 'Please enter a valid number';
        }

        if (maxValue != null && parsed > maxValue) {
          return 'Must be ≤ $maxValue $suffixText';
        }

        return null;
      },
    );
  }
}
