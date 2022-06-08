import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pk_wallets/common/common.dart';
import 'package:pk_wallets/consts.dart';
import 'package:pk_wallets/models/categoryModel.dart';
import 'package:pk_wallets/screens/ProfileScreen.dart';
import 'package:pk_wallets/widgets/appbarWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/CustomAlertDialog.dart';
import 'SubCategory.dart';

class DashBoard extends StatefulWidget {
  static List<SubCategory> subcatList = <SubCategory>[];
  static List<SubCategory> subcatListFilter = <SubCategory>[];

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool? isHomeDataLoading;
  String userName = '';
  int current_index = 0;
  String walletAmount = "";

  Padding CategoryGrid(
      AsyncSnapshot<List<Category>> snapshot, Function gridClicked) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 5.0,
        ),
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   childAspectRatio: 1,
        //   crossAxisCount: 3,
        // ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: CategoryCell(snapshot.data![index]),
            onTap: () => gridClicked(context, snapshot.data![index]),
          );
        },
      ),
    );
  }

  Padding RecordsCount(
      AsyncSnapshot<List<RecentRecords>> snapshot, Function gridClicked) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, int index) {
          var size = MediaQuery.of(context).size;
          String? pending = snapshot.data![index].pending_records;
          String pendingStr = "";
          String? accept = snapshot.data![index].accepted_records;
          String acceptStr = "";
          String? refund = snapshot.data![index].refund_records;
          String refundStr = "";
          if (pending == null) {
            pendingStr = "";
          } else {
            pendingStr = pending;
          }
          if (accept == null) {
            acceptStr = "";
          } else {
            acceptStr = accept;
          }
          if (refund == null) {
            refundStr = "";
          } else {
            refundStr = refund;
          }
          return Container(
              width: size.longestSide,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: size.width * .25,
                    child: Column(
                      children: [
                        Text(
                          pendingStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Text(
                          "Pending",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Column(
                      children: [
                        Text(
                          acceptStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Text(
                          "Accepted",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * .25,
                    child: Column(
                      children: [
                        Text(
                          refundStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Text(
                          "Refund",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  void _changeTab(int index) {
    setState(() {
      current_index = index;
      // tabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int _page = 0;
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    var tabs = [
      Stack(
        children: [
          Container(
            height: height * 0.25,
            color: color_blue,
          ),
          Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  MyAppBar(),
                  Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: height,
                        width: width / 1.06,
                        child: Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              margin: EdgeInsets.all(5),
                              elevation: 15.0,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 15,right: 10,left: 10),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                                width: 1,
                                              ),
                                              Expanded(
                                                child:
                                                  Column(
                                                    children: [
                                                      AutoSizeText(
                                                        "Current Balance",
                                                        // textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'Montserrat Medium',
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.normal,
                                                            fontSize: width * 0.046,),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      AutoSizeText(
                                                          "SR " + walletAmount,
                                                          style: TextStyle(
                                                            fontFamily:
                                                            'Montserrat Medium',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w900,
                                                            fontSize:  width * 0.09,
                                                          ),
                                                          minFontSize: 10),
                                                    ],
                                                  )
                                              ),

                                              // const SizedBox(height: 50,),
                                              // Expanded(
                                              //   child:
                                              // ),
                                              const SizedBox(
                                                height: 10,
                                                width: 1,
                                              ),
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent
                                                    style: TextStyle(
                                                      fontSize: width * 0.045,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(text: 'Welcome ',style:
                                                      const TextStyle(
                                                        fontFamily:
                                                        'Montserrat Medium',
                                                      )),
                                                      TextSpan(
                                                          text: userName,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Montserrat Medium',
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // const SizedBox(width: 20),
                                        // Spacer(),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 50,
                                                width: 1,
                                              ),
                                              Center(

                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                      Radius.circular(7.0),
                                                    ),
                                                    border: Border.all(
                                                        color: color_blue,
                                                        width: 2),
                                                    color: color_blue,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 8.0,),
                                                      Container(
                                                        child: Image.asset(
                                                          "assets/images/toopup.png",
                                                          // fit:BoxFit.scaleDown,
                                                          height: 27,
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                          "Top Up",
                                                          style: TextStyle(
                                                            fontFamily:
                                                            'Montserrat Medium',
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 20,
                                                            letterSpacing: 1,
                                                          ),
                                                          minFontSize: 10,),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // ConstrainedBox(
                                              //     constraints: BoxConstraints(
                                              //       minWidth: 20,
                                              //       minHeight: 30,
                                              //       maxWidth: 50,
                                              //       maxHeight: 80,
                                              //     ),
                                              //     child: )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 20.0,top: 20.0),
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      "Add New Transaction",
                      style: TextStyle(
                        fontFamily:
                        'Montserrat Medium',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                      minFontSize: 10,
                    ),
                  ),
                  Flexible(
                      flex: 4,
                      child: Container(
                        child: Center(
                          child: Container(
                            child: FutureBuilder<List<Category>>(
                              future: Services.fetchCategoryData(
                                  "http://newapp.pkwallets.com/api/get_all_category"),
                              builder: (context, snapshot) {
                                return snapshot.connectionState ==
                                        ConnectionState.done
                                    ? snapshot.hasData
                                        ? CategoryGrid(snapshot, gridClicked)
                                        : ComComp.retryButton(fetch)
                                    : ComComp.circularProgress();
                              },
                            ),
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 17, right: 17, bottom: 1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    border:
                                        Border.all(color: color_blue.withOpacity(0.6), width: 2),
                                    color: color_blue.withOpacity(0.6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Recent Records",
                                        style: TextStyle(color: Colors.black87, fontWeight:
                                        FontWeight.bold, ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 4,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: FutureBuilder<List<RecentRecords>>(
                                future: Services.fetchRecordsCount(
                                    "http://newapp.pkwallets.com/api/get_count_record"),
                                builder: (context, snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.done
                                      ? snapshot.hasData
                                          ? RecordsCount(snapshot, gridClicked)
                                          : Container(
                                              width: size.longestSide,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: size.width * .25,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "100",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.blue,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: size.width*.08),
                                                        ),
                                                        Text(
                                                          "Pending",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * .3,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "120",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.blue,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: size.width*.08),
                                                        ),
                                                        Text(
                                                          "Accepted",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * .25,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "101",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.blue,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: size.width*.08),
                                                        ),
                                                        Text(
                                                          "Refund",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Medium',
                                                              color: Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ))
                                      /*ComComp.retryButton(fetch)*/
                                      : ComComp.circularProgress();
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 17, right: 17, bottom: 1,top: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(child: Container(
                                    height:  height * 0.06,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5.0))),
                                      color: HexColor.fromHex('#3183b5'),
                                      onPressed: () {
                                      },
                                      child: Center(
                                        child: Text(
                                          'View Transactions',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), flex: 1,),
                                  Flexible(child: Container(
                                    height:  height * 0.06,
                                    margin: EdgeInsets.only(left: 10),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5.0))),
                                      color: HexColor.fromHex('#3183b5'),
                                      onPressed: () {
                                      },
                                      child: Center(
                                        child: Text(
                                          'View Logs',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), flex: 1,)
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //     width: size.longestSide,
                          //     margin: EdgeInsets.only(top: 35),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //       MainAxisAlignment.center,
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: [
                          //         Container(
                          //           height: height * 0.06,
                          //           child:RaisedButton(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                 BorderRadius.all(Radius.circular(5.0))),
                          //             color: HexColor.fromHex('#3183b5'),
                          //             onPressed: () {
                          //             },
                          //             child: Center(
                          //               child: Text(
                          //                 'View Transactions',
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           height: height * 0.06,
                          //           margin: EdgeInsets.only(left: 10),
                          //           child:RaisedButton(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                 BorderRadius.all(Radius.circular(5.0))),
                          //             color: HexColor.fromHex('#3183b5'),
                          //             onPressed: () {
                          //             },
                          //             child: Center(
                          //               child: Text(
                          //                 'View Logs',
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ))
                        ],
                      )),
                ],
              ))
        ],
      ),
      Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.black12,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => _changeTab(0),
                        icon: Icon(
                          AntIcons.arrowLeftOutlined,
                          color: Colors.black,
                        )),
                    Text(
                      '      ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.receipt_long, size: 30, color: Colors.black),
                    Text(
                      'Payment History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FittedBox(
                        child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blueAccent),
                      columns: [
                        DataColumn(
                            label: Center(
                          child: Text('Payment Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                        DataColumn(
                            label: Center(
                          child: Text('Payment Mode',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                        DataColumn(
                            label: Center(
                          child: Text('Previous Outstanding',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                        DataColumn(
                            label: Center(
                          child: Text('Paid Amount',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                        DataColumn(
                            label: Center(
                          child: Text('Balance',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ))
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                        DataRow(cells: [
                          DataCell(Center(child: Text('29-12-2020'))),
                          DataCell(Center(child: Text('BPM-OGJ'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('5.380'))),
                          DataCell(Center(child: Text('0.000'))),
                        ]),
                      ],
                    )),
                  ))
            ],
          )
        ],
      ),
      Center(
        child: Text("Records"),
      ),
      Center(
        child: Text("Add"),
      ),
      new ProfileScreen(changePage: _changeTab),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          // statusBarColor: color_blue
        ),
        child: SafeArea(
            child: Scaffold(
          extendBody: true,
          // appBar: ,
          body: tabs[current_index],
          bottomNavigationBar: CurvedNavigationBar(
            height: 60.0,
            backgroundColor: Color(0x00ffffff),
            items: <Widget>[
              Icon(
                AntIcons.homeFilled,
                size: 30,
                color: Colors.white,
              ),
              Icon(Icons.receipt_long, size: 30, color: Colors.white),
              Icon(Icons.add, size: 30, color: Colors.white),
              Icon(Icons.my_library_books_sharp, size: 30, color: Colors.white),
              Icon(Icons.settings, size: 30, color: Colors.white),
            ],
            color: color_blue,
            index: current_index,
            buttonBackgroundColor: color_blue,
            // backgroundColor: Color(0x00ffffff),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                current_index = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        )));
  }

  @override
  void initState() {
    super.initState();
    isHomeDataLoading = false;
    FetchData();
  }

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  fetch() {
    setLoading(true);
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
      walletAmount = (prefs.getString('wallet') ?? '');
    });
  }
}

gridClicked(BuildContext context, Category cellModel) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? sub_categoryString = await prefs.getString('all_sub_category');
  // List<Children> SubCategoryList = Children.decode(sub_categoryString!);
  List<SubCategory> SubCategoryListFiltered = <SubCategory>[];
  String encodedData = "";
  for (var i = 0; i < cellModel.children.length; i++) {
    SubCategory subCategoryModel = cellModel.children[i];
    // if (DashBoard.subcatList[i].parentId == cellModel.id.toString()) {
    //   // encodedData += SubCategory.encode([
    //   //   SubCategory(
    //   //     cat_id: subCategoryModel.cat_id,
    //   //     name: subCategoryModel.name,
    //   //     mobile_icon: subCategoryModel.mobile_icon,
    //   //     category_name: subCategoryModel.category_name,
    //   //   )
    //   // ]);
    // }
    SubCategoryListFiltered.add(subCategoryModel);
    DashBoard.subcatListFilter.add(subCategoryModel);
  }
  String? nme = cellModel.name;
  prefs.setString('cat_name', nme == null ? "" : nme);
  await prefs.setString('sub_category', encodedData);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => SubCategoryScreen()));

  // _opensubCatgory(context,nme!,SubCategoryListFiltered);
}

Future<void> _opensubCatgory(BuildContext context, String heading,
    List<SubCategory> SubCategoryList) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        title: new Text(
          heading,
          style:
              new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: Wrap(children: [
          Container(
            // Specify some width
            width: MediaQuery.of(context).size.width * .7,
            child: Center(
              child: Container(
                child: SubCategoryList.length != 0
                    ? SubCategoryGrid(SubCategoryList, gridClicked)
                    : Container(
                        margin: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "No Record Found!",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ]),
        actions: <Widget>[
          new IconButton(
              splashColor: Colors.white,
              icon: new Icon(
                Icons.done,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class RecentRecords {
  String? pending_records;
  String? accepted_records;
  String? refund_records;

  RecentRecords(
      {this.pending_records, this.accepted_records, this.refund_records});

  RecentRecords.fromJson(Map<String, dynamic> json) {
    pending_records = json['pending_records'];
    accepted_records = json['accepted_records'];
    refund_records = json['refund_records'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_records': pending_records,
      'accepted_records': accepted_records,
      'refund_records': refund_records
    };
  }
}

class CategoryCell extends StatelessWidget {
  const CategoryCell(this.cellModel);

  @required
  final Category cellModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.5,
      height: size.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              border: Border.all(color: color_blue, width: 2),
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ConstrainedBox(
                    //   constraints: BoxConstraints(
                    //     minWidth: 20,
                    //     minHeight: 30,
                    //     maxWidth: 50,
                    //     maxHeight: 80,
                    //   ),
                    //   child: Container(
                    //     child: Image.asset(
                    //       "assets/images/tpo.jpg",
                    //       // fit:BoxFit.fitWidth,
                    //       // height: 40,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Text(
                      "${cellModel.name}",
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: color_blue, fontSize: size.width*.04,fontWeight: FontWeight.w500),
                    ),
                    // const SizedBox(height: 20),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class SubCategoryCell extends StatelessWidget {
  const SubCategoryCell(this.cellModel);

  @required
  final SubCategory cellModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.5,
      height: size.height * 0.1,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              border: Border.all(color: HexColor.fromHex('#3183b5'), width: 2),
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ConstrainedBox(
                    //   constraints: BoxConstraints(
                    //     minWidth: 20,
                    //     minHeight: 30,
                    //     maxWidth: 50,
                    //     maxHeight: 80,
                    //   ),
                    //   child: Container(
                    //     child: Image.asset(
                    //       "assets/images/tpo.jpg",
                    //       // fit:BoxFit.fitWidth,
                    //       // height: 40,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Text(
                      "${cellModel.name}",
                      // overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    // const SizedBox(height: 20),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Services {
  static Future<List<Category>> fetchHomeData(String Url) async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      List<Category> _category_list = <Category>[];

      for (var item in convert.jsonDecode(response.body)) {
        {
          _category_list.add(Category.fromJson(item));
          // _category_list.add(Autogenerated.fromJson(item));
          // _category_list.map((user) => ;
        }
      }
      SharedPreferences userData = await SharedPreferences.getInstance();
      await userData.setString('all_sub_category', "");
      return _category_list;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Category>> fetchCategoryData(String Url) async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      List<Category> _category_list = <Category>[];

      for (var item in convert.jsonDecode(response.body)) {
        {
          _category_list.add(Category.fromJson(item));
        }
      }
      // _category_list.map((user) => Autogenerated.fromJson(convert.jsonDecode(response.body))).toList();
      SharedPreferences userData = await SharedPreferences.getInstance();
      // await userData.setString('all_sub_category', Category.encodedData);
      return _category_list;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<RecentRecords>> fetchRecordsCount(String Url) async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      List<RecentRecords> _category_list = <RecentRecords>[];
      _category_list.add(RecentRecords.fromJson(jsonDecode(response.body)));
      return _category_list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static List<Category> parsePostsForHome(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }
}
