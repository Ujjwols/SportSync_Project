import 'package:mobile_application_project/features/post/data/model/post_api_model.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:test/test.dart';

void main() {
  group('PostApiModel Tests', () {
    test(
        'should correctly convert from PostEntity to PostApiModel and vice versa',
        () {
      // Create a PostEntity for testing
      final postEntity = PostEntity(
        postId: '123',
        postedBy: 'user123',
        text: 'This is a post',
        img: 'image_url',
        likes: const ['user1', 'user2'],
        replies: const [
          ReplyEntity(
            userId: 'user1',
            text: 'Reply text',
            userProfilePic: 'profile_pic_url',
            username: 'User One',
          ),
        ],
        createdAt: DateTime.parse('2025-03-06T12:00:00Z'),
        updatedAt: DateTime.parse('2025-03-06T12:00:00Z'),
      );

      // Convert PostEntity to PostApiModel
      final postApiModel = PostApiModel.fromEntity(postEntity);

      // Test if the conversion from entity to model is correct
      expect(postApiModel.id, '123');
      expect(postApiModel.postedBy, 'user123');
      expect(postApiModel.text, 'This is a post');
      expect(postApiModel.img, 'image_url');
      expect(postApiModel.likes, ['user1', 'user2']);
      expect(postApiModel.replies.length, 1);

      // Convert back to entity
      final postEntityBack = postApiModel.toEntity();
      expect(postEntityBack.postId, '123');
      expect(postEntityBack.postedBy, 'user123');
      expect(postEntityBack.text, 'This is a post');
      expect(postEntityBack.img, 'image_url');
      expect(postEntityBack.likes, ['user1', 'user2']);
      expect(postEntityBack.replies.length, 1);
    });
  });

  group('ReplyApiModel Tests', () {
    // Test for fromJson and toJson
    test('should correctly convert from JSON to ReplyApiModel and vice versa',
        () {
      // Example JSON for ReplyApiModel
      final replyJson = {
        'userId': 'user1',
        'text': 'Reply text',
        'userProfilePic': 'profile_pic_url',
        'username': 'User One',
      };

      // Convert JSON to ReplyApiModel
      final replyModel = ReplyApiModel.fromJson(replyJson);

      // Test if the conversion from JSON to model is correct
      expect(replyModel.userId, 'user1');
      expect(replyModel.text, 'Reply text');
      expect(replyModel.userProfilePic, 'profile_pic_url');
      expect(replyModel.username, 'User One');

      // Convert back to JSON
      final replyJsonBack = replyModel.toJson();
      expect(replyJsonBack['userId'], 'user1');
      expect(replyJsonBack['text'], 'Reply text');
      expect(replyJsonBack['userProfilePic'], 'profile_pic_url');
      expect(replyJsonBack['username'], 'User One');
    });

    // Test for toEntity and fromEntity
    test(
        'should correctly convert from ReplyEntity to ReplyApiModel and vice versa',
        () {
      // Create a ReplyEntity for testing
      const replyEntity = ReplyEntity(
        userId: 'user1',
        text: 'Reply text',
        userProfilePic: 'profile_pic_url',
        username: 'User One',
      );

      // Convert ReplyEntity to ReplyApiModel
      final replyApiModel = ReplyApiModel.fromEntity(replyEntity);

      // Test if the conversion from entity to model is correct
      expect(replyApiModel.userId, 'user1');
      expect(replyApiModel.text, 'Reply text');
      expect(replyApiModel.userProfilePic, 'profile_pic_url');
      expect(replyApiModel.username, 'User One');

      // Convert back to entity
      final replyEntityBack = replyApiModel.toEntity();
      expect(replyEntityBack.userId, 'user1');
      expect(replyEntityBack.text, 'Reply text');
      expect(replyEntityBack.userProfilePic, 'profile_pic_url');
      expect(replyEntityBack.username, 'User One');
    });
  });
}
