import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class EditProfilePage extends StatelessWidget {
  static const _sizeImgProfile = 100.0;

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
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: Strings.fullName,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.insetM,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: Strings.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.insetM,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: Strings.mobileNumber,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.insetM,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(Strings.save),
                      ),
                    ],
                  ),
                ],
              ),
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
