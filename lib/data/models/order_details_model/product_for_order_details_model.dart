import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_for_order_details_model.g.dart';

@JsonSerializable()
class ProductForOrderDetailsModel {
  ProductForOrderDetailsModel({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'name')
  String name;

  factory ProductForOrderDetailsModel.fromJson(Map<String, dynamic> json) => _$ProductForOrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductForOrderDetailsModelToJson(this);
}