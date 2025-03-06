import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/creatematchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/deletematchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpost_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpostbyid_usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/usecase/getmatchpostbyusername_usecase.dart';

import 'matchpost_event.dart';
import 'matchpost_state.dart';

class MatchpostBloc extends Bloc<MatchpostEvent, MatchpostState> {
  final CreateMatchPostUseCase _createMatchPostUseCase;
  final DeleteMatchPostUseCase _deleteMatchPostUseCase;
  final GetMatchFeedUseCase _getMatchFeedUseCase;
  final GetMatchPostByIdUseCase _getMatchPostByIdUseCase;
  final GetUserMatchPostUseCase _getUserMatchPostUseCase;

  MatchpostBloc({
    required CreateMatchPostUseCase createMatchPostUseCase,
    required DeleteMatchPostUseCase deleteMatchPostUseCase,
    required GetMatchFeedUseCase getMatchFeedUseCase,
    required GetMatchPostByIdUseCase getMatchPostByIdUseCase,
    required GetUserMatchPostUseCase getUserMatchPostUseCase,
  })  : _createMatchPostUseCase = createMatchPostUseCase,
        _deleteMatchPostUseCase = deleteMatchPostUseCase,
        _getMatchFeedUseCase = getMatchFeedUseCase,
        _getMatchPostByIdUseCase = getMatchPostByIdUseCase,
        _getUserMatchPostUseCase = getUserMatchPostUseCase,
        super(MatchPostInitial()) {
    on<CreateMatchPostEvent>(_onCreateMatchPost);
    on<DeleteMatchPostEvent>(_onDeleteMatchPost);
    on<GetMatchFeedEvent>(_onGetMatchFeed);
    on<GetPostMatchByIdEvent>(_onGetPostMatchById);
    on<GetUserMatchPostEvent>(_onGetUserMatchPost);
  }

  Future<void> _onCreateMatchPost(
      CreateMatchPostEvent event, Emitter<MatchpostState> emit) async {
    emit(MatchPostLoading());

    if (event.postedBy.isEmpty || event.text?.isEmpty == true) {
      emit(const MatchPostError('PostedBy and text fields are required.'));
      return;
    }

    final params = CreateMatchPostParams(
      postedBy: event.postedBy,
      text: event.text,
      img: event.img,
      teamname: event.teamName,
      location: event.location,
      date: event.date,
      time: event.time,
      gameType: event.gameType,
      payment: event.payment,
    );

    final result = await _createMatchPostUseCase(params);

    result.fold(
      (failure) => emit(MatchPostError(_mapFailureToMessage(failure))),
      (success) => emit(MatchPostCreated(success)),
    );
  }

  Future<void> _onDeleteMatchPost(
      DeleteMatchPostEvent event, Emitter<MatchpostState> emit) async {
    emit(MatchPostLoading());

    final result = await _deleteMatchPostUseCase(
        DeleteMatchPostParams(matchpostId: event.matchpostId));

    result.fold(
      (failure) => emit(MatchPostError(_mapFailureToMessage(failure))),
      (success) => emit(MatchPostDeleted(success)),
    );
  }

  Future<void> _onGetMatchFeed(
      GetMatchFeedEvent event, Emitter<MatchpostState> emit) async {
    emit(MatchPostLoading());

    final result = await _getMatchFeedUseCase();

    result.fold(
      (failure) => emit(MatchPostError(_mapFailureToMessage(failure))),
      (matchposts) => emit(MatchFeedLoaded(matchposts)),
    );
  }

  Future<void> _onGetPostMatchById(
      GetPostMatchByIdEvent event, Emitter<MatchpostState> emit) async {
    emit(MatchPostLoading());

    final result = await _getMatchPostByIdUseCase(
        GetMatchPostByIdParams(matchpostId: event.matchpostId));

    result.fold(
      (failure) => emit(MatchPostError(_mapFailureToMessage(failure))),
      (matchpost) => emit(MatchPostLoaded(matchpost)),
    );
  }

  Future<void> _onGetUserMatchPost(
      GetUserMatchPostEvent event, Emitter<MatchpostState> emit) async {
    emit(MatchPostLoading());

    final result = await _getUserMatchPostUseCase(
        GetUserMatchPostParams(username: event.username));

    result.fold(
      (failure) => emit(MatchPostError(_mapFailureToMessage(failure))),
      (matchposts) => emit(MatchUserPostsLoaded(matchposts)),
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
