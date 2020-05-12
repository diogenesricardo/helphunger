import 'package:ajudafome/pages/helped_page.dart';
import 'package:ajudafome/pages/helper_page.dart';
import 'package:ajudafome/utils/nav.dart';
import 'package:ajudafome/widgets/drawer_list.dart';
import 'package:ajudafome/widgets/main_buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temos uns aos outros"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      color: Colors.brown,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonHelp("Alguém me ajuda", _onClickHelpedPage),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonHelp("Quero ajudar alguém", _onClickHelperPage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onClickHelpedPage() {
    NavigatorHelper.push(context, HelpedPage());
  }

  _onClickHelperPage() {
    NavigatorHelper.push(context, HelperPage());
  }
}
