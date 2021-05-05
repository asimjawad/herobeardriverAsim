import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_for_get_reason_model.g.dart';

@JsonSerializable()
class DataForGetReason {
  DataForGetReason({
    required this.id,
    required this.reason,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'reason')
  String reason;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory DataForGetReason.fromJson(Map<String, dynamic> json) => _$DataForGetReasonFromJson(json);

  Map<String, dynamic> toJson() => _$DataForGetReasonToJson(this);
}