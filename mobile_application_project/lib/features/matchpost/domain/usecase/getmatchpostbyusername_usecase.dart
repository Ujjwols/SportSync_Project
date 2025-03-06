import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class GetUserMatchPostParams extends Equatable {
  final String username;

  const GetUserMatchPostParams({required this.username});

  @override
  List<Object?> get props => [username];
}

class GetUserMatchPostUseCase
    implements
        UsecaseWithParams<List<MatchPostEntity>, GetUserMatchPostParams> {
  final IMatchPostRepository repository;

  GetUserMatchPostUseCase(this.repository);

  @override
  Future<Either<Failure, List<MatchPostEntity>>> call(
      GetUserMatchPostParams params) async {
    return await repository.getUserMatchPost(params.username);
  }
}
