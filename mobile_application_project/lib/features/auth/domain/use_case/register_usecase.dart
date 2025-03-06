import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String username;
  final String email;
  final String password;

  const RegisterUserParams({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, username, email, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      name: params.name,
      username: params.username,
      email: params.email,
      password: params.password,
    );
    return repository.registerUser(userEntity);
  }
}
