

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omegashare/pages/activity_feed.dart';
import 'package:omegashare/pages/create_account.dart';
import 'package:omegashare/pages/profile.dart';
import 'package:omegashare/pages/search.dart';

import 'package:omegashare/pages/upload.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = Firestore.instance.collection('users');

final DateTime timestamp = DateTime.now();

class _HomeState extends State<Home> {
  bool auth = false;
  PageController pageController;
  int pageIndex = 0;

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore(account);
      setState(() {
        auth = true;
      });
    } else {
      setState(() {
        auth = false;
      });
    }
  }

  createUserInFirestore(account) async {
    final GoogleSignInAccount user = googleSignIn.currentUser;

    final DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      usersRef.document(user.id).setData({
        'id': user.id,
        'username': username,
        'userUrl': user.photoUrl,
        'email': user.email,
        'displayName': user.displayName,
        'bio': '',
        'timestamp': timestamp,
        'postCount': 0,
        'isAdmin': false,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Erro $err');
    });

    // Reautenticação ao usuário voltar pro app
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Erro $err');
    });
  }

  @override
  dispose() {
    super.dispose();
    pageController.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        curve: Curves.easeIn, duration: Duration(milliseconds: 200));
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
//          Timeline(),
          FlatButton(
            child: Text('Deslogar'),
            onPressed: logout,
          ),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 35.0,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
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
