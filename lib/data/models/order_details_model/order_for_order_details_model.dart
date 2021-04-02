import 'package:hero_bear_driver/data/models/order_details_model/user_for_order_details_model.dart';
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
    required this.adminCommission,
    required this.restaurantCommission,
    required this.driverTip,
    required this.status,
    required this.image,
    this.deliverImage,
    required this.deliveryAddress,
    required this.scheduledDate,
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

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'restaurant_id')
  String restaurantId;
  @JsonKey(name: 'order_no')
  String orderNo;
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'qty')
  String qty;
  @JsonKey(name: 'driver_id')
  String driverId;
  @JsonKey(name: 'offer_discount')
  String offerDiscount;
  @JsonKey(name: 'tax')
  String tax;
  @JsonKey(name: 'delivery_charges')
  String deliveryCharges;
  @JsonKey(name: 'sub_total')
  String subTotal;
  @JsonKey(name: 'total')
  String total;
  @JsonKey(name: 'admin_commission')
  String adminCommission;
  @JsonKey(name: 'restaurant_commission')
  String restaurantCommission;
  @JsonKey(name: 'driver_tip')
  String driverTip;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'deliver_image')
  dynamic deliverImage;
  @JsonKey(name: 'delivery_address')
  String deliveryAddress;
  @JsonKey(name: 'scheduled_date')
  DateTime scheduledDate;
  @JsonKey(name: 'd_lat')
  String dLat;
  @JsonKey(name: 'd_lng')
  String dLng;
  @JsonKey(name: 'ordered_time')
  DateTime orderedTime;
  @JsonKey(name: 'preparing_time')
  DateTime preparingTime;
  @JsonKey(name: 'delivered_time')
  DateTime deliveredTime;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'order_product')
  List<OrderProductForOrderDetailsModel> orderProduct;
  @JsonKey(name: 'user')
  UserForOrderDetailsModel user;

  factory OrderForOrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderForOrderDetailsModelToJson(this);
}
