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

  static Center plug([error]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
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
          Constants.loadingImage,
          color: isColored ? Constants.colorAccent : null,
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
    String url = Constants.apiImageUrl + photo.image!.name!;

    return InkWell(
      onTap: () => onTap(photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }


  static ListView details(Photo photo) {
    String url = Constants.apiImageUrl + photo.image!.name!;
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
              color: Constants.colorTitle,
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