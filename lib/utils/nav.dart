import 'package:flutter/material.dart';

class NavigatorHelper{

static push(BuildContext context, Widget page) {
//pushReplacement não empilha a activity
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return page;
    },
  ));
}

static pushReplacement(BuildContext context, Widget page) {
//pushReplacement não empilha a activity
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return page;
    },
  ));
}

static pop(BuildContext context) {
  Navigator.pop(context);
}

}

