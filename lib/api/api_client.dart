import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import '../features/inventory/models/enum_item.dart';
import '../features/inventory/models/product.dart';
import '../features/inventory/models/supplier.dart';
import '../features/inventory/models/brand.dart';
import '../features/inventory/models/variance.dart';
import './product_tree.dart';

Logger logger = Logger(
  printer: PrettyPrinter(),
);

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

  ///
  ///
  ///! This is the section for inventory page related api calls
  ///
  ///

  Future<List<Product>> fetchProducts() async {
    final response = await _httpClient.get<Map<String, dynamic>>('/products');

    final data = response.data;

    if (data == null || data['products'] == null) {
      logger.d('got a null value for fetch prodcuts: $data');

      return []; // or handle the null case however you'd like
    }

    return (data['products'] as List).cast<_ResponseData>().map(Product.fromJson).toList();
  }

  Future<Product> fetchLastProduct() async {
    final response = await _httpClient.get('/last-product');

    logger.d('Last added product: $response');

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

    final updatedProduct = product.copyWith(imageUrl: publicUrl);

    final response = await _httpClient.post(
      '/products/insert',
      data: updatedProduct.toJson(), // Assuming your Product model has a `toJson()` method
    );

    logger.d('add product response: $response');

    // Parse the response JSON
    final productData = response.data['product'] as Map<String, dynamic>;

    return Product.fromJson(productData);
  }

  ///
  ///
  ///! This is the section for menu tree related api calls
  ///
  ///

  Future<Map<String, TreeNode>> fetchEnumsAndBuildTree() async {
    try {
      final response = await _httpClient.get('/enums');

      final data = response.data['enums'] as List<dynamic>;
      final enums = data.map((item) => EnumItem.fromJson(item as Map<String, dynamic>)).toList();

      final updatedTree = updateTreeLevels(items);

      return updatedTree;
    } catch (e) {
      logger.f('building tree failed: $e');
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

//! ============================================================================ //
//? ================= ✈️ PRODCUT VARIANCE RELATED API calls ✈️ ===================== //
//! ============================================================================ //



  Future<Variance> fetchLastVariance() async {
    final response = await _httpClient.get('/variance/last');

    logger.d('Last added variance: $response');

    final varianceData = response.data['variance'] as Map<String, dynamic>;

    return Variance.fromJson(varianceData);
  }

  Future<Variance> addVariance(Variance product, File imageFile) async {
    try {
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

      final updatedProduct = product.copyWith(imageUrl: publicUrl);

      final response = await _httpClient.post(
        '/variance/upsert',
        data: updatedProduct.toJson(), // Assuming your Product model has a `toJson()` method
      );

      logger.d('add variance response[pipe level:api client]: $response');

      // ✅ Extract the nested `product` map
      final responseMap = response.data as Map<String, dynamic>;
      final varianceMap = responseMap['product'] as Map<String, dynamic>;

// ✅ Convert to Variance model
      return Variance.fromJson(varianceMap);
    } catch (e) {
      logger.f('adding variance failed: $e');
      rethrow;
    }
  }


Future<List<Variance>> fetchVariancesByProductId(String productId) async {
    try {
      final response = await _httpClient.get('/variance/by-product/$productId');

      logger.d('Fetched variances for product $productId: $response');

      final data = response.data['variances'] as List<dynamic>;

      return data.map((json) => Variance.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      logger.f('Error fetching variances for product $productId: $e');
      rethrow;
    }
  }


//! ============================================================================ //
//? ================= ✈️ SUPPLIER RELATED API calls ✈️ ===================== //
//! ============================================================================ //


    Future<List<Supplier>> fetchSuppliers() async {
    try {
      final response = await _httpClient.get('/supplier/getAll'); // or whatever your route is

      final suppliersJson = response.data['suppliers'] as List<dynamic>;

      return suppliersJson.map((json) => Supplier.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      logger.f('Fetching all suppliers failed with this error: $e');
      rethrow;
    }
  }

//! ============================================================================ //
//? ================= ✈️ BRAND RELATED API calls ✈️ ===================== //
//! ============================================================================ //

  Future<List<Brand>> fetchBrands() async {
    try {
      final response = await _httpClient.get('/brand/getAll'); // or whatever your route is

      final brandJson = response.data['brands'] as List<dynamic>;

      return brandJson.map((json) => Brand.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      logger.f('Fetching all brands failed with this error: $e');
      rethrow;
    }
  }


  //? below method is not working yet
  // Future<Product> fetchProduct(int id) async {
  //   final response = await _httpClient.get('/products/$id');

  //   return Product.fromJson(response.data as _ResponseData);
  // }
}
