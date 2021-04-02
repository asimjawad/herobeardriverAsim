import 'package:json_annotation/json_annotation.dart';

import 'data_for_get_reason_model.dart';

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
