import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data_for_diamond_model.dart';

part 'diamonds_model.g.dart';

@JsonSerializable()
class DiamondsModel {
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'total', fromJson: JsonUtil.parseDouble)
  double total;
  @JsonKey(name: 'available')
  int available;
  @JsonKey(name: 'data')
  List<DataForDiamondModel>? data;

  DiamondsModel(
      {required this.status,
      required this.total,
      required this.available,
      this.data});

  factory DiamondsModel.fromJson(Map<String, dynamic> json) => _$DiamondsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiamondsModelToJson(this);
}