import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormField extends StatelessWidget {
  const PriceFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired = true,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 34,
      horizontal: 10,
    ),
  });
  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          labelText: label,
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
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,20}')),
        ],
        validator: (value) {
          if (!isRequired && (value == null || value.isEmpty)) {
            return null;
          }
          if (value == null || value.isEmpty) {
            return 'Please enter $label'.toLowerCase();
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}
