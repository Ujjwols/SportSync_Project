import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class GetFeedUseCase implements UsecaseWithoutParams<List<PostEntity>> {
  final IPostRepository repository;

  GetFeedUseCase(this.repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repository.getFeed();
  }
}
