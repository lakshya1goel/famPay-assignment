import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../errors/exception.dart';

class ApiClient {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: _defaultHeaders(headers));
      return _handleResponse(response);
    } catch (e) {
      throw UnknownException(message: 'Failed to get data: ${e.toString()}');
    }
  }

  Map<String, String> _defaultHeaders(Map<String, String>? custom) {
    return {
      'Content-Type': 'application/json',
      ...?custom,
    };
  }

  List<dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      throw ServerException(
        message: response.body.isNotEmpty ? response.body : "Unknown server error: ${response.statusCode}",
        statusCode: statusCode,
      );
    }
  }
}