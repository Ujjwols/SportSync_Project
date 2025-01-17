import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}SportSync.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.teamBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.teamBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.teamBox);
    return box.values.toList();
  }

  // Login using teamName and password
  Future<AuthHiveModel?> login(String teamName, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.teamBox);
    try {
      var team = box.values.firstWhere(
        (element) =>
            element.teamName == teamName && element.password == password,
        orElse: () => throw Exception("User not found"),
      );
      box.close();
      return team; // return the found team if valid
    } catch (e) {
      box.close();
      return null; // return null if no user is found
    }
  }
}
