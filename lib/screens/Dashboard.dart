import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pk_wallets/common/common.dart';
import 'package:pk_wallets/consts.dart';
import 'package:pk_wallets/models/categoryModel.dart';
import 'package:pk_wallets/widgets/appbarWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SubCategory.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool? isHomeDataLoading;
  String userName = '';

  String walletAmount = "";

  Padding CategoryGrid(
      AsyncSnapshot<List<Category>> snapshot, Function gridClicked) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
      padding: EdgeInsets.only(left: 20),
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
            child: Flexible(
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
                            fontSize: 30),
                      ),
                      Text(
                        "Pending",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat Medium',
                            color: Colors.black,
                            fontSize: 20),
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
                            fontSize: 30),
                      ),
                      Text(
                        "Accepted",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat Medium',
                            color: Colors.black,
                            fontSize: 20),
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
                            fontSize: 30),
                      ),
                      Text(
                        "Refund",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat Medium',
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int _page = 0;
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          // statusBarColor: color_blue
        ),
        child: SafeArea(
            child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: height * 0.15,
                  color: color_blue,
                ),
                Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Flexible(
                            flex: 2,
                            child: Container(
                              height: height,
                              width: width / 1.2,
                              child: Center(
                                child: Card(
                                    margin: EdgeInsets.all(10),
                                    elevation: 2.0,
                                    child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: const AutoSizeText(
                                                        "BALANCE",
                                                        // textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat Medium',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),

                                                    // const SizedBox(height: 50,),
                                                    Expanded(
                                                      child: AutoSizeText(
                                                          "SR " + walletAmount,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat Medium',
                                                            color: color_blue,
                                                            fontSize: 25,
                                                          ),
                                                          minFontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // const SizedBox(width: 20),
                                              // Spacer(),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    new AutoSizeText(
                                                      userName,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      minFontSize: 20,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
//                       textAlign: TextAlign.right,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                      width: 1,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 20,
                                                        minHeight: 30,
                                                        maxWidth: 50,
                                                        maxHeight: 80,
                                                      ),
                                                      child: Container(
                                                        child: Image.asset(
                                                          "assets/images/tpo.jpg",
                                                          // fit:BoxFit.fitWidth,
                                                          // height: 40,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ),
                            )),
                        Flexible(
                            flex: 4,
                            child: Container(
                              child: Center(
                                child: Container(
                                  child: FutureBuilder<List<Category>>(
                                    future: Services.fetchHomeData(
                                        "http://newapp.pkwallets.com/api/get_all_category"),
                                    builder: (context, snapshot) {
                                      return snapshot.connectionState ==
                                              ConnectionState.done
                                          ? snapshot.hasData
                                              ? CategoryGrid(
                                                  snapshot, gridClicked)
                                              : ComComp.retryButton(fetch)
                                          : ComComp.circularProgress();
                                    },
                                  ),
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 3,
                            child: Container(
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
                                          border: Border.all(
                                              color: Color(0xFF64B5F6),
                                              width: 2),
                                          color: Color(0xFF64B5F6),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "Recent Records",
                                              style: TextStyle(
                                                  color: Color(0xFF0D47A1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Center(
                                  //   child: Container(
                                  //     child: FutureBuilder<List<RecentRecords>>(
                                  //       future: Services.fetchRecordsCount(
                                  //           "http://newapp.pkwallets.com/api/get_count_record"),
                                  //       builder: (context, snapshot) {
                                  //         return snapshot.connectionState ==
                                  //             ConnectionState.done
                                  //             ? snapshot.hasData
                                  //             ? RecordsCount(snapshot, gridClicked)
                                  //             : ComComp.retryButton(fetch)
                                  //             : ComComp.circularProgress();
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )),
                        Flexible(
                            flex: 1,
                            child: Center(
                              child: Container(
                                child: FutureBuilder<List<RecentRecords>>(
                                  future: Services.fetchRecordsCount(
                                      "http://newapp.pkwallets.com/api/get_count_record"),
                                  builder: (context, snapshot) {
                                    return snapshot.connectionState ==
                                            ConnectionState.done
                                        ? snapshot.hasData
                                            ? RecordsCount(
                                                snapshot, gridClicked)
                                            : ComComp.retryButton(fetch)
                                        : ComComp.circularProgress();
                                  },
                                ),
                              ),
                            )),
                      ],
                    ))
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60.0,
            items: <Widget>[
              Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              Icon(Icons.list, size: 30, color: Colors.white),
              Icon(Icons.compare_arrows, size: 30, color: Colors.white),
              Icon(Icons.call_split, size: 30, color: Colors.white),
              Icon(Icons.perm_identity, size: 30, color: Colors.white),
            ],
            color: color_blue,
            buttonBackgroundColor: color_blue,
            backgroundColor: Color(0x00ffffff),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              // setState(() {
              //   _page = index;
              // });
            },
            // letIndexChange: (index) => true,
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
  List<SubCategory> SubCategoryList = SubCategory.decode(sub_categoryString!);
  String encodedData = "";
  for (var i = 0; i < SubCategoryList.length; i++) {
    if (SubCategoryList[i].cat_id == cellModel.id) {
      SubCategory subCategoryModel = SubCategoryList[i];
      encodedData += SubCategory.encode([
        SubCategory(
          cat_id: subCategoryModel.cat_id,
          name: subCategoryModel.name,
          mobile_icon: subCategoryModel.mobile_icon,
          category_name: subCategoryModel.category_name,
        )
      ]);
    }
  }
  String? nme= cellModel.name;
  prefs.setString('cat_name', nme==null?"":nme );
  await prefs.setString('sub_category', encodedData);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategoryScreen()));
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
    return Wrap(
      children: [
        Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/tpo.jpg",
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${cellModel.name}",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        )
      ],
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
    return Wrap(
      children: [
        Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/tpo.jpg",
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${cellModel.name}",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Services {
  static Future<List<Category>> fetchHomeData(String Url) async {
    final response = await http.get(Uri.parse(Url));
    SharedPreferences userData = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      List<Category> _category_list = <Category>[];
      List<SubCategory> _subcategory_list = <SubCategory>[];
      String encodedData = "";
      for (var item in convert.jsonDecode(response.body)['category']) {
        {
          _category_list.add(Category.fromJson(item));
        }
      }
      for (var item in convert.jsonDecode(response.body)['sub_category']) {
        {
          _subcategory_list.add(SubCategory.fromJson(item));
          encodedData = SubCategory.encode([SubCategory.fromJson(item)]);
        }
      }

      await userData.setString('all_sub_category', encodedData);
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
