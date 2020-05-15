
import 'package:ajudafome/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';

class UserService {
  getUsers() => _users.snapshots();

  get _users => Firestore.instance.collection("users");

  List<User> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((document) => User.fromMap(document.data) )
        .toList();
  }

  Future<bool> favoritar(User user) async {

    var document = _users.document("${user.id}");
    var documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print("${user.nome}, adicionado nos favoritos");
      document.setData(user.toMap());

      return true;
    } else {
      print("${user.nome}, removido nos favoritos");
      document.delete();

      return false;
    }
  }

  Future<bool> exists(User user) async {

    // Busca o user no Firestore
    var document = _users.document("${user.id}");

    var documentSnapshot = await document.get();

    // Verifica se o user está favoritado
    return await documentSnapshot.exists;
  }
}