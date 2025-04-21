import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormField extends StatelessWidget {
  const PriceFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired = true,
  });
  final TextEditingController controller;
  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryFixed,
          ),
      decoration: InputDecoration(
        labelText: label,
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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
    );
  }
}
