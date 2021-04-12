import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/ui/home/bottom_sheet_check_wgt.dart';
import 'package:hero_bear_driver/ui/home/user_dashboard_wgt.dart';
import 'package:hero_bear_driver/ui/loading_page.dart';
import 'package:hero_bear_driver/ui/order_confirm_page/order_confirm_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/deliver_order_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/pick_order_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class HomeMapPage extends StatefulWidget {
  final HomeScreenDashboardModel model;
  final LocationModel locModel;

  HomeMapPage({
    required this.model,
    required this.locModel,
  });

  @override
  _HomeMapPageState createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  static const _badgeRadius = 25.0;
  static const _mapZoomLvl = 18.0;
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.locModel.latLng.latitude,
                widget.locModel.latLng.longitude),
            zoom: _mapZoomLvl,
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.insetM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        return Card(
                          shape: CircleBorder(),
                          child: IconButton(
                            icon: Icon(Icons.list),
                            color: colorScheme.primary,
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        );
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: Dimens.insetM,
                        ),
                        _buildOnlineWgt(context, widget.model),
                      ],
                    ),
                    Card(
                      shape: CircleBorder(),
                      child: IconButton(
                        icon: Text(
                          '?',
                          style: TextStyle(
                            fontSize: Dimens.sizeIconM,
                            color: colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          Get.to<void>(() => LoadingPage());
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildUserStatusWgt(context, widget.model),
                    SizedBox(
                      height: Dimens.insetS,
                    ),
                    _buildButton(context, widget.model),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserStatusWgt(
      BuildContext context, HomeScreenDashboardModel model) {
    return UserDashboardWgt(
      acceptance: model.acceptance.toDouble(),
      capital: model.capital,
      completion: model.decline.toDouble(),
      earning: model.todaysEarning.toDouble(),
    );
  }

  Widget _buildButton(BuildContext context, HomeScreenDashboardModel model) {
    var online =
        widget.model.driverStatus == HomeScreenDashboardModel.statusOnline;
    return ElevatedButton(
      onPressed: () => _onToggleOnline(context, model),
      style: online
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.red500),
            )
          : null,
      child: Text(online ? Strings.returnToDelivery : Strings.goOnline),
    );
  }

  Widget _buildOnlineWgt(BuildContext context, HomeScreenDashboardModel model) {
    if (model.driverStatus == HomeScreenDashboardModel.statusOnline) {
      final textTheme = Theme.of(context).textTheme;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_badgeRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.insetM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.youAreOnlineIn),
              SizedBox(
                height: Dimens.insetS,
              ),
              GestureDetector(
                onTap: () => _onGoOffline(context),
                child: Text(
                  Strings.endDelivery,
                  style: textTheme.subtitle1!.copyWith(
                    color: MyColors.red500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_badgeRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.insetM),
        child: Text(Strings.youAreOffline),
      ),
    );
  }

  void _onToggleOnline(BuildContext context, HomeScreenDashboardModel model) {
    if (model.driverStatus == HomeScreenDashboardModel.statusOffline) {
      showModalBottomSheet<void>(
        context: context,
        builder: (builderContext) => BottomSheetCheck(
          onReady: () {
            Navigator.pop(builderContext);
            showDialog<void>(
              context: context,
              builder: (builderContext2) {
                () async {
                  try {
                    await _appBloc.setUserOnline();
                    setState(() {});
                  } catch (e) {}
                  Navigator.pop(builderContext2);
                }.call();
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      );
    } else {
      Get.to<void>(() => LoadingPage());
    }
  void _onGoOnline(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (builderContext) => BottomSheetCheck(
        onReady: () {
          Navigator.pop(builderContext);
          showDialog<void>(
            context: context,
            builder: (builderContext2) {
              () async {
                try {
                  await _appBloc.setUserOnline();
                  _checkOrderRequest();
                  setState(() {});
                } catch (e) {}
                Navigator.pop(builderContext2);
              }.call();
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }

  void _onGoOffline(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (builderContext) {
        () async {
          try {
            await _appBloc.setUserOffline();
            setState(() {});
          } catch (e) {}
          Navigator.pop(builderContext);
        }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _checkOrderRequest() async {
    // await _appBloc.setOrderAcceptedStatus(true);
    /*await _appBloc.setOrderAcceptedStatus(false);
    await _appBloc.setOrderDeliveryStatus(true);*/
    final reqData = await _appBloc.orderRequest();
    if (reqData.data != null) {
      //ftech data for obj
      await _appBloc.fetchOrderRequestData();
      final acceptedStatus = await _appBloc.getOrderAcceptedStatus();
      if (acceptedStatus == null) {
        await Get.to<void>(OrderConfirmPage());
      } else if (acceptedStatus) {
        // if order was accepted
        final deliveryStatus = await _appBloc.getOrderDeliveryStatus();
        // check if order is picked or not
        if (deliveryStatus == null) {
          await Get.to<void>(() => PickOrderPage());
        } else if (deliveryStatus) {
          await Get.to<void>(DeliverOrderPage());
          print('a');
        } else {
          await Get.to<void>(() => PickOrderPage());
          print('a');
        }
      } else {
        final deliveryStatus = await _appBloc.getOrderDeliveryStatus();
        if (deliveryStatus == null) {
        } else if (deliveryStatus) {
          await Get.to<void>(DeliverOrderPage());
          print('a');
        } else {
          print('a');
        }
        print('a');
      }
    }
  }
}
