import 'package:flutter/material.dart';
import 'package:gallery/constants.dart';
import 'package:gallery/dto/photo_entity.dart';
import 'package:gallery/widgets/photo_details.dart';

class PhotoGridItem extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoGridItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage(
          fit: BoxFit.cover,
          image: NetworkImage(photo.image.getUrl()),
          placeholder: const AssetImage(Constants.placeholderImage),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PhotoDetails(photo: photo);
    }));
  }
}
