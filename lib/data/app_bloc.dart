import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/diamonds_model/diamonds_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/data/models/order_details_model/order_details_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/repository.dart';
import 'package:hero_bear_driver/ui/values/strings.dart';
import 'package:rxdart/rxdart.dart';

import 'models/get_reason_model/get_reason_model.dart';

class AppBloc extends DisposableInterface {
  final _repository = Repository();
  UserLoginModel? _user;
  late OrderDetailsModel orderDetailsModel;
  late String message;
  final _subjectHomeData = BehaviorSubject<HomeScreenDashboardModel>();
  BehaviorSubject<OrderDetailsModel> _orderDetailsSubject = BehaviorSubject();
  LocationModel? _locationModel;

  Future<LocationModel> get location async {
    /*  // todo: replace with real location
    return LocationModel(
      latLng: LatLng(31.4643699, 74.2414676),
    );*/
    if (_locationModel != null) {
      return _locationModel!;
    } else {
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _locationModel =
          LocationModel(latLng: LatLng(location.latitude, location.longitude));
      return _locationModel!;
    }
  }

  Future<UserLoginModel> get user async {
    final user = _user ?? await _repository.getUser();
    if (user != null) {
      return user;
    }
    throw (Exception('User not logged in!'));
  }

  @override
  void onInit() {
    _repository.initFirebaseMessaging();
    _repository.listenNotifications();
    super.onInit();
  }

  @override
  void onClose() => _repository.close();

  Future<bool> isUserLoggedIn() async => await _repository.getUser() != null;

  Future<UserLoginModel> logIn({
    required String phoneNo,
    required String password,
  }) async {
    final user = await _repository.logIn(
      phoneNo: phoneNo,
      password: password,
    );
    _user = user;
    return user;
  }

  Future<void> logOut() => _repository.clearSharedPref();

  Stream<HomeScreenDashboardModel> getHomeDataSteam() {
    if (!_subjectHomeData.hasValue) {
      _updateHomeDataStream();
    }
    return _subjectHomeData.stream;
  }

  Future<CommissionModel> getCommissionData() async {
    final user = await this.user;
    return _repository.getCommissionData(user.userId);
  }

  Future<EarningModel> getDriverEarningHistory(DateTime startDate,
      DateTime endDate,) async {
    final user = await this.user;
    final earningHistory = await _repository.getDriverEarningHistory(
        user.userId, startDate, endDate);
    return earningHistory;
  }

  Future<String> setCapital(
    double capital,
  ) async {
    final user = await this.user;
    var response = await _repository.setCapital(user.userId, capital);
    if (response == true) {
      message = Strings.msgSuccessCapitalUpdate;
      _updateHomeDataStream();
    } else {
      message = Strings.msgFailCapitalUpdate;
    }
    return message;
  }

  Future<String> submitPayment({
    required String payoutAmount,
    required String transactionId,
  }) async {
    final user = await this.user;
    final response = await _repository.submitPayment(
      user.userId,
      payoutAmount: payoutAmount,
      transactionId: transactionId,
    );
    if (response == true) {
      message = Strings.msgSuccessPaymentRequest;
    } else {
      message = Strings.msgFailPaymentRequest;
    }
    return message;
  }

  Future<void> setUserOnline() async {
    final user = await this.user;
    final location = await this.location;
    await _repository.setUserOnline(
      user.userId,
      location.latLng,
    );
    _updateHomeDataStream();
  }

  Future<void> setUserOffline() async {
    final user = await this.user;
    await _repository.setUserOffline(user.userId);
    _updateHomeDataStream();
  }

  Future<OrderDetailsModel> orderRequest() async {
    final user = await this.user;
    final response = await _repository.orderRequest(driverId: user.userId);
    return response;
  }

  Future<void> fetchOrderRequestData() async {
    final user = await this.user;
    final response = await _repository.orderRequest(driverId: user.userId);
    orderDetailsModel = response;
  }

  void refreshUserData() async {
    final user = await this.user;
    _orderDetailsSubject
        .add(await _repository.orderRequest(driverId: user.userId));
  }

  Stream<OrderDetailsModel> getUserDataStream() {
    if (_orderDetailsSubject.valueWrapper == null) {
      () async {
        final user = await this.user;
        // just copied someone's  pride (-v-)
        try {
          _orderDetailsSubject
              .add(await _repository.orderRequest(driverId: user.userId));
        } catch (e) {
          _orderDetailsSubject.addError(e);
        }
      }.call();
    }
    return _orderDetailsSubject.stream;
  }

  // get driver Reviews
  Future<DriverReviewsModel> getDriverReviews() async {
    final user = await this.user;
    return _repository.getDriverReviews(user.userId);
  }

  // Get Diamonds
  Future<DiamondsModel> getDiamonds() async {
    final user = await this.user;
    return _repository.getDiamonds(user.userId);
  }

  //Request Diamonds
  Future<String> requestDiamond({
    required String diamond,
  }) async {
    final user = await this.user;
    final response =
        await _repository.requestDiamond(user.userId, diamond: diamond);
    if (response == true) {
      message = Strings.msgSuccessDiamondRequest;
    } else {
      message = Strings.msgFailDiamondRequest;
    }
    return message;
  }

  Future<void> changePassword({
    required String phoneNo,
    required String password,
  }) =>
      _repository.changePassword(
        phoneNo: phoneNo,
        password: password,
      );

  Future<bool> editProfile({
    required String name,
    required String email,
    File? image,
  }) async {
    final user = await this.user;
    return await _repository.editProfile(
        driverId: user.userId, name: name, email: email, image: image);
  }

  void _updateHomeDataStream() async {
    final user = await this.user;
    _subjectHomeData.add(await _repository.getHomeData(user.userId));
  }

  // get reasons
  Future<GetReasonModel> getReason() async {
    final response = await _repository.getReason();
    return response;
  }

  //set order status
  Future<void> setOrderAcceptedStatus(bool res) async {
    await _repository.setOrderAcceptedStatus(res);
  }

  // get order status
  Future<bool?> getOrderAcceptedStatus() async {
    return await _repository.getOrderAcceptedStatus();
  }

  //set order status
  Future<void> setOrderDeliveryStatus(bool res) async {
    await _repository.setOrderDeliveryStatus(res);
  }

  // get order status
  Future<bool?> getOrderDeliveryStatus() async {
    return await _repository.getOrderDeliveryStatus();
  }

  //order accept
  Future<bool> orderAcceptByDriver(
      {required String orderNo,
      // required File image,
      required int status}) async {
    final user = await this.user;
    return await _repository.orderAcceptByDriver(
        driverId: user.userId, orderNo: orderNo, status: status);
  }

  // accept order from restaurant
  Future<bool> orderPickedFromRestaurant(
      {required String orderNo,
      required File image,
      required int status}) async {
    final user = await this.user;
    return await _repository.orderPickedFromRestaurant(
        driverId: user.userId, orderNo: orderNo, image: image, status: status);
  }

  //order complete by driver
  Future<bool> orderCompleteByDriver(
      {required String orderNo,
      required File image,
      required int userId}) async {
    final user = await this.user;
    return await _repository.orderCompleteByDriver(
        driverId: user.userId, orderNo: orderNo, image: image, userId: userId);
  }

  // reject the order
  Future<bool> rejectOrderRequest({
    required String orderNo,
    required String reason,
    required int status,
  }) async {
    final user = await this.user;
    return await _repository.rejectOrderRequest(
        orderNo: orderNo,
        reason: reason,
        status: status,
        driverId: user.userId.toString());
  }

  // update the user current location

  Future<void> updateUserCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _locationModel =
        LocationModel(latLng: LatLng(location.latitude, location.longitude));
  }
}
