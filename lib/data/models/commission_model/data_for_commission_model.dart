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

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'driver_id')
  String driverId;
  @JsonKey(name: 'payout_amount')
  String payoutAmount;
  @JsonKey(name: 'transaction_id')
  String transactionId;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory DataForCommissionModel.fromJson(Map<String, dynamic> json) => _$DataForCommissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataForCommissionModelToJson(this);
}
