import 'package:flutter/material.dart';

class ButtonHelp extends StatelessWidget {
  String title;
  Function onPressed;

  ButtonHelp(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      color: Colors.brown[100],
      child: Text(
        title,
        style: new TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      onPressed: onPressed,

    );

    /*InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {},
      splashColor: Colors.blue,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
//          gradient: LinearGradient(colors: colors),
          color: Colors.blue,

          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );*/
  }
}
