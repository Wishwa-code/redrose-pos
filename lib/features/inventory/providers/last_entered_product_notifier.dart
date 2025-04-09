import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/product.dart';

part 'last_entered_product_notifier.g.dart';

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

@riverpod
class LastProduct extends _$LastProduct {
  @override
  Future<Product> build() async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchLastProduct();

    return response;
  }
}
