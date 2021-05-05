import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_for_commission_model.g.dart';

@JsonSerializable()
class DataForCommissionModel
{
  DataForCommissionModel({
    required this.id,
    required this.driverId,
    required this.payoutAmount,
    required this.transactionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'driver_id', fromJson: JsonUtil.parseInt)
  int driverId;
  @JsonKey(name: 'payout_amount', fromJson: JsonUtil.parseDouble)
  double payoutAmount;
  @JsonKey(name: 'transaction_id', fromJson: JsonUtil.parseInt)
  int transactionId;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory DataForCommissionModel.fromJson(Map<String, dynamic> json) =>
      _$DataForCommissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataForCommissionModelToJson(this);
}
