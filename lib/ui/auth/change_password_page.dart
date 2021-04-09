import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ChangePasswordPage extends StatelessWidget {
  static const _vGap = 20.0;

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
            TextField(
              decoration: InputDecoration(
                hintText: Strings.newPassword,
              ),
              obscureText: true,
            ),
            SizedBox(
              height: _vGap,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: Strings.confirmPassword,
              ),
              obscureText: true,
            ),
            SizedBox(
              height: _vGap,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(Strings.done),
            ),
          ],
        ),
      ),
    );
  }
}
