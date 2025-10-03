import 'dart:convert';
import 'package:http/http.dart' as http;

import '../errors/exception.dart';

class ApiClient {
  final String baseUrl;
  final http.Client httpClient;

  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint')
          .replace(queryParameters: queryParams);
      final response =
          await httpClient.get(uri, headers: _defaultHeaders(headers));

      return _handleResponse(response);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  Map<String, String> _defaultHeaders(Map<String, String>? custom) {
    return {
      'Content-Type': 'application/json',
      ...?custom,
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      throw ServerException(
        message: response.body.isNotEmpty ? response.body : "Unknown server error",
        statusCode: statusCode,
      );
    }
  }
}