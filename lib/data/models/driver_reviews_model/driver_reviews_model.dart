import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data_for_driver_reviews_model.dart';

part 'driver_reviews_model.g.dart';

@JsonSerializable()
class DriverReviewsModel {
  DriverReviewsModel({
    required this.status,
    required this.data,
    this.rating,
    required this.trips,
    required this.baseUrlProfile,
  });

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'data')
  DataForDriverReviewsModel data;
  @JsonKey(name: 'rating', fromJson: JsonUtil.tryParseDouble)
  double? rating;
  @JsonKey(name: 'trips', fromJson: JsonUtil.parseInt)
  int trips;
  @JsonKey(name: 'BASE_URL_PROFILE')
  String baseUrlProfile;

  factory DriverReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$DriverReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverReviewsModelToJson(this);
}

