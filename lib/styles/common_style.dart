import 'dart:io';

import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/fonts.dart';

abstract class CommonStyle {
  /// Main app theme
  static var mainTheme = ThemeData(
    primaryColor: Colors.primary,
    accentColor: Colors.primary,
    platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.red,
    dialogBackgroundColor: Colors.white,
    fontFamily: Fonts.fontNormal,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      brightness: Brightness.dark,
      elevation: 0,
      iconTheme: ThemeData().iconTheme,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Constants.cornerRadius),
        ),
      ),
    ),
  );

  /// Text small
  static TextStyle textSmall({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeSmall,
    );
  }

  /// Text small bold
  static TextStyle textSmallBold({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeSmall,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w600,
    );
  }

  /// Text medium
  static TextStyle textMedium({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeMedium,
    );
  }

  /// Text medium bold
  static TextStyle textMediumBold({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeMedium,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w600,
    );
  }

  /// Text large
  static TextStyle textLarge({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeLarge,
    );
  }

  /// Text large bold
  static TextStyle textLargeBold({Color color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.fontSizeLarge,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w600,
    );
  }

  /// Shadow offset
  static BoxShadow shadowOffset({double blurRadius}) {
    return BoxShadow(
      color: Colors.shadow,
      spreadRadius: 0,
      blurRadius: blurRadius ?? Constants.elevation,
      offset: Offset(0, 2), // changes position of shadow
    );
  }

  /// Text error
  static const textError = TextStyle(
    fontSize: Fonts.fontSizeSmall,
    color: Colors.red,
  );
}
