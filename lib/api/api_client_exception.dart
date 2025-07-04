import 'package:dio/dio.dart';

extension ApiClientExceptionX on DioException {
  // Access nested message inside `error` object
  String? get dioResponseMessage {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['message'] as String?;
    }
    return null;
  }

  // Access nested `details` from `error` object
  String? get responseDetails {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['details'] as String?;
    }
    return null;
  }

  String? get serverErrorCode {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['code'] as String?;
    }
    return null;
  }

  String? get operationStatus {
    final data = response?.data;
    if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
      return data['error']['success'] as String?;
    }
    return null;
  }

  // Access plain top-level `message`
  String? get responseMessage => response?.data?['message'] as String?;

  /// HTTP status code
  int? get statusCode => response?.statusCode;

  /// HTTP method used in the request
  String get method => requestOptions.method;

  /// Request path/endpoint
  String get path => requestOptions.path;

  /// Request headers
  Map<String, dynamic> get requestHeaders => requestOptions.headers;

  /// Request payload (body)
  dynamic get requestBody => requestOptions.data;

  /// Response headers
  Headers? get responseHeaders => response?.headers;

  /// Raw response data
  dynamic get responseBody => response?.data;

  /// DioException type (timeout, badResponse, etc.)
  DioExceptionType get exceptionType => type;

  /// Raw error object (usually from network layer)
  Object? get rawError => error;

  /// Stack trace (if available)
  StackTrace? get trace => stackTrace;

  /// Formatted summary for UI display (e.g., SnackBar)
  String get formattedMessage {
    final buffer = StringBuffer();
    buffer.writeln('$exceptionType');
    buffer.writeln(' We got problems homy.');
    buffer.writeln('\n⛔ Status Code: $exceptionType');
    buffer.writeln('⛔ Status Msg: ${response?.statusMessage}');
    buffer.writeln('\n ⛔ Dio Message: $message');
    if (operationStatus != null) {
      buffer.writeln('⛔ Operation Status: $operationStatus');
    }
    if (serverErrorCode != null) {
      buffer.writeln('⛔ Server Error Code: $serverErrorCode');
    }
    if (responseDetails != null) {
      buffer.writeln('⛔ Server Error Details: $responseDetails');
    }
    if (dioResponseMessage != null) {
      buffer.writeln('⛔ Server Error Message: $dioResponseMessage');
    }
    if (responseDetails == null) {
      buffer.writeln('⛔ Response Body: $responseBody');
    }
    buffer.writeln('More details are provided in the developer debugDump 🫡');
    return buffer.toString();
  }

  /// Optional: developer-only full debug info
  String get debugDump {
    return '''
⛔ DioException Debug Dump
────────────────────────────────────────────
• Type:          $exceptionType
• Status Code:   $statusCode
• Status Msg:    ${response?.statusMessage}
• Message:       $message
• Raw Error:     $rawError
• Method:        $method
• Path:          $path
• Request Body:  $requestBody
• Response Body: $responseBody
• Stack Trace:   $trace
────────────────────────────────────────────
''';
  }

}