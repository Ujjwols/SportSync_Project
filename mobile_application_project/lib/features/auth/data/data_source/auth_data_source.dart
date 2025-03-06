import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/data/model/user_api_model.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

abstract interface class IAuthDataSource {
  Future<Map<String, dynamic>> loginUser(String username, String password);

  Future<void> registerUser(UserEntity team);
  Future<String?> uploadImage(String imagePath);

  Future<Either<Failure, UserApiModel>> updateProfile({
    required String userId,
    required String name,
    required String email,
    required String username,
    required String bio,
    String? profilePic,
    String? password,
  });
}
