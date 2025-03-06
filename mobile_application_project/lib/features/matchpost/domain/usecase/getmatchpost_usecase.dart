import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class GetMatchFeedUseCase
    implements UsecaseWithoutParams<List<MatchPostEntity>> {
  final IMatchPostRepository repository;

  GetMatchFeedUseCase(this.repository);

  @override
  Future<Either<Failure, List<MatchPostEntity>>> call() async {
    return await repository.getMatchFeed();
  }
}
