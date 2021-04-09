import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/diamonds_model/diamonds_model.dart';
import 'package:hero_bear_driver/ui/diamond/diamond_list_item.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class DiamondPage extends StatefulWidget {
  @override
  _DiamondPageState createState() => _DiamondPageState();
}

class _DiamondPageState extends State<DiamondPage> {
  final _formKey1 = GlobalKey<FormState>();
  final diamondTextField = TextEditingController();
  final _appBloc = Get.find<AppBloc>();

  @override
  void dispose() {
    diamondTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const _height = 20.0;
    const _width = 20.0;
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          title: Text(
            Strings.diamonds,
            style: Styles.appTheme.accentTextTheme.headline5
                ?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
        body: FutureBuilder<DiamondsModel>(
            key: UniqueKey(),
            future: _appBloc.getDiamonds(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final diamond = snapshot.data!;
                return Container(
                  child: Column(children: [
                    IntrinsicHeight(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(
                          Dimens.insetM, 24.0, Dimens.insetM, Dimens.insetM),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          totalDiamonds(context, _height, colorScheme, diamond),
                          VerticalDivider(
                            width: _width,
                            color: MyColors.grey,
                          ),
                          withdrawDiamonds(
                              context, _height, colorScheme, diamond),
                        ],
                      ),
                    )),
                    SizedBox(height: _height),
                    Divider(color: MyColors.grey, height: _height),
                    SizedBox(height: _height),
                    _diamondListView(context, diamond)
                  ]),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        bottomNavigationBar: BottomAppBar(
            child: GestureDetector(
          onTap: () =>
              _diamondDialog(context, _formKey1, colorScheme, diamondTextField),
          child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: colorScheme.primary),
              child: Text(
                Strings.submitDiamondsPayment,
                textAlign: TextAlign.center,
                style: Styles.appTheme.textTheme.headline5
                    ?.copyWith(color: colorScheme.onPrimary),
              )),
        )));
  }

  Future<void> _diamondDialog(BuildContext context, Key _formKey1,
      ColorScheme colorScheme, TextEditingController diamondTextField) {
    final _appBloc = Get.find<AppBloc>();
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(color: colorScheme.primary),
                          child: Text(
                            Strings.withdrawDiamonds,
                            textAlign: TextAlign.center,
                            style: Styles.appTheme.textTheme.headline5
                                ?.copyWith(color: colorScheme.onPrimary),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                          decoration:
                              BoxDecoration(color: colorScheme.onPrimary),
                          child: Text(
                            Strings.withdrawDiamondslabel,
                            style: Styles.appTheme.textTheme.headline5
                                ?.copyWith(color: colorScheme.onBackground),
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: TextField(
                          autofocus: true,
                          controller: diamondTextField,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.hintTextDiamonds,
                            hintStyle:
                                Styles.appTheme.textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async {
                          if (diamondTextField.text.isNotEmpty) {
                            var message = await _appBloc.requestDiamond(
                                diamond: diamondTextField.text);

                            _snackbarMessage(context, message);
                            Navigator.pop(context);
                          } else {
                            _snackbarMessage(context, Strings.msgEmptyFields);
                          }
                          setState(() {});
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            decoration:
                                BoxDecoration(color: colorScheme.primary),
                            child: Text(
                              Strings.requestPaymentBtn,
                              textAlign: TextAlign.center,
                              style: Styles.appTheme.textTheme.headline6
                                  ?.copyWith(color: colorScheme.onPrimary),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    // setState(() {});
  }
}

Widget _diamondListView(BuildContext context, DiamondsModel diamond) {
  return Expanded(
      child: diamond.data!.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(Dimens.insetM),
              itemCount: diamond.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(child: DiamondListItem(diamond.data![index]));
              },
            )
          : Center(child: Image.asset(MyImgs.noData)));
}

Widget withdrawDiamonds(BuildContext context, double height,
    ColorScheme colorScheme, DiamondsModel diamond) {
  return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(MyImgs.diamondLogo,
            width: Dimens.sizeIconM, height: Dimens.sizeIconM),
        Text(
          ' 0',
          style: Styles.appTheme.accentTextTheme.headline2
              ?.copyWith(color: colorScheme.onBackground),
        ),
      ],
    ),
    SizedBox(height: height),
    Text(
      Strings.withdrawDiamonds,
      textAlign: TextAlign.center,
      style: Styles.appTheme.accentTextTheme.headline3
          ?.copyWith(color: colorScheme.onBackground),
    )
  ]));
}

Widget totalDiamonds(BuildContext context, double height,
    ColorScheme colorScheme, DiamondsModel diamond) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(MyImgs.diamondLogo,
              width: Dimens.sizeIconM, height: Dimens.sizeIconM),
          Text(
            ' ${diamond.total}',
            style: Styles.appTheme.accentTextTheme.headline2
                ?.copyWith(color: colorScheme.onBackground),
          ),
        ]),
        SizedBox(height: height),
        Text(
          Strings.totalDiamonds,
          textAlign: TextAlign.center,
          style: Styles.appTheme.accentTextTheme.headline3
              ?.copyWith(color: colorScheme.onBackground),
        ),
      ],
    ),
  );
}

// Dialog for payment submission

//snackbar message on modal

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackbarMessage(
    BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message.toString()),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
