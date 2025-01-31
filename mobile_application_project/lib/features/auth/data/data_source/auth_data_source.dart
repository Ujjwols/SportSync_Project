import 'dart:io';

import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginTeam(String teamName, String password);

  Future<void> registerTeam(AuthEntity team);

  Future<AuthEntity> getCurrentTeam();

  Future<String> uploadProfilePicture(File file);
}
