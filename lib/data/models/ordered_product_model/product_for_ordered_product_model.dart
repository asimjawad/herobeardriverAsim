import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_for_ordered_product_model.g.dart';

@JsonSerializable()
class ProductForOrderedProductModel {
  ProductForOrderedProductModel({
    required this.id,
    required this.categoryId,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.price,
    this.size,
    this.discountPrice,
    required this.description,
    required this.featured,
    required this.isFixed,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.qty,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'category_id')
  String categoryId;
  @JsonKey(name: 'restaurant_id', fromJson: JsonUtil.parseInt)
  int restaurantId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'price', fromJson: JsonUtil.parseDouble)
  double price;
  @JsonKey(name: 'size')
  dynamic size;
  @JsonKey(name: 'discount_price')
  dynamic discountPrice;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'featured')
  String featured;
  @JsonKey(name: 'isFixed')
  String isFixed;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'qty', fromJson: JsonUtil.parseInt)
  int qty;

  factory ProductForOrderedProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductForOrderedProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductForOrderedProductModelToJson(this);
}