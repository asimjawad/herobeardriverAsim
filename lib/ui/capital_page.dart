import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CapitalPage extends StatefulWidget {
  @override
  _CapitalPageState createState() => _CapitalPageState();
}

class _CapitalPageState extends State<CapitalPage> {
  static const _imgSize = 150.0;
  static const _wDropDwn = 100.0;
  final _dropDwnData = <_CapitalData>[
    _CapitalData(
      label: '250',
      value: 250,
    ),
    _CapitalData(
      label: '500',
      value: 500,
    ),
    _CapitalData(
      label: '1000',
      value: 1000,
    ),
    _CapitalData(
      label: Strings.unlimited,
      value: double.infinity,
    ),
  ];
  _CapitalData? _selection;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.capital),
        centerTitle: false,
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
                    Image.asset(
                      MyImgs.money,
                      width: _imgSize,
                      height: _imgSize,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      Strings.capital,
                      style: textTheme.headline5,
                    ),
                    SizedBox(
                      height: Dimens.insetM,
                    ),
                    SizedBox(
                      width: _wDropDwn,
                      child: DropdownButton<_CapitalData>(
                        value: _selection,
                        items: _dropDwnData
                            .map((e) => DropdownMenuItem<_CapitalData>(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.label),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selection = value),
                        hint: Text(
                          Strings.selectCapital,
                          style: textTheme.bodyText2,
                        ),
                        isExpanded: true,
                      ),
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

class _CapitalData {
  String label;
  double value;

  _CapitalData({
    required this.label,
    required this.value,
  });
}
