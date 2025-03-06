// import 'package:dartz/dartz.dart';
// import 'package:mobile_application_project/core/error/failure.dart';
// import 'package:mobile_application_project/features/auth/data/data_source/auth_local_data_source/auth_local_data_source.dart';
// import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';
// import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';

// class AuthLocalRepository implements IUserRepository {
//   final AuthLocalDataSource _authLocalDataSource;

//   AuthLocalRepository(this._authLocalDataSource);

//   @override
//   Future<Either<Failure, UserEntity>> getUsers() async {
//     try {
//       final currentUser = await _authLocalDataSource.getUsers();
//       return Right(currentUser);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> loginUser(
//     String username,
//     String password,
//   ) async {
//     try {
//       final token = await _authLocalDataSource.loginUser(username, password);
//       return Right(token);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registerUser(UserEntity user) async {
//     try {
//       return Right(_authLocalDataSource.registerUser(user));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }
// }
