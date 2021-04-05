import 'package:json_annotation/json_annotation.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  UserLoginModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.image,
    required this.approved,
    required this.status,
    required this.statusCode,
    required this.message,
  });

  static const sApproved = "1";

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

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}