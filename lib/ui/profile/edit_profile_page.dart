import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/no_internet_wgt.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _imageSelected;
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.editProfile),
      ),
      body: FutureBuilder<UserLoginModel>(
        future: _appBloc.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(Dimens.insetM),
              children: [
                GestureDetector(
                  onTap: () async {
                    _showPicker(context);
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _imageSelected == null
                          ? Image.network(
                              snapshot.data!.image,
                              width: _sizeImgProfile,
                              height: _sizeImgProfile,
                            )
                          : Image.file(
                        _imageSelected!,
                              width: _sizeImgProfile,
                              height: _sizeImgProfile,
                              fit: BoxFit.cover,
                            ),
                    )),
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

                                const pattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
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
                                } else if (value.length > 10 ||
                                    value.length < 10) {
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
            );
          }
          if (snapshot.hasError) {
            return NoInternetWgt();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        openGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      openCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onSave(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        // todo: handle on edit profile here
        late bool res;
        () async {
          res = await _appBloc.editProfile(
              name: _name.text, email: _email.text, image: _imageSelected);
        }.call();
        if (res) {
          Get.back<void>();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void openGallery() async {
    var pickedFile = (await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ));
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
      });
    } else {
      print('Nothing is selected');
    }
  }

  void openCamera() async {
    var pickedFile = (await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ));
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
      });
    } else {
      print('Nothing is selected');
    }
  }
}
