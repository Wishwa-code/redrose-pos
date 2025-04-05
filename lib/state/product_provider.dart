import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/product.dart';

// Necessary for code-generation to work
part 'product_provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<List<Product>> activity(Ref ref) async {
  //http: //localhost:8080/products
  // Fetch the list of products from the API.
  final response = await http.get(Uri.http('localhost:8080', '/products'));
  //print(response.body);

  // Decode the JSON payload into a Map data structure.
  final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

  // Access the list of products using the correct key.
  final jsonList = jsonMap['products'] as List<dynamic>;

  // Convert each item in the list into an Activity instance.
  return jsonList.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
}
