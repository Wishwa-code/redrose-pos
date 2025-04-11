import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/enums_provider.dart';

class EnumDropdownField extends ConsumerWidget {
  const EnumDropdownField({
    super.key,
    required this.name,
    required this.label,
    this.onChanged,
  });
  final String name;
  final String label;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enumsAsync = ref.watch(enumsProvider);

    return enumsAsync.when(
      data: (groupedEnums) {
        final items = groupedEnums[name] ?? [];

        if (items.isEmpty) {
          return Text('No values for "$name"');
        }

        return FormBuilderDropdown<String>(
          name: name,
          onChanged: onChanged,
          decoration: InputDecoration(labelText: label),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e.enumValue,
                  child: Text(e.enumValue),
                ),
              )
              .toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading $name values: $e'),
    );
  }
}
