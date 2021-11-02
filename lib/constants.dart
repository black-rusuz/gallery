import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String APP_NAME = 'Pictures';

  static const MaterialColor COLOR_ACCENT = MaterialColor(0xFFED5992, {
         50 : Color(0xfffbe3ec),
        100 : Color(0xfff6b8d0),
        200 : Color(0xfff28ab1),
        300 : Color(0xffed5992),
        400 : Color(0xffe93079),
        500 : Color(0xffe50062),
        600 : Color(0xffd4005f),
        700 : Color(0xffbf005a),
        800 : Color(0xffa90056),
        900 : Color(0xff84004e),
  });
  static const Color COLOR_TITLE = Color(0xff2f1767);
  static const Color COLOR_SUBTITLE = Color(0xff8c8c8c);
  static const Color COLOR_TEXT = Color(0xff4a4a4a);
  static const Color COLOR_GRAY = Color(0xffc8c8c8);

  static const String TITLE_NEW = 'New';
  static const String TITLE_POPULAR = 'Popular';

  static const String LOADING_IMAGE = 'assets/images/loading.svg';
  static const String CONNECTION_ERROR_IMAGE = 'assets/images/internet.svg';
  static const String CONNECTION_ERROR_TITLE = 'Oh shucks!';
  static const String CONNECTION_ERROR_MESSAGE =
      'Slow or no internet connection.\n'
      'Please check your internet settings';

  static const String API_IMAGE_URL = 'http://gallery.dev.webant.ru/media/';
  static const String API_REQUEST_NEW =
      'http://gallery.dev.webant.ru/api/photos?limit=10&new=true&page=';
  static const String API_REQUEST_POPULAR =
      'http://gallery.dev.webant.ru/api/photos?limit=10&popular=true&page=';
}