part of 'update_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final UserEntity updatedUser;

  const UpdateUserSuccess(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class UpdateUserFailure extends UpdateUserState {
  final String message;

  const UpdateUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}