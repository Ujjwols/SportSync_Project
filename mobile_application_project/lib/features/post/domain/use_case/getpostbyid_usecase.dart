import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class GetPostByIdParams extends Equatable {
  final String postId;

  const GetPostByIdParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class GetPostByIdUseCase implements UsecaseWithParams<PostEntity, GetPostByIdParams> {
  final IPostRepository repository;

  GetPostByIdUseCase(this.repository);

  @override
  Future<Either<Failure, PostEntity>> call(GetPostByIdParams params) async {
    return await repository.getPostByID(params.postId);
  }
}