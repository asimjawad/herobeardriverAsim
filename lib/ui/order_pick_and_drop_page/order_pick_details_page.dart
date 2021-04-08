import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/slider_widget.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/pick_photo_and_confirm_dialog.dart';
import 'dart:io';

class OrderPickDetailsPage extends StatefulWidget {
  @override
  _OrderPickDetailsPageState createState() => _OrderPickDetailsPageState();
}

class _OrderPickDetailsPageState extends State<OrderPickDetailsPage> {
  final String _customerName = 'zayn';

  final String _time = '12:44 AM';

  final int _noOfItems = 2;

  final double _total = 13.22;

  final double _sizedBoxW = 20;

  final int _itemCount = 2;

  final String _comment = 'what the fuck i am doing';

  final int _quantity = 3;

  final String _dishName = 'Pizza O Blyat';

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        centerTitle: false,
        title: Text(Strings.orderDetail,),
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
                child: Text(_customerName,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),),
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
                    Text('$_noOfItems ${Strings.item}'),
                    Padding(
                      padding: const EdgeInsets.only(right: Dimens.insetM),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(Strings.subTotal),
                            SizedBox(width: _sizedBoxW,),
                            Text('${Strings.sCurrency}$_total'),
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.insetM),
                child: ShowlineFull(widthMax: true, color: Colors.black54),
              ),
              Expanded(child: ListView.builder(itemBuilder: (BuildContext context, index){
                return _Container(comment: _comment,quantity: _quantity,dishName: _dishName,);
              },
                itemCount: _itemCount,
              ),
              ),
              Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SliderWidget(func:() =>_CheckForCommonItems(context: context),),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(child: Text(Strings.slideAfterArrival,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white,fontWeight: FontWeight.w700),)),
                      ),

                    ],
                  ),
                ],
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
              child: Text('${_quantity}x',style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.insetXs),
              child: Text(dishName,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimens.insetXs),
          child: Text(comment,style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.black54),),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.insetS),
          child: ShowlineFull(widthMax: true, color: Colors.black54,),
        ),
      ],
    );
  }

  void _CheckForCommonItems({required BuildContext context}){
    showDialog<void>(context: context,
        builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.insetS),
        ),
        elevation: 0,
        // backgroundColor: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.insetS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline_rounded,size: 50,color: MyColors.yellow600,),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetM),
                child: Text(Strings.holdon,style: Styles.appTheme.textTheme.headline3?.copyWith(color: MyColors.yellow400,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.insetM),
                child: Text(Strings.checkForCommonlyMissedItems, maxLines: 2,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetS),
                child: Text(Strings.drinks,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetS),
                child: Text(Strings.sides,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetS),
                child: Text(Strings.sauces,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetS),
                child: Text(Strings.utensils,style: Styles.appTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.insetM),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      },
                        child: Text(Strings.cancel,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: MyColors.yellow400),),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        _CheckOut(context);
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: MyColors.yellow400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(Strings.ok,style: Styles.appTheme.textTheme.headline4?.copyWith(color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _CheckOut(BuildContext context){
    showDialog<void>(context: context, builder: (context){
      return PickPhotoAndConfirmDialog(total: _total,);
    });
  }


}