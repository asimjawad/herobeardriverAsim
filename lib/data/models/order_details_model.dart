import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';

@JsonSerializable()
class OrderDetailsModel {
  OrderDetailsModel({
    required this.status,
    this.orderNos,
    this.data,
    required this.count,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'orderNos')
  List<String>? orderNos;
  @JsonKey(name: 'data')
  OrderDetailsData? data;
  @JsonKey(name: 'count')
  int count;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);

}
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

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'user_id')
  String userId;
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
  @JsonKey(name: 'service_charges')
  String? serviceCharges;
  @JsonKey(name: 'delivery_charges')
  String deliveryCharges;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'tax')
  String tax;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'latitude')
  String latitude;
  @JsonKey(name: 'longitude')
  String longitude;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'min_order')
  String minOrder;
  @JsonKey(name: 'avg_delivery_time')
  String avgDeliveryTime;
  @JsonKey(name: 'avg_pickup_time')
  dynamic avgPickupTime;
  @JsonKey(name: 'delivery_range')
  dynamic deliveryRange;
  @JsonKey(name: 'polygone')
  String polygone;
  @JsonKey(name: 'admin_commission')
  String adminCommission;
  @JsonKey(name: 'approved')
  String approved;
  @JsonKey(name: 'delivery')
  String delivery;
  @JsonKey(name: 'vouchers')
  String vouchers;
  @JsonKey(name: 'deal')
  String deal;
  @JsonKey(name: 'is_open')
  String isOpen;
  @JsonKey(name: 'featured')
  String featured;
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
@JsonSerializable()
class OrderProductForOrderDetailsModel {
  OrderProductForOrderDetailsModel({
    required this.id,
    required this.productId,
    required this.qty,
    required this.product,
  });
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'qty')
  String qty;
  @JsonKey(name: 'productrequired ')
  ProductForOrderDetailsModel product;

  factory OrderProductForOrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderProductForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductForOrderDetailsModelToJson(this);
}
@JsonSerializable()
class ProductForOrderDetailsModel {
  ProductForOrderDetailsModel({
    required this.id,
    required this.name,
  });
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;

  factory ProductForOrderDetailsModel.fromJson(Map<String, dynamic> json) => _$ProductForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductForOrderDetailsModelToJson(this);
}
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
