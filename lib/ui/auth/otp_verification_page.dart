import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/auth/change_password_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNo;
  final String verificationId;
  final Duration timeOut;

  OtpVerificationPage({
    required this.phoneNo,
    required this.verificationId,
    required this.timeOut,
  });

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const _otpCharCount = 6;
  static const _styleDisabledText = TextStyle(
    color: Colors.grey,
  );
  final _appBloc = Get.find<AppBloc>();
  final _focusNodes = List.generate(_otpCharCount, (_) => FocusNode());
  final _textControllers =
      List.generate(_otpCharCount, (_) => TextEditingController());
  bool _enableResend = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _onceAfterBuild());
    super.initState();
  }

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
              Strings.verificationCode,
              style: textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(Strings.msgEnterVerification),
            SizedBox(
              height: 20,
            ),
            _buildOtpRow(context),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _onResendOtp,
              child: Text(
                Strings.resendOtp,
                textAlign: TextAlign.end,
                style: _enableResend ? null : _styleDisabledText,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _onNext(context),
              child: Text(Strings.next),
            ),
          ],
        ),
      ),
    );
  }

  void _onceAfterBuild() async {
    try {
      await _appBloc.onOtpAutoVerificationComplete();
      Get.offAll<void>(() => ChangePasswordPage(
            phoneNo: widget.phoneNo,
          ));
    } catch (e) {
      setState(() => _enableResend = true);
    }
  }

  Widget _buildOtpRow(BuildContext context) {
    return Wrap(
      spacing: Dimens.insetM,
      alignment: WrapAlignment.center,
      runSpacing: Dimens.insetM,
      children: [
        ...List.generate(_otpCharCount, (index) => index)
            .map((index) => _buildOtpCell(
                  context,
                  node: _focusNodes[index],
                  onFilled: () {
                    // exclude last node
                    if (index < _focusNodes.length - 1) {
                      _focusNodes[index + 1].requestFocus();
                    }
                  },
                  onClear: () {
                    // exclude first node
                    if (index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                  },
                  autoFocus: index == 0,
                  controller: _textControllers[index],
                )),
      ],
    );
  }

  static Widget _buildOtpCell(
    BuildContext context, {
    FocusNode? node,
    void Function()? onFilled,
    void Function()? onClear,
    bool autoFocus = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      height: 50,
      width: 40,
      child: Card(
        elevation: Dimens.elevationM,
        child: Center(
          child: TextField(
            controller: controller,
            autofocus: autoFocus,
            focusNode: node,
            maxLength: 1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
            onChanged: (input) {
              if (input == '') {
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

  void _onNext(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (builderContext) {
        () async {
          try {
            var smsCode = '';
            _textControllers
                .forEach((controller) => smsCode += controller.text);
            await _appBloc.verifySmsCode(smsCode);
            Get.offAll<void>(() => ChangePasswordPage(
                  phoneNo: widget.phoneNo,
                ));
          } catch (e) {
            Navigator.pop(builderContext);
            print('error');
          }
        }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onResendOtp() {
    setState(() => _enableResend = false);
  }
}
