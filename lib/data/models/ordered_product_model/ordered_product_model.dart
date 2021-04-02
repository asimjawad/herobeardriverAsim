import 'package:hero_bear_driver/data/models/ordered_product_model/product_for_ordered_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ordered_product_model.g.dart';

@JsonSerializable()
class OrderedProductModel {
  OrderedProductModel({
    required this.status,
    required this.products,
  });
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'products')
  List<ProductForOrderedProductModel> products;

  factory OrderedProductModel.fromJson(Map<String, dynamic> json) => _$OrderedProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedProductModelToJson(this);
}