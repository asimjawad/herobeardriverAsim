import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/map_client.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/order_pick_select_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/orders_list_page.dart';
import 'package:hero_bear_driver/ui/order_pick_and_drop_page/slider_widget.dart';
import 'package:hero_bear_driver/ui/values/values.dart';
import 'package:hero_bear_driver/ui/widgets/show_full_line_widget.dart';
import 'package:hero_bear_driver/util/map_util.dart';
import 'package:url_launcher/url_launcher.dart';

class PickOrderPage extends StatefulWidget {
  static const double _rowV = 20;

  @override
  _PickOrderPageState createState() => _PickOrderPageState();
}

class _PickOrderPageState extends State<PickOrderPage> {
  DateTime dateTime = DateTime.now();

  final double _iconSize = 20;

  final double _iconSizeL = 30;

  final double _containerH = 40;

  final double _sizedBoxW = 15;

  final double _price = 16.33;

  final String _customerName = 'Customer Name';

  final String _restaurantName = 'Restaurant Name';

  final String _hotelAddress = 'The address of the hotel';

  final String _time = '11:30 AM';

  final int _totalItems = 1;

  final int _itemCount = 1;

  final int _noOfSngleItem = 3;

  final String _nameofSingleItem = 'Pizza One';

  final String _restaurantNumber = '03154511100';

  final double _restaurantLat = 12.22222;

  final double _restaurantLng = 32.22222;

  final String _userNumber = '03154511100';

  final double _userLat = 12.22222;

  final double _userLng = 32.22222;

  bool _amPm = false;

  int hourS = 0;

  int minutesS = 0;

  final _appBloc = Get.find<AppBloc>();

  final _mapClient = MapClient();

  final Set<Polyline> _polyline = {};

  List<LatLng> polylineCoordinates = [];
  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<LatLng>> getPolyline() async {
    LatLng origin = await currentUserLocation();
    LatLng destination = await getDestination();
    var data = await _mapClient.getPolyline(origin, destination);
    return data;
  }

  //getting current user location
  Future<LatLng> currentUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng _origin = LatLng(position.latitude, position.longitude);
    return _origin;
  }

//getting destination location
  LatLng getDestination() {
    LatLng _destination = LatLng(
        double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLat),
        double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLng));

    return _destination;
  }

  void _onMapCreated(GoogleMapController controllerParam) async {
    List<LatLng> latlng = await getPolyline();
    LatLng getOrigin = await currentUserLocation();
    setState(() {
      //adding markers for user location and destination
      _markers.add(Marker(
        markerId: MarkerId('currentUserMarker'),
        position: getOrigin,
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(Marker(
        markerId: MarkerId('desUserMarker'),
        position: getDestination(),
        icon: BitmapDescriptor.defaultMarker,
      ));

      // adding polyines in list
      _polyline.add(Polyline(
        polylineId: PolylineId('poly'),
        visible: true,
        points: latlng,
        width: 5,
        color: Theme.of(context).colorScheme.primary,
      ));
    });

    LatLngBounds bound;
    bound = MapUtil.getLatLngBounds(getOrigin, getDestination());

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    check(u2, controllerParam);
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    c.moveCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dateTime.hour > 12) {
      if ((dateTime.minute +
              int.parse(_appBloc.orderDetailsModel.data!.avgDeliveryTime)) >
          60) {
        hourS = dateTime.hour + 1;
        _amPm = true;
        minutesS = dateTime.minute +
            int.parse(_appBloc.orderDetailsModel.data!.avgDeliveryTime) -
            60;
      }
    } else {
      hourS = dateTime.hour;
      minutesS = dateTime.minute +
          int.parse(_appBloc.orderDetailsModel.data!.avgDeliveryTime);
    }
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                Get.to<void>(() => OrdersListPage());
              },
              child: Icon(
                Icons.list,
                size: _iconSizeL,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        title:
            Text('${Strings.pickUpAt} $hourS:$minutesS ${_amPm ? 'PM' : 'AM'}'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  double.parse(_appBloc.orderDetailsModel.data!.orders[0].dLat),
                  double.parse(
                      _appBloc.orderDetailsModel.data!.orders[0].dLng)),
            ),
            polylines: _polyline,
            markers: _markers,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.9,
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
                        Text(
                          _appBloc.orderDetailsModel.data!.name,
                          maxLines: 2,
                          style: Styles.appTheme.textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.elevationM),
                          child: Text(
                            _appBloc.orderDetailsModel.data!.address,
                            maxLines: 2,
                            style: Styles.appTheme.textTheme.bodyText1
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                        _directionsAndCallRow(
                            callFunc: () => _makeCall(
                                number: _appBloc.orderDetailsModel.data!.phone),
                            mapFunc: () => _openMaps(
                                lat: double.parse(
                                    _appBloc.orderDetailsModel.data!.latitude),
                                lon: double.parse(_appBloc
                                    .orderDetailsModel.data!.longitude))),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimens.insetS),
                            child: ShowlineFull(
                                widthMax: true, color: Colors.black54)),
                        Text(
                          Strings.customerDetails,
                          style: Styles.appTheme.textTheme.headline4,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimens.insetS),
                            child: ShowlineFull(
                                widthMax: false, color: MyColors.yellow400)),
                        Text(
                          _appBloc.orderDetailsModel.data!.orders[0].user.name,
                          style: Styles.appTheme.textTheme.bodyText2
                              ?.copyWith(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: PickOrderPage._rowV),
                          child: _directionsAndCallRow(
                              mapFunc: () => _openMaps(
                                  lat: double.parse(_appBloc
                                      .orderDetailsModel.data!.orders[0].dLat),
                                  lon: double.parse(_appBloc
                                      .orderDetailsModel.data!.orders[0].dLng)),
                              callFunc: () => _makeCall(
                                  number: _appBloc.orderDetailsModel.data!
                                      .orders[0].user.phone)),
                        ),
                        ShowlineFull(widthMax: true, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.insetS),
                          child: Text(
                            Strings.orderDetails,
                            style: Styles.appTheme.textTheme.headline4,
                          ),
                        ),
                        ShowlineFull(
                            widthMax: false, color: MyColors.yellow400),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: PickOrderPage._rowV,
                            bottom: 5,
                          ),
                          child: Text(
                            '${_appBloc.orderDetailsModel.count} ${Strings.totalItem}',
                            style: Styles.appTheme.textTheme.bodyText2
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                        Text(
                          '${Strings.sCurrency} ${_appBloc.orderDetailsModel.data!.orders[0].subTotal}',
                          style: Styles.appTheme.textTheme.bodyText2
                              ?.copyWith(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.insetS),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(Dimens.insetXs),
                                child: Text(
                                  '${_appBloc.orderDetailsModel.data!.orders[0].orderProduct[index].qty}'
                                  'x ${_appBloc.orderDetailsModel.data!.orders[0].orderProduct[index].product?.name}',
                                  style: Styles.appTheme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.black54),
                                ),
                              );
                            },
                            itemCount: _appBloc.orderDetailsModel.data!
                                .orders[0].orderProduct.length,
                            shrinkWrap: true,
                          ),
                        ),
                        ShowlineFull(
                            widthMax: false, color: MyColors.yellow400),
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
                Stack(
                  children: [
                    SliderWidget(
                      func: _gotoOrderPickDriver,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: PickOrderPage._rowV),
                      child: Center(
                          child: Text(
                        Strings.slideAfterArrival,
                        style: Styles.appTheme.textTheme.bodyText1?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _directionsAndCallRow(
      {required void Function() mapFunc, required void Function() callFunc}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            mapFunc();
          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions,
                    size: _iconSize,
                    color: Colors.white,
                  ),
                  Text(
                    Strings.direction,
                    style: Styles.appTheme.textTheme.bodyText1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: _sizedBoxW,
        ),
        GestureDetector(
          onTap: () {
            callFunc();
          },
          child: Container(
            height: _containerH,
            // width: 90,
            color: MyColors.yellow400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.call,
                    size: _iconSize,
                    color: Colors.white,
                  ),
                  Text(
                    Strings.call,
                    style: Styles.appTheme.textTheme.bodyText1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _gotoOrderPickDriver() {
    Get.to<void>(() => OrderPickSelectPage());
  }

  Future<void> _makeCall({required String number}) async {
    print(number);
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Could not launch $number';
    }
  }

  Future<void> _openMaps({required double lat, required double lon}) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
