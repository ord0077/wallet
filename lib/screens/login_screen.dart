import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pk_wallets/consts.dart';
import 'package:pk_wallets/models/loginModel.dart';
import 'package:pk_wallets/repositories/loginRepository.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final LoginRepository _login = LoginRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSelected = false;
  late Timer timer;
  bool loginIsTapped = false;
  bool _isObscure = true;

//  @override
//  void initState() {
//    if (timer != null) timer.cancel();
//    super.initState();
//  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _buildMobileLayout(context);
  }


  @override
  Widget _buildMobileLayout(BuildContext context){
    return SafeArea(
        child:Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,

            body: Builder(
                builder: (context) {
                  return  Stack(
                    children: <Widget>[

                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  // Logo image of login screen
                                  Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    height: 150,
                                    child: Image.asset(
                                        "assets/images/pkwallets.png"
                                    ),
                                  ),


                                  SizedBox(height: 16.0,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Login',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500)),
                                  ),

                                  SizedBox(height: 5.0,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Please login to your account',style: TextStyle(fontSize: 14.0)),
                                  ),

                                  SizedBox(height: 15.0,),

                                  // Input textfields for email
                                  InputEmail(
                                    hint: "Email",
                                    icon: Icons.email_outlined,
                                    isPassword: false,
                                    textController: emailController,
                                  ),

                                  SizedBox(height: 15.0,),


                                  // Input textfields for password
                                  InputBox(
                                    hint: "Password",
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                    textController: passwordController,
                                  ),





                                  SizedBox(height: 20.0,),

                                  // Button
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      color: DarkBlue,
                                      child: Center(
                                        child: loginIsTapped? Center(
                                            child: SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                                strokeWidth: 3.0,
                                              ),
                                            )
                                        ):Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,fontSize: 16.0
                                          ),
                                        ),
                                      ),
                                    ),

                                    onTap: () async
                                    {

                                      if (emailController.text == "" || passwordController.text == ""){
                                        _showToast(context, 'One or more feild(s) are empty');
                                      } else{

                                        setState(() {
                                          loginIsTapped = loginIsTapped? false:true;
                                        });

                                        // String _email = "customer2@ord.com";
                                        // String _password = "secret";
                                        String _email = emailController.text;
                                        String _password = passwordController.text;



                                        Future<LoginModel> loginResponse = _login.login(_email, _password);

                                        loginResponse.then((loginModel) async {

                                          SharedPreferences userData = await SharedPreferences.getInstance();
                                          String userJSON = jsonEncode(loginModel);
                                          // userData.setString('token', loginModel.token.toString());
                                          userData.setString('token', "");

                                          userData.setInt('user_id', loginModel.user.id);
                                          userData.setString('role_type', loginModel.user.roleType  );
                                          userData.setString('user_name', loginModel.user.firstName);
                                          userData.setString("wallet", loginModel.user.wallet);

                                          userData.setString(userKey, userJSON);
                                          var tokenn = userData.getString('token');
                                          print(tokenn);
                                          userData.remove(userKey);
                                          userData.setString(userKey, userJSON);

                                          print(loginModel.user.roleType.toLowerCase());
//                                      loginModel.user.userType = "User";
                                          switch (loginModel.user.roleType) {
                                            case "Shopkeeper":
                                              Navigator.pushReplacementNamed(
                                                context,
                                                '/Shopkeeper',
                                              );
                                              break;

                                            case "public":
                                              Navigator.pushReplacementNamed(
                                                context,
                                                '/public',
                                              );
                                              break;

                                            default:
                                              _showToast(context, 'Some error occurred please try again later');
                                          }
                                        }).catchError((error){
                                          if(error is SocketException){
                                            //treat SocketException
                                            Fluttertoast.showToast(
                                                msg: "No internet connection available",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                          else if(error is TimeoutException){
                                            //treat TimeoutException
                                            print("Timeout exception: ${error.toString()}");
                                          }
                                          else _showToast(context, error);
                                        }).whenComplete((){
                                          setState(() {
                                            loginIsTapped = false;

                                          });
                                        });

                                      }
                                    },

                                  ),

                                  SizedBox(height: 60.0,),

//                              GestureDetector(
//                                child: Align(
//                                  alignment: Alignment.center,
//                                  child: Text(
//                                    "Forgot Password ?",
//                                    style: TextStyle(
//                                        color: Colors.black87,fontSize: 18.0
//                                    ),
//                                  ),
//                                ),
//                                onTap: (){
////                               Navigator.push(
////                                 context,
////                                 MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
////                               );
//                                },
//                              ),
                                ],

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            )
        )
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class InputBox extends StatefulWidget {


  const InputBox({
    Key? key,
    required this.textController, required this.hint, required this.icon, required this.isPassword,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final IconData icon;
  final bool isPassword;
  @override
  _InputBox createState() => new _InputBox();
}

class _InputBox extends State<InputBox> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),

      ),
      child: Row(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              widget.icon,
            ),
          ),

          Flexible(
            child: TextField(
//              enableInteractiveSelection: false,
//              autofocus: false,
//              autocorrect: false,
              obscureText: _obscureText ,
              controller: widget.textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                suffixIcon: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child:
                  new Icon(_obscureText ? Icons.visibility_off : Icons.visibility ,color: DarkBlue,),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}

class InputEmail extends StatefulWidget {


  const InputEmail({
    Key? key,
    required this.textController, required this.hint, required this.icon, required this.isPassword,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final IconData icon;
  final bool isPassword;
  @override
  _InputEmail createState() => new _InputEmail();
}

class _InputEmail extends State<InputEmail> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),

      ),
      child: Row(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              widget.icon,
            ),
          ),

          Flexible(
            child: TextField(
//              enableInteractiveSelection: false,
//              autofocus: false,
//              autocorrect: false,
              obscureText: widget.isPassword ,
              controller: widget.textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,

              ),

            ),
          ),
        ],
      ),
    );
  }
}