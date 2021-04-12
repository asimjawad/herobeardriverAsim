import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/ui/auth/change_password_page.dart';
import 'package:hero_bear_driver/ui/auth/login_form_wgt.dart';
import 'package:hero_bear_driver/ui/auth/otp_verification_page.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginPage extends StatelessWidget {
  final _appBloc = Get.find<AppBloc>();

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
            LoginFormWgt(
              onLogin: (phoneNo, pwd) => _onLogin(context, phoneNo, pwd),
              onForgotPassword: (phoneNo) =>
                  _onForgotPassword(context, phoneNo),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogin(BuildContext context, String phoneNo, String password) {
    showDialog<void>(
      context: context,
      builder: (builderContext) {
        () async {
          var success = false;
          try {
            final user = await _appBloc.logIn(
              phoneNo: phoneNo,
              password: password,
            );
            // todo: show msg when not approved
            if (user.approved == UserLoginModel.sApproved) {
              success = true;
            }
          } catch (e) {}
          if (success) {
            Get.offAll<void>(HomePage());
          } else {
            Navigator.pop(builderContext);
          }
        }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onForgotPassword(BuildContext context, String phoneNo) {
    Get.offAll<void>(ChangePasswordPage(phoneNo: '+923001234567'));
    // showDialog<void>(
    //   context: context,
    //   builder: (builderContext) {
    //     () async {
    //       try {
    //         final timeOut = Duration(seconds: 60);
    //         final verefId = await _appBloc.sendOtp(phoneNo, timeOut);
    //         Navigator.pop(builderContext);
    //         Get.to<void>(() => OtpVerificationPage(
    //               phoneNo: phoneNo,
    //               timeOut: timeOut,
    //               verificationId: verefId,
    //             ));
    //       } catch (e) {
    //         Navigator.pop(builderContext);
    //       }
    //     }.call();
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
