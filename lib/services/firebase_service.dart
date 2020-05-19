import 'package:ajudafome/models/response.dart';
import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/utils/current-user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<Response> loginGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Usuario do Firebase
    final AuthResult fuser = await _auth.signInWithCredential(credential);
    print("signed in " + fuser.user.displayName);

    //Associa o uid a classe global.
    CurrentUser.uid = fuser.user.uid;
    CurrentUser.displayName = fuser.user.displayName;

    Firestore.instance.collection('books').document()
        .setData({ 'title': 'title', 'author': 'author' });

    // Cria um usuario do app
    var user = User();
    user.name = fuser.user.displayName;
    user.email = fuser.user.email;
    user.urlPhoto = fuser.user.photoUrl;
    user.save();

    // Resposta genérica
    return Response(true, "Login efetuado com sucesso");
  }

  Future<Response> loginEmailPassword() async {
    // Usuario do Firebase
    final AuthResult fuser = await _auth.signInWithEmailAndPassword(
        email: "anakin@gmail.com", password: "123456");
    print("signed in " + fuser.user.email ?? "Novo usuário");

    //Associa o uid a classe global.
    CurrentUser.uid = fuser.user.uid;
    CurrentUser.displayName = fuser.user.displayName;

    // Cria um usuario do app
    var user = User();
    user.name = fuser.user.displayName;
    user.email = fuser.user.email;
    user.urlPhoto = fuser.user.photoUrl;

    user.save();

    // Resposta genérica
    return Response(true, "Login efetuado com sucesso");
  }

  Future<Response> signup(String name, String email, String password) async {
    try {
      // Usuario do Firebase
      final AuthResult fUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      userUpdateInfo.photoUrl =
          "https://static.thenounproject.com/png/26617-200.png";
      fUser.user.updateProfile(userUpdateInfo);

      print("Usuario criado: ${fUser.user.displayName}");
      // Resposta genérica
      return Response(true, "Usuário criado com sucesso");
    } catch (error) {
      print(error);

      if (error is PlatformException) {
        print("Error Code ${error.code}");

        return Response(false, "Erro ao criar um usuário.\n\n${error.message}");
      }

      return Response(false, "Não foi possível criar um usuário.");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
