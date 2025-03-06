import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/post_entity.dart';

part 'post_api_model.g.dart';

@JsonSerializable()
class PostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String?
      id; // Made id nullable to handle cases where it might not be present
  final String postedBy;
  final String? text;
  final String? img;
  final List<String> likes;
  final List<ReplyApiModel> replies;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostApiModel({
    this.id,
    required this.postedBy,
    this.text,
    this.img,
    this.likes = const [],
    this.replies = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert JSON to `PostApiModel`
  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);

  /// Convert `PostApiModel` to JSON
  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

  /// Convert to domain entity
  PostEntity toEntity() {
    return PostEntity(
      postId: id,
      postedBy: postedBy,
      text: text,
      img: img,
      likes: likes,
      replies: replies.map((reply) => reply.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory PostApiModel.fromEntity(PostEntity entity) {
    return PostApiModel(
      id: entity.postId,
      postedBy: entity.postedBy,
      text: entity.text,
      img: entity.img,
      likes: entity.likes,
      replies: entity.replies
          .map((reply) => ReplyApiModel.fromEntity(reply))
          .toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        postedBy,
        text,
        img,
        likes,
        replies,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class ReplyApiModel extends Equatable {
  final String userId;
  final String text;
  final String? userProfilePic;
  final String? username;

  const ReplyApiModel({
    required this.userId,
    required this.text,
    this.userProfilePic,
    this.username,
  });

  /// Convert JSON to `ReplyApiModel`
  factory ReplyApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyApiModelFromJson(json);

  /// Convert `ReplyApiModel` to JSON
  Map<String, dynamic> toJson() => _$ReplyApiModelToJson(this);

  /// Convert to domain entity
  ReplyEntity toEntity() {
    return ReplyEntity(
      userId: userId,
      text: text,
      userProfilePic: userProfilePic,
      username: username,
    );
  }

  /// Create from domain entity
  factory ReplyApiModel.fromEntity(ReplyEntity entity) {
    return ReplyApiModel(
      userId: entity.userId,
      text: entity.text,
      userProfilePic: entity.userProfilePic,
      username: entity.username,
    );
  }

  @override
  List<Object?> get props => [userId, text, userProfilePic, username];
}
