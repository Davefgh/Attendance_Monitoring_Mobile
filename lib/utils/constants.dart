// lib/utils/constants.dart
class ApiConstants {
  // Change this to your actual backend IP/port
  // For physical device: use your computer's IP (e.g., 192.168.254.106)
  // For Android emulator: use 10.0.2.2
  // For iOS simulator: use localhost or your computer's IP
  
  static const String baseUrl = 'http://localhost:8080';
  // static const String baseUrl = 'http://10.0.2.2:8080'; // Android emulator
  // static const String baseUrl = 'http://192.168.x.x:8080'; // Physical device
  
  // Auth endpoints
  static const String loginEndpoint = '/api/account/login';
  static const String registerEndpoint = '/api/account/register';
  static const String refreshEndpoint = '/api/account/refresh';
  static const String logoutEndpoint = '/api/account/logout';
  
  // Section endpoints
  static const String sectionsEndpoint = '/api/sections';
  static String sectionDetailsEndpoint(int id) => '/api/sections/$id';
  static String sectionStudentsEndpoint(int id) => '/api/sections/$id/active-students';
  
  // Student endpoints
  static const String studentsEndpoint = '/api/students';
  static String studentDetailsEndpoint(int id) => '/api/students/$id';
  
  // Instructor endpoints
  static const String instructorsEndpoint = '/api/instructors';
  static String instructorDetailsEndpoint(int id) => '/api/instructors/$id';
  
  // Subject endpoints
  static const String subjectsEndpoint = '/api/subjects';
  static String subjectDetailsEndpoint(int id) => '/api/subjects/$id';
  
  // Timeout durations
  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}