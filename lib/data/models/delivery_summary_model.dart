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
  @JsonKey(name: 'tip')
  String tip;
  @JsonKey(name: 'total')
  int total;

  factory DeliverSummary.fromJson(Map<String, dynamic> json) => _$DeliverSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DeliverSummaryToJson(this);
}
