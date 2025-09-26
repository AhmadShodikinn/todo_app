import 'package:http/http.dart' as http;
import 'dart:convert';

// digunakan sebagai media komunikasi antara aplikasi dengan server
class ApiClient {
  final String _baseUrl =
      'https://jsonplaceholder.typicode.com'; // kalau semisal mau ganti url sistem tinggal ganti di sini.
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  // cara pakainya tinggal panggil method request, terus kasih endpoint, method, headers, body kalau perlu
  Future<dynamic> request({
    required String endpoint,
    String method = 'GET',
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl$endpoint',
    ); // uri ini dibuat dinamis ya, ntar digunakan sama method dibawah
    http.Response response;

    headers ??= {'Content-Type': 'application/json'};

    // pakai try catch buat jaga jaga kalau misal ada error dari server atau masalah jaringan
    // penggunaan switch case buat proyek kecil, kalau besar bisa dipertimbangkan pakai cara lain (package dio, atau retrofit.dart)
    try {
      switch (method.toUpperCase()) {
        case 'POST':
          response = await client
              .post(uri, headers: headers, body: json.encode(body))
              .timeout(
                const Duration(seconds: 10),
              ); // duration ini digunakan kalau semisal server respon lagi lama, biar ga terlalu lama nunggu, minusnya timeout aja
          break;
        case 'PUT':
          response = await client
              .put(uri, headers: headers, body: json.encode(body))
              .timeout(
                const Duration(seconds: 10),
              ); // bisa disesuaikan sesuai kebutuhan
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

      // jaga jaga kalau mau logging, apa yang dikirim dan diterima sama server
      // print('Request: $method $uri');
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

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

// buat handling status code dari server, sekalian message nya, kalau semisal pas ada error langsung ngerti tracknya
class ApiException implements Exception {
  final int statusCode;
  final String message; // message ini biasanya isi dari response body

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'ApiException: HTTP $statusCode - $message';
  }
}
