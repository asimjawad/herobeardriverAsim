import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/ui/order_decline_page/select_a_reason_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
class OrderDeclinePage extends StatelessWidget {
  final double height = 50;
  final double width = 90;
  static const double marginTop = 20;
  static const double radi = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.insetM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.areyousureyouwanttodeclinethisorder,style: Styles.appTheme.textTheme.headline5,textAlign: TextAlign.start,maxLines: 2,),
              Padding(
                padding: const EdgeInsets.only(top: marginTop),
                child: Text(Strings.yourethebestHeroBeardriverforthisorder,style: Styles.appTheme.textTheme.bodyText1,textAlign: TextAlign.start,maxLines: 2,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: marginTop),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){Get.back<void>();}, child: Text(Strings.goBack,style: Styles.appTheme.textTheme.headline5?.copyWith(color: MyColors.yellow400),)),
                    InkWell(
                      onTap: (){
                        Get.to<void>(SelectAReason());
                      },
                      child: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          color: MyColors.yellow400,
                          borderRadius: BorderRadius.circular(radi),
                        ),
                        child: Center(child: Text(Strings.declineCapWords,style: Styles.appTheme.textTheme.headline5?.copyWith(color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
