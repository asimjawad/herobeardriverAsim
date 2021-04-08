import 'package:hero_bear_driver/data/api_client.dart';
import 'package:hero_bear_driver/data/closable.dart';
import 'package:hero_bear_driver/data/firebase_messaging_client.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/shared_pref_client.dart';

class Repository implements Closable {
  final _apiClient = ApiClient();
  final _firebaseMsgClient = FirebaseMessagingClient();
  final _sharedPrefClient = SharedPrefClient();

  @override
  void close() {
    _firebaseMsgClient.close();
  }

  Future<UserLoginModel> logIn({
    required String phoneNo,
    required String password,
  }) async {
    final token = await FirebaseMessagingClient.getDeviceToken();
    final user = await _apiClient.logIn(
      phoneNo: phoneNo,
      password: password,
      deviceToken: token ?? 'null',
    );
    await _sharedPrefClient.setUser(user);
    return user;
  }

  Future<void> initFirebaseMessaging() => FirebaseMessagingClient.initialize();

  void listenNotifications() => _firebaseMsgClient.listenNotifications();

  Future<UserLoginModel?> getUser() => _sharedPrefClient.getUser();

  Future<void> clearUser() => _sharedPrefClient.clearUser();

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

  // get Driver Reviews
  Future<DriverReviewsModel> getDriverReviews(int userId) =>
      _apiClient.getDriverReviews(userId);
}
