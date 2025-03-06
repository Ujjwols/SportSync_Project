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

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String name;
  final String username;
  final String email;
  final String password;

  const RegisterUser({
    required this.context,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
}
