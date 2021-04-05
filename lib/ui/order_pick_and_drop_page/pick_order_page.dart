import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickOrderPage extends StatelessWidget {
  final double _iconSize = 20;
  final double _iconSizeL = 30;
  final double _containerH = 40;
  final double _sizedBoxW = 15;
  final double _price = 16.33;
  final String _customerName = 'Customer Name';
  final String _restaurantName = 'Restaurant Name';
  final String _hotelAddress = 'The address of the hotel';
  static const double _rowV = 20;
  final String _time = '11:30 AM';
  final int _totalItems = 1;
  final int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        actions: [
          Center(
            child: InkWell(
              onTap: (){

              },
                child: Icon(Icons.list,size: _iconSizeL,),
            ),
          ),
          SizedBox(width: 10,)
        ],
        title: Text('${Strings.pickUpAt} $_time'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.insetM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_restaurantName,maxLines: 2,style: Styles.appTheme.textTheme.headline4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:Dimens.elevationM),
                          child: Text(_hotelAddress, maxLines: 2,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.black54),),
                        ),
                        _directionsAndCallRow(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: _showlineFull(widthMax: true, color: Colors.black54)
                        ),
                        Text(Strings.customerDetails,style: Styles.appTheme.textTheme.headline4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: _showlineFull(widthMax: false, color: MyColors.yellow400)
                        ),
                        Text(_customerName,style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.black54),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: _rowV),
                          child: _directionsAndCallRow(),
                        ),
                        _showlineFull(widthMax: true, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: Text(Strings.orderDetails,style: Styles.appTheme.textTheme.headline4,),
                        ),
                        _showlineFull(widthMax: false, color: MyColors.yellow400),
                        Padding(
                          padding: const EdgeInsets.only(top: _rowV,bottom: 5,),
                          child: Text('$_totalItems ${Strings.totalItem}',style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.black54),),
                        ),
                        Text('${Strings.sCurrency} $_price',style: Styles.appTheme.textTheme.bodyText2?.copyWith(color: Colors.black54),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.insetS),
                          child: ListView.builder(itemBuilder: (BuildContext context, index){
                            return Container(
                              height: 23,
                              width: 23,
                              color: Colors.black54,
                            );
                          },
                          itemCount: _itemCount,
                          shrinkWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
         /* Positioned(
            // bottom: Dimens.insetXs,
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: MyColors.yellow400,
            ),
          )*/
          Padding(
            padding: const EdgeInsets.all(Dimens.insetM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.black54,
                  height: 20,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _directionsAndCallRow(){
    return Row(
      children: [
        GestureDetector(
          onTap: (){

          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.directions,size: _iconSize,color: Colors.white,),
                  Text(Strings.direction,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: _sizedBoxW,),
        GestureDetector(
          onTap: (){

          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.call,size: _iconSize,color: Colors.white,),
                  Text(Strings.call,style: Styles.appTheme.textTheme.bodyText1?.copyWith(color: Colors.white,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _showlineFull({required bool widthMax,required Color color}){
    return Container(
      height: 1,
      width: widthMax ? double.infinity : _containerH,
      color: color,
    );
  }
}
