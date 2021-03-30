import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class Styles {
  static final appTheme = _baseTheme.copyWith(
    cardTheme: _baseTheme.cardTheme.copyWith(
      margin: EdgeInsets.zero,
    ),
  );

  static final _baseTheme = ThemeData.from(colorScheme: _colorScheme);

  static const _colorScheme = ColorScheme.light(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: MyColors.yellow400,
    onSecondary: Colors.white,
  );

  Styles._();
}
