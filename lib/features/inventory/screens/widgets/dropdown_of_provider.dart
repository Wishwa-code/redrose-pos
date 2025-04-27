import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/print_logger.dart';

class ProviderDropdownField extends ConsumerWidget {
  const ProviderDropdownField({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.provider,
    this.labelText = 'Select ',
  });

  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final ProviderListenable<AsyncValue<List<dynamic>>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandAsync = ref.watch(provider);

    return brandAsync.when(
      data: (brands) {
        logger.d('🌿 Provider dropdown brands $brands');
        return DropdownButtonFormField<String>(
          value: brands.any((b) => b.name == selectedValue)
              ? selectedValue
              : brands.first.name.toString(),
          isExpanded: true,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: [
            // Optional placeholder item
            ...brands.map(
              (brand) => DropdownMenuItem<String>(
                value: brand.name.toString(),
                child: Text(brand.name.toString()),
              ),
            ),
          ],
          onChanged: onChanged,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading brands: $e'),
    );
  }
}
