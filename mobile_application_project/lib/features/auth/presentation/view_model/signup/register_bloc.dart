import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/register_usecase.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_cubit.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<NavigateLoginScreenEvent>(_onNavigateLoginScreenEvent);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      name: event.name,
      username: event.username,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }

  void _onNavigateLoginScreenEvent(
    NavigateLoginScreenEvent event,
    Emitter<RegisterState> emit,
  ) {
    // Navigate to the desired screen with the necessary blocs
    Navigator.of(event.context).push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  getIt<LoginBloc>()), // Ensure LoginBloc is available
          BlocProvider(create: (context) => getIt<RegisterBloc>()),
          BlocProvider(create: (context) => getIt<HomeCubit>()),
        ],
        child:
            event.destination, // Pass the destination screen (LoginView) here
      ),
    ));
  }
}
