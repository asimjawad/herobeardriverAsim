import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/login_page/login_form.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 60.0),
                child: Text(Strings.welcome,
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
                child: Text(Strings.loginText,
                    style: Styles.appTheme.textTheme.headline5?.copyWith(
                        color: MyColors.grey, fontWeight: FontWeight.normal)),
              ),
              Container(child: LoginForm())
            ],
          ),
        ),
      ),
    );
  }
}
