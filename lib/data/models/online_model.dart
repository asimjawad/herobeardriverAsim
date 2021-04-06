import 'package:json_annotation/json_annotation.dart';

part 'online_model.g.dart';

@JsonSerializable()
class OnlineModel {
  final String g;
  final List<double> l;

  OnlineModel({
    required this.g,
    required this.l,
  }) : assert(l.length == 2);

  factory OnlineModel.fromJson(Map<String, dynamic> json) =>
      _$OnlineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineModelToJson(this);
}
