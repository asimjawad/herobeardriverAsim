import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:hero_bear_driver/data/models/login_model.dart';

class ApiClient {
  static const _baseUrl = 'https://portal.herobear.com.ph/api';

  static const _epDriverLogin = '/driver_login';

  static const _pPhone = 'phone';
  static const _pPassword = 'password';
  static const _pDeviceToken = 'device_token';

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

  Future<LoginModel> login({
    required String phoneNo,
    required String password,
    required String deviceToken,
  }) async {
    final response = await _dio.post<dynamic>(_epDriverLogin, data: {
      _pPhone: phoneNo,
      _pPassword: password,
      _pDeviceToken: deviceToken,
    });
    if (response.statusCode == HttpStatus.ok) {
      print('success');
    }
    throw (Exception('Unimplemented method'));
  }
}
