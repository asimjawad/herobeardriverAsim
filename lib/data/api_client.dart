import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';

import 'models/order_details_model/order_details_model.dart';

class ApiClient {
  static const _baseUrl = 'https://portal.herobear.com.ph/api';

  static const _epDriverLogin = '/driver_login';
  static const _epHomeScreenData = '/home_screen_data';
  static const _epDriverEarningHistory = '/driver_earning_history';
  static const _epCommissionData = '/get_commission';
  static const _epSetCapitalData = '/set_capital';
  static const _epDriverReviews = '/driver_reviews';
  static const _epSubmitPayment = '/submit_payment';
  static const _epOrderRequest = '/order_request';
  static const _epSetDriverOnline = '/set_driver_online';
  static const _epSetDriverOffline = '/set_driver_offline';

  static const _pPhone = 'phone';
  static const _pPassword = 'password';

  static const _pDeviceToken = 'device_token';
  static const _pCapital = 'capital';

  static const _pDriverId = 'driver_id';

  static const _pStartDate = 'startDate';
  static const _pEndDate = 'endDate';

  static const _pPayoutAmount = 'payout_amount';
  static const _pTransactionId = 'transaction_id';

  static const _pLatitude = 'latitude';
  static const _pLongitude = 'longitude';

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
      '$_epCommissionData/$userId',
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

  // Set Capital Data
  Future<bool> setCapital(int userId, double capital) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _epSetCapitalData,
      data: {_pCapital: capital, _pDriverId: userId},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    throw (Exception(response.statusMessage));
  }

  Future<DriverReviewsModel> getDriverReviews(int userId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$_epDriverReviews/$userId',
    );

    if (response.statusCode == HttpStatus.ok) {
      return DriverReviewsModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }

  // post payment
  Future<bool> submitPayment(int userId,
      {required String payoutAmount, required String transactionId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _epSubmitPayment,
      data: {
        _pDriverId: userId,
        _pPayoutAmount: payoutAmount,
        _pTransactionId: transactionId
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    throw (Exception(response.statusMessage));
  }

  Future<void> setDriverOnline({
    required int driverId,
    required String deviceToken,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$_epSetDriverOnline/$driverId',
      data: {
        _pDeviceToken: deviceToken,
        _pLatitude: latitude,
        _pLongitude: longitude,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw (Exception(response.statusMessage));
    }
  }

  Future<void> setDriverOffline(int driverId) async {
    final response = await _dio.get<dynamic>('$_epSetDriverOffline/$driverId');
    if (response.statusCode != HttpStatus.ok) {
      throw (Exception(response.statusMessage));
    }
  }

  //request order
  Future<OrderDetailsModel> orderRequest({required int driverId}) async{
    final response = await _dio.get<Map<String, dynamic>>('$_epOrderRequest/$driverId');
    if(response.statusCode == HttpStatus.ok){
      return OrderDetailsModel.fromJson(response.data!);
    }
    throw (Exception(response.statusMessage));
  }
}
