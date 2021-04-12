import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtil {
  static LatLngBounds getLatLngBounds(LatLng point1, LatLng point2) {
    return LatLngBounds(
      northeast: LatLng(max(point1.latitude, point2.latitude),
          max(point1.longitude, point2.longitude)),
      southwest: LatLng(min(point1.latitude, point2.latitude),
          min(point1.longitude, point2.longitude)),
    );
  }

  static Future<BitmapDescriptor> getBitmapDescriptor(
      BuildContext context, String assetName, double height) async {
    final dpRatio = MediaQuery.of(context).devicePixelRatio;
    ByteData data = await rootBundle.load(assetName);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: (height * dpRatio).toInt(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    final bytes = (await fi.image.toByteData(format: ui.ImageByteFormat.png))
            ?.buffer
            .asUint8List() ??
        Uint8List(1); // create a useless list if null
    return BitmapDescriptor.fromBytes(bytes);
  }

  MapUtil._();
}
