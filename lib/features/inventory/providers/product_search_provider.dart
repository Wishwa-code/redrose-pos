// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final searchFieldProvider = StateProvider<String>((ref) => '');
final departmentFilterProvider = StateProvider<List<String>>((ref) => []);
final categoryFilterProvider = StateProvider<List<String>>((ref) => []);

final questionsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = http.Client();
  ref.onDispose(client.close);

  final search = ref.watch(searchFieldProvider);

  final selectedDepartments = ref.watch(departmentFilterProvider);

  final selectedCategories = ref.watch(categoryFilterProvider);
  print('selectedCategories $selectedCategories');

  Uri uri;

  if (selectedDepartments.isNotEmpty && selectedCategories.isNotEmpty && search.isEmpty) {
    final departmentQuery = selectedDepartments.join(',');
    final categoryquery = selectedCategories.join(',');

    uri = Uri.parse(
      'http://localhost:8080/products/search?department=$departmentQuery&main_catogory=$categoryquery',
    );
  } else if (selectedDepartments.isNotEmpty && search.isEmpty) {
    final departmentQuery = selectedDepartments.join(',');
    uri = Uri.parse(
      'http://localhost:8080/products/search?department=$departmentQuery',
    );
  } else if (selectedDepartments.isNotEmpty) {
    final encodedQuery = Uri.encodeComponent(search);
    final departmentQuery = selectedDepartments.join(',');

    uri = Uri.parse(
      'http://localhost:8080/products/search?title=$encodedQuery&department=$departmentQuery',
    );
  } else if (search.isEmpty) {
    uri = Uri.parse(
      'http://localhost:8080/products/search?title=cement',
    );
  } else {
    final encodedQuery = Uri.encodeComponent(search);
    print(encodedQuery);
    uri = Uri.parse(
      'http://localhost:8080/products/search?title=$encodedQuery&department=mainplumbing',
    );
  }

  final response = await client.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch data: ${response.statusCode}');
  }

  final data = jsonDecode(response.body);
  print(data);

  final products = data['products'];
  if (products == null || products is! List) {
    print('❗ Unexpected or missing "products" key: $data');
    return [];
  }

  print(products);

  return products.cast<Map<String, dynamic>>();
});

// void main() => runApp(const ProviderScope(child: MyApp()));

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: MyHomePage());
//   }
// }

// class MyHomePage extends ConsumerWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final questions = ref.watch(questionsProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Questions')),
//       body: Column(
//         children: [
//           TextField(
//             onChanged: (value) =>
//                 ref.read(searchFieldProvider.notifier).state = value,
//           ),
//           Expanded(
//             child: switch (questions) {
//               AsyncData(:final value) => ListView.builder(
//                   itemCount: value.length,
//                   itemBuilder: (context, index) {
//                     final question = value[index];

//                     return ListTile(
//                       title: Text(
//                         question.toString(),
//                       ),
//                     );
//                   },
//                 );,
//               AsyncError(:final error) => Center(child: Text('Error $error')),
//               _ => const Center(child: CircularProgressIndicator()),
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
