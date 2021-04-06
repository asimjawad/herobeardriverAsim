import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/driver_earning/driver_earning_list_item.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class DriverEarningPage extends StatefulWidget {
  @override
  _DriverEarningPageState createState() => _DriverEarningPageState();
}

class _DriverEarningPageState extends State<DriverEarningPage> {
  DateTime currentDate = DateTime.now();
  final _height = 10.0;
  final _width = 5.0;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1996),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

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
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                '${Strings.sCurrency}18.00',
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
                style: Styles.appTheme.accentTextTheme.headline5?.copyWith(
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
                TableRow(
               
                  children: [

                  Column(children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: BorderRadius.circular(10)),
                         padding: EdgeInsets.all(Dimens.insetM),
                          margin: EdgeInsets.only(right:5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () => _selectDate(context),
                                    child: Icon(Icons.calendar_today,
                                        color: MyColors.yellow400)),
                                SizedBox(width: _width),
                                Text('10-12-2021',
                                    style: Styles.appTheme.textTheme.bodyText1
                                        ?.copyWith(fontSize: 12.0))
                              ]))
                    ]),
                  
                Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.all(Dimens.insetM),
                         margin: EdgeInsets.only(left:5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () => _selectDate(context),
                                  child: Icon(Icons.calendar_today,
                                      color: MyColors.yellow400)),
                              SizedBox(width: _width),
                              Text('10-12-2021',
                                  style: Styles.appTheme.textTheme.bodyText1
                                      ?.copyWith(fontSize: 12.0))
                            ]),
                      )
                    ]),
                  
                ]),
              ],
            ),
            // ),
            SizedBox(
              width: _width*2,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(child: DriverEarningListItem());
                  }),
            ),

            SizedBox(
              height: _height * 2,
            ),
          ],
        ),
      ),
    );
  }
}
