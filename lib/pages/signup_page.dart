import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/pages/home_page.dart';
import 'package:ajudafome/utils/alert.dart';
import 'package:ajudafome/utils/api_response.dart';
import 'package:ajudafome/utils/firebase_service.dart';
import 'package:ajudafome/utils/nav.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final User userModel;

  SignupPage({this.userModel});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  var tName = TextEditingController();

  final tPhone = TextEditingController();

  var tEmail = TextEditingController();

  final tPassword = TextEditingController();

  final tConfirmedPassword = TextEditingController();

  get userModel => widget.userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: new Form(
        key: this._formKey,
        child: new ListView(
          children: <Widget>[
            new TextFormField(
              controller: tName,
              keyboardType: TextInputType.text,
              validator: _validateName,
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: new InputDecoration(
                hintText: '',
                labelText: 'Nome completo',
              ),
            ),
            new TextFormField(
              controller: tPhone,
              keyboardType: TextInputType.phone,
//              validator: _validatePhone,
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: new InputDecoration(
                hintText: '',
                labelText: 'Telefone',
              ),
            ),
            new TextFormField(
              controller: tEmail,
              keyboardType: TextInputType.emailAddress,
//              validator: _validateEmail,
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: new InputDecoration(
                hintText: 'E-mail (opcional)',
                labelText: 'Email',
              ),
            ),
            userModel == null
                ? new TextFormField(
                    obscureText: true,
                    controller: tPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: _validatePassword,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    decoration: new InputDecoration(
                      hintText: '',
                      labelText: 'Senha',
                    ),
                  )
                : Container(),
            userModel == null
                ? new TextFormField(
                    obscureText: true,
                    controller: tConfirmedPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: _validatePassword,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    decoration: new InputDecoration(
                      hintText: '',
                      labelText: 'Confirmar Senha',
                    ),
                  )
                : Container(),
            userModel != null
                ? new TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    decoration: new InputDecoration(
                      hintText: '',
                      labelText: 'Token de confirmação aguarde',
                    ),
                  )
                : Container(),
            Container(
              height: 50,
              margin: new EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Colors.brown,
                child: Text(
                  "Continuar",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  _onClickContinuar(context);
                },
              ),
            ),
            Container(
              height: 50,
              margin: new EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Colors.white,
                child: Text(
                  "Cancelar",
                  style: new TextStyle(
                    color: Colors.brown,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  NavigatorHelper.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onClickContinuar(BuildContext context) async {
    try {
      final service = FirebaseService();

      final response =
          await service.signup(tName.text, tEmail.text, tPassword.text);

      if (response.ok) {
//        userModel.savePrefs();

        NavigatorHelper.pushReplacement(context, HomePage());
      } else {
        Alerts.alert(context, "Erro", response.msg);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Informe seu nome completo.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Informe seu nome completo.';
    }

    return null;
  }
}
