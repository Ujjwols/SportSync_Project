import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';

void main() {
  group('PostEntity', () {
    test('should be equal when properties are the same', () {
      final post1 = PostEntity(
        postId: '123',
        postedBy: 'user1',
        text: 'Hello world',
        img: 'image_url',
        likes: const ['user2', 'user3'],
        replies: const [
          ReplyEntity(
            userId: 'user2',
            text: 'Nice post!',
          )
        ],
        createdAt: DateTime(2024, 3, 6),
        updatedAt: DateTime(2024, 3, 6),
      );

      final post2 = PostEntity(
        postId: '123',
        postedBy: 'user1',
        text: 'Hello world',
        img: 'image_url',
        likes: const ['user2', 'user3'],
        replies: const [
          ReplyEntity(
            userId: 'user2',
            text: 'Nice post!',
          )
        ],
        createdAt: DateTime(2024, 3, 6),
        updatedAt: DateTime(2024, 3, 6),
      );

      expect(post1, equals(post2));
    });
  });

  group('ReplyEntity', () {
    test('should be equal when properties are the same', () {
      const reply1 = ReplyEntity(
        userId: 'user1',
        text: 'Great post!',
        userProfilePic: 'profile_pic_url',
        username: 'UserOne',
      );

      const reply2 = ReplyEntity(
        userId: 'user1',
        text: 'Great post!',
        userProfilePic: 'profile_pic_url',
        username: 'UserOne',
      );

      expect(reply1, equals(reply2));
    });
  });
}
