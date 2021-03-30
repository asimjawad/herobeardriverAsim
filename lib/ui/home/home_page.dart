import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
              ),
            ),
            Column(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
