import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response_dto.dart';
import 'http_client.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8081';
  final http.Client _client = HttpClientService.getClient();
  
  Future<LoginResponseDto> login(String username, String password) async {
    try {
      final url = Uri.http('localhost:8081', '/api/account/login');
      
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return LoginResponseDto(
          success: data['success'] ?? true,
          message: data['message'] ?? 'Login successful',
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'],
          user: data['user'],
        );
      } else {
        return LoginResponseDto(
          success: false,
          message: data['message'] ?? 'Login failed',
          accessToken: null,
          refreshToken: null,
          user: null,
        );
      }
    } catch (e) {
      print('Login error: $e');
      return LoginResponseDto(
        success: false,
        message: 'Network error: Unable to connect to server',
        accessToken: null,
        refreshToken: null,
        user: null,
      );
    }
  }
}