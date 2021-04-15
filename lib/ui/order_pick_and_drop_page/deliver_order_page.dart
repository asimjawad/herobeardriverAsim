import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/home/home_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/deliver_photo_and_confirm_dialog.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/pending_orders_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/slider_widget.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliverOrderPage extends StatelessWidget {
  final double _iconSize = 25;
  final double _iconSizeS = 20;
  final double _iconSizeL = 30;
  static const double _rowV = 20;
  final _appBloc = Get.find<AppBloc>();
  File? imageSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                Get.to<void>(() => PendingOrdersPage());
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
        title: Text('${Strings.deliverDetail}'),
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
            maxChildSize: 1,
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.deliverFor,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimens.insetS),
                                    child: Text(
                                      _appBloc.orderDetailsModel.data!.orders[0]
                                          .user.name,
                                      style: Styles.appTheme.textTheme.bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  _makePhoneCall(
                                      'tel:${_appBloc.orderDetailsModel.data!.orders[0].user.phone}');
                                },
                                child: Container(
                                  child:
                                  Center(child: Icon(Icons.phone,size: _iconSizeL,color: Colors.black54,),),
                                ),
                              ),
                            ]
                        ),
                        ShowlineFull(widthMax: true, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimens.insetS,
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: _iconSize,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.address,
                                      style: Styles.appTheme.textTheme.bodyText1
                                          ?.copyWith(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w800),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: Dimens.insetS),
                                      child: Text(
                                        '${_appBloc.orderDetailsModel.data!.orders[0].deliveryAddress}',
                                        style: Styles
                                            .appTheme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.black54),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _launchMapsUrl(
                                                double.parse(_appBloc
                                                    .orderDetailsModel
                                                    .data!
                                                    .orders[0]
                                                    .dLat),
                                                double.parse(_appBloc
                                                    .orderDetailsModel
                                                    .data!
                                                    .orders[0]
                                                    .dLng));
                                          },
                                          child: Container(
                                            color: Colors.black26,
                                            padding: EdgeInsets.symmetric(
                                                vertical: Dimens.insetS,
                                                horizontal: Dimens.insetXs),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.directions_rounded,
                                                  size: _iconSizeS,
                                                ),
                                                SizedBox(
                                                  width: Dimens.insetXs,
                                                ),
                                                Text(
                                                  Strings.direction,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ShowlineFull(widthMax: true, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: Dimens.insetS),
                                child: Icon(Icons.message,size: _iconSize,color: Colors.grey,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.leaveAtTheDoor,
                                    style: Styles.appTheme.textTheme.bodyText1
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    Strings.leaveAtMyDoorknockTheDoor,
                                    style: Styles.appTheme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ShowlineFull(color: Colors.black54,widthMax: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: Dimens.insetS),
                                child: Icon(Icons.cloud_download,size: _iconSize,color: Colors.grey,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.totalItem,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54,fontWeight: FontWeight.w800)),
                                  Text('items',style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.black54)),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                    SliderWidget(func:()=> OrderDeliveredDialog(context),),
                    Padding(
                      padding: const EdgeInsets.only(top: _rowV),
                      child: Center(child: Text(Strings.iHaveArrivedAtCustomer,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white,fontWeight: FontWeight.w700),)),
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

  void OrderDeliveredDialog(BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DeliverPhotoAndConfirmDialog(
            total:
                double.parse(_appBloc.orderDetailsModel.data!.orders[0].total),
            callApi: () => ordeCompleteByDriver(context),
            imageCallBack: imageCallBack,
          );
        });
  }

  void ordeCompleteByDriver(BuildContext context) async {
    await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    final res = await _appBloc.orderCompleteByDriver(
        orderNo: _appBloc.orderDetailsModel.orderNos![0],
        image: imageSelected!,
        userId: int.parse(_appBloc.orderDetailsModel.data!.orders[0].userId));
    if (res == true) {
      await _appBloc.setOrderAcceptedStatus(false);
      await _appBloc.setOrderDeliveryStatus(false);
      await Get.offAll<void>(() => HomePage());
    } else if (res == false) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          Strings.tryAgain,
          style: Styles.appTheme.textTheme.bodyText1!
              .copyWith(color: MyColors.yellow400),
        ),
        duration: Duration(milliseconds: 2000),
      ));
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          Strings.somethingWentWrong,
          style: Styles.appTheme.textTheme.bodyText1!
              .copyWith(color: MyColors.yellow400),
        ),
        duration: Duration(milliseconds: 2000),
      ));
    }
  }

  void imageCallBack(File a) {
    imageSelected = a;
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
