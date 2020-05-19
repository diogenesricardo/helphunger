import 'dart:convert';

import 'package:ajudafome/utils/prefs.dart';

class User {
  String id;
  String email;
  String name;
  String urlPhoto;
  String password;
  bool wasHelped;

  User({
    this.email,
    this.name,
    this.urlPhoto,
    this.password,
    this.wasHelped,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
      email: json["email"],
      name: json["name"],
      urlPhoto: json["urlPhoto"],
      password: json["password"],
      wasHelped: json["wasHelped"]);

  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
        "urlPhoto": urlPhoto,
        "password": password,
        "wasHelped": wasHelped,
      };

  void save() {
    final map = {"name": name, "urlPhoto": urlPhoto, "email": email};
    Prefs.setString("user.prefs", json.encode(map));
  }

  static Future<User> get() async {
    String s = await Prefs.getString("user.prefs");
    if (s == null || s.isEmpty) {
      return null;
    }
    final user = User.fromMap(json.decode(s));
    return user;
  }

  static clear() {
    Prefs.setString("user.prefs", "");
  }
}

User userFromJson(String str) => User.fromMap(json.decode(str));

String userToJson(User data) => json.encode(data.toMap());
