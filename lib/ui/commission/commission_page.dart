import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/commission_model/comission_model.dart';
import 'package:hero_bear_driver/ui/commission/commission_list_item.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class CommissionPage extends StatefulWidget {
  @override
  _CommissionPageState createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  final _formKey1 = GlobalKey<FormState>();
  final amount = TextEditingController();
  final transactionID = TextEditingController();
  final _appBloc = Get.find<AppBloc>();

  @override
  void dispose() {
    amount.dispose();
    transactionID.dispose();
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
            Strings.commission,
            style: Styles.appTheme.accentTextTheme.headline5
                ?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
        body: FutureBuilder<CommissionModel>(
            key: UniqueKey(),
            future: _appBloc.getCommissionData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final commission = snapshot.data!;
                return Container(
                  child: Column(children: [
                    IntrinsicHeight(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(
                          Dimens.insetM, 24.0, Dimens.insetM, Dimens.insetM),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          totalCommission(
                              context, _height, colorScheme, commission),
                          VerticalDivider(
                            width: _width,
                            color: MyColors.grey,
                          ),
                          paidCommission(
                              context, _height, colorScheme, commission),
                          VerticalDivider(
                            width: _width,
                            color: MyColors.grey,
                          ),
                          pendingCommission(
                              context, _height, colorScheme, commission)
                        ],
                      ),
                    )),
                    Divider(color: MyColors.grey, height: _height),
                    _commissionListView(context, commission)
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
              _commissionDialog(context, colorScheme, amount, transactionID),
          child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: colorScheme.primary),
              child: Text(
                Strings.submitCommission,
                textAlign: TextAlign.center,
                style: Styles.appTheme.textTheme.headline5
                    ?.copyWith(color: colorScheme.onPrimary),
              )),
        )));
  }

// Dialog for payment submission
  Future<void> _commissionDialog(BuildContext context, ColorScheme colorScheme,
      TextEditingController payoutAmount, TextEditingController transactionId) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            decoration:
                                BoxDecoration(color: colorScheme.primary),
                            child: Text(
                              Strings.dialogTitle,
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
                              Strings.amountLabel,
                              style: Styles.appTheme.textTheme.headline5
                                  ?.copyWith(color: colorScheme.onBackground),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: TextFormField(
                            controller: payoutAmount,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Strings.msgEmptyPayout;
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: Strings.amount),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Strings.msgEmptyTransId;
                              }
                            },
                            controller: transactionId,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: Strings.transactionId),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey1.currentState!.validate()) {
                              await _onSubmit(context, payoutAmount.text,
                                  transactionId.text);
                              payoutAmount.clear();
                              transactionId.clear();
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              decoration:
                                  BoxDecoration(color: colorScheme.primary),
                              child: Text(
                                Strings.paymentSubmitBtn,
                                textAlign: TextAlign.center,
                                style: Styles.appTheme.textTheme.headline5
                                    ?.copyWith(color: colorScheme.onPrimary),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //loading dialog on submitting form

  Future<void> _onSubmit(
      BuildContext context, String payoutAmount, String transactionId) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (builderContext) {
        () async {
          try {
            var message = await _appBloc.submitPayment(
                payoutAmount: payoutAmount, transactionId: transactionId);
            Navigator.pop(context);
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
}

Widget _commissionListView(BuildContext context, CommissionModel commission) {
  return Expanded(
      child: commission.data!.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              padding: const EdgeInsets.all(Dimens.insetM),
              itemCount: commission.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: CommissionListItem(commission.data![index]));
              },
            )
          : Center(child: Image.asset(MyImgs.noData)));
}

Widget pendingCommission(BuildContext context, double height,
    ColorScheme colorScheme, CommissionModel commissionModel) {
  return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Text(
      '${Strings.sCurrency} ${commissionModel.pendingCommission}',
      style: Styles.appTheme.accentTextTheme.headline2
          ?.copyWith(color: colorScheme.onBackground),
    ),
    SizedBox(height: height),
    Text(
      Strings.pendingCommission,
      textAlign: TextAlign.center,
      style: Styles.appTheme.accentTextTheme.headline6
          ?.copyWith(color: colorScheme.onBackground),
    )
  ]));
}

Widget paidCommission(BuildContext context, double height,
    ColorScheme colorScheme, CommissionModel commissionModal) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${Strings.sCurrency} ${commissionModal.paidCommissiom}',
          style: Styles.appTheme.accentTextTheme.headline2
              ?.copyWith(color: colorScheme.onBackground),
        ),
        SizedBox(height: height),
        Text(
          Strings.paidCommission,
          textAlign: TextAlign.center,
          style: Styles.appTheme.accentTextTheme.headline6
              ?.copyWith(color: colorScheme.onBackground),
        ),
      ],
    ),
  );
}

Widget totalCommission(BuildContext context, double height,
    ColorScheme colorScheme, CommissionModel commissionModel) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${Strings.sCurrency} ${commissionModel.totalCommission}',
          textAlign: TextAlign.center,
          style: Styles.appTheme.accentTextTheme.headline2
              ?.copyWith(color: colorScheme.onBackground),
        ),
        SizedBox(height: height),
        Text(
          Strings.totalCommission,
          textAlign: TextAlign.center,
          style: Styles.appTheme.accentTextTheme.headline6
              ?.copyWith(color: colorScheme.onBackground),
        ),
      ],
    ),
  );
}

//snackbar message on modal

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackbarMessage(
    BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message.toString()),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
