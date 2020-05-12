
import 'package:flutter/material.dart';

class Alerts{

static alert (BuildContext context,String title, String msg, {function}){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () => function ?? Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
}

