import 'package:dio/dio.dart';

import '../entities/product.dart';

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
