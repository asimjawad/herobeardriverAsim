import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/data/repository.dart';

class AppBloc extends DisposableInterface {
  final _repository = Repository();
  UserLoginModel? _user;

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
}
