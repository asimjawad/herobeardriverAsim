import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/home_Screen_dashboard_model.dart';
import 'package:hero_bear_driver/data/models/location_model.dart';
import 'package:hero_bear_driver/data/models/user_login_model.dart';
import 'package:hero_bear_driver/ui/auth/login_page.dart';
import 'package:hero_bear_driver/ui/capital_page.dart';
import 'package:hero_bear_driver/ui/commission/commission_page.dart';
import 'package:hero_bear_driver/ui/diamond/diamond_page.dart';
import 'package:hero_bear_driver/ui/driver_earning/driver_earning_page.dart';
import 'package:hero_bear_driver/ui/home/home_map_page.dart';
import 'package:hero_bear_driver/ui/loading_page.dart';
import 'package:hero_bear_driver/ui/order_confirm_page/order_confirm_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/deliver_order_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/pick_order_page.dart';
import 'package:hero_bear_driver/ui/profile/profile_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/no_internet_wgt.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _sizeProfileBadge = 60.0;
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),
            child: _buildDrawerHeaderContent(),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(Strings.home),
            onTap: () => _onHomePressed(context),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(Strings.profile),
            onTap: _onProfilePressed,
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text(Strings.lookingOrders),
            onTap: _onLookingOrders,
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(Strings.earnings),
            onTap: _onEarningPressed,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(Strings.capital),
            onTap: _onCapitalPressed,
          ),
          ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text(Strings.diamonds),
            onTap: _oDiamondPressed,
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(Strings.commission),
            onTap: _onCommissionPressed,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(Strings.logOut),
            onTap: _onLogOut,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeaderContent() {
    return FutureBuilder<UserLoginModel>(
      future: _appBloc.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                width: _sizeProfileBadge,
                height: _sizeProfileBadge,
                child: Image.network(
                  user.image,
                  fit: BoxFit.cover,
                  width: _sizeProfileBadge,
                  height: _sizeProfileBadge,
                ),
              ),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(
                user.name,
                style: Styles.onPrimaryTextTheme.headline6,
              ),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(
                user.email,
                style: Styles.onPrimaryTextTheme.bodyText2,
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  void _goToPickOrderPage(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _getOrderRequest());
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<LocationModel>(
      future: _appBloc.location,
      builder: (context, locSnapshot) {
        if (locSnapshot.hasData) {
          return StreamBuilder<HomeScreenDashboardModel>(
            stream: _appBloc.getHomeDataSteam(),
            builder: (context, homeSnapshot) {
              if (homeSnapshot.hasData) {
                if (homeSnapshot.data!.driverStatus ==
                    HomeScreenDashboardModel.statusOnline) {
                  return HomeMapPage(
                    model: homeSnapshot.data!,
                    locModel: locSnapshot.data!,
                  );
                  //_goToPickOrderPage(context);
                } else {
                  return HomeMapPage(
                    model: homeSnapshot.data!,
                    locModel: locSnapshot.data!,
                  );
                }
              } else if (homeSnapshot.hasError) {
                return NoInternetWgt(
                    // todo: add [onTryAgain]
                    );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        if (locSnapshot.hasError) {
          return NoInternetWgt(
              // todo: add [onTryAgain]
              );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onHomePressed(BuildContext context) => Navigator.pop(context);

  void _onProfilePressed() => Get.to<void>(ProfilePage());

  void _onCapitalPressed() => Get.to<void>(CapitalPage());

  void _onEarningPressed() => Get.to<void>(DriverEarningPage());

  void _onCommissionPressed() => Get.to<void>(CommissionPage());

  void _oDiamondPressed() => Get.to<void>(DiamondPage());

  void _onLookingOrders() => Get.to<void>(() => LoadingPage());

  void _onLogOut() async {
    await _appBloc.logOut();
    Get.offAll<void>(() => LoginPage());
  }

  void _getOrderRequest() async {
    final reqData = await _appBloc.orderRequest();
    if (reqData.data != null) {
      //ftech data for obj
      await _appBloc.fetchOrderRequestData();
      final acceptedStatus = await _appBloc.getOrderAcceptedStatus();
      if (acceptedStatus == null) {
        // print("");
        // app runs first time
        await Get.offAll<void>(() => OrderConfirmPage());
        // await Get.offAll<void>(OrderConfirmPage());
      } else if (acceptedStatus) {
        // if order was accepted
        final deliveryStatus = await _appBloc.getOrderDeliveryStatus();
        // check if order is picked or not
        if (deliveryStatus == null) {
          // app runs first time and the order is not picked from the hotel
          await Get.offAll<void>(() => PickOrderPage());
        } else if (deliveryStatus) {
          // order is picked and now must be delivered
          await Get.offAll<void>(DeliverOrderPage());
          // print('a');
        } else {
          // order is not picked.
          await Get.offAll<void>(() => PickOrderPage());
          // print('a');
        }
      } else {
        // order is not accpeted.
        final deliveryStatus = await _appBloc.getOrderDeliveryStatus();
        if (deliveryStatus == null) {
          // app runs first time and the order is not picked from the hotel
          await Get.offAll<void>(() => PickOrderPage());
        } else if (deliveryStatus) {
          // order is picked and now must be delivered
          await Get.offAll<void>(DeliverOrderPage());
          // print('a');
        } else {
          // print('a');
          // order is not picked.
          await Get.offAll<void>(() => PickOrderPage());
        }
        // print('a');
      }
    }
  }
}
