import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String teamname;
  final String email;
  final String? image;
  final String? password;
  final String? confrimpassword;

  const AuthApiModel({
    this.id,
    required this.teamname,
    required this.email,
    required this.image,
    required this.password,
    required this.confrimpassword,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      teamId: id,
      teamName: teamname,
      email: email,
      image: image,
      password: password ?? '',
      confirmPassword: confrimpassword ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      teamname: entity.teamName,
      email: entity.email,
      image: entity.image,
      password: entity.password,
      confrimpassword: entity.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [id, teamname, email, image, password];
}
