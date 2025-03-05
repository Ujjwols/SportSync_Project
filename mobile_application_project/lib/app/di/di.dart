import 'package:cloudinary/cloudinary.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:mobile_application_project/app/shared_prefs/user_shared_prefs.dart';
import 'package:mobile_application_project/core/network/api_service.dart';
import 'package:mobile_application_project/core/network/hive_service.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:mobile_application_project/features/auth/data/repository/user_remote_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/register_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/update_usecase.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/update/update_bloc.dart';
import 'package:mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:mobile_application_project/features/post/data/data_source/post_remote_data_source.dart/post_remote_data_source.dart';
import 'package:mobile_application_project/features/post/data/repository/post_remote_repository.dart';
import 'package:mobile_application_project/features/post/domain/use_case/createpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/deletepost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/get_feed_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getpostbyid_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/getuserpost_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/likeandunlike_usecase.dart';
import 'package:mobile_application_project/features/post/domain/use_case/replytopost_usecase.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_bloc.dart';
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
  // Add UserSharedPrefs
  await _initUserSharedPrefs();

  // Add Post dependencies
  await _initPostDependencies();

  await _initUpdateDependencies();
  // Add Cloudinary
  await _initCloudinary();
}

Future<void> _initCloudinary() async {
  getIt.registerLazySingleton<Cloudinary>(
    () => Cloudinary.signedConfig(
      cloudName: 'ddiswbjbw',
      apiKey: '272882952667473',
      apiSecret: 'tRZTJajq6JgdSmFxTdeiZtndxpk',
    ),
  );
}

Future<void> _initUserSharedPrefs() async {
  getIt.registerLazySingleton<UserSharedPrefs>(
    () => UserSharedPrefs(getIt<SharedPreferences>()),
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPrefrences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefrences);

  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

//Post
// Add this function to initialize Post-related dependencies
Future<void> _initPostDependencies() async {
  // Register PostRemoteDataSource
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(
      dio: getIt<Dio>(), // Pass the Dio instance
      cloudinary: getIt<Cloudinary>(),
      tokenSharedPrefs:
          getIt<TokenSharedPrefs>(), // Pass the Cloudinary instance
    ),
  );

  // Register PostRemoteRepository
  getIt.registerLazySingleton<PostRemoteRepository>(
    () => PostRemoteRepository(getIt<PostRemoteDataSource>()),
  );
  // Register all Post-related use cases
  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(
      repository: getIt<PostRemoteRepository>(), // Pass PostRemoteRepository
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Pass UserSharedPrefs
    ),
  );

  getIt.registerLazySingleton<DeletePostUseCase>(
    () => DeletePostUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetFeedUseCase>(
    () => GetFeedUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetPostByIdUseCase>(
    () => GetPostByIdUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetUserPostUseCase>(
    () => GetUserPostUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerLazySingleton<LikeUnlikePostUseCase>(
    () => LikeUnlikePostUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerLazySingleton<ReplyToPostUseCase>(
    () => ReplyToPostUseCase(getIt<PostRemoteRepository>()),
  );

  getIt.registerFactory<PostBloc>(
    () => PostBloc(
      createPostUseCase: getIt(),
      deletePostUseCase: getIt(),
      getFeedUseCase: getIt(),
      getPostByIdUseCase: getIt(),
      getUserPostUseCase: getIt(),
      likeUnlikePostUseCase: getIt(),
      replyToPostUseCase: getIt(),
    ),
  );
}

//Registration
_initRegisterDependencies() {
  // init local data source
  // getIt.registerLazySingleton(
  //   () => AuthLocalDataSource(getIt<HiveService>()),
  // );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
        getIt<Dio>(), getIt<TokenSharedPrefs>(), getIt<Cloudinary>()),
  );

  // init local repository
  // getIt.registerLazySingleton(
  //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  // );

  getIt.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<UserRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
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
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<UserRemoteRepository>(),
      // getIt<AuthLocalRepository>(),
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

_initUpdateDependencies() async {
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  // Register UpdateUserUseCase
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(
      repository: getIt<UserRemoteRepository>(), // Pass PostRemoteRepository
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Pass UserSharedPrefs
    ),
  );

  // Register UpdateUserBloc with UpdateUserUseCase
  getIt.registerFactory<UpdateUserBloc>(
    () => UpdateUserBloc(
        getIt<UpdateProfileUseCase>()), // Pass UpdateUserUseCase here
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}
