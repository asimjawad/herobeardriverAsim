import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/ui/values/dimens.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class HomePage extends StatelessWidget {
  static const _sizeProfileBadge = 60.0;

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
            child: Column(
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
                Text('User Name'),
                SizedBox(
                  height: Dimens.insetS,
                ),
                Text('user email'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(Strings.home),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(Strings.profile),
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text(Strings.lookingOrders),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(Strings.earnings),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(Strings.capital),
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text(Strings.diamonds),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(Strings.commission),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(Strings.logOut),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.insetM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildUserStatusWgt(context),
                    SizedBox(
                      height: Dimens.insetS,
                    ),
                    ElevatedButton(
                      onPressed: () {},
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

  Widget _buildUserStatusWgt(BuildContext context) {
    return Card(
      elevation: Dimens.elevationM,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.insetS),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.heroBear),
                Text('${Strings.workingCapital}: ${Strings.sCurrency} X'),
              ],
            ),
            SizedBox(
              height: Dimens.insetS,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.beenhere),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('X %'),
                    Text(Strings.acceptance),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('\$ X'),
                    Text(Strings.todaysEarning),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.cancel),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('X %'),
                    Text(Strings.completion),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
