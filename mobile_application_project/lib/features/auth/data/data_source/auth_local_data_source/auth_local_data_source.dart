// import 'package:mobile_application_project/core/network/hive_service.dart';
// import 'package:mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
// import 'package:mobile_application_project/features/auth/data/model/user_hive_model.dart';
// import 'package:mobile_application_project/features/auth/domain/entity/user_entity.dart';

// class AuthLocalDataSource implements IAuthDataSource {
//   final HiveService _hiveService;

//   AuthLocalDataSource(this._hiveService);

//   @override
//   Future<UserEntity> getUsers() {
//     return Future.value(const UserEntity(
//         userId: "1", name: "", username: "", email: "", password: ""));
//   }

//   @override
//   Future<String> loginUser(String username, String password) async {
//     try {
//       await _hiveService.login(username, password);
//       return Future.value("Success");
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<void> registerUser(UserEntity user) async {
//     try {
//       // Convert AuthEntity to UserHiveModel
//       final userHiveModel = UserHiveModel.fromEntity(user);

//       await _hiveService.register(userHiveModel);
//       return Future.value();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }
