import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginFormWgt extends StatefulWidget {
  void Function(String phoneNo, String email)? onLogin;
  void Function(String phoneNo)? onForgotPassword;

  LoginFormWgt({
    this.onLogin,
    this.onForgotPassword,
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
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: _ctrlPhoneNo,
                    validator: (_ctrlPhoneNo) {
                      if (_ctrlPhoneNo!.isEmpty) {
                        return Strings.msgEmptyPhone;
                      } else if (_ctrlPhoneNo.length < 10) {
                        return Strings.msgPhoneLength;
                      } else {
                        return null;
                      }
                    },
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
            validator: (_ctrlPwd) {
              if (_ctrlPwd!.length > 1 && _ctrlPwd.length < 6) {
                return Strings.msgPasswordLength;
              } else if (_ctrlPwd.isEmpty) {
                return Strings.msgEmptyPassword;
              } else {
                return null;
              }
            },
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final dialCode = _selectedDialCode ?? '+33';

                      final phoneNo = dialCode + _ctrlPhoneNo.text;
                      widget.onLogin?.call(phoneNo, _ctrlPwd.text);
                    }
                    ;
                  },
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
                  onTap: () {
                    if (_ctrlPhoneNo.text.isNotEmpty) {
                      _onForgotPassword();
                      // final dialCode = _selectedDialCode ?? '+39';
                      // final phoneNo = dialCode + _ctrlPhoneNo.text;
                      // widget.onForgotPassword?.call(phoneNo);
                    }
                    ;

                    if (_ctrlPhoneNo.text.isEmpty) {
                      final snackBar = SnackBar(
                        content: Text(Strings.msgEmptyPhone),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    ;
                  },
                  child: Text(Strings.forgotPassword,
                      style: Styles.appTheme.accentTextTheme.headline5
                          ?.copyWith(color: colorScheme.onBackground))))
        ],
      ),
    );
  }

  void _onLogin() {
    final dialCode = _selectedDialCode ?? '+39';
    final phoneNo = dialCode + _ctrlPhoneNo.text;
    widget.onLogin?.call(phoneNo, _ctrlPwd.text);
  }

  void _onForgotPassword() {
    final dialCode = _selectedDialCode ?? '+39';
    final phoneNo = dialCode + _ctrlPhoneNo.text;
    widget.onForgotPassword?.call(phoneNo);
  }
}
