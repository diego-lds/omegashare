import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:omegashare/pages/progress.dart';
import 'header.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, titleText: 'Omega Share'),
      body: StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final children = snapshot.data.documents
                .map((doc) => Text(doc['username']))
                .toList();
            return Container(
              child: ListView(children: children),
            );
          }),
    );
  }
}
