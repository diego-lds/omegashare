import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omegashare/pages/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text('Usuário $username criado com sucesso'),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  String validations(value) {
    if (value.length < 3 || value.length == 0) {
      return 'Usuário inválido';
    } else if (value.length > 30) {
      return 'Usuário muito longo';
    }
    return null;
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: header(context, isAppTitle: true, titleText: 'Crie se Perfil'),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidate: true,
              child: TextFormField(
                validator: (value) {
                  return validations(value.trim());
                },
                onSaved: (value) => username = value,
                decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  focusedBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                onPressed: submit,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: Colors.blueAccent,
                child: Text(
                  'Prosseguir',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
