import 'package:flutter/material.dart';

Widget ShowlineFull({required bool widthMax, required Color color}) {
  final double _containerH = 40;
  return Container(
    height: 1,
    width: widthMax ? double.infinity : _containerH,
    color: color,
  );
}