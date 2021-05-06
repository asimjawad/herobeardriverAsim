import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_for_order_details_model.dart';

part 'order_details_data.g.dart';


@JsonSerializable()
class OrderDetailsData {
  OrderDetailsData({
    required this.id,
    required this.userId,
    required this.name,
    required this.userName,
    required this.slug,
    required this.email,
    required this.password,
    required this.slogan,
    required this.logo,
    required this.coverImage,
    required this.services,
    this.serviceCharges,
    required this.deliveryCharges,
    required this.city,
    required this.tax,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.description,
    required this.minOrder,
    required this.avgDeliveryTime,
    this.avgPickupTime,
    this.deliveryRange,
    required this.polygone,
    required this.adminCommission,
    required this.approved,
    required this.delivery,
    required this.vouchers,
    required this.deal,
    required this.isOpen,
    required this.featured,
    this.keywords,
    required this.accountName,
    required this.accountNumber,
    this.bankName,
    this.swiftCode,
    required this.routing,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'user_id', fromJson: JsonUtil.parseInt)
  int userId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'slug')
  String slug;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'slogan')
  String slogan;
  @JsonKey(name: 'logo')
  String logo;
  @JsonKey(name: 'cover_image')
  String coverImage;
  @JsonKey(name: 'services')
  String services;
  @JsonKey(name: 'service_charges', fromJson: JsonUtil.tryParseDouble)
  double? serviceCharges;
  @JsonKey(name: 'delivery_charges', fromJson: JsonUtil.parseDouble)
  double deliveryCharges;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'tax', fromJson: JsonUtil.parseDouble)
  double tax;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'latitude', fromJson: JsonUtil.parseDouble)
  double latitude;
  @JsonKey(name: 'longitude', fromJson: JsonUtil.parseDouble)
  double longitude;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'min_order', fromJson: JsonUtil.parseDouble)
  double minOrder;
  @JsonKey(name: 'avg_delivery_time', fromJson: JsonUtil.forceString)
  String avgDeliveryTime;
  @JsonKey(name: 'avg_pickup_time')
  dynamic avgPickupTime;
  @JsonKey(name: 'delivery_range')
  dynamic deliveryRange;
  @JsonKey(name: 'polygone')
  String polygone;
  @JsonKey(name: 'admin_commission', fromJson: JsonUtil.parseDouble)
  double adminCommission;
  @JsonKey(name: 'approved', fromJson: JsonUtil.parseInt)
  int approved;
  @JsonKey(name: 'delivery')
  String delivery;
  @JsonKey(name: 'vouchers')
  String vouchers;
  @JsonKey(name: 'deal')
  String deal;
  @JsonKey(name: 'is_open', fromJson: JsonUtil.parseInt)
  int isOpen;
  @JsonKey(name: 'featured', fromJson: JsonUtil.parseInt)
  int featured;
  @JsonKey(name: 'keywords')
  dynamic keywords;
  @JsonKey(name: 'account_name')
  String accountName;
  @JsonKey(name: 'account_number')
  String accountNumber;
  @JsonKey(name: 'bank_name')
  dynamic bankName;
  @JsonKey(name: 'swift_code')
  dynamic swiftCode;
  @JsonKey(name: 'routing')
  dynamic routing;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'orders')
  List<OrderForOrderDetailsModel> orders;


  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => _$OrderDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsDataToJson(this);
}