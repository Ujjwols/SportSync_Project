import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/post/domain/use_case/createpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/deletepost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/get_feed_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getpostbyid_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getuserpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/likeandunlike_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/replytopost_usecase.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPostUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final GetFeedUseCase _getFeedUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase;
  final GetUserPostUseCase _getUserPostUseCase;
  final LikeUnlikePostUseCase _likeUnlikePostUseCase;
  final ReplyToPostUseCase _replyToPostUseCase;

  PostBloc({
    required CreatePostUseCase createPostUseCase,
    required DeletePostUseCase deletePostUseCase,
    required GetFeedUseCase getFeedUseCase,
    required GetPostByIdUseCase getPostByIdUseCase,
    required GetUserPostUseCase getUserPostUseCase,
    required LikeUnlikePostUseCase likeUnlikePostUseCase,
    required ReplyToPostUseCase replyToPostUseCase,
  })  : _createPostUseCase = createPostUseCase,
        _deletePostUseCase = deletePostUseCase,
        _getFeedUseCase = getFeedUseCase,
        _getPostByIdUseCase = getPostByIdUseCase,
        _getUserPostUseCase = getUserPostUseCase,
        _likeUnlikePostUseCase = likeUnlikePostUseCase,
        _replyToPostUseCase = replyToPostUseCase,
        super(PostInitial()) {
    on<CreatePostEvent>(_onCreatePost);
    on<DeletePostEvent>(_onDeletePost);
    on<GetFeedEvent>(_onGetFeed);
    on<GetPostByIdEvent>(_onGetPostById);
    on<GetUserPostEvent>(_onGetUserPost);
    on<LikeUnlikePostEvent>(_onLikeUnlikePost);
    on<ReplyToPostEvent>(_onReplyToPost);
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    if (event.postedBy.isEmpty || event.text?.isEmpty == true) {
      emit(const PostError('PostedBy and text fields are required.'));
      return;
    }

    final params = CreatePostParams(
      postedBy: event.postedBy,
      text: event.text,
      img: event.img,
    );

    final result = await _createPostUseCase(params);

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (success) => emit(PostCreated(success)),
    );
  }

  Future<void> _onDeletePost(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result =
        await _deletePostUseCase(DeletePostParams(postId: event.postId));

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (success) => emit(PostDeleted(success)),
    );
  }

  Future<void> _onGetFeed(GetFeedEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result = await _getFeedUseCase();

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (posts) => emit(FeedLoaded(posts)),
    );
  }

  Future<void> _onGetPostById(
      GetPostByIdEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result =
        await _getPostByIdUseCase(GetPostByIdParams(postId: event.postId));

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (post) => emit(PostLoaded(post)),
    );
  }

  Future<void> _onGetUserPost(
      GetUserPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result =
        await _getUserPostUseCase(GetUserPostParams(username: event.username));

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (posts) => emit(UserPostsLoaded(posts)),
    );
  }

  Future<void> _onLikeUnlikePost(
      LikeUnlikePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result = await _likeUnlikePostUseCase(
        LikeUnlikePostParams(postId: event.postId));

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (success) {
        // Emit PostLiked state
        emit(PostLiked(success));

        // Dispatch GetUserPostEvent to refresh the feed
        add(GetUserPostEvent(username: event.username));
      },
    );
  }

  Future<void> _onReplyToPost(
      ReplyToPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result = await _replyToPostUseCase(
      ReplyToPostParams(postId: event.postId, text: event.text),
    );

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (success) => emit(PostReplied(success)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ApiFailure:
        return 'An API error occurred: ${(failure as ApiFailure).message}';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
