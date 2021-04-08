import 'package:flutter/material.dart';
import 'package:hero_bear_driver/data/models/diamonds_model/data_for_diamond_model.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class DiamondListItem extends StatelessWidget {
  final DataForDiamondModel diamondData;

  DiamondListItem(this.diamondData);

  final _height = 10.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${Strings.trans}${diamondData.transactionId}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${Strings.sCurrency}${diamondData.amount}',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        SizedBox(height: _height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${Strings.transaction} ${diamondData.status == '0' ? Strings.pending : Strings.completed}',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: colorScheme.error, fontWeight: FontWeight.normal)),
            SizedBox(height: _height),
            Text('${Strings.diamond}${diamondData.diamond}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
        SizedBox(height: _height),
        Divider(height: _height * 2, color: MyColors.grey),
      ]),
    );
  }
}
