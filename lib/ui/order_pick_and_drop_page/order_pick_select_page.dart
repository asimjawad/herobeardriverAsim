import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';
import 'package:hero_bear_driver/ui/widgets/order_card_widget.dart';

class OrderPickSelectPage extends StatelessWidget {
  final int _itemCount = 2;
  final double _price = 12.22;
  final int _noOfOrder = 1;
  final String _orderNo = 'HB- 135434';
  final String _userName = 'zayn';
  final String _completeAddress = 'The complete address';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        centerTitle: false,
        title: Text(Strings.noOfOrders),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.insetM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Dimens.insetM),
              child: Text(Strings.noOfOrders,style: Styles.appTheme.textTheme.headline2?.copyWith(fontWeight: FontWeight.w400),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.insetM),
              child: Text('$_noOfOrder ${Strings.order}'),
            ),
            ShowlineFull(widthMax: true, color: Colors.black54),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:Dimens.insetM),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, index){
                    return Column(
                      children: [
                        OrderCard(userName: _userName,orderNo: _orderNo,completeAddress: _completeAddress,price: _price),
                        ShowlineFull(widthMax: true, color: Colors.black54),
                      ],
                    );
                  },
                  itemCount: _itemCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
