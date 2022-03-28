import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dashboard.dart';

class SecondForm extends StatelessWidget {
  String cat_name;


  SecondForm(this.cat_name);


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return  MaterialApp(
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
        appBar: AppBar(
          title: Center(child: Text(cat_name)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bill No",
                          style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Bill No',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            hintStyle:
                            TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                        obscureText: false,
                        // validator: validator,
                        // onSaved: onSaved,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Account No",
                          style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Account No',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            hintStyle:
                            TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                        obscureText: false,
                        // validator: validator,
                        // onSaved: onSaved,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Amount",
                          style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: TextFormField(

                        decoration: InputDecoration(
                            hintText: 'Amount',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            hintStyle:
                            TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                        obscureText: false,
                        // validator: validator,
                        // onSaved: onSaved,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        color:  Colors.blueAccent,
                        onPressed: () {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.LEFTSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              // showCloseIcon: true,
                              desc: '$cat_name submitted',
                              btnOkOnPress: () {
                                // Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashBoard()));
                              },
                              // btnOkIcon: Icons.check_circle,
                              onDissmissCallback: (type) {
                                debugPrint('Dialog Dissmiss from callback $type');
                              })
                            ..show();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
