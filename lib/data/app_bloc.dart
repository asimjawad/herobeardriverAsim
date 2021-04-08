import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/diamonds_model/diamonds_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/repository.dart';
import 'package:hero_bear_driver/ui/values/strings.dart';

class AppBloc extends DisposableInterface {
  final _repository = Repository();
  UserLoginModel? _user;
  late String message;

  Future<LocationModel> get location async {
    // todo: replace with real location
    return LocationModel(
      latLng: LatLng(31.4643699, 74.2414676),
    );
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

  Future<void> logOut() => _repository.clearUser();

  Future<HomeScreenDashboardModel> getHomeData() async {
    final user = await this.user;
    return _repository.getHomeData(user.userId);
  }

  Future<CommissionModel> getCommissionData() async {
    final user = await this.user;
    return _repository.getCommissionData(user.userId);
  }

  Future<EarningModel> getDriverEarningHistory(
    DateTime startDate,
    DateTime endDate,
  ) async {
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
}
