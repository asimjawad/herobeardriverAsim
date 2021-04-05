import 'package:dio/dio.dart';

class ApiClient {
  static const _baseUrl = 'https://portal.herobear.com.ph/api';

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

// LoginModel login() {
//   final response = _dio.post<dynamic>();
// }
}
