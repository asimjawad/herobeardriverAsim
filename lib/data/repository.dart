import 'package:hero_bear_driver/data/api_client.dart';
import 'package:hero_bear_driver/data/closable.dart';
import 'package:hero_bear_driver/data/firebase_db_client.dart';
import 'package:hero_bear_driver/data/firebase_messaging_client.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/online_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/shared_pref_client.dart';

class Repository implements Closable {
  final _apiClient = ApiClient();
  final _firebaseMsgClient = FirebaseMessagingClient();
  final _sharedPrefClient = SharedPrefClient();
  final _firebaseDbClient = FirebaseDbClient();

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
    await _sharedPrefClient.setUser(user);
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

  Future<DriverReviewsModel> getDriverReviews(int userId) =>
      _apiClient.getDriverReviews(userId);

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

  Future<void> setUserOnline(int userId, OnlineModel model) async {
    await _apiClient.setDriverOnline(
      driverId: userId,
      deviceToken: await _deviceToken,
      latitude: model.l[0],
      longitude: model.l[1],
    );
    await _firebaseDbClient.setUserOnline(userId, model);
  }

  Future<void> setUserOffline(int userId) async {
    await _apiClient.setDriverOffline(userId);
    await _firebaseDbClient.setUserOffline(userId);
  }
}
