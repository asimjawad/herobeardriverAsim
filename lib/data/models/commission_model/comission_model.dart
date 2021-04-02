import 'package:json_annotation/json_annotation.dart';
import 'data_for_commission_model.dart';

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
  List<DataForCommissionModel>? data;

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    dynamic tc = json['totalCommission'];
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