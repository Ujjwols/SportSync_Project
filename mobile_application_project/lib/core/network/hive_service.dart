import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:mobile_application_project/features/auth/data/model/user_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}mobileSportSync.db';

    Hive.init(path);

    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<UserHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    try {
      var user = box.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () =>
            throw Exception("User not found"), // Ensure it throws an exception
      );
      box.close();
      return user;
    } catch (e) {
      box.close();
      return null; // Handle the case when no user is found
    }
  }

  //dulpicate register garna nadene
}
