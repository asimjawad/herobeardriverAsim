import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class BottomSheetCheck extends StatefulWidget {
  final void Function()? onReady;

  BottomSheetCheck({
    this.onReady,
  });

  @override
  _BottomSheetCheckState createState() => _BottomSheetCheckState();
}

class _BottomSheetCheckState extends State<BottomSheetCheck> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  bool visi = false;
  static const double marginVisi = 10.0;
  final double btnHeight = 40;
  static const double sizedB = 22;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: Dimens.insetM, left: Dimens.insetM),
          child: Text(
            Strings.makeSureYouAreReadyTogo,
            style: Styles.appTheme.textTheme.headline4,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: checkBoxListTileModel.length,
          key: UniqueKey(),
          padding: EdgeInsets.all(Dimens.insetM / 2),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.insetM / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizedB,
                    width: sizedB,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (val) {
                        itemChange(val!, index);
                      },
                      value: checkBoxListTileModel[index].isCheck,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.insetS),
                    child: Text(
                      checkBoxListTileModel[index].title,
                      style: Styles.appTheme.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Center(
            child: visi
                ? Padding(
                    padding: const EdgeInsets.only(bottom: marginVisi),
                    child: Text(
                      Strings.makeSureYouHaveAllOfAbove,
                      style: Styles.appTheme.textTheme.bodyText1
                          ?.copyWith(color: Colors.red),
                    ),
                  )
                : Container()),
        Padding(
          padding: const EdgeInsets.only(
              bottom: Dimens.insetM, left: Dimens.insetM, right: Dimens.insetM),
          child: ElevatedButton(
            onPressed: () {
              if (checkBoxListTileModel[0].isCheck == true &&
                  checkBoxListTileModel[1].isCheck == true &&
                  checkBoxListTileModel[2].isCheck == true) {
                widget.onReady?.call();
                visi = false;
                setState(() {});
              } else {
                visi = true;
                setState(() {});
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(marginVisi),
                ),
              ),
            ),
            child: Text(Strings.startYourRide),
          ),
        ),
      ],
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }
}

class CheckBoxListTileModel {
  String title;
  bool isCheck;

  CheckBoxListTileModel({required this.title, required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(title: Strings.enoughGas, isCheck: false),
      CheckBoxListTileModel(title: Strings.phoneCharged, isCheck: false),
      CheckBoxListTileModel(
          title: Strings.hotBagAndSpaceBlanket, isCheck: false),
    ];
  }
}
