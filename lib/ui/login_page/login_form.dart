import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/ui/commission/commission_page.dart';
import 'package:hero_bear_driver/ui/driver_earning/driver_earning.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final bool _obscure = true;
  final _height = 10.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Row(
            children: [
              CountryCodePicker(
                showFlag: false,
                showDropDownButton: true,
                onChanged: print,
                initialSelection: 'IT',
                favorite: ['+39', 'FR'],
                countryFilter: ['IT', 'FR'],
              ),
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: Strings.hintTextPhoneNumber,
                    hintStyle: TextStyle(color: MyColors.grey, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          )),
          SizedBox(
            height: _height * 2,
          ),
          TextFormField(
            obscureText: _obscure,
            decoration: const InputDecoration(
                hintText: Strings.hintTextPassword,
                hintStyle: TextStyle(color: MyColors.grey, fontSize: 16.0),
                suffixIcon: InkWell(
                  onTap:null,
                  child: Icon(
                    Icons.visibility,
                    color: MyColors.grey,
                  ),
                )),
          ),
          SizedBox(
            height: _height * 2,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: _height * 5,
              child: ElevatedButton(
                  onPressed: () => Get.to<void>(() => DriverEarning()),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MyColors.yellow400)),
                  child: Text(Strings.login,
                      style: Styles.appTheme.accentTextTheme.bodyText2
                          ?.copyWith(color: colorScheme.onPrimary)))),
          SizedBox(
            height: _height * 2,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {
                    Get.to<void>(() => CommissionPage());
                  },
                  child: Text(Strings.forgotPassword,
                      style: Styles.appTheme.accentTextTheme.headline5
                          ?.copyWith(color: colorScheme.onBackground))))
        ],
      ),
    );
  }
}
