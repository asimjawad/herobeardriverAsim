import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CommissionListItem extends StatelessWidget {
  final _height = 10.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '123456',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${Strings.sCurrency}12.0',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        SizedBox(height: _height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${Strings.status}: pending'),
            SizedBox(height: _height),
            Text('${Strings.createdAt}: 21-jan-02 10:31')
          ],
        ),
        SizedBox(height: _height),
        Divider(height: _height * 2, color: MyColors.grey),
      ]),
    );
  }
}
