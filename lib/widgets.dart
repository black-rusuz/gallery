import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dto/photo.dart';
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

  static AppBar backAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: const BackButton(color: Constants.COLOR_TITLE),
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

  static Center plug([error]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SvgPicture.asset(
              Constants.CONNECTION_ERROR_IMAGE,
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

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          //   child: Text(
          //     'ERROR MESSAGE:\n' + error.toString(),
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //       color: Constants.COLOR_SUBTITLE,
          //       fontSize: 8.0,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }


  static Align loading(vsync, [isColored = false]){
    return Align(
      alignment: Alignment.topCenter,
      child: RotationTransition(
        turns: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(seconds: 2),
            vsync: vsync,
          )..repeat(),
          curve: Curves.linear,
        ),
        child: SvgPicture.asset(
          Constants.LOADING_IMAGE,
          color: isColored ? Constants.COLOR_ACCENT : null,
        ),
      ),
    );
  }

  static Future<Widget> grid(String requestUrl, Function(Photo) onTap) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final http.Response response = await http.get(Uri.parse(requestUrl));
        if (response.statusCode == 200) {
          Iterable i = jsonDecode(response.body)['data'];
          List<Photo> photos =
          List<Photo>.from(i.map((model) => Photo.fromJson(model)));
          List<InkWell> gridImages = <InkWell>[];
          for (var item in photos) {
            gridImages.add(gridImage(item, onTap));
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 160 / 100,
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 16.0),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: gridImages,
          );
        }
      } else {
        return plug();
      }
    } on SocketException catch (e) {
      return plug(e);
    }
    return plug();
  }

  static InkWell gridImage(Photo photo, Function(Photo) onTap) {
    String url = Constants.API_IMAGE_URL + photo.image!.name!;

    return InkWell(
      onTap: () => onTap(photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }


  static ListView details(Photo photo) {
    String url = Constants.API_IMAGE_URL + photo.image!.name!;
    String name = photo.name!;
    String description = photo.description!;

    return ListView(
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Image.network(url),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 15.0),
          child: Text(
            name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Constants.COLOR_TITLE,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 15.0),
          child: Text(
            description,
            style: const TextStyle(
              color: Constants.COLOR_TEXT,
              fontSize: 12.0,
              height: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}