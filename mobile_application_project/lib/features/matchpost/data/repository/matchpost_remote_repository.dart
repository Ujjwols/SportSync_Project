import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/matchpost/data/data_source/matchpost_remote_data_source/matchpost_remote_data_source.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class MatchpostRemoteRepository implements IMatchPostRepository {
  final MatchpostRemoteDataSource _matchpostRemoteDataSource;

  MatchpostRemoteRepository(this._matchpostRemoteDataSource);

  @override
  Future<String?> uploadImage(String imagePath) async {
    return await _matchpostRemoteDataSource.uploadImage(imagePath);
  }

  @override
  Future<Either<Failure, bool>> createMatchPost(
      MatchPostEntity matchpost) async {
    return await _matchpostRemoteDataSource.createMatchPost(matchpost);
  }

  @override
  Future<Either<Failure, bool>> deleteMatchPost(String matchpostId) async {
    return await _matchpostRemoteDataSource.deleteMatchPost(matchpostId);
  }

  @override
  Future<Either<Failure, List<MatchPostEntity>>> getMatchFeed() async {
    return await _matchpostRemoteDataSource.getMatchFeed();
  }

  @override
  Future<Either<Failure, List<MatchPostEntity>>> getUserMatchPost(
      String username) async {
    return await _matchpostRemoteDataSource.getUserMatchPost(username);
  }

  @override
  Future<Either<Failure, MatchPostEntity>> getPostMatchById(
      String matchpostId) async {
    return await _matchpostRemoteDataSource.getMatchPostById(matchpostId);
  }
}
