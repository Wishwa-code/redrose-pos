// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../api/api_client_service.dart';
// import '../entities/product.dart';

// // Necessary for code-generation to work
// part 'product_provider.g.dart';

// @riverpod
// Future<List<Product>> product(Ref ref) async {
//   final api = await ref.watch(apiServiceProvider.future);
//   return api.fetchProducts();
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/api_client_service.dart';
import '../entities/product.dart';

// Necessary for code-generation to work
part 'product_provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<List<Product>> product(Ref ref) async {
  //http: //localhost:8080/products
  // Fetch the list of products from the API.

  final response = await ref.watch(apiServiceProvider.future);

  final result = response.fetchProducts();
  //print(response.body);

  // Decode the JSON payload into a Map data structure.
  return result;
}
