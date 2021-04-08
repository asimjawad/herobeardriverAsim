import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/change_password_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class OtpVerificationPage extends StatelessWidget {
  final _appBloc = Get.find<AppBloc>();
  final String phoneNo;
  final String verificationId;
  final Duration timeOut;
  final focusNodes = List.generate(6, (index) => FocusNode());

  OtpVerificationPage({
    required this.phoneNo,
    required this.verificationId,
    required this.timeOut,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterBuild());
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.forgotPassword),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimens.insetM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.verificationCode,
              style: textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(Strings.msgEnterVerfiication),
            SizedBox(
              height: 20,
            ),
            _buildOtpRow(context),
            SizedBox(
              height: 20,
            ),
            Text(
              Strings.resendOtp,
              textAlign: TextAlign.end,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _onNext(),
              child: Text(Strings.next),
            ),
          ],
        ),
      ),
    );
  }

  void _afterBuild() async {
    try {
      await _appBloc.onOtpAutoVerificationComplete();
    } catch (e) {}
  }

  Widget _buildOtpRow(BuildContext context) {
    return Wrap(
      spacing: Dimens.insetM,
      alignment: WrapAlignment.center,
      runSpacing: Dimens.insetM,
      children: [
        ...List.generate(focusNodes.length, (index) => index).map((index) =>
            _buildOtpCell(context, node: focusNodes[index], onFilled: () {
              // exclude last node
              if (index < focusNodes.length - 1) {
                focusNodes[index + 1].requestFocus();
              }
            }, onClear: () {
              // exclude first node
              if (index > 0) {
                focusNodes[index - 1].requestFocus();
              }
            })),
      ],
    );
  }

  Widget _buildOtpCell(
    BuildContext context, {
    FocusNode? node,
    void Function()? onFilled,
    void Function()? onClear,
  }) {
    return SizedBox(
      height: 50,
      width: 40,
      child: Card(
        elevation: Dimens.elevationM,
        child: Center(
          child: TextField(
            focusNode: node,
            maxLength: 1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
            onChanged: (input) {
              final text = input ?? '';
              if (text == '') {
                onClear?.call();
              } else {
                onFilled?.call();
              }
            },
          ),
        ),
      ),
    );
  }

  void _onNext() {
    Get.to<void>(ChangePasswordPage());
  }
}
