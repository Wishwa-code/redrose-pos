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
  });

  final String name;
  final int level;
  final StateProvider<List<String>> provider;
  final StateProvider<List<String>>? parentProvider;
  final bool chipOrDropdown;
  final VoidCallback? onChanged;

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

        String labelFor(String index) => items[index]?.data ?? index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (chipOrDropdown)
              Wrap(
                spacing: 8,
                children: levelNodes.map((index) {
                  final isSelected = selectedValues.contains(index);
                  final label = labelFor(index);

                  return FilterChip(
                    label: Text(label),
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
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading $name filter: $e'),
    );
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class FilterChips extends ConsumerWidget {
// //   const FilterChips({
// //     super.key,
// //     required this.name,
// //     required this.options,
// //     required this.provider,
// //   });
// //   final String name; // Not used in logic, but nice to label
// //   final List<String> options;
// //   final StateProvider<List<String>> provider;

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final selectedValues = ref.watch(provider);

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(name, style: Theme.of(context).textTheme.titleMedium),
// //         const SizedBox(height: 8),
// //         Wrap(
// //           spacing: 8,
// //           children: options.map((option) {
// //             final isSelected = selectedValues.contains(option);
// //             return FilterChip(
// //               label: Text(option),
// //               selected: isSelected,
// //               onSelected: (bool selected) {
// //                 final newList = [...selectedValues];
// //                 if (selected) {
// //                   newList.add(option);
// //                 } else {
// //                   newList.remove(option);
// //                 }
// //                 ref.read(provider.notifier).state = newList;
// //               },
// //             );
// //           }).toList(),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '/api/product_tree.dart';
// import '../../providers/menu_tree_provider.dart'; // Assuming this has your enumTreeProvider

// class FilterChipsBox extends ConsumerWidget {
//   const FilterChipsBox({
//     super.key,
//     required this.name,
//     required this.level,
//     required this.provider,
//     required this.parentProvider,
//   });

//   final String name;
//   final int level;
//   final StateProvider<List<String>> provider;
//   final StateProvider<List<String>> parentProvider;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedValues = ref.watch(provider);
//     final selectedParentValues = ref.watch(parentProvider);
//     final treeAsync = ref.watch(menutreeProvider);

//     // Get all TreeNode indexes at the given level

//     return treeAsync.when(
//       data: (tree) {
//         final childToParent = <String, String>{};
//         for (final entry in tree.entries) {
//           final parentIndex = entry.key;
//           for (final childIndex in entry.value.children) {
//             childToParent[childIndex] = parentIndex;
//           }
//         }

//         // final levelNodes =
//         //     tree.values.where((node) => node.level == level).map((node) => node.index).toList();
//         final levelNodes = tree.values
//             .where((node) {
//               final parentIndex = childToParent[node.index];
//               final parentNode = tree[parentIndex];
//               return node.level == level &&
//                   (selectedParentValues.isEmpty ||
//                       (parentNode != null &&
//                           parentNode.level == level - 1 &&
//                           selectedParentValues.contains(parentNode.index)));
//             })
//             .map((node) => node.index)
//             .toList();

//         // print('level nodes$levelNodes');

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(name, style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               children: levelNodes.map((index) {
//                 final isSelected = selectedValues.contains(index);
//                 final label = items[index]?.data ?? index;

//                 return FilterChip(
//                   label: Text(label),
//                   selected: isSelected,
//                   onSelected: (bool selected) {
//                     final newList = [...selectedValues];
//                     if (selected) {
//                       newList.add(index);
//                     } else {
//                       newList.remove(index);
//                     }
//                     ref.read(provider.notifier).state = newList;
//                   },
//                 );
//               }).toList(),
//             ),
//           ],
//         );
//       },
//       loading: () => const CircularProgressIndicator(),
//       error: (e, _) => Text('Error loading tree data: $e'),
//     );
//   }
// }
