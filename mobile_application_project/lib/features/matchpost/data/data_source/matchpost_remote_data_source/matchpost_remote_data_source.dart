import 'package:cloudinary/cloudinary.dart'; // Use the cloudinary package
import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/app/constants/api_endpoints.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/matchpost/data/data_source/matchpost_data_source.dart';
import 'package:mobile_application_project/features/matchpost/data/model/matchpost_api_model.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

class MatchpostRemoteDataSource implements IMatchPostDataSource {
  final Dio dio;
  final Cloudinary cloudinary;
  final TokenSharedPrefs
      tokenSharedPrefs; // Use Cloudinary from the cloudinary package

  MatchpostRemoteDataSource(
      {required this.dio,
      required this.cloudinary,
      required this.tokenSharedPrefs});

  /// Uploads an image to Cloudinary and returns the secure URL.
  @override
  Future<String?> uploadImage(String imagePath) async {
    try {
      final response = await cloudinary.upload(
        file: imagePath,
        resourceType:
            CloudinaryResourceType.image, // Use CloudinaryResourceType
      );
      return response.secureUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Failure, bool>> createMatchPost(
      MatchPostEntity matchpost) async {
    try {
      // Retrieve the token
      final tokenResult = await tokenSharedPrefs.getToken();
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

      // Retrieve the user details
      final userDetailsResult = await tokenSharedPrefs.getUserDetails();
      final userDetails = userDetailsResult.fold(
        (failure) {
          print('Error retrieving user details: ${failure.message}');
          throw Exception('Failed to get user details: ${failure.message}');
        },
        (userDetails) {
          print('Retrieved user details: $userDetails'); // Debugging
          return userDetails;
        },
      );

      // Extract the userId from user details
      final userId = userDetails['_id'];
      if (userId == null) {
        return const Left(
            ApiFailure(message: 'User ID not found in user details'));
      }

      // Debug: Print the userId to verify it's being retrieved correctly
      print('Retrieved userId: $userId');

      // Upload image to Cloudinary if provided
      String? imageUrl;
      if (matchpost.img != null) {
        imageUrl = await uploadImage(matchpost.img!);
        if (imageUrl == null) {
          return const Left(
              ApiFailure(message: 'Failed to upload image to Cloudinary'));
        }
      }

      // Create the post with the uploaded image URL and userId
      final response = await dio.post(
        ApiEndpoints.createMatchPost,
        data: {
          "postedBy": userId, // Use the userId from user details
          "text": matchpost.text,
          "img": imageUrl,
          "teamName": matchpost.teamName,
          "location": matchpost.location,
          "date": matchpost.date,
          "time": matchpost.time,
          "gameType": matchpost.gameType,
          "payment": matchpost.payment,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer $token', // Ensure token is correctly formatted
            'Content-Type': 'application/json', // Add the token to the headers
          },
        ),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(ApiFailure(
            message: 'Failed to create post: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'Failed to create post: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMatchPost(String matchpostId) async {
    try {
      // Retrieve the token properly using fold
      final tokenResult = await tokenSharedPrefs.getToken();
      final token = tokenResult.fold(
        (failure) {
          print('Error retrieving token: ${failure.message}');
          return null;
        },
        (token) {
          print('Retrieved token: $token'); // Debugging
          return token;
        },
      );

      if (token == null || token.trim().isEmpty) {
        return const Left(
            ApiFailure(message: 'Authentication token is missing.'));
      }

      // Send request with Authorization header
      final response = await dio.delete(
        '${ApiEndpoints.deleteMatchPost}/$matchpostId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true); // Successfully deleted post
      } else {
        return Left(ApiFailure(
            message: 'Failed to delete post: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'Failed to delete post: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MatchPostEntity>>> getMatchFeed() async {
    try {
      // Retrieve the token properly using fold
      final tokenResult = await tokenSharedPrefs.getToken();
      final token = tokenResult.fold(
        (failure) {
          print('Error retrieving token: ${failure.message}');
          return null;
        },
        (token) {
          print('Retrieved token: $token'); // Debugging
          return token;
        },
      );

      if (token == null || token.trim().isEmpty) {
        return const Left(
            ApiFailure(message: 'Authentication token is missing.'));
      }

      // Send request with Authorization header
      final response = await dio.get(
        ApiEndpoints.getMatchFeed,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final matchposts = (response.data as List)
            .map(
                (matchpost) => MatchPostApiModel.fromJson(matchpost).toEntity())
            .toList();
        return Right(matchposts);
      } else {
        return Left(ApiFailure(
            message: 'Failed to fetch feed posts: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(
          ApiFailure(message: 'Failed to fetch feed posts: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, MatchPostEntity>> getMatchPostById(
      String matchpostId) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.getMatchPostById}/$matchpostId');

      if (response.statusCode == 200) {
        final matchpost = MatchPostApiModel.fromJson(response.data).toEntity();
        return Right(matchpost);
      } else {
        return Left(ApiFailure(
            message: 'Failed to fetch post: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'Failed to fetch post: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MatchPostEntity>>> getUserMatchPost(
      String username) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.getUserMatchPost}/$username');

      if (response.statusCode == 200) {
        final matchposts = (response.data as List)
            .map((post) => MatchPostApiModel.fromJson(post).toEntity())
            .toList();
        return Right(matchposts);
      } else {
        return Left(ApiFailure(
            message: 'Failed to fetch user posts: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(
          ApiFailure(message: 'Failed to fetch user posts: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
