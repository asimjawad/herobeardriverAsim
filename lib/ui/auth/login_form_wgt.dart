import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginFormWgt extends StatefulWidget {
  void Function(String phoneNo, String email)? onLogin;

  LoginFormWgt({
    this.onLogin,
  });

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginFormWgt> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlPhoneNo = TextEditingController();
  final _ctrlPwd = TextEditingController();
  String? _selectedDialCode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                CountryCodePicker(
                  showFlag: true,
                  searchDecoration:
                      InputDecoration(contentPadding: EdgeInsets.all(40)),
                  dialogSize: Size(
                      MediaQuery.of(context).size.width - Dimens.insetM * 2,
                      MediaQuery.of(context).size.height -
                          Dimens.insetM * 2 -
                          MediaQuery.of(context).padding.top),
                  showDropDownButton: true,
                  onChanged: (code) => _selectedDialCode = code.dialCode,
                  initialSelection: 'IT',
                  favorite: ['+39', 'FR'],
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _ctrlPhoneNo,
                    decoration: const InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _ctrlPwd,
            decoration: const InputDecoration(
                hintText: Strings.hintTextPassword,
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: _onLogin,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MyColors.yellow400)),
                  child: Text(Strings.logIn,
                      style: Styles.appTheme.accentTextTheme.bodyText2
                          ?.copyWith(color: colorScheme.onPrimary)))),
          SizedBox(
            height: 20.0,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {},
                  child: Text(Strings.forgotPassword,
                      style: Styles.appTheme.accentTextTheme.headline5
                          ?.copyWith(color: colorScheme.onBackground))))
        ],
      ),
    );
  }

  void _onLogin() {
    final dialCode = _selectedDialCode ?? '+33';

    final phoneNo = dialCode + _ctrlPhoneNo.text;
    widget.onLogin?.call(phoneNo, _ctrlPwd.text);
  }
}
