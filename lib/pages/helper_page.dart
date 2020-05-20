import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperPage extends StatefulWidget {
  @override
  _HelperPageState createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajude"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.brown[100],
      child: StreamBuilder<QuerySnapshot>(
        stream: UserService().getHelpedUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Não foi possível buscar as pessoas");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<User> users =
              snapshot.data.documents.map((DocumentSnapshot document) {
            return User.fromMap(document.data);
          }).toList();

          print(users[0]);

          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(users[index].name),
              subtitle: Text(users[index].wasHelped == true ? "Precisa de ajuda" : "Obteve ajuda há 10 dias"),
            ),
            itemCount: users.length,
          );
        },
      ),
    );
  }
}
