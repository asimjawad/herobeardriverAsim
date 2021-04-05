import 'package:hero_bear_driver/data/api_client.dart';
import 'package:hero_bear_driver/data/closable.dart';
import 'package:hero_bear_driver/data/firebase_messaging_client.dart';
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
}
