import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle: false, String titleText}) {
  return AppBar(
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
