import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);

    // Registering fallback values for mocking AuthEntity and SharedPrefs
    registerFallbackValue(const LoginParams.initial());
  });

  const tLoginParams = LoginParams(
    teamname: 'Team A',
    password: 'password123',
  );

  const tToken = 'some_token';

  group('LoginUseCase', () {
    test('should return ApiFailure if login fails', () async {
      // Arrange
      when(() => mockAuthRepository.loginTeam(any(), any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Login failed')));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: 'Login failed')));
    });

    test('should return SharedPrefsFailure if saving token fails', () async {
      // Arrange
      when(() => mockAuthRepository.loginTeam(any(), any()))
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockTokenSharedPrefs.saveToken(any())).thenAnswer((_) async =>
          const Left(SharedPrefsFailure(message: 'Failed to save token')));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result,
          const Left(SharedPrefsFailure(message: 'Failed to save token')));
    });

    test('should return SharedPrefsFailure if getting token fails', () async {
      // Arrange
      when(() => mockAuthRepository.loginTeam(any(), any()))
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockTokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.getToken()).thenAnswer((_) async =>
          const Left(SharedPrefsFailure(message: 'Failed to get token')));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result,
          const Left(SharedPrefsFailure(message: 'Failed to get token')));
    });

    test('should return the token when login and saving succeed', () async {
      // Arrange
      when(() => mockAuthRepository.loginTeam(any(), any()))
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockTokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result, const Right(tToken));
    });
  });
}
