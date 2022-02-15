
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pk_wallets/consts.dart';
import 'package:pk_wallets/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ShopkeeperDashboard extends StatefulWidget {

//  final List<Survey> EconomicDetail;

  ShopkeeperDashboard({Key? key,}) : super(key: key);


  @override
  _ShopkeeperDashboard createState() => _ShopkeeperDashboard();
}

class _ShopkeeperDashboard extends State<ShopkeeperDashboard> {


  @override
  void initState() {
  }


  Future<bool?> _exitApp(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) =>
      new AlertDialog(
        title: Text('Are you sure ?'),
        content: Text('You want to Logout ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text(
              'No', style: TextStyle(fontSize: 17, color: Colors.blue),),
          ),
          FlatButton(
            onPressed: () async {
//              SystemChannels.platform.invokeMethod('SystemNavigator.pop');

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(userKey);
              await Future.delayed(Duration(seconds: 1));

              Navigator.of(context).pushAndRemoveUntil(
                // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                      (Route<dynamic> route) => false
              );
            },
            child: Text(
                'Yes', style: TextStyle(fontSize: 17, color: Colors.blue)),
          ),
        ],
      ),
    ) ??
        false;
  }

  late DateTime backbuttonpressedTime;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                _exitApp(context);
              },
            )
          ],
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
