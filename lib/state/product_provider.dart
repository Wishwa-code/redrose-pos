// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../api/api_client_service.dart';
// import '../entities/product.dart';

// part 'product_provider.g.dart';

// @riverpod
// Future<List<Product>> products(Ref ref) =>
//     ref.watch(apiServiceProvider).fetchProducts();

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/api_client_service.dart';
import '../entities/product.dart';

// Necessary for code-generation to work
part 'product_provider.g.dart';

@riverpod
Future<List<Product>> product(Ref ref) async {
  final api = await ref.watch(apiServiceProvider.future);
  return api.fetchProducts();
}
