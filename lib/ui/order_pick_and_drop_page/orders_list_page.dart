import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/order_detail_page.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/order_card_widget.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';

class OrdersListPage extends StatelessWidget {
  final int _itemCount = 3;
  final double _price = 14.44;
  final String _userName = 'zayn';
  final String _orderNo = 'HB- 1353867';
  final String _completeAddress = 'Complete Address';
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(Strings.ordersList),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (BuildContext context, index){
              return Padding(
                padding: const EdgeInsets.all(Dimens.insetS),
                child: Column(
                  children: [
                      GestureDetector(
                        onTap: () {
                          Get.to<void>(() => OrderDetailPage());
                        },
                        child: OrderCard(
                            price: double.parse(_appBloc
                                .orderDetailsModel.data!.orders[0].total),
                            completeAddress: _appBloc.orderDetailsModel.data!
                                .orders[0].deliveryAddress,
                            orderNo: _appBloc.orderDetailsModel.orderNos![0],
                            userName: _appBloc
                                .orderDetailsModel.data!.orders[0].user.name),
                      ),
                      ShowlineFull(color: Colors.black54, widthMax: true),
                    ],
                  ),
                );
              },
              itemCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
