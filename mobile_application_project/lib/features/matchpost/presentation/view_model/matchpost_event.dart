import 'package:equatable/equatable.dart';

abstract class MatchpostEvent extends Equatable {
  const MatchpostEvent();

  @override
  List<Object?> get props => [];
}

class CreateMatchPostEvent extends MatchpostEvent {
  final String postedBy;
  final String? text;
  final String? img;
  final String teamName;
  final String location;
  final String date;
  final String time;
  final String gameType;
  final String payment;

  const CreateMatchPostEvent({
    required this.postedBy,
    this.text,
    this.img,
    required this.teamName,
    required this.location,
    required this.date,
    required this.time,
    required this.gameType,
    required this.payment,
  });

  @override
  List<Object?> get props =>
      [postedBy, text, img, teamName, location, date, time, gameType, payment];
}

class DeleteMatchPostEvent extends MatchpostEvent {
  final String matchpostId;

  const DeleteMatchPostEvent({required this.matchpostId});

  @override
  List<Object?> get props => [matchpostId];
}

class GetMatchFeedEvent extends MatchpostEvent {}

class GetPostMatchByIdEvent extends MatchpostEvent {
  final String matchpostId;

  const GetPostMatchByIdEvent({required this.matchpostId});

  @override
  List<Object?> get props => [matchpostId];
}

class GetUserMatchPostEvent extends MatchpostEvent {
  final String username;

  const GetUserMatchPostEvent({required this.username});

  @override
  List<Object?> get props => [username];
}
