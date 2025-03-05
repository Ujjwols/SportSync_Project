import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  final SharedPreferences _sharedPreferences;

  UserSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      if (userId == null || userId.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'User ID not found'));
      }
      return Right(userId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
