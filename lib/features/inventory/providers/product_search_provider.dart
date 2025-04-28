import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/product.dart';
import './filter_prodcut_state_providers.dart';

part 'product_search_provider.g.dart'; // <-- Make sure this matches your file

@riverpod
Future<List<Product>> productSearch(ProductSearchRef ref) async {
  final apiService = await ref.watch(apiServiceProvider.future);

  final search = ref.watch(searchFieldProvider).trim();
  final selectedDepartments = ref.watch(departmentFilterProvider);
  final selectedCategories = ref.watch(categoryFilterProvider);
  final selectedSubCategories = ref.watch(subCategoryFilterProvider);
  final lookinDescription = ref.watch(lookinDescriptionProvider);
  final page = ref.watch(currentPageProvider);

  final products = await apiService.productSearch(
    search: search,
    selectedDepartments: selectedDepartments,
    selectedCategories: selectedCategories,
    selectedSubCategories: selectedSubCategories,
    lookinDescription: lookinDescription,
    page: page,
  );

  ref.keepAlive();

  return products;
}
// // Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.

// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// import './filter_prodcut_state_providers.dart';

// final questionsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
//   final client = http.Client();
//   ref.onDispose(client.close);

//   final search = ref.watch(searchFieldProvider).trim();
//   final selectedDepartments = ref.watch(departmentFilterProvider);
//   final selectedCategories = ref.watch(categoryFilterProvider);

//   final queryParams = <String, String>{
//     'sort': 'title',
//     'order': 'asc',
//     'page': '1',
//     'pagesize': '10',
//   };

//   if (search.isNotEmpty) {
//     queryParams['title'] = search;
//   }

//   if (selectedDepartments.isNotEmpty) {
//     queryParams['department'] = selectedDepartments.join(',');
//   }

//   if (selectedCategories.isNotEmpty) {
//     queryParams['main_catogory'] = selectedCategories.join(',');
//   }

//   final uri = Uri.http('localhost:8080', '/products/search', queryParams);

//   final response = await client.get(uri);

//   if (response.statusCode != 200) {
//     throw Exception('Failed to fetch data: ${response.statusCode}');
//   }

//   final data = jsonDecode(response.body);

//   final products = data['products'];
//   if (products == null || products is! List) {
//     print('❗ Unexpected or missing "products" key: $data');
//     return [];
//   }

//   return products.cast<Map<String, dynamic>>();
// });
