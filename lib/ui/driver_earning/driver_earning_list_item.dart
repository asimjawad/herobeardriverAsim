import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class DriverEarningListItem extends StatelessWidget {
  final _height = 20.0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.insetM),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'HB-845454800',
              style: Styles.appTheme.accentTextTheme.headline6
                  ?.copyWith(color: Colors.black26),
            ),
            Text('18.0',
                style: Styles.appTheme.accentTextTheme.headline6
                    ?.copyWith(color: Colors.black26)),
          ]),
        ),
        SizedBox(height: _height),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.insetM),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${Strings.delieverDate}: 21 jan-01 09:52',
              style: Styles.appTheme.accentTextTheme.subtitle1
                  ?.copyWith(color: colorScheme.onBackground),
            ),
            Text(
              '${Strings.items}: 1',
              style: Styles.appTheme.accentTextTheme.subtitle1
                  ?.copyWith(color: colorScheme.onBackground),
            ),
          ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.insetM),
          child: Divider(
            height: _height * 2,
            color: MyColors.grey,
          ),
        )
      ],
    ));
  }
}
