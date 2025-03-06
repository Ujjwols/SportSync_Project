part of 'update_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserRequested extends UpdateUserEvent {
  final String name;
  final String email;
  final String username;
  final String bio;
  final String? profilePic;
  final String? password;

  const UpdateUserRequested({
    required this.name,
    required this.email,
    required this.username,
    required this.bio,
    this.profilePic,
    this.password,
  });

  @override
  List<Object?> get props => [name, email, username, bio, profilePic, password];
}
