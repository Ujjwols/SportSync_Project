import 'package:cloudinary/cloudinary.dart'; // Use the cloudinary package
import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/app/constants/api_endpoints.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/post/data/data_source/post_data_source.dart';
import 'package:mobile_application_project/features/post/data/model/post_api_model.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';

class PostRemoteDataSource implements IPostDataSource {
  final Dio dio;
  final Cloudinary cloudinary;
  final TokenSharedPrefs
      tokenSharedPrefs; // Use Cloudinary from the cloudinary package

  PostRemoteDataSource(
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
  Future<Either<Failure, bool>> createPost(PostEntity post) async {
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
      if (post.img != null) {
        imageUrl = await uploadImage(post.img!);
        if (imageUrl == null) {
          return const Left(
              ApiFailure(message: 'Failed to upload image to Cloudinary'));
        }
      }

      // Create the post with the uploaded image URL and userId
      final response = await dio.post(
        ApiEndpoints.createpost,
        data: {
          "postedBy": userId, // Use the userId from user details
          "text": post.text,
          "img": imageUrl,
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
  Future<Either<Failure, bool>> deletePost(String postId) async {
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
        '${ApiEndpoints.deletepost}/$postId',
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
  Future<Either<Failure, List<PostEntity>>> getFeed() async {
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
        ApiEndpoints.getfeed,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final posts = (response.data as List)
            .map((post) => PostApiModel.fromJson(post).toEntity())
            .toList();
        return Right(posts);
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
  Future<Either<Failure, PostEntity>> getPostById(String postId) async {
    try {
      final response = await dio.get('${ApiEndpoints.getpostbyid}/$postId');

      if (response.statusCode == 200) {
        final post = PostApiModel.fromJson(response.data).toEntity();
        return Right(post);
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
  Future<Either<Failure, List<PostEntity>>> getUserPost(String username) async {
    try {
      final response = await dio.get('${ApiEndpoints.getuserpost}/$username');

      if (response.statusCode == 200) {
        final posts = (response.data as List)
            .map((post) => PostApiModel.fromJson(post).toEntity())
            .toList();
        return Right(posts);
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

  @override
  Future<Either<Failure, bool>> likeUnlikePost(String postId) async {
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
      final response = await dio.put(
        '${ApiEndpoints.likepost}/$postId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true); // Successfully liked/unliked post
      } else {
        return Left(ApiFailure(
            message: 'Failed to like/unlike post: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(
          ApiFailure(message: 'Failed to like/unlike post: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> replyToPost(String postId, String text) async {
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
      final response = await dio.put(
        '${ApiEndpoints.replypost}/$postId',
        data: {"text": text},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true); // Successfully replied to post
      } else {
        return Left(ApiFailure(
            message: 'Failed to reply to post: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'Failed to reply to post: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
