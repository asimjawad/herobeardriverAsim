import 'package:hero_bear_driver/data/models/order_details_model/product_for_order_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_product_for_order_details_model.g.dart';

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
