import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/utils/current-user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';

class UserService {
  getUsers() => _users.snapshots();

  get _users => Firestore.instance.collection("helpers");

  List<User> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((document) => User.fromMap(document.data))
        .toList();
  }

  Future<bool> requestHelp(uid) async {
    DocumentReference documentReference = _users.document(uid);

    documentReference.setData({
      "id": CurrentUser.uid,
      "nome": CurrentUser.displayName,
      "askedHelp": false
    });

    DocumentSnapshot documentSnapshot = await documentReference.get();

    print(documentSnapshot.data);

    if (documentSnapshot.exists) {
      return true;
    }
    return false;
  }

  Future<bool> exists(User user) async {
    // Busca o user no Firestore
    var document = _users.document("${user.id}");

    var documentSnapshot = await document.get();

    // Verifica se o user está favoritado
    return await documentSnapshot.exists;
  }
}
