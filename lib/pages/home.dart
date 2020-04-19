import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

GoogleSignIn googleSignIn = GoogleSignIn();

class _HomeState extends State<Home> {
  bool auth = false;

  handleSignIn(GoogleSignInAccount account) {
    setState(() {
      auth = account != null;
    });
  }

  @override
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Erro $err');
    });

    // Reautenticação ao usuário voltar pro app
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }, onError: (err){
        print('Erro $err');
    });
  }

  login() {
    googleSignIn.signIn();
  }

  Widget buildAuthScreen() {
    return Text('Autenticado');
  }

  Scaffold buildUnauthScreen() {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Omega Share',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 240.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return auth ? buildAuthScreen() : buildUnauthScreen();
  }
}
