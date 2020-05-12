import 'package:ajudafome/pages/home_page.dart';
import 'package:ajudafome/utils/alert.dart';
import 'package:ajudafome/utils/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:ajudafome/utils/nav.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajuda Fome"),
        ),
        body: _body(context));
  }

  _body(context){
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(
                "https://static.thenounproject.com/png/26617-200.png"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FacebookSignInButton(
                  borderRadius: 10.0,
                  onPressed: () {
                    NavigatorHelper.push(context, HomePage());
                  }),
              GoogleSignInButton(
                borderRadius: 10.0,
                onPressed: () => _onClickGoogleLogin(context),
                darkMode: true, // default: false
              ),
              TwitterSignInButton(
                onPressed: () {},
                borderRadius: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onClickGoogleLogin(context) async{
    print("Google");

    final service = FirebaseService();
    final response = await service.loginGoogle();

    if (response.isOk()) {
      NavigatorHelper.push(context, HomePage());
    } else {
      Alerts.alert(context, "Erro", response.msg);
    }
  }
}
