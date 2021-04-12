import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapClient {
  // endpoints
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  static const _epAutocomplete = "/autocomplete/json";
  static const _epDetails = "/details/json";

  // parameters
  static const _key = 'AIzaSyC5T3JDKFkn59SE2lnC8oxjbcAHp7d6hYo';
  static const _pfields = 'fields';
  static const _pKey = 'key';
  static const _pLanguage = 'language';
  static const _pQuery = 'input';
  static const _pPlaceid = 'place_id';
  static const _pOrigin = 'origin';
  static const _pDestination = 'destination';

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

  // Future<AutoComplete> getPlaces(String str,
  //     {String key, String language}) async {
  //   final response = await _dio.get(
  //     _epAutocomplete,
  //     queryParameters: {_pQuery: str, _pKey: _key, _pLanguage: 'en'},
  //   );
  //   if (response.statusCode == HttpStatus.ok) {
  //     return AutoComplete.fromJson(response.data);
  //   }
  //   throw (response.statusMessage);
  // }
  //
  // Future<IdtoLatLong> getPlacesLatLong(String str,
  //     {String key, String language}) async {
  //   final response = await _dio.get(
  //     _epDetails,
  //     queryParameters: {_pPlaceid: str, _pKey: _key, _pfields: 'geometry'},
  //   );
  //   if (response.statusCode == HttpStatus.ok) {
  //     return IdtoLatLong.fromJson(response.data);
  //   }
  //   throw (response.statusMessage);
  // }

  Future<List<LatLng>> getPolyline(LatLng origin, LatLng destination) async {
    final response = await _dio.get<dynamic>(
      'https://maps.googleapis.com/maps/api/directions/json',
      queryParameters: <String, String>{
        _pOrigin: '${origin.latitude},${origin.longitude}',
        _pDestination: '${destination.latitude},${destination.longitude}',
        _pKey: _key,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      final routes = response.data['routes'] as List;
      if (routes.isNotEmpty) {
        final encodedPolyline =
            routes[0]['overview_polyline']['points'] as String;
        return _decodeEncodedPolyline(encodedPolyline);
      }
      return [];
    }
    throw (Exception(response.statusMessage));
  }

  // https://medium.com/@dammyololade2010/decode-google-polyline-in-dart-456d54b7128e
  // https://gist.github.com/Dammyololade/ce4eda8544e76c8f66a2664af9a1e0f3#file-decoder-dart
  static List<LatLng> _decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}
