import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String name;
  final String username;
  final String email;
  final String password;
  final String profilePic;
  final List<String> followers;
  final List<String> following;
  final String bio;
  final bool isFrozen;

  const UserEntity({
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
