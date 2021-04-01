import 'package:json_annotation/json_annotation.dart';

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
  Data data;
  @JsonKey(name: 'rating')
  String? rating;
  @JsonKey(name: 'trips')
  int trips;
  @JsonKey(name: 'BASE_URL_PROFILE')
  String baseUrlProfile;

  factory DriverReviewsModel.fromJson(Map<String, dynamic> json) => _$DriverReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverReviewsModelToJson(this);
}
@JsonSerializable()
class Data {
  Data({
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

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'restaurant_id')
  String? restaurantId;
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
  @JsonKey(name: 'capital')
  String capital;
  @JsonKey(name: 'diamond')
  String diamond;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'latitude')
  String latitude;
  @JsonKey(name: 'longitude')
  String longitude;
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
  @JsonKey(name: 'approved')
  String approved;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'reviews')
  List<Review> reviews;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Review {
  Review({
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
  });
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'rating')
  String rating;
  @JsonKey(name: 'reviews')
  String reviews;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}