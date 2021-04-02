import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoginFormWgt extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginFormWgt> {
  final _formKey = GlobalKey<FormState>();

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
                showFlag: false,
                showDropDownButton: true,
                onChanged: print,
                initialSelection: 'IT',
                favorite: ['+39', 'FR'],
                countryFilter: ['IT', 'FR'],
// flagDecoration: BoxDecoration(
// borderRadius: BorderRadius.circular(7),
// ),
              ),
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                      // hintText: Strings.hintTextPhoneNumber,
                      // hintStyle: TextStyle(color: MyColors.grey),
                      ),
                ),
              ),
            ],
          )),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: Strings.hintTextPassword,
                // hintStyle: TextStyle(color: MyColors.grey),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  // color: MyColors.grey,
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () {},
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
}
