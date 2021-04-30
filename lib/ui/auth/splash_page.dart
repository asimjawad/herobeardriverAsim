import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/ask_location_wgt.dart';
import 'package:hero_bear_driver/ui/auth/login_page.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class SplashPage extends StatelessWidget {
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterBuild(context));
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // same size as native splash
        child: Image.asset(
          MyImgs.heroBearLogo,
          width: 111.5,
          height: 111.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void _afterBuild(BuildContext context) => _checkInternetAndProceed(context);

  void _checkInternetAndProceed(BuildContext context) async {
    // print("#checkInternetAndProceed");
    var flagConnected = false;
    try {
      final result =
          await InternetAddress.lookup('example.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // when connected
        flagConnected = true;
      }
    } catch (_) {}
    if (flagConnected) {
      _checkLocationAndProceed(context);
    } else {
      // when no internet
      _onNoInternet(context);
    }
  }

  void _onNoInternet(BuildContext context) {
    // print("#showModalBottomSheet");
    showModalBottomSheet<void>(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(Dimens.radiusM),
          topRight: const Radius.circular(Dimens.radiusM),
        ),
      ),
      builder: (builderContext) => _buildNoInternetWgt(context, builderContext),
    );
  }

  Widget _buildNoInternetWgt(
      BuildContext context, BuildContext builderContext) {
    // print("#buildNoInternetWgt");
    final imgSize = 200.0;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(Dimens.insetM),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.noInternetConnection,
            style: Theme.of(context).textTheme.headline6,
          ),
          Image.asset(
            MyImgs.noInternet,
            width: imgSize,
            height: imgSize,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(builderContext);
              _checkInternetAndProceed(context);
            },
            child: Text(Strings.tryAgain),
          ),
        ],
      ),
    );
  }

  void _checkLocationAndProceed(BuildContext context) async {
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse) {
      _checkSessionAndProceed();
    } else {
      showDialog<void>(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => Center(
          child: AskLocationWgt(
            onLocationEnabled: _checkSessionAndProceed,
          ),
        ),
      );
    }
  }

  void _checkSessionAndProceed() async {
    // call method here
    await _appBloc.updateUserCurrentLocation();
    if (await _appBloc.isUserLoggedIn()) {
      Get.to<void>(HomePage());
    } else {
      Get.to<void>(LoginPage());
    }
  }
}
