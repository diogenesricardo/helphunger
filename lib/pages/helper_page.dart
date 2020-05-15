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

    /*return StreamBuilder<QuerySnapshot>(
      stream: UserService().getUsers(),
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

        return ListView.builder(
          itemBuilder: (context, index) => Text(
            users[index].nome,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          itemCount: users.length,
        );
      },
    );*/
  }

  _body() {
    return Container(
      color: Colors.brown[100],
      child: StreamBuilder<QuerySnapshot>(
        stream: UserService().getUsers(),
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

          return ListView.builder(
            itemBuilder: (context, index) => Center(
              child: Text(
                users[index].nome,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            itemCount: users.length,
          );
        },
      ),
    );
  }
}
