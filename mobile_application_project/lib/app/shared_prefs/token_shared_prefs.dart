import 'dart:convert'; // For jsonEncode and jsonDecode

import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  // Save token
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      print('Token saved: $token'); // Debugging
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve token
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      if (token == null || token.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'Token not found'));
      }
      return Right(token);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save user details
  Future<Either<Failure, void>> saveUserDetails(
      Map<String, dynamic> userDetails) async {
    try {
      await _sharedPreferences.setString(
          'userDetails', jsonEncode(userDetails));
      print('User details saved: $userDetails'); // Debugging
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user details
  Future<Either<Failure, Map<String, dynamic>>> getUserDetails() async {
    try {
      final userDetailsJson = _sharedPreferences.getString('userDetails');
      if (userDetailsJson == null || userDetailsJson.isEmpty) {
        return const Left(
            SharedPrefsFailure(message: 'User details not found'));
      }
      final userDetails = jsonDecode(userDetailsJson) as Map<String, dynamic>;
      print('Retrieved user details: $userDetails'); // Debugging
      return Right(userDetails);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
