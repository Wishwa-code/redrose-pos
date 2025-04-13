// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FilterChips extends ConsumerWidget {
//   const FilterChips({
//     super.key,
//     required this.name,
//     required this.options,
//     required this.provider,
//   });
//   final String name; // Not used in logic, but nice to label
//   final List<String> options;
//   final StateProvider<List<String>> provider;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedValues = ref.watch(provider);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(name, style: Theme.of(context).textTheme.titleMedium),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: options.map((option) {
//             final isSelected = selectedValues.contains(option);
//             return FilterChip(
//               label: Text(option),
//               selected: isSelected,
//               onSelected: (bool selected) {
//                 final newList = [...selectedValues];
//                 if (selected) {
//                   newList.add(option);
//                 } else {
//                   newList.remove(option);
//                 }
//                 ref.read(provider.notifier).state = newList;
//               },
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/api/product_tree.dart';
import '../../providers/enums_provider.dart'; // Assuming this has your enumTreeProvider

class FilterChipsBox extends ConsumerWidget {
  const FilterChipsBox({
    super.key,
    required this.name,
    required this.level,
    required this.provider,
  });

  final String name;
  final int level;
  final StateProvider<List<String>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValues = ref.watch(provider);
    final treeAsync = ref.watch(rrenumsProvider);

    // Get all TreeNode indexes at the given level

    return treeAsync.when(
      data: (tree) {
        final levelNodes =
            tree.values.where((node) => node.level == level).map((node) => node.index).toList();
        // print('level nodes$levelNodes');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: levelNodes.map((index) {
                final isSelected = selectedValues.contains(index);
                final label = items[index]?.data ?? index;

                return FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    final newList = [...selectedValues];
                    if (selected) {
                      newList.add(index);
                    } else {
                      newList.remove(index);
                    }
                    ref.read(provider.notifier).state = newList;
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading tree data: $e'),
    );
  }
}
