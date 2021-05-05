import 'package:hero_bear_driver/data/models/order_details_model/product_for_order_details_model.dart';
import 'package:hero_bear_driver/util/json_util.dart';
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

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'product_id', fromJson: JsonUtil.parseInt)
  int productId;
  @JsonKey(name: 'qty', fromJson: JsonUtil.parseInt)
  int qty;
  @JsonKey(name: 'product')
  ProductForOrderDetailsModel? product;

  factory OrderProductForOrderDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      _$OrderProductForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderProductForOrderDetailsModelToJson(this);
}
