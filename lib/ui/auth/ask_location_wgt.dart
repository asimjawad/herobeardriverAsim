import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class AskLocationWgt extends StatefulWidget {
  void Function()? onLocationEnabled;

  AskLocationWgt({
    this.onLocationEnabled,
  });

  @override
  _AskLocationWgtState createState() => _AskLocationWgtState();
}

class _AskLocationWgtState extends State<AskLocationWgt> {
  static const _indicatorSize = 15.0;
  static const _indicatorStrokeWidth = 2.0;
  static const _contentPadding = 25.0;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: Dimens.elevationM,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_contentPadding),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.msgLocationWhy,
                style: Styles.appTheme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimens.insetM,
              ),
              ElevatedButton(
                onPressed: _onEnableLocation,
                child: FutureBuilder<LocationPermission>(
                  future: Geolocator.checkPermission(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final perm = snapshot.data;
                      if (perm == LocationPermission.deniedForever) {
                        return Text(Strings.openSettings);
                      }
                    }
                    return Text(Strings.enable);
                  },
                ),
              ),
              SizedBox(
                height: Dimens.insetXs,
              ),
              ElevatedButton(
                onPressed: () => _onContinue(),
                child: _loading
                    ? SizedBox(
                        width: _indicatorSize,
                        height: _indicatorSize,
                        child: CircularProgressIndicator(
                          strokeWidth: _indicatorStrokeWidth,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.onPrimary),
                        ),
                      )
                    : Text(Strings.sContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEnableLocation() async {
    try {
      final perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
      }
    } catch (e) {
      // may throw [PermissionRequestInProgressException]
    }
  }

  void _onContinue() async {
    if (!_loading) {
      setState(() => _loading = true);
      // wait for loading animation to complete
      await Future<void>.delayed(Duration(
        seconds: 1,
      ));
      final perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.always ||
          perm == LocationPermission.whileInUse) {
        widget.onLocationEnabled?.call();
      }
      setState(() => _loading = false);
    }
  }
}
