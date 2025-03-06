import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class GetUserPostParams extends Equatable {
  final String username;

  const GetUserPostParams({required this.username});

  @override
  List<Object?> get props => [username];
}

class GetUserPostUseCase
    implements UsecaseWithParams<List<PostEntity>, GetUserPostParams> {
  final IPostRepository repository;

  GetUserPostUseCase(this.repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetUserPostParams params) async {
    return await repository.getUserPost(params.username);
  }
}
