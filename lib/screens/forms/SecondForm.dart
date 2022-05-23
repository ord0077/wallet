import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../widgets/CustomDialogBox.dart';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: color_back,
        appBar: AppBar(
          backgroundColor: color_blue,
          title: Center(child: Text(cat_name)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.of(context).pop()},
          ),
        ),
        body: Column(
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
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "Bill No",
                        //       style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        //     ),
                        //   ),
                        // ),
                        Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                                  hintText: 'Enter Bill No',
                                  contentPadding: EdgeInsets.all(15.0),
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey/*Color(0xF7F7F7)*/, fontSize: 14)),
                              obscureText: false,
                              // validator: validator,
                              // onSaved: onSaved,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "Account No",
                        //       style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        //     ),
                        //   ),
                        // ),
                        Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                                  hintText: 'Enter Account No',
                                  contentPadding: EdgeInsets.all(15.0),
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                              obscureText: false,
                              // validator: validator,
                              // onSaved: onSaved,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "Amount",
                        //       style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                        //     ),
                        //   ),
                        // ),
                        Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                                  hintText: 'Enter Amount',
                                  contentPadding: EdgeInsets.all(15.0),
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
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
                                borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            color:  color_blue,
                            onPressed: () {
                              // showDialog(context: context,
                              //     builder: (BuildContext context){
                              //       return CustomDialogBox(
                              //         title: "Custom Dialog Demo",
                              //         descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                              //         text: "Yes",
                              //       );
                              //     }
                              // );
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
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),


                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
