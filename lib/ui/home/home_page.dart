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
import 'package:hero_bear_driver/ui/profile/profile_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:tuple/tuple.dart';

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
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(Strings.profile),
            onTap: _onProfilePressed,
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text(Strings.lookingOrders),
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
            leading: Icon(Icons.close),
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
              ClipOval(
                child: Container(
                  color: Colors.white,
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

  Widget _buildBody(BuildContext context) {
    final future = () async {
      return Tuple2<HomeScreenDashboardModel, LocationModel>(
          await _appBloc.getHomeData(), await _appBloc.location);
    }.call();
    return FutureBuilder<Tuple2<HomeScreenDashboardModel, LocationModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tuple = snapshot.data!;
          return HomeMapPage(
            model: tuple.item1,
            locModel: tuple.item2,
          );
        } else if (snapshot.hasError) {
          // todo: handle here
          throw UnimplementedError();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onProfilePressed() => Get.to<void>(ProfilePage());

  void _onCapitalPressed() => Get.to<void>(CapitalPage());

  void _onEarningPressed() => Get.to<void>(DriverEarningPage());

  void _onCommissionPressed() => Get.to<void>(CommissionPage());

  void _oDiamondPressed() => Get.to<void>(DiamondPage());

  void _onLogOut() async {
    await _appBloc.logOut();
    Get.offAll<void>(() => LoginPage());
  }
}
