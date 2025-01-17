import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashCompleted extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()); // Removed _loginBloc parameter

  Future<void> init(BuildContext context) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      emit(SplashCompleted());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<LoginBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<RegisterBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<HomeCubit>(),
              ),
            ],
            child: LoginView(),
          ),
        ),
      );
    }
  }
}
