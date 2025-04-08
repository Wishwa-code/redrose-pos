import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';
// import 'mock/mocked_api_client.dart';
import 'storage/secure_storage.dart';

part 'api_client_service.g.dart';

/// An API service that handles authentication and exposes an [ApiClient].
///
/// Every API call coming from UI should watch/read this provider instead of
/// instantiating the [ApiClient] itself. When being watched, it will force any
/// data provider (provider that fetches data) to refetch when the
/// authentication state changes.
///
/// The API client is kept alive to follow dio's recommendation to use the same
/// client instance for the entire app.
@riverpod
Future<ApiClient> apiService(Ref ref) async {
  final token = await ref.watch(tokenProvider.future);

  const mock = bool.fromEnvironment('MOCK_API');
  final client = switch (mock) {
    true => token != null ? ApiClient.withToken(token) : ApiClient(),
    false => token != null ? ApiClient.withToken(token) : ApiClient(),
  };
  return client;
}

@riverpod
Future<String?> token(Ref ref) async {
  final secureStorage = await ref.watch(secureStorageProvider.future);
  return secureStorage.get('token');
}
