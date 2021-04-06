import 'package:flutter/material.dart';
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
      body: Container(
        child: Column(children: [
          IntrinsicHeight(
              child: Container(
            padding: EdgeInsets.all(Dimens.insetM),
            child: Row(
              children: [
                totalCommission(context, _height, colorScheme),
                VerticalDivider(
                  width: _width,
                  color: MyColors.grey,
                ),
                paidCommission(context, _height, colorScheme),
                VerticalDivider(
                  width: _width,
                  color: MyColors.grey,
                ),
                pendingCommission(context, _height, colorScheme)
              ],
            ),
          )),
          Divider(color: MyColors.grey, height: _height),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(Dimens.insetM),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: CommissionListItem(),
                  );
                }),
          ),
        ]),
      ),
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
      )),
    );
  }
}

Widget pendingCommission(
    BuildContext context, double height, ColorScheme colorScheme) {
  return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Text(
      '${Strings.sCurrency} 7.00',
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

Widget paidCommission(
    BuildContext context, double height, ColorScheme colorScheme) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${Strings.sCurrency} 0.00',
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

Widget totalCommission(
    BuildContext context, double height, ColorScheme colorScheme) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${Strings.sCurrency} 7.00',
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
          title: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(color: colorScheme.primary),
              child: Text(
                Strings.dialogTitle,
                textAlign: TextAlign.center,
                style: Styles.appTheme.textTheme.headline5
                    ?.copyWith(color: colorScheme.onPrimary),
              )),
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKey1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0, bottom: 16.0),
                        decoration: BoxDecoration(color: colorScheme.onPrimary),
                        child: Text(
                          Strings.amountLabel,
                          style: Styles.appTheme.textTheme.headline5
                              ?.copyWith(color: colorScheme.onBackground),
                        )),
                    Padding(
                      padding: EdgeInsets.all(Dimens.insetS),
                      child: TextField(
                        controller: amount,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.amount),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimens.insetS),
                      child: TextField(
                        controller: transactionID,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.transactionId),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (amount.text.isNotEmpty &&
                            transactionID.text.isNotEmpty) {
                          _snackbarMessage(context, Strings.msgPaymentSuccess);
                        } else {
                          _snackbarMessage(context, Strings.msgEmptyFields);
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(Strings.paymentSubmitBtn)),
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
