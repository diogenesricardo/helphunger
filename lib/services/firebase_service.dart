import 'package:ajudafome/models/response.dart';
import 'package:ajudafome/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    // Cria um usuario do app
    final user = User();
    user.nome = fuser.user.displayName;
    user.email = fuser.user.email;
    user.urlFoto = fuser.user.photoUrl;
    user.save();

    // Resposta genérica
    return Response(true, "Login efetuado com sucesso");
  }

  Future<Response> loginEmailPassword() async {
    // Usuario do Firebase
    final AuthResult fuser = await _auth.signInWithEmailAndPassword(
        email: "anakin@gmail.com", password: "123456");
    print("signed in " + fuser.user.email ?? "Novo usuário");

    // Cria um usuario do app
    final user = User();
    user.nome = fuser.user.displayName;
    user.email = fuser.user.email;
    user.urlFoto = fuser.user.photoUrl;

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
