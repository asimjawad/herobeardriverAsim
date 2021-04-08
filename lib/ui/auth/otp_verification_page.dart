import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class OtpVerificationPage extends StatelessWidget {
  final String phoneNo;
  final String verificationId;
  final Duration timeOut;

  OtpVerificationPage({
    required this.phoneNo,
    required this.verificationId,
    required this.timeOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimens.insetM),
        child: Column(
          children: [
            Text(Strings.verificationCode),
            Text(Strings.msgEnterVerfiication),
          ],
        ),
      ),
    );
  }
}
