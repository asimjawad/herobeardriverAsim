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
    textTheme: _baseTextTheme,
    accentTextTheme: _baseTextTheme.apply(
      bodyColor: _colorScheme.secondary,
      displayColor: _colorScheme.secondary,
    ),
  );

  static final onPrimaryTextTheme = _baseTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );

  static final _baseTextTheme = _baseTheme.textTheme
      .copyWith(
        headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headline3: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        headline4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        headline5: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: TextStyle(
          fontSize: 12,
        ),
      )
      .apply(
        displayColor: _colorScheme.onBackground,
        bodyColor: _colorScheme.onBackground,
      );

  static final _baseTheme = ThemeData.from(
    colorScheme: _colorScheme,
    textTheme: Typography.material2018().black,
  );

  static const _colorScheme = ColorScheme.light(
    primary: MyColors.yellow400,
    secondary: MyColors.yellow600,
    onSecondary: Colors.white,
  );

  Styles._();
}
