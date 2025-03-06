import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class UpdateProfileParams extends Equatable {
  final String name;
  final String email;
  final String username;
  final String bio;
  final String? profilePic;
  final String? password;

  const UpdateProfileParams({
    required this.name,
    required this.email,
    required this.username,
    required this.bio,
    this.profilePic,
    this.password,
  });

  @override
  List<Object?> get props => [name, email, username, bio, profilePic, password];
}

class UpdateProfileUseCase
    implements UsecaseWithParams<UserEntity, UpdateProfileParams> {
  final IUserRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateProfileUseCase({
    required this.repository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) async {
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

      // Upload profile picture to Cloudinary if provided
      String? imageUrl;
      if (params.profilePic != null) {
        imageUrl = await repository.uploadImage(params.profilePic!);
        if (imageUrl == null) {
          return const Left(ApiFailure(
              message: 'Failed to upload profile picture to Cloudinary'));
        }
      }

      // Call the repository to update the profile
      return await repository.updateUser(
        userId: userId,
        name: params.name,
        email: params.email,
        username: params.username,
        bio: params.bio,
        profilePic: imageUrl,
        password: params.password,
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
