import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class SelectAReason extends StatelessWidget {
  final _itemCount = 1;
  final _reason = Strings.deliveryIsTooFar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.insetM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.pleaseSelectAReason,style: Styles.appTheme.textTheme.headline4,),
              ListView.builder(itemBuilder: (BuildContext context, index){
                return _container(_reason);
              },
                shrinkWrap: true,
                itemCount: _itemCount,
                padding: EdgeInsets.all(Dimens.insetM),
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _container(String reason){
    return  Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reason,style: Styles.appTheme.textTheme.bodyText1,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
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
