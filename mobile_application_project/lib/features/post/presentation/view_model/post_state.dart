import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostCreated extends PostState {
  final bool success;

  const PostCreated(this.success);

  @override
  List<Object?> get props => [success];
}

class PostDeleted extends PostState {
  final bool success;

  const PostDeleted(this.success);

  @override
  List<Object?> get props => [success];
}

class FeedLoaded extends PostState {
  final List<PostEntity> posts;

  const FeedLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostLoaded extends PostState {
  final PostEntity post;

  const PostLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

class UserPostsLoaded extends PostState {
  final List<PostEntity> posts;

  const UserPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostLiked extends PostState {
  final bool success;

  const PostLiked(this.success);

  @override
  List<Object?> get props => [success];
}

class PostReplied extends PostState {
  final bool success;

  const PostReplied(this.success);

  @override
  List<Object?> get props => [success];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object?> get props => [message];
}
