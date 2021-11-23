import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pictures/constants.dart';
import 'package:pictures/fonts/nav_icons.dart';
import 'package:pictures/dto/photo.dart';

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

  static RefreshIndicator plug() {
    return RefreshIndicator(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SvgPicture.asset(
                  Constants.connectionErrorImage,
                  width: 160.0,
                  height: 160.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  Constants.connectionErrorTitle,
                  style: TextStyle(
                    color: Constants.colorTitle,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                Constants.connectionErrorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.colorSubtitle,
                  fontSize: 12.0,
                  height: 2.0,
                ),
              ),
            ],
          ),
        ),
        // TODO: Прописать pullRequest (но где?)
        onRefresh: () async {
          print('hey');
        });
  }

  static ListView details(Photo photo) {
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
