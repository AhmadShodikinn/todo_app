import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> request({
    required String endpoint,
    String method = 'GET',
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    http.Response response;

    headers ??= {'Content-Type': 'application/json'};

    try {
      switch (method.toUpperCase()) {
        case 'POST':
          response = await client
              .post(uri, headers: headers, body: json.encode(body))
              .timeout(const Duration(seconds: 10));
          break;
        case 'PUT':
          response = await client
              .put(uri, headers: headers, body: json.encode(body))
              .timeout(const Duration(seconds: 10));
          break;
        case 'DELETE':
          response = await client
              .delete(uri, headers: headers)
              .timeout(const Duration(seconds: 10));
          break;
        case 'GET':
        default:
          response = await client
              .get(uri, headers: headers)
              .timeout(const Duration(seconds: 10));
      }

      print('Request: $method $uri');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return null;
        }
      } else {
        throw ApiException(response.statusCode, response.body);
      }
    } catch (e) {
      throw ApiException(-1, e.toString());
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'ApiException: HTTP $statusCode - $message';
  }
}
