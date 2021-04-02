import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/auth/login_form_wgt.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(Dimens.insetM, 30, Dimens.insetM, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60.0),
              child: Text(Strings.welcomeTo,
                  style: Styles.appTheme.textTheme.headline2),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(Strings.heroBearDriver,
                  style: Styles.appTheme.textTheme.headline2
                      ?.copyWith(color: colorScheme.primary)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                Strings.msgLoginText,
                style: Styles.appTheme.textTheme.headline5?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            LoginFormWgt(),
          ],
        ),
      ),
    );
  }

  void _onLogin() {}
}
