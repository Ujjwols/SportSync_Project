// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      id: json['_id'] as String?,
      postedBy: json['postedBy'] as String,
      text: json['text'] as String?,
      img: json['img'] as String?,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => ReplyApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postedBy': instance.postedBy,
      'text': instance.text,
      'img': instance.img,
      'likes': instance.likes,
      'replies': instance.replies,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

ReplyApiModel _$ReplyApiModelFromJson(Map<String, dynamic> json) =>
    ReplyApiModel(
      userId: json['userId'] as String,
      text: json['text'] as String,
      userProfilePic: json['userProfilePic'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$ReplyApiModelToJson(ReplyApiModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'text': instance.text,
      'userProfilePic': instance.userProfilePic,
      'username': instance.username,
    };
