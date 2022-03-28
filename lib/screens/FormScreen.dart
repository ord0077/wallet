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
          title: Center(child: Text(cat_name)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TestForm(cat_name),
        ),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  String cat_name;

  TestForm(this.cat_name);

  @override
  _TestFormState createState() => _TestFormState(cat_name);
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  String cat_nme;

  _TestFormState(this.cat_nme);

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
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
                    "Email",
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
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                  obscureText: false,
                  // validator: validator,
                  // onSaved: onSaved,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone No",
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
                      hintText: 'Phone No',
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
        ));
  }
}

class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  String hint;

  InputWidget(this.hint, this.topRight, this.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];