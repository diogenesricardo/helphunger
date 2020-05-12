import 'package:ajudafome/models/user.dart';
import 'package:ajudafome/pages/login_page.dart';
import 'package:ajudafome/utils/firebase_service.dart';
import 'package:ajudafome/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 300,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<FirebaseUser>(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return user.displayName != null
                        ? Text(user.displayName)
                        : Text("Novo usuário");
                  }
                  return Text("");
                },
              ),
              accountEmail: FutureBuilder<FirebaseUser>(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return Text(user.email);
                  }
                  return Text("");
                },
              ),
              currentAccountPicture: FutureBuilder<FirebaseUser>(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return CircleAvatar(
                      backgroundImage: user.photoUrl != null
                          ? NetworkImage(user.photoUrl)
                          : NetworkImage(
                              "https://static.thenounproject.com/png/26617-200.png"),
                    );
                  }
                  return Text("");
                },
              ),
            ),
            ListTile(
              onTap: () {
                print("Doações Recebidas");
              },
              title: Text("Item 1"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Doações efetuadas");
              },
              title: Text("Item 2"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Configurações");
              },
              title: Text("Configurações"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              onTap: () {
                print("Ajuda");
              },
              title: Text("Ajuda"),
              leading: Icon(Icons.help),
            ),
            ListTile(
              onTap: () {
                _logout(context);
              },
              title: Text("Logout"),
              leading: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }

  Future _logout(BuildContext context) async {
    print("Logout Firebase");
    final service = FirebaseService();
    service.logout();

    print("Logout");
    NavigatorHelper.pop(context);
    NavigatorHelper.pushReplacement(context, LoginPage());
    User.clear();
  }
}
