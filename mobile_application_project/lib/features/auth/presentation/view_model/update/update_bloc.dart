import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_project/core/error/failure.dart';
import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/update_usecase.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UpdateProfileUseCase updateUserUseCase;

  UpdateUserBloc(this.updateUserUseCase) : super(UpdateUserInitial()) {
    on<UpdateUserRequested>(_onUpdateUserRequested);
  }

  Future<void> _onUpdateUserRequested(
      UpdateUserRequested event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());

    final result = await updateUserUseCase(UpdateProfileParams(
      name: event.name,
      email: event.email,
      username: event.username,
      bio: event.bio,
      profilePic: event.profilePic,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(UpdateUserFailure(_mapFailureToMessage(failure))),
      (updatedUser) => emit(UpdateUserSuccess(updatedUser)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message; // Assuming Failure has a `message` property
  }
}
