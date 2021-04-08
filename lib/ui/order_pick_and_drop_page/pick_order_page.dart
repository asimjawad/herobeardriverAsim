import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/slider_widget.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/orders_list_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/order_pick_select_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PickOrderPage extends StatelessWidget {
  final double _iconSize = 20;
  final double _iconSizeL = 30;
  final double _containerH = 40;
  final double _sizedBoxW = 15;
  final double _price = 16.33;
  final String _customerName = 'Customer Name';
  final String _restaurantName = 'Restaurant Name';
  final String _hotelAddress = 'The address of the hotel';
  static const double _rowV = 20;
  final String _time = '11:30 AM';
  final int _totalItems = 1;
  final int _itemCount = 1;
  final int _noOfSngleItem = 3;
  final String _nameofSingleItem = 'Pizza One';
  final String _restaurantNumber = '03154511100';
  final double _restaurantLat = 12.22222;
  final double _restaurantLng = 32.22222;
  final String _userNumber = '03154511100';
  final double _userLat = 12.22222;
  final double _userLng = 32.22222;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                Get.to<void>(()=> OrdersListPage());
              },
              child: Icon(
                Icons.list,
                size: _iconSizeL,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        title: Text('${Strings.pickUpAt} $_time'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _restaurantName,
                          maxLines: 2,
                          style: Styles.appTheme.textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.elevationM),
                          child: Text(
                            _hotelAddress,
                            maxLines: 2,
                            style: Styles.appTheme.textTheme.bodyText1
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                        _directionsAndCallRow(callFunc:()=>_makeCall(number:_restaurantNumber ),mapFunc:()=> _openMaps(lat: _restaurantLat, lon: _restaurantLng)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimens.insetS),
                            child: ShowlineFull(
                                widthMax: true, color: Colors.black54)),
                        Text(
                          Strings.customerDetails,
                          style: Styles.appTheme.textTheme.headline4,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimens.insetS),
                            child: ShowlineFull(
                                widthMax: false, color: MyColors.yellow400)),
                        Text(
                          _customerName,
                          style: Styles.appTheme.textTheme.bodyText2
                              ?.copyWith(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: _rowV),
                          child: _directionsAndCallRow(mapFunc:()=> _openMaps(lat: _userLat,lon: _userLng),callFunc:()=> _makeCall(number: _userNumber)),
                        ),
                        ShowlineFull(widthMax: true, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.insetS),
                          child: Text(
                            Strings.orderDetails,
                            style: Styles.appTheme.textTheme.headline4,
                          ),
                        ),
                        ShowlineFull(
                            widthMax: false, color: MyColors.yellow400),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: _rowV,
                            bottom: 5,
                          ),
                          child: Text(
                            '$_totalItems ${Strings.totalItem}',
                            style: Styles.appTheme.textTheme.bodyText2
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                        Text(
                          '${Strings.sCurrency} $_price',
                          style: Styles.appTheme.textTheme.bodyText2
                              ?.copyWith(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.insetS),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(Dimens.insetXs),
                                child: Text(
                                  '$_noOfSngleItem' 'x $_nameofSingleItem',
                                  style: Styles.appTheme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.black54),
                                ),
                              );
                            },
                            itemCount: _itemCount,
                            shrinkWrap: true,
                          ),
                        ),
                        ShowlineFull(
                            widthMax: false, color: MyColors.yellow400),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          /* Positioned(
            // bottom: Dimens.insetXs,
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: MyColors.yellow400,
            ),
          )*/
          Padding(
            padding: const EdgeInsets.all(Dimens.insetM),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    SliderWidget(func: _gotoOrderPickDriver,),
                    Padding(
                      padding: const EdgeInsets.only(top: _rowV),
                      child: Center(child: Text(Strings.slideAfterArrival,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white,fontWeight: FontWeight.w700),)),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _directionsAndCallRow({required void Function() mapFunc, required void Function() callFunc}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            mapFunc();
          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions,
                    size: _iconSize,
                    color: Colors.white,
                  ),
                  Text(
                    Strings.direction,
                    style: Styles.appTheme.textTheme.bodyText1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: _sizedBoxW,
        ),
        GestureDetector(
          onTap: () {
            callFunc();
          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.call,
                    size: _iconSize,
                    color: Colors.white,
                  ),
                  Text(
                    Strings.call,
                    style: Styles.appTheme.textTheme.bodyText1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  void _gotoOrderPickDriver(){
    Get.to<void>(()=>OrderPickSelectPage());
  }
  void _makeCall({required String number})async{
    if (await canLaunch(number)) {
    await launch(number);
    } else {
    throw 'Could not launch $number';
    }
  }
    void _openMaps({required double lat,required double lon}) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
