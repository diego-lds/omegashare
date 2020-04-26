import 'package:flutter/material.dart';
import 'package:omegashare/pages/upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      home: Upload(),
    );
  }
}
