import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/ui/home/progress_indicator_timer_wgt.dart';
import 'package:hero_bear_driver/ui/plain_scroll_behavior.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';

class OrderConfirmPage extends StatelessWidget {

  final TWO_PI = 3.14 * 2;
  final String _orderNumber = '1';
  final String _restaurantName = 'Restaurant Name';
  final String _time = '11:04 AM';
  final double _price = 20.00;
  final double size = 50;
  int percentage= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(0, 0),
                      // zoom: 12,
                    ),
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: SafeArea(
                      child: Container(
                        height: 45,
                        width: 80,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: Dimens.elevationM,
                            ),
                          ],
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: Text(Strings.decline,style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.white),)),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ScrollConfiguration(
              behavior: PlainScrollBehavior(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.pickedAt,style: Styles.appTheme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),),
                            Text(_time,style: Styles.appTheme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),),
                            ProgressTimerWidget(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 20,),
                        child: Text(_restaurantName,style: Styles.appTheme.textTheme.headline3,maxLines: 2,textAlign: TextAlign.start,),
                      ),
                      Text('$_orderNumber ${Strings.order}',style: Styles.appTheme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.estimatedEarning,style: Styles.appTheme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
                            Text('\$ ${_price}',style: Styles.appTheme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.yellow400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(Strings.acceptOrder,style: Styles.appTheme.textTheme.headline5?.copyWith(color: Colors.white),),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
