import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CapitalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.capital),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.insetM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: Dimens.elevationM,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.insetM),
                child: Column(
                  children: [
                    Text(
                      Strings.capital,
                      style: textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
