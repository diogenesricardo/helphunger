import 'package:ajudafome/models/response.dart';
import 'package:ajudafome/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final user =
        User(fuser.user.displayName, fuser.user.email, fuser.user.email);
    user.save();

    // Resposta genérica
    return Response(true, "Login efetuado com sucesso");
  }

  Future<Response> loginEmailPassword() async {

    // Usuario do Firebase
    final AuthResult fuser = await _auth.signInWithEmailAndPassword(email: "anakin@gmail.com", password: "123456");
    print("signed in " + fuser.user.email ?? "Novo usuário");

    // Cria um usuario do app
    final user =
        User(fuser.user.displayName ?? "Novo usuário", fuser.user.email, fuser.user.email);
    user.save();

    // Resposta genérica
    return Response(true, "Login efetuado com sucesso");
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
