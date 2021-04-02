import 'package:json_annotation/json_annotation.dart';

part 'data_for_diamond_model.g.dart';

@JsonSerializable()
class DataForDiamondModel{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'driver_id')
  int driverId;
  @JsonKey(name: 'diamond')
  int diamond;
  @JsonKey(name: 'transaction_id')
  String transactionId;
  @JsonKey(name: 'amount')
  int amount;
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  DataForDiamondModel({
    required this.id,
    required this.driverId,
    required this.diamond,
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });


  factory DataForDiamondModel.fromJson(Map<String, dynamic> json) => _$DataForDiamondModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataForDiamondModelToJson(this);
}