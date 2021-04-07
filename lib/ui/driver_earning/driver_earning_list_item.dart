import 'package:flutter/material.dart';
import 'package:hero_bear_driver/data/models/earning_model/order_for_earning_model.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class DriverEarningListItem extends StatelessWidget {
  final OrderForEarningModel orderData;

  DriverEarningListItem(this.orderData);

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
                  orderData.orderNo,
              style: Styles.appTheme.accentTextTheme.headline6
                  ?.copyWith(color: Colors.black26),
            ),
                Text(orderData.earning,
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
                  '${Strings.delieverDate}: ${orderData.delivery}',
              style: Styles.appTheme.accentTextTheme.subtitle1
                  ?.copyWith(color: colorScheme.onBackground),
            ),
                Text(
                  '${Strings.items}:${orderData.items}',
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
