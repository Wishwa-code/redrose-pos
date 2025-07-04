import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/product.dart';

part 'last_entered_product_notifier.g.dart';

@riverpod
class LastProduct extends _$LastProduct {
  @override
  Future<Product> build() async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchLastProduct();
    // print(response);

    return response;
  }

  Future<void> addProduct(Product product, File imageFile) async {
    final apiService = await ref.watch(apiServiceProvider.future);

    final newProduct = await apiService.addProduct(product, imageFile);

    print(newProduct);

    // Update the state
    state = AsyncData(newProduct);
  }

  Future<void> fetchProductById(String id) async {
    state = const AsyncLoading(); // optional
    try {
      final apiService = await ref.watch(apiServiceProvider.future);
      final product = await apiService.fetchProductById(id);
      state = AsyncData(product);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateProduct(Product product, File? imageFile) async {
    state = const AsyncLoading();
    try {
      final apiService = await ref.watch(apiServiceProvider.future);
      final updatedProduct = await apiService.updateProduct(product, imageFile);
      state = AsyncData(updatedProduct);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}








// @riverpod
// Future<List<Product>> lastProduct(Ref ref) async {
//   //http: //localhost:8080/products
//   // Fetch the list of products from the API.

//   final response = await ref.watch(apiServiceProvider.future);

//   final result = response.fetchProducts();
//   //print(response.body);

//   // Decode the JSON payload into a Map data structure.
//   return result;
// }
//   Future<List<Product>> fetchLastProduct() async {

  //   Future<void> filterVariance(Product product, File imageFile) async {
  //   final apiService = await ref.watch(apiServiceProvider.future);

  //   final newProduct = await apiService.addProduct(product, imageFile);

  //   print(newProduct);

  //   // Update the state
  //   state = AsyncData(newProduct);
  // }

  // Future<void> addProdcut(Product product) async {
  //   final apiService = await.ref.watch(apiServiceProvider.)
  // }