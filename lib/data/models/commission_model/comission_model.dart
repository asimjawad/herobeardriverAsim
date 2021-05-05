import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'data_for_commission_model.dart';

part 'comission_model.g.dart';

@JsonSerializable()
class CommissionModel {
  CommissionModel({
    required this.status,
    this.totalCommission = 0,
    required this.paidCommissiom,
    required this.pendingCommission,
    this.data,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'totalCommission', fromJson: JsonUtil.parseDouble)
  double totalCommission;
  @JsonKey(name: 'paidCommissiom', fromJson: JsonUtil.parseDouble)
  double paidCommissiom;
  @JsonKey(name: 'pendingCommission', fromJson: JsonUtil.parseDouble)
  double pendingCommission;
  @JsonKey(name: 'data')
  List<DataForCommissionModel>? data;

  factory CommissionModel.fromJson(Map<String, dynamic> json) =>
      _$CommissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionModelToJson(this);
}
