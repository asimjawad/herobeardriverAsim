import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:location/location.dart';

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
  static const _sizeIcon = 40.0;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.location_on_sharp,
                size: _sizeIcon,
              ),
              SizedBox(
                height: Dimens.insetM,
              ),
              Text(
                Strings.msgLocationWhy,
                style: Styles.appTheme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimens.insetM,
              ),
              ElevatedButton(
                onPressed: () => _onContinue(),
                child: _buildBtnContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtnContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _loading
        ? SizedBox(
      height: _indicatorSize,
      width: _indicatorSize,
      child: CircularProgressIndicator(
        strokeWidth: _indicatorStrokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
      ),
    )
        : Text(Strings.sContinue);
  }

  void _onContinue() async {
    if (!_loading) {
      setState(() => _loading = true);
      // wait for loading animation to complete
      await Future<void>.delayed(Duration(
        seconds: 1,
      ));
      final location = Location();
      if (await location.serviceEnabled()) {
        try {
          final perm = await location.requestPermission();
          if (perm == PermissionStatus.granted ||
              perm == PermissionStatus.grantedLimited) {
            widget.onLocationEnabled?.call();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(Strings.msgNoLoc),
            ));
          }
        } catch (e) {
          // may throw [PermissionRequestInProgressException]
        }
      } else {
        await location.requestPermission();
      }
      setState(() => _loading = false);
    }
  }
}
