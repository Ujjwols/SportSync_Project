import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/core/network/api_service.dart';
import 'package:mobile_application_project/core/network/hive_service.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_local_data_source/auth_local_data_source.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:mobile_application_project/features/auth/data/repository/auth_local_repository.dart';
import 'package:mobile_application_project/features/auth/data/repository/auth_remote_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/register_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initSharedPreferences();
  await _initApiService();
  await _initHiveService();
  await _initRegisterDependencies();
  await _initHomeDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPrefrences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefrences);
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

//Registration
_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

//Login
_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(), // Ensure AuthLocalRepository uses HiveService
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}
