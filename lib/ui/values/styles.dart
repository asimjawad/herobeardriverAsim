import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class Styles {
  static final appTheme = _baseTheme.copyWith(
    cardTheme: _baseTheme.cardTheme.copyWith(
      margin: EdgeInsets.zero,
    ),
    iconTheme: _baseTheme.iconTheme.copyWith(
      color: _colorScheme.onBackground,
    ),
  );

  static final _baseTheme = ThemeData.from(colorScheme: _colorScheme);

  static const _colorScheme = ColorScheme.light(
    primary: MyColors.yellow400,
    secondary: MyColors.yellow600,
    onSecondary: Colors.white,
  );

  Styles._();
}
