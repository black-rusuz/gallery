import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictures/constants.dart';
import 'package:pictures/dto/photo_entity.dart';
import 'package:pictures/widgets/widgets.dart';

class PhotoDetails extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoDetails({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name = photo.name;
    String? description = photo.description;

    return Scaffold(
      appBar: Widgets.appBarBack(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(photo.image.getUrl()),
              placeholder: const AssetImage(Constants.placeholderImage),
            ),
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
      ),
    );
  }
}
