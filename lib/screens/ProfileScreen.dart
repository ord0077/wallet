import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_wallets/screens/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';
import 'login_screen.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 73, top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () =>  changePage(0),
                          icon: Icon(
                            AntIcons.arrowLeftOutlined,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () =>  AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            showCloseIcon: true,
                            closeIcon: const Icon(Icons.cancel_outlined),
                            title: 'Logout',
                            desc:
                            'Are you sure you want to Logout?',
                            btnCancelText: "No",
                            btnOkText: "Yes",
                            btnOkColor: Colors.green ,
                            btnCancelColor: Colors.red ,
                            btnCancelOnPress: () {


                              // if(Platform.isAndroid){
                              //   SystemNavigator.pop();
                              // }else{
                              //   Navigator.push(
                              //       context, new MaterialPageRoute(builder: (context) => DashBoard()));
                              // }
                            },
                            onDissmissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            },
                            btnOkOnPress: () async {
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
                          ).show(),
                          icon: Icon(
                            AntIcons.logoutOutlined,
                            color: Colors.white,
                          )),
                      // Icon(
                      //   AntIcons.logoutOutlined,
                      //   color: Colors.white,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      'Jhone Doe',
                                      style: TextStyle(
                                        color:
                                        Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Orders',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '10',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: Icon(
                                AntIcons.settingOutlined,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    width: innerWidth * 0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  /*  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Orders',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.cancel_outlined),
      title: 'Logout',
      desc:
      'Are you sure you want to Logout?',
      btnCancelText: "No",
      btnOkText: "Yes",

      btnOkColor: Colors.green ,
      btnCancelColor: Colors.red ,
      btnCancelOnPress: () {
        print("you choose no");
        Navigator.of(context).pop(true);
      },
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () async {
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
    ).show();
    // set up the AlertDialog
    AlertDialog alert= new AlertDialog(
      title: Text('Are you sure ?'),
      content: Text('You want to Logout ?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("you choose no");
            Navigator.of(context).pop(false);
          },
          child: Text('No',style: TextStyle( fontSize: 17,color: Colors.red), ),
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
          child: Text('Yes', style: TextStyle( fontSize: 17,color:Colors.green)),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  AlertDialog _exitApp(BuildContext context) {
    return new AlertDialog(
      title: Text('Are you sure ?'),
      content: Text('You want to Logout ?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("you choose no");
            Navigator.of(context).pop(false);
          },
          child: Text('No',style: TextStyle( fontSize: 17,color: Colors.red), ),
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
          child: Text('Yes', style: TextStyle( fontSize: 17,color:Colors.green)),
        ),
      ],
    );
  }
}