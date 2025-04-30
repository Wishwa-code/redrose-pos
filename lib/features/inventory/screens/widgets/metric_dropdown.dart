import 'package:flutter/material.dart';

import 'subunit_config.dart';

class DropdownPriceFormField extends StatelessWidget {
  const DropdownPriceFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.focusNode,
    required this.focusNodetoCall,
    this.isRequired = true,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final FocusNode focusNode;
  final FocusNode focusNodetoCall;
  final bool isRequired;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  // Static list of dropdown items
  List<String> get supportedUnits => unitSubunitMap.keys.toList();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: supportedUnits.contains(controller.text) ? controller.text : null,
      focusNode: focusNode,
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          if (onFieldSubmitted != null) {
            onFieldSubmitted!(value);
          }
          FocusScope.of(context).requestFocus(focusNodetoCall);
        }
      },
      items: supportedUnits
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      decoration: InputDecoration(
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
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      ),
      validator: (value) {
        if (!isRequired && (value == null || value.isEmpty)) return null;
        if (value == null || value.isEmpty) {
          return 'Please select $label'.toLowerCase();
        }
        return null;
      },
    );
  }
}
