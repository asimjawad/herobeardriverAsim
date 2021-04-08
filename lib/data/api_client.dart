import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';

class ApiClient {
  static const _baseUrl = 'https://portal.herobear.com.ph/api';

  static const _epDriverLogin = '/driver_login';
  static const _epHomeScreenData = '/home_screen_data';
  static const _epDriverEarningHistory = '/driver_earning_history';
  static const _pCommissionData = '/get_commission';

  static const _pPhone = 'phone';
  static const _pPassword = 'password';

  static const _pDeviceToken = 'device_token';
  static const _pCapital = 'capital';

  static const _pDriverId = 'driver_id';

  static const _pStartDate = 'startDate';
  static const _pEndDate = 'endDate';

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

  // Get Commission Data
  Future<CommissionModel> getCommissionData(int userId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$_pCommissionData/$userId',
    );

    if (response.statusCode == HttpStatus.ok) {
      return CommissionModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }

  // Get Earning History Data
  Future<EarningModel> getDriverEarningHistory(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$_epDriverEarningHistory/$userId',
      data: {_pStartDate: startDate, _pEndDate: startDate},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return EarningModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }
}
