import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerTeam(AuthEntity team);

  Future<Either<Failure, String>> loginTeam(String teamName, String password);

  Future<Either<Failure, AuthEntity>> getCurrentTeam();

  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
