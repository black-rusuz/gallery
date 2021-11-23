import 'package:flutter/material.dart';

import 'package:pictures/dto/photo.dart';
import 'package:pictures/constants.dart';
import 'widgets.dart';

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    String url = Constants.apiImageUrl + photo.image.name;

    return InkWell(
      onTap: () => _onTap(context, photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  void _onTap(BuildContext context, Photo photo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: Widgets.appBarBack(),
        body: Widgets.details(photo),
      );
    }));
  }
}
