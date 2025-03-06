import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';

abstract interface class IPostDataSource {
  Future<String?> uploadImage(String imagePath);

  /// Fetches the feed posts for the current user.
  Future<Either<Failure, List<PostEntity>>> getFeed();

  /// Fetches posts by a specific username.
  Future<Either<Failure, List<PostEntity>>> getUserPost(String username);

  /// Fetches a single post by its ID.
  Future<Either<Failure, PostEntity>> getPostById(String postId);

  /// Creates a new post.
  Future<Either<Failure, bool>> createPost(PostEntity post);

  /// Deletes a post by its ID.
  Future<Either<Failure, bool>> deletePost(String postId);

  /// Likes or unlikes a post by its ID.
  Future<Either<Failure, bool>> likeUnlikePost(String postId);

  /// Replies to a post by its ID with the given text.
  Future<Either<Failure, bool>> replyToPost(String postId, String text);
}
