import 'package:json_annotation/json_annotation.dart';

part 'home_Screen_dashboard_model.g.dart';

@JsonSerializable()
class HomeScreenDashboardModel {
  HomeScreenDashboardModel({
    required this.status,
    required this.acceptance,
    required this.decline,
    required this.todaysEarning,
    required this.capital,
    this.driverStatus,
  });
  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'acceptance')
  int acceptance;
  @JsonKey(name: 'decline')
  int decline;
  @JsonKey(name: 'todaysEarning')
  String todaysEarning;
  @JsonKey(name: 'capital')
  String capital;
  @JsonKey(name: 'driver_status')
  String? driverStatus;

  factory HomeScreenDashboardModel.fromJson(Map<String, dynamic> json) => _$HomeScreenDashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeScreenDashboardModelToJson(this);
}
