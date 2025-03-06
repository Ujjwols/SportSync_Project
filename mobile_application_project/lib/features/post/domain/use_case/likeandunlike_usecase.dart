import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class LikeUnlikePostParams extends Equatable {
  final String postId;

  const LikeUnlikePostParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class LikeUnlikePostUseCase
    implements UsecaseWithParams<bool, LikeUnlikePostParams> {
  final IPostRepository repository;

  LikeUnlikePostUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LikeUnlikePostParams params) async {
    return await repository.likeUnlikePost(params.postId);
  }
}
