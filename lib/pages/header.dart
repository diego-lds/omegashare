import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle: false, String titleText, removeBackButton: true}) {
  return AppBar(
    automaticallyImplyLeading: !removeBackButton,
    title: Text(
      titleText,
      style: TextStyle(
        fontFamily: isAppTitle ? 'Signatra' : '',
        fontSize: isAppTitle ? 35.0: 22.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
