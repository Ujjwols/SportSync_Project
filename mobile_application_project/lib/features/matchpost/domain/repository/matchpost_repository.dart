import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

abstract interface class IMatchPostRepository {
  Future<String?> uploadImage(String imagePath);

  /// Fetches the feed posts for the current user.
  Future<Either<Failure, List<MatchPostEntity>>> getMatchFeed();

  /// Fetches posts by a specific username.
  Future<Either<Failure, List<MatchPostEntity>>> getUserMatchPost(
      String username);

  Future<Either<Failure, MatchPostEntity>> getPostMatchById(String matchpostId);

  /// Creates a new post.
  Future<Either<Failure, bool>> createMatchPost(MatchPostEntity matchpost);

  /// Deletes a post by its ID.
  Future<Either<Failure, bool>> deleteMatchPost(String matchpostId);
}
