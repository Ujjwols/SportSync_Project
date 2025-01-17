import 'package:mobile_application_project/core/network/hive_service.dart';
import 'package:mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
import 'package:mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentTeam() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      teamId: "1",
      teamName: "",
      email: "",
      password: "",
      confirmPassword: "",
    ));
  }

  @override
  Future<String> loginTeam(String teamName, String password) async {
    try {
      await _hiveService.login(teamName, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerTeam(AuthEntity team) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(team);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }
}
