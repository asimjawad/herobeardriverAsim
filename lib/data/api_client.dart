import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';

class ApiClient {
  static const _baseUrl = 'https://portal.herobear.com.ph/api';

  static const _epDriverLogin = '/driver_login';
  static const _epHomeScreenData = '/home_screen_data';

  static const _pPhone = 'phone';
  static const _pPassword = 'password';
  static const _pDeviceToken = 'device_token';
  static const _pCapital = 'capital';
  static const _pDriverId = 'driver_id';

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

  Future<UserLoginModel> logIn({
    required String phoneNo,
    required String password,
    required String deviceToken,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _epDriverLogin,
      data: {
        _pPhone: phoneNo,
        _pPassword: password,
        _pDeviceToken: deviceToken,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      return UserLoginModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }

  Future<HomeScreenDashboardModel> getHomeData(int userId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$_epHomeScreenData/$userId',
    );
    if (response.statusCode == HttpStatus.ok) {
      return HomeScreenDashboardModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }
}
