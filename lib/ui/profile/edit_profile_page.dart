import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey1 = GlobalKey<FormState>();

  static const _sizeImgProfile = 100.0;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobileNo = TextEditingController();
  // final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.editProfile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimens.insetM),
        children: [
          Image.asset(
            MyImgs.noProfile,
            width: _sizeImgProfile,
            height: _sizeImgProfile,
          ),
          SizedBox(
            height: Dimens.insetM,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.insetM),
              child: Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: Strings.fullName,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Strings.msgEmptyName;
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimens.insetM,
                      ),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: Strings.emailAddress,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.msgEmptyEmail;
                          }

                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return Strings.msgInvalidEmail;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: Dimens.insetM,
                      ),
                      TextFormField(

                        maxLength: 10,
                        controller: _mobileNo,
                        decoration: InputDecoration(
                          hintText: Strings.mobileNumber,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.msgEmptyMobile;
                          }
                          else if (value.length > 10 || value.length < 10) {
                            return Strings.msgInvalidMobile;
                          }
                            return null;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: Dimens.insetM,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey1.currentState!.validate()) {
                                _formKey1.currentState!.save();
                                _onSave(context);
                              }
                              ;
                            },
                            child: Text(Strings.save),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }



  void _onSave(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        // todo: handle on edit profile here
        // () async {
        //
        // }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
