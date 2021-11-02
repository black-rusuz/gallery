/// id : 229
/// name : "5badea780fd2c987088603.jpg"

class Image {
  Image({
    int? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  Image.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}