import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/utils/current-user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';

class UserService {
  get _helpedUsers => Firestore.instance.collection("helped-users");

  get _helperUsers => Firestore.instance.collection("helpers");

  getHelpedUsers() => _helpedUsers.snapshots();

  Future<bool> requestHelp(uid) async {
    DocumentReference documentReference = _helpedUsers.document(uid);

    documentReference.setData({
      "id": CurrentUser.uid,
      "name": CurrentUser.displayName,
      "askedHelp": true
    });

    DocumentSnapshot documentSnapshot = await documentReference.get();

    print(documentSnapshot.data);

    if (documentSnapshot.exists) {
      return true;
    }
    return false;
  }

  Future<bool> existsHelpedUsers(User user) async {
    // Busca o user no Firestore
    var document = _helpedUsers.document("${user.id}");

    var documentSnapshot = await document.get();

    // Verifica se o user já existe
    return await documentSnapshot.exists;
  }

  Future<bool> existsHelperUsers(User user) async {
    // Busca o user no Firestore
    var document = _helperUsers.document("${user.id}");

    var documentSnapshot = await document.get();

    // Verifica se o user já existe
    return await documentSnapshot.exists;
  }
}
