import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class RegisterTeamParams extends Equatable {
  final String teamname;
  final String email;
  final String password;
  final String confirmpassword;

  const RegisterTeamParams(
      {required this.teamname,
      required this.email,
      required this.password,
      required this.confirmpassword});

  //intial constructor
  const RegisterTeamParams.initial(
      {required this.teamname,
      required this.email,
      required this.password,
      required this.confirmpassword});

  @override
  List<Object?> get props => [teamname, email, password, confirmpassword];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterTeamParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterTeamParams params) {
    final authEntity = AuthEntity(
      teamName: params.teamname,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmpassword,
    );
    return repository.registerTeam(authEntity);
  }
}
