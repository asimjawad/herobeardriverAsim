import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';

class SplashPage extends StatelessWidget {
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

  void _afterBuild(BuildContext context) {
    Get.to<void>(HomePage());
  }
}
