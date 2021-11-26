import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'Pictures';

  static const MaterialColor colorAccent = MaterialColor(0xFFED5992, {
    50: Color(0xfffbe3ec),
    100: Color(0xfff6b8d0),
    200: Color(0xfff28ab1),
    300: Color(0xffed5992),
    400: Color(0xffe93079),
    500: Color(0xffe50062),
    600: Color(0xffd4005f),
    700: Color(0xffbf005a),
    800: Color(0xffa90056),
    900: Color(0xff84004e),
  });
  static const Color colorTitle = Color(0xff2f1767);
  static const Color colorSubtitle = Color(0xff8c8c8c);
  static const Color colorText = Color(0xff4a4a4a);

  static const String titleNew = 'New';
  static const String titlePopular = 'Popular';

  static const String placeholderImage = 'assets/images/placeholder.png';

  static const String connectionErrorImage = 'assets/images/internet.svg';
  static const String connectionErrorTitle = 'Oh shucks!';
  static const String connectionErrorMessage =
      'Slow or no internet connection.\n'
      'Please check your internet settings';

  static const String apiRequestUrl = 'http://gallery.dev.webant.ru/api/photos';
  static const String apiImageUrl = 'http://gallery.dev.webant.ru/media/';
}
