import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../features/inventory/models/enum_item.dart';
import '../features/inventory/models/product.dart';
import './product_tree.dart';

class SupabaseUploadResponse {
  SupabaseUploadResponse({
    required this.path,
    required this.id,
    required this.fullPath,
  });

  factory SupabaseUploadResponse.fromJson(Map<String, dynamic> json) {
    return SupabaseUploadResponse(
      path: json['path'] as String,
      id: json['id'] as String,
      fullPath: json['fullPath'] as String,
    );
  }
  final String path;
  final String id;
  final String fullPath;
}

typedef ApiClientException = DioException;
typedef ApiClientResponse<T> = Response<T>;
typedef ApiClientRequestOptions = RequestOptions;
typedef _ResponseData = Map<String, Object?>;

extension ApiClientExceptionX on ApiClientException {
  String? get responseMessage => response?.data?['message'] as String?;
}

///? An API client that makes network requests.
///
/// This class is meant to be seen as a representation of the common API contract
/// or API list (such as Swagger or Postman) given by the backend.
///
/// This class does not maintain authentication state, but rather receive the token
/// from external source.
///
/// When a widget or provider wants to make a network request, it should not
/// instantiate this class, but instead call the provider that exposes an object
/// of this type.
class ApiClient {
  /// Creates an [ApiClient] with default options.
  ApiClient() : _httpClient = Dio(_defaultOptions);

  /// Creates an [ApiClient] with [token] set for authorization.
  ApiClient.withToken(String token)
      : _httpClient = Dio(
          _defaultOptions.copyWith()..headers['Authorization'] = 'Bearer $token',
        );
  static final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: 'http://localhost:8080',
  );

  final Dio _httpClient;
  final Map<String, TreeNode> treeData = items;

  @override
  String toString() {
    return "ApiClient(_httpClient.options.headers['Authorization']: ${_httpClient.options.headers['Authorization']})";
  }

  Future<List<Product>> fetchProducts() async {
    final response = await _httpClient.get('/products');

    return (response.data['products'] as List).cast<_ResponseData>().map(Product.fromJson).toList();
  }

  Future<Product> fetchLastProduct() async {
    final response = await _httpClient.get('/last-product');

    print(response);

    // Assuming the API response contains a 'product' key with a single product object
    final productData = response.data['product'] as Map<String, dynamic>;

    // Return the product parsed using Product.fromJson
    return Product.fromJson(productData);
  }

  Future<Product> addProduct(Product product, File imageFile) async {
    final fileName = imageFile.path.split(r'\').last;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    final imgresponse = await _httpClient.post(
      'https://yqewezudxihyadvmfovd.supabase.co/functions/v1/storage-upload',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    final imgData = imgresponse.data['data'];
    final rawPath = imgData['path'] as String;
    final encodedPath = Uri.encodeComponent(rawPath); // encodes spaces + other special chars

    final publicUrl =
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/public/product_images/$encodedPath';

    print('🖼️ Public Image URL: $publicUrl');

    final updatedProduct = product.copyWith(imageUrl: publicUrl);

    print('updated prodcut: $updatedProduct ');

    final response = await _httpClient.post(
      '/products',
      data: updatedProduct.toJson(), // Assuming your Product model has a `toJson()` method
    );

    print('Response: $response');

    // Parse the response JSON
    final productData = response.data['product'] as Map<String, dynamic>;

    return Product.fromJson(productData);
  }

  // Future<Map<String, List<EnumItem>>> getEnums() async {
  //   try {
  //     final response = await _httpClient.get('/enums');

  //     final data = response.data['enums'] as List<dynamic>;
  //     final enums = data.map((item) => EnumItem.fromJson(item as Map<String, dynamic>)).toList();

  //     final parentLookup = _generateParentLookup(treeData, enums);

  //     print('parent lookup ------------------------------------->>>>>>$parentLookup');

  //     final groupedEnums = <String, List<EnumItem>>{};
  //     for (final enumItem in enums) {
  //       final parentIdx = parentLookup[enumItem.enumName];

  //       // print('parentIdx-------->>>> $parentIdx enum item ---------->$enumItem ');

  //       final itemWithParent = enumItem.copyWith(parentIndex: parentIdx);

  //       groupedEnums.putIfAbsent(itemWithParent.enumName, () => []).add(itemWithParent);
  //     }

  //     return groupedEnums;
  //   } catch (e) {
  //     // Log the error or handle it as needed
  //     print('Error fetching or processing enums: $e');
  //     // Rethrow or return an empty map/default value depending on requirements
  //     rethrow;
  //     // Or return {};
  //   }
  // }

  Future<Map<String, TreeNode>> fetchEnumsAndBuildTree() async {
    try {
      final response = await _httpClient.get('/enums');

      final data = response.data['enums'] as List<dynamic>;
      final enums = data.map((item) => EnumItem.fromJson(item as Map<String, dynamic>)).toList();

      // You can use enums if needed for any tree data enrichment, or skip this if tree is static.

      // Assuming you already have the raw tree defined (like `items`)
      final updatedTree = updateTreeLevels(items);

      // print('🌳 Updated tree with levels:');
      // updatedTree.forEach((key, node) {
      //   print('Node: $key -> Level: ${node.level}');
      // });

      return updatedTree;
    } catch (e) {
      print('❌ Error fetching enums or building tree: $e');
      rethrow;
    }
  }

  Map<String, TreeNode> updateTreeLevels(Map<String, TreeNode> originalTree) {
    final updatedTree = <String, TreeNode>{};

    void traverse(String nodeId, int currentLevel) {
      final node = originalTree[nodeId];
      if (node == null) return;

      // Create a new node with the updated level
      final updatedNode = TreeNode(
        index: node.index,
        available: node.available,
        isFolder: node.isFolder,
        children: node.children,
        data: node.data,
        level: currentLevel,
        image: node.image,
      );

      updatedTree[nodeId] = updatedNode;

      for (final childId in node.children) {
        traverse(childId, currentLevel + 1);
      }
    }

    // Start from root with level 0
    traverse('root', 0);

    return updatedTree;
  }

  //? below method is not working yet
  // Future<Product> fetchProduct(int id) async {
  //   final response = await _httpClient.get('/products/$id');

  //   return Product.fromJson(response.data as _ResponseData);
  // }
}

/// Attempts to login with the login [data], returns the token if success.
// Future<String> login(Login data) async {
//   final response = await _httpClient.post(
//     '/auth/login',
//     data: {
//       ...data.toJson(),
//       'expiresInMins': 43200,
//     },
//   );

//   return response.data['accessToken'] as String;
// }

// Future<Profile> fetchProfile() async {
//   final response = await _httpClient.get('/user/me');

//   return Profile.fromJson(response.data as _ResponseData);
// }
