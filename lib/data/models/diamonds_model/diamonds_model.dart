import 'package:json_annotation/json_annotation.dart';

part 'diamonds_model.g.dart';

@JsonSerializable()
class DiamondsModel {
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'available')
  int available;
  @JsonKey(name: 'data')
  List<Data>? data;

  DiamondsModel({
    required this.status,
    required this.total,
    required this.available,
    this.data
  });


  factory DiamondsModel.fromJson(Map<String, dynamic> json) => _$DiamondsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiamondsModelToJson(this);
}

@JsonSerializable()
class Data{
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

  Data({
    required this.id,
    required this.driverId,
    required this.diamond,
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt
});


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}