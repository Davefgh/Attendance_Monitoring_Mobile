// lib/utils/constants.dart
class ApiConstants {
  // Change this to your actual backend IP/port
  // For physical device: use your computer's IP (e.g., 192.168.254.106)
  // For Android emulator: use 10.0.2.2
  // For iOS simulator: use localhost or your computer's IP
  
  static const String baseUrl = 'http://localhost:8080';
  // static const String baseUrl = 'http://10.0.2.2:8881'; // Android emulator
  // static const String baseUrl = 'http://localhost:8881'; // Web only
  
  static const String loginEndpoint = '/api/account/login';
  static const String registerEndpoint = '/api/account/register';
  static const String refreshEndpoint = '/api/account/refresh';
  static const String logoutEndpoint = '/api/account/logout';
}