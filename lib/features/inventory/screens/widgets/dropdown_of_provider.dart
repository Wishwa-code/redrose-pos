import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderDropdownField extends ConsumerWidget {
  const ProviderDropdownField({
    super.key,
    required this.selectedBrandId,
    required this.onChanged,
    required this.provider,
    this.labelText = 'Select ',
  });

  final String? selectedBrandId;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final ProviderListenable<AsyncValue<List<dynamic>>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandAsync = ref.watch(provider);

    return brandAsync.when(
      data: (brands) {
        return DropdownButtonFormField<String>(
          value: selectedBrandId,
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
