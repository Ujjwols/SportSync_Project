import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/core/usecase/usecase.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';
import 'package:mobile_application_project/features/matchpost/domain/repository/matchpost_repository.dart';

class CreateMatchPostParams extends Equatable {
  final String postedBy;
  final String? text;
  final String? img;
  final String teamname;
  final String location;
  final String date;
  final String time;
  final String gameType;
  final String payment;

  const CreateMatchPostParams({
    required this.postedBy,
    this.text,
    this.img,
    required this.teamname,
    required this.location,
    required this.date,
    required this.time,
    required this.gameType,
    required this.payment,
  });

  @override
  List<Object?> get props =>
      [postedBy, text, img, teamname, location, date, time, gameType, payment];
}

class CreateMatchPostUseCase
    implements UsecaseWithParams<bool, CreateMatchPostParams> {
  final IMatchPostRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  CreateMatchPostUseCase(
      {required this.tokenSharedPrefs, required this.repository});

  @override
  Future<Either<Failure, bool>> call(CreateMatchPostParams params) async {
    try {
      // Retrieve user details from TokenSharedPrefs
      final userDetailsResult = await tokenSharedPrefs.getUserDetails();
      final userDetails = userDetailsResult.fold(
        (failure) {
          print('Error retrieving user details: ${failure.message}');
          throw Exception('Failed to get user details: ${failure.message}');
        },
        (userDetails) {
          print('Retrieved user details: $userDetails'); // Debugging
          return userDetails;
        },
      );

      // Extract the userId from user details
      final userId = userDetails['_id'];
      if (userId == null || userId.isEmpty) {
        return const Left(
            ApiFailure(message: 'User ID not found in user details'));
      }

      // Debug: Print the userId to verify it's being retrieved correctly
      print('Retrieved userId: $userId');

      // Upload image to Cloudinary if provided
      String? imageUrl;
      if (params.img != null) {
        imageUrl = await repository.uploadImage(params.img!);
        if (imageUrl == null) {
          return const Left(
              ApiFailure(message: 'Failed to upload image to Cloudinary'));
        }
      }

      // Create the PostEntity
      final matchpostEntity = MatchPostEntity(
        matchpostId: null,
        postedBy: userId, // Use the retrieved userId
        text: params.text,
        img: imageUrl,
        teamName: params.teamname,
        location: params.location,
        date: params.date,
        time: params.time,
        gameType: params.gameType,
        payment: params.payment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Pass the PostEntity to the repository
      return await repository.createMatchPost(matchpostEntity);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
