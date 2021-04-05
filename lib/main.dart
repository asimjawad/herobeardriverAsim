import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/splash_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.heroBearDriver,
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme,
      initialBinding: BindingsBuilder.put(
        () => AppBloc(),
        permanent: true,
      ),
      getPages: [
        GetPage<void>(
          name: '/',
          page: () => SplashPage(),
        ),
      ],
    );
  }
}
