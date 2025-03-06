import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, UserEntity>> getUsers();
  Future<Either<Failure, void>> registerUser(UserEntity user);
  Future<Either<Failure, Map<String, dynamic>>> loginUser(
      String username, String password);
  Future<Either<Failure, UserEntity>> updateUser({
    required String userId,
    required String name,
    required String email,
    required String username,
    required String bio,
    String? profilePic,
    String? password,
  });
  Future<String?> uploadImage(String imagePath);
}
