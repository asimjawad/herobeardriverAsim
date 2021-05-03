import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class UserDashboardWgt extends StatelessWidget {
  final double acceptance;
  final double earning;
  final double completion;
  final double capital;

  UserDashboardWgt({
    required this.acceptance,
    required this.earning,
    required this.completion,
    required this.capital,
  });

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('##0.00#', 'en_US');
    final data = <Tuple3<IconData, String, String>>[
      Tuple3(Icons.beenhere, Strings.acceptance, '${f.format(acceptance)} %'),
      Tuple3(Icons.attach_money, Strings.todaysEarning,
          '${Strings.sCurrency}${f.format(earning)}'),
      Tuple3(Icons.cancel, Strings.completion, '${f.format(completion)} %'),
    ];
    final theme = Theme.of(context);
    return Card(
      elevation: Dimens.elevationM,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.insetS),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.heroBear),
                Text(
                  '${Strings.workingCapital}: ${capital < 10000 ? NumberFormat.compactCurrency(symbol: Strings.sCurrency).format(capital) : Strings.unlimited}',
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
            SizedBox(
              height: Dimens.insetM,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data
                  .map(
                    (e) => Column(
                      children: [
                        e.item1 == Icons.attach_money
                            ? Text(
                                Strings.sCurrency,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Icon(e.item1),
                        SizedBox(
                          height: Dimens.insetS,
                        ),
                        Text(
                          e.item3,
                          style: theme.accentTextTheme.headline4,
                        ),
                        SizedBox(
                          height: Dimens.insetXs,
                        ),
                        Text(e.item2),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
