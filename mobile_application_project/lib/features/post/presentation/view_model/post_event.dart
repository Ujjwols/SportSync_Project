import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class CreatePostEvent extends PostEvent {
  final String postedBy;
  final String? text;
  final String? img;

  const CreatePostEvent({
    required this.postedBy,
    this.text,
    this.img,
  });

  @override
  List<Object?> get props => [postedBy, text, img];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class GetFeedEvent extends PostEvent {}

class GetPostByIdEvent extends PostEvent {
  final String postId;

  const GetPostByIdEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class GetUserPostEvent extends PostEvent {
  final String username;

  const GetUserPostEvent({required this.username});

  @override
  List<Object?> get props => [username];
}

class LikeUnlikePostEvent extends PostEvent {
  final String postId;
  final String username;

  const LikeUnlikePostEvent({required this.postId, required this.username});

  @override
  List<Object?> get props => [postId, username];
}

class ReplyToPostEvent extends PostEvent {
  final String postId;
  final String text;

  const ReplyToPostEvent({required this.postId, required this.text});

  @override
  List<Object?> get props => [postId, text];
}
