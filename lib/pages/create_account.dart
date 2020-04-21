import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omegashare/pages/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  String username;

  submit(){
    _formKey.currentState.save();
    print(username);
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: 'Crie se Perfil'),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
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
