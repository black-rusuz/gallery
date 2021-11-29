import 'package:flutter/material.dart';

import 'package:pictures/constants.dart';
import 'package:pictures/dto/photo_entity.dart';
import 'package:pictures/fonts/nav_icons.dart';

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

  static ListView details(PhotoEntity photo) {
    String url = Constants.apiImageUrl + photo.image.name;
    String? name = photo.name;
    String? description = photo.description;

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Image.network(url),
        ),
        if (name != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 15.0),
            child: Text(
              name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Constants.colorTitle,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 15.0),
            child: Text(
              description,
              style: const TextStyle(
                color: Constants.colorText,
                fontSize: 12.0,
                height: 2.0,
              ),
            ),
          ),
      ],
    );
  }
}
