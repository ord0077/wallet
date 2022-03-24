// import 'package:awesome_dialog/animated_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pk_wallets/screens/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:validators/validators.dart' as validator;
import '../models/Model.dart';

class SubmitForm extends StatefulWidget {
  const SubmitForm({Key? key}) : super(key: key);

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  String cat_name = '';

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? sub_categoryString = await prefs.getString('sub_category');
    //Return int
    setState(() {
      cat_name = (prefs.getString('cat_name') ?? '');
      // SubCategoryList = SubCategory.decode(sub_categoryString!);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text(cat_name),
        ),
        body: TestForm(),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          /*Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child:TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Account No',
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    obscureText:  false,
                    // validator: validator,
                    // onSaved: onSaved,
                    keyboardType:TextInputType.number,
                  ),
                  // MyTextFormField(
                  //   hintText:
                  //   validator: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'Enter your account no';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     model.Account_no = value;
                  //   },
                  // ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Bill No',
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    obscureText:  false,
                    // validator: validator,
                    // onSaved: onSaved,
                    keyboardType:TextInputType.number,
                  ),
                  // MyTextFormField(
                  //   hintText: 'Bill No',
                  //   validator: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'Enter your bill no';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (String value) {
                  //     model.Bill_no = value;
                  //   },
                  // ),

                )
              ],
            ),
          ),*/
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Bill No',
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            obscureText:  false,
            // validator: validator,
            // onSaved: onSaved,
            keyboardType:TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Account No',
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            obscureText:  false,
            // validator: validator,
            // onSaved: onSaved,
            keyboardType:TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            obscureText:  false,
            // validator: validator,
            // onSaved: onSaved,
            keyboardType:TextInputType.emailAddress ,
          ),
          // MyTextFormField(
          //   hintText: 'Email',
          //   isEmail: true,
          //   validator: (String value) {
          //     if (!validator.isEmail(value)) {
          //       return 'Please enter a valid email';
          //     }
          //     return null;
          //   },
          //   onSaved: (String value) {
          //     model.email = value;
          //   },
          // ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Phone No',
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          obscureText:  false,
          // validator: validator,
          // onSaved: onSaved,
          keyboardType:TextInputType.phone ,
        ),
          // MyTextFormField(
          //   hintText: 'Phone No',
          //   isPassword: false,
          //   validator: (String value) {
          //     if (value.length < 11 || value.length > 11) {
          //       return 'Invalid Phone number';
          //     }
          //     _formKey.currentState?.save();
          //     return null;
          //   },
          //   onSaved: (String value) {
          //     model.Phone_no = value;
          //   },
          // ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Amount',
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            obscureText:  false,
            // validator: validator,
            // onSaved: onSaved,
            keyboardType:TextInputType.number ,
          ),
          // MyTextFormField(
          //   hintText: 'Amount',
          //   isPassword: false,
          //   validator: (String value) {
          //     if (value.isEmpty) {
          //       return 'Required field';
          //     }
          //     _formKey.currentState?.save();
          //     return null;
          //   },
          //   onSaved: (String value) {
          //     model.Amount = value;
          //   },
          // ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              //
              //   // Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //         builder: (context) => Result(model: this.model)));
              // }
              // AnimatedButton(
              //   text: 'Succes Dialog',
              //   color: Colors.green,
              //
              //   pressEvent: () {
              //
              //   },
              // );
              AwesomeDialog(
                  context: context,
                  animType: AnimType.LEFTSLIDE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.SUCCES,
                  // showCloseIcon: true,
                  desc: 'Form submitted',
                  btnOkOnPress: () {
                    // Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashBoard()));
                  },
                  btnOkIcon: Icons.check_circle,
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
          )
        ],
      ),
    );
  }
}

/*class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final Function? validator;
  final Function? onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        // validator: validator,
        // onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}*/
