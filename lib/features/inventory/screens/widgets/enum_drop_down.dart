//!in this component isattached variable is used to check whether the current filed iis connecteed with parent field
//!which is the case only when variable are are part of current tree but tagone1 and tagtwo1 are added for future use
//!there fore is atatched false make thos drop down listt work freely

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/api/product_tree.dart';
// import '../../models/tree_node.dart'; // If TreeNode is defined in a separate file
import '../../providers/menu_tree_provider.dart'; // Assuming this has your enumTreeProvider

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
    final treeAsync = ref.watch(menutreeProvider);

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
                sinhalaName: 'නැත',
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
                  sinhalaName: 'පලවනිපලවනි ටැග් එක',
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
                sinhalaName: 'නැත',
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
                  sinhalaName: 'දෙවැනි ටැග් එක',
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              'No $label found.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
            ),
          );
        }

        return FormBuilderDropdown<String>(
          name: name,
          initialValue:
              filteredNodes.contains(controller.text) ? controller.text : filteredNodes.first.index,
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
                  child: Text(node.sinhalaName),
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

// //!in this component isattached variable is used to check whether the current filed iis connecteed with parent field
// //!which is the case only when variable are are part of current tree but tagone1 and tagtwo1 are added for future use
// //!there fore is atatched false make thos drop down listt work freely

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '/api/product_tree.dart';
// // import '../../models/tree_node.dart'; // If TreeNode is defined in a separate file
// import '../../providers/menu_tree_provider.dart'; // Assuming this has your enumTreeProvider

// class EnumDropdownField extends ConsumerStatefulWidget {
//   const EnumDropdownField({
//     super.key,
//     required this.name,
//     required this.label,
//     required this.controller,
//     required this.parentController,
//     required this.level,
//     required this.onParentStateChanged,
//     required this.isattached,
//   });

//   final String name;
//   final String label;
//   final TextEditingController controller;
//   final int level;
//   final TextEditingController parentController;
//   final void Function() onParentStateChanged;
//   final bool isattached;

//   @override
//   ConsumerState<EnumDropdownField> createState() => _EnumDropdownFieldState();
// }

// class _EnumDropdownFieldState extends ConsumerState<EnumDropdownField> {
//   late String _currentValue;

//   @override
//   void initState() {
//     super.initState();

//     _currentValue = widget.controller.text;

//     widget.controller.addListener(() {
//       if (_currentValue != widget.controller.text) {
//         setState(() {
//           _currentValue = widget.controller.text;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final treeAsync = ref.watch(menutreeProvider);

//     return treeAsync.when(
//       data: (tree) {
//         // Step 1: Build a reverse lookup map: child -> parent
//         final childToParent = <String, String>{};
//         for (final entry in tree.entries) {
//           final parentIndex = entry.key;
//           for (final childIndex in entry.value.children) {
//             childToParent[childIndex] = parentIndex;
//           }
//         }

//         // Step 2: Get nodes where:
//         // - the level of the parent is equal to passed `level`
//         // - the parent's index matches parentController.text
//         // final filteredNodes = tree.values.where((node) {
//         //   final parentIndex = childToParent[node.index];
//         //   final parentNode = tree[parentIndex];
//         //   return parentNode != null &&
//         //       parentNode.level == level - 1 &&
//         //       parentNode.index == parentController.text;
//         // }).toList();
//         // final nodesAtLevel = tree.values.where((node) => node.level == level).toList();
//         List<TreeNode> filteredNodes;

//         if (widget.isattached) {
//           filteredNodes = tree.values.where((node) {
//             final parentIndex = childToParent[node.index];
//             final parentNode = tree[parentIndex];
//             return parentNode != null &&
//                 parentNode.level == widget.level - 1 &&
//                 parentNode.index == widget.parentController.text;
//           }).toList();
//         } else {
//           if (widget.level == -1) {
//             filteredNodes = [
//               const TreeNode(
//                 index: 'N/A',
//                 available: true,
//                 isFolder: false,
//                 children: [],
//                 data: 'N/A',
//                 level: -1,
//                 image: '',
//               ),
//               for (var i = 1; i <= 5; i++)
//                 TreeNode(
//                   index: 'tagone$i',
//                   available: true,
//                   isFolder: false,
//                   children: const [],
//                   data: 'tagone$i',
//                   level: -1,
//                   image: '',
//                 ),
//             ];
//           } else if (widget.level == -2) {
//             filteredNodes = [
//               const TreeNode(
//                 index: 'N/A',
//                 available: true,
//                 isFolder: false,
//                 children: [],
//                 data: 'N/A',
//                 level: -2,
//                 image: '',
//               ),
//               for (var i = 1; i <= 5; i++)
//                 TreeNode(
//                   index: 'tagtwo$i',
//                   available: true,
//                   isFolder: false,
//                   children: const [],
//                   data: 'tagtwo$i',
//                   level: -2,
//                   image: '',
//                 ),
//             ];
//           } else {
//             filteredNodes = tree.values.where((node) => node.level == widget.level).toList();
//           }
//         }

//         // final filteredNodes = isattached
//         //     ? tree.values.where((node) {
//         //         final parentIndex = childToParent[node.index];
//         //         final parentNode = tree[parentIndex];
//         //         return parentNode != null &&
//         //             parentNode.level == level - 1 &&
//         //             parentNode.index == parentController.text;
//         //       }).toList() // If `isattached` is true to the tree, it filters by conditions
//         //     : tree.values
//         //         .where((node) => node.level == level)
//         //         .toList(); //  Or use item that is passed as a parent

//         if (filteredNodes.isEmpty) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//             child: Text(
//               'No ${widget.label} found.',
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onPrimaryFixed,
//                   ),
//             ),
//           );
//         }

//         return FormBuilderDropdown<String>(
//           name: widget.name,
//           initialValue: _currentValue,
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                 color: Theme.of(context).colorScheme.onPrimaryFixed,
//               ),
//           decoration: InputDecoration(
//             labelText: widget.label,
//             labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
//                   color: Theme.of(context).colorScheme.onPrimaryFixed,
//                 ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Theme.of(context).colorScheme.outline,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           onChanged: (value) {
//             widget.controller.text = value ?? 'what';
//             if (widget.isattached) {
//               widget.onParentStateChanged();
//             }
//           },
//           items: filteredNodes
//               .map(
//                 (node) => DropdownMenuItem(
//                   value: node.index,
//                   child: Text(node.index),
//                 ),
//               )
//               .toList(),
//         );
//       },
//       loading: () => const CircularProgressIndicator(),
//       error: (e, _) => Text('Error loading tree data: $e'),
//     );
//   }
// }
