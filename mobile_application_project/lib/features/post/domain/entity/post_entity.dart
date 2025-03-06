import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String postedBy;
  final String? text;
  final String? img;
  final List<String> likes;
  final List<ReplyEntity> replies;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostEntity({
    this.postId,
    required this.postedBy,
    this.text,
    this.img,
    this.likes = const [],
    this.replies = const [],
    required this.createdAt,
    required this.updatedAt,  
  });

  @override
  List<Object?> get props => [
        postId,
        postedBy,
        text,
        img,
        likes,
        replies,
        createdAt,
        updatedAt,
      ];
}

class ReplyEntity extends Equatable {
  final String userId;
  final String text;
  final String? userProfilePic;
  final String? username;

  const ReplyEntity({
    required this.userId,
    required this.text,
    this.userProfilePic,
    this.username,
  });

  @override
  List<Object?> get props => [
        userId,
        text,
        userProfilePic,
        username,
      ];
}
