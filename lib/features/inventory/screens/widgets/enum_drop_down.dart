// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../providers/enums_provider.dart';

// class EnumDropdownField extends ConsumerWidget {
//   const EnumDropdownField({
//     super.key,
//     required this.name,
//     required this.label,
//     this.onChanged,
//   });
//   final String name;
//   final String label;
//   final void Function(String?)? onChanged;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final enumsAsync = ref.watch(enumsProvider);

//     return enumsAsync.when(
//       data: (groupedEnums) {
//         final items = groupedEnums[name] ?? [];

//         if (items.isEmpty) {
//           return Text('No values for "$name"');
//         }

//         return FormBuilderDropdown<String>(
//           name: name,
//           onChanged: onChanged,
//           decoration: InputDecoration(labelText: label),
//           items: items
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

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../providers/enums_provider.dart';

// class EnumDropdownField extends ConsumerWidget {
//   const EnumDropdownField({
//     super.key,
//     required this.name,
//     required this.label,
//     required this.controller, // Add controller parameter
//   });

//   final String name;
//   final String label;
//   final TextEditingController controller; // Controller to be updated
// // No onChanged: using the controller makes it unnecessary

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final enumsAsync = ref.watch(enumsProvider);

//     return enumsAsync.when(
//       data: (groupedEnums) {
//         final items = groupedEnums[name] ?? [];

//         if (items.isEmpty) {
//           return Text('No values for "$name"');
//         }

//         return FormBuilderDropdown<String>(
//           name: name,
//           decoration: InputDecoration(labelText: label),
//           onChanged: (value) {  // Set dropdown text to the controller value
//             controller.text = value ?? ''; // Update the text form on any change
//           },
//           items: items
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

import '../../providers/enums_provider.dart';

class EnumDropdownField extends ConsumerWidget {
  const EnumDropdownField({
    super.key,
    required this.name,
    required this.label,
    required this.controller,
    required this.parentController, // Add parentController parameter
    required this.onParentStateChanged, // New required parameter
  });

  final String name;
  final String label;
  final TextEditingController controller;
  final TextEditingController parentController; // parentControllers
  final void Function() onParentStateChanged; // Callback function

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enumsAsync = ref.watch(enumsProvider);

    return enumsAsync.when(
      data: (groupedEnums) {
        final items = groupedEnums[name] ?? [];

        print('items $items');

        // Filter items based on parentIndex
        final filteredItems = items
            .where((item) => item.parentIndex == null || item.parentIndex == parentController.text)
            .toList();

        print('parentController $parentController');

        if (filteredItems.isEmpty) {
          return Text('No values for "${parentController.text}" based on selection.');
        }

        return FormBuilderDropdown<String>(
          name: name,
          decoration: InputDecoration(labelText: label),
          onChanged: (value) {
            // This makes a bit confused please fix it and try to improve the code
            controller.text = value ?? '';
            onParentStateChanged();
          },
          items: filteredItems
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
