import 'package:ajudafome/pages/welcome_page.dart';
import 'package:ajudafome/pages/signup_page.dart';
import 'package:ajudafome/utils/alert.dart';
import 'package:ajudafome/services/firebase_service.dart';
import 'package:ajudafome/utils/firebase-message.dart';
import 'package:ajudafome/widgets/button_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:ajudafome/utils/nav.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    initFcm();

    return Scaffold(
        appBar: AppBar(
          title: Text("Ajuda Fome"),
        ),
        body: _body(context));
  }

  _body(context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    "https://static.thenounproject.com/png/26617-200.png"),
                Container(
                  child: InkWell(
                    onTap: () => _onClickSignup(context),
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                          fontSize: 24,
                          decoration: TextDecoration.underline,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 280,
                child: ButtonHelp("Login com email e senha",
                    () => _onClickEmailPassword(context)),
              ),
              FacebookSignInButton(
                  borderRadius: 10.0,
                  onPressed: () {
                    NavigatorHelper.push(context, WelcomePage());
                  }),
              GoogleSignInButton(
                borderRadius: 10.0,
                onPressed: () => _onClickGoogleLogin(context),
                darkMode: true, // default: false
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onClickGoogleLogin(context) async {
    print("Google");

    final service = FirebaseService();
    final response = await service.loginGoogle();

    if (response.isOk()) {
      NavigatorHelper.pushReplacement(context, WelcomePage());
    } else {
      Alerts.alert(context, "Erro", response.msg);
    }
  }

  _onClickEmailPassword(context) async {
    print("Firebase Login");

    final service = FirebaseService();
    final response = await service.loginEmailPassword();

    if (response.isOk()) {
      NavigatorHelper.pushReplacement(context, WelcomePage());
    } else {
      Alerts.alert(context, "Erro", response.msg);
    }
  }

  _onClickSignup(context) {
    print("Cadastre-se");

    NavigatorHelper.push(context, SignupPage());
  }
}
