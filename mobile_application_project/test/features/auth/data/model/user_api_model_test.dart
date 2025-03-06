import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/auth/data/model/user_api_model.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

void main() {
  group('UserApiModel', () {
    final userJson = {
      '_id': '123',
      'name': 'John Doe',
      'username': 'johndoe',
      'email': 'johndoe@example.com',
      'password': 'password123',
      'profilePic': 'https://example.com/profile.jpg',
      'followers': ['user1', 'user2'],
      'following': ['user3', 'user4'],
      'bio': 'This is a bio',
      'isFrozen': false,
    };

    const userModel = UserApiModel(
      id: '123',
      name: 'John Doe',
      username: 'johndoe',
      email: 'johndoe@example.com',
      password: 'password123',
      profilePic: 'https://example.com/profile.jpg',
      followers: ['user1', 'user2'],
      following: ['user3', 'user4'],
      bio: 'This is a bio',
      isFrozen: false,
    );

    test('should convert from JSON correctly', () {
      final result = UserApiModel.fromJson(userJson);
      expect(result, equals(userModel));
    });

    test('should convert to JSON correctly', () {
      final result = userModel.toJson();
      expect(result, equals(userJson));
    });

    test('should convert to entity correctly', () {
      final entity = userModel.toEntity();
      expect(entity, isA<UserEntity>());
      expect(entity.userId, equals(userModel.id));
      expect(entity.name, equals(userModel.name));
      expect(entity.username, equals(userModel.username));
      expect(entity.email, equals(userModel.email));
      expect(entity.password, equals(userModel.password));
      expect(entity.profilePic, equals(userModel.profilePic));
      expect(entity.followers, equals(userModel.followers));
      expect(entity.following, equals(userModel.following));
      expect(entity.bio, equals(userModel.bio));
      expect(entity.isFrozen, equals(userModel.isFrozen));
    });

    test('should create from entity correctly', () {
      final entity = userModel.toEntity();
      final result = UserApiModel.fromEntity(entity);
      expect(result, equals(userModel));
    });
  });
}
