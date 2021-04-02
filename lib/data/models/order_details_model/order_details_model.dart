import 'package:json_annotation/json_annotation.dart';

import 'order_details_data.dart';

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
