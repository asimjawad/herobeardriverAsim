import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';

class OrderDetailPage extends StatelessWidget {
  final String _customerName = 'zayn';
  final String _time = '12:44 AM';
  final int _noOfItems = 2;
  final double _total = 13.22;
  final double _sizedBoxW = 20;
  final int _itemCount = 2;
  final String _comment = 'what the fuck i am doing';
  final int _quantity = 3;
  final String _dishName = 'Pizza O Blyat';
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        centerTitle: false,
        title: Text(
          Strings.orderDetail,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.insetS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Text(Strings.customer,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Text(
                  _appBloc.orderDetailsModel.data!.orders[0].user.name,
                  style: Styles.appTheme.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: ShowlineFull(widthMax: true, color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Text(Strings.pickUp,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Text(_time,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: ShowlineFull(widthMax: true, color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Text(Strings.orderDetails,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${_appBloc.orderDetailsModel.data!.orders[0].orderProduct[0].qty} ${Strings.item}'),
                    Padding(
                      padding: const EdgeInsets.only(right: Dimens.insetM),
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.subTotal),
                            SizedBox(
                              width: _sizedBoxW,
                            ),
                            Text(
                                '${Strings.sCurrency}${_appBloc.orderDetailsModel.data!.orders[0].subTotal}'),
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetM),
                child: ShowlineFull(widthMax: true, color: Colors.black54),
              ),
              Expanded(child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                    return _Container(
                      comment: _comment,
                      quantity: _appBloc.orderDetailsModel.data!.orders[0]
                          .orderProduct[0].qty,
                      dishName: _appBloc.orderDetailsModel.data!.orders[0]
                          .orderProduct[0].product!.name,
                    );
                  },
                  itemCount: _appBloc.orderDetailsModel.count,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _Container({required String comment,required int quantity,required String dishName}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.insetXs),
              // height: 20,
              // width: 20,
              color: MyColors.yellow400,
              child: Text(
                '${quantity}x',
                style: Styles.appTheme.textTheme.bodyText1
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.insetXs),
              child: Text(dishName,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimens.insetXs),
          child: Text(
            ' ',
            style: Styles.appTheme.textTheme.bodyText2
                ?.copyWith(color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.insetS),
          child: ShowlineFull(widthMax: true, color: Colors.black54,),
        )
      ],
    );
  }
}
