import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

Widget OrderCard({required String orderNo,required double price, required String userName, required String completeAddress}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(Strings.orderNo,style: Styles.appTheme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),),
              Text(orderNo,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54,),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: Dimens.insetM),
            child: Text('${Strings.sCurrency} $price',style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54,),),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: Dimens.insetXs),
        child: Text(userName,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w500,),),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: Dimens.insetS),
        child: Text(completeAddress,overflow: TextOverflow.ellipsis,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54,),),
      )
    ],
  );
}