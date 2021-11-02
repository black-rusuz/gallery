import 'image.dart';

/// id : 84
/// name : "1"
/// dateCreate : "-0001-11-30T00:00:00+02:31"
/// description : "1"
/// isNew : true
/// isPopular : false
/// image : {"id":229,"name":"5badea780fd2c987088603.jpg"}
/// user : null

class Photo {
  Photo({
      int? id,
      String? name, 
      String? dateCreate, 
      String? description, 
      bool? isNew,
      bool? isPopular,
      Image? image,
      dynamic user,}){
    _id = id;
    _name = name;
    _dateCreate = dateCreate;
    _description = description;
    _isNew = isNew;
    _isPopular = isPopular;
    _image = image;
    _user = user;
}

  Photo.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _dateCreate = json['dateCreate'];
    _description = json['description'];
    _isNew = json['new'];
    _isPopular = json['popular'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _user = json['user'];
  }
  int? _id;
  String? _name;
  String? _dateCreate;
  String? _description;
  bool? _isNew;
  bool? _isPopular;
  Image? _image;
  dynamic _user;

  int? get id => _id;
  String? get name => _name;
  String? get dateCreate => _dateCreate;
  String? get description => _description;
  bool? get isNew => _isNew;
  bool? get isPopular => _isPopular;
  Image? get image => _image;
  dynamic get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['dateCreate'] = _dateCreate;
    map['description'] = _description;
    map['new'] = _isNew;
    map['popular'] = _isPopular;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['user'] = _user;
    return map;
  }

}