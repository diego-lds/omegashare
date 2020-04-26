import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omegashare/models/user.dart';
import 'package:omegashare/widgets/progress.dart';
import 'home.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchUsersResult;

  handleSearch(String query) {
    Future<QuerySnapshot> users = usersRef
        .where('displayName', isGreaterThanOrEqualTo: query)
        .getDocuments();

    setState(() {
      searchUsersResult = users;
    });
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Procurar um usuário...",
          filled: true,
          prefixIcon: Icon(Icons.account_box, size: 28.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => searchController.clear(),
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchUsersResult,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult userResult = UserResult(user: user);
          searchResults.add(userResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    Container buildNoContent() {
      final Orientation orientation = MediaQuery.of(context).orientation;
      return Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SvgPicture.asset('assets/images/search.svg', height: orientation == Orientation.portrait ? 300.0 : 150.0),
              Text(
                'Encontre usuários',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, fontSize: 60.0),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        appBar: buildSearchField(),
        body: searchUsersResult == null ? buildNoContent() : buildSearchResults());
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => print('ontap'),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.displayName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(user.username, style: TextStyle(color: Colors.white)),
            ),
          ),
          Divider(height: 2.0, color: Colors.white54),
        ],
      ),
    );
  }
}
