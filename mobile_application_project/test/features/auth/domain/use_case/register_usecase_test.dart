import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/register_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockAuthRepository);

    // Register the fallback method in the mock.
    registerFallbackValue(const AuthEntity(
      teamName: 'Team A',
      email: 'team@example.com',
      image: null,
      password: 'password123',
      confirmPassword: 'password123',
    ));
  });

  const tRegisterTeamParams = RegisterTeamParams(
    teamname: 'Team A',
    email: 'team@example.com',
    image: null,
    password: 'password123',
    confirmpassword: 'password123',
  );

  const tAuthEntity = AuthEntity(
    teamName: 'Team A',
    email: 'team@example.com',
    image: null,
    password: 'password123',
    confirmPassword: 'password123',
  );

  group('RegisterUseCase', () {
    test('should return Failure if the parameters are invalid', () async {
      // Arrange
      const invalidParams = RegisterTeamParams(
        teamname: '',
        email: '',
        image: null,
        password: '',
        confirmpassword: '',
      );

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result, const Left(ApiFailure(message: 'Invalid parameters')));
    });

    test('should return Failure if passwords do not match', () async {
      // Arrange
      const invalidParams = RegisterTeamParams(
        teamname: 'Team A',
        email: 'team@example.com',
        image: null,
        password: 'password123',
        confirmpassword: 'password3232',
      );

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result, const Left(ApiFailure(message: 'Passwords do not match')));
    });

    test('should return ApiFailure if email format is invalid', () async {
      // Arrange
      const invalidParams = RegisterTeamParams(
        teamname: 'Team A',
        email: 'email',
        image: null,
        password: 'password123',
        confirmpassword: 'password123',
      );

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result, const Left(ApiFailure(message: 'Invalid email format')));
    });

    test('should return success when valid params are passed', () async {
      // Arrange
      when(() => mockAuthRepository.registerTeam(any())).thenAnswer(
        (_) async => const Right(null),
      );

      // Act
      final result = await useCase(tRegisterTeamParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.registerTeam(tAuthEntity)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(() => mockAuthRepository.registerTeam(any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Failed to register team')),
      );

      // Act
      final result = await useCase(tRegisterTeamParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: 'Failed to register team')));
    });
  });
}
