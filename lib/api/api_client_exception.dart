import 'package:dio/dio.dart';


extension ApiClientExceptionX on DioException {
  String? get dioResponseMessage {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['message'] as String?;
    }
    return null;
  }

  String? get responseDetails {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['details'] as String?;
    }
    return null;
  }
}
