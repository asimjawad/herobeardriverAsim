import 'package:flutter/material.dart';
import 'package:hero_bear_driver/data/models/commission_model/data_for_commission_model.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CommissionListItem extends StatelessWidget {
  final DataForCommissionModel commissionData;

  CommissionListItem(this.commissionData);

  final _height = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              commissionData.transactionId,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${Strings.sCurrency}${commissionData.payoutAmount}',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        SizedBox(height: _height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${Strings.status}: ${commissionData.status}'),
            SizedBox(height: _height),
            Text('${Strings.createdAt}: ${commissionData.createdAt}')
          ],
        ),
        SizedBox(height: _height),
        Divider(height: _height * 2, color: MyColors.grey),
      ]),
    );
  }
}
