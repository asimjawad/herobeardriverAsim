import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class LoadingPage extends StatelessWidget {
  static const _sizeRipple = 300.0;
  static const _sizeBadge = 90.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.lookingForOrders),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
            ),
            scrollGesturesEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Container(
            color: Color(0x88000000),
          ),
          SpinKitRipple(
            size: _sizeRipple,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary,
                ),
              );
            },
          ),
          Center(
            child: SizedBox(
              height: _sizeBadge,
              width: _sizeBadge,
              child: Card(
                shape: CircleBorder(),
                child: Center(child: Text('Loading')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
