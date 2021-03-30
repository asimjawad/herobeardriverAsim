import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.heroBear,
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme,
      initialBinding: BindingsBuilder(() => Get.put(
            AppBloc(),
            permanent: true,
          )),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
      ],
    );
  }
}
