import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';

class AppBloc extends DisposableInterface {
  // todo: replace with actual session
  final user = UserLoginModel(
    userId: 78,
    name: 'John Doe',
    email: 'john@gmail.com',
    image: '',
    approved: '1',
    status: true,
    statusCode: 200,
    message: '',
  );

  final location = LocationModel(
    latLng: LatLng(31.4643699, 74.2414676),
  );

  bool isUserLoggedIn() => true;
}
