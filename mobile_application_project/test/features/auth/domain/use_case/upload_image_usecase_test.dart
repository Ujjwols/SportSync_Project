import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UploadImageUsecase useCase;
  late MockAuthRepository mockAuthRepository;

  // Register the fallback value for File class
  setUpAll(() {
    registerFallbackValue(File('dummy_path'));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = UploadImageUsecase(mockAuthRepository);
  });

  final tFile = File('dummy_path');
  const tSuccessMessage = 'Image uploaded successfully';

  group('UploadImageUsecase', () {
    test('should return Failure when upload fails', () async {
      // Arrange
      when(() => mockAuthRepository.uploadProfilePicture(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Upload failed')));

      // Act
      final result = await useCase(UploadImageParams(file: tFile));

      // Assert
      expect(result, const Left(ApiFailure(message: 'Upload failed')));
    });

    test('should return success message when upload is successful', () async {
      // Arrange
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => const Right(tSuccessMessage));

      // Act
      final result = await useCase(UploadImageParams(file: tFile));

      // Assert
      expect(result, const Right(tSuccessMessage));
    });
  });
}
