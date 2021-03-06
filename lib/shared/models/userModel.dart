import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  }

  UserModel({required this.name, this.photoURL});

  Map<String, dynamic> toMap() => {"name": name, "photoURL": photoURL};

  String toJson() => jsonEncode(toMap());
}
