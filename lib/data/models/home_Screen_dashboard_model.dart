import 'package:json_annotation/json_annotation.dart';

part 'home_Screen_dashboard_model.g.dart';

@JsonSerializable()
class HomeScreenDashboardModel {
  HomeScreenDashboardModel({
    required this.status,
    required this.acceptance,
    required this.decline,
    this.todaysEarning = 0,
    this.capital = 0,
    this.driverStatus,
  });

  static const statusOnline = 'online';
  static const statusOffline = 'offline';

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'acceptance')
  int acceptance;
  @JsonKey(name: 'decline')
  int decline;
  @JsonKey(ignore: true)
  double todaysEarning;
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
    dynamic todaysEarning = json['todaysEarning'];
    if (todaysEarning is String) {
      model.todaysEarning = double.parse(todaysEarning);
    } else if (todaysEarning is int) {
      model.todaysEarning = todaysEarning.toDouble();
    }
    return model;
  }

  Map<String, dynamic> toJson() => _$HomeScreenDashboardModelToJson(this);
}
