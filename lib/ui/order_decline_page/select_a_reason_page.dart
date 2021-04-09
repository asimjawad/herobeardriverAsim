import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/get_reason_model/get_reason_model.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class SelectAReason extends StatelessWidget {
  final _itemCount = 1;
  final _reason = Strings.deliveryIsTooFar;
  static const double marginH = 3;
  static const double marginV = 5;
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetReasonModel>(
        future: _appBloc.getReason(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _content(snapshot.data!);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _content(GetReasonModel model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.insetM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.pleaseSelectAReason,
              style: Styles.appTheme.textTheme.headline4,
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: _container(model.data[index].reason),
                );
              },
              shrinkWrap: true,
              itemCount: _itemCount,
              padding: EdgeInsets.all(Dimens.insetM),
              scrollDirection: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }

  Widget _container(String reason) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reason,
          style: Styles.appTheme.textTheme.bodyText1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: marginH,vertical: marginV),
          child: Container(
            width: double.infinity,
            color: Colors.black,
            height: 1,
          ),
        )
      ],
    ));
  }
}
