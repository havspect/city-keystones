import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiRepository extends http.BaseClient {
  late String apiKey;
  String baseUrl = 'http://localhost:8000/api';
  final http.Client _httpClient = http.Client();

  Future<String> login(String email, String password) async {

    var res = await _httpClient.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password, 'token_name': 'mobile'},
    );

    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception('Failed to login: ${res.body}');
    }
  }

  bool isAuthorized() {
    return apiKey.isNotEmpty;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] = 'Bearer $apiKey';
    return await _httpClient.send(request);
  }
}
