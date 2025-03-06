import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class DeleteMatchPostParams extends Equatable {
  final String matchpostId;

  const DeleteMatchPostParams({required this.matchpostId});

  @override
  List<Object?> get props => [matchpostId];
}

class DeleteMatchPostUseCase
    implements UsecaseWithParams<bool, DeleteMatchPostParams> {
  final IMatchPostRepository repository;

  DeleteMatchPostUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteMatchPostParams params) async {
    return await repository.deleteMatchPost(params.matchpostId);
  }
}
