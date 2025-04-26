import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/api/product_tree.dart';
import '../../providers/menu_tree_provider.dart';

class FilterChipsBox extends ConsumerWidget {
  const FilterChipsBox({
    super.key,
    required this.name,
    required this.level,
    required this.provider,
    this.parentProvider,
    this.chipOrDropdown = true,
    this.onChanged,
    this.isSinhala = false,
  });

  final String name;
  final int level;
  final StateProvider<List<String>> provider;
  final StateProvider<List<String>>? parentProvider;
  final bool chipOrDropdown;
  final VoidCallback? onChanged;
  final bool isSinhala;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValues = ref.watch(provider);
    final parentValues = parentProvider != null ? ref.watch(parentProvider!) : <String>[];
    final treeAsync = ref.watch(menutreeProvider);

    return treeAsync.when(
      data: (tree) {
        final childToParent = <String, String>{};
        for (final entry in tree.entries) {
          final parentIndex = entry.key;
          for (final childIndex in entry.value.children) {
            childToParent[childIndex] = parentIndex;
          }
        }

        if (parentProvider != null) {
          final updatedSelected = selectedValues.where((index) {
            final parent = childToParent[index];
            return parent == null || parentValues.contains(parent);
          }).toList();

          if (updatedSelected.length != selectedValues.length) {
            // Update state only if any were removed
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(provider.notifier).state = updatedSelected;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select the related parent tag first 🫰'),
                  duration: Duration(seconds: 2),
                ),
              );
            });
          }
        }

        // Filter relevant nodes based on level and parent selections
        final levelNodes = tree.values
            .where((node) {
              final parentIndex = childToParent[node.index];
              final parentNode = tree[parentIndex];
              final isCorrectLevel = node.level == level;

              final hasValidParent = parentProvider == null ||
                  parentValues.isEmpty ||
                  (parentNode != null &&
                      parentNode.level == level - 1 &&
                      parentValues.contains(parentNode.index));

              return isCorrectLevel && hasValidParent;
            })
            .map((node) => node.index)
            .toList();

        String labelFor(String index) =>
            isSinhala ? (items[index]?.sinhalaName ?? index) : (items[index]?.data ?? index);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
            ),
            const SizedBox(height: 8),
            if (chipOrDropdown)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: levelNodes.map((index) {
                  final isSelected = selectedValues.contains(index);
                  final label = labelFor(index);

                  return Theme(
                    data: Theme.of(context).copyWith(
                      chipTheme: Theme.of(context).chipTheme.copyWith(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Set border radius here
                            ),
                          ),
                    ),
                    child: FilterChip(
                      // avatar: isSelected
                      //     ? const Icon(
                      //         Icons.check, // Replace with your desired icon
                      //         size: 10,
                      //         color: Colors.white,
                      //       )
                      //     : null,
                      selectedColor: const Color(0xFF006FE9),
                      label: Text(
                        label,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        final updated = [...selectedValues];
                        if (selected) {
                          updated.add(index);
                        } else {
                          updated.remove(index);
                        }
                        ref.read(provider.notifier).state = updated;
                        onChanged?.call();
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  );
                }).toList(),
              )
            else
              DropdownButtonFormField<String>(
                value: selectedValues.isEmpty ? null : selectedValues.first,
                hint: Text('Select $name'),
                items: levelNodes
                    .map(
                      (index) => DropdownMenuItem<String>(
                        value: index,
                        child: Text(labelFor(index)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(provider.notifier).state = [value];
                    onChanged?.call();
                  }
                },
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading $name filter: $e')),
    );
  }
}
