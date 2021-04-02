import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.image,
    required this.approved,
    required this.status,
    required this.statusCode,
    required this.message,
  });
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'approved')
  String approved;
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'status_code')
  int statusCode;
  @JsonKey(name: 'message')
  String message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}