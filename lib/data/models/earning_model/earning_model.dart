import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_for_earning_model.dart';

part 'earning_model.g.dart';

@JsonSerializable()
class EarningModel {
  EarningModel({
    required this.status,
    required this.totalEarning,
    required this.adminEarning,
    required this.order,
    this.diamond,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'totalEarning', fromJson: JsonUtil.parseDouble)
  double totalEarning;
  @JsonKey(name: 'adminEarning', fromJson: JsonUtil.parseDouble)
  double adminEarning;
  @JsonKey(name: 'order')
  List<OrderForEarningModel> order;
  @JsonKey(name: 'diamond')
  String? diamond;

  factory EarningModel.fromJson(Map<String, dynamic> json) =>
      _$EarningModelFromJson(json);

  Map<String, dynamic> toJson() => _$EarningModelToJson(this);
}
