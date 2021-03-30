import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/ui/values/dimens.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Padding(
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
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        );
                      },
                    ),
                    Card(
                      shape: CircleBorder(),
                      child: IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () => Scaffold.of(context).openDrawer(),
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
        ],
      ),
    );
  }

  Widget _buildUserStatusWgt(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.insetS),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('App Name'),
                Text('text'),
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
                    Icon(Icons.check_box),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('Text'),
                    Text('Text'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('Text'),
                    Text('Text'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.cancel),
                    SizedBox(
                      height: Dimens.insetXs,
                    ),
                    Text('Text'),
                    Text('Text'),
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
