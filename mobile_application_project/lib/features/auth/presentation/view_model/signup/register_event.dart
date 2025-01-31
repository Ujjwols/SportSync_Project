part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object> get props => [context, destination];
}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class RegisterTeam extends RegisterEvent {
  final BuildContext context;
  final String teamName;
  final String email;
  final String? image;
  final String password;
  final String confirmPassword;

  const RegisterTeam({
    required this.context,
    required this.teamName,
    required this.email,
    this.image,
    required this.password,
    required this.confirmPassword,
  });
}
