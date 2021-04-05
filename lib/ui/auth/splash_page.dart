import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/login_page.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';

class SplashPage extends StatelessWidget {
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterBuild(context));
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: theme.colorScheme.primary,
      ),
    );
  }

  void _afterBuild(BuildContext context) async {
    if (await _appBloc.isUserLoggedIn()) {
      Get.to<void>(HomePage());
    } else {
      Get.to<void>(LoginPage());
    }
  }
}
