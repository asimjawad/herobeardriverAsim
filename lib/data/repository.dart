import 'dart:io';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/api_client.dart';
import 'package:hero_bear_driver/data/closable.dart';
import 'package:hero_bear_driver/data/firebase_db_client.dart';
import 'package:hero_bear_driver/data/firebase_messaging_client.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/diamonds_model/diamonds_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/online_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/shared_pref_client.dart';

import 'models/get_reason_model/get_reason_model.dart';
import 'models/order_details_model/order_details_model.dart';

class Repository implements Closable {
  final _apiClient = ApiClient();
  final _firebaseMsgClient = FirebaseMessagingClient();
  final _sharedPrefClient = SharedPrefClient();
  final _firebaseDbClient = FirebaseDbClient();
  final _geoFire = Geoflutterfire();

  @override
  void close() {
    _firebaseMsgClient.close();
  }

  Future<String> get _deviceToken async {
    final token = await _sharedPrefClient.getDeviceToken();
    return token ??
        await FirebaseMessagingClient.getDeviceToken() ??
        'no_token_could_be_generated';
  }

  Future<UserLoginModel> logIn({
    required String phoneNo,
    required String password,
  }) async {
    final token = await _deviceToken;
    final user = await _apiClient.logIn(
      phoneNo: phoneNo,
      password: password,
      deviceToken: token,
    );
    if (user.approved == UserLoginModel.sApproved) {
      await _sharedPrefClient.setUser(user);
    }
    return user;
  }

  Future<void> initFirebaseMessaging() => FirebaseMessagingClient.initialize();

  void listenNotifications() => _firebaseMsgClient.listenNotifications();

  Future<UserLoginModel?> getUser() => _sharedPrefClient.getUser();

  Future<void> clearSharedPref() => _sharedPrefClient.clearAll();

  Future<HomeScreenDashboardModel> getHomeData(int userId) =>
      _apiClient.getHomeData(userId);

  Future<CommissionModel> getCommissionData(int userId) =>
      _apiClient.getCommissionData(userId);

  Future<EarningModel> getDriverEarningHistory(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final earningHistory = await _apiClient.getDriverEarningHistory(
      userId,
      startDate,
      endDate,
    );
    return earningHistory;
  }

  Future<bool> setCapital(
    int userId,
    double capital,
  ) async {
    var response = await _apiClient.setCapital(userId, capital);
    return response;
  }

  Future<bool> submitPayment(
    int userId, {
    required String payoutAmount,
    required String transactionId,
  }) async {
    final response = await _apiClient.submitPayment(
      userId,
      payoutAmount: payoutAmount,
      transactionId: transactionId,
    );
    return response;
  }

  Future<void> setUserOnline(int userId, LatLng latLng) async {
    await _apiClient.setDriverOnline(
      driverId: userId,
      deviceToken: await _deviceToken,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );
    await _firebaseDbClient.setUserOnline(
        userId,
        OnlineModel(
          g: _geoFire
              .point(
                latitude: latLng.latitude,
                longitude: latLng.longitude,
              )
              .hash,
          l: [
            latLng.latitude,
            latLng.longitude,
          ],
        ));
  }

  Future<void> setUserOffline(int userId) async {
    await _apiClient.setDriverOffline(userId);
    await _firebaseDbClient.setUserOffline(userId);
  }

  Future<OrderDetailsModel> orderRequest({required int driverId}) async {
    final response = await _apiClient.orderRequest(driverId: driverId);
    return response;
  }

  // get Driver Reviews
  Future<DriverReviewsModel> getDriverReviews(int userId) =>
      _apiClient.getDriverReviews(userId);

  // Get Diamonds
  Future<DiamondsModel> getDiamonds(int userId) =>
      _apiClient.getDiamonds(userId);

  // Request Diamond
  Future<bool> requestDiamond(
    int userId, {
    required String diamond,
  }) async {
    final response = await _apiClient.requestDiamond(userId, diamond: diamond);
    return response;
  }

  Future<void> changePassword({
    required String phoneNo,
    required String password,
  }) =>
      _apiClient.changePassword(
        phoneNo: phoneNo,
        password: password,
      );

  Future<bool> editProfile({
    required int driverId,
    required String name,
    required String email,
    File? image,
  }) =>
      _apiClient.editProfile(
          driverId: driverId, name: name, email: email, image: image);

  // get reasons
  Future<GetReasonModel> getReason() async {
    final response = await _apiClient.getReason();
    return response;
  }

  //set order status
  Future<void> setOrderAcceptedStatus(bool res) async {
    await _sharedPrefClient.setOrderAcceptedStatus(res);
  }

  // get order status
  Future<bool?> getOrderAcceptedStatus() async {
    return await _sharedPrefClient.getOrderAcceptedStatus();
  }

  //set order delivery status
  Future<void> setOrderDeliveryStatus(bool res) async {
    await _sharedPrefClient.setOrderDeliveryStatus(res);
  }

  // get order delivery status
  Future<bool?> getOrderDeliveryStatus() async {
    return await _sharedPrefClient.getOrderDeliveryStatus();
  }

  //order accept
  Future<bool> orderAcceptByDriver(
      {required int driverId,
      required String orderNo,
      // required File image,
      required int status}) async {
    return await _apiClient.orderAcceptByDriver(
        driverId: driverId, orderNo: orderNo, status: status);
  }

  // accept order from restaurant
  Future<bool> orderPickedFromRestaurant(
      {required int driverId,
      required String orderNo,
      required File image,
      required int status}) async {
    return await _apiClient.orderPickedFromRestaurant(
        driverId: driverId, orderNo: orderNo, image: image, status: status);
  }

  //order complete by driver
  Future<bool> orderCompleteByDriver(
      {required int driverId,
      required String orderNo,
      required File image,
      required int userId}) async {
    return await _apiClient.orderCompleteByDriver(
        driverId: driverId, orderNo: orderNo, image: image, userId: userId);
  }

  // reject the order
  Future<bool> rejectOrderRequest({
    required String orderNo,
    required String reason,
    required int status,
    required String driverId,
  }) async {
    return await _apiClient.rejectOrderRequest(
        orderNo: orderNo, reason: reason, status: status, driverId: driverId);
  }
}
