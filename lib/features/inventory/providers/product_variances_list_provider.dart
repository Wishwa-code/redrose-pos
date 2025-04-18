import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/variance.dart';

part 'product_variances_list_provider.g.dart';

// final productVariancesProvider =
//     FutureProvider.family<List<Variance>, String>((ref, productId) async {
//   final api = ref.watch(apiServiceProvider.future); // however you're calling your backend

//   final fetchedVariances = await api.fetchVariancesByProductId(productId);
//   return fetchedVariances;
// });

@riverpod
class ProductVariances extends _$ProductVariances {
  @override
  Future<List<Variance>> build(String productId) async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchVariancesByProductId(productId);
    // print(response);

    return response;
  }

  // Future<void> addProduct(Product product, File imageFile) async {
  //   final apiService = await ref.watch(apiServiceProvider.future);

  //   final newProduct = await apiService.addProduct(product, imageFile);

  //   print(newProduct);

  //   // Update the state
  //   state = AsyncData(newProduct);
  // }

  // Future<void> filterVariance(Product product, File imageFile) async {
  //   final apiService = await ref.watch(apiServiceProvider.future);

  //   final newProduct = await apiService.addProduct(product, imageFile);

  //   print(newProduct);

  //   // Update the state
  //   state = AsyncData(newProduct);
  // }

  // Future<void> addProdcut(Product product) async {
  //   final apiService = await.ref.watch(apiServiceProvider.)
  // }
}
