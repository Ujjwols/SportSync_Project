class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  static const Duration connectionTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // static const String baseUrl = "http://10.1.20.184:5000/api/";

  //===============================AuthRoutes===============================//

  static const String login = "users/login";
  static const String signup = "users/signup";
  static const String update = "users/update/";
  static const String suggested = "users/suggested";
  static const String follow = "users/follow/";

  // static const String refreshToken = "auth/refresh_token";
  // static const String uploadImage = "auth/uploadImage";

//==============================postroutes==============================//
  static const String getfeed = "posts/feed";
  static const String getpostbyid = "posts/";
  static const String getuserpost = "posts/user/";
  static const String createpost = "posts/create";
  static const String deletepost = "posts/";
  static const String likepost = "posts/like/";
  static const String replypost = "posts/reply/";

  //==============================MatchPostRoutes==============================//
  static const String getMatchFeed = "matchpost/matchfeed";
  static const String getMatchPostById = "matchpost/";
  static const String getUserMatchPost = "matchpost/user/";
  static const String createMatchPost = "matchpost/create";
  static const String deleteMatchPost = "matchpost/";
}
