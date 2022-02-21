

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_wallets/models/loginModel.dart';
import 'package:pk_wallets/screens/Dashboard.dart';
import 'package:pk_wallets/screens/login_screen.dart';
import 'package:pk_wallets/screens/shopkeeper/shopkeeper_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'consts.dart';


Future<void> main() async {

//  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };

// WidgetsFlutterBinding.ensureInitialized();
// await FlutterDownloader.initialize(
//     debug: true // optional: set false to disable printing logs to console
// );
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();

  bool isLogged = false;
  String route = '/login';
// String route = '/project_Admin';

  @override
  Widget build(BuildContext context) {


// FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.grey, //or set color with: Color(0xFF0000FF)
// ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
// For Android.
// Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
// For iOS.
// Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: FutureBuilder<SharedPreferences>  (
          future: sharedPreferences(),
          builder: (context, snapshot) {
            if (  snapshot.hasData && snapshot !=null) {

              isLogged = snapshot.data!.containsKey(userKey);
              print(userKey);

              if (isLogged ) {
                Map<String, dynamic> userMap = jsonDecode(snapshot.data!.getString(userKey) ?? "");
                LoginModel userData = LoginModel.fromJson(userMap);

                switch (userData.user.roleType) {
                  case "Shopkeeper":
                    route = '/Shopkeeper';
                    break;

                  default:
                    route = '/login';
// route = '/project_Admin';
                }
              }

              return MaterialApp(

                title: 'PK Wallets',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColorLight: Colors.black,
                  accentColor: Color(0xFFF9F8F4),
                  buttonColor: Color(0xFF333333),
                  backgroundColor: Color(0xFFF9F8F4),
// appBarTheme: ,

                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),

                  tabBarTheme: TabBarTheme(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black26,
                    labelPadding: EdgeInsets.only(top: 32.0),
                    indicator: ShapeDecoration(
                      shape: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  scaffoldBackgroundColor: const Color(0xFFF9F8F4),

                  textTheme: TextTheme(
// headline: TextStyle(
//   fontSize: 24.0,
//   fontWeight: FontWeight.bold,
// ),
                  ),
                ),

                routes: <String, WidgetBuilder>{
                  '/login': (BuildContext context) => new LoginScreen(),
                  '/Shopkeeper': (BuildContext context) =>  new DashBoard(),


                },


                initialRoute: route,
// initialRoute: isLogged? '/customer' : '/login',
// home: LoginScreen(),
              )
              ;

            }
            else {
              return Container(height: 0,width: 0,);

//                MaterialApp(
//                debugShowCheckedModeBanner: false,
//                theme: ThemeData(
//                  primaryColorLight: Colors.black,
//                  accentColor: Color(0xFFF9F8F4),
//                  buttonColor: Color(0xFF333333),
//                  backgroundColor: Color(0xFFF9F8F4),
//                ),
//
//                builder: (_, __) {
//                  return Scaffold(
//                    body: Container(
//                      color: Color(0xFFCCCCCC),
//                      child: Center(
//                        child: Text(
//                          'WELCOME BACK',
//                          style: TextStyle(
//                            fontSize: 32.0,
//                            color: Colors.black,
//                          ),
//                        ),
//                      ),
//                    ),
//                  );
//                },
//              );
            }
          }
      ),
    );


//    WidgetsBinding.instance.addPostFrameCallback((_) async {


//    }
//    );
  }
}