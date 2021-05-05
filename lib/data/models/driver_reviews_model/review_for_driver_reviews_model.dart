import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_for_driver_reviews_model.g.dart';

@JsonSerializable()
class ReviewForDriverReviewsModel {
  ReviewForDriverReviewsModel({
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
  });

  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'rating', fromJson: JsonUtil.parseDouble)
  double rating;
  @JsonKey(name: 'reviews')
  String reviews;

  factory ReviewForDriverReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewForDriverReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewForDriverReviewsModelToJson(this);
}