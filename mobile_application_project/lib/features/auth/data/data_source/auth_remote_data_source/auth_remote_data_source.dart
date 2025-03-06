import 'package:cloudinary/cloudinary.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/app/constants/api_endpoints.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
import 'package:mobile_application_project/features/auth/data/model/user_api_model.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;
  final Cloudinary _cloudinary;

  AuthRemoteDataSource(this._dio, this._tokenSharedPrefs, this._cloudinary);

  @override
  Future<String?> uploadImage(String imagePath) async {
    try {
      final response = await _cloudinary.upload(
        file: imagePath,
        resourceType: CloudinaryResourceType.image,
      );
      return response.secureUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.signup,
        data: {
          "name": user.name,
          "username": user.username,
          "email": user.email,
          "password": user.password,
        },
      );

      if (response.statusCode == 201) {
        // Registration successful
        print('User registered: ${response.data}');
        return;
      } else {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> getUsers() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // Extract user details from the response body
        final responseData = response.data; // Assuming the response is JSON
        final userDetails = {
          '_id': responseData['_id'], // User ID for creating posts
          'name': responseData['name'],
          'email': responseData['email'],
          'username': responseData['username'],
          'bio': responseData['bio'],
          'profilePic': responseData['profilePic'],
        };

        // Extract the JWT token from the Set-Cookie header
        final cookies = response.headers['set-cookie'];
        if (cookies != null) {
          for (var cookie in cookies) {
            if (cookie.contains('jwt=')) {
              final jwtToken = cookie.split('jwt=')[1].split(';')[0];

              // Save token and user details to TokenSharedPrefs
              await _tokenSharedPrefs.saveToken(jwtToken);
              await _tokenSharedPrefs.saveUserDetails(userDetails);

              print('Token saved: $jwtToken'); // Debugging
              print('User details saved: $userDetails'); // Debugging

              return {
                'token': jwtToken, // JWT token for authentication
                'user': userDetails, // User details including userId
              };
            }
          }
        }
        throw Exception('JWT token not found in response headers');
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Either<Failure, UserApiModel>> updateProfile({
    required String userId,
    required String name,
    required String email,
    required String username,
    required String bio,
    String? profilePic,
    String? password,
  }) async {
    try {
      // Retrieve the token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold(
        (failure) {
          print('Error retrieving token: ${failure.message}');
          throw Exception('Failed to get token: ${failure.message}');
        },
        (token) {
          print('Retrieved token: $token'); // Debugging
          return token;
        },
      );

      // Upload profile picture to Cloudinary if provided
      String? imageUrl;
      if (profilePic != null) {
        imageUrl = await uploadImage(profilePic);
      }

      // Map the UserEntity to UserApiModel
      final userApiModel = UserApiModel(
        id: userId,
        name: name,
        email: email,
        username: username,
        bio: bio,
        profilePic: imageUrl,
        password: password ?? '',
      );

      // Send the data to the backend with the token in the headers
      final response = await _dio.put(
        '${ApiEndpoints.update}/$userId',
        data: userApiModel.toJson(), // Convert to JSON before sending
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Add the token in the Authorization header
            'Content-Type':
                'application/json', // Ensure the content type is set
          },
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Convert the response data to UserApiModel
        final updatedUser = UserApiModel.fromJson(response.data);
        return Right(updatedUser);
      } else {
        // Handle non-successful response
        return Left(ApiFailure(
            message: 'Failed to update profile: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues, timeouts)
      return Left(ApiFailure(message: 'Network error: ${e.message}'));
    } catch (e) {
      // Handle other unexpected errors
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }
}
