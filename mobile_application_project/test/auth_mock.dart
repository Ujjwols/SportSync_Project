import 'package:mobile_application_project/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/register_usecase.dart';
import 'package:mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUseCase extends Mock implements UploadImageUsecase {}

class MockLoginBloc extends Mock implements LoginBloc {}

class MockRegisterBloc extends Mock implements RegisterBloc {}
