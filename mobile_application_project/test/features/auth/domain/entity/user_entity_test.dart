import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

void main() {
  group('UserEntity', () {
    // Test data
    const userEntity1 = UserEntity(
      userId: '123',
      name: 'John Doe',
      username: 'johndoe',
      email: 'johndoe@example.com',
      password: 'password123',
      profilePic: 'https://example.com/profile.jpg',
      followers: ['user1', 'user2'],
      following: ['user3', 'user4'],
      bio: 'Hello, I am John',
      isFrozen: false,
    );

    const userEntity2 = UserEntity(
      userId: '123',
      name: 'John Doe',
      username: 'johndoe',
      email: 'johndoe@example.com',
      password: 'password123',
      profilePic: 'https://example.com/profile.jpg',
      followers: ['user1', 'user2'],
      following: ['user3', 'user4'],
      bio: 'Hello, I am John',
      isFrozen: false,
    );

    const userEntity3 = UserEntity(
      userId: '456',
      name: 'Jane Doe',
      username: 'janedoe',
      email: 'janedoe@example.com',
      password: 'password456',
      profilePic: 'https://example.com/jane.jpg',
      followers: ['user5', 'user6'],
      following: ['user7', 'user8'],
      bio: 'Hello, I am Jane',
      isFrozen: true,
    );

    // Test for equality
    test('two UserEntity instances with the same properties should be equal',
        () {
      expect(userEntity1, equals(userEntity2));
    });

    // Test for inequality
    test(
        'two UserEntity instances with different properties should not be equal',
        () {
      expect(userEntity1, isNot(equals(userEntity3)));
    });

    // Test for props
    test('props should contain all properties of UserEntity', () {
      expect(
        userEntity1.props,
        equals([
          '123', // userId
          'John Doe', // name
          'johndoe', // username
          'johndoe@example.com', // email
          'password123', // password
          'https://example.com/profile.jpg', // profilePic
          ['user1', 'user2'], // followers
          ['user3', 'user4'], // following
          'Hello, I am John', // bio
          false, // isFrozen
        ]),
      );
    });

    // Test for default values
    test('default values should be set correctly', () {
      const defaultUserEntity = UserEntity(
        name: 'Default User',
        username: 'defaultuser',
        email: 'default@example.com',
        password: 'defaultpassword',
      );

      expect(defaultUserEntity.profilePic, '');
      expect(defaultUserEntity.followers, []);
      expect(defaultUserEntity.following, []);
      expect(defaultUserEntity.bio, '');
      expect(defaultUserEntity.isFrozen, false);
    });
  });
}
