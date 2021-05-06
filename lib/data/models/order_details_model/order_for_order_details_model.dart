import 'package:hero_bear_driver/data/models/order_details_model/user_for_order_details_model.dart';
import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_product_for_order_details_model.dart';

part 'order_for_order_details_model.g.dart';

@JsonSerializable()
class OrderForOrderDetailsModel {
  OrderForOrderDetailsModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.orderNo,
    required this.productId,
    required this.qty,
    required this.driverId,
    required this.offerDiscount,
    required this.tax,
    required this.deliveryCharges,
    required this.subTotal,
    required this.total,
    required this.driverTip,
    required this.status,
    required this.image,
    this.deliverImage,
    required this.deliveryAddress,
    this.scheduledDate,
    required this.dLat,
    required this.dLng,
    required this.orderedTime,
    required this.preparingTime,
    required this.deliveredTime,
    required this.createdAt,
    required this.updatedAt,
    required this.orderProduct,
    required this.user,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'user_id', fromJson: JsonUtil.parseInt)
  int userId;
  @JsonKey(name: 'restaurant_id', fromJson: JsonUtil.parseInt)
  int restaurantId;
  @JsonKey(name: 'order_no')
  String orderNo;
  @JsonKey(name: 'product_id', fromJson: JsonUtil.parseInt)
  int productId;
  @JsonKey(name: 'qty', fromJson: JsonUtil.parseInt)
  int qty;
  @JsonKey(name: 'driver_id', fromJson: JsonUtil.parseInt)
  int driverId;
  @JsonKey(name: 'offer_discount')
  double offerDiscount;
  @JsonKey(name: 'tax', fromJson: JsonUtil.parseDouble)
  double tax;
  @JsonKey(name: 'delivery_charges', fromJson: JsonUtil.parseDouble)
  double deliveryCharges;
  @JsonKey(name: 'sub_total', fromJson: JsonUtil.parseDouble)
  double subTotal;
  @JsonKey(name: 'total', fromJson: JsonUtil.parseDouble)
  double total;
  @JsonKey(name: 'admin_commission', fromJson: JsonUtil.parseDouble)
  double driverTip;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'deliver_image')
  dynamic deliverImage;
  @JsonKey(name: 'delivery_address')
  String deliveryAddress;
  @JsonKey(name: 'scheduled_date')
  DateTime? scheduledDate;
  @JsonKey(name: 'd_lat', fromJson: JsonUtil.parseDouble)
  double dLat;
  @JsonKey(name: 'd_lng', fromJson: JsonUtil.parseDouble)
  double dLng;
  @JsonKey(name: 'ordered_time')
  DateTime orderedTime;
  @JsonKey(name: 'preparing_time')
  DateTime preparingTime;
  @JsonKey(name: 'delivered_time')
  DateTime deliveredTime;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'order_product')
  List<OrderProductForOrderDetailsModel> orderProduct;
  @JsonKey(name: 'user')
  UserForOrderDetailsModel user;

  factory OrderForOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderForOrderDetailsModelToJson(this);
}
