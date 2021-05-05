import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_summary_model.g.dart';

@JsonSerializable()
class DeliverSummary {
  DeliverSummary({
    required this.status,
    required this.base,
    required this.tip,
    required this.total,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'base')
  String base;
  @JsonKey(name: 'tip', fromJson: JsonUtil.parseDouble)
  double tip;
  @JsonKey(name: 'total', fromJson: JsonUtil.parseDouble)
  double total;

  factory DeliverSummary.fromJson(Map<String, dynamic> json) =>
      _$DeliverSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DeliverSummaryToJson(this);
}
