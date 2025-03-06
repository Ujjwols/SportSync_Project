// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchpost_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPostApiModel _$MatchPostApiModelFromJson(Map<String, dynamic> json) =>
    MatchPostApiModel(
      id: json['_id'] as String?,
      postedBy: json['postedBy'] as String,
      text: json['text'] as String?,
      img: json['img'] as String?,
      teamName: json['teamName'] as String,
      location: json['location'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      gameType: json['gameType'] as String,
      payment: json['payment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MatchPostApiModelToJson(MatchPostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postedBy': instance.postedBy,
      'text': instance.text,
      'img': instance.img,
      'teamName': instance.teamName,
      'location': instance.location,
      'date': instance.date,
      'time': instance.time,
      'gameType': instance.gameType,
      'payment': instance.payment,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
