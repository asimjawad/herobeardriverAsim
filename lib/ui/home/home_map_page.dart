import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/ui/home/bottomSheetCheck.dart';
import 'package:hero_bear_driver/ui/home/user_dashboard_wgt.dart';
import 'package:hero_bear_driver/ui/order_confirm_page/order_confirm_page.dart';
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
                          Get.to<void>(OrderConfirmPage());
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
                    ElevatedButton(
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Text(Strings.goOnline),
                    ),
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

  Widget _buildOnlineWgt(BuildContext context, HomeScreenDashboardModel model) {
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

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => BottomSheetCheck(
        onReady: () {
          // _appBloc;
        },
      ),
    );
  }
}
