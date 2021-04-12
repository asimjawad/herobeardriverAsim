import 'dart:convert';

import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefClient {
  static const _kUserModel = 'user_login_model';
  static const _kDeviceToken = 'device_token';
  static const _kOrderConfirmed = 'order_confirmed';
  static const _kOrderDelivery = 'order_delivery';

  Future<UserLoginModel?> getUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    final json = sharedPref.getString(_kUserModel);
    if (json != null) {
      return UserLoginModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> setUser(UserLoginModel user) async {
    final sharedPref = await SharedPreferences.getInstance();
    final json = jsonEncode(user);
    await sharedPref.setString(_kUserModel, json);
  }

  Future<void> clearUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove(_kUserModel);
  }

  Future<void> setDeviceToken(String deviceToken) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(_kDeviceToken, deviceToken);
  }

  Future<void> setOrderAcceptedStatus(bool res) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(_kOrderConfirmed, res);
  }

  Future<void> setOrderDeliveryStatus(bool res) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(_kOrderDelivery, res);
  }

  Future<String?> getDeviceToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_kDeviceToken);
  }

  Future<bool?> getOrderAcceptedStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(_kOrderConfirmed);
  }

  Future<bool?> getOrderDeliveryStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(_kOrderDelivery);
  }

  Future<void> clearAll() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove(_kUserModel);
    await sharedPref.remove(_kDeviceToken);
  }
}
