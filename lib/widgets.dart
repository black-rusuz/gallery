import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'fonts/nav_icons.dart';

class Widgets {

  static AppBar appBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,

      title: Text(
        title,
        style: const TextStyle(
          color: Constants.COLOR_TITLE,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
    
  static BottomNavigationBar navBar(int index, Function(int) onTap) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: index,
      selectedFontSize: 12.0,
      selectedItemColor: Constants.COLOR_ACCENT,
      unselectedItemColor: Constants.COLOR_SUBTITLE,
      onTap: onTap,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: Constants.TITLE_NEW,
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(NavIcons.NAV_NEW),
          ),
        ),
        BottomNavigationBarItem(
          label: Constants.TITLE_POPULAR,
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Icon(NavIcons.NAV_POPULAR),
          ),
        ),
      ],
    );
  }

  static Center plug() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SvgPicture.asset(
              Constants.CONNECTION_ERROR_IMAGE_ASSET,
              width: 160.0,
              height: 160.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              Constants.CONNECTION_ERROR_TITLE,
              style: TextStyle(
                color: Constants.COLOR_TITLE,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            Constants.CONNECTION_ERROR_MESSAGE,
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Constants.COLOR_SUBTITLE,
              fontSize: 12.0,
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Доработать, подключить к API
  // static GridView mainGrid(List<Widget> children) {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     childAspectRatio: 160 / 100,
  //     padding: const EdgeInsets.all(16.0),
  //     crossAxisSpacing: 10.0,
  //     mainAxisSpacing: 10.0,
  //     children: children,
  //   );
  // }
  static GridView mainGrid() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 160 / 100,
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: <Widget> [
        image(Constants.UNSPLASH_RANDOM),
        image(Constants.UNSPLASH_RANDOM),
      ],
    );
  }

  static image(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

}