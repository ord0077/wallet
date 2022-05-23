import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pk_wallets/screens/forms/SecondForm.dart';

import '../../consts.dart';
import '../Dashboard.dart';

class FirstForm extends StatelessWidget {
  String cat_name;

  // const FirstForm({Key? key}) : super(key: key);

  FirstForm(this.cat_name);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MaterialApp(
      title: cat_name,
      theme: ThemeData(
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      home: Scaffold(

        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: color_blue,
          title: Center(child: Text(cat_name)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.of(context).pop()},
          ),
        ),
        backgroundColor: color_back,
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [

              Center(
                child: Image.asset(
                  "assets/images/header.jpeg",
                  // fit:BoxFit.fitWidth,
                  // height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 8.0, horizontal: 4.0),
                            //   child: Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text(
                            //       "Email",
                            //       style:
                            //       TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                            //     ),
                            //   ),
                            // ),
                            Material(
                              color: Colors.transparent,
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: Container(
                                margin: EdgeInsets.only(right: 20,left: 20,top: 5),
                                  decoration: BoxDecoration(
                                      color:Colors.transparent ,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: color_blue,
                                              width: 2.0
                                          )
                                      )
                                  ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      contentPadding: EdgeInsets.all(15.0),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                  obscureText: false,
                                  // validator: validator,
                                  // onSaved: onSaved,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 8.0, horizontal: 4.0),
                            //   child: Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text(
                            //       "Phone No",
                            //       style:
                            //       TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                            //     ),
                            //   ),
                            // ),
                            Material(
                              // elevation: 10,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: Container(
                                margin: EdgeInsets.only(right: 20,left: 20,top: 10),
                                decoration: BoxDecoration(
                                    color:Colors.transparent ,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: color_blue,
                                            width: 2.0
                                        )
                                    )
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Phone No',
                                      contentPadding: EdgeInsets.all(15.0),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                  obscureText: false,
                                  // validator: validator,
                                  // onSaved: onSaved,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:150.0,right:15.0,left: 15.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                                color: HexColor.fromHex('#3183b5'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SecondForm(cat_name)));
                                },
                                child: Center(
                                  child: Text(
                                    'Proceed',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
