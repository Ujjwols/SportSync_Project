class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  static const Duration connectionTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  //===============================AuthRoutes===============================//

  static const String login = "auth/login";
  static const String register = "auth/register";
  // static const String refreshToken = "auth/refresh_token";
  static const String uploadImage = "auth/uploadImage";
}
