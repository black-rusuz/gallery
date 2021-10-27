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
  static const Color COLOR_TITLE = Color(0xFF2F1767);
  static const Color COLOR_SUBTITLE = Color(0xFF8C8C8C);
  static const Color COLOR_GRAY = Color(0xFFC8C8C8);

  static const String TITLE_NEW = 'New';
  static const String TITLE_POPULAR = 'Popular';

  static const String CONNECTION_ERROR_IMAGE_ASSET = 'assets/images/internet.svg';
  static const String CONNECTION_ERROR_TITLE = 'Oh shucks!';
  static const String CONNECTION_ERROR_MESSAGE = 'Slow or no internet connection.\nPlease check your internet settings';

  // TODO: Убрать после подключения API
  static const String UNSPLASH_RANDOM = 'https://source.unsplash.com/random';
}