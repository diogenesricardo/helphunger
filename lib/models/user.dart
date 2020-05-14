import 'dart:convert';

import 'package:ajudafome/utils/prefs.dart';

class User {
  String id;
  String email;
  String nome;
  String urlFoto;
  String password;

  User({
    this.email,
    this.nome,
    this.urlFoto,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        nome: json["nome"],
        urlFoto: json["urlFoto"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "nome": nome,
        "urlFoto": urlFoto,
        "password": password,
      };

  void save() {
    final map = {"nome": nome, "urlFoto": urlFoto, "email": email};
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
