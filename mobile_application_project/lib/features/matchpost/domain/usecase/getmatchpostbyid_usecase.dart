import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class GetMatchPostByIdParams extends Equatable {
  final String matchpostId;

  const GetMatchPostByIdParams({required this.matchpostId});

  @override
  List<Object?> get props => [matchpostId];
}

class GetMatchPostByIdUseCase
    implements UsecaseWithParams<MatchPostEntity, GetMatchPostByIdParams> {
  final IMatchPostRepository repository;

  GetMatchPostByIdUseCase(this.repository);

  @override
  Future<Either<Failure, MatchPostEntity>> call(
      GetMatchPostByIdParams params) async {
    return await repository.getPostMatchById(params.matchpostId);
  }
}
