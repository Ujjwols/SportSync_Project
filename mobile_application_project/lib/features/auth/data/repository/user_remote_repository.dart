import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class UserRemoteRepository implements IUserRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  UserRemoteRepository(this._authRemoteDataSource);

  @override
  Future<String?> uploadImage(String imagePath) async {
    return await _authRemoteDataSource.uploadImage(imagePath);
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString())); // Corrected the typo here
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUsers() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> loginUser(
      String username, String password) async {
    try {
      final result = await _authRemoteDataSource.loginUser(username, password);
      return Right(result); // Return the entire Map
    } catch (e) {
      return Left(ApiFailure(message: e.toString())); // Corrected the typo here
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({
    required String userId,
    required String name,
    required String email,
    required String username,
    required String bio,
    String? profilePic,
    String? password,
  }) async {
    try {
      // Call the data source to update the profile
      final result = await _authRemoteDataSource.updateProfile(
        userId: userId,
        name: name,
        email: email,
        username: username,
        bio: bio,
        profilePic: profilePic,
        password: password,
      );

      // Handle the result
      return result.fold(
        (failure) => Left(failure), // Propagate the failure
        (userApiModel) =>
            Right(userApiModel.toEntity()), // Convert to UserEntity
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
