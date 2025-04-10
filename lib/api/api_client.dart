import 'dart:io';

import 'package:dio/dio.dart';

import '../features/inventory/models/product.dart';

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

/// An API client that makes network requests.
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

  // Future<SupabaseUploadResponse> uploadImage(File imageFile) async {

    

  //   final data = response.data['data'] as Map<String, dynamic>;
  //   return SupabaseUploadResponse.fromJson(data);
  // }

  Future<Product> addProduct(Product product, File imageFile) async {
    final fileName = imageFile.path.split('/').last;


    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
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

    print('Upload Response: $imgresponse');

    final response = await _httpClient.post(
      '/products',
      data: product.toJson(), // Assuming your Product model has a `toJson()` method
    );

    print('Response: $response');

    // Parse the response JSON
    final productData = response.data['product'] as Map<String, dynamic>;

    return Product.fromJson(productData);
  }

  Future<Product> fetchProduct(int id) async {
    final response = await _httpClient.get('/products/$id');

    return Product.fromJson(response.data as _ResponseData);
  }
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
