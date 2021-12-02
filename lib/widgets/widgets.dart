import 'package:flutter/material.dart';
import 'package:gallery/constants.dart';
import 'package:gallery/fonts/nav_icons.dart';

class Widgets {
  static AppBar appBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          color: Constants.colorTitle,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static AppBar appBarBack() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: const BackButton(color: Constants.colorTitle),
    );
  }

  static BottomNavigationBar navBar(int index, Function(int) onTap) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: index,
      selectedFontSize: 12.0,
      selectedItemColor: Constants.colorAccent,
      unselectedItemColor: Constants.colorSubtitle,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: Constants.titleNew,
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(NavIcons.navNew),
          ),
        ),
        BottomNavigationBarItem(
          label: Constants.titlePopular,
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(NavIcons.navPopular),
          ),
        ),
      ],
    );
  }
}
