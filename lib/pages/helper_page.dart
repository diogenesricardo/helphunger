import 'package:flutter/material.dart';

class HelperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajude alguém")),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text("Ajudando alguém"),
    );
  }
}
