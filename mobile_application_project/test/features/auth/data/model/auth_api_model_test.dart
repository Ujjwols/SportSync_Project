import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/auth/data/model/auth_api_model.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      '_id': '123',
      'teamname': 'John Doe',
      'email': 'john@example.com',
      'image': 'profile.jpg',
      'password': 'password123',
      'confrimpassword': 'password123',
    };

    test('should convert from JSON correctly', () {
      final model = AuthApiModel.fromJson(json);

      expect(model.id, '123');
      expect(model.teamname, 'John Doe');
      expect(model.email, 'john@example.com');
      expect(model.image, 'profile.jpg');
      expect(model.password, 'password123');
      expect(model.confrimpassword, 'password123');
    });

    test('should convert to JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      final convertedJson = model.toJson();

      expect(convertedJson['_id'], '123');
      expect(convertedJson['teamname'], 'John Doe');
      expect(convertedJson['email'], 'john@example.com');
      expect(convertedJson['image'], 'profile.jpg');
      expect(convertedJson['password'], 'password123');
      expect(convertedJson['confrimpassword'], 'password123');
    });

    test('should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        teamId: '123',
        teamName: 'johndoe',
        email: 'john@example.com',
        image: 'profile.jpg',
        password: 'password123',
        confirmPassword: 'password123',
      );

      final model = AuthApiModel.fromEntity(entity);
      final convertedEntity = model.toEntity();

      expect(convertedEntity, equals(entity));
    });
  });
}
