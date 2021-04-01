import 'package:json_annotation/json_annotation.dart';

part 'comission_model.g.dart';

@JsonSerializable()
class CommissionModel {
  CommissionModel({
    required  this.status,
    this.totalCommission =0,
    required this.paidCommissiom,
    required this.pendingCommission,
    this.data,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(ignore: true)
  double totalCommission;
  @JsonKey(name: 'paidCommissiom')
  int paidCommissiom;
  @JsonKey(name: 'pendingCommission')
  int pendingCommission;
  @JsonKey(name: 'data')
  List<Data>? data;

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    dynamic tc = json["totalCommission"];
    final model = _$CommissionModelFromJson(json);
    if ( tc is int ){
      model.totalCommission = tc.toDouble();
    }
    else if(tc is String){
      model.totalCommission = double.parse(tc);
    }
    return model;
  }

  Map<String, dynamic> toJson() => _$CommissionModelToJson(this);
}
@JsonSerializable()
class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
