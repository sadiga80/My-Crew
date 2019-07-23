import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_crew/pages/activity_feed.dart';
import 'package:my_crew/pages/profile.dart';
import 'package:my_crew/pages/search.dart';
import 'package:my_crew/pages/timeline.dart';
import 'package:my_crew/pages/upload.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  initState() {
    super.initState();

    pageController = PageController();

    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print("Error Signing in :: $err");
    });

    // Re-authenticate user when the app is reopened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print("Error Signing in :: $err");
    });
  }

  dispose() {
    pageController.dispose();
    super.dispose();
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User Signed In ::  $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
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
    pageController.jumpToPage(pageIndex);
  }

  Scaffold authScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 36.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
//    return RaisedButton(
//      child: Text("Logout"),
//      onPressed: logout,
//    );
  }

  Scaffold unAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "My Crew",
              style: TextStyle(
                  fontFamily: "Signatra", fontSize: 80, color: Colors.blue),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                height: 60,
                width: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/google_signin_button.png'),
                      fit: BoxFit.cover),
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
    return isAuth ? authScreen() : unAuthScreen();
  }
}
