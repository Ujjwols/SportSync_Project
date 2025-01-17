import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.teamTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String teamName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String confirmPassword;

  AuthHiveModel({
    String? userId,
    required this.teamName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  }) : userId = userId ?? const Uuid().v4();

  /// Default empty constructor with initial values.
  const AuthHiveModel.initial()
      : userId = '',
        teamName = '',
        email = '',
        password = '',
        confirmPassword = '';

  /// Converts an AuthEntity into AuthHiveModel
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.teamId,
      teamName: entity.teamName,
      email: entity.email,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  /// Converts the AuthHiveModel into AuthEntity.
  AuthEntity toEntity() {
    return AuthEntity(
      teamId: userId,
      teamName: teamName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        teamName,
        email,
        password,
        confirmPassword,
      ];
}
