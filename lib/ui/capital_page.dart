import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CapitalPage extends StatefulWidget {
  @override
  _CapitalPageState createState() => _CapitalPageState();
}

class _CapitalPageState extends State<CapitalPage> {
  static const _imgSize = 150.0;
  static const _wDropDwn = 150.0;
  final _appBloc = Get.find<AppBloc>();
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
      value: 10000,
    ),
  ];
  _CapitalData? _selection;

  @override
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(e.label),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selection = value;
                            });
                            _setCapital(context, _selection!.value);
                          },

                          hint: Text(
                            Strings.selectCapital,
                            style: textTheme.bodyText2,
                          ),

                          //  isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _setCapital(BuildContext context, double value) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (builderContext) {
        () async {
          try {
            var message = await _appBloc.setCapital(value);
            Navigator.of(context).pop();
            _snackbarMessage(context, message);
          } catch (e) {
            Navigator.pop(builderContext);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(Strings.somethingWentWrong),
            ));
          }
        }.call();
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackbarMessage(
      BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message.toString()),
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
