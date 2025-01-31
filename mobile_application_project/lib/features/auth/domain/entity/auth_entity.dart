import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? teamId;
  final String teamName;
  final String email;
  final String? image;
  final String password;
  final String confirmPassword;

  const AuthEntity({
    this.teamId,
    required this.teamName,
    required this.email,
    this.image,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        teamId,
        teamName,
        email,
        image,
        password,
        confirmPassword,
      ];
}
