import 'package:json_annotation/json_annotation.dart';

part 'user_for_order_details_model.g.dart';

@JsonSerializable()
class UserForOrderDetailsModel {
  UserForOrderDetailsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.deviceToken,
    required this.image,
    required this.phone,
    required this.blocked,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'device_token')
  String deviceToken;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'blocked')
  String blocked;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory UserForOrderDetailsModel.fromJson(Map<String, dynamic> json) => _$UserForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserForOrderDetailsModelToJson(this);
}