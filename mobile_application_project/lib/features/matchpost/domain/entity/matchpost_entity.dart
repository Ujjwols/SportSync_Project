import 'package:equatable/equatable.dart';

class MatchPostEntity extends Equatable {
  final String? matchpostId; // <-- Updated field name
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

  const MatchPostEntity({
    this.matchpostId, // <-- Updated field name
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

  @override
  List<Object?> get props => [
        matchpostId, // <-- Updated field name
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
