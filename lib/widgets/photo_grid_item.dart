import 'package:flutter/material.dart';

import 'package:pictures/constants.dart';
import 'package:pictures/dto/photo_entity.dart';
import 'widgets.dart';

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({Key? key, required this.photo}) : super(key: key);

  final PhotoEntity photo;

  @override
  Widget build(BuildContext context) {
    String url = Constants.apiImageUrl + photo.image.name;

    return InkWell(
      onTap: () => _onTap(context, photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
          placeholder: const AssetImage(Constants.placeholderImage),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, PhotoEntity photo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: Widgets.appBarBack(),
        body: Widgets.details(photo),
      );
    }));
  }
}
