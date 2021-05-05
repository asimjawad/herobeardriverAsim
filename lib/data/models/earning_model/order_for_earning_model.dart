import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_for_earning_model.g.dart';

@JsonSerializable()
class OrderForEarningModel {
  OrderForEarningModel({
    required this.orderNo,
    required this.earning,
    required this.delivery,
    required this.adminEarning,
    required this.items,
    required this.lat,
    required this.lng,
    required this.deliveryAddress,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantLat,
    required this.restaurantLng,
  });

  @JsonKey(name: 'order_no')
  String orderNo;
  @JsonKey(name: 'earning', fromJson: JsonUtil.parseDouble)
  double earning;
  @JsonKey(name: 'delivery')
  DateTime delivery;
  @JsonKey(name: 'admin_earning', fromJson: JsonUtil.parseDouble)
  double adminEarning;
  @JsonKey(name: 'items')
  int items;
  @JsonKey(name: 'lat', fromJson: JsonUtil.parseDouble)
  double lat;
  @JsonKey(name: 'lng', fromJson: JsonUtil.parseDouble)
  double lng;
  @JsonKey(name: 'delivery_address')
  String deliveryAddress;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'user_email')
  String userEmail;
  @JsonKey(name: 'user_phone')
  String userPhone;
  @JsonKey(name: 'restaurant_name')
  String restaurantName;
  @JsonKey(name: 'restaurant_address')
  String restaurantAddress;
  @JsonKey(name: 'restaurant_lat', fromJson: JsonUtil.parseDouble)
  double restaurantLat;
  @JsonKey(name: 'restaurant_lng', fromJson: JsonUtil.parseDouble)
  double restaurantLng;

  factory OrderForEarningModel.fromJson(Map<String, dynamic> json) =>
      _$OrderForEarningModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderForEarningModelToJson(this);
}
