import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class CreatePostParams extends Equatable {
  final String postedBy;
  final String? text;
  final String? img;

  const CreatePostParams({
    required this.postedBy,
    this.text,
    this.img,
  });

  @override
  List<Object?> get props => [postedBy, text, img];
}

class CreatePostUseCase implements UsecaseWithParams<bool, CreatePostParams> {
  final IPostRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  CreatePostUseCase({required this.tokenSharedPrefs, required this.repository});

  @override
  Future<Either<Failure, bool>> call(CreatePostParams params) async {
    try {
      // Retrieve user details from TokenSharedPrefs
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
      if (userId == null || userId.isEmpty) {
        return const Left(
            ApiFailure(message: 'User ID not found in user details'));
      }

      // Debug: Print the userId to verify it's being retrieved correctly
      print('Retrieved userId: $userId');

      // Upload image to Cloudinary if provided
      String? imageUrl;
      if (params.img != null) {
        imageUrl = await repository.uploadImage(params.img!);
        if (imageUrl == null) {
          return const Left(
              ApiFailure(message: 'Failed to upload image to Cloudinary'));
        }
      }

      // Create the PostEntity
      final postEntity = PostEntity(
        postId: null,
        postedBy: userId, // Use the retrieved userId
        text: params.text,
        img: imageUrl,
        likes: const [],
        replies: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Pass the PostEntity to the repository
      return await repository.createPost(postEntity);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
