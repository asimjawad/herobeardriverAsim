import 'package:json_annotation/json_annotation.dart';

part 'get_reason_model.g.dart';

@JsonSerializable()
class GetReasonModel {
  GetReasonModel({
    required this.status,
    required this.data,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'data')
  List<DataForGetReason> data;

  factory GetReasonModel.fromJson(Map<String, dynamic> json) => _$GetReasonModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetReasonModelToJson(this);
}
@JsonSerializable()
class DataForGetReason {
  DataForGetReason({
    required this.id,
    required this.reason,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id')
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