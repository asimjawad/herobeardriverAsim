import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/earning_model/earning_model.dart';
import 'package:hero_bear_driver/ui/driver_earning/driver_earning_list_item.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:intl/intl.dart';

class DriverEarningPage extends StatefulWidget {
  @override
  _DriverEarningPageState createState() => _DriverEarningPageState();
}

class _DriverEarningPageState extends State<DriverEarningPage> {
  final _appBloc = Get.find<AppBloc>();

  DateTime currentDateOne = DateTime.now();
  DateTime currentDateTwo = DateTime.now();

  final _height = 10.0;
  final _width = 5.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.yellow400,
          title: Text(
            Strings.driverEarning,
            style: Styles.appTheme.accentTextTheme.headline5
                ?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
        body: FutureBuilder<EarningModel>(
          future:
              _appBloc.getDriverEarningHistory(currentDateOne, currentDateTwo),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final earning = snapshot.data!;
              return Container(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${Strings.sCurrency}${earning.totalEarning}',
                        style: Styles.appTheme.accentTextTheme.headline4
                            ?.copyWith(color: colorScheme.onBackground),
                      ),
                    ),
                    SizedBox(
                      height: _height * 2,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        Strings.todaysEarning,
                        style: Styles.appTheme.accentTextTheme.headline5
                            ?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: colorScheme.onBackground),
                      ),
                    ),
                    Divider(
                      height: _height * 4,
                      color: Colors.grey,
                    ),

                    Table(
                      columnWidths: {
                        0: FractionColumnWidth(0.45),
                        1: FractionColumnWidth(0.45)
                      },
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.pink[50],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(Dimens.insetM),
                                margin: EdgeInsets.only(right: 5.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          onTap: () =>
                                              _selectStartDate(context),
                                          child: Icon(Icons.calendar_today,
                                              color: MyColors.yellow400)),
                                      SizedBox(width: _width),
                                      Text(
                                          DateFormat.yMMMd()
                                              .format(currentDateOne),
                                          style: Styles
                                              .appTheme.textTheme.bodyText1
                                              ?.copyWith(fontSize: 12.0))
                                    ]))
                          ]),
                          Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.all(Dimens.insetM),
                              margin: EdgeInsets.only(left: 5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () => _selectEndDate(context),
                                        child: Icon(Icons.calendar_today,
                                            color: MyColors.yellow400)),
                                    SizedBox(width: _width),
                                    Text(
                                        DateFormat.yMMMd()
                                            .format(currentDateTwo),
                                        style: Styles
                                            .appTheme.textTheme.bodyText1
                                            ?.copyWith(fontSize: 12.0))
                                  ]),
                            )
                          ]),
                        ]),
                      ],
                    ),
                    // ),
                    SizedBox(
                      width: _width * 2,
                    ),
                    earning.order.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            itemCount: earning.order.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: DriverEarningListItem(
                                      earning.order[index]));
                            })
                        : Center(
                            child: Image.asset('assets/images/no_data.png')),

                    SizedBox(
                      height: _height * 2,
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ));
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final pickedDateOne = await showDatePicker(
        context: context,
        initialDate: currentDateOne,
        firstDate: DateTime(1996),
        lastDate: DateTime(2050));
    if (pickedDateOne != null && pickedDateOne != currentDateOne) {
      setState(() {
        currentDateOne = pickedDateOne;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final pickedDateTwo = await showDatePicker(
        context: context,
        initialDate: currentDateTwo,
        firstDate: DateTime(1996),
        lastDate: DateTime(2050));
    if (pickedDateTwo != null && pickedDateTwo != currentDateTwo) {
      setState(() {
        currentDateTwo = pickedDateTwo;
      });
    }
  }
}
