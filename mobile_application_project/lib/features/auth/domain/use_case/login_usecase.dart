import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/app/usecase/usecase.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String teamname;
  final String password;

  const LoginParams({
    required this.teamname,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : teamname = '',
        password = '';

  @override
  List<Object> get props => [teamname, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await repository.loginTeam(params.teamname, params.password);
    return result.fold(
      (failure) => Left(failure),
      (token) async {
        final saveResult = await tokenSharedPrefs.saveToken(token);
        if (saveResult.isLeft()) {
          return Left(saveResult.fold(
              (failure) => failure,
              (_) =>
                  const SharedPrefsFailure(message: "Failed to save token")));
        }

        // Ensure that the token is retrieved correctly after saving
        final tokenResult = await tokenSharedPrefs.getToken();
        return tokenResult.fold(
            (failure) => Left(failure), (savedToken) => Right(savedToken));
      },
    );
  }
}
