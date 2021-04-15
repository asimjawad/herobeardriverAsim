import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/login_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ChangePasswordPage extends StatelessWidget {
  static const _vGap = 20.0;
  final _appBloc = Get.find<AppBloc>();
  final _formKey1 = GlobalKey<FormState>();
  final _txtCtrlPassword = TextEditingController();
  final _txtCtrlConfirmPwd = TextEditingController();
  final String phoneNo;

  ChangePasswordPage({
    required this.phoneNo,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.forgotPassword),
      ),
      body: Padding(
          padding: EdgeInsets.all(Dimens.insetM),
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Strings.enterYourPassword,
                  style: textTheme.headline2?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: _vGap,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Strings.newPassword,
                  ),
                  obscureText: true,
                  controller: _txtCtrlPassword,
                  validator: (value) {
                    if (value!.length > 1 && value.length < 6) {
                      return Strings.msgPasswordLength;
                    } else if (value.isEmpty) {
                      return Strings.msgNewPassword;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: _vGap,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Strings.confirmPassword,
                  ),
                  obscureText: true,
                  controller: _txtCtrlConfirmPwd,
                  validator: (value) {
                    if (value!.length > 1 && value.length < 6) {
                      return Strings.msgPasswordLength;
                    } else if (value.isEmpty) {
                      return Strings.msgReenterPassword;
                    } else if (value != _txtCtrlPassword.text) {
                      return Strings.msgPasswordNotMatch;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: _vGap,
                ),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (_formKey1.currentState!.validate()) {
                        _onDone(context);
                      }
                      ;
                    },
                    child: Text(Strings.done),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onDone(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (builderContext) {
        () async {
          try {
            await _appBloc.changePassword(
              phoneNo: phoneNo,
              password: _txtCtrlConfirmPwd.text,
            );
            Get.offAll<void>(() => LoginPage());
          } catch (e) {
            Navigator.pop(builderContext);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(Strings.somethingWentWrong),
            ));
          }
        }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
