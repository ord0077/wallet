import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pk_wallets/common/common.dart';


class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Color color_blue = HexColor.fromHex('#3183b5');
  bool? isHomeDataLoading;

  Padding CategoryGrid(
      AsyncSnapshot<List<Category>> snapshot, Function gridClicked) {
    return Padding(
      padding:
      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 20.0),
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


  Wrap RecordsCount(
      AsyncSnapshot<List<RecentRecords>> snapshot, Function gridClicked) {
    return Wrap(children:[Padding(
      padding:
      EdgeInsets.only(left: 20, bottom: 5.0, top: 5.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          var size = MediaQuery.of(context).size;
          String? pending= snapshot.data![index].pending_records;
          String pendingStr="";
          String? accept= snapshot.data![index].accepted_records;
          String acceptStr="";
          String? refund= snapshot.data![index].refund_records;
          String refundStr="";
          if(pending == null){
            pendingStr="";
          }else{
            pendingStr=pending;
          }
          if(accept == null){
            acceptStr="";
          }else{
            acceptStr=accept;
          }
          if(refund == null){
            refundStr="";
          }else{
            refundStr=refund;
          }
          return Container(
            width: size.longestSide,
            child:  Flexible(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size.width*.25,
                      child:
                      Column(
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
                      )
                      ,),
                    Container(

                      width: size.width*.3,
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
                      )
                      ,),
                    Container(
                      width: size.width*.25,
                      child:
                      Column(
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
                      )
                      ,),
                  ],
                )),
          );
        },
      ),
    )]);
  }




  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(

            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            statusBarColor: color_blue),
        child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.27,
                      color: color_blue,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 1),
                              Flexible(
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  child: Icon(
                                    Icons.person,
                                    color: color_blue,
                                    size: 40,
                                  ),
                                  shape: const CircleBorder(),
                                ),
                                flex: 1,
                              ),
                              Flexible(
                                child: Image.asset(
                                  "assets/images/pkwallets.png",
                                ),
                                flex: 2,
                              ),
                              const Flexible(
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                flex: 1,
                              ),
                              const SizedBox(width: 1),
                            ],
                          ),
                        ),
                        Card(
                            margin: EdgeInsets.all(15),
                            elevation: 2.0,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "BALANCE",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat Medium',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(height: 40),
                                      Center(
                                        child: Text(
                                          "SR 4,180.20",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Medium',
                                              color: color_blue,
                                              fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Usmain Khalil",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Medium',
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(height: 2),
                                        Image.asset(
                                          "assets/images/tpo.jpg",
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                ],
                              ),
                            )),
                        Center(
                          child: Container(
                            child: FutureBuilder<List<Category>>(
                              future: Services.fetchHomeData(
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
                        Wrap(children: [
                          Container(
                            margin: EdgeInsets.only(left: 17,right: 17,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              border: Border.all(
                                  color: Color(0xFF64B5F6),
                                  width: 2
                              ),
                              color: Color(0xFF64B5F6),
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Recent Records",
                                  style: TextStyle(color: Color(0xFF0D47A1)),
                                ),
                              ),
                            ),
                          ),
                        ],),
                        Center(
                          child: Container(
                            child: FutureBuilder<List<RecentRecords>>(
                              future: Services.fetchRecordsCount(
                                  "http://newapp.pkwallets.com/api/get_count_record"),
                              builder: (context, snapshot) {
                                return snapshot.connectionState ==
                                    ConnectionState.done
                                    ? snapshot.hasData
                                    ? RecordsCount(snapshot, gridClicked)
                                    : ComComp.retryButton(fetch)
                                    : ComComp.circularProgress();
                              },
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  void initState() {
    super.initState();
    isHomeDataLoading = false;
  }

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  fetch() {
    setLoading(true);
  }
}

gridClicked(BuildContext context, Category cellModel) {
  // Grid Click
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

class Category {
  String? id;
  String? name;
  String? icon;
  String? status;
  String? created_at;

  Category({this.id, this.name, this.icon, this.status, this.created_at});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'status': status,
      'created_at': created_at,
    };
  }
}
class RecentRecords {
  String? pending_records;
  String? accepted_records;
  String? refund_records;

  RecentRecords({this.pending_records, this.accepted_records, this.refund_records});

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
                  border: Border.all(
                      color: Colors.blue,
                      width: 2
                  ),
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

    if (response.statusCode == 200) {
      List<Category> _category_list = <Category>[];
      for (var item in convert.jsonDecode(response.body)['category']) {
        {
          _category_list.add(Category.fromJson(item));
        }
      }
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
