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
          title: Text(
            Strings.commission,
            style: Styles.appTheme.accentTextTheme.headline5
                ?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
        body: FutureBuilder<CommissionModel>(
            future: _appBloc.getCommissionData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final commission = snapshot.data!;
                return Container(
                  child: Column(children: [
                    IntrinsicHeight(
                        child: Container(
                      padding: EdgeInsets.all(Dimens.insetM),
                      child: Row(
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
                    commission.data!.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(Dimens.insetM),
                            itemCount: commission.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: CommissionListItem(
                                      commission.data![index]));
                            },
                          )
                        : Center(
                            heightFactor: 1.7,
                            child: Image.asset('assets/images/no_data.png'))
                  ]),
                );
              }
              return SizedBox();
            }),
        bottomNavigationBar: BottomAppBar(
            child: GestureDetector(
          onTap: () => _commisionDialog(
              context, _formKey1, colorScheme, amount, transactionID),
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

// Dialog for payment submission
Future<void> _commisionDialog(
    BuildContext context,
    Key _formKey1,
    ColorScheme colorScheme,
    TextEditingController amount,
    TextEditingController transactionID) {
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
                          Strings.dialogTitle,
                          textAlign: TextAlign.center,
                          style: Styles.appTheme.textTheme.headline5
                              ?.copyWith(color: colorScheme.onPrimary),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                        decoration: BoxDecoration(color: colorScheme.onPrimary),
                        child: Text(
                          Strings.amountLabel,
                          style: Styles.appTheme.textTheme.headline5
                              ?.copyWith(color: colorScheme.onBackground),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: TextField(
                        controller: amount,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.amount),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: TextField(
                        controller: transactionID,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.transactionId),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        if (amount.text.isNotEmpty &&
                            transactionID.text.isNotEmpty) {
                          _snackbarMessage(context, Strings.msgPaymentSuccess);
                        } else {
                          _snackbarMessage(context, Strings.msgEmptyFields);
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          decoration: BoxDecoration(color: colorScheme.primary),
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
        );
      });
}

//snackbar message on modal

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackbarMessage(
    BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
