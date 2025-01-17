import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String teamName;
  final String password;

  const LoginParams({
    required this.teamName,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : teamName = '',
        password = '';

  @override
  List<Object> get props => [teamName, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginTeam(params.teamName, params.password);
  }
}
