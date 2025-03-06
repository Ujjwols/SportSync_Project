import 'package:dartz/dartz.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/post/data/data_source/post_remote_data_source.dart/post_remote_data_source.dart';
import 'package:mobile_application_project/features/post/domain/entity/post_entity.dart';
import 'package:mobile_application_project/features/post/domain/repository/post_repository.dart';

class PostRemoteRepository implements IPostRepository {
  final PostRemoteDataSource _postRemoteDataSource;

  PostRemoteRepository(this._postRemoteDataSource);

  @override
  Future<String?> uploadImage(String imagePath) async {
    return await _postRemoteDataSource.uploadImage(imagePath);
  }

  @override
  Future<Either<Failure, bool>> createPost(PostEntity post) async {
    return await _postRemoteDataSource.createPost(post);
  }

  @override
  Future<Either<Failure, bool>> deletePost(String postId) async {
    return await _postRemoteDataSource.deletePost(postId);
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getFeed() async {
    return await _postRemoteDataSource.getFeed();
  }

  @override
  Future<Either<Failure, PostEntity>> getPostByID(String postId) async {
    return await _postRemoteDataSource.getPostById(postId);
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getUserPost(String username) async {
    return await _postRemoteDataSource.getUserPost(username);
  }

  @override
  Future<Either<Failure, bool>> likeUnlikePost(String postId) async {
    return await _postRemoteDataSource.likeUnlikePost(postId);
  }

  @override
  Future<Either<Failure, bool>> replyToPost(String postId, String text) async {
    return await _postRemoteDataSource.replyToPost(postId, text);
  }
}
