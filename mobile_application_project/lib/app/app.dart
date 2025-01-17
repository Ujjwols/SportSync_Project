import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/features/splash/presentation/view/splash_view.dart';
import 'package:mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SportSync',
      home: BlocProvider(
        // Changed from BlocProvider.value to BlocProvider
        create: (context) => getIt<SplashCubit>(),
        child: const SplashView(),
      ),
    );
  }
}
