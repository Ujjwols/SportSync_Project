import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class DeletePostParams extends Equatable {
  final String postId;

  const DeletePostParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class DeletePostUseCase implements UsecaseWithParams<bool, DeletePostParams> {
  final IPostRepository repository;

  DeletePostUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeletePostParams params) async {
    return await repository.deletePost(params.postId);
  }
}
