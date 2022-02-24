import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_wallets/models/categoryModel.dart';
import 'package:pk_wallets/widgets/appbarWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/common.dart';
import 'Dashboard.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  bool? isHomeDataLoading;
  String cat_name = '';

  @override
  void initState() {
    super.initState();
    isHomeDataLoading = false;
    FetchData();
  }

  Padding SubCategoryGrid(
      List<SubCategory> snapshot, Function gridClicked) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: SubCategoryCell(snapshot[index]),
            onTap: () => gridClicked(context, snapshot[index]),
          );
        },
      ),
    );
  }

  fetch() {
    setLoading(true);
  }

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int _page = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          // statusBarColor: color_blue
        ),
        child: SafeArea(
            child: Scaffold(

          appBar: AppBar(
            backgroundColor: HexColor.fromHex('#3183b5'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: AutoSizeText(
              cat_name,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
              minFontSize: 20,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.right,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Center(
                          child: AutoSizeText(
                            "",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500),
                            minFontSize: 20,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          child: Wrap(
                              children:[ Container(
                                // Specify some width
                                width: size.longestSide,
                                height: size.longestSide,
                                child:  Container(
                                  child: DashBoard.subcatListFilter.length!=0?SubCategoryGrid(
                                      DashBoard.subcatListFilter, gridClicked):
                                  Container(
                                    margin: const EdgeInsets.all(20.0),
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        "No Record Found!",
                                        style:
                                        new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ),]
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        )));
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? sub_categoryString = await prefs.getString('sub_category');
    //Return int
    setState(() {
      cat_name = (prefs.getString('cat_name') ?? '');
      // SubCategoryList = SubCategory.decode(sub_categoryString!);
    });
  }
}
