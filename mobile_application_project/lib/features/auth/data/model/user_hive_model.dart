import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String password;

  @HiveField(5)
  final String profilePic;

  @HiveField(6)
  final List<String> followers;

  @HiveField(7)
  final List<String> following;

  @HiveField(8)
  final String bio;

  @HiveField(9)
  final bool isFrozen;

  const UserHiveModel({
    this.userId,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    this.profilePic = '',
    this.followers = const [],
    this.following = const [],
    this.bio = '',
    this.isFrozen = false,
  });

  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      userId: entity.userId,
      name: entity.name,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      profilePic: entity.profilePic,
      followers: entity.followers,
      following: entity.following,
      bio: entity.bio,
      isFrozen: entity.isFrozen,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      name: name,
      username: username,
      email: email,
      password: password,
      profilePic: profilePic,
      followers: followers,
      following: following,
      bio: bio,
      isFrozen: isFrozen,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        username,
        email,
        password,
        profilePic,
        followers,
        following,
        bio,
        isFrozen,
      ];
}
