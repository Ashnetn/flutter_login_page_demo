import 'package:flutter/material.dart';
import 'package:flutter_demo_login/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userName = "temp";

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  /**
     * Function to check whether user had logged in before
     */
  void _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if ((prefs.getInt('isLoggedIn') ?? 0) == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        setState(() {});

        setState(() {
          this._userName = prefs.getString('username');
        });
      }
    });
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('isLoggedIn', 0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(_userName.toString(),
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _logOut();
                },
                child: Text('Log Out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
