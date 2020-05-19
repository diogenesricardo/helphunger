import 'package:ajudafome/services/firebase_service.dart';
import 'package:ajudafome/services/user_service.dart';
import 'package:ajudafome/utils/alert.dart';
import 'package:ajudafome/utils/current-user.dart';
import 'package:ajudafome/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpedPage extends StatelessWidget {
  var tPhone = TextEditingController();
  var tAdress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedindo Ajuda"),
        ),
        body: _body(context));
  }

  _body(context) {
    return Center(
      child: Container(
        height: 350,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Digite seu telefone ou de alguém que está precisando"),
            TextFormField(
              controller: tPhone,
              keyboardType: TextInputType.text,
              validator: _validatePhone,
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: new InputDecoration(
                hintText: '',
                labelText: 'Numero de telefone',
              ),
            ),
            Text("Digite o ponto de encontro pra receber a doação."),
            TextFormField(
              controller: tAdress,
              keyboardType: TextInputType.text,
              validator: _validatePhone,
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: new InputDecoration(
                hintText: '',
                labelText: 'Digite o endereço',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                Container(
                  height: 50,
                  margin: new EdgeInsets.only(top: 20.0),
                  child: RaisedButton(
                    color: Colors.brown,
                    child: Text(
                      "Pedir ajuda",
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _validatePhone(String value) {
    if (value.isEmpty) {
      return 'Informe seu nome completo.';
    }

    return null;
  }

  _onClickContinuar(context) async{
    print("Ajuda solicitada");
    print(CurrentUser.uid);

//    await UserService().requestHelp("2ugm9sISPnUICguJHH1t");
    await UserService().requestHelp(CurrentUser.uid);

    Alerts.alert(context, "Ajuda solicitada", "Aguarde o contato e tenha fé");
  }
}
