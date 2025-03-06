import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String? profilePic;
  final List<String>? followers;
  final List<String>? following;
  final String? bio;
  final bool? isFrozen;

  const UserApiModel({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    this.profilePic,
    this.followers,
    this.following,
    this.bio,
    this.isFrozen,
  });

  /// Convert JSON to UserApiModel
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  /// Convert UserApiModel to JSON
  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  /// Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      userId: id,
      name: name,
      username: username,
      email: email,
      password: password,
      profilePic: profilePic ?? '',
      followers: followers ?? [],
      following: following ?? [],
      bio: bio ?? '',
      isFrozen: isFrozen ?? false,
    );
  }

  /// Create from domain entity
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.userId,
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

  @override
  List<Object?> get props => [
        id,
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
