import 'package:json_annotation/json_annotation.dart';

part 'home_Screen_dashboard_model.g.dart';

@JsonSerializable()
class HomeScreenDashboardModel {
  HomeScreenDashboardModel({
    required this.status,
    required this.acceptance,
    required this.decline,
    required this.todaysEarning,
    this.capital = 0,
    this.driverStatus,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'acceptance')
  int acceptance;
  @JsonKey(name: 'decline')
  int decline;
  @JsonKey(name: 'todaysEarning')
  int todaysEarning;
  @JsonKey(ignore: true)
  double capital;
  @JsonKey(name: 'driver_status')
  String? driverStatus;

  factory HomeScreenDashboardModel.fromJson(Map<String, dynamic> json) {
    final model = _$HomeScreenDashboardModelFromJson(json);
    dynamic capital = json['capital'];
    if (capital is String) {
      model.capital = double.parse(capital);
    } else if (capital is int) {
      model.capital = capital.toDouble();
    }
    return model;
  }

  Map<String, dynamic> toJson() => _$HomeScreenDashboardModelToJson(this);
}
