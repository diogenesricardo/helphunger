import 'package:flutter/material.dart';

class HelpedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ninguém com fome"),
        ),
        body: _body());
  }

  _body() {
    return Center(
      child: Text("Sendo ajudado"),
    );
  }
}
