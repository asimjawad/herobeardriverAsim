import 'package:hero_bear_driver/util/json_util.dart';
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
  @JsonKey(name: 'acceptance', fromJson: JsonUtil.parseDouble)
  num acceptance;
  @JsonKey(name: 'decline', fromJson: JsonUtil.parseDouble)
  num decline;
  @JsonKey(name: 'todaysEarning', fromJson: JsonUtil.parseDouble)
  double todaysEarning;
  @JsonKey(name: 'capital', fromJson: JsonUtil.parseDouble)
  double capital;
  @JsonKey(name: 'driver_status')
  String? driverStatus;

  factory HomeScreenDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$HomeScreenDashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeScreenDashboardModelToJson(this);
}
