import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

part 'matchpost_api_model.g.dart';

@JsonSerializable()
class MatchPostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id; // <-- Updated field name
  final String postedBy;
  final String? text;
  final String? img;
  final String teamName;
  final String location;
  final String date;
  final String time;
  final String gameType;
  final String payment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MatchPostApiModel({
    this.id, // <-- Updated field name
    required this.postedBy,
    this.text,
    this.img,
    required this.teamName,
    required this.location,
    required this.date,
    required this.time,
    required this.gameType,
    required this.payment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MatchPostApiModel.fromJson(Map<String, dynamic> json) =>
      _$MatchPostApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchPostApiModelToJson(this);

  MatchPostEntity toEntity() {
    return MatchPostEntity(
      matchpostId: id, // <-- Updated field name
      postedBy: postedBy,
      text: text,
      img: img,
      teamName: teamName,
      location: location,
      date: date,
      time: time,
      gameType: gameType,
      payment: payment,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory MatchPostApiModel.fromEntity(MatchPostEntity entity) {
    return MatchPostApiModel(
      id: entity.matchpostId, // <-- Updated field name
      postedBy: entity.postedBy,
      text: entity.text,
      img: entity.img,
      teamName: entity.teamName,
      location: entity.location,
      date: entity.date,
      time: entity.time,
      gameType: entity.gameType,
      payment: entity.payment,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, // <-- Updated field name
        postedBy,
        text,
        img,
        teamName,
        location,
        date,
        time,
        gameType,
        payment,
        createdAt,
        updatedAt,
      ];
}
