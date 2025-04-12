//!in this component isattached variable is used to check whether the current filed iis connecteed with parent field
//!which is the case only when variable are are part of current tree but tagone1 and tagtwo1 are added for future use
//!there fore is atatched false make thos drop down listt work freely

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../providers/enums_provider.dart';

// class EnumDropdownField extends ConsumerWidget {
//   const EnumDropdownField({
//     super.key,
//     required this.name,
//     required this.label,
//     required this.controller,
//     required this.parentController, // Add parentController parameter
//     required this.onParentStateChanged, // New required parameter
//     required this.isattached,
//   });

//   final String name;
//   final String label;
//   final TextEditingController controller;
//   final TextEditingController parentController; // parentControllers
//   final void Function() onParentStateChanged; // Callback function
//   final bool isattached;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final enumsAsync = ref.watch(rrenumsProvider);

//     return enumsAsync.when(
//       data: (groupedEnums) {
//         final items = groupedEnums[name] ?? [];

//         // print(
//         //   'name: $name items ----------------------------------------->> $items in this $groupedEnums',
//         // );

//         // Filter items based on parentIndex
//         // final filteredItems = isattached // Use boolean first, it is more readable way.
//         //     ? items
//         //         .where(
//         //           (item) => item.parentIndex == null || item.parentIndex == parentController.text,
//         //         )
//         //         .toList() // If `isattached` is true to the tree, it filters by conditions
//         //     : items; //  Or use item that is passed as a parent

//         final filteredItems =
//             items.where((item) => item.parentIndex == parentController.text).toList();

//         // print('parentController $parentController');

//         if (filteredItems.isEmpty) {
//           return Text('No values for "${parentController.text}" based on selection.');
//         }

//         return FormBuilderDropdown<String>(
//           name: name,
//           decoration: InputDecoration(labelText: label),
//           onChanged: (value) {
//             // This makes a bit confused please fix it and try to improve the code
//             controller.text = value ?? '';
//             if (isattached) {
//               onParentStateChanged();
//             }
//           },
//           items: filteredItems
//               .map(
//                 (e) => DropdownMenuItem(
//                   value: e.enumValue,
//                   child: Text(e.enumValue),
//                 ),
//               )
//               .toList(),
//         );
//       },
//       loading: () => const CircularProgressIndicator(),
//       error: (e, _) => Text('Error loading $name values: $e'),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/api/product_tree.dart';
// import '../../models/tree_node.dart'; // If TreeNode is defined in a separate file
import '../../providers/enums_provider.dart'; // Assuming this has your enumTreeProvider

class EnumDropdownField extends ConsumerWidget {
  const EnumDropdownField({
    super.key,
    required this.name,
    required this.label,
    required this.controller,
    required this.parentController,
    required this.level,
    required this.onParentStateChanged,
    required this.isattached,
  });

  final String name;
  final String label;
  final TextEditingController controller;
  final int level;
  final TextEditingController parentController;
  final void Function() onParentStateChanged;
  final bool isattached;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeAsync = ref.watch(rrenumsProvider);

    return treeAsync.when(
      data: (tree) {
        // Step 1: Build a reverse lookup map: child -> parent
        final childToParent = <String, String>{};
        for (final entry in tree.entries) {
          final parentIndex = entry.key;
          for (final childIndex in entry.value.children) {
            childToParent[childIndex] = parentIndex;
          }
        }

        // Step 2: Get nodes where:
        // - the level of the parent is equal to passed `level`
        // - the parent's index matches parentController.text
        // final filteredNodes = tree.values.where((node) {
        //   final parentIndex = childToParent[node.index];
        //   final parentNode = tree[parentIndex];
        //   return parentNode != null &&
        //       parentNode.level == level - 1 &&
        //       parentNode.index == parentController.text;
        // }).toList();
        // final nodesAtLevel = tree.values.where((node) => node.level == level).toList();
        List<TreeNode> filteredNodes;

        if (isattached) {
          filteredNodes = tree.values.where((node) {
            final parentIndex = childToParent[node.index];
            final parentNode = tree[parentIndex];
            return parentNode != null &&
                parentNode.level == level - 1 &&
                parentNode.index == parentController.text;
          }).toList();
        } else {
          if (level == -1) {
            filteredNodes = [
              const TreeNode(
                index: 'N/A',
                available: true,
                isFolder: false,
                children: [],
                data: 'N/A',
                level: -1,
                image: '',
              ),
              for (var i = 1; i <= 5; i++)
                TreeNode(
                  index: 'tagone$i',
                  available: true,
                  isFolder: false,
                  children: const [],
                  data: 'tagone$i',
                  level: -1,
                  image: '',
                ),
            ];
          } else if (level == -2) {
            filteredNodes = [
              const TreeNode(
                index: 'N/A',
                available: true,
                isFolder: false,
                children: [],
                data: 'N/A',
                level: -2,
                image: '',
              ),
              for (var i = 1; i <= 5; i++)
                TreeNode(
                  index: 'tagtwo$i',
                  available: true,
                  isFolder: false,
                  children: const [],
                  data: 'tagtwo$i',
                  level: -2,
                  image: '',
                ),
            ];
          } else {
            filteredNodes = tree.values.where((node) => node.level == level).toList();
          }
        }

        // final filteredNodes = isattached
        //     ? tree.values.where((node) {
        //         final parentIndex = childToParent[node.index];
        //         final parentNode = tree[parentIndex];
        //         return parentNode != null &&
        //             parentNode.level == level - 1 &&
        //             parentNode.index == parentController.text;
        //       }).toList() // If `isattached` is true to the tree, it filters by conditions
        //     : tree.values
        //         .where((node) => node.level == level)
        //         .toList(); //  Or use item that is passed as a parent

        if (filteredNodes.isEmpty) {
          return Text('No items found at level $level.');
        }

        return FormBuilderDropdown<String>(
          name: name,
          decoration: InputDecoration(labelText: label),
          onChanged: (value) {
            controller.text = value ?? '';
            if (isattached) {
              onParentStateChanged();
            }
          },
          items: filteredNodes
              .map(
                (node) => DropdownMenuItem(
                  value: node.index,
                  child: Text(node.index),
                ),
              )
              .toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading tree data: $e'),
    );
  }
}
