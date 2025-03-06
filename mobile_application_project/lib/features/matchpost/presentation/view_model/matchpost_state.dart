import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

abstract class MatchpostState extends Equatable {
  const MatchpostState();

  @override
  List<Object?> get props => [];
}

class MatchPostInitial extends MatchpostState {}

class MatchPostLoading extends MatchpostState {}

class MatchPostCreated extends MatchpostState {
  final bool success;

  const MatchPostCreated(this.success);

  @override
  List<Object?> get props => [success];
}

class MatchPostDeleted extends MatchpostState {
  final bool success;

  const MatchPostDeleted(this.success);

  @override
  List<Object?> get props => [success];
}

class MatchFeedLoaded extends MatchpostState {
  final List<MatchPostEntity> posts;

  const MatchFeedLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class MatchPostLoaded extends MatchpostState {
  final MatchPostEntity post;

  const MatchPostLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

class MatchUserPostsLoaded extends MatchpostState {
  final List<MatchPostEntity> posts;

  const MatchUserPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class MatchPostError extends MatchpostState {
  final String message;

  const MatchPostError(this.message);

  @override
  List<Object?> get props => [message];
}
