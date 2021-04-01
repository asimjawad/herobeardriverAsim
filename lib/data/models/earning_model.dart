import 'package:json_annotation/json_annotation.dart';

part 'earning_model.g.dart';

@JsonSerializable()
class EarningModel {
  EarningModel({
    required this.status,
    required this.totalEarning,
    required this.adminEarning,
    required this.order,
    this.diamond,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'totalEarning')
  int totalEarning;
  @JsonKey(name: 'adminEarning')
  int adminEarning;
  @JsonKey(name: 'order')
  List<Order> order;
  @JsonKey(name: 'diamond')
  String? diamond;

  factory EarningModel.fromJson(Map<String, dynamic> json) => _$EarningModelFromJson(json);

  Map<String, dynamic> toJson() => _$EarningModelToJson(this);
}
@JsonSerializable()
class Order {
  Order({
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
  @JsonKey(name: 'earning')
  String earning;
  @JsonKey(name: 'delivery')
  DateTime delivery;
  @JsonKey(name: 'admin_earning')
  String adminEarning;
  @JsonKey(name: 'items')
  int items;
  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'lng')
  String lng;
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
  @JsonKey(name: 'restaurant_lat')
  String restaurantLat;
  @JsonKey(name: 'restaurant_lng')
  String restaurantLng;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
