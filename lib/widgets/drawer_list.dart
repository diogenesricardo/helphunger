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
                    return Text(user.displayName);
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
                      backgroundImage: NetworkImage(
                          user.photoUrl),
                    );
                  }
                  return Text("");
                },
              ),
            ),
            ListTile(
              onTap: () {
                print("Item 1");
              },
              title: Text("Item 1"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 2");
              },
              title: Text("Item 2"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 3");
              },
              title: Text("Item 3"),
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
              title: Text("Visite o site"),
              leading: Icon(Icons.web),
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