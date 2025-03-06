import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class ReplyToPostParams extends Equatable {
  final String postId;
  final String text;

  const ReplyToPostParams({required this.postId, required this.text});

  @override
  List<Object?> get props => [postId, text];
}

class ReplyToPostUseCase implements UsecaseWithParams<bool, ReplyToPostParams> {
  final IPostRepository repository;

  ReplyToPostUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ReplyToPostParams params) async {
    return await repository.replyToPost(params.postId, params.text);
  }
}
