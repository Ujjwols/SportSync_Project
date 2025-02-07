import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class RegisterTeamParams extends Equatable {
  final String teamname;
  final String email;
  final String? image;
  final String password;
  final String confirmpassword;

  const RegisterTeamParams(
      {required this.teamname,
      required this.email,
      this.image,
      required this.password,
      required this.confirmpassword});

  //intial constructor
  const RegisterTeamParams.initial(
      {required this.teamname,
      required this.email,
      this.image,
      required this.password,
      required this.confirmpassword});

  @override
  List<Object?> get props =>
      [teamname, email, image, password, confirmpassword];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterTeamParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterTeamParams params) async {
    // Validation logic:
    if (params.teamname.isEmpty ||
        params.email.isEmpty ||
        params.password.isEmpty ||
        params.confirmpassword.isEmpty) {
      return const Left(ApiFailure(message: 'Invalid parameters'));
    }

    if (params.password != params.confirmpassword) {
      return const Left(ApiFailure(message: 'Passwords do not match'));
    }

    // Simple email validation (basic)
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(params.email)) {
      return const Left(ApiFailure(message: 'Invalid email format'));
    }

    // Proceed to create the AuthEntity
    final authEntity = AuthEntity(
      teamName: params.teamname,
      email: params.email,
      image: params.image,
      password: params.password,
      confirmPassword: params.confirmpassword,
    );

    // Call the repository
    return repository.registerTeam(authEntity);
  }
}
