import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/app/usecase/usecase.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase
    implements UsecaseWithParams<Map<String, dynamic>, LoginParams> {
  final IUserRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(LoginParams params) async {
    final result = await repository.loginUser(params.username, params.password);
    return result.fold(
      (failure) => Left(failure),
      (data) async {
        final token = data['token']; // Extract the token from the Map
        final saveResult = await tokenSharedPrefs.saveToken(token);
        if (saveResult.isLeft()) {
          return Left(saveResult.fold(
              (failure) => failure,
              (_) =>
                  const SharedPrefsFailure(message: "Failed to save token")));
        }

        // Ensure that the token is retrieved correctly after saving
        final tokenResult = await tokenSharedPrefs.getToken();
        return tokenResult.fold((failure) => Left(failure),
            (savedToken) => Right(data)); // Return the entire Map
      },
    );
  }
}
