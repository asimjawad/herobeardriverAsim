import 'package:hero_bear_driver/data/models/driver_reviews_model/review_for_driver_reviews_model.dart';
import 'package:hero_bear_driver/util/json_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_for_driver_reviews_model.g.dart';

@JsonSerializable()
class DataForDriverReviewsModel {
  DataForDriverReviewsModel({
    required this.id,
    required this.name,
    required this.phone,
    this.restaurantId,
    required this.email,
    required this.vehicleType,
    required this.dateOfBirth,
    required this.postCode,
    required this.image,
    required this.licenceImage,
    this.licenceImageBack,
    required this.password,
    required this.wallet,
    required this.capital,
    required this.diamond,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.deviceToken,
    required this.accountName,
    required this.accountAddress,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.branchAddress,
    required this.approved,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.reviews,
  });

  @JsonKey(name: 'id', fromJson: JsonUtil.parseInt)
  int id;
  @JsonKey(name: 'restaurant_id', fromJson: JsonUtil.tryParseInt)
  int? restaurantId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'vehicle_type')
  String vehicleType;
  @JsonKey(name: 'date_of_birth')
  String dateOfBirth;
  @JsonKey(name: 'post_code')
  String postCode;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'licence_image')
  String licenceImage;
  @JsonKey(name: 'licence_image_back')
  String? licenceImageBack;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'wallet')
  String wallet;
  @JsonKey(name: 'capital', fromJson: JsonUtil.parseDouble)
  double capital;
  @JsonKey(name: 'diamond')
  String diamond;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'latitude', fromJson: JsonUtil.parseDouble)
  double latitude;
  @JsonKey(name: 'longitude', fromJson: JsonUtil.parseDouble)
  double longitude;
  @JsonKey(name: 'device_token')
  String deviceToken;
  @JsonKey(name: 'account_name')
  String accountName;
  @JsonKey(name: 'account_address')
  String accountAddress;
  @JsonKey(name: 'account_number')
  String accountNumber;
  @JsonKey(name: 'bank_name')
  String bankName;
  @JsonKey(name: 'branch_name')
  String branchName;
  @JsonKey(name: 'branch_address')
  String branchAddress;
  @JsonKey(name: 'approved', fromJson: JsonUtil.parseInt)
  int approved;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'reviews')
  List<ReviewForDriverReviewsModel> reviews;

  factory DataForDriverReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$DataForDriverReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataForDriverReviewsModelToJson(this);
}
