import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';
import 'package:hero_bear_driver/ui/home/progress_indicator_timer_wgt.dart';
import 'package:hero_bear_driver/ui/order_decline_page/order_decline_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/pick_order_page.dart';
import 'package:hero_bear_driver/ui/plain_scroll_behavior.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/util/map_util.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class OrderConfirmPage extends StatelessWidget {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final TWO_PI = 3.14 * 2;
  final String _orderNumber = '1';
  final String _restaurantName = 'Restaurant Name';
  final String _time = '11:04 AM';
  final double _price = 20.00;
  final double size = 50;
  final double height = 45;
  final double width = 80;
  final double posT = 5;
  final double posR = 10;
  static const double posC = 15;
  static const double posCs = 10;
  static const double padT = 20;

  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    // String dateTime = dateFormat.format(_appBloc.orderDetailsModel.data!.orders[0].deliveredTime.);
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait<dynamic>([
          _appBloc.orderRequest(),
          _appBloc.fetchOrderRequestData(),
          MapUtil.getBitmapDescriptor(context, MyImgs.mapPin, 35),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bmpDescriptor = snapshot.data![2] as BitmapDescriptor;
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(
                                    _appBloc.orderDetailsModel.data!.latitude),
                                double.parse(_appBloc
                                    .orderDetailsModel.data!.longitude)),
                            zoom: 12,
                          ),
                          markers: _prepareMapMarkers(bmpDescriptor),
                          onMapCreated: _zoomCameraToBounds,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                        Positioned(
                          top: posT,
                          right: posR,
                          child: SafeArea(
                              child: InkWell(
                                onTap: () async {
                                  /*  final res = await _appBloc.orderRequest();
                          print(res.data?.toJson());*/
                                  Get.to<void>(OrderDeclinePage());
                                },
                                child: Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: Dimens.elevationM,
                                      ),
                                    ],
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(posC),
                                  ),
                                  child: Center(
                                      child: Text(
                                        Strings.decline,
                                        style: Styles.appTheme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.white),
                                      )),
                                ),
                              )),
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
                      padding: EdgeInsets.all(Dimens.insetM),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: padT,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Strings.pickedAt,
                                  style: Styles.appTheme.textTheme.bodyText2
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${_appBloc.orderDetailsModel.data!.orders[0].deliveredTime.hour.toString()}:${_appBloc.orderDetailsModel.data!.orders[0].deliveredTime.minute.toString()}',
                                  style: Styles.appTheme.textTheme.bodyText2
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                ProgressTimerWidget(
                                  func: _gotoHome,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: posC,
                              bottom: padT,
                            ),
                            child: Text(
                              _appBloc.orderDetailsModel.data!.name,
                              style: Styles.appTheme.textTheme.headline3,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            '$_orderNumber ${Strings.order}',
                            style: Styles.appTheme.textTheme.headline5
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: padT),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Strings.estimatedEarning,
                                  style: Styles.appTheme.textTheme.headline5
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\$ ${_appBloc.orderDetailsModel.data!.orders[0].deliveryCharges}',
                                  style: Styles.appTheme.textTheme.headline5
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.insetM),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog<void>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                // var f = await getImageFileFromAssets(
                                //     'assets/images/no_profile.png');
                                var response =
                                await _appBloc.orderAcceptByDriver(
                                    orderNo: _appBloc
                                        .orderDetailsModel.orderNos![0],
                                    // image: f,
                                    status: 1);
                                if (response) {
                                  // await _appBloc.setOrderAcceptedStatus(true);
                                  await Get.offAll<void>(() => PickOrderPage());
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      Strings.somethingWentWrong,
                                      style: Styles
                                          .appTheme.textTheme.bodyText1!
                                          .copyWith(color: MyColors.yellow400),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                  ));
                                }
                              },
                              child: Container(
                                height: height,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: MyColors.yellow400,
                                  borderRadius: BorderRadius.circular(posCs),
                                ),
                                child: Center(
                                  child: Text(
                                    Strings.acceptOrder,
                                    style: Styles.appTheme.textTheme.headline5
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/image.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void _gotoHome() {
    Get.offAll<void>(HomePage());
  }

  Set<Marker> _prepareMapMarkers(BitmapDescriptor icon) {
    return {
      Marker(
        markerId: MarkerId('marker_id_1'),
        icon: icon,
        position: LatLng(
            double.parse(_appBloc.orderDetailsModel.data!.latitude),
            double.parse(_appBloc.orderDetailsModel.data!.longitude)),
      ),
      Marker(
        icon: icon,
        markerId: MarkerId('marker_id_2'),
        position: LatLng(
            double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLat),
            double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLng)),
      ),
    };
  }

  void _zoomCameraToBounds(GoogleMapController controller) {
    final orderRequest = _appBloc.orderDetailsModel.data!;
    final bounds = MapUtil.getLatLngBounds(
      LatLng(double.parse(orderRequest.latitude),
          double.parse(orderRequest.longitude)),
      LatLng(double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLat),
          double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLng)),
    );
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 25));
  }
}
