import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
class BottomSheetCheck extends StatefulWidget {
  @override
  _BottomSheetCheckState createState() => _BottomSheetCheckState();
}

class _BottomSheetCheckState extends State<BottomSheetCheck> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: checkBoxListTileModel.length,
          key: UniqueKey(),
          padding: EdgeInsets.all(Dimens.insetM/2),
          itemBuilder: (BuildContext context,index){
            return Padding(
             padding: const EdgeInsets.all(Dimens.insetM/2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22,
                    width: 22,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (val){
                        itemChange(val!, index);
                      },
                      value: checkBoxListTileModel[index].isCheck,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:Dimens.insetS),
                    child: Text(checkBoxListTileModel[index].title,style: Styles.appTheme.textTheme.bodyText1,),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: Dimens.insetM,left: Dimens.insetM,right: Dimens.insetM),
          child: InkWell(
            onTap: (){
              // Get.to<void>(SelectAReason());
            },
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.yellow400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(Strings.declineCapWords,style: Styles.appTheme.textTheme.headline5?.copyWith(color: Colors.white),)),
            ),
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
      CheckBoxListTileModel(
          title: Strings.enoughGas,
          isCheck: false),
      CheckBoxListTileModel(
          title: Strings.phoneCharged,
          isCheck: false),
      CheckBoxListTileModel(
          title: Strings.hotBagAndSpaceBlanket,
          isCheck: false),
    ];
  }
}
